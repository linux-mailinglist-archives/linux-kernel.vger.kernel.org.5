Return-Path: <linux-kernel+bounces-111894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D51887250
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566471C21849
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE0C60BA2;
	Fri, 22 Mar 2024 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aneMZokY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF996089A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130192; cv=none; b=rrwuWnr0+9HVxg0tkfYqrmdLkSqGQmCcSGRFe/VPYoZQJf6zler/phPjuibs8R/k4OaG4vexiPRtRuTC5sDa5fhKmPLGsX2bwJUSy+Ayv9vfx6fPtL2Pq3wBmfjrm+XOz4ZbaTRUVCztXRVfbxWW4pBOpILIOXDzsPR34aWHalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130192; c=relaxed/simple;
	bh=ZER+XMKoV0uNq0dEunaVFRx+y5nNBpVo8wxZrWbW1S8=;
	h=Subject:To:Cc:From:Date:Message-Id; b=Rh7dGDFkEROhNZGt4wx6KZY6mPQBdz0OjPHpBL2oKscMduzVCVj6HPFm5mMEgJP25JtbMhJtpShERB54KIBfQUn+jLusfcvp3u95pgsMdv7TTEHnS0LoeKz162x9c1Y0f15T/+KJjxSPFHgxmkxZ+A52ng1GkUqi5lv78mmn5XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aneMZokY; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130192; x=1742666192;
  h=subject:to:cc:from:date:message-id;
  bh=ZER+XMKoV0uNq0dEunaVFRx+y5nNBpVo8wxZrWbW1S8=;
  b=aneMZokYwVNYzoArV7r1UnTAHHsiAJTycjBzxTtjfBxcLdUe4u2F9SAb
   O1pvzCLNxG6QWecBdRxgq6e2qHR2SD52MOi/c7KvSzmALbKKSoBgfwyJi
   nbhjVJmhMd1XzZcHdlWFFaHkoodyNQqN9GSrOWjhy3/0H96j/rvqo5Gga
   JGVg8WrBim0Fv7UOqoctwIRNZRb6SrcSDNCjwVz1sZ2YkQXUlvdBHzVah
   9zP9YNlOvB9RlTd8aGkF5/TnP2D+5CZNaWTIhmXgwUsOBeGRTH3ZP62bw
   Fd+jaLhvwH7z+MPxm3ju65oyL7MXzZTlp2Vm4lhk5Ou/SiNdVXfUInWzX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28669672"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28669672"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15425568"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 22 Mar 2024 10:56:30 -0700
Subject: [PATCH 0/4] x86: Add CPUID region helper and clarify Xen startup
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 22 Mar 2024 10:56:29 -0700
Message-Id: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This peels off a patches from the top of another longer series
where Borislav suggested actually fixing a problem rather than
complaining about it:

	https://lore.kernel.org/all/20240307162752.GAZenrCDqs0lMTjmu1@fat_crate.local/

There's a little detour here to explain some mysterious (to me)
CPUID prodding.

The end result gets rid of some fragile Xen boot code.  It also clears
the way for a future series to bring some order to the early boot code
and remove some of the random tinkering that is there today.


