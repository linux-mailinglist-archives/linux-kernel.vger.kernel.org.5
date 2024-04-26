Return-Path: <linux-kernel+bounces-159387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C5C8B2E05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2DA1F22504
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2A8184F;
	Fri, 26 Apr 2024 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+KHdS+s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F2365;
	Fri, 26 Apr 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091278; cv=none; b=nZo4g+fb9q1PyhJAnZbjz9ngtMdhG8PyTjR/F3DYZ2IhVx0Tfjl4kNL0km00WalzQdSl7lU9AStmaa/L+36cJuWK7Wx0hoJKTli3uWQklb4I/yAQqx9PMIY6OTkw/IJTUfEiqvbEvIUoASGCaj2Zahx7ZPFwRUSlwyBrBrNcYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091278; c=relaxed/simple;
	bh=5wUjyaLOjLlce2+odKbeoEuknmweqfQnjGisatOGGFs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYBptWrZ7hzWL6v3Kep1WfnDhkXgdEJ+a+mc24ZFSpdYlTKuHlkAXVX+oHceJ+nFaIsjF/IklXT2dHu+79eRcAB9UBOTo2GfTe+Exka+lsw29/nrxqWGN3j0fl0h0YsYqdEO8HjwQhU3uuzOkg/3u5a/IG6PoDHfyiAmrJWoXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+KHdS+s; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714091277; x=1745627277;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=5wUjyaLOjLlce2+odKbeoEuknmweqfQnjGisatOGGFs=;
  b=K+KHdS+sJzL4JEBqdjXjGhuRrLZbuqgZ9SCcBQA8Xk0BWpnfZlfHIegi
   fwPyqGGEfg3fBIT01xLjAp7cJWEagO+K+X3e+mzDKSORI4dtm6QgAD6hY
   sALjHQHPT9HazSk9WqfV9e7Y9zVBVqRxRRHpykCFRkIcaTzz/tfWG6AuR
   IdNYYQQV1bj+sjiHv0V+Z6yGxoo7phX7KwOQXVf+C5xWgDNfj28SauUSL
   za9fpSDbVYQ3L2wZ3N0dRa43udatfZ52LgbhBl7Ae0AJqwgc3SzOu0bdS
   VLgXnqg3Xa51WzN9HMOWakxwQ88LBQtV0jdkpuS7PQdP5v4hVJouRsaPW
   g==;
X-CSE-ConnectionGUID: No76uRTTTuCsic2+GEfMGw==
X-CSE-MsgGUID: kyGRRegPRe2x7hs224Bvow==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="9650241"
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="9650241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:56 -0700
X-CSE-ConnectionGUID: GxcdTrErSAOrzb6tgg9pfg==
X-CSE-MsgGUID: MLE47eiOSX2BTy7UqHrCLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,230,1708416000"; 
   d="scan'208";a="25329110"
Received: from breannah-mobl.amr.corp.intel.com (HELO xpardee-test1.hsd1.or.comcast.net) ([10.209.32.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:27:55 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] platform/x86:intel/pmc: Update LNL signal status map
Date: Thu, 25 Apr 2024 17:27:50 -0700
Message-Id: <20240426002752.2504282-2-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
References: <20240426002752.2504282-1-xi.pardee@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Xi Pardee <xi.pardee@intel.com>

Update Lunar Lake signal status map. This status map has been updated
since the map was merged. This patch updates the signal status map to
the lastest version.

Signed-off-by: Xi Pardee <xi.pardee@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/core.h |  1 +
 drivers/platform/x86/intel/pmc/lnl.c  | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index 83504c49a0e3..18ba4f901c10 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -537,6 +537,7 @@ extern const struct pmc_bit_map lnl_vnn_misc_status_map[];
 extern const struct pmc_bit_map *lnl_lpm_maps[];
 extern const struct pmc_bit_map lnl_pfear_map[];
 extern const struct pmc_bit_map *ext_lnl_pfear_map[];
+extern const struct pmc_bit_map lnl_signal_status_map[];
 
 /* ARL */
 extern const struct pmc_bit_map arl_socs_ltr_show_map[];
diff --git a/drivers/platform/x86/intel/pmc/lnl.c b/drivers/platform/x86/intel/pmc/lnl.c
index ec89e7dda103..82c881653f86 100644
--- a/drivers/platform/x86/intel/pmc/lnl.c
+++ b/drivers/platform/x86/intel/pmc/lnl.c
@@ -317,6 +317,26 @@ const struct pmc_bit_map lnl_clocksource_status_map[] = {
 	{}
 };
 
+const struct pmc_bit_map lnl_signal_status_map[] = {
+	{"LSX_Wake0_STS",                BIT(0)},
+	{"LSX_Wake1_STS",                BIT(1)},
+	{"LSX_Wake2_STS",                BIT(2)},
+	{"LSX_Wake3_STS",                BIT(3)},
+	{"LSX_Wake4_STS",                BIT(4)},
+	{"LSX_Wake5_STS",                BIT(5)},
+	{"LSX_Wake6_STS",                BIT(6)},
+	{"LSX_Wake7_STS",                BIT(7)},
+	{"LPSS_Wake0_STS",               BIT(8)},
+	{"LPSS_Wake1_STS",               BIT(9)},
+	{"Int_Timer_SS_Wake0_STS",       BIT(10)},
+	{"Int_Timer_SS_Wake1_STS",       BIT(11)},
+	{"Int_Timer_SS_Wake2_STS",       BIT(12)},
+	{"Int_Timer_SS_Wake3_STS",       BIT(13)},
+	{"Int_Timer_SS_Wake4_STS",       BIT(14)},
+	{"Int_Timer_SS_Wake5_STS",       BIT(15)},
+	{}
+};
+
 const struct pmc_bit_map *lnl_lpm_maps[] = {
 	lnl_clocksource_status_map,
 	lnl_power_gating_status_0_map,
@@ -331,7 +351,7 @@ const struct pmc_bit_map *lnl_lpm_maps[] = {
 	lnl_vnn_req_status_2_map,
 	lnl_vnn_req_status_3_map,
 	lnl_vnn_misc_status_map,
-	mtl_socm_signal_status_map,
+	lnl_signal_status_map,
 	NULL
 };
 
-- 
2.34.1


