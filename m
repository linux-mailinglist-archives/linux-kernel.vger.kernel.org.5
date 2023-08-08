Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71EB774211
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjHHRct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjHHRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:32:06 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919F91B08
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:13:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so49822535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1691511220; x=1692116020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aKTM65Hk6mGoUuD04O4aN5AQ3hEPhlqNZbHsqhxOlFc=;
        b=PGMQy2C5Os2kHa7UatjlOZCDrLNrEwQrz1IItVAFXacHosKWUEf7fWStic2qmLhg2Y
         Ma6YBV4eD6kJ+H/HlR0RPZutppO5vEtVzYdlfIgd2A6/xLYe9PVOMihhPBCGg0bmBzy8
         l73GPXsmQTSkbhj2SxJgHc9dYN1VdKyhyU8uAma9vJTYGeRtBEWFazjIvyRJms4xc/yD
         TxVgFthMiU5vnz/qtHEUthx+Y3OaxqbqrR5HjDsnanEL0NQfcWvBaDRna8kq8uj4b0lB
         8p4QjhY4DZ7mCrOu5+Mg1ubYFDP/y4irbaOwmog7Ft0ay9aaa+k6lkMBtdthxu7gqSTU
         csvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511220; x=1692116020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKTM65Hk6mGoUuD04O4aN5AQ3hEPhlqNZbHsqhxOlFc=;
        b=TepErPw6rwUKmc3c93F7hzIoK/+95V0e79unUlmYSIKtDssB719zdTzGRTiD97h0YK
         bbMqoxlb8ymAohcQrl5j5YnXYL6bkYy08qv++dbaMTru+aeWppS2sl5XMimUDFViRbai
         szla/gWMJG0Egy59n7sHIniF2ojsAlDcCeyWi+1mcvU1gY25rzsASiYZ7n1xehbMqGFe
         C7yCdpXzgx8FrhTV9TLdcb6IwP12nb2hRaffBoMkpenhzhfShwrG9fSMagfbkhZeGTLV
         n6NWAHsiDI3M0rvPHzA1LVAp+D9WoW1eXXUbq0xGCwhzru9SL218rRlM4aL3PnVxDbOO
         vDUw==
X-Gm-Message-State: AOJu0YwyLMzlaTSAjbDnxgVtoYGKJRq3/JWWS4LPeDkvMWpSsSed1Caa
        y5cOb7RG93aHUNi9Ceo6ecJXQ7drAM+dl/PiMDA=
X-Google-Smtp-Source: AGHT+IHCg6jK5QeAQL7ZbDp7JHMdEJbqOK7NfrBs1E2JWLSE/ov+AA3/Bp6bD/RPcGzaSByaM3IqVA==
X-Received: by 2002:adf:ffc3:0:b0:317:5b99:d3d8 with SMTP id x3-20020adfffc3000000b003175b99d3d8mr7412543wrs.20.1691489280387;
        Tue, 08 Aug 2023 03:08:00 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:efd4:f3df:2c50:1776])
        by smtp.googlemail.com with ESMTPSA id e11-20020a5d500b000000b003143c9beeaesm13109420wrt.44.2023.08.08.03.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 03:08:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@libre.computer>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] usb: misc: onboard_usb_hub: add Genesys Logic gl3510 hub support
Date:   Tue,  8 Aug 2023 12:07:46 +0200
Message-Id: <20230808100746.391365-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808100746.391365-1-jbrunet@baylibre.com>
References: <20230808100746.391365-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the gl3510 4 ports USB3.1 hub. This allows to control its
reset pins with a gpio.

No public documentation is available for this hub. Using the same reset
duration as the gl852g which seems OK.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/misc/onboard_usb_hub.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/misc/onboard_usb_hub.h b/drivers/usb/misc/onboard_usb_hub.h
index aca5f50eb0da..4b94ea375d45 100644
--- a/drivers/usb/misc/onboard_usb_hub.h
+++ b/drivers/usb/misc/onboard_usb_hub.h
@@ -22,6 +22,10 @@ static const struct onboard_hub_pdata ti_tusb8041_data = {
 	.reset_us = 3000,
 };
 
+static const struct onboard_hub_pdata genesys_gl3510_data = {
+	.reset_us = 50,
+};
+
 static const struct onboard_hub_pdata genesys_gl850g_data = {
 	.reset_us = 3,
 };
@@ -41,6 +45,7 @@ static const struct of_device_id onboard_hub_match[] = {
 	{ .compatible = "usb451,8142", .data = &ti_tusb8041_data, },
 	{ .compatible = "usb5e3,608", .data = &genesys_gl850g_data, },
 	{ .compatible = "usb5e3,610", .data = &genesys_gl852g_data, },
+	{ .compatible = "usb5e3,626", .data = &genesys_gl3510_data, },
 	{ .compatible = "usbbda,411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,5411", .data = &realtek_rts5411_data, },
 	{ .compatible = "usbbda,414", .data = &realtek_rts5411_data, },
-- 
2.40.1

