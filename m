Return-Path: <linux-kernel+bounces-96537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A7875DBC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CDF01F21964
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8485339A1;
	Fri,  8 Mar 2024 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gg8EQi+N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DD32C9C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876376; cv=none; b=jrMPPqBRXHVSUKpF0Ft4qd8kQzQNCiTvBTtif78DKNJEH3MprzplozowX70sqzOD3y5Irxs3TLaAMBYlTktOzZXI1V1N4pTSbthBELslW7LQBm9VDj+KcUtjYygij41FOK4R6cliXP59tWcvrhHKc5n+06EMeH6SgeFUH1sBzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876376; c=relaxed/simple;
	bh=bUAxy/8NQvatIH76qHo0YEeNSFPiiErwn7J6TdNAGp8=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=l8opOfuz7EzSOlEmLcryH6+r3INY+Y+jLxS1rF3X2Mu3PfrRru1LXlUpX6VFKCIBFrpoUuKvT1d/I12enIKE00zpzYAC3qrH5T064t3HT7M2SC8Mb4ubDV9HQEytN5qPgd3rcy7PjYPMwRw5YJZz2ZyxSeiHIXuztH7F++z7Rvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gg8EQi+N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709876374; x=1741412374;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bUAxy/8NQvatIH76qHo0YEeNSFPiiErwn7J6TdNAGp8=;
  b=Gg8EQi+Nxamecf9qPyQcZ4ZKNyjcUYAFqXEUV5uShetqVFuUTOATGjYI
   s46P+CXPB2iD8W/pZ7bxGpdmA7hhA9VxpX2EM6SDD+iPd9NULfgvs7eQX
   747zAScM6lxbMoXwQaRU8TCTO5cKQnX9ulDa5kNyFgFeaEWQovJ25PIEW
   p7rxS5Wyb6G7bEjxEp5Xu+lPopIh99DHID4Cj1LQjZoOK/6P+D1CupQND
   a9phSs6QtzcrYx3hzvImdZfIk+9d4VzmnqoDzXn/pwlGYMa7/Uw13jNGO
   L+dyvKFjMxe1zGJMU33fU7otshf3jBC8Lv8SK0o6pRpdKAwy8gcRV2J1a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4430341"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4430341"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 21:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="10243415"
Received: from mickrams-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.136.83])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 21:39:33 -0800
Subject: [PATCH] workqueue: Cleanup subsys attribute registration
From: Dan Williams <dan.j.williams@intel.com>
To: tj@kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Date: Thu, 07 Mar 2024 21:39:32 -0800
Message-ID: <170987627011.449367.8705596691078598981.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

While reviewing users of subsys_virtual_register() I noticed that
wq_sysfs_init() ignores the @groups argument. This looks like a
historical artifact as the original wq_subsys only had one attribute to
register.

On the way to building up an @groups argument to pass to
subsys_virtual_register() a few more cleanups fell out:

* Use DEVICE_ATTR_RO() and DEVICE_ATTR_RW() for
  cpumask_{isolated,requested} and cpumask respectively. Rename the
  @show and @store methods accordingly.

* Co-locate the attribute definition with the methods. This required
  moving wq_unbound_cpumask_show down next to wq_unbound_cpumask_store
  (renamed to cpumask_show() and cpumask_store())

* Use ATTRIBUTE_GROUPS() to skip some boilerplate declarations

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Tejun, just a drive-by cleanup while poking around sysfs.

 kernel/workqueue.c |   49 +++++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 7b482a26d741..7aa970b2f0d6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6208,25 +6208,27 @@ static ssize_t __wq_cpumask_show(struct device *dev,
 	return written;
 }
 
-static ssize_t wq_unbound_cpumask_show(struct device *dev,
+static ssize_t cpumask_requested_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return __wq_cpumask_show(dev, attr, buf, wq_unbound_cpumask);
+	return __wq_cpumask_show(dev, attr, buf, wq_requested_unbound_cpumask);
 }
+static DEVICE_ATTR_RO(cpumask_requested);
 
-static ssize_t wq_requested_cpumask_show(struct device *dev,
+static ssize_t cpumask_isolated_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return __wq_cpumask_show(dev, attr, buf, wq_requested_unbound_cpumask);
+	return __wq_cpumask_show(dev, attr, buf, wq_isolated_cpumask);
 }
+static DEVICE_ATTR_RO(cpumask_isolated);
 
-static ssize_t wq_isolated_cpumask_show(struct device *dev,
+static ssize_t cpumask_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return __wq_cpumask_show(dev, attr, buf, wq_isolated_cpumask);
+	return __wq_cpumask_show(dev, attr, buf, wq_unbound_cpumask);
 }
 
-static ssize_t wq_unbound_cpumask_store(struct device *dev,
+static ssize_t cpumask_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	cpumask_var_t cpumask;
@@ -6242,36 +6244,19 @@ static ssize_t wq_unbound_cpumask_store(struct device *dev,
 	free_cpumask_var(cpumask);
 	return ret ? ret : count;
 }
+static DEVICE_ATTR_RW(cpumask);
 
-static struct device_attribute wq_sysfs_cpumask_attrs[] = {
-	__ATTR(cpumask, 0644, wq_unbound_cpumask_show,
-	       wq_unbound_cpumask_store),
-	__ATTR(cpumask_requested, 0444, wq_requested_cpumask_show, NULL),
-	__ATTR(cpumask_isolated, 0444, wq_isolated_cpumask_show, NULL),
-	__ATTR_NULL,
+static struct attribute *wq_sysfs_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	&dev_attr_cpumask_requested.attr,
+	&dev_attr_cpumask_isolated.attr,
+	NULL,
 };
+ATTRIBUTE_GROUPS(wq_sysfs_cpumask);
 
 static int __init wq_sysfs_init(void)
 {
-	struct device *dev_root;
-	int err;
-
-	err = subsys_virtual_register(&wq_subsys, NULL);
-	if (err)
-		return err;
-
-	dev_root = bus_get_dev_root(&wq_subsys);
-	if (dev_root) {
-		struct device_attribute *attr;
-
-		for (attr = wq_sysfs_cpumask_attrs; attr->attr.name; attr++) {
-			err = device_create_file(dev_root, attr);
-			if (err)
-				break;
-		}
-		put_device(dev_root);
-	}
-	return err;
+	return subsys_virtual_register(&wq_subsys, wq_sysfs_cpumask_groups);
 }
 core_initcall(wq_sysfs_init);
 


