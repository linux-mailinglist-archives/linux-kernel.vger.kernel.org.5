Return-Path: <linux-kernel+bounces-63886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB48535F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C0C1F24498
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1ED5F875;
	Tue, 13 Feb 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O73GiMWi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DA356B65
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841670; cv=none; b=jzqLdmjBnpxIy1yYlEi1mvjbk1CQzkGvFtBaur/qlJBymVcDNMlH16idCrGCC7Ys0r8TBBtulLNcIXAqcPGpqFk+8dN7bJFqaX0QkZg2G0BlKy/qj8E1Zhg7GafXp5Q08vfik97VZk7Sbmhiin3ZTIKKkBRwX7YzpaDrl4ECTsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841670; c=relaxed/simple;
	bh=493bNgvRuweZimbX4Xhwo671z6/HUwelN8/FJypwO9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkKrrwyuWBAFQdG2RgjFhjek78C/PfbfusclqXgb18TpEIV45LOUfr5w1dd+fGtgppWQwIFoXfJ1utfKSsUeX8IQccq/WYxRb7cuuJLggaHmOya0pfvZlnR7gt4UmSPjtop1Ss6vRbX1Ffv8vw0BqoJ6ObuF+v/5xIyD0uQML6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O73GiMWi; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707841668; x=1739377668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=493bNgvRuweZimbX4Xhwo671z6/HUwelN8/FJypwO9g=;
  b=O73GiMWiHnjTCae994xnG5PYQYywa8iUsrFE2mcFuayDW2yLdQFmorn4
   eODirSw07yQk4W+1h9xmYzd0MtcRKzwtDDW9wW5VEaz97W+uJtxlugbPz
   SGgW9PnGKNoxORoctTHkR55IkEmpI/wZ8x6y8nhOjCJezq4Dj9lW6Yuvy
   ZGipi1bppsxHpPsOnbU1B5vbdaQsv8kEBRZ0HmqHN3ERdOdKM6TmLMNYu
   PyfgMpPHUoI+LCUWIxS5x7XIq0vnHMAofB+PFYpFPCG+CteEAIDj6w8XW
   Gn8Vlj2oRD8zCKLAwFXUnbceWrOgG2WMd7jCtM2cLmVYrtqiuDEaq8z7T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1736599"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1736599"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 08:27:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935386688"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935386688"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 08:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 506B7184; Tue, 13 Feb 2024 18:27:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jim Cromie <jim.cromie@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dyndbg: Replace kstrdup() + strchr() with kstrdup_and_replace()
Date: Tue, 13 Feb 2024 18:27:41 +0200
Message-ID: <20240213162741.3102810-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded functionalify of kstrdup_and_replace() with a call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fba6423cc10..c78f335fa981 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -640,10 +640,9 @@ static int param_set_dyndbg_classnames(const char *instr, const struct kernel_pa
 	int cls_id, totct = 0;
 	bool wanted;
 
-	cl_str = tmp = kstrdup(instr, GFP_KERNEL);
-	p = strchr(cl_str, '\n');
-	if (p)
-		*p = '\0';
+	cl_str = tmp = kstrdup_and_replace(instr, '\n', '\0', GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
 
 	/* start with previously set state-bits, then modify */
 	curr_bits = old_bits = *dcp->bits;
-- 
2.43.0.rc1.1.gbec44491f096


