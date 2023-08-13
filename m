Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF277A98D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbjHMQOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHMQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:14:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DE910E3;
        Sun, 13 Aug 2023 09:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBBCE6145D;
        Sun, 13 Aug 2023 16:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8378C433C7;
        Sun, 13 Aug 2023 16:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943143;
        bh=pUhHomwpsMbBnYK/7qs+qvKtOqAEWcAL813zxbIscRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQBQ21dx10NDOydHEM51I50eIYIKsTy5Ur8pT3xAQKr1LA3DWVmT84LXFqBnDXpLo
         +ncEn/5fxplpwFb1KTVylM425rlOyt2PTz24v7xCldQKuCZqM7J5hEdEEFDxk0fy27
         tg+bswI+YRmEOfgprZKNW4F93PPqPwe6aNPS5Uw6/4gM/wH4RPWRyXyzlB/eLaHy4K
         r9+O2N6vqk8eX91B82r8aRUzxreGpGzLIDa6OTK536yu2w8bi7BqE8247Gyrx7ZBUc
         +OYNCvnHjZTG1VrvaPez32YU0jobGOgQgho2KnlCZ6kBLafv24qMOGrUbibvRvk1iD
         a77tny+R4cX+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        pavan.chebbi@broadcom.com, trix@redhat.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 04/14] ethernet: atheros: fix return value check in atl1c_tso_csum()
Date:   Sun, 13 Aug 2023 12:11:52 -0400
Message-Id: <20230813161202.1086004-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161202.1086004-1-sashal@kernel.org>
References: <20230813161202.1086004-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.253
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjun Gong <ruc_gongyuanjun@163.com>

[ Upstream commit 8d01da0a1db237c44c92859ce3612df7af8d3a53 ]

in atl1c_tso_csum, it should check the return value of pskb_trim(),
and return an error code if an unexpected value is returned
by pskb_trim().

Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 2b239ecea05f2..ff28dbf515747 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1989,8 +1989,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
 			real_len = (((unsigned char *)ip_hdr(skb) - skb->data)
 					+ ntohs(ip_hdr(skb)->tot_len));
 
-			if (real_len < skb->len)
-				pskb_trim(skb, real_len);
+			if (real_len < skb->len) {
+				err = pskb_trim(skb, real_len);
+				if (err)
+					return err;
+			}
 
 			hdr_len = (skb_transport_offset(skb) + tcp_hdrlen(skb));
 			if (unlikely(skb->len == hdr_len)) {
-- 
2.40.1

