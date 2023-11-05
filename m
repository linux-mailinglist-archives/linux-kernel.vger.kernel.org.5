Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458587E16AA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjKEU5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 15:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKEU5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:57:32 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB02BEB
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 12:57:29 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507ad511315so5477153e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 12:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699217848; x=1699822648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQE5Q7bSQ5CYGQU246bebUi4YlUrrbixJJSlZ4tZEQg=;
        b=eebXLP15HFRHF1NnfTmdlPXcVOVbnmtE9p8dzz+IYmqFzesu1EkR+fVaXcEV5iDmYe
         OgiebByePomyAo9ga9txe6TlOwSPNlgoXQgeqP5GACCp9bYrQXhPdRX720MlHUkbui68
         cTzw/oERVjohWz//20L7BPP9MDgBvSTM3gV3Ekz1BWhnv7F1cqq6nApigEZKm9SFbfX5
         35qt0oBJ5n74RnqT8hcRD33giUNU6gZL91oYfaxDcHRUNYftLzJwix+fh+/nb0U64qNJ
         KQl5Cvfpk/oBhmmquYMwuSX35Y1xqmTlh/7be3SCtg88PVBM0T49LTvZy63IfKlPZSz+
         Si6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699217848; x=1699822648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQE5Q7bSQ5CYGQU246bebUi4YlUrrbixJJSlZ4tZEQg=;
        b=U+vjpuavYR43iyXgHTV23yW2TgfTmWBCezv/j7jzVrLS/4QNNKS1nifp9/mPIaUZFK
         f/+UFJ24HKN3K4Jc0vjt7lE/TlkH5OeBQuWj5kfFZfJtVAzFae5Stk+coVXDt+mLEtR5
         rWwMbrD4y3qpAqfOTjG82VYVEShmUXR5nM2ugdiGUWHWPYm73aGrFfu34MuSXpALJEt7
         OgubK2X+VdvOHRvk60DI3g2UHfbZwSMoYdaQLJ7P2MjMZBuG1REfmYmNOpkl8n3U9Xyd
         vsJZ42XoFdfjw+QVZUlxJ+Y+VEpw3CCv/7PpU1lkF6rIXXuFGS6SKitDQ9+/0zy43ANA
         6vtA==
X-Gm-Message-State: AOJu0YxC6H1ZVcIZlp7F7FvzfM5Ml0RAbTlkSmGuiidL2GhIf0uZBt2o
        EgA6bmEDeo75hOo1twwxBOlWNuxgcQxhVkez+RI=
X-Google-Smtp-Source: AGHT+IHOmoeKz7m5iyemJOxxs0vWx/4QhLzQOa5mtwwvMfSXkeaGjljiQd5YYPz0Pgyz9fiVyiPrlQ==
X-Received: by 2002:ac2:4d07:0:b0:502:ff3b:766f with SMTP id r7-20020ac24d07000000b00502ff3b766fmr18019859lfi.6.1699217847698;
        Sun, 05 Nov 2023 12:57:27 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id d12-20020ac24c8c000000b00507c72697d0sm931873lfl.303.2023.11.05.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 12:57:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 05 Nov 2023 21:57:23 +0100
Subject: [PATCH net v2 1/4] net: ethernet: cortina: Fix MTU max setting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231105-gemini-largeframe-fix-v2-1-cd3a5aa6c496@linaro.org>
References: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
In-Reply-To: <20231105-gemini-largeframe-fix-v2-0-cd3a5aa6c496@linaro.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

