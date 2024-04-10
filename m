Return-Path: <linux-kernel+bounces-139525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0EB8A03F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14DDB1F21DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90883FE52;
	Wed, 10 Apr 2024 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZvNP3K8n"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B2F3E47B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791338; cv=none; b=UXnOWMsZePB+vif65LhrBq/vgI+lG+N+qPVDpMkpUSOdOjANfhgYwDmajM1XU4YtIl2Pkn12Qw5t81hB11j9RWmE0pn2b7X93aSkVekZ9lmKSPl29eezJdQNCILG0fCK0nrIssALkF5KRqO/p0roZFN9FQBF7a5GNB6n6r/ulxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791338; c=relaxed/simple;
	bh=C1Cggop2R+WTc+R4/TFM7+lo8ZEIZ3c6Tykm84sd+fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpPKwfOg3k2BApLeV3evTZX8eKV5R9CPp412+6c9v6syTlQ6v/KQLuz9lcnZ0i21rezxA/mKfQyqrk8y8iywdYyUHWER3zFRvwIrM3RvIVRRZqWQaabAUa17UxldG2Q0Y2jEwru0pO26t4IusjTVEJDjoUovCV0GQ8yFKM9oT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZvNP3K8n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so4514953a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1712791336; x=1713396136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+xEyOh0M1W0xL2DtBPhpQ2krZlGziuT9mNpOFxUrPI=;
        b=ZvNP3K8nJSneIfpBGvf1I0UbExaFb7IEIpz3c9adCm9TYQ+8KUI+etAI9UMFRWcyzZ
         heBdF2qo1iDcqrQyZ9m8DVZR9awo6c0LtNHt+kWq0S27Yy4DpulGteg+jNRIqrGNWJ/p
         LzdTgNg8WpQ98AFHkxcnM3hHhrhPLY82r2nTLNmeUqovx0b3gz+8rww4gqFpD2767VWc
         CpH8ksGvx+0tShQTo54aOlRL9pTcKRkQ44VW0vrbQcFEsFAta4sXtOi7cPWEaGGh6zmt
         Vf5BRqQaPJvU+u3r8WDM/74Lxg7XibD1ejRNZhk4n5tRnBbo3eg/rTYTVCVrzS+efoDh
         0ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712791336; x=1713396136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+xEyOh0M1W0xL2DtBPhpQ2krZlGziuT9mNpOFxUrPI=;
        b=UykItI8KYCDx45nq2wOW0NCv/uavPRTE8XL1lxuuX6mJvJialnutMBdUWl6/9OVxeu
         0M4FSkjH/avE0fU5e8v3yV+FPj7q7fjU4/zKnTr4znIWpX6YbQRGaV+onJ1rXcSoiTjg
         RxrZDYdl0zhLoU22kDriHMhy8PXpLRHMUjKZ6AVDptHqdZkZbYHtHPbQwkN5Z+2sVjMD
         jPU5UmYQEVBRHW3/8oAOtzWnCy2ZnroUwKY4w6KbzWX7w15BREejbsdDL5ipcN4snNYk
         v6Un3ok7T71XNrVvS1WK9Py5EnsbHBJVfMt+b6kEx8trlm/TcuyVHnPcdsSyfVnuOR03
         bR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWgbU5tUAQlq7LIM15nFRHWZPPhBB2xfUehfrlHhKzrrMPRK6N5N7pG6ABNyKS1sYoTGAWlRqmyGw2xfaH3LmDAcx7vv0Bfs9rIuw1v
X-Gm-Message-State: AOJu0YwWRxGkHY/uGuJgz2x4NAO7aiKO+1bCMv8EMbigGOiLZ1tZH43F
	+9/UtyRvo5TerQOavnlXZ4KGBkgLpV0jIPl8y7hxuobxJZRdYXbsxlAGWa3gWZc=
X-Google-Smtp-Source: AGHT+IGp4Idc2NG3pVS/vsrTy9eVQjpOytYv5hd5ONmx0POT/BGj99cAO2unYtbQ58d68y/B3rLWag==
X-Received: by 2002:a17:90b:1e42:b0:2a2:b411:81ae with SMTP id pi2-20020a17090b1e4200b002a2b41181aemr3926259pjb.4.1712791336375;
        Wed, 10 Apr 2024 16:22:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090aac1300b002a269828bb8sm161865pjq.40.2024.04.10.16.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 16:22:16 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cache: sifive_ccache: Export base address for child drivers
Date: Wed, 10 Apr 2024 16:22:05 -0700
Message-ID: <20240410232211.438277-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410232211.438277-1-samuel.holland@sifive.com>
References: <20240410232211.438277-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SiFive Composable Cache functionality is split across multiple
drivers, including the base cache driver, the EDAC driver, and a
PMU driver. Export the MMIO base address from the main driver so the
child drivers can access the MMIO space. Since each driver uses a
different subset of registers, there are no synchronization concerns.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 drivers/cache/sifive_ccache.c      | 44 +++++++++++++++---------------
 include/soc/sifive/sifive_ccache.h |  4 +++
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/cache/sifive_ccache.c b/drivers/cache/sifive_ccache.c
index 9833e9f6f36c..42dac39c41cf 100644
--- a/drivers/cache/sifive_ccache.c
+++ b/drivers/cache/sifive_ccache.c
@@ -53,7 +53,7 @@
 #define SIFIVE_CCACHE_MAX_ECCINTR 4
 #define SIFIVE_CCACHE_LINE_SIZE 64
 
-static void __iomem *ccache_base;
+static struct sifive_ccache ccache;
 static int g_irq[SIFIVE_CCACHE_MAX_ECCINTR];
 static struct riscv_cacheinfo_ops ccache_cache_ops;
 static int level;
@@ -81,7 +81,7 @@ static ssize_t ccache_write(struct file *file, const char __user *data,
 	if (kstrtouint_from_user(data, count, 0, &val))
 		return -EINVAL;
 	if ((val < 0xFF) || (val >= 0x10000 && val < 0x100FF))
-		writel(val, ccache_base + SIFIVE_CCACHE_ECCINJECTERR);
+		writel(val, ccache.base + SIFIVE_CCACHE_ECCINJECTERR);
 	else
 		return -EINVAL;
 	return count;
@@ -106,14 +106,14 @@ static void ccache_config_read(void)
 {
 	u32 cfg;
 
-	cfg = readl(ccache_base + SIFIVE_CCACHE_CONFIG);
+	cfg = readl(ccache.base + SIFIVE_CCACHE_CONFIG);
 	pr_info("%llu banks, %llu ways, sets/bank=%llu, bytes/block=%llu\n",
 		FIELD_GET(SIFIVE_CCACHE_CONFIG_BANK_MASK, cfg),
 		FIELD_GET(SIFIVE_CCACHE_CONFIG_WAYS_MASK, cfg),
 		BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_SETS_MASK, cfg)),
 		BIT_ULL(FIELD_GET(SIFIVE_CCACHE_CONFIG_BLKS_MASK, cfg)));
 
-	cfg = readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
+	cfg = readl(ccache.base + SIFIVE_CCACHE_WAYENABLE);
 	pr_info("Index of the largest way enabled: %u\n", cfg);
 }
 
@@ -153,9 +153,9 @@ static void ccache_flush_range(phys_addr_t start, size_t len)
 	for (line = ALIGN_DOWN(start, SIFIVE_CCACHE_LINE_SIZE); line < end;
 			line += SIFIVE_CCACHE_LINE_SIZE) {
 #ifdef CONFIG_32BIT
-		writel(line >> 4, ccache_base + SIFIVE_CCACHE_FLUSH32);
+		writel(line >> 4, ccache.base + SIFIVE_CCACHE_FLUSH32);
 #else
-		writeq(line, ccache_base + SIFIVE_CCACHE_FLUSH64);
+		writeq(line, ccache.base + SIFIVE_CCACHE_FLUSH64);
 #endif
 		mb();
 	}
@@ -170,7 +170,7 @@ static const struct riscv_nonstd_cache_ops ccache_mgmt_ops __initconst = {
 
 static int ccache_largest_wayenabled(void)
 {
-	return readl(ccache_base + SIFIVE_CCACHE_WAYENABLE) & 0xFF;
+	return readl(ccache.base + SIFIVE_CCACHE_WAYENABLE) & 0xFF;
 }
 
 static ssize_t number_of_ways_enabled_show(struct device *dev,
@@ -206,41 +206,41 @@ static irqreturn_t ccache_int_handler(int irq, void *device)
 	unsigned int add_h, add_l;
 
 	if (irq == g_irq[DIR_CORR]) {
-		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
-		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_LOW);
+		add_h = readl(ccache.base + SIFIVE_CCACHE_DIRECCFIX_HIGH);
+		add_l = readl(ccache.base + SIFIVE_CCACHE_DIRECCFIX_LOW);
 		pr_err("DirError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DirError interrupt sig */
-		readl(ccache_base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
+		readl(ccache.base + SIFIVE_CCACHE_DIRECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
 					   SIFIVE_CCACHE_ERR_TYPE_CE,
 					   "DirECCFix");
 	}
 	if (irq == g_irq[DIR_UNCORR]) {
-		add_h = readl(ccache_base + SIFIVE_CCACHE_DIRECCFAIL_HIGH);
-		add_l = readl(ccache_base + SIFIVE_CCACHE_DIRECCFAIL_LOW);
+		add_h = readl(ccache.base + SIFIVE_CCACHE_DIRECCFAIL_HIGH);
+		add_l = readl(ccache.base + SIFIVE_CCACHE_DIRECCFAIL_LOW);
 		/* Reading this register clears the DirFail interrupt sig */
-		readl(ccache_base + SIFIVE_CCACHE_DIRECCFAIL_COUNT);
+		readl(ccache.base + SIFIVE_CCACHE_DIRECCFAIL_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
 					   SIFIVE_CCACHE_ERR_TYPE_UE,
 					   "DirECCFail");
 		panic("CCACHE: DirFail @ 0x%08X.%08X\n", add_h, add_l);
 	}
 	if (irq == g_irq[DATA_CORR]) {
-		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_HIGH);
-		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_LOW);
+		add_h = readl(ccache.base + SIFIVE_CCACHE_DATECCFIX_HIGH);
+		add_l = readl(ccache.base + SIFIVE_CCACHE_DATECCFIX_LOW);
 		pr_err("DataError @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataError interrupt sig */
-		readl(ccache_base + SIFIVE_CCACHE_DATECCFIX_COUNT);
+		readl(ccache.base + SIFIVE_CCACHE_DATECCFIX_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
 					   SIFIVE_CCACHE_ERR_TYPE_CE,
 					   "DatECCFix");
 	}
 	if (irq == g_irq[DATA_UNCORR]) {
-		add_h = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
-		add_l = readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_LOW);
+		add_h = readl(ccache.base + SIFIVE_CCACHE_DATECCFAIL_HIGH);
+		add_l = readl(ccache.base + SIFIVE_CCACHE_DATECCFAIL_LOW);
 		pr_err("DataFail @ 0x%08X.%08X\n", add_h, add_l);
 		/* Reading this register clears the DataFail interrupt sig */
-		readl(ccache_base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
+		readl(ccache.base + SIFIVE_CCACHE_DATECCFAIL_COUNT);
 		atomic_notifier_call_chain(&ccache_err_chain,
 					   SIFIVE_CCACHE_ERR_TYPE_UE,
 					   "DatECCFail");
@@ -298,8 +298,8 @@ static int __init sifive_ccache_init(void)
 
 	quirks = (uintptr_t)match->data;
 
-	ccache_base = of_iomap(np, 0);
-	if (!ccache_base) {
+	ccache.base = of_iomap(np, 0);
+	if (!ccache.base) {
 		rc = -ENOMEM;
 		goto err_node_put;
 	}
@@ -335,7 +335,7 @@ static int __init sifive_ccache_init(void)
 	return 0;
 
 err_unmap:
-	iounmap(ccache_base);
+	iounmap(ccache.base);
 err_node_put:
 	of_node_put(np);
 	return rc;
diff --git a/include/soc/sifive/sifive_ccache.h b/include/soc/sifive/sifive_ccache.h
index 4d4ed49388a0..85fd1ff1355a 100644
--- a/include/soc/sifive/sifive_ccache.h
+++ b/include/soc/sifive/sifive_ccache.h
@@ -7,6 +7,10 @@
 #ifndef __SOC_SIFIVE_CCACHE_H
 #define __SOC_SIFIVE_CCACHE_H
 
+struct sifive_ccache {
+	void __iomem		*base;
+};
+
 extern int register_sifive_ccache_error_notifier(struct notifier_block *nb);
 extern int unregister_sifive_ccache_error_notifier(struct notifier_block *nb);
 
-- 
2.44.0


