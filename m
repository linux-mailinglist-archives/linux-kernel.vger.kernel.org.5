Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D7812D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443681AbjLNKf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443669AbjLNKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:35:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278BD138;
        Thu, 14 Dec 2023 02:35:54 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-33621d443a7so4223002f8f.3;
        Thu, 14 Dec 2023 02:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702550152; x=1703154952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bSH5LSThTrH8jKZ5V0W7uU2b3lxsQ8a/FvDmGfwzlA=;
        b=DfwPS7L06Jc+pulUiwgpRofSxbwTOshNLSMK1u1CQ6vNuzaDyX4Dv+Zeav1x1y8LC4
         hEW+dghmdMkpWneT83aOBK8UAxA97xhl6Cneb6pj35q9gNlcWsQdfb21aXnPb9TZ6LMo
         J/7zKE44LmjY7Kz0eUUaQ08orOjNd5L5UZxB58kVbwkUO45D1S8nuKSzOnDC2rApRVTH
         3jb+C6V5k7gxtuQ5fytlZdoEXCAoW3qU+lz5qFLTX4T2pYeBhOAhKbJ56aJF4TftvLmO
         wbZu8uBISlpkTkw8vPA8v6AVGtXM3etLx/GOXOjzP+3jTwUxYpg+qrdk5NI3DSYDuhlu
         18Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550152; x=1703154952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bSH5LSThTrH8jKZ5V0W7uU2b3lxsQ8a/FvDmGfwzlA=;
        b=R7lVjrh/D6w9aTN0Yi/Wm2ZVSLy8hQv3maofl63MeD+ySqYAbWg0PB2oWTUkuJo3Cj
         AkKAMpqtrkH9Z5UIyh/aE0HnRQzGkdyHIPbDPUKB6y+SWqUSVU2d1hNqUZYtD1hrxh4z
         YlV+Sq6X9gLlJ2KywR+rXyPug+lwBi+qRfL8iktK/E+q64yCTESO8IA+OsAkP83hO140
         KDOzLR31gQG35pVQenWVCl9WLXv0VyM8dhqVFkSdUIzyMyV28AHOJdSbb7mEZFnpioy0
         mXDjEUCGuODK//aT1zQo12GB+7/w4p3bFJX7OB3gGhryeDzsQDi5t+ZTsedNypyaJHZn
         mTqQ==
X-Gm-Message-State: AOJu0YxXcAjKZbcZ+xvljAt6T26I82AwBUNUW+LBQRU1vc7zjzEHa933
        SuSZxuGhH0N3bQV3xZ9crBU=
X-Google-Smtp-Source: AGHT+IEbki3k5FnEaNVZtWRBuhOkVOwOnKsRmJW5T9tQx+eZlX6USeTgoCxh9UtIGcxFBYXudVg1vw==
X-Received: by 2002:a5d:4bd2:0:b0:333:4940:dd1a with SMTP id l18-20020a5d4bd2000000b003334940dd1amr4977407wrt.23.1702550152438;
        Thu, 14 Dec 2023 02:35:52 -0800 (PST)
Received: from localhost.localdomain ([129.0.226.240])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm15849623wrw.4.2023.12.14.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:35:51 -0800 (PST)
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
Subject: [PATCH 5/5] cpufreq: Make sun50i h6 cpufreq Kconfig option generic
Date:   Thu, 14 Dec 2023 11:33:42 +0100
Message-Id: <20231214103342.30775-6-fusibrandon13@gmail.com>
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

Remove the 'ARM_' prefix from the Allwinner SUN50I cpufreq driver
Kconfig.arm option as that driver can support the D1, a RISC-V
chip.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 drivers/cpufreq/Kconfig.arm | 4 ++--
 drivers/cpufreq/Makefile    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index f91160689..510604781 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -29,14 +29,14 @@ config ACPI_CPPC_CPUFREQ_FIE
 
 	  If in doubt, say N.
 
-config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
+config ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	tristate "Allwinner nvmem based SUN50I CPUFreq driver"
 	depends on ARCH_SUNXI
 	depends on NVMEM_SUNXI_SID
 	select PM_OPP
 	help
 	  This adds the nvmem based CPUFreq driver for Allwinner
-	  h6 SoC.
+	  H6/D1 SoCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d141c71b..110b676d2 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_ARM_SCMI_CPUFREQ)		+= scmi-cpufreq.o
 obj-$(CONFIG_ARM_SCPI_CPUFREQ)		+= scpi-cpufreq.o
 obj-$(CONFIG_ARM_SPEAR_CPUFREQ)		+= spear-cpufreq.o
 obj-$(CONFIG_ARM_STI_CPUFREQ)		+= sti-cpufreq.o
-obj-$(CONFIG_ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
+obj-$(CONFIG_ALLWINNER_SUN50I_CPUFREQ_NVMEM) += sun50i-cpufreq-nvmem.o
 obj-$(CONFIG_ARM_TEGRA20_CPUFREQ)	+= tegra20-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA124_CPUFREQ)	+= tegra124-cpufreq.o
 obj-$(CONFIG_ARM_TEGRA186_CPUFREQ)	+= tegra186-cpufreq.o
-- 
2.30.2

