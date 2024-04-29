Return-Path: <linux-kernel+bounces-162310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903BB8B5949
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4693B1F22135
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C07C093;
	Mon, 29 Apr 2024 13:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kryx1d+i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40B17BAE3
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395720; cv=none; b=MCpT5op+uX5+Z8dM/BMNCCqBcrOTwghb/6LSU1muea0BT92Pa8uSWNStvUNGxpcs+7/aSLqyuUQiNO+eziqHLmjMSGP9NLGO8qUjUErxdC9cqLWrfRsZixu95KlOoWhj4UmAIibeF8Uoyf+PS97zYjK7pWTh/gZzpDX8p8i8vS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395720; c=relaxed/simple;
	bh=JzxYEt5O7zxHEt/Z8bns47/1CXCnPIbwbW+u3fqIlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnJMhyUZHVV0r6coY2Ok57cUIh9DbhKVnypH1Qd3w+gpZBTy17z59RFV0wxyn70fEwKPfT2z4wKBUCxNwAeIUmkecuG4X4v9FWc3iH40fR57I1XH6plh9fIHAmA6+zVTVJyN4FiW4TgefgtmrZ4lkWaMTn5zI9sCk0Z/QWS8u3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kryx1d+i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714395719; x=1745931719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JzxYEt5O7zxHEt/Z8bns47/1CXCnPIbwbW+u3fqIlbI=;
  b=kryx1d+iSXe7VvihpyJg9fZtJSlk9yJJqbrZatC6rZaN8nKS9yIbJNqG
   T+yotv5HYa9PqlfHdNZdIRfhPWruikDGwiHAZThKBx63pwr475NZk1hTB
   YwHPZLryjwVRlbOM49YJ2V8el9PFx5tcoCSS4Uw9+AMpQAJ1zUBQEpA5M
   KH8XINDt/zql175iDqKOMZfucG3PRFtOOogTDObeKO9rWPrySXlrGNfVT
   /eTLGu2jIwC9E24nbS0Ljnf7g/hSNbm/26UJ6Iu9AVbFi+Q+O21Fhzico
   /Kow17LzVGxZpTCKyr70qhYV2rlb2CMV9dnW+dOpjiPqc9xY40FgUu//4
   A==;
X-CSE-ConnectionGUID: v+4hvcDURI2HpncxT68U8w==
X-CSE-MsgGUID: OGrFd8lMRQS37sPqbZgprg==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="12986905"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="12986905"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 06:01:58 -0700
X-CSE-ConnectionGUID: NX35Vbs6SS6ltVg0ivCMhQ==
X-CSE-MsgGUID: /cDeG+g8S8ObH3pHs6uf3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26507109"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orviesa006.jf.intel.com with ESMTP; 29 Apr 2024 06:01:56 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 08/15] intel_th: Remove redundant initialization of pointer outp
Date: Mon, 29 Apr 2024 16:01:12 +0300
Message-ID: <20240429130119.1518073-9-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
References: <20240429130119.1518073-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

The pointer outp is being initialized with a value that is never
read. All the reads of outp occur after outp has neen set to an
appropriate value rather than using the first value is initialized
with. The assignment is redundant and can be removed.

Cleans up clang scan warning:
drivers/hwtracing/intel_th/sth.c:73:15: warning: Value stored to
'outp' during its initialization is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/sth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/sth.c b/drivers/hwtracing/intel_th/sth.c
index 9ca8c4e045f8..428f595a28a0 100644
--- a/drivers/hwtracing/intel_th/sth.c
+++ b/drivers/hwtracing/intel_th/sth.c
@@ -70,8 +70,8 @@ static ssize_t notrace sth_stm_packet(struct stm_data *stm_data,
 	struct sth_device *sth = container_of(stm_data, struct sth_device, stm);
 	struct intel_th_channel __iomem *out =
 		sth_channel(sth, master, channel);
-	u64 __iomem *outp = &out->Dn;
 	unsigned long reg = REG_STH_TRIG;
+	u64 __iomem *outp;
 
 #ifndef CONFIG_64BIT
 	if (size > 4)
-- 
2.43.0


