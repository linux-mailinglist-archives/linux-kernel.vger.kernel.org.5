Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96FF7E3840
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjKGJyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjKGJyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:54:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0427122
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 01:54:35 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd19eac8so7040355e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699350874; x=1699955674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JloLY/S3J4vbR80IcKlfhvbtLk/oEHP3bZQboIzjIZc=;
        b=sWdBRhM/t7wng6xlOylPZOEGtcorfDINLBWemTEIh0XtNaqjJLy1SdGMwyzeJEmKCU
         Yk4aUBBGE6l8uzfk4UYAhhG3fhGCIXjR9CN8sbVEJyeYPaokasvmIK+TpUnL5A6424SA
         MtoNDQMTQN97eFJV31QKImYv3jDAsCRwZhJNKQKBMFFc6zJYXvNTt8hbJpGF/ywD58vx
         3sm9AC0DM5iPooCUHDvTfGne3kbd48fB8iZkXlqaJ1V2tTt6MHr2tbR+kfmFer2i6Ll7
         8CSEjB5MmqegFlJMMrmLsYIzAMmOglyTYiR0JQdZBLRWR9ZIqa03r/5qyD72d9FAkj+p
         ev+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699350874; x=1699955674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JloLY/S3J4vbR80IcKlfhvbtLk/oEHP3bZQboIzjIZc=;
        b=f5HLjCjD14wHPFxN4Z4+vdcLcEcJulQ5C9Ps7BSYGeQgV/3UDehuY+iA/SjdlUL4tO
         9iZ6mLUG7SxYqaygrD3927JiieD8A0COFmaVlFW59X7/Va2byyv/xVr00kcG+Hc589hg
         jjMbs7pu9y4ANQER29EXdFCkQnVSpHNltmnZ/8kV64pfd7dAFpqbQ2zEi6mqK81wQzoy
         04C2RIbXL7lfe7NwcuoVd+9VcUmTo4JyBCnbLaW4vi08ePt9gq5ADb24lX3KlYaD2jIn
         dBN8oCl1vgz+d/4T0xjfRopI75ZRlCbEjT5dnmBI/cXK0jye0eoh0qKVrd3gYE4FMA1b
         PhNw==
X-Gm-Message-State: AOJu0YysD7BkVjC/jwBpVtt3cy4SvuzpiaOD8gx8bV0GzftbOVqNGnOm
        Iqo17HHvdk1Riw+EfZwqSk/0hg==
X-Google-Smtp-Source: AGHT+IFpYjXoetaqCE4w0x17lDufaf6MMnsyuen6QOAUsAm15BkmP4tyeuBHkl/HJ06CXDK6NOBRxg==
X-Received: by 2002:a05:6512:b8d:b0:509:47e1:6ebe with SMTP id b13-20020a0565120b8d00b0050947e16ebemr13946569lfv.14.1699350874094;
        Tue, 07 Nov 2023 01:54:34 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id m25-20020ac24ad9000000b005091314185asm296356lfp.285.2023.11.07.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 01:54:33 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 07 Nov 2023 10:54:26 +0100
Subject: [PATCH net v3 1/4] net: ethernet: cortina: Fix MTU max setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-gemini-largeframe-fix-v3-1-e3803c080b75@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 7 ++++---
 drivers/net/ethernet/cortina/gemini.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 5423fe26b4ef..ed9701f8ad9a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2464,11 +2464,12 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
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
index 9fdf77d5eb37..201b4efe2937 100644
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

