Return-Path: <linux-kernel+bounces-47476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5A1844E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350001F247DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89A53D0A3;
	Thu,  1 Feb 2024 01:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANK1vD7B"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2043A1A8;
	Thu,  1 Feb 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749675; cv=none; b=ivC254vP99tbBkZGcddMtM0edPaxjNt0Thq0th9xnzIa4UKqgM/47ExNDdjv1RmEwnClyKvsGJO+qp3u75g0IEmcRbXQ6/EiNTmYQ5K5TSDh3VCkQltRah0Wb0nah7D6gXsyosxNXkdkxyrPhS35It+IffO0vc6ceqTjiOv4Vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749675; c=relaxed/simple;
	bh=ZmlyHYXBVtbijbrpUOF8yDi/v2bX8+Dqf/m3Q2yqn+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKTLkHxcUYS//0A4etslOOWwuj0SnmP0+yoqOk0wYw+0jaHtXyvfOKQ/NlmHzFDqFwqNVydBB/VXJP6WEhajug7NKNZzfHMcaXsNseAeaizqxG/6Cwoq4AjN2AurOTk2xXjEftTDqgHv1E4c9EYVqtMrM8uvo9xvMnhUYYE5H98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANK1vD7B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749674; x=1738285674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZmlyHYXBVtbijbrpUOF8yDi/v2bX8+Dqf/m3Q2yqn+U=;
  b=ANK1vD7Bh4th1iRA9MovMWBkK/KAoHfXnYAEH4SraUZAmGbuQ1DvBD/8
   WLk0HDNMQYEgD6XbkCMKgTGHTXfxMlb8caZ8aBXUNryYZ13EIaArxjlhk
   iuUU588xRy9jlZdAysUBW0i0LRTPmQAA5a3MBYoWC8nxhjiQXPXxaw4F7
   0AJSvmClIse2S/3NrW9o+9NhaPe3S/V2XuFo7zebkeUgBfdDnQ0uLLZTL
   xb4NdXk2mSFjD5vWqt7h9Q99MqJC5MOtcAE5EwlDHalnyuWh4sPEVRsmN
   rNbwxNLon+Gt1Ue8lJNIDoUDq4Z2LctXu7uwDeoYB37FsRoid75VEtxED
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11145825"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="11145825"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="37057420"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id 8306F580201;
	Wed, 31 Jan 2024 17:07:49 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 7/8] tools: Fix errors in meter_certificate display
Date: Wed, 31 Jan 2024 17:07:46 -0800
Message-Id: <20240201010747.471141-8-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The maximum number of bundles in the meter certificate was hardcoded to
8 which caused extra bundles not to display. Instead, since the bundles
appear at the end of the file, set it to the remaining size from where
the bundles start.

Add missing 'version' field to struct meter_certificate.

Fix errors in the calculation of the start position of the counters and
in the display loop.

Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 tools/arch/x86/intel_sdsi/intel_sdsi.c | 51 +++++++++++++++-----------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..a8fb6d17405f 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -43,7 +43,6 @@
 #define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
-#define METER_MAX_NUM_BUNDLES	8
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -154,11 +153,12 @@ struct bundle_encoding {
 };
 
 struct meter_certificate {
-	uint32_t block_signature;
+	uint32_t signature;
+	uint32_t version;
+	uint64_t ppin;
 	uint32_t counter_unit;
-	uint64_t ppin;
 	uint32_t bundle_length;
-	uint32_t reserved;
+	uint64_t reserved;
 	uint32_t mmrc_encoding;
 	uint32_t mmrc_counter;
 };
@@ -167,6 +167,9 @@ struct bundle_encoding_counter {
 	uint32_t encoding;
 	uint32_t counter;
 };
+#define METER_MAX_NUM_BUNDLES							\
+		(METER_CERT_MAX_SIZE - sizeof(struct meter_certificate) /	\
+		 sizeof(struct bundle_encoding_counter))
 
 struct sdsi_dev {
 	struct sdsi_regs regs;
@@ -334,6 +337,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	uint32_t count = 0;
 	FILE *cert_ptr;
 	int ret, size;
+	char name[4];
 
 	ret = sdsi_update_registers(s);
 	if (ret)
@@ -375,32 +379,39 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	printf("\n");
 	printf("Meter certificate for device %s\n", s->dev_name);
 	printf("\n");
-	printf("Block Signature:       0x%x\n", mc->block_signature);
-	printf("Count Unit:            %dms\n", mc->counter_unit);
-	printf("PPIN:                  0x%lx\n", mc->ppin);
-	printf("Feature Bundle Length: %d\n", mc->bundle_length);
-	printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
-	printf("MMRC counter:          %d\n", mc->mmrc_counter);
+
+	get_feature(mc->signature, name);
+	printf("Signature:                    %.4s\n", name);
+
+	printf("Version:                      %d\n", mc->version);
+	printf("Count Unit:                   %dms\n", mc->counter_unit);
+	printf("PPIN:                         0x%lx\n", mc->ppin);
+	printf("Feature Bundle Length:        %d\n", mc->bundle_length);
+
+	get_feature(mc->mmrc_encoding, name);
+	printf("MMRC encoding:                %.4s\n", name);
+
+	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
 	if (mc->bundle_length % 8) {
 		fprintf(stderr, "Invalid bundle length\n");
 		return -1;
 	}
 
 	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
-		fprintf(stderr, "More than %d bundles: %d\n",
+		fprintf(stderr, "More than %ld bundles: actual %d\n",
 			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
 		return -1;
 	}
 
-	bec = (void *)(mc) + sizeof(mc);
+	bec = (void *)(mc) + sizeof(*mc);
 
-	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
-	while (count++ < mc->bundle_length / 8) {
-		char feature[5];
+	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
+	while (count < mc->bundle_length / 8) {
+		char feature[4];
 
-		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
-		printf("    %s:          %d\n", feature, bec[count].counter);
+		printf("    %.4s:          %d\n", feature, bec[count].counter);
+		++count;
 	}
 
 	return 0;
@@ -480,7 +491,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
 			sizeof(*lki) +			// size of the license key info
 			offset;				// offset to this blob content
 		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
-		char feature[5];
+		char feature[4];
 		uint32_t i;
 
 		printf("     Blob %d:\n", count - 1);
@@ -493,11 +504,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
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


