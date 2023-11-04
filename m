Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C77E0F79
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjKDMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjKDMoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:44:00 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B0D4C
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:43:56 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50930f126b1so3657125e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101834; x=1699706634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGuoNoybmpAHVbeBRQ0Y/xZn4w65B05owlyMy7HgTuo=;
        b=d2xvWO4ScSw5iDGGrf5T4DdSaie2rYXL4P08TnmhPuTytCXNw16vb9TzYTpT0snlbg
         HJZUnMNOKFLVcUh0YZ4Qex3UDoIE5jpiUVrowLCwkJTzzJRUWhmVPq/ujbmhAAbQxogg
         Ppu08ekkM5OrENbvJX+0Ir5z4yeoU3evZN+YibULApcl4gAICZFaRtEr/sTBljFM2cXi
         BWpfe+kNA9MPS/abpXvdHQLNtkCML2QQe2gQxeHmTAzo241bRMcu8KbBwyrB/Wx4zQgO
         fLQWp0J96w779pogg1S8ZBPaGMY6CiY52ES1x9tThamt7ygywOrvuUUfTSJcx0JOqTJu
         qtfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101834; x=1699706634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGuoNoybmpAHVbeBRQ0Y/xZn4w65B05owlyMy7HgTuo=;
        b=lGevPvw0t68dO6Gz2XF32/jSdsD44GuyUKwchBXJdv6bi075f3oNhPrAeCif/b592g
         j2/uoC4iGqRP+u/R8c5mYG2dnSRP6A3xZo7tMs8arGJAAbsPb1HbrRJpxsWVqpjiNCa6
         LPrLvWYaaAiN6NlJefKqPQLBxoLfTjP+1HI/K5hiZoHPOHRyAna5ZlmJH/nnM9in972V
         3BO8kmjW/POfjhBh/vJkhHNyTm+oS5/Nq07QR11ZQd8R9NUa9ucvFklQRFzYDNYd7geY
         2LBWC2LTFC+k5JgIrBSTv/S9FSjIsWT6blDKlPZKcBE+zrGR9OvmyV8Du3TPPaHPV0Km
         TBGA==
X-Gm-Message-State: AOJu0Yx3nACEaQp+zdMpvumoLRDjhouIPulnR1sg3wtyUBxPJVhfHON+
        u7umiYWBp4rVbnSyNvRcLI0E3A==
X-Google-Smtp-Source: AGHT+IFM8LyKtYP3lb6rmldO2Y/K2K0eNH2873kfaHunY7CPSwdiCXkmjcn14UjlqR8YVVm6mXvm5w==
X-Received: by 2002:a05:6512:3f29:b0:509:62de:71c7 with SMTP id y41-20020a0565123f2900b0050962de71c7mr825163lfa.2.1699101834505;
        Sat, 04 Nov 2023 05:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 04 Nov 2023 13:43:51 +0100
Subject: [PATCH net 4/4] net: ethernet: cortina: Handle large frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-4-9c5513f22f33@linaro.org>
References: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
In-Reply-To: <20231104-gemini-largeframe-fix-v1-0-9c5513f22f33@linaro.org>
To:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

On the D-Link DIR-685 router this fixes a bug on the conduit
interface to the RTL8366RB DSA switch: as the switch needs to add
space for its tag it increases the MTU on the conduit interface
to 1504 and that means that when the router sends packages
of 1500 bytes these get an extra 4 bytes of DSA tag and the
transfer fails because of the erroneous hardware checksumming,
affecting such basic functionality as the LuCI web inteface.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 23723c9c0f93..063e58639379 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1145,6 +1145,7 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	dma_addr_t mapping;
 	unsigned short mtu;
 	void *buffer;
+	int ret;
 
 	mtu  = ETH_HLEN;
 	mtu += netdev->mtu;
@@ -1170,7 +1171,14 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 		word3 |= mtu;
 	}
 
-	if (skb->ip_summed != CHECKSUM_NONE) {
+	if (skb->len >= ETH_FRAME_LEN) {
+		/* Hardware offloaded checksumming isn't working on frames
+		 * bigger than 1514 bytes. Perhaps the buffer is only 1518
+		 * bytes fitting mach a normal frame and a checksum?
+		 * Just bypass on bigger frames.
+		 */
+		word1 |= TSS_BYPASS_BIT;
+	} else if (skb->ip_summed != CHECKSUM_NONE) {
 		int tcp = 0;
 
 		if (skb->protocol == htons(ETH_P_IP)) {

-- 
2.34.1

