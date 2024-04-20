Return-Path: <linux-kernel+bounces-152369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE388ABD04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 22:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FF71C2086B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 20:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2645BEC;
	Sat, 20 Apr 2024 20:06:17 +0000 (UTC)
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D6374F7
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 20:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713643576; cv=none; b=K8R1kn7Dc8b4F+mhY53NUN+SelNxdUXjqgd/K40+sAeqO+FqLZFBuV7oF4GIRw9xGgRvSouOFiam43JXNxV233+Z/sPhoUFHQhgvld3KedspQdX8jyo97X3YgxY9PLbzJexmB+mK5NSrw8tjWiDVR/kPyjasR6yLzS7BXCnmuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713643576; c=relaxed/simple;
	bh=SJLsBVmhwlj1yVLisqQ5YBDEm+4Aq95LOI1Ys1f7Uug=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=Gsj/k42PbHb2M0mVUtAPaf40rrUJMllMlDYqhlZNd0xaW0T6VyVGatUt8mWWb9cr9bno2u3cLCUyeGQM+InhpwkJghxZEJKbYyQjK9Rvv1MCNAqZe/qI9dqKQluMmPjPTlUf9F0JAuPD/tw4xb3jB6rRFWYR6DtN194EgTA31xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 6E8F330008F1C;
	Sat, 20 Apr 2024 22:06:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6895E120701; Sat, 20 Apr 2024 22:06:12 +0200 (CEST)
Message-ID: <3a297850312b4ecb62d6872121de04496900f502.1713608122.git.lukas@wunner.de>
In-Reply-To: <cover.1713608122.git.lukas@wunner.de>
References: <cover.1713608122.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sat, 20 Apr 2024 22:00:04 +0200
Subject: [PATCH 4/6] perf: Use device_show_string() helper for sysfs
 attributes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>, Jijie Shao <shaojijie@huawei.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Khuong Dinh <khuong@os.amperecomputing.com>, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Deduplicate sysfs ->show() callbacks which expose a string at a static
memory location.  Use the newly introduced device_show_string() helper
in the driver core instead by declaring those sysfs attributes with
DEVICE_STRING_ATTR_RO().

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 arch/x86/events/intel/core.c             | 13 +++----------
 drivers/perf/alibaba_uncore_drw_pmu.c    | 12 ++----------
 drivers/perf/arm-cci.c                   | 12 +-----------
 drivers/perf/arm-ccn.c                   | 11 +----------
 drivers/perf/arm_cspmu/arm_cspmu.c       | 10 ----------
 drivers/perf/arm_cspmu/arm_cspmu.h       |  7 +------
 drivers/perf/arm_dsu_pmu.c               | 11 +----------
 drivers/perf/cxl_pmu.c                   | 13 +------------
 drivers/perf/hisilicon/hisi_pcie_pmu.c   | 13 +------------
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 14 --------------
 drivers/perf/hisilicon/hisi_uncore_pmu.h |  4 +---
 drivers/perf/hisilicon/hns3_pmu.c        | 12 +-----------
 drivers/perf/qcom_l3_pmu.c               | 11 +----------
 drivers/perf/xgene_pmu.c                 | 11 +----------
 14 files changed, 15 insertions(+), 139 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 768d1414897f..38c1b1f1deaa 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5645,18 +5645,11 @@ lbr_is_visible(struct kobject *kobj, struct attribute *attr, int i)
 
 static char pmu_name_str[30];
 
-static ssize_t pmu_name_show(struct device *cdev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
-}
-
-static DEVICE_ATTR_RO(pmu_name);
+static DEVICE_STRING_ATTR_RO(pmu_name, 0444, pmu_name_str);
 
 static struct attribute *intel_pmu_caps_attrs[] = {
-       &dev_attr_pmu_name.attr,
-       NULL
+	&dev_attr_pmu_name.attr.attr,
+	NULL
 };
 
 static DEVICE_ATTR(allow_tsx_force_abort, 0644,
diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index a9277dcf90ce..a82592e131ba 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -236,24 +236,16 @@ static const struct attribute_group ali_drw_pmu_cpumask_attr_group = {
 	.attrs = ali_drw_pmu_cpumask_attrs,
 };
 
-static ssize_t ali_drw_pmu_identifier_show(struct device *dev,
-					struct device_attribute *attr,
-					char *page)
-{
-	return sysfs_emit(page, "%s\n", "ali_drw_pmu");
-}
-
 static umode_t ali_drw_pmu_identifier_attr_visible(struct kobject *kobj,
 						struct attribute *attr, int n)
 {
 	return attr->mode;
 }
 
-static struct device_attribute ali_drw_pmu_identifier_attr =
-	__ATTR(identifier, 0444, ali_drw_pmu_identifier_show, NULL);
+static DEVICE_STRING_ATTR_RO(ali_drw_pmu_identifier, 0444, "ali_drw_pmu");
 
 static struct attribute *ali_drw_pmu_identifier_attrs[] = {
-	&ali_drw_pmu_identifier_attr.attr,
+	&dev_attr_ali_drw_pmu_identifier.attr.attr,
 	NULL
 };
 
diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 6be03f81ae5d..e516edc933f2 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -127,8 +127,6 @@ enum cci_models {
 
 static void pmu_write_counters(struct cci_pmu *cci_pmu,
 				 unsigned long *mask);
-static ssize_t __maybe_unused cci_pmu_format_show(struct device *dev,
-			struct device_attribute *attr, char *buf);
 static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
 			struct device_attribute *attr, char *buf);
 
@@ -138,7 +136,7 @@ static ssize_t __maybe_unused cci_pmu_event_show(struct device *dev,
 	})[0].attr.attr
 
 #define CCI_FORMAT_EXT_ATTR_ENTRY(_name, _config) \
-	CCI_EXT_ATTR_ENTRY(_name, cci_pmu_format_show, (char *)_config)
+	CCI_EXT_ATTR_ENTRY(_name, device_show_string, _config)
 #define CCI_EVENT_EXT_ATTR_ENTRY(_name, _config) \
 	CCI_EXT_ATTR_ENTRY(_name, cci_pmu_event_show, (unsigned long)_config)
 
@@ -688,14 +686,6 @@ static void __cci_pmu_disable(struct cci_pmu *cci_pmu)
 	writel(val, cci_pmu->ctrl_base + CCI_PMCR);
 }
 
-static ssize_t cci_pmu_format_show(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr = container_of(attr,
-				struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-
 static ssize_t cci_pmu_event_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 641471bd5eff..e4408acd4450 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -215,18 +215,9 @@ static void arm_ccn_pmu_config_set(u64 *config, u32 node_xp, u32 type, u32 port)
 	*config |= (node_xp << 0) | (type << 8) | (port << 24);
 }
 
-static ssize_t arm_ccn_pmu_format_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *ea = container_of(attr,
-			struct dev_ext_attribute, attr);
-
-	return sysfs_emit(buf, "%s\n", (char *)ea->var);
-}
-
 #define CCN_FORMAT_ATTR(_name, _config) \
 	struct dev_ext_attribute arm_ccn_pmu_format_attr_##_name = \
-			{ __ATTR(_name, S_IRUGO, arm_ccn_pmu_format_show, \
+			{ __ATTR(_name, S_IRUGO, device_show_string, \
 			NULL), _config }
 
 static CCN_FORMAT_ATTR(node, "config:0-7");
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index b9a252272f1e..7aff616523ec 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -223,16 +223,6 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct dev_ext_attribute *eattr =
-		container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_format_show);
-
 static struct attribute *arm_cspmu_format_attrs[] = {
 	ARM_CSPMU_FORMAT_EVENT_ATTR,
 	ARM_CSPMU_FORMAT_FILTER_ATTR,
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index c9163acfe810..2621f3111148 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -28,7 +28,7 @@
 	})[0].attr.attr)
 
 #define ARM_CSPMU_FORMAT_ATTR(_name, _config)				\
-	ARM_CSPMU_EXT_ATTR(_name, arm_cspmu_sysfs_format_show, (char *)_config)
+	ARM_CSPMU_EXT_ATTR(_name, device_show_string, _config)
 
 #define ARM_CSPMU_EVENT_ATTR(_name, _config)				\
 	PMU_EVENT_ATTR_ID(_name, arm_cspmu_sysfs_event_show, _config)
@@ -167,11 +167,6 @@ ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf);
 
-/* Default function to show format attribute in sysfs. */
-ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf);
-
 /* Register vendor backend. */
 int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
 
diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index bae3ca37f846..4e54ce9100a6 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -85,7 +85,7 @@
 	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_event_show, (unsigned long)_config)
 
 #define DSU_FORMAT_ATTR(_name, _config)		\
-	DSU_EXT_ATTR(_name, dsu_pmu_sysfs_format_show, (char *)_config)
+	DSU_EXT_ATTR(_name, device_show_string, _config)
 
 #define DSU_CPUMASK_ATTR(_name, _config)	\
 	DSU_EXT_ATTR(_name, dsu_pmu_cpumask_show, (unsigned long)_config)
@@ -139,15 +139,6 @@ static ssize_t dsu_pmu_sysfs_event_show(struct device *dev,
 	return sysfs_emit(buf, "event=0x%lx\n", (unsigned long)eattr->var);
 }
 
-static ssize_t dsu_pmu_sysfs_format_show(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-	struct dev_ext_attribute *eattr = container_of(attr,
-					struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-
 static ssize_t dsu_pmu_cpumask_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 308c9969642e..c41263c7fe5c 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -208,21 +208,10 @@ static int cxl_pmu_parse_caps(struct device *dev, struct cxl_pmu_info *info)
 	return 0;
 }
 
-static ssize_t cxl_pmu_format_sysfs_show(struct device *dev,
-					 struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-
 #define CXL_PMU_FORMAT_ATTR(_name, _format)\
 	(&((struct dev_ext_attribute[]) {					\
 		{								\
-			.attr = __ATTR(_name, 0444,				\
-				       cxl_pmu_format_sysfs_show, NULL),	\
+			.attr = __ATTR(_name, 0444, device_show_string, NULL),	\
 			.var = (void *)_format					\
 		}								\
 		})[0].attr.attr)
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index 5d1f0e9fdb08..dfd1f448f3fc 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -99,16 +99,6 @@ HISI_PCIE_PMU_FILTER_ATTR(len_mode, config1, 11, 10);
 HISI_PCIE_PMU_FILTER_ATTR(port, config2, 15, 0);
 HISI_PCIE_PMU_FILTER_ATTR(bdf, config2, 31, 16);
 
-static ssize_t hisi_pcie_format_sysfs_show(struct device *dev, struct device_attribute *attr,
-					   char *buf)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-
 static ssize_t hisi_pcie_event_sysfs_show(struct device *dev, struct device_attribute *attr,
 					  char *buf)
 {
@@ -120,8 +110,7 @@ static ssize_t hisi_pcie_event_sysfs_show(struct device *dev, struct device_attr
 
 #define HISI_PCIE_PMU_FORMAT_ATTR(_name, _format)                              \
 	(&((struct dev_ext_attribute[]){                                       \
-		{ .attr = __ATTR(_name, 0444, hisi_pcie_format_sysfs_show,     \
-				 NULL),                                        \
+		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),       \
 		  .var = (void *)_format }                                     \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index 04031450d5fe..382c5567e4e2 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -22,20 +22,6 @@
 
 #define HISI_MAX_PERIOD(nr) (GENMASK_ULL((nr) - 1, 0))
 
-/*
- * PMU format attributes
- */
-ssize_t hisi_format_sysfs_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-EXPORT_SYMBOL_GPL(hisi_format_sysfs_show);
-
 /*
  * PMU event attributes
  */
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.h b/drivers/perf/hisilicon/hisi_uncore_pmu.h
index 92402aa69d70..25b2d43b72bf 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.h
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.h
@@ -33,7 +33,7 @@
 	})[0].attr.attr)
 
 #define HISI_PMU_FORMAT_ATTR(_name, _config)		\
-	HISI_PMU_ATTR(_name, hisi_format_sysfs_show, (void *)_config)
+	HISI_PMU_ATTR(_name, device_show_string, _config)
 #define HISI_PMU_EVENT_ATTR(_name, _config)		\
 	HISI_PMU_ATTR(_name, hisi_event_sysfs_show, (unsigned long)_config)
 
@@ -122,8 +122,6 @@ void hisi_uncore_pmu_enable(struct pmu *pmu);
 void hisi_uncore_pmu_disable(struct pmu *pmu);
 ssize_t hisi_event_sysfs_show(struct device *dev,
 			      struct device_attribute *attr, char *buf);
-ssize_t hisi_format_sysfs_show(struct device *dev,
-			       struct device_attribute *attr, char *buf);
 ssize_t hisi_cpumask_sysfs_show(struct device *dev,
 				struct device_attribute *attr, char *buf);
 int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node);
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 16869bf5bf4c..6d9725bdff83 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -363,16 +363,6 @@ HNS3_PMU_FILTER_ATTR(global, config1, 52, 52);
 	HNS3_PMU_EVT_PPS_##_name##_TIME,				\
 	HNS3_PMU_FILTER_INTR_##_name})
 
-static ssize_t hns3_pmu_format_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-
 static ssize_t hns3_pmu_event_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -421,7 +411,7 @@ static ssize_t hns3_pmu_filter_mode_show(struct device *dev,
 	})[0].attr.attr)
 
 #define HNS3_PMU_FORMAT_ATTR(_name, _format) \
-	HNS3_PMU_ATTR(_name, hns3_pmu_format_show, (void *)_format)
+	HNS3_PMU_ATTR(_name, device_show_string, _format)
 #define HNS3_PMU_EVENT_ATTR(_name, _event) \
 	HNS3_PMU_ATTR(_name, hns3_pmu_event_show, (void *)_event)
 #define HNS3_PMU_FLT_MODE_ATTR(_name, _event) \
diff --git a/drivers/perf/qcom_l3_pmu.c b/drivers/perf/qcom_l3_pmu.c
index f16783d03db7..5fc53781afba 100644
--- a/drivers/perf/qcom_l3_pmu.c
+++ b/drivers/perf/qcom_l3_pmu.c
@@ -609,18 +609,9 @@ static void qcom_l3_cache__event_read(struct perf_event *event)
 
 /* formats */
 
-static ssize_t l3cache_pmu_format_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "%s\n", (char *) eattr->var);
-}
-
 #define L3CACHE_PMU_FORMAT_ATTR(_name, _config)				      \
 	(&((struct dev_ext_attribute[]) {				      \
-		{ .attr = __ATTR(_name, 0444, l3cache_pmu_format_show, NULL), \
+		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
 		  .var = (void *) _config, }				      \
 	})[0].attr.attr)
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 0d49343d704b..79279a359995 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -162,18 +162,9 @@ enum xgene_pmu_dev_type {
 /*
  * sysfs format attributes
  */
-static ssize_t xgene_pmu_format_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr;
-
-	eattr = container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "%s\n", (char *) eattr->var);
-}
-
 #define XGENE_PMU_FORMAT_ATTR(_name, _config)		\
 	(&((struct dev_ext_attribute[]) {		\
-		{ .attr = __ATTR(_name, S_IRUGO, xgene_pmu_format_show, NULL), \
+		{ .attr = __ATTR(_name, S_IRUGO, device_show_string, NULL), \
 		  .var = (void *) _config, }		\
 	})[0].attr.attr)
 
-- 
2.43.0


