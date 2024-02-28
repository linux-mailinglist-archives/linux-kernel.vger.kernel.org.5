Return-Path: <linux-kernel+bounces-84251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158B886A42D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F77287D85
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C101D364;
	Wed, 28 Feb 2024 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIbMAkyI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE091CF9A;
	Wed, 28 Feb 2024 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078422; cv=none; b=hyw2eVZeYRd6HzrXbVpkN4vwmhpR60sMrGFXwg2VjmoRs2i195LuLJJUWzCjejigHWSLTGuBV+T8Um9T98ZuQ8fWBpKTQltbB8jBkEROMkaA8Wi5gSRuX84KZ5q9LskZ5gVLHF+4b3wEBweFUdUClaS0pM7kOzxNSOEhLAoQUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078422; c=relaxed/simple;
	bh=Xrls4UpurhgVy6jk7w6ROuUCyAmG1GzPqDtSTrya6q4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l29KhKR5AfCwhB42503ujjekWjn4oX8WjMo/wTILr4SI5XLhlm2tE75mHNni9ZC6WJxZoiGlNDVrJp1yEJFFjw4JiZCOVpUdHKms2OTvnblPjBiOTgFqhnHXUs35T0oYkSsIqThmKg5dAhzWyq8INEpopK4uSBJMUIrvqU4W5LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIbMAkyI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078422; x=1740614422;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Xrls4UpurhgVy6jk7w6ROuUCyAmG1GzPqDtSTrya6q4=;
  b=KIbMAkyIzOYE35LxiY0wCShMOOK1LjvEVhdbE+Xw2uRnOrmwboUBsiz7
   so5VFJPavYtPMRjocQa3pC23F1xlD2X0dAgMlCp7AXuEIE3cY2fjJiJuv
   DZjn82PSIdl5m25qs/GAncDS+OFwn7choqO5ZtRuG7Vkjasr9X4hHtDOV
   GtSC6L7JHQZcSase8NdgH2EMAIwozUE7JdRoxg51vNx/oTlc2fTDxPm7k
   n7Rss5eRr9OoH6u7j+yZGXrfAKDAEERSk6xaXD/5VDRXxZfvx0zZD1DSj
   ZzDtkSnJR8QOJinbJngAxQWogAnmhzBmSUpq5sT1Oe1Rn5tgnUoCeRAnO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604944"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604944"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176943"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id D2EAF580D7F;
	Tue, 27 Feb 2024 16:00:17 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 8/9] platform/x86/intel/sdsi: Simplify ascii printing
Date: Tue, 27 Feb 2024 16:00:15 -0800
Message-Id: <20240228000016.1685518-9-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use printf width specifier to set the display length of encoded feature
names.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2acc6be5f5d6..a8fb6d17405f 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -407,11 +407,10 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
 	while (count < mc->bundle_length / 8) {
-		char feature[5];
+		char feature[4];
 
-		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
-		printf("    %s:          %d\n", feature, bec[count].counter);
+		printf("    %.4s:          %d\n", feature, bec[count].counter);
 		++count;
 	}
 
@@ -492,7 +491,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 			sizeof(*lki) +			// size of the license key info
 			offset;				// offset to this blob content
 		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
-		char feature[5];
+		char feature[4];
 		uint32_t i;
 
 		printf("     Blob %d:\n", count - 1);
@@ -505,11 +504,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 		printf("        Blob revision ID:           %u\n", lbc->rev_id);
 		printf("        Number of Features:         %u\n", lbc->num_bundles);
 
-		feature[4] = '\0';
-
 		for (i = 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); i++) {
 			get_feature(bundle[i].encoding, feature);
-			printf("                 Feature %d:         %s\n", i, feature);
+			printf("                 Feature %d:         %.4s\n", i, feature);
 		}
 
 		if (lbc->num_bundles > STATE_MAX_NUM_IN_BUNDLE)
-- 
2.34.1


