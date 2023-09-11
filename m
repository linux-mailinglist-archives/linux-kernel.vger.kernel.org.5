Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2132B79BEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353559AbjIKVrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjIKJqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:46:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E6BED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:10 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso44906215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694425568; x=1695030368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w9ahDhPc6L0ywEvUgRNWzT5d0G2oBcSOo4fjp5iRg6c=;
        b=K1cI59Wv7WoADLh3Eo3gPfRjKm2OwEQ0grhsHYhOBoeXDyNy4Yor8X9IJTp372Uz/v
         S+TfwUYy59h26f5B3YSYK0cGqqykK0sU0ZlmbGcmNGmG1KYpmEzhceUvlaYTuBns7/JO
         IQ9l3Ol2M3COloHFLcsVR3PZWVK5R8czQLIDtt8et2A/1FgGk92RQTLJt19wvBZCYsaR
         cRh1ZxFAJ5IdLfdZD0J9iotFQLL5Cu9XyDpwcKskklToxpmO1n+XKMQ18y+b0RXI77me
         LCXHhQNFKpt6HrIq6VpAAI2ekA7TNt1PKmj7Xk1iHXpYUygaKzfxXcU3Bf/RkzgXwXrA
         rfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425568; x=1695030368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w9ahDhPc6L0ywEvUgRNWzT5d0G2oBcSOo4fjp5iRg6c=;
        b=W9ktXH4kUz4xrg818BllWYYd326hUJWNsW9hKgfEaA/vcn7UmfNvSHE3v6n3x57Vr8
         +CAqBd1PjT9FJHbHxb29FxtVRXWUCUJovqYDycnvyqj2gVmlbc/dw/46AwsJmHWqB4/R
         B9i8JScKGa7DINP90j6T23DCNWI4/uFDlfz84Yfi0J1l7dN1baiBHI8dEM/qtYpfBBrz
         Vn4d1VwpcTK7wQqMjQbT2sB3HeAGRMqC04A7YH1AUMquBxL77XDZdC1EW6b7xMu2r3ZU
         u7CUqjHhJNDL7CnINIDj7PZZRb8pIKrMCxePzASIkIpiUrcnhOTsHxMkWZN9x6ydlO/f
         0f7A==
X-Gm-Message-State: AOJu0YynnM1K/0N/KNk/3RqfDG7X4TVWC41WW8+OBQlPejT4Mz8HsVPz
        yKLQQ7M1wFwY4zrNlu7n2ooX+Q==
X-Google-Smtp-Source: AGHT+IFGUMpGnpUE1hRHPjyhgmIROsEkgEC38A2hYNyCGyp7CKvL1rV4WL2PF+ArTt1b2DV7vW7sWw==
X-Received: by 2002:a7b:ce06:0:b0:401:4417:a82d with SMTP id m6-20020a7bce06000000b004014417a82dmr7816601wmc.38.1694425568379;
        Mon, 11 Sep 2023 02:46:08 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:c2b1:675e:119e:2497])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003fe601a7d46sm12680275wml.45.2023.09.11.02.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:46:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     timestamp@lists.linux.dev, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] hte: allow building modules with COMPILE_TEST enabled
Date:   Mon, 11 Sep 2023 11:46:04 +0200
Message-Id: <20230911094604.14179-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Allow building all HTE modules with COMPILE_TEST Kconfig option enabled.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
This was part of a wider series but since this is independent, I'm sending
it separately.

 drivers/hte/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hte/Kconfig b/drivers/hte/Kconfig
index cf29e0218bae..083e67492bf2 100644
--- a/drivers/hte/Kconfig
+++ b/drivers/hte/Kconfig
@@ -16,7 +16,7 @@ if HTE
 
 config HTE_TEGRA194
 	tristate "NVIDIA Tegra194 HTE Support"
-	depends on ARCH_TEGRA_194_SOC
+	depends on (ARCH_TEGRA_194_SOC || COMPILE_TEST)
 	help
 	  Enable this option for integrated hardware timestamping engine also
 	  known as generic timestamping engine (GTE) support on NVIDIA Tegra194
@@ -25,7 +25,7 @@ config HTE_TEGRA194
 
 config HTE_TEGRA194_TEST
         tristate "NVIDIA Tegra194 HTE Test"
-        depends on HTE_TEGRA194
+        depends on (HTE_TEGRA194 || COMPILE_TEST)
         help
 	  The NVIDIA Tegra194 GTE test driver demonstrates how to use HTE
 	  framework to timestamp GPIO and LIC IRQ lines.
-- 
2.39.2

