Return-Path: <linux-kernel+bounces-98816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B2877FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFBF1C2108F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10A3F8DA;
	Mon, 11 Mar 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGexMmWJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A33B79F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710159479; cv=none; b=euEeakl0pn6V+IBjVzwQZzbGNxHchd7V9+PiOYMu16EqxmabVEsGNvtvPJu0NhdF+loR7eEwafFhPtIli4Wa+d6hV0qoF+WnL0Z2sBzWuymH1o9KgKXXqh7vc7ZomgGl8go5kDszRVbMLw+5WxmIyqKROTMPQgbjG9mRo9tpd6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710159479; c=relaxed/simple;
	bh=lY0f0O/T5DIqAm38n8d6EtkE9SN4TSyT54f5Jpryia0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mSSLm8fvOWyam8FhFRMzJ5BfgfQSSC6Pi6CmB1m0rDIbiJBzoY8tigouekZGwVFoETX4tXzFCVzlVKWulXXsdKXv+++ZgT8eN37rdFquX2d0563m6gSls6rvc7fcU6OMQEvgPUSBbOw7iQ77wgYRoFfLl8VaYNgrIrPJu0LvZO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGexMmWJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710159477; x=1741695477;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lY0f0O/T5DIqAm38n8d6EtkE9SN4TSyT54f5Jpryia0=;
  b=MGexMmWJbtlGga++KCKALw6jAQ/PDzK8nEAcsfiZybde8h7TwBJLj2PN
   4NzFyYejpcUWe73T4DUOfyUE/CppOWoJby0lRvynKMznyvb2Y9lEEhl2N
   ZsfWUSz44IzBSFAmFKT8kLV+6g6bW/I1vm+ZS7Fw0NNCdL3HKIWKMq4wl
   lkikq7ZXBre5OxXrJ8xY0LvpU3R5IUdpN0H5tzBu/oBcghVHYpIIw83lT
   HDdBvNCFw5tiExrrtbccwUyF4xwdHvy3F+GRodVgJspNWsjbYeY9/Iaug
   +uNRKyVSqXLKZF4JNT0RW4F5Qzd5Lpt75eDuIUnJjG7jXwrpWxgeu+CyT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="27287785"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="27287785"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="42131677"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 05:17:53 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 11 Mar 2024 14:17:48 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
    Rex Nie <rex.nie@jaguarmicro.com>
cc: "james.morse@arm.com" <james.morse@arm.com>, 
    "fenghua.yu@intel.com" <fenghua.yu@intel.com>, 
    "reinette.chatre@intel.com" <reinette.chatre@intel.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    Liming Wu <liming.wu@jaguar.com>
Subject: =?GB2312?Q?Re=3A_=B4=F0=B8=B4=3A_=5BPATCH=5D_fs=2Fresctrl=3A_fix?=
 =?GB2312?Q?_domid_loss_precision_issue?=
In-Reply-To: <3fjeeggediya7cl26snya5o5oif6x2xfd26qmsvroe6jygtufu@whanfahntydy>
Message-ID: <dcef573e-dada-efdc-32d0-8e6070af9d99@linux.intel.com>
References: <20240311064822.891-1-rex.nie@jaguarmicro.com> <2u7eg2khp2zrcmbfpnh6ighxqbttv2w7giwdxlkndeywpgq2bq@2lccnqwkbo65> <KL1PR0601MB577303C9D0B1247436BB06F8E6242@KL1PR0601MB5773.apcprd06.prod.outlook.com>
 <3fjeeggediya7cl26snya5o5oif6x2xfd26qmsvroe6jygtufu@whanfahntydy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Mar 2024, Maciej Wieczor-Retman wrote:

> Thanks for the reply,
> 
> On 2024-03-11 at 09:37:37 +0000, Rex Nie wrote:
> >Hello,
> >	Please kindly check my inline reply. Thanks.
> >Best regards
> >Rex Nie
> >
> >> >This will cause below issue if cache_id > 0x3fff likes:
> >> 
> >> Is there some reason for cache_id ever being this high?
> >> 
> >> I thought the max for cache_id was the amount of L3 caches on a system. And I
> >> only observed it going up to 3 on some server platforms. So not nearly in the
> >> range of 0x3fff or 16k.
> >> 
> >It is exactly as you said on X86 platforms, but cache_Id on Arm platform is different.
> >According to ACPI for mpam, cache id is used as locator for cache MSC. Reference to RD_PPTT_CACHE_ID definition from edk2-platforms:
> >#define RD_PPTT_CACHE_ID(PackageId, ClusterId, CoreId, CacheType)         \
> >	(                                                              \
> >	  (((PackageId) & 0xF) << 20) | (((ClusterId) & 0xFF) << 12) |              \
> >	  (((CoreId) & 0xFF) << 4) | ((CacheType) & 0xF)                        \
> >	)
> >So it may be > 0x3fff on Arm platform.

Hi Rex,

Please also put that kind of knowledge into the commit message upfront. No 
need to be as verbose as you're here (with code quotes, etc.) but stating 
that some platforms use higher IDs (e.g., Arm) would be pretty useful in 
answering the question why you're doing this change (which is one of the 
key points of describing your change).

-- 
 i.

> >Reference RD_PPTT_CACHE_ID from edk2-platforms: https://github.com/tianocore/edk2-platforms/blob/master/Platform/ARM/SgiPkg/Include/SgiAcpiHeader.h#L202
> 
> and thanks for clearing it up for me! I browsed some MPAM patches but didn't
> notice cache_id was used differently on ARM.
> 
> >
> >> >/sys/fs/resctrl/mon_groups/p1/mon_data/mon_L3_1048564 # cat
> >> >llc_occupancy
> >> 
> >> How did you get this file to appear? Could you maybe show how your
> >> mon_data directory looks like?
> >> 
> >I found this issue on Arm FVP N1 platform and my N2 platform.
> >
> >Below is the steps on Arm FVP N1:
> >mount -t resctrl resctrl / /sys/fs/resctrl
> >cd /sys/fs/resctrl/mon_data
> >
> >/sys/fs/resctrl/mon_data # ls -l
> >total 0
> >dr-xr-xr-x    2 0        0                0 Mar 11 09:24 mon_L3_1048564
> >
> >cd /sys/fs/resctrl/mon_data # cd mon_L3_1048564
> >/sys/fs/resctrl/mon_data/mon_L3_1048564 # cat llc_occupancy
> >cat: read error: No such file or directory
> >
> >Arm FVP MPAM: https://neoverse-reference-design.docs.arm.com/en/latest/mpam/mpam-resctrl.html#memory-system-resource-partitioning-and-monitoring-mpam
> >
> 
> 


