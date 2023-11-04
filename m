Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3BF7E0F74
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjKDMn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjKDMn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:43:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E21DD62
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:43:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507cee17b00so3736721e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699101830; x=1699706630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Oy6YnzrrQAU74UB/BgNy8fxjGeu1ULALolZntz7GpU=;
        b=bckd4k8ZwZWtVNFCjzqnJOHxFhsIXC9HPD4IS9cTYlU2EfXQ1/xY9lVF7Sm8ETRbUE
         g0qf51je+M0H0FQOHqDKssCUjTzO7tRiPw2ZH8V/tMrx5aclgws3a9sTdxUrd01ovi4F
         21ijAT8ibZTaICo9vCVDGlAUoUwY9lpdmZSXKny6kg8oJcw9y6+Mnv3/9P9kAs4LTle1
         JSQxndFOWQm5R7LwlerhD+4+l+pZv0kW3zUehWUBnITPUWsgmO6q5iMK5igaSNKUjOv7
         315CGLHSqXGfxn3Mg0bjgP426dla0lKEFj/wKNN9YcWmmIebPyT8G8GC2IlIqtOsz98N
         28DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101830; x=1699706630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Oy6YnzrrQAU74UB/BgNy8fxjGeu1ULALolZntz7GpU=;
        b=UjmEaYFHVU+pX+h4lhw5zjFHDhkz2vErFbKW4OLTAJjKyujqzkIyxypY0ubD6l/j7u
         Vela6lWJCj6XWaGew/Bd6gPsGD2Ytn1G+QxA+pYfE0RWuB0DcCNCt0QBa100iAp89OCL
         6olY3FMrbq8tHjuMzzaL2d07DQnTUytKxZpnmlCHRNwDXVaMvWB8aUzwgIOw2kTCEFPt
         kObvSa/qpIZzZ9X75z0Lluuk4gRF00ORX3W8gDyfuSg2nNQOiTs4WKd9ndNF27bobgVZ
         mMAWKjQu49hI8MSApPG6vjmk/FqiMxhLB2rv76zwwDVgAjjR8jippFNj8tuDJ8ArG/Lf
         TXlA==
X-Gm-Message-State: AOJu0YyU7S+Li8vyOxNkrjZrEFtwJYXQTopny+iXpK2bcleVFQY0XUQJ
        3VXFx6UX3ujMxpDVbde4FZqyFg==
X-Google-Smtp-Source: AGHT+IGwsd6bMa0WdkB0xdWasEvDnIiyZd8prwFEb7gsYRpi9uYQ0Z3rXATmveYQoxaGQ3DQcung8A==
X-Received: by 2002:a19:f80e:0:b0:500:7f71:e46b with SMTP id a14-20020a19f80e000000b005007f71e46bmr18641913lff.1.1699101830741;
        Sat, 04 Nov 2023 05:43:50 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u22-20020ac24c36000000b005093312f66fsm496100lfq.124.2023.11.04.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 05:43:50 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 04 Nov 2023 13:43:48 +0100
Subject: [PATCH net 1/4] net: ethernet: cortina: Fix MTU max setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231104-gemini-largeframe-fix-v1-1-9c5513f22f33@linaro.org>
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

The RX max frame size is over 10000 for the Gemini ethernet,
but the TX max frame size is actually just 2047 (0x7ff after
checking the datasheet). Reflect this in what we offer to Linux,
cap the MTU at the TX max frame minus ethernet headers.

Use the BIT() macro for related bit flags so these TX settings
are consistent.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 12 +++++++++---
 drivers/net/ethernet/cortina/gemini.h |  8 ++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5423fe26b4ef..e12d14359133 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1151,6 +1151,11 @@ static int gmac_map_tx_bufs(struct net_device *netdev, struct sk_buff *skb,
 	if (skb->protocol == htons(ETH_P_8021Q))
 		mtu += VLAN_HLEN;
 
+	if (mtu > MTU_SIZE_BIT_MASK) {
+		netdev_err(netdev, "%s: MTU too big, max size 2047 bytes, capped\n", __func__);
+		mtu = MTU_SIZE_BIT_MASK;
+	}
+
 	word1 = skb->len;
 	word3 = SOF_BIT;
 
@@ -2464,11 +2469,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	netdev->hw_features = GMAC_OFFLOAD_FEATURES;
 	netdev->features |= GMAC_OFFLOAD_FEATURES | NETIF_F_GRO;
-	/* We can handle jumbo frames up to 10236 bytes so, let's accept
-	 * payloads of 10236 bytes minus VLAN and ethernet header
+	/* We can receive jumbo frames up to 10236 bytes but only
+	 * transmit 2047 bytes so, let's accept payloads of 2047
+	 * bytes minus VLAN and ethernet header
 	 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = 10236 - VLAN_ETH_HLEN;
+	netdev->max_mtu = MTU_SIZE_BIT_MASK - VLAN_ETH_HLEN;
 
 	port->freeq_refill = 0;
 	netif_napi_add(netdev, &port->napi, gmac_napi_poll);
diff --git a/drivers/net/ethernet/cortina/gemini.h b/drivers/net/ethernet/cortina/gemini.h
index 9fdf77d5eb37..d7101bfcb4a0 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -499,10 +499,10 @@ union gmac_txdesc_3 {
 };
 
 #define SOF_EOF_BIT_MASK	0x3fffffff
-#define SOF_BIT			0x80000000
-#define EOF_BIT			0x40000000
-#define EOFIE_BIT		BIT(29)
-#define MTU_SIZE_BIT_MASK	0x1fff
+#define SOF_BIT			BIT(31) /* Start of Frame */
+#define EOF_BIT			BIT(30) /* End of Frame */
+#define EOFIE_BIT		BIT(29) /* End of Frame Interrupt Enable */
+#define MTU_SIZE_BIT_MASK	0x7ff /* Max MTU 2047 bytes */
 
 /* GMAC Tx Descriptor */
 struct gmac_txdesc {

-- 
2.34.1

