Return-Path: <linux-kernel+bounces-116020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758208895D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 255B0B262CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B623317DC1A;
	Mon, 25 Mar 2024 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaT0fVCf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A027550D;
	Sun, 24 Mar 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323362; cv=none; b=OeJG8BGW/lwZcX+KfwIJ2l+JAZC3ktj8uBNIk4GP7BsMXxfCHJp+xiZ8eX0BaSMe3TQyeGb3ULmZPGzeWVcUKHUR7qrZ8HYJ6gTmTerQ/83ucaAJFuFYA3JILGNd1hygse1QUvvWxUDGSd03/07U6KmBzeWKBV+Ys07VJwF3qDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323362; c=relaxed/simple;
	bh=dXw/GUG7J5HCW2qalxp3eZ8ma51egnwp+1yt6yCWkXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYGOe0/p2it+N21WD2eY1iVZIYFuOcaS0t6kU5TxZiGN0nF0beR5y/+fwgMeEQfHWWp+AJCJSh12vsETT5a8dgaI/HP92ybitDKXZQuOnCYCXVhl3Djqh7Q9rOFfU8C/0agrF/BWCyZZ5bBAcNAVTDTJBuxUV7Ruk9+xUyaR3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaT0fVCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DC1C43399;
	Sun, 24 Mar 2024 23:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323362;
	bh=dXw/GUG7J5HCW2qalxp3eZ8ma51egnwp+1yt6yCWkXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WaT0fVCf6oeNrWgCTA42B8W9/Uwn52KANgtqmm56MifGTHXlIk3wylICMEwLY7oQq
	 +DJpprBaVN7JXiXSOKZ8c+zVIjAJ31lGMAdgVbNfvjIQPt3IhYHU+RYBrul6bpFI7l
	 2ZEen6bex1Be23wyucndxi1R/yq57waTBRl6cmOzDFl4yiYk62f7uEqB4cfWNJowzL
	 aSvDvArabQ3iSdwoW6kg6Oa6IoniE3Tz4VG1cXOzv9kX2zqnS9tnmLevYzlS5aq9J7
	 FcC6J2LJk9uO5Oz/QOns/syBO+yzQrovfi8EJ8AyzRmwZWw7FjL81X1LXVwdfJGnHN
	 6wf/raKuuz/AA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 062/317] cpufreq: Explicitly include correct DT includes
Date: Sun, 24 Mar 2024 19:30:42 -0400
Message-ID: <20240324233458.1352854-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 0cf18dd46b923..8a4e52b22eed7 100644
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
index c58abb4cca3a2..acaa8db57812d 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -9,7 +9,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 
 #include <asm/machdep.h>
 #include <asm/prom.h>
diff --git a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
index 037fe23bc6ed0..e85fa0f41991c 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq_pmi.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/timer.h>
 #include <linux/init.h>
-#include <linux/of_platform.h>
 #include <linux/pm_qos.h>
 
 #include <asm/processor.h>
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6e011e8bfb6a9..63fc879e23096 100644
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
index bda3e7d429647..763692e327b18 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -22,7 +22,7 @@
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/pm_opp.h>
 #include <linux/scpi_protocol.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
index fdb0a722d8812..f1cde44670689 100644
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
index 8f9fdd864391a..88bffa0bd0139 100644
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


