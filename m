Return-Path: <linux-kernel+bounces-84249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFA86A42B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B9D282E7B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59CC2E645;
	Wed, 28 Feb 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnzX7nR4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDD79ED;
	Wed, 28 Feb 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078422; cv=none; b=PQkSNA13/uN46Q1CUxPuvPki8t58TWq8c5pquhjSATWCjKFxRn1+Wc9ipvUR9gWb+duIKsDXxLRhi2NjGklMj1kEh42faudjVg4v+Agn7IY5DFSKEAB0w7rYzThrEgHWewrUgwpVFmriYwmPFphFpNGy+ZshjYmr3fNfOspRFsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078422; c=relaxed/simple;
	bh=+Z7En2HDO6d1w36dnpCFtmIvi6nCJV8wICBRrJL4X00=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tg1kJfx10ot3u34FTyO3lHrsDEZEV2KdRLYjmhZaVgQ1Ohq+n0wPqw7gDEdsE5tTV/yHPDxw8MeahW717p9NVq/axQEYHGuIVKKrR8WdsBqtPpBDVmvl3qJLdwFYHw/NVJL3dHls5AloLz3630obkPFdzAduEj4iLERXC2FT820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnzX7nR4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078421; x=1740614421;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+Z7En2HDO6d1w36dnpCFtmIvi6nCJV8wICBRrJL4X00=;
  b=WnzX7nR4+nbl8VnWWTRNIvZ4BHSSxR53I/wpeNrT0IZ/4Zq1h7DPE2cL
   K2tGY/5I/xOSMVAP1C/yKI2Yy81Jih0sqJPIz7M9GTS9PHL7N2NFAIHm2
   txioPC+7rLf8N7il5ma8Abc2G/lAaZOjOS+ebxwdYlNujT4xMwJgZA+ki
   LSja9S5ZspMZ3f97D0rZ0MFgjZbh9vWgqBkrIf+BDhytVh3xNq0mBuplk
   kq6sxgFtK7Emak0am1bagX6UCBvvFGDy5REmjsYoI2OvQByUlDxahvKna
   7JIIauKckHcKr67Qki688M0gnvycJ23Q2Es7COtjGbpylEzfpZTMqxhkg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604939"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604939"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176941"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 406A6580B9A;
	Tue, 27 Feb 2024 16:00:17 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 5/9] tools/arch/x86/intel_sdsi: Fix maximum meter bundle length
Date: Tue, 27 Feb 2024 16:00:12 -0800
Message-Id: <20240228000016.1685518-6-david.e.box@linux.intel.com>
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

The maximum number of bundles in the meter certificate was set to 8 which
is much less than the maximum. Instead, since the bundles appear at the end
of the file, set it based on the remaining file size from the bundle start
position.

Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Split of V1 patch 7

 tools/arch/x86/intel_sdsi/intel_sdsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..a02850a710ee 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -43,7 +43,6 @@
 #define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
-#define METER_MAX_NUM_BUNDLES	8
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -167,6 +166,9 @@ struct bundle_encoding_counter {
 	uint32_t encoding;
 	uint32_t counter;
 };
+#define METER_MAX_NUM_BUNDLES							\
+		((METER_CERT_MAX_SIZE - sizeof(struct meter_certificate)) /	\
+		 sizeof(struct bundle_encoding_counter))
 
 struct sdsi_dev {
 	struct sdsi_regs regs;
@@ -387,7 +389,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	}
 
 	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
-		fprintf(stderr, "More than %d bundles: %d\n",
+		fprintf(stderr, "More than %ld bundles: actual %d\n",
 			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
 		return -1;
 	}
-- 
2.34.1


