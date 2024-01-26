Return-Path: <linux-kernel+bounces-39649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137DE83D44D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB731C235B1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39033175A1;
	Fri, 26 Jan 2024 06:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="cSZ8EPuL"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BD11199;
	Fri, 26 Jan 2024 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249631; cv=none; b=KmvkMPEIGt1o41gWy40b5YOCK45YG+vo0byYgvVFlnjAJQHvo21L7lhhGgiUSohDIRbE63X4LUNv+P+cCgUHNHq8eGizT7Twr0rVzkgzl8rQTjXnmpwDnNgxwusSkHGzeFW9vbcpbPFQdS0UU2td9pF9RV+nfZvAhzUP4dR6ys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249631; c=relaxed/simple;
	bh=NSY2jyTpYUJkOi3qGPBcaqscnscOFJ7dKzxcGQNhZc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWtIMmxzFBU1ZamD/rbp3VYWJ+/8ks8ushuusYvdGmJXIHniBxo/2r+zOoWsHpv/TKspS3onAMZLh6xe61vubXGlEIRWACz0epG8t6MUXuUSVMs0xUNOfOj/7FxK435GCbPFsdFTnVN/sU0iavU2Q+4TD+mlrrUCU7juYdOpmZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=cSZ8EPuL; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706249629; x=1737785629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NSY2jyTpYUJkOi3qGPBcaqscnscOFJ7dKzxcGQNhZc8=;
  b=cSZ8EPuLHwWX5l5szgQ/jAX3U7q1bPVLbR7uqN0qUIG60jI2qgNNSN4x
   ++q43oX0YieJiUoEoCkd+2DvopyWWmzDch+JP0J7PY+t0rWTrlhta+Uoj
   dudopEF2NQ0crVuZO53LWd9xe/KyL7WLmWA/uRd8VXgFlEHp0uWZliSOS
   Vyvfw6Q3dPfkOlicXZTY8X0RsbaqGzBMlgxXkuFxxHA1u1DN4Mxn0kQ8w
   03wkUvVbSGDYTWzZM22gmwPguQVl7gdGUqTNKrfeOoZdOynrmyXfqA3xe
   cLIAJuROBK6KRFAi1WjfN+ixxO+CS/7kPwra6HQdWmzVx8bL3mS+qbC4O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="147342526"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="147342526"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:13:37 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A624AD9D97;
	Fri, 26 Jan 2024 15:13:34 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id C64A1D8BBB;
	Fri, 26 Jan 2024 15:13:33 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4F758E55AE;
	Fri, 26 Jan 2024 15:13:33 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 8052B1A006C;
	Fri, 26 Jan 2024 14:13:32 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 4/4] arch/x86/events/intel: Convert snprintf/sprintf to sysfs_emit
Date: Fri, 26 Jan 2024 14:13:19 +0800
Message-Id: <20240126061319.245901-4-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126061319.245901-1-lizhijian@fujitsu.com>
References: <20240126061319.245901-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28142.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28142.005
X-TMASE-Result: 10--15.300200-10.000000
X-TMASE-MatchedRID: dBi1avXuVWw4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpRzqfit7JyUVv+tuWXZk8lIEVuC0eNRYvLSvRkgO4EJeqyitsTk3SfXhQ6
	YZNvnIb96nBST4xyrLMMeFc5zbLKUj56IjTnLR+m5x7uAXGEprcE5XPQnBzGXq8KsbROd9VR3Ib
	SSOjBC48Inj1es+UVqJmT/R1dRpcrvEJY6jb7huii1gp0ZxaqK0MQw+++ihy+4GyTmeN+AbP2gE
	+jwlmhQBEleHrOyiTdSV1ufuEL9uf+XuscWvkzguLt50vtxBA7865QlVwxmG6c25vF67O2XGEG9
	aBmVf7zi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq+mTbRaoIcTcyQytwlNX6GZLZ798+FR1TyRZXy
	e0LVu8G7Gx1BMuFPw
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./arch/x86/events/intel/core.c:5614:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
> ./arch/x86/events/intel/core.c:5623:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
> ./arch/x86/events/intel/core.c:5605:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
> ./arch/x86/events/intel/core.c:5651:8-16: WARNING: please use sysfs_emit or sysfs_emit_at
> ./arch/x86/events/intel/core.c:5571:8-16: WARNING: please use sysfs_emit or sysfs_emit_at

Most of this patch is generated by:
$ make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci M=arch/x86/events/intel | sed -n '6,$p' | patch -p1

No functional change intended

CC: Peter Zijlstra <peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>
CC: Adrian Hunter <adrian.hunter@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-perf-users@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
- Rebase to v6.8-rc1(Fix 2 newly introduced abused cases)
- Extract patch from the patch set[1] so that maintainer accept it separately.
 [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 arch/x86/events/intel/core.c         | 12 ++++++------
 arch/x86/events/intel/pt.c           | 10 +++++-----
 arch/x86/events/intel/uncore.c       |  2 +-
 arch/x86/events/intel/uncore_snbep.c |  2 +-
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3804f21ab049..7effb715dfaa 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5517,7 +5517,7 @@ static ssize_t freeze_on_smi_show(struct device *cdev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	return sprintf(buf, "%lu\n", x86_pmu.attr_freeze_on_smi);
+	return sysfs_emit(buf, "%lu\n", x86_pmu.attr_freeze_on_smi);
 }
 
 static DEFINE_MUTEX(freeze_on_smi_mutex);
@@ -5568,7 +5568,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -5602,7 +5602,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5611,7 +5611,7 @@ static ssize_t branch_counter_nr_show(struct device *cdev,
 				      struct device_attribute *attr,
 				      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", fls(x86_pmu.lbr_counters));
+	return sysfs_emit(buf, "%d\n", fls(x86_pmu.lbr_counters));
 }
 
 static DEVICE_ATTR_RO(branch_counter_nr);
@@ -5620,7 +5620,7 @@ static ssize_t branch_counter_width_show(struct device *cdev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", LBR_INFO_BR_CNTR_BITS);
+	return sysfs_emit(buf, "%d\n", LBR_INFO_BR_CNTR_BITS);
 }
 
 static DEVICE_ATTR_RO(branch_counter_width);
@@ -5648,7 +5648,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a12235e62..178238d096cd 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -96,7 +96,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
+	return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group __ro_after_init = {
@@ -150,11 +150,11 @@ pt_timing_attr_show(struct device *dev, struct device_attribute *attr,
 
 	switch (pmu_attr->id) {
 	case 0:
-		return sprintf(page, "%lu\n", pt_pmu.max_nonturbo_ratio);
+		return sysfs_emit(page, "%lu\n", pt_pmu.max_nonturbo_ratio);
 	case 1:
-		return sprintf(page, "%u:%u\n",
-			       pt_pmu.tsc_art_num,
-			       pt_pmu.tsc_art_den);
+		return sysfs_emit(page, "%u:%u\n",
+				  pt_pmu.tsc_art_num,
+				  pt_pmu.tsc_art_den);
 	default:
 		break;
 	}
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7927c0b832fa..b6bb3aa286fe 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -131,7 +131,7 @@ ssize_t uncore_event_show(struct device *dev,
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
-	return sprintf(buf, "%s", event->config);
+	return sysfs_emit(buf, "%s", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index a96496bef678..553ba9422677 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3754,7 +3754,7 @@ static ssize_t skx_iio_mapping_show(struct device *dev,
 	long die = (long)ea->var;
 	struct intel_uncore_topology *pmut = pmu_topology(pmu, die);
 
-	return sprintf(buf, "%04x:%02x\n", pmut ? pmut->iio->segment : 0,
+	return sysfs_emit(buf, "%04x:%02x\n", pmut ? pmut->iio->segment : 0,
 					   pmut ? pmut->iio->pci_bus_no : 0);
 }
 
-- 
2.29.2


