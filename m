Return-Path: <linux-kernel+bounces-132380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FA08993CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E50F28A076
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149B262BE;
	Fri,  5 Apr 2024 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7aGPwjI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA820DFF;
	Fri,  5 Apr 2024 03:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712287518; cv=none; b=QQ43/Y7xB95DLe4txi5XL36dYexxfosKH/03e/EW+n+yprTdQvLuKiClGwiAcbfoR1l7c9qdZ/hawvfQeqTG6xyzwfR301gI+J6y1lwZozUa9nP1GNwzAAAg0c3OmFFnVgL9Zqe8I49mZZOUNIG0GdpFv3KnDIh+b8bQAHtWZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712287518; c=relaxed/simple;
	bh=LSyc9Dm8TDs0NYggrHtFbz7Muqryx6ObuYUPSDrvryY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHOQEQPV2Vn9WBOXSVU2W8+10S2MpS0stmyD7CmwljQvyxWhHxbqixNH8tdXzpAeleDGsZmR2DV1Lgm4nzKcmvkyJaod7+ugN27UljVhFVK/WYH6E/7eNO3dSlpxhtRYMqywBA9rWdys/SGIW2Dw+JXcnIawCSno5Qc6w44UFP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7aGPwjI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712287517; x=1743823517;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=LSyc9Dm8TDs0NYggrHtFbz7Muqryx6ObuYUPSDrvryY=;
  b=G7aGPwjIqPY9Zb7TSkN7ftkmbutTsv8vpw2wNB8mA4alNXONZ5aTd/l8
   eCkRzM/1zY3d7lB6z59wp0IloYpXxobEfg1Lv6A5LzBMvi1CmfPvSEISI
   MQIkCxZbyuNKG3327JpYReY8R1a987YtcVqyqWtuHhfiHJIQoJfpvibNh
   OKIDsiO6RW6nFEPvha2USz+7R8xqetcqV+y7DZTkpe6q/XIf8a+28P5UN
   YZVj/DPIbx0Kl2X9tnvLudLQ+bjKQALSELV4ATnCFPk9Ddvs7NV/lNd2F
   zmaa3Scoib81hUvfXkX7TiwKiYQugbyHmZZ50vfdtuF33atPp+efiwOyu
   w==;
X-CSE-ConnectionGUID: rLtUwk1YQ5mFaoE7t+CAqg==
X-CSE-MsgGUID: /yeX4IttTaSGQz+KWwwIoA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25112470"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25112470"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:15 -0700
X-CSE-ConnectionGUID: z3NCHSYmRh2ycQ0rKiGkTA==
X-CSE-MsgGUID: tU2skXYXTOiX1DjoXaCBlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18955987"
Received: from alexpabo-mobl.amr.corp.intel.com (HELO debox1-desk4.lan) ([10.209.49.45])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 20:25:14 -0700
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH V3 6/9] tools/arch/x86/intel_sdsi: Fix meter_show display
Date: Thu,  4 Apr 2024 20:25:04 -0700
Message-Id: <20240405032507.2637311-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405032507.2637311-1-david.e.box@linux.intel.com>
References: <20240405032507.2637311-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes sdsi_meter_cert_show() to correctly decode and display the meter
certificate output. Adds and displays a missing version field, displays the
ASCII name of the signature, and fixes the print alignment.

Fixes: 7fdc03a7370f ("tools/arch/x86: intel_sdsi: Add support for reading meter certificates")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V3 - Change patch subject and changelog to clarify changes.
   - Use new BUNDLE_COUNT #def

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 29 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 7eaffcbff788..a0711177e1bb 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -153,11 +153,12 @@ struct bundle_encoding {
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
@@ -338,6 +339,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	uint32_t count = 0;
 	FILE *cert_ptr;
 	int ret, size;
+	char name[4];
 
 	ret = sdsi_update_registers(s);
 	if (ret)
@@ -379,12 +381,19 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
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
@@ -398,7 +407,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	bec = (void *)(mc) + sizeof(mc);
 
-	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
+	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
 	while (count++ < mc->bundle_length / 8) {
 		char feature[5];
 
-- 
2.34.1


