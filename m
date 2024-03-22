Return-Path: <linux-kernel+bounces-111895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9E1887251
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8C21284168
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB2460BB7;
	Fri, 22 Mar 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLJPpDX4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158165FDA8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130194; cv=none; b=JHViwEUAV1OolHfSIljHRophql88dP+HOOhtFlI/LqJLiKkWpl2zjJ2FoJjMGwAP315WUx2FCfneOldd29Gh/4HyOkv74H657PaD+sOhiaCqs/OMpdfgDQ0MMGB4/J/cWNIcDrpVy+xLDB9zKvrz+E69by3JsEDNXoqoZXPLLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130194; c=relaxed/simple;
	bh=KMEuR9Ct5c67N/eXZ6ai612Ojw1UgVoyvVnhOYdLqWQ=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=Id2mr+whlw+VUBYhBi4FONiU6xjtmekSZb0qWL2EIhlQwXDLl5vfs9t15HwPpk6zTOMiTa5wkqbbq4z6iN8RjFUugUQ4ErDX13W7NfFYiTsrha93PVkcx3SGi2TDbLS/mamD0b1aHuCWRaOF2hnwHZXRLivzVaMqwfbmyF2M4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLJPpDX4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130193; x=1742666193;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=KMEuR9Ct5c67N/eXZ6ai612Ojw1UgVoyvVnhOYdLqWQ=;
  b=ZLJPpDX4t006HjLdDNOVOEYPYn16Q5oRqhA9WrCnMUpVC/Zko0UPd07K
   Mz8z3JxfHJUqrbUy2PcMXMwOXJ8qLeqt3NHCu3kSItcOKojOcliAXGM8d
   OyT2z8xgyIILPiGoavG5dKk7FftO9mYiSeCp+ABCMAPNgFlQmSBH6GD5t
   1Fi67D8gJzsbzr9wE0V5XssUTSA8S2FL7LQ/qjcvzY4nSHa/WQER/lU5J
   i42SruVxPkqOazc6gawsHUJvRbrFCNIwyr52KlZjClwL2XlZz7ehpCLDD
   cTJ8LFLqsMb4YFZPrQgc2R4DKYZngVNoemV7o2lA7/xNrLm0NP96w92Z9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28669695"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28669695"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15425574"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 22 Mar 2024 10:56:33 -0700
Subject: [PATCH 2/4] perf/x86/ibs: Use CPUID region helper
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 22 Mar 2024 10:56:32 -0700
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
In-Reply-To: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
Message-Id: <20240322175632.D1DA64D4@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

IBS details are enumerated in an extended CPUID leaf.  But
the support has an open-coded CPUID region check.  Use the
new helper to trim down the code.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
--

Note: this cleanup could take another form:

        if (boot_cpu_data->extended_cpuid_level >= IBS_CPUID_FEATURES)
                caps = cpuid_eax(IBS_CPUID_FEATURES);

that would be one fewer CPUID invocations, but one more
line of code.
---

 b/arch/x86/events/amd/ibs.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff -puN arch/x86/events/amd/ibs.c~ibs-region-helpers arch/x86/events/amd/ibs.c
--- a/arch/x86/events/amd/ibs.c~ibs-region-helpers	2024-03-18 15:12:21.228327350 -0700
+++ b/arch/x86/events/amd/ibs.c	2024-03-18 15:12:21.228327350 -0700
@@ -1278,18 +1278,13 @@ static __init int perf_event_ibs_init(vo
 
 static __init u32 __get_ibs_caps(void)
 {
-	u32 caps;
-	unsigned int max_level;
+	u32 caps = 0;
 
 	if (!boot_cpu_has(X86_FEATURE_IBS))
 		return 0;
 
-	/* check IBS cpuid feature flags */
-	max_level = cpuid_eax(0x80000000);
-	if (max_level < IBS_CPUID_FEATURES)
-		return IBS_CAPS_DEFAULT;
+	get_cpuid_region_leaf(IBS_CPUID_FEATURES, CPUID_EAX, &caps);
 
-	caps = cpuid_eax(IBS_CPUID_FEATURES);
 	if (!(caps & IBS_CAPS_AVAIL))
 		/* cpuid flags not valid */
 		return IBS_CAPS_DEFAULT;
_

