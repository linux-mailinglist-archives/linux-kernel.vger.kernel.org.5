Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A167E3845
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjKGJyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjKGJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E0122
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:54:37 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7040386e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350876; x=1699955676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xqcp7l3sLztmXNgaaMhSUStMniJux5ggXCgPLhgfhw=;
        b=adFYU4MQxEKKhXpBtF7fw+thICJ5HzrvT+a7pdKXbaMYgHsw1EhSFc3jMKUj5Tu+tD
         CiyQZs6odu83KWCO67Y1/2RMJQEp0TOr1bjeqnrIurfnrBlttONhJzYUqzlMBdfVCg5N
         UGLBfCMVOlhU4TbjisXu85yPVgN+AULp/jC9vurJsl904JB/ZdZoEMi1c4gU1U3ANRL6
         UjYnsHaeOoP3x/VPjpazXLV4OyoxmoZLlvpXdbfy57MyNN2ox+tSPrLsbOmP91uhbyfx
         KKRINZzME6aJpVnFztFQcrGYRzt64CFv4c6h6r+v0HBcfQXzHq1Z1465CYKEcTYCs8xW
         yajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350876; x=1699955676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xqcp7l3sLztmXNgaaMhSUStMniJux5ggXCgPLhgfhw=;
        b=P48VVSi5b6NvO+Q4dG2N7WoxgfNffld1bFcbejAhYJ9eHLMX1XpBRTuhyCzJ0y65SR
         vzkH/vYYYN5dkbGrf34sPJpVSDvzuXh15hKBYEz45cZAtQ2x+dCmh4L0zlsXJNotvJLc
         KfkDjkgATl7MviWVfq+kyUkX4uAa3mgSD9yP7USdGNZkZC/7jDBVRqP2/sqG9pNCm7TT
         JRrCen6ijBiY0hww3feqY5ZbvQ3+uN8CtDfAJVUZ98gIY6TJlGlt9K/Hq1+W001CWkpG
         EtQ/1I8oPg72dwfQeYX894iEShZ6uRZEVLujwlrlbKplX9/H7hzb+DbDU4jC/yR5OSXF
         Fd8A==
X-Gm-Message-State: AOJu0YwSAbNYuM3E6cVpljMUusrZnIpMxZvEsQADQWN5ujMqXPjTaakF
        zzhE9DJ+iOrMHhXs1RXtFNX0bA==
X-Google-Smtp-Source: AGHT+IEF5MBAZYuBJjtXQUrFPyFp3vNlwVPxymtsM4RhEBsU9XfIdzPTR44CE8k76aI55w2oKoPhpw==
X-Received: by 2002:ac2:504d:0:b0:509:4a02:49f7 with SMTP id a13-20020ac2504d000000b005094a0249f7mr11388717lfm.44.1699350876033;
        Tue, 07 Nov 2023 01:54:36 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:35 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Nov 2023 10:54:28 +0100
Subject: [PATCH net v3 3/4] net: ethernet: cortina: Handle large frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-3-e3803c080b75@linaro.org>
References: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
In-Reply-To: <20231107-gemini-largeframe-fix-v3-0-e3803c080b75@linaro.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gemini ethernet controller provides hardware checksumming
for frames up to 1514 bytes including ethernet headers but not
FCS.

If we start sending bigger frames (after first bumping up the MTU
on both interfaces sending and receiveing the frames), truncated
packets start to appear on the target such as in this tcpdump
resulting from ping -s 1474:

23:34:17.241983 14:d6:4d:a8:3c:4f (oui Unknown) > bc:ae:c5:6b:a8:3d (oui Unknown),
ethertype IPv4 (0x0800), length 1514: truncated-ip - 2 bytes missing!
(tos 0x0, ttl 64, id 32653, offset 0, flags [DF], proto ICMP (1), length 1502)
OpenWrt.lan > Fecusia: ICMP echo request, id 1672, seq 50, length 1482

If we bypass the hardware checksumming and provide a software
fallback, everything starts working fine up to the max TX MTU
of 2047 bytes, for example ping -s2000 192.168.1.2:

00:44:29.587598 bc:ae:c5:6b:a8:3d (oui Unknown) > 14:d6:4d:a8:3c:4f (oui Unknown),
ethertype IPv4 (0x0800), length 2042:
(tos 0x0, ttl 64, id 51828, offset 0, flags [none], proto ICMP (1), length 2028)
Fecusia > OpenWrt.lan: ICMP echo reply, id 1683, seq 4, length 2008

The bit enabling to bypass hardware checksum (or any of the
"TSS" bits) are undocumented in the hardware reference manual.
The entire hardware checksum unit appears undocumented. The
conclusion that we need to use the "bypass" bit was found by
trial-and-error.

Since no hardware checksum will happen, we slot in a software
checksum fallback.

Check for the condition where we need to compute checksum on the
skb with either hardware or software using == CHECKSUM_PARTIAL instead
of != CHECKSUM_NONE which is an incomplete check according to
<linux/skbuff.h>.

We delete the code disabling the hardware checksum for large
MTU:s: this is suboptimal because it will disable hardware
checksumming also on small packets which the checksumming
engine can handle just fine, which is a waste of resources.

On the D-Link DIR-685 router this fixes a bug on the conduit
interface to the RTL8366RB DSA switch: as the switch needs to add
space for its tag it increases the MTU on the conduit interface
to 1504 and that means that when the router sends packages
of 1500 bytes these get an extra 4 bytes of DSA tag and the
transfer fails because of the erroneous hardware checksumming,
affecting such basic functionality as the LuCI web interface.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index b21a94b4ab5c..78287cfcbf63 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1159,9 +1160,30 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. A hypothesis about this is that the
+		 * checksum buffer is only 1518 bytes, so when the frames get
+		 * bigger they get truncated, or the last few bytes get
+		 * overwritten by the FCS.
+		 *
+		 * Just use software checksumming and bypass on bigger frames.
+		 */
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			ret = skb_checksum_help(skb);
+			if (ret)
+				return ret;
+		}
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int tcp = 0;
 
+		/* We do not switch off the checksumming on non TCP/UDP
+		 * frames: as is shown from tests, the checksumming engine
+		 * is smart enough to see that a frame is not actually TCP
+		 * or UDP and then just pass it through without any changes
+		 * to the frame.
+		 */
 		if (skb->protocol == htons(ETH_P_IP)) {
 			word1 |= TSS_IP_CHKSUM_BIT;
 			tcp = ip_hdr(skb)->protocol == IPPROTO_TCP;
@@ -1978,15 +2000,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
 	return 0;
 }
 
-static netdev_features_t gmac_fix_features(struct net_device *netdev,
-					   netdev_features_t features)
-{
-	if (netdev->mtu + ETH_HLEN + VLAN_HLEN > MTU_SIZE_BIT_MASK)
-		features &= ~GMAC_OFFLOAD_FEATURES;
-
-	return features;
-}
-
 static int gmac_set_features(struct net_device *netdev,
 			     netdev_features_t features)
 {
@@ -2212,7 +2225,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 

-- 
2.34.1

