Return-Path: <linux-kernel+bounces-4670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F284C818077
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A89611F24BC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70706BE59;
	Tue, 19 Dec 2023 04:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhRV1KcG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083963AC;
	Tue, 19 Dec 2023 04:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702959755; x=1734495755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FWm7knnCNk3XzYwemNuQu99HK/VR/XFfS7auE+Dgc0=;
  b=QhRV1KcGmCI9IYvbG0OqXp+kv02p89KuldJRRQH5xpGbWEzWp6ekTnGj
   EkiRHgmDeKxPD+4WuzFjvfYpQQ9191o1d9+mhCb94KV9OwaTcw9bjT7KQ
   T34wCsz6uuKkAX6ircDM3ocbhG4gq9bizRX+sQSMJtr++f4EEj3Pv7w8f
   cLT6cpRFm7QI4NQAcVXx7ef3HHf/jmOg3lZ8jSfjDjxc09cdoR4Ez/V4Y
   rOun/zW3y4JKPzUeZQJ+Cn6X+mHDtfz1JAhTiZzL0N0ys5FZ+OSVHqmpg
   Y07lN/08q1TIdgWGkkZXDQC8E/ABIgzVTzytqlEM2JmBCKmMmt/fl6O6S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="2455982"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="2455982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="919503108"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="919503108"
Received: from mnichels-mobl1.amr.corp.intel.com (HELO rjingar-desk5.intel.com) ([10.212.29.225])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 20:22:30 -0800
From: rjingar <rajvi.jingar@linux.intel.com>
To: irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: rajvi.jingar@linux.intel.com
Subject: [PATCH 4/8] platform/x86/intel/pmc: Add PSON residency counter for Alder Lake
Date: Mon, 18 Dec 2023 20:22:12 -0800
Message-Id: <20231219042216.2592029-4-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
References: <20231219042216.2592029-1-rajvi.jingar@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajvi Jingar <rajvi.jingar@linux.intel.com>

Add PSON register offsets for Alder Lake PCH that provides an access to
PSON residency counter.

Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/adl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/adl.c b/drivers/platform/x86/intel/pmc/adl.c
index 64c492391ede..882f2d5d8937 100644
--- a/drivers/platform/x86/intel/pmc/adl.c
+++ b/drivers/platform/x86/intel/pmc/adl.c
@@ -307,6 +307,8 @@ const struct pmc_reg_map adl_reg_map = {
 	.lpm_sts = adl_lpm_maps,
 	.lpm_status_offset = ADL_LPM_STATUS_OFFSET,
 	.lpm_live_status_offset = ADL_LPM_LIVE_STATUS_OFFSET,
+	.pson_residency_offset = TGL_PSON_RESIDENCY_OFFSET,
+	.pson_residency_counter_step = TGL_PSON_RES_COUNTER_STEP,
 };
 
 int adl_core_init(struct pmc_dev *pmcdev)
-- 
2.34.1


