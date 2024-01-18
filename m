Return-Path: <linux-kernel+bounces-30079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E9F8318DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EB152878B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADE124214;
	Thu, 18 Jan 2024 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVz8l6bl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB139241EC;
	Thu, 18 Jan 2024 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705579519; cv=none; b=l1Mw+GqQa0fkuyUQdxw4hvvuG4MHRQHaGsQtlOi8Bw9eLkPHuMlUQEC9AZ0zw+a3uT+s/dQacUxhib/BjL0SXGnDUGs0ILyodbU8d78ryIQjCwpQ9OqZG5F56JObLJYF+rgHO46u9B8jY5b+/T7K9KNrRzq9AeiYJ7V9FSKg3YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705579519; c=relaxed/simple;
	bh=SNU17WpjdPFohIh6bNYg3pQZpp+L6Jmf/1lHQBAlWQI=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=fmPFeMcZ1oInfM3UmZCGxS522kC8+ay3EiuxMFl8XU1Jwu2qWWzppvXeEm9V8MPlMzjoDpIyr0OPO/mjztsJQt5vTFqJhzjz9kcp0H7C/3gkQDi+MSL0fLp701ENl942Ak2LDYGTWRINHnBabS0YTvl7uz0+mVAI+IWgyd8LwoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVz8l6bl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705579516; x=1737115516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SNU17WpjdPFohIh6bNYg3pQZpp+L6Jmf/1lHQBAlWQI=;
  b=FVz8l6blqZcEovO3HhOQ+0prPH/mr+09iNSBNVsCrKpKJKOzuHRLNhZV
   MYwk6W+SaqeHev91VI29LtYpHNTIxoM+yaExKuTEuu5L+QPtpIoXKCyau
   BqwhevAs8iGFtUyrRziO/LjOYuvTgteyWnuPKn6p+F9vDETeatPMAB1bg
   EJ8HiSAOELeulMLP0UbmzP9Zn74y4njAtpEIbLjiXQZlTisMleh0PrYui
   NDeecj/uTFeuCuFZKzUEabdS6SNuIFNPknluPOTJzQwOR6zfQ25gFvyNc
   UYjXdPIPvM9M9WUTV2VPsbXFs5JNm/D9Q+AL64esX/OrLWxhcj9AKXFxQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7188533"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7188533"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 04:05:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="396341"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by orviesa004.jf.intel.com with ESMTP; 18 Jan 2024 04:05:15 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Directly use stored ratios for max frequencies
Date: Thu, 18 Jan 2024 04:05:13 -0800
Message-Id: <20240118120513.1018808-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid unnecessary calculation for converting frequency to performance
ratio by using a scaling factor for the maximum non turbo and turbo
frequency. Here the driver already stored performance ratios for max
non turbo and turbo frequency by reading from MSR_HWP_CAPABILITIES.
Directly use those ratios without any calculations.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2ca70b0b5fdc..6bbc21ca96e0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2532,7 +2532,14 @@ static void intel_pstate_update_perf_limits(struct cpudata *cpu,
 		int freq;
 
 		freq = max_policy_perf * perf_ctl_scaling;
-		max_policy_perf = DIV_ROUND_UP(freq, scaling);
+
+		if (freq == cpu->pstate.turbo_freq)
+			max_policy_perf = cpu->pstate.turbo_pstate;
+		else if (freq == cpu->pstate.max_freq)
+			max_policy_perf = cpu->pstate.max_pstate;
+		else
+			max_policy_perf = DIV_ROUND_UP(freq, scaling);
+
 		freq = min_policy_perf * perf_ctl_scaling;
 		min_policy_perf = DIV_ROUND_UP(freq, scaling);
 	}
-- 
2.40.1


