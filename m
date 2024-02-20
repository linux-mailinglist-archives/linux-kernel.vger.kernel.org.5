Return-Path: <linux-kernel+bounces-72214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA885B0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31761B221AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6A5677F;
	Tue, 20 Feb 2024 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaDvwyx0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90717482DF;
	Tue, 20 Feb 2024 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708395987; cv=none; b=GbsIWV1ek5U7MqkMWUd+DMjbO+tltnxxEn/0G8NOr1ypU32lB9/reXERlf57C4ar/yP8DqCvPh7Vn184WcZ1cfawx1jvvVyi82y47zOENpoWjJZVVCiJKkcsaY7OMEerAGwh+6DGuubaQEino0ABhHCeliZstcbsnC+NPPalzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708395987; c=relaxed/simple;
	bh=fYcp+tOavnZN6kwD0CzmpF4nQI1USCgZ12+SyleHdiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpY1mYFCdQu/0zzyrmmwIkxpsdUVNePmBH/Ftioe3x8yNpACLDoyqTs6FkncSU870BW6c38bm1guNrkE/eSmUfGNQS8plrk7fdoOONX/KKUkw/taOe0iZvb6Dc/8pZdtRdIXngXUceGWD4QNKELykaFL3MVUw9zX+zCCL2x/O/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaDvwyx0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708395985; x=1739931985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fYcp+tOavnZN6kwD0CzmpF4nQI1USCgZ12+SyleHdiE=;
  b=WaDvwyx0N/Tn0puI6/2+MtDvlgHj0Y8E/vFRwLrKHeRI6Gyv1DA5C1Yj
   PA+9WFumMPF14ZA/e8tgRkfkjpCmYIW1R9Us+W1Oz3mMwj+z+ZeVkkX4u
   45ptBrh3ieYO8wrnIV9cy8aOKXcdXmYMlYupQO4D2zO5foS05HNBaKdC2
   qFCwODsi2RcTljr5v96oUho2ouSmBvLyBferjNikcFlXvR2CYpjsUDOcc
   OGGoDZXRGlrDBlmgrgFYrJ0+Wjp5VoqTaYQecHlbF/4Dm8qiBMwxNmuGh
   8a6SDffF3VN7dxF7xo4eFS+YFuOd7Hh5i+4MUa5cNHaXt64ZTUBYWA1sk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2357358"
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="2357358"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 18:26:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,171,1705392000"; 
   d="scan'208";a="4538216"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa007.fm.intel.com with ESMTP; 19 Feb 2024 18:26:23 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Update default EPPs for Meteor Lake
Date: Mon, 19 Feb 2024 18:26:07 -0800
Message-Id: <20240220022607.485129-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
References: <20240220022607.485129-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update default balanced_performance EPP to 115 and performance EPP to 16.

Changing the balanced_performance EPP has better performance/watt
compared to default powerup EPP value of 128.

Changing the performance EPP to 0x10 shows reduced power for similar
performance as EPP 0. On small form factor devices this is beneficial
as lower power results in lower CPU and skin temperature. This
results in reduced thermal throttling and higher performance.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9a11228dd871..f2bde2ac109e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3428,6 +3428,8 @@ static const struct x86_cpu_id intel_epp_default[] = {
 	 */
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, HWP_SET_DEF_BALANCE_PERF_EPP(102)),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, HWP_SET_DEF_BALANCE_PERF_EPP(32)),
+	X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L, HWP_SET_EPP_VALUES(HWP_EPP_POWERSAVE,
+							HWP_EPP_BALANCE_POWERSAVE, 115, 16)),
 	{}
 };
 
-- 
2.43.0


