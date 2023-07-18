Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581EA7577CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjGRJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjGRJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C4E4F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54FB0614E9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10489C433C8;
        Tue, 18 Jul 2023 09:24:07 +0000 (UTC)
From:   Ilia Lin <quic_ilial@quicinc.com>
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        leonro@nvidia.com, Ilia Lin <ilia.lin@kernel.org>
Subject: [PATCH] xfrm: Allow ESP over UDP in packet offload mode
Date:   Tue, 18 Jul 2023 12:24:05 +0300
Message-Id: <20230718092405.4124345-1-quic_ilial@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ESP encapsulation is not supported only in crypto mode.
In packet offload mode, the RX is bypassing the XFRM,
so we can enable the encapsulation.

Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
---
 net/xfrm/xfrm_device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 4aff76c6f12e0..3018468d97662 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -246,8 +246,10 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if (x->encap || x->tfcpad) {
+	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
+
+	/* We don't yet support UDP encapsulation except full mode and TFC padding. */
+	if ((!is_packet_offload && x->encap) || x->tfcpad) {
 		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
 		return -EINVAL;
 	}
@@ -258,7 +260,6 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 		return -EINVAL;
 	}
 
-	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 	dev = dev_get_by_index(net, xuo->ifindex);
 	if (!dev) {
 		if (!(xuo->flags & XFRM_OFFLOAD_INBOUND)) {
-- 

