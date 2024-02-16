Return-Path: <linux-kernel+bounces-68288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE6C857840
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D171F25B68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C018AF9;
	Fri, 16 Feb 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5DocEkU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71174647
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073905; cv=none; b=FY2OD2rFuVvK6DoetKESFMks4Z+huOW+U5U0Tcsk1jcfI0ffZRTX1oS3W4ljNg3tz/xL4xQKNOKmDZ9/b1fRScc9cpvs6ztUYdngfp9tJ4J9UAxgmIk+cmNSPML943r8Romw2skd/X8q0zTXoN2JDROuNOKc0eOPd/nGeLV/Ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073905; c=relaxed/simple;
	bh=d6QxL5a8KwuUX1bWADJH8Z/xc++iOJI/PqmoWkmlZxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJFP/L40bJmRXQi+l8LIhF/6OAQ7m5OaeVpIxj8JkOVRJLPkkc07K8zUOk8IosPqR9ClvE8PA1IK7RfTw9qgi3zK+Mh9PftD1UBzJ79jyCg39A6YZ1HmJXYmua+irJtrvU6ojOvvu7KzpqE0Tb9MiRO3NM9C3+Odb3A+bvI6m9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5DocEkU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708073903; x=1739609903;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=d6QxL5a8KwuUX1bWADJH8Z/xc++iOJI/PqmoWkmlZxw=;
  b=M5DocEkU62kSocOjlG9I2RpZqn2uJ2zbFDf0hn3rWqRdra1/NedL1Frg
   MnvfG1p+kNvPaLIOss7M8GPvyTcc0CTLFIa5ANbaFW090Wozdf15GSfSt
   Ytxl3MAJdhUE0CakumS33co/V2X43XRuIwYigxRhiQgVO866nZlb6Suf2
   nEgXr76jY3eQeBZPlRcu3HY5f1TmQVAgOaLZ7X/hSNimEmx3FKutAAXTP
   YJ6iN6jjEAfGtpxMAFgXoA+8qVtHizKEJc8M2xvsxX86Z5KmPNbFJ+znn
   0RMEdohLsk9SZc5VPq8bo6Si2Fq3brhjcj9tPqw7HpxEqvik1QzvPxJ/m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2103967"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2103967"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="4171354"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.79])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 00:58:17 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/amd/display: add panel_power_savings sysfs entry
 to eDP connectors
In-Reply-To: <a1d2749b-8db5-46d1-bf60-7820902cfc8f@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240202152837.7388-1-hamza.mahfooz@amd.com>
 <0b94b25a-9ffa-41a5-b931-ad84e1892d36@amd.com>
 <b117ccc0-6569-4753-9cb9-c304f9e50d30@amd.com>
 <a1d2749b-8db5-46d1-bf60-7820902cfc8f@amd.com>
Date: Fri, 16 Feb 2024 10:58:14 +0200
Message-ID: <87mss04wgp.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 15 Feb 2024, Mario Limonciello <mario.limonciello@amd.com> wrote:
> I feel the solution to these concerns is that we should make a knob that 
> controls whether the DRM property is created or the sysfs file is 
> created but not let them happen simultaneously.

*insert the eyeballs emoji here*

I mean no matter what the problem is, this sounds like the solution is
worse than the problem!


BR,
Jani.


-- 
Jani Nikula, Intel

