Return-Path: <linux-kernel+bounces-39651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8722A83D452
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 07:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64B9B20A58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8FD1803E;
	Fri, 26 Jan 2024 06:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="GSJAzkR5"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57A17BBB
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706249690; cv=none; b=Qsp5UeQ0TdVsCXMpqbZEeYoPtxzailvHXHDfnUsJ2IJmxdKGf0GsP2EeVwV8SK3Wsjhp/eAGack1oooXl2gW01aFJhRNBAPPxu1Veas+8Tk7nYvall/uAaHCWpRUE52HN5LIGa5OPlgXL2+rPZeqRfo94yReZ7A2HxTtt4mLovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706249690; c=relaxed/simple;
	bh=OdV3/VXkvGAeWdnhK/tcT92mxKx/qVq5LJz/V81cuTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LinfXuHlntebpQ4cKMkHVfHeOQqcVCLsHm+mNs9Bd+tsBpZNN8hlrsvD3g7RPn5/skHt9ZlbroKcB5baVIZZZE5loczUtfNXn9dtB7NEMg37S7us7qHqKznXfwdf+ctteCQbLDnm0IpOjlSyi8wiudZQQWJT5GiENNwiL2OnofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=GSJAzkR5; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1706249688; x=1737785688;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OdV3/VXkvGAeWdnhK/tcT92mxKx/qVq5LJz/V81cuTo=;
  b=GSJAzkR5tyG4ZJgTnxOuf6oRq51E54ZWizo8GguqiShSCeuyTXxXymSG
   TILpdMEWbIyFIisip2/Yy3fijXpJT75RgEcJMxL+m1HXnmtFrvP7UGmvf
   KXlr0kHAE+m0D3NN7EaejnlDnU3rqstbN7MXqHFgRpJZsCB5jEkYS4Wb6
   lk43DNApuasGLkTFuTZtHXPzuLsclfBf6PXntCezmj5hDFJ2AMb5Nb2ZE
   b7qCiED/npK5MJUORaf+f2XboqiGLOQcUY4C/ckLPB0TZGepHFAd+/93H
   ffPV2mRIEj+EMxfDUwXL9FsETh9optZVUq3Swv99t4JG38BaLaw+AgjG2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="126657158"
X-IronPort-AV: E=Sophos;i="6.05,216,1701097200"; 
   d="scan'208";a="126657158"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 15:13:36 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
	by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A27AED9D92
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:13:32 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id C8839E9E5A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:13:31 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6549A200A7EC8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:13:31 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id C55FB1A006A;
	Fri, 26 Jan 2024 14:13:29 +0800 (CST)
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/4] arch/x86/events/amd: Convert snprintf/sprintf to sysfs_emit
Date: Fri, 26 Jan 2024 14:13:16 +0800
Message-Id: <20240126061319.245901-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
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
X-TMASE-Result: 10--12.987700-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfvd49YGReckE1N
	J2MN+nPkgxCMf8A0YpRzqfit7JyUVv+tuWXZk8lIEVuC0eNRYvLSvRkgO4EJeqyitsTk3SfXhQ6
	YZNvnIb+UFDd5x8j8T+ZtbVQsdt0oRY1tl9vG/AZO5y1KmK5bJRSLgSFq3TnjoxCLfriDzzj3MM
	lWBma+yBbjDpwV9/AzvCUtJ1WOqj2R9GF2J2xqMxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7nPFQ
	wHIksyOc5m9VFq5Q0uFqLb56tjR38LpsAIizCmH66XHIc5w+gc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

> ./arch/x86/events/amd/core.c:1282:8-16: WARNING: please use sysfs_emit

This patch is generated by
$ make coccicheck MODE=patch COCCI=scripts/coccinelle/api/device_attr_show.cocci M=arch/x86/events/amd | sed -n '6,$p' | patch -p1

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
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: extract patch from the patch set[1] so that maintainer can accept it separately.
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 arch/x86/events/amd/core.c  | 2 +-
 arch/x86/events/amd/iommu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 81f6d8275b6b..0d520592010c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1279,7 +1279,7 @@ static ssize_t branches_show(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index b15f7b950d2e..1126bda96d8f 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -89,7 +89,7 @@ static ssize_t _iommu_event_show(struct device *dev,
 {
 	struct amd_iommu_event_desc *event =
 		container_of(attr, struct amd_iommu_event_desc, attr);
-	return sprintf(buf, "%s\n", event->event);
+	return sysfs_emit(buf, "%s\n", event->event);
 }
 
 #define AMD_IOMMU_EVENT_DESC(_name, _event)			\
-- 
2.29.2


