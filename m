Return-Path: <linux-kernel+bounces-162197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F138B5783
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38EBB244D2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43E54919;
	Mon, 29 Apr 2024 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NluAY1O1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD46AFB5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392571; cv=none; b=HwOMIsMnyHtfYfqDL7ELvTtvIr1mQrnRD1k9DEzqlXcMjbFSRLVKGCbqjkAbg3tXjq0WAqJ4X45Dg9hTBVsoqumbTh/5+GZPuuemk+5K7gPrEeLsytEZyFRITzxAtSf/V96F8aIx7CsAKsiRPnuCdcrzLMV8K8TTCXNUUuGp9ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392571; c=relaxed/simple;
	bh=JzxYEt5O7zxHEt/Z8bns47/1CXCnPIbwbW+u3fqIlbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upLjddokFdB75lcQSY7SvktoDhvKblp4VBb2jNzgVdQ9UE2PCdFjkZiVezN06qtlfd4VNgg8YdzCFP5lGnQYhYkZhCtWr4Z9wTWcwchsYqlsd4PMBWiZ1U5aNqZHYR+HpWj1/hSZVG5auJW43zRelav5uL74CH3RFHL5IF8lHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NluAY1O1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392570; x=1745928570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JzxYEt5O7zxHEt/Z8bns47/1CXCnPIbwbW+u3fqIlbI=;
  b=NluAY1O1mCx7DMeZntHKfw4Lbq+8pasSsftRhLAgnE5UShU+l02Ynftg
   5QT3cwajSD07kRKzvfaoy1X55qA4c56ukPbb5IqJfffKY7DhfSsDpXtBp
   ceBLOwRXayeZBsxff7aghmXZ+IDg210zDMfiEFiPldF+FWujkya9ChbfR
   NA/PvqhzJO2fhzN1ib6VUMWIojkkFCR0L9zz70DnYNQs8sTPa0GanBKDK
   VEciTgErL1rTwyp1adMJJA6AEXAoTAON7P5aPu0PnJXUfirfb2zb4iUYU
   qZpP1oc/g8t1M5zvzfxbUSXPnAlKAs1iETn65GgubC2J3pXumAiuZrabg
   Q==;
X-CSE-ConnectionGUID: PB+0qjK/Sx66K0Z0wbSKSA==
X-CSE-MsgGUID: b21YA6ReRom7sfarb0k71A==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908260"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:30 -0700
X-CSE-ConnectionGUID: KLkOLTXASEGaGeGadL/QIw==
X-CSE-MsgGUID: tUPvs+rOR/GlgExXGifRlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166626"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:27 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 07/14] intel_th: Remove redundant initialization of pointer outp
Date: Mon, 29 Apr 2024 15:09:01 +0300
Message-ID: <20240429120908.3723458-8-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
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


