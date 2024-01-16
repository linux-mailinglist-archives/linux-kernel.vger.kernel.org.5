Return-Path: <linux-kernel+bounces-26968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16D82E8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958E01F238B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43011183;
	Tue, 16 Jan 2024 04:52:29 +0000 (UTC)
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561C12B89;
	Tue, 16 Jan 2024 04:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="146236932"
X-IronPort-AV: E=Sophos;i="6.04,198,1695654000"; 
   d="scan'208";a="146236932"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:52:19 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5B30FD9D90;
	Tue, 16 Jan 2024 13:52:16 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 83F56BF3FF;
	Tue, 16 Jan 2024 13:52:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id ECAFD6B4CA;
	Tue, 16 Jan 2024 13:52:14 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 230561A0160;
	Tue, 16 Jan 2024 12:52:14 +0800 (CST)
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
Subject: [PATCH 05/42] arch/x86/events/intel: Convert snprintf to sysfs_emit
Date: Tue, 16 Jan 2024 12:51:14 +0800
Message-Id: <20240116045151.3940401-3-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240116045151.3940401-1-lizhijian@fujitsu.com>
References: <20240116041129.3937800-1-lizhijian@fujitsu.com>
 <20240116045151.3940401-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28122.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28122.005
X-TMASE-Result: 10--9.097500-10.000000
X-TMASE-MatchedRID: e6WPXQD7Ri84ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpR5sRK06wHV4ZsFQA+TKYc0rMZ+BqQt2No4ptE5KnVLXjoUdFbHYUawvwU
	evDt+uW5/XjpbSJS7a0NziVKCujClC2Anznh4fA6HmRpBdG9H1zexY0PszFIeR6RHdVK85hU3U1
	4kSxupDgOvPn6zMZtLZd7aQCHVPPQfE8yM4pjsDwtuKBGekqUpI/NGWt0UYPD+g9ZptlFQ2FT75
	KevbdCMo4C9/4njWLA1aAM/OPY/K4uX/sx5DfTn
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./arch/x86/events/intel/core.c:5496:8-16: WARNING: please use sysfs_emit
> ./arch/x86/events/intel/core.c:5530:8-16: WARNING: please use sysfs_emit
> ./arch/x86/events/intel/core.c:5546:8-16: WARNING: please use sysfs_emit
> ./arch/x86/events/intel/pt.c:99:8-16: WARNING: please use sysfs_emit

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
 arch/x86/events/intel/core.c | 6 +++---
 arch/x86/events/intel/pt.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0f2786d4e405..aa5fa64a923b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5493,7 +5493,7 @@ static ssize_t show_sysctl_tfa(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, 40, "%d\n", allow_tsx_force_abort);
+	return sysfs_emit(buf, "%d\n", allow_tsx_force_abort);
 }
 
 static ssize_t set_sysctl_tfa(struct device *cdev,
@@ -5527,7 +5527,7 @@ static ssize_t branches_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
@@ -5543,7 +5543,7 @@ static ssize_t pmu_name_show(struct device *cdev,
 			     struct device_attribute *attr,
 			     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", pmu_name_str);
+	return sysfs_emit(buf, "%s\n", pmu_name_str);
 }
 
 static DEVICE_ATTR_RO(pmu_name);
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 8e2a12235e62..30bba5f3a840 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -96,7 +96,7 @@ static ssize_t pt_cap_show(struct device *cdev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	enum pt_capabilities cap = (long)ea->var;
 
-	return snprintf(buf, PAGE_SIZE, "%x\n", intel_pt_validate_hw_cap(cap));
+	return sysfs_emit(buf, "%x\n", intel_pt_validate_hw_cap(cap));
 }
 
 static struct attribute_group pt_cap_group __ro_after_init = {
-- 
2.29.2


