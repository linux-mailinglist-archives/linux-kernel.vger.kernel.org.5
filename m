Return-Path: <linux-kernel+bounces-84247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA4F86A423
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB4E1F23DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF572C182;
	Wed, 28 Feb 2024 00:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsDOnxB7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BCD652;
	Wed, 28 Feb 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078421; cv=none; b=Cj6vJZ1goXcOHfH8kTw0WzVhd5XKY4cokJcsjDn/WhPXzb+DMr5T0g69xEA40vAIws+ksm5M2evg8ud/YPuz1zbf84u8WunlqPJ4gSv6ipQO3Z3PCOZCyFdCbuHH70AjM863pJ4/+IjXyEUVOOi6YAmJfASfihtWy10D9k4S0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078421; c=relaxed/simple;
	bh=UkJaObiiJZKiIN9VycVTIOIbM93MxYdzndcsRLEGOWI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RjOcluMnSD5EwOfwx/7khBRI7O0856axHFc8aSSyqELH8luadk0nHsm4Bal5HG4ixOPBOJEh0TBbCj1h9LzT3TzLc0aX78Po4JR+X1Wk25vHWfLbX5JOPhl6GR0fbJ5q2AmawRIO4Sh+NZxbKqpu3YAJFbKr+eB5vn1pJVOqPrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsDOnxB7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078420; x=1740614420;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=UkJaObiiJZKiIN9VycVTIOIbM93MxYdzndcsRLEGOWI=;
  b=NsDOnxB7K2c2V6M4C472xMJgVct+0gp5RygrUW3rgrK67YzygdkeT+6s
   kHYgsObVpY3QwHh6n/6jVA5bJPp9pQ4A9KdfXQqI4vyzQHMtl6dCqAvdt
   6/0QvYj2hxUFrZ5Gyi/ryl2ImAwMtyMshtk4qoL3+cX7rFZRQWIbxeNkK
   CccUd1hJP3MtJp/b5hkou5bR6IeHmdpG6oP6Uu+hDTz0XymZkFa3HWw+x
   2o5viAOfk7Gr2NPtzK1LZ/jtF8nSNAb4GRu9pOsz06vZNJlT9p5cqe2kS
   PueHqM171YmUSu9M8AbL4LcLQB0rjA/2rdUSj8kRYFEB/Ogkj0z4M+gaS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604941"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604941"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176942"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 6E3FC580B9A;
	Tue, 27 Feb 2024 16:00:17 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 6/9] tools/arch/x86/intel_sdsi: Add missing version field
Date: Tue, 27 Feb 2024 16:00:13 -0800
Message-Id: <20240228000016.1685518-7-david.e.box@linux.intel.com>
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

Add missing 'version' field to struct meter_certificate. Also fix output
string alignment.

Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 29 +++++++++++++++++---------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index a02850a710ee..def1b9a01738 100644
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
@@ -336,6 +337,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	uint32_t count = 0;
 	FILE *cert_ptr;
 	int ret, size;
+	char name[4];
 
 	ret = sdsi_update_registers(s);
 	if (ret)
@@ -377,12 +379,19 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
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
@@ -396,7 +405,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 
 	bec = (void *)(mc) + sizeof(mc);
 
-	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
+	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
 	while (count++ < mc->bundle_length / 8) {
 		char feature[5];
 
-- 
2.34.1


