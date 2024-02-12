Return-Path: <linux-kernel+bounces-61592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C1851403
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5923D1F2645F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF193A8E0;
	Mon, 12 Feb 2024 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="klqEjlbh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03323A28B;
	Mon, 12 Feb 2024 13:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742976; cv=none; b=jzAvhBHdzFDx/OqWC5DK7U1QF4tMIiCmJltiLJUd9yYIG1OefP+s+33dRv8EmV1EFcLxGnb3mLCqBBcZPdT0qYUPt2QIiZakBWSG5MAM0pDaNxwggPmb61wrTNYuSkU5qVqvT98G1kdDh4QDG19q/+pqmcbXWFhzvh3fgizpckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742976; c=relaxed/simple;
	bh=uje6c8I2tiqtfUYQ+9jgDQlGSSLDu0ZZYftu8pHhS3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNIW3EJALMYPLiOZMBk8FS8SVybJpI0VFnYkcJLQFS5JsQ17fk2a3bAvhigQnyNAQ7ZKDl4pXXxgyBxgUY8ABnk/+IIJM5gieZHhnap+9a/+ZmmcrbupjD2Gu50XwgcjfKT7FsJwDw6+6tle2DchhZ5cDFO9fQMBFWKxBKkjQiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=klqEjlbh; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742975; x=1739278975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uje6c8I2tiqtfUYQ+9jgDQlGSSLDu0ZZYftu8pHhS3M=;
  b=klqEjlbhGogFUcn0Ao2WhRGI1+6gA6qDJaPBUUfYKTYLG9yXDPJ+ZiBG
   NTt2RBvWZH1R85I5nL36AcQFSbqcPpaS4bNaV6jcgNTDfn2lZQqKSU3bx
   Fa72xmPrbWREqwiM9CfG8xiXtRgkd61V6gZcD3tEgaTaLe2HiOqis43nE
   Hfqgz740ig0Vnh4XQV1fqsDrf/T6mXEH3KKqS7AVTwQuhnJ6gQGubsLTH
   YBwYu+rTdFl0Q3HmKiWlR4uBYvT36dX0Z0ICa7YDokHN52B0MAOT+FWZo
   CoT3T+u0XtLWyZVVf3oSYD1/5PTsuuDICgTt5Gfkx9h8d2qEYpM8kV9V6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1594832"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1594832"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33378387"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 05:02:50 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 59E3D1CAD1;
	Mon, 12 Feb 2024 18:32:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 56F421600105; Mon, 12 Feb 2024 18:32:49 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 5/5] pwm: dwc: access driver_data using dev_get_drvdata()
Date: Mon, 12 Feb 2024 18:32:47 +0530
Message-Id: <20240212130247.9985-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240212130247.9985-1-raag.jadav@intel.com>
References: <20240212130247.9985-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we're setting driver_data using dev_set_drvdata(), we can use
dev_get_drvdata() for accessing it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 56fac8655c7b..ed56b796b670 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -82,8 +82,7 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 
 static int dwc_pwm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
@@ -102,8 +101,7 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct dwc_pwm *dwc = dev_get_drvdata(dev);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-- 
2.35.3


