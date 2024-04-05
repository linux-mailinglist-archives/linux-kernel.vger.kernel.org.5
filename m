Return-Path: <linux-kernel+bounces-133490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786F89A476
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88ABE1C22918
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F835173320;
	Fri,  5 Apr 2024 18:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JS5uJ+KZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC13172BB5
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343457; cv=none; b=bI3w4Bkd/4deIUSk7ig7oGoT407mqoIBNRrk8AYTMrR2Nnxa7fGuk6iiVI29zd8FUoADw+xl2/QBVHAmUwRoA+FYZwggwwF//ZQGSTPUU+e+MXfrpqgzSHeqLDWP0K8WvaLogCjPC/qiwDhPFltlpMNYmgvhySLgNrR4RQAAq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343457; c=relaxed/simple;
	bh=WJe3dgB0WvVHGTd0bDMt0olEoE3Xv3pzesF58nyistQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5LvgCmGpsCOmDhG0JkjSSA/YLShzR34See6b16LYx0SGYEgu0YXo/WMmb4V49zb9DCPAIdXr9VGZkqw/BTQHpZs5brIvloDl5FHLZ2jiMydmSGtD2iXeg7y65tpb5NVjiC2JRC5Y1F9cA9R3grsOAQcISOavqsuCVclo4tT1IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JS5uJ+KZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712343456; x=1743879456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WJe3dgB0WvVHGTd0bDMt0olEoE3Xv3pzesF58nyistQ=;
  b=JS5uJ+KZ7PsG5OnUWYNKvkmOafRQf+wFID9hrin8mNwP7atqcENexmd9
   jgt2ghzBgmhozeEsyC5kdZ8oivuRBTKwMlV+HwcijiAkTz7gKe3g32sZv
   kSJD1Wyhmm8w44wNXY7iJNqzOYr0lo3YPfdbsMRKFOVga1Tc3L+jImbsO
   2lSd1raCZwBZ8MkZyNwBITHiehQQLWhLnfQlDO3WRR2B/7ZHchj2b++kt
   XBp86/y1MT+xK8eA9qUVCuPI+0ywtwUrG8vU9mjNP3NAtXOh3BwjdCQhC
   o2N869LSK/N2MEYBpap/Lf/4lUk/r+/IWk4TktSRtYDYTVJlTgbEXBPIt
   w==;
X-CSE-ConnectionGUID: FjLefSmtQ4q3aXilQDhU3A==
X-CSE-MsgGUID: UaSZOJZmSvqkNkovVtt4kQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7588308"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7588308"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 11:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="937088095"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="937088095"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 05 Apr 2024 11:57:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 0CA72F4; Fri,  5 Apr 2024 21:57:31 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] genirq: Update MAINTAINERS to include IRQ related header files
Date: Fri,  5 Apr 2024 21:56:45 +0300
Message-ID: <20240405185726.3931703-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240405185726.3931703-1-andriy.shevchenko@linux.intel.com>
References: <20240405185726.3931703-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IRQ related header files seems orphaned, add them to the respective
subsystem records.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997ebd1ae474..92d57c3782f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11517,6 +11517,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
 F:	include/linux/irqdomain.h
+F:	include/linux/irqdomain_defs.h
 F:	kernel/irq/irqdomain.c
 F:	kernel/irq/msi.c
 
@@ -11526,6 +11527,10 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	include/linux/group_cpus.h
+F:	include/linux/irq.h
+F:	include/linux/irqhandler.h
+F:	include/linux/irqnr.h
+F:	include/linux/irqreturn.h
 F:	kernel/irq/
 F:	lib/group_cpus.c
 
@@ -11536,6 +11541,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/devicetree/bindings/interrupt-controller/
 F:	drivers/irqchip/
+F:	include/linux/irqchip.h
 
 ISA
 M:	William Breathitt Gray <wbg@kernel.org>
-- 
2.43.0.rc1.1.gbec44491f096


