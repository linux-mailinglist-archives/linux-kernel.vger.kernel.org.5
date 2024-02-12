Return-Path: <linux-kernel+bounces-61596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BA585140A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4275328697F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FF13B79C;
	Mon, 12 Feb 2024 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5N0YQ00"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4613A8CB;
	Mon, 12 Feb 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742979; cv=none; b=rC3ntrSbZSSTKLipimGEty5/ByYzyBz6KetL1tRqRFVvxvM0peKkVp6somb7rV+614AuzWcoMQOVSbwWx8zlXong0504ESrOE0JCNHYO8WawRrn9Vl8haqPCRGP34gBXhMMELjQZlYqcaG/vBQ9ntNwtAi7CnDvbSxZReCC4l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742979; c=relaxed/simple;
	bh=B3s2F89GzkRqiCuF715R3/bfNCpfUIA+Ssd1CZYkmYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YLm4W626qoX7GHdUFK+5NUwF8vTmHWhXKIrT4XhONyuhJ1dzwNuw0gmeBwFf3RIxP1wvPaYpWCNIB8CeT/ac9y38zBnXLvKk95Eq5bqs4Yljy68yetsq9EkgtUtJqn0IWBVdg+VbOoSjQqSeqh2BUm4GFimmj1AYHEeGDjQPZVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5N0YQ00; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707742976; x=1739278976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3s2F89GzkRqiCuF715R3/bfNCpfUIA+Ssd1CZYkmYM=;
  b=c5N0YQ00+km2atJAvKL6Qz9OIf0gPKhRXUc+GEa/vVE0lXAcyrzDkeMB
   aflft9KcFCsYb2F4cwMIR37SUqR7RkdNZFmGBlo9nlkgHmJStN5fE1LWY
   Bov+ugEOMIeBPcTNbvLEs5kQGfARtZ+rrQkugC9B3O9Y9ATo6qNmHBgRf
   XfcT2YeSor9osh3vVlXLE9DDH030ksLnd8xZVdnoT4fTLThq9l+WXAd6o
   UDIjJXiaXNQGqxzrxpBXxGmmE4jECNxXZbkXGNPM/jECk5j9dtk3oV3L/
   C3Cp6D97z0UMPJDoiXynyM+eQNRva1Sz6uJDm33LLPwZVlr1CypwfBSKr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1594836"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="1594836"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:02:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="33378392"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2024 05:02:50 -0800
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 5756C1CACF;
	Mon, 12 Feb 2024 18:32:49 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 541C51600101; Mon, 12 Feb 2024 18:32:49 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: u.kleine-koenig@pengutronix.de,
	jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	lakshmi.sowjanya.d@intel.com
Cc: linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 1/5] pwm: dwc: use pm_sleep_ptr() macro
Date: Mon, 12 Feb 2024 18:32:43 +0530
Message-Id: <20240212130247.9985-2-raag.jadav@intel.com>
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

Since we don't have runtime PM handles here, we should be using
pm_sleep_ptr() macro, so that the compiler can discard it in case
CONFIG_PM_SLEEP=n.

Fixes: 30b5b066fa83 ("pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/pwm-dwc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 4929354f8cd9..a4a057ae03ea 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -120,7 +120,7 @@ static struct pci_driver dwc_pwm_driver = {
 	.remove = dwc_pwm_remove,
 	.id_table = dwc_pwm_id_table,
 	.driver = {
-		.pm = pm_ptr(&dwc_pwm_pm_ops),
+		.pm = pm_sleep_ptr(&dwc_pwm_pm_ops),
 	},
 };
 
-- 
2.35.3


