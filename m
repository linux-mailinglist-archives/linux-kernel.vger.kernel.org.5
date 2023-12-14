Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC16812DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443828AbjLNKxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443766AbjLNKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:52:58 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C8129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:58 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so37442215e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702551176; x=1703155976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xcopqDHmkhwhZiddcnv/4oqDnf2f2C/EfKwZNlZ0qw=;
        b=hUg91Jw5utLpyY8E5CDdi/IaLvyeX0Y0EjDQzG/iXoXcPl49mRrpQKxyr1hIszPB90
         K96OtV50cQ0BFgtgMjFXXvyd9y0PMBTJFqCub65yjlpfaguHH9eptI1C2VHeAUJWGF5g
         JvDuidXOqpSolEOQu/zGoXqs/NsPiASXms+GYVj/H4rx7efIrkc9y+LgScmkUyTjAndg
         tmepwkVmlGOSfXqm4T4JDNEHhz2ny7sf48EWaZcznpt+VaXNy/vAWIX0VluNSK/2Jnn+
         0PtGNRfLvurQlW2YLtcrcb8lAIoJTdZJmHQ0wtPI70QelPCDQ19lyLVuw0MNY4+sdSuC
         pHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551176; x=1703155976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xcopqDHmkhwhZiddcnv/4oqDnf2f2C/EfKwZNlZ0qw=;
        b=nVD/v3QyE94UPQA4AOkxq38m1SUoqxmTuwyxXkHKHOJoun5ww/B5ja/jHWuD1r97v1
         VAlsmc/hgsTYpVtoHYnSjT4mDwJfnkvLwNSd7OSEUJqyW4HhRoflVUO4YGfJn73VaMCy
         6pxNNZcUWSWCUwYLCCXzhl/dq2il5X/38uJulwe77YlSxZU4VkRClVkurnKn0OTdH6Jy
         asHW6g7TMyvT3qcaviIWLlI4vl2T7JzTkKmZ+jNHtjwy2qpFK/qDFSO63CR22Ox4/dbr
         XrRgRqgFspL01I/YsR2wgcx+mej1Udn/PUirZ8NIow3JHa1FlAq+H+qtAVVzJyJjuTTF
         e+Fg==
X-Gm-Message-State: AOJu0YxrX0XbqrymBEgEGWxcW/jGgARkVCZALpnX/GP0MTgiRYv0uFXz
        PhSet6uI5aF54aZcLjEy7BCNpQ==
X-Google-Smtp-Source: AGHT+IFoOjFMWtrSQgxb2NLW2t0CuX+poAGfnV283P6BxnO1HFB3lfJ/1vp1DW3s4vZF+aaQfp5C7g==
X-Received: by 2002:a1c:7411:0:b0:40c:30f8:dcf0 with SMTP id p17-20020a1c7411000000b0040c30f8dcf0mr5564669wmc.64.1702551176443;
        Thu, 14 Dec 2023 02:52:56 -0800 (PST)
Received: from ta2.c.googlers.com.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c468700b0040c420eda48sm17614854wmo.22.2023.12.14.02.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:52:55 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     peter.griffin@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org, andi.shyti@kernel.org,
        alim.akhtar@samsung.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        s.nawrocki@samsung.com, tomasz.figa@gmail.com,
        cw00.choi@samsung.com, arnd@arndb.de, semen.protsenko@linaro.org
Cc:     andre.draszik@linaro.org, saravanak@google.com,
        willmcvicker@google.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 05/13] tty: serial: samsung: add gs101 earlycon support
Date:   Thu, 14 Dec 2023 10:52:35 +0000
Message-ID: <20231214105243.3707730-6-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GS101 only allows 32-bit register accesses. If using 8-bit register
accesses on gs101, a SError Interrupt is raised causing the system
unusable.

Force the reg accesses to MMIO32 regardless of the user's settings.
This is a common practice for such earlycons (bcm2835aux, uniphier,
lpuart32), in order to avoid crashing the kernel with a wrong early
console definition.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/tty/serial/samsung_tty.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 66bd6c090ace..19cd3e6a9b6e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -2787,6 +2787,17 @@ OF_EARLYCON_DECLARE(exynos4210, "samsung,exynos4210-uart",
 OF_EARLYCON_DECLARE(artpec8, "axis,artpec8-uart",
 			s5pv210_early_console_setup);
 
+static int __init gs101_early_console_setup(struct earlycon_device *device,
+					    const char *opt)
+{
+	/* gs101 always expects MMIO32 register accesses. */
+	device->port.iotype = UPIO_MEM32;
+
+	return s5pv210_early_console_setup(device, opt);
+}
+
+OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);
+
 /* Apple S5L */
 static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
 						const char *opt)
-- 
2.43.0.472.g3155946c3a-goog

