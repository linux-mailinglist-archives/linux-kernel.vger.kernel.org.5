Return-Path: <linux-kernel+bounces-115859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364B889A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10589B447DB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D2264245;
	Mon, 25 Mar 2024 03:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pi1FAxfo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313012EBF0;
	Sun, 24 Mar 2024 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322024; cv=none; b=jqdHuhqIXCsRsXqTMWpj7f0pD3QkIU44+HWxpU5JWJYOvW6S4zS4esvutt9kPa+Iu+nE4p57K2l9FbcnXBzaTKIjFKDoHeMbMxazeaDiBr+lhYNPsWU9SMPV9RDnQBznj61K+IJ9RyClAzdpxQ4tvDLneDOP9XP/EJ3YYocMAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322024; c=relaxed/simple;
	bh=c/CyEIJllUPjHqlbq9wDkzDuj6vhPeDRipxiYEF0RWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=si1da4Ys9TjpE0JIzZ+fnicf5O6jzXSAW4LYWk1uVlBTFOBtYHNZxkPOWgeK45jUHX7Gre79DuWUMK4IApHQ+yq/q2pLYiE3wL9FKokRpTZg2qM9HCfKHjXQ0eQ1DpMMVHv8LbEYfQdMvhBlOxqj+X+1NHmxbj0Mx6rJ5RIpmfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pi1FAxfo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DCDC43394;
	Sun, 24 Mar 2024 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322023;
	bh=c/CyEIJllUPjHqlbq9wDkzDuj6vhPeDRipxiYEF0RWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pi1FAxfolnoCWnpcnU452f5skcbHConl797bU59eqqL46+1DT21BNAxV8s/zU+VDv
	 TnGo8QCnEEdfcioOOsRBT0Mpk72k8mlGTmtufUfbCklHapNq8YcwhXfpj2a6Rs+pOx
	 LAvII3txYA40LmBnNXBI5tZSG9phUakQ0ON9YYMo0h1SXAumeB9rQNk10ibMoI1RIw
	 561nCf/b94FRfb3JOgq59bouiYbUjKtdyeFz7S3aJ1kQDyno6pj1yuFC/PL/8S7AH/
	 QFMQf5YipEsNzuWICN4BBhaYLp5JLqorjOjS/P0x3W/IQn4Vxcw01uGUF48g5oY5j6
	 0OlZBczbHPxlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 096/451] cpufreq: Explicitly include correct DT includes
Date: Sun, 24 Mar 2024 19:06:12 -0400
Message-ID: <20240324231207.1351418-97-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rob Herring <robh@kernel.org>

[ Upstream commit a70eb93a2477371638ef481aaae7bb7b760d3004 ]

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it as merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Stable-dep-of: 788715b5f21c ("cpufreq: mediatek-hw: Wait for CPU supplies before probing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/armada-37xx-cpufreq.c  | 4 +---
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 3 ++-
 drivers/cpufreq/ppc_cbe_cpufreq.c      | 2 +-
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c  | 1 -
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 1 -
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/sti-cpufreq.c          | 2 +-
 drivers/cpufreq/ti-cpufreq.c           | 2 +-
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 -
 9 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index b74289a95a171..bea41ccabf1f0 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -14,10 +14,8 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index f0e0a35c7f217..212bbca8daf32 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -10,8 +10,9 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 
 #define LUT_MAX_ENTRIES			32U
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index e3313ce63b388..88afc49941b71 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -9,7 +9,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 
 #include <asm/machdep.h>
 #include <asm/cell-regs.h>
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 4fba3637b115c..6f0c32592416d 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
 #include <linux/pm_qos.h>
 #include <linux/slab.h>
 
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index a577586b23be2..cb03bfb0435ea 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -22,7 +22,6 @@
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index fd2c16821d54c..ac719aca49b75 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -14,7 +14,7 @@
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index 1a63aeea87112..9c542e723a157 100644
--- a/drivers/cpufreq/sti-cpufreq.c
+++ b/drivers/cpufreq/sti-cpufreq.c
@@ -13,7 +13,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index f64180dd2005b..61ef653bcf56f 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -12,7 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index d295f405c4bb0..865e501648034 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -18,7 +18,6 @@
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
-- 
2.43.0


