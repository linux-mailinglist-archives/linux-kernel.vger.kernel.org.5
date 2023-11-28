Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1276A7FC841
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346602AbjK1VGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346555AbjK1VGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D35198D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDC5C433C9;
        Tue, 28 Nov 2023 21:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205584;
        bh=VF+FqZDwC1y4zaNtTATkaYq4JV+XiOLwLQAQ5id2JQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyDhiu1tR/k04EBFPd6vrsXtq/mrug4hKe43nvPKWEkVWg1Yay3OSKTIJtT7yruF0
         Pkzgfjrh7oRuOmfJ0HeP+NjpHtkZbqMx/FaQkmXglNIzF7d2LpWqhwzsRvRalNR34i
         YqrcRIIzSlde31yAgrPVkUNGjtIgSRsM0qdWYqm7Y0xFmzZHLeZ7+W1z5OzN/76foo
         VewVtqkNsfJSSkl/ga0XWNdO4JCvvAPEv9U/ogHeW+aV3wCCZIRUQ5gWy2cYlWX+Qv
         6XkI/NTBOAx9Cvd3/o+0QcIf3OPf54dGwnX+M7IhUjNs0dVWJ1pnHoqWe63wdjoDpO
         +xFOK9/kewGOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 02/40] usb: aqc111: check packet for fixup for true limit
Date:   Tue, 28 Nov 2023 16:05:08 -0500
Message-ID: <20231128210615.875085-2-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit ccab434e674ca95d483788b1895a70c21b7f016a ]

If a device sends a packet that is inbetween 0
and sizeof(u64) the value passed to skb_trim()
as length will wrap around ending up as some very
large value.

The driver will then proceed to parse the header
located at that position, which will either oops or
process some random value.

The fix is to check against sizeof(u64) rather than
0, which the driver currently does. The issue exists
since the introduction of the driver.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/aqc111.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index a017e9de2119d..7b8afa589a53c 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1079,17 +1079,17 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 	u16 pkt_count = 0;
 	u64 desc_hdr = 0;
 	u16 vlan_tag = 0;
-	u32 skb_len = 0;
+	u32 skb_len;
 
 	if (!skb)
 		goto err;
 
-	if (skb->len == 0)
+	skb_len = skb->len;
+	if (skb_len < sizeof(desc_hdr))
 		goto err;
 
-	skb_len = skb->len;
 	/* RX Descriptor Header */
-	skb_trim(skb, skb->len - sizeof(desc_hdr));
+	skb_trim(skb, skb_len - sizeof(desc_hdr));
 	desc_hdr = le64_to_cpup((u64 *)skb_tail_pointer(skb));
 
 	/* Check these packets */
-- 
2.42.0

