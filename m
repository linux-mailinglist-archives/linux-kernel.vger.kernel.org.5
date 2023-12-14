Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6348139F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjLNS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjLNS03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:26:29 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00690127
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:26:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bfd7be487so9599144e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702578393; x=1703183193; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zmDsslJafTSRmKM5b3evsAK8Ls3ViXkhrQcd4zcmDWM=;
        b=AR6gs+icO/PNoQj08LSynWJBUnptWwURA+TXjqJGAGz8YpCPKZB9r095UBrrxPfVPT
         NxdYyrTjwfxZgbxsH91FKQndaRmrvaFYCdAp2gkDER6fMctqMohtMWWHUP84i4aU2T/s
         VsyvksHiewnxS6UCCveq1yMMxvcbHPqbnPLGH6MoWv9pmvjQr5nP+jWIok1+9QASnuyw
         IgqvRAl7reYsuqQfU5fCI6wPGDw2POlh/ApVrQHR1p2Eg8owumVqXUpiEPpnOFagNkGl
         fD48cI62ddvnkX8NqR4aoeTvkW2lYqqHK8UAz07td6NSCFmz4u9Fz7LyBAXlbQqf3bSD
         SdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702578393; x=1703183193;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmDsslJafTSRmKM5b3evsAK8Ls3ViXkhrQcd4zcmDWM=;
        b=sj7JL+ak/fRknvDHFQUjgEWgHZnVUKlmuHYMTEJdW8c5TxNW/gdcQss3d8h/7+rW0Y
         fEjw6YtCV4B39f6rT0LeNvsUUubiL+OJUiZcXrq0s40Vkhv52s5jFm/7IT19UrXFiTL6
         KAo79tHFepRppFKiCBlNeMnlOWaXz0XUdMxTyTyB7SIgfwonO2eiiCHRJuq41HKaEOQC
         WuL9i8JTjH12FoCWaJqnF6vOXW2jfSgzU3K3zOGOgF4JJIIZZ/8TMqUZVciKvrBrwPlt
         qOhROznoEAzQX5c/ydbz1NES2lAhdjHAeyUjEA9PR0x5edARBB9gyp4C6fUrb7hYNhOL
         Y2fg==
X-Gm-Message-State: AOJu0YwaYm89q+srchnPy1e/K6sBILNtEBr/9VT56suEGPwppZvaEVqR
        rTLzvvk4KA4wwyrWut/SkDYT+5eT5wC4jiLABLQ=
X-Google-Smtp-Source: AGHT+IG/1gx2W51+VtFuYaGxp+hgI76ViJ9Jv9M9qP8wYfm6+Eagvq1LqKduA9NDPaG0h9kfKHYS4g==
X-Received: by 2002:a05:6512:3452:b0:50b:f861:fd4 with SMTP id j18-20020a056512345200b0050bf8610fd4mr4547064lfr.123.1702578393258;
        Thu, 14 Dec 2023 10:26:33 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id bi27-20020a0565120e9b00b0050c0f4fbbcesm1936228lfb.26.2023.12.14.10.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:26:32 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Dec 2023 19:26:31 +0100
Subject: [PATCH] mfd: ab8500-sysctrl: Drop ancient charger
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-ab8500-sysctrl-oneliner-v1-1-fd78a15c0b2f@linaro.org>
X-B4-Tracking: v=1; b=H4sIANZIe2UC/x3MQQqEMAxA0atI1hNoapUZrzK4sBo1IFWSYVDEu
 1tcvsX/JxirsEFTnKD8F5M1ZdCrgH7u0sQoQzZ450vyFLCL78o5tMP6ny64Jl4ksSLHwX2IQh3
 GCLnelEfZn/O3va4boel6OGkAAAA=
To:     Lee Jones <lee@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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

The sysctrl driver was looking for an instance of the PM2301
charger but this has been deleted from the kernel and is not
used with the U8500 systems any more. Drop the string.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/ab8500-sysctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/ab8500-sysctrl.c b/drivers/mfd/ab8500-sysctrl.c
index eeeb62415f53..7ac8248b790a 100644
--- a/drivers/mfd/ab8500-sysctrl.c
+++ b/drivers/mfd/ab8500-sysctrl.c
@@ -30,7 +30,7 @@ static void ab8500_power_off(void)
 {
 	sigset_t old;
 	sigset_t all;
-	static const char * const pss[] = {"ab8500_ac", "pm2301", "ab8500_usb"};
+	static const char * const pss[] = {"ab8500_ac", "ab8500_usb"};
 	int i;
 	bool charger_present = false;
 	union power_supply_propval val;

---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231214-ab8500-sysctrl-oneliner-ebd0911464fb

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

