Return-Path: <linux-kernel+bounces-130100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62757897419
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFC28EDD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA4E14A4C0;
	Wed,  3 Apr 2024 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DNgn1IZs"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA3814A0A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158511; cv=none; b=ax7yLRzrxbfzYWov4SBBXVwDUSPdRRQ10w5pKHhmWqiDrbPnN50YnzsNkG3ZQb1A1U8laTF+wb5BwCblsSiJegKBpOKl1ZhcLWmdeo55cV6A85F2pNsRthcIiNYLdZ3iaREqL8NCrPQTRu5jOC7+8LX/Nqc6MHO4nsOocLNqN00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158511; c=relaxed/simple;
	bh=/i+d9yJal5XQJcEJTQYG4lJkPTbxJBfam9byO42rSJ0=;
	h=Subject:To:Cc:From:Date:Message-Id; b=eM03i2fsPcqraGuCtjQvJmF6OTlNvc3/o5+SowauuXvhNbir9gW27M33XoCWN8wZfpy7aqTnca9u6vH7OGYxDa/R17T838dCgsmpxATDVpdOurKeVh0RopJPFsrzQi5YafVIHgQmSMZeb+ofbq5HC78tSEftJnwHlyQA+YfYBO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DNgn1IZs; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712158510; x=1743694510;
  h=subject:to:cc:from:date:message-id;
  bh=/i+d9yJal5XQJcEJTQYG4lJkPTbxJBfam9byO42rSJ0=;
  b=DNgn1IZs5fJ/UvHXY7SCBbybhRUIV8zKR7AwQUdLW9+64WO+EynntOSu
   k/PXasO7YKXgfvpncab4HoHSJKV3EWkc6ldGIKfO7IsFAQuQyBevZvW1N
   hMCJWTQhyq5vV8LRsU4n+CbBSgG388o3EcxSZdwLpjf5mq28tNQELEQi4
   HzkOa/Pt7iDQ6r9bPNQUu4YiJWQ8ofHq8ZyzT0Wtwbv3D69tOseb+1e4s
   CVBFgHG+l6b/RMccKUuMEnxLI/nAnUmHiM8lzhLaz46RdiMyy3X9fcjK6
   5yh9t28Wm9uI42i8TAkW0PX+VlaSOAeaMvAu0SXSYpeyLBaAD3wxdCFyU
   Q==;
X-CSE-ConnectionGUID: sBN5kF6DR7aebQ8aaYJJ7A==
X-CSE-MsgGUID: RnEzI5z0SBCjGxEfsmqpnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7269793"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7269793"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 08:35:09 -0700
X-CSE-ConnectionGUID: hpxrqCOQTpaM3+YSc7ypWg==
X-CSE-MsgGUID: offDVKTKTqmAC1UcREHawg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="41637975"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by fmviesa002.fm.intel.com with ESMTP; 03 Apr 2024 08:35:08 -0700
Subject: [PATCH 0/4] [v2] x86: Add CPUID region helper and clarify Xen startup
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 03 Apr 2024 08:35:08 -0700
Message-Id: <20240403153508.7328E749@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v1:
 - Typos and whitepace damage noted by Ingo.

--

This peels off a patches from the top of another longer series
where Borislav suggested actually fixing a problem rather than
complaining about it:

	https://lore.kernel.org/all/20240307162752.GAZenrCDqs0lMTjmu1@fat_crate.local/

There's a little detour here to explain some mysterious (to me)
CPUID prodding.

The end result gets rid of some fragile Xen boot code.  It also clears
the way for a future series to bring some order to the early boot code
and remove some of the random tinkering that is there today.


