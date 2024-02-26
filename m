Return-Path: <linux-kernel+bounces-81275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A092086733C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5B61F26281
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567884CB20;
	Mon, 26 Feb 2024 11:34:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2E64C627
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947268; cv=none; b=S6uuleUovk7MoLXidHPLCfCiuZ4pWKMFOa3+fi7ULwwwaoicJSTOpWgrQAIuve9tohNU9G2+CRidJ/cuHKioK2La2J5iurYPvV+A2U5TI9zc2tAl3E2KFE0b0nPjEL/G2tQJxnU+iPVyosE0PzQf8949WQ5vXqlj8AbPITV20VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947268; c=relaxed/simple;
	bh=iQUVhMXan0N9d/UX9hOf/y32NkYSxDSZ3nvhEoqpFqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7z3CAllUKnfNdpZvW/Q54TfapzaELShI1wPJtMHL8tJPM2FVQU3vChhsoGsVTvzScdgmDFCzHqpsa3+uXElfXV6uwmpJyOWScA9Hx3sqqgYJKkSqC56hwwFDyKRjvvTjbaxyWdKWamrGDaQ7zarQYe9YGfNchHCZI+kASCvL4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69C8F1042;
	Mon, 26 Feb 2024 03:35:05 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 68BED3F6C4;
	Mon, 26 Feb 2024 03:34:23 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org,
	oliver.upton@linux.dev,
	broonie@kernel.org
Cc: James Clark <james.clark@arm.com>,
	James Morse <james.morse@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Miguel Luis <miguel.luis@oracle.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Quentin Perret <qperret@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Donnefort <vdonnefort@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] coresight: Pass guest TRFCR value to KVM
Date: Mon, 26 Feb 2024 11:30:36 +0000
Message-Id: <20240226113044.228403-9-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226113044.228403-1-james.clark@arm.com>
References: <20240226113044.228403-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the userspace and kernel filters for guests are never set, so
no trace will be generated for them. Add support for tracing guests by
passing the desired TRFCR value to KVM so it can be applied to the
guest.

By writing either E1TRE or E0TRE, filtering on either guest kernel or
guest userspace is also supported. And if both E1TRE and E0TRE are
cleared when exclude_guest is set, that option is supported too. This
change also brings exclude_host support which is difficult to add as a
separate commit without excess churn and resulting in no trace at all.

Testing
=======

The addresses were counted with the following:

  $ perf report -D | grep -Eo 'EL2|EL1|EL0' | sort | uniq -c

Guest kernel only:

  $ perf record -e cs_etm//Gk -a -- true
    535 EL1
      1 EL2

Guest user only (only 5 addresses because the guest runs slowly in the
model):

  $ perf record -e cs_etm//Gu -a -- true
    5 EL0

Host kernel only:

  $  perf record -e cs_etm//Hk -a -- true
   3501 EL2

Host userspace only:

  $  perf record -e cs_etm//Hu -a -- true
    408 EL0
      1 EL2

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-core.c          | 42 ++++++++++++++++---
 drivers/hwtracing/coresight/coresight-etm4x.h |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  3 ++
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ce1995a2827f..45a69bfdc6b5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -6,6 +6,7 @@
 #include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <linux/kvm_host.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -271,9 +272,22 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
 	if (!drvdata->trfcr)
 		return;
+	kvm_etm_set_guest_trfcr(0);
 	cpu_prohibit_trace();
 }
 
+static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
+{
+	u64 trfcr = drvdata->trfcr;
+
+	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
+		trfcr &= ~TRFCR_ELx_ExTRE;
+	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
+		trfcr &= ~TRFCR_ELx_E0TRE;
+
+	return trfcr;
+}
+
 /*
  * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
  * as configured by the drvdata->config.mode for the current
@@ -286,18 +300,28 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
  */
 static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 {
-	u64 trfcr = drvdata->trfcr;
+	u64 trfcr;
 
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
-	if (!trfcr)
+	if (!drvdata->trfcr)
 		return;
 
-	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
-		trfcr &= ~TRFCR_ELx_ExTRE;
-	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
-		trfcr &= ~TRFCR_ELx_E0TRE;
+	if (drvdata->config.mode & ETM_MODE_EXCL_HOST)
+		trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
+	else
+		trfcr = etm4x_get_kern_user_filter(drvdata);
 
 	write_trfcr(trfcr);
+
+	/* Set filters for guests and pass to KVM */
+	if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
+		trfcr = drvdata->trfcr & ~(TRFCR_ELx_ExTRE | TRFCR_ELx_E0TRE);
+	else
+		trfcr = etm4x_get_kern_user_filter(drvdata);
+
+	/* TRFCR_EL1 doesn't have CX so mask it out. */
+	trfcr &= ~TRFCR_EL2_CX;
+	kvm_etm_set_guest_trfcr(trfcr);
 }
 
 #ifdef CONFIG_ETM4X_IMPDEF_FEATURE
@@ -655,6 +679,12 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	if (attr->exclude_user)
 		config->mode = ETM_MODE_EXCL_USER;
 
+	if (attr->exclude_host)
+		config->mode |= ETM_MODE_EXCL_HOST;
+
+	if (attr->exclude_guest)
+		config->mode |= ETM_MODE_EXCL_GUEST;
+
 	/* Always start from the default config */
 	etm4_set_default_config(config);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index da17b6c49b0f..70c29e91f4b5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -841,7 +841,7 @@ enum etm_impdef_type {
  * @s_ex_level: Secure ELs where tracing is supported.
  */
 struct etmv4_config {
-	u32				mode;
+	u64				mode;
 	u32				pe_sel;
 	u32				cfg;
 	u32				eventctrl0;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e07970..727dd27ba800 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -39,6 +39,9 @@
 
 #define ETM_MODE_EXCL_KERN	BIT(30)
 #define ETM_MODE_EXCL_USER	BIT(31)
+#define ETM_MODE_EXCL_HOST	BIT(32)
+#define ETM_MODE_EXCL_GUEST	BIT(33)
+
 struct cs_pair_attribute {
 	struct device_attribute attr;
 	u32 lo_off;
-- 
2.34.1


