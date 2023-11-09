Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC7A7E664A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjKIJKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKIJJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:09:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6A9173E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:09:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f613272so4319795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699520995; x=1700125795; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3LORq79d2KWiO2zsyhGNgwevjLWkh4YlRcW/4qVJO5g=;
        b=rY2x8RVYepX4L872ZaDWeeDgDzh4HRywExgN+iDPArfDhueD70nYg6JwbJw9dlIkxI
         EN/6IQxkCRT/Zq1xun/68LCW4d8vb59z1EmJlGyggO6usztVsoC88dKN+BcS2uYBD4J5
         00JEaCGAKGVS3bVTR/S5J7nmr+RNk5idopAE6XUN/ZQeiK/KBaGtaoquVlGSBme5uEap
         j/JMdmMiCtaedtP4LY6d9qZO/ZOuTIygQv1IP1qa0cayiOPT8i9XjoNhya18QC0t7ThS
         wFI4ZlaL2yQQ5oWlQ1FpO3FOtE7kRGG/dqqfJRkAvKhxMRuOumtqrCkaKUQ1zC5ZHiPu
         I2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699520995; x=1700125795;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LORq79d2KWiO2zsyhGNgwevjLWkh4YlRcW/4qVJO5g=;
        b=QgUzuhGOG5P2LzxlXsSxLogjVL6enFHYCAkBuBf7djawUf2P2esD3p+wP/YYPhW1L3
         f/2imNtbSuCLC2pIMPdKpKuci8sfmvU6WAkg4TsmAz5JRJe5kppzUGfI4RA2hI+kgHx6
         HSDbHV9l+FJMgGmXG9rT5Zy5CFz7WZSe/z59JlAGMr0TnKoxGrICRQavc5HnOKhMh4b8
         7EueYNs1oKiVIjgMX0GQKxc3enm47YcSBRTo+f7CrIUNidTcOlQviIAFYREABMO5+i4s
         T9al4jl8qRsg8xD9bgxkRmK0gFAED7XDMFRLz8jwmCpP5TPjgJSYySeQKufB1vK7R2wy
         nbyw==
X-Gm-Message-State: AOJu0Yz87tNeCHGJ1fPlee3hftJNQ27UJbKCXd4iJYO+RI9sHxBbTrf2
        a7GseukvoysbpJkNHMJ8Z39KIp+G9axc4yff+EI=
X-Google-Smtp-Source: AGHT+IF2mb2GZBOKU5NXn4xWX1KfmPMioQ/7KZHFjewuwHxEgnC77hOGACXU+QAP8LrJWhu2BAZcXw==
X-Received: by 2002:a2e:80d6:0:b0:2c5:a21:8388 with SMTP id r22-20020a2e80d6000000b002c50a218388mr3713516ljg.29.1699520596806;
        Thu, 09 Nov 2023 01:03:16 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h19-20020a05651c159300b002bbacc6c523sm2212383ljq.49.2023.11.09.01.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:03:16 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 09 Nov 2023 10:03:14 +0100
Subject: [PATCH net v4 3/3] net: ethernet: cortina: Fix MTU max setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231109-gemini-largeframe-fix-v4-3-6e611528db08@linaro.org>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
In-Reply-To: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RX max frame size is over 10000 for the Gemini ethernet,
but the TX max frame size is actually just 2047 (0x7ff after
checking the datasheet). Reflect this in what we offer to Linux,
cap the MTU at the TX max frame minus ethernet headers.

We delete the code disabling the hardware checksum for large
MTUs as netdev->mtu can no longer be larger than
netdev->max_mtu meaning the if()-clause in gmac_fix_features()
is never true.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 17 ++++-------------
 drivers/net/ethernet/cortina/gemini.h |  2 +-
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index dbbccef86516..636949737d72 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2000,15 +2000,6 @@ static int gmac_change_mtu(struct net_device *netdev, int new_mtu)
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
@@ -2234,7 +2225,6 @@ static const struct net_device_ops gmac_351x_ops = {
 	.ndo_set_mac_address	= gmac_set_mac_address,
 	.ndo_get_stats64	= gmac_get_stats64,
 	.ndo_change_mtu		= gmac_change_mtu,
-	.ndo_fix_features	= gmac_fix_features,
 	.ndo_set_features	= gmac_set_features,
 };
 
@@ -2486,11 +2476,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
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
index 99efb1155743..24bb989981f2 100644
--- a/drivers/net/ethernet/cortina/gemini.h
+++ b/drivers/net/ethernet/cortina/gemini.h
@@ -502,7 +502,7 @@ union gmac_txdesc_3 {
 #define SOF_BIT			0x80000000
 #define EOF_BIT			0x40000000
 #define EOFIE_BIT		BIT(29)
-#define MTU_SIZE_BIT_MASK	0x1fff
+#define MTU_SIZE_BIT_MASK	0x7ff /* Max MTU 2047 bytes */
 
 /* GMAC Tx Descriptor */
 struct gmac_txdesc {

-- 
2.34.1

