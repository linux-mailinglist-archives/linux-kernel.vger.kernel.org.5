Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA24812D18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443733AbjLNKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443743AbjLNKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:35:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E67B137;
        Thu, 14 Dec 2023 02:35:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso58872025e9.2;
        Thu, 14 Dec 2023 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702550128; x=1703154928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrT4GQFgUc2NFNy8QfHDcUrSUYysbuxBIxCpg4THq6A=;
        b=T9/rLp3lA9YvFk+eSwLr/+vJsfm7myTmt3cfTjY76HaDeR2Hy43toF2exFW2JQKWGe
         k7id6fqMefwQRdGLPVHSdgY/3G+h6EAhJiOdlnC54E4lL0KwB3F+vnhI9+ZVV8lyUcQM
         EYV840p4rvOI4/eUqFs+nraKPav+eBUZtxuT7I2TdjWnyADOsb0xHB1SIJ8cdd3fqEOp
         TUBWSZFyReLKhY+xeQEYvTzbee39h1CgZ3iY9JIRKWtvkmzh0H7vr6yQ1D+6bbGorEXg
         0oFS3D9a2TIL6ySaulKCrR00uhDLhLy0NGxAk8lQfk0KgC6C71pa9uSVpUtfne2kLo0M
         WjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550128; x=1703154928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrT4GQFgUc2NFNy8QfHDcUrSUYysbuxBIxCpg4THq6A=;
        b=KWPxMFUKg4Qor6qhFV63Lg+QugqneI4aVGTfpI03m+cOOyI9alAYOVefAjeSZr+Ksb
         kfwBuVzM0m5eD3lAZ4ZVbfsNWs05F1pIrKrdJRKLd7OTLo8x98XucszVktJObxOcv9QC
         S6+1KnxOdkb7m/IwFfSP0phMOxh6/fudM/1WchIW9uxKuWKPmA6JILhGSydhRFLsBcey
         fR4MWVo+wG8NSYKBMaGNGOKwHZrK59TqyycvgrjrZSGL+ZoPp8XjhUaRKCq9owxceRAR
         btrjGmf9N5TO7dgBZb3PJIhIBU48ih5twhbBdsIZ5+414LxvsfJ5dR15KqiYo6zT459B
         J3Pg==
X-Gm-Message-State: AOJu0YxWXGRFWtPSwlbCEEle2vudxrXoMbgX4kalqQQJ8jb04uv4Jp8E
        nC6kvuRkSBiAZy0hwFOIv7Q=
X-Google-Smtp-Source: AGHT+IGCjmnMr0NRq+HC8R0lvRI/AD01AcPL7img9WmAVtzQAIwlJBk50oZM1JWLrtlKld0tmTb1iA==
X-Received: by 2002:a05:600c:2a41:b0:40c:32fa:4f45 with SMTP id x1-20020a05600c2a4100b0040c32fa4f45mr3510981wme.248.1702550128507;
        Thu, 14 Dec 2023 02:35:28 -0800 (PST)
Received: from localhost.localdomain ([129.0.226.240])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm15849623wrw.4.2023.12.14.02.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:35:27 -0800 (PST)
From:   Brandon Cheo Fusi <fusibrandon13@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH 4/5] cpufreq: Add support for RISC-V CPU Frequency scaling drivers
Date:   Thu, 14 Dec 2023 11:33:41 +0100
Message-Id: <20231214103342.30775-5-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214103342.30775-1-fusibrandon13@gmail.com>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig file for cpufreq scaling drivers that can handle RISC-V
CPUs. An entry is included for the Allwinner H6 cpufreq driver that
works with D1.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/Kconfig       |  4 ++++
 drivers/cpufreq/Kconfig.riscv | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 drivers/cpufreq/Kconfig.riscv

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 35efb53d5..4bef39fed 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -239,6 +239,10 @@ if PPC32 || PPC64
 source "drivers/cpufreq/Kconfig.powerpc"
 endif
 
+if RISCV
+source "drivers/cpufreq/Kconfig.riscv"
+endif
+
 if MIPS
 config BMIPS_CPUFREQ
 	tristate "BMIPS CPUfreq Driver"
diff --git a/drivers/cpufreq/Kconfig.riscv b/drivers/cpufreq/Kconfig.riscv
new file mode 100644
index 000000000..025c7c439
--- /dev/null
+++ b/drivers/cpufreq/Kconfig.riscv
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RISC-V CPU Frequency scaling drivers
+#
+
+config ALLWINNER_SUN50I_CPUFREQ_NVMEM
+	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
+	depends on ARCH_SUNXI
+	depends on NVMEM_SUNXI_SID
+	select PM_OPP
+	help
+	  This adds the nvmem based CPUFreq driver for Allwinner
+	  H6/D1 SoCs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sun50i-cpufreq-nvmem.
\ No newline at end of file
-- 
2.30.2

