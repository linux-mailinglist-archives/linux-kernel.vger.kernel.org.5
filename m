Return-Path: <linux-kernel+bounces-93674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7787331E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6611F24CF5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD085F84E;
	Wed,  6 Mar 2024 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3kLAhH1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0915FBB5;
	Wed,  6 Mar 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718803; cv=none; b=cpyKsBgG2XLiyM7dczc7bx6Fm+RPKKFijhgoP7ZaBvy9YPYzThxVibnByLKuGkW7L/29UI4I7N04rl6x2YOAvCcbv71kfeap4JVvU22wq/+m7255SheMDiq/WSbjeMqeKjEc3BdwUWjcl35gAGGHjRhOP8VJY/4rOtBBXFCmHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718803; c=relaxed/simple;
	bh=io4SbbnyiNckKCLRLcGAVDLGtDr6dhrOEcERzQbK/JY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tt95gtmLTuSgJ9UpOzyx56yg09AYHHShAa4hlcTAS/D74qLg9n4Rlx9YFHhQIrQpiHMhWOW1NOflZfeNwgXRowXwLi5Q2pYP1+TpRWJpUrdhyIG1WHIMOGy+fWHnWo/xa0N5qjYqFgiKrSBAK2aYlEt3sf69ifcqiKm+llUVRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3kLAhH1; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709718801; x=1741254801;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=io4SbbnyiNckKCLRLcGAVDLGtDr6dhrOEcERzQbK/JY=;
  b=n3kLAhH12AH+qo7NtjkSmeRXgh4qdswYzh/Uw+vNUBqe6IC4fXWmrvei
   462hSBJ/vDMwhDZ1AFEEJYK9ATYDH66GE2ET8yA/5gQFFban7FcLAMg6l
   DCOzsHxdsKU0VIyT213980j4ul6BFDrZaf7rmIqza/37D5vGxUaxxm5X/
   9JphC6jVswKQ5PQCMrl7KhI5EMIhNwzI0tPsziXg/TvgkTsMTAT/GYjMp
   8dWzvddEFWZGbPpufoACQ/GJR3NjbdDTtSsKiR3LsgvZmBjxl6rKU7oEY
   dPL4hA23OrozoQfVOCLeQFU0TJQuy4ubBYna/xOg2uiJSqPPkYoFj1k+x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4436928"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4436928"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:53:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="10266716"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 01:53:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 6 Mar 2024 11:53:14 +0200 (EET)
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] platform/x86/amd/pmf: Fix policy binary
 handling
In-Reply-To: <839a74c1-6e08-441b-a6e3-9923dfc3f303@amd.com>
Message-ID: <0b614744-257b-3d4f-533e-f8bf9085f03a@linux.intel.com>
References: <20240304205005.10078-1-W_Armin@gmx.de> <839a74c1-6e08-441b-a6e3-9923dfc3f303@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 6 Mar 2024, Shyam Sundar S K wrote:
> On 3/5/2024 02:20, Armin Wolf wrote:
> > This patch series fixes various issues inside the policy binary
> > handling code.
> > The first patch makes sure that a valid error code is returned upon
> > failing to start the policy engine, while the second patch drops the
> > usage of readl() on non-io memory.
> > The last two patches fix a possible out-of-bounds memory access when
> > parsing the policy binary header.
> > 
> > All patches are compile-tested only.
> > 
> > Changes since v2:
> > - add patches 1 and 3
> > 
> > Changes since v1:
> > - get the full dword instead of only 8 bits when reading the header
> > - check if the policy buffer also has enough room for storing the length
> 
> Thank you Armin. Series looks good to me.
> 
> Reviewed-by: Shyam Sundar S K Shyam-sundar.S-k@amd.com

Thanks for taking a look.

Btw, you were missing <> around the address so the patchwork automation 
didn't catch that line. To help the patchwork to capture that tag (no need 
for you to do anything):

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

--
 i.

> > Armin Wolf (4):
> >   platform/x86/amd/pmf: Fix return value of
> >     amd_pmf_start_policy_engine()
> >   platform/x86/amd/pmf: Do not use readl() for policy buffer access
> >   platform/x86/amd/pmf: Use struct for cookie header
> >   platform/x86/amd/pmf: Fix possible out-of-bound memory accesses


