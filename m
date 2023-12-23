Return-Path: <linux-kernel+bounces-10261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA581D1DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005F71C22C58
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B99610B;
	Sat, 23 Dec 2023 03:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBb3nfU4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7DA1110;
	Sat, 23 Dec 2023 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703301953; x=1734837953;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=ncqZrSwEdBCXtxvWbb1V+l2i5EjB3nBI2XKvixmXGNI=;
  b=nBb3nfU4uNCELjgufIi6VlJokgtguxc46sJskJty0mwJS3e4r4J17emJ
   1bYXY94XeNg74NO9+WAxEpIHDJN4sZ2ui92Ms3slU+PBjvot8PjMq/yv7
   S4GlZH/LL1uANKgzarxsEw1iVb0kRMgtYXLXnhPt1268XiaoV917vwWlL
   S/VYBXE4Yx1SdbyxkOMLMO5lbB0A8SK7GgJL/eAKfP1BnYtWmeVL75vct
   3KZ3/+VAV32aas07B2jj4OPQEcAdlkgB/PYfgsEHTZfptGAd2mWdrjS5x
   neTp8BqmZsYxNwSnc2kDHb8OQlmWZCZ6vzdmxHliINhdqiSWExpY71TOI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462619292"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="462619292"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811534582"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; 
   d="scan'208";a="811534582"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 19:25:52 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.110])
	by linux.intel.com (Postfix) with ESMTP id 5726F580DDD;
	Fri, 22 Dec 2023 19:25:52 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] platform/x86/intel/pmc/arl: Add GBE LTR ignore during suspend
Date: Fri, 22 Dec 2023 19:25:46 -0800
Message-Id: <20231223032548.1680738-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231223032548.1680738-1-david.e.box@linux.intel.com>
References: <20231223032548.1680738-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the GBE LTR ignore suspend time fix for Arrow Lake.

Fixes: f34dcf397286 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmc/arl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
index 31e1fa538e32..ae3a9a96f845 100644
--- a/drivers/platform/x86/intel/pmc/arl.c
+++ b/drivers/platform/x86/intel/pmc/arl.c
@@ -685,6 +685,8 @@ void arl_d3_fixup(void)
 int arl_resume(struct pmc_dev *pmcdev)
 {
 	arl_d3_fixup();
+	pmc_core_send_ltr_ignore(pmcdev, 3, 0);
+
 	return pmc_core_resume_common(pmcdev);
 }
 
@@ -696,6 +698,7 @@ int arl_core_init(struct pmc_dev *pmcdev)
 	bool ssram_init = true;
 
 	arl_d3_fixup();
+	pmcdev->suspend = cnl_suspend;
 	pmcdev->resume = arl_resume;
 	pmcdev->regmap_list = arl_pmc_info_list;
 
-- 
2.34.1


