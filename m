Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B777A9B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjHMQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233414AbjHMQQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:16:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D749CF;
        Sun, 13 Aug 2023 09:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E14463913;
        Sun, 13 Aug 2023 16:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07375C433C7;
        Sun, 13 Aug 2023 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943283;
        bh=3dbjnZxrVUMKozJ/mrwEA8HZKfj3QGCrkecUWGfJmNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUMDuK61bUjmfXPs70mYulu53CDl8HFURLNR31vmO+oGojw/BSEgGneixhP2RzbRs
         DnDdUVqENCsufvdOOgbsM7TzQwqJLW6CK8Dy+O1KuQ8H8Wx1v3LxQyTnaEsdqpDCDD
         JdEtq93xXM4gpyHDtQZjKQE7NyN0hViOnY3cRk/gbSDf77rl4tDoLVD4UxZeOXProd
         oJeZzXMAxYNTpG9WoGBqvyI08QdS639dtLmcbGFeZxPylOs4lLw1Sc1hW2Z8mvfWvw
         hiYMS7PSbg7IxO1sqc5wxpAOiUTtcrW39C8BLGRI70/kCp90fuNQGnz1GXoJqyMdnf
         FvnNNTlCPBocg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, chris.snook@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mkl@pengutronix.de, trix@redhat.com, pavan.chebbi@broadcom.com,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/9] ethernet: atheros: fix return value check in atl1c_tso_csum()
Date:   Sun, 13 Aug 2023 12:14:21 -0400
Message-Id: <20230813161427.1089101-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
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
index 3615c2a06fdad..6f5c7c1401ce0 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2001,8 +2001,11 @@ static int atl1c_tso_csum(struct atl1c_adapter *adapter,
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

