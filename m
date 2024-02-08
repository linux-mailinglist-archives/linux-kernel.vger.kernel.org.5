Return-Path: <linux-kernel+bounces-57546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BA84DA8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6121F242C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB126A328;
	Thu,  8 Feb 2024 07:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8lBdqOS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E319C6997B;
	Thu,  8 Feb 2024 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375949; cv=none; b=YnWe5VIFmdr064f+w8rGhjCuOgCeh7eNVbweTezsjBTZr4/fCoDUVaFy4FP/BJW6fgoxHrUL7lyO973XSP/8TfAZ6iangsAj4D27/lznb3AaEjCil6K6j8Rqq/0oAsJHOjTeDUeVZvRycLiSd+jrVcyTgpdPu+9Wojl8hxtfaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375949; c=relaxed/simple;
	bh=zYJsF8OpWc7dj9/OozfDPc9dxuZGaqWmvnyjlLvPRpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8vTv5Ueh9d97Jxb577lINA4NVq9382m563xq1sz/4lDDxwYjACjDzqRdUMzAxDGb8Kopeq5f/mzxJV7U0hWnl6VmKbHIus6Wo6H29MgyKtr53VKZGLwe+ryxCovS3DLowN8RhzGKf3olsOaV6e/ful2jF5gZbgowGcA/HsnJBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8lBdqOS; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707375948; x=1738911948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYJsF8OpWc7dj9/OozfDPc9dxuZGaqWmvnyjlLvPRpo=;
  b=B8lBdqOSWHEkBo5YhmwpXLUyWL9B3OUOTYINxVfJUiHtUZjnYthjjDJH
   RQ4kR1UycEw0REMYof5Mj+wdbUG9pcxpsz9yiruxTbBssDMvMwvEfBNNY
   j2YE9nSf9gA1uHZ2jfz6oRTuqbPzDrVL3So5XnOeKaIEJKht8s61UGA2N
   hngO4ZNLWYkihwpSX9nBDp8VjScA6TqbHWIcEEkLH73EjdM+Bi8371Qt1
   zMknz4+kOqxue7xZBgogfnMJJB6gsn8HEyEKcajo4FjUP7OBdiF/3YVKV
   Ec+E+fZ6cGNoHE5ya+g+15+tlJHnUNfzEEMeXpSnu0IgBfG0CSqqh/zUk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12525875"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12525875"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 23:05:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1573972"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by fmviesa007.fm.intel.com with ESMTP; 07 Feb 2024 23:05:38 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 57D8B4841;
	Thu,  8 Feb 2024 12:35:35 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 578F41600100; Thu,  8 Feb 2024 12:35:35 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 5/5] pwm: dwc: use pm_sleep_ptr() macro
Date: Thu,  8 Feb 2024 12:35:29 +0530
Message-Id: <20240208070529.28562-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240208070529.28562-1-raag.jadav@intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we don't have runtime PM handles here, we should be using
pm_sleep_ptr() macro, so that the compiler can discard it in case
CONFIG_PM_SLEEP=n.

Fixes: 30b5b066fa83 ("pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/pwm/pwm-dwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index cc5bba977f47..bb39cc34f895 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -127,7 +127,7 @@ static struct pci_driver dwc_pwm_driver = {
 	.remove = dwc_pwm_remove,
 	.id_table = dwc_pwm_id_table,
 	.driver = {
-		.pm = pm_ptr(&dwc_pwm_pm_ops),
+		.pm = pm_sleep_ptr(&dwc_pwm_pm_ops),
 	},
 };
 
-- 
2.35.3


