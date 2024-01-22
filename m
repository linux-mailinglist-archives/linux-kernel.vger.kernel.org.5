Return-Path: <linux-kernel+bounces-32292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EAA835992
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06A5F1F22E16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C2453A7;
	Mon, 22 Jan 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="laj4Elr3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82311C2D;
	Mon, 22 Jan 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705892577; cv=none; b=Zm5uAnyJHlMrNADtV7x4o5jy7lIHMw68yXfigQ1ywHPotUPsToPRi6bBtsg30GOyESvIO6KVHNQaf8CbUz9u5Nbv8mpU9iehDoU/2ltyBd9YcTdLKDMO9V59gq6DPplU30ZLzivK8njyHRTpKeEqh7TOWS2pU2uauou66zt6gAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705892577; c=relaxed/simple;
	bh=UuttBsPusSkviTtBaHGivf1p+uWZkhK/ocLzEpk1Ga8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIy3IV8LFWEBBZVQMRZ4TBJ5WJV34zP1fZCz0tSxtNwv4kgBQp1O7fml7e3oFDMV6Elsai/29YMfkWHM9gs2Q7MiUwV0TTJ3z8v6xSAr8K3thcNwwMDzrtUcyUoNteYnoEUVHrtnSsuuyeied1zhcqtOQPv0QLyM/gPCDwH5GGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=laj4Elr3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705892576; x=1737428576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UuttBsPusSkviTtBaHGivf1p+uWZkhK/ocLzEpk1Ga8=;
  b=laj4Elr3fcK/EpsHwn8MzfDzA/el9TQcL0JyECVpqf0KtfSX0081c6k/
   g6Z+8iUL5ER7fPAOqNk8AqqMjGlF3Gz4xbDBbMoZ97mrpMTgXZIchFH1i
   1RWqk9CNt+mlec+Dyn1gx1ZbBWwEX7MBTyWg5k09o56CjoNEE7W5GmcBQ
   K6cVzo0854bcT2/lBI+1WfBRbHtOq1qepcPJACKJdF1GGERVw2y7hlpWl
   QpAMbusTw7OatowXpQRf7LGq5pMz79URRbLIsPhmTsv9ckGMFz/jDVI1a
   0zE+KKmJmNqa+oFa99WLsh5fIQ/YM1zzjMtIQiA8eEvlVMmGtHs3ZJWFf
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="14607325"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="14607325"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 19:02:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1085523"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2024 19:02:42 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 21851484E;
	Mon, 22 Jan 2024 08:32:41 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 1F34B1600100; Mon, 22 Jan 2024 08:32:41 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 3/3] pwm: dwc: use to_pci_dev() helper
Date: Mon, 22 Jan 2024 08:32:38 +0530
Message-Id: <20240122030238.29437-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240122030238.29437-1-raag.jadav@intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use to_pci_dev() helper to get pci device reference.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 8f8035b047c1..f5fcea4e69e2 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -100,7 +100,7 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 
 static int dwc_pwm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
 	int i;
 
@@ -120,7 +120,7 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
 	int i;
 
-- 
2.35.3


