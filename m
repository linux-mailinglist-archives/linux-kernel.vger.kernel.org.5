Return-Path: <linux-kernel+bounces-37901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A64A783B768
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48E51C21C27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA56127;
	Thu, 25 Jan 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZQ6nlzlH"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BFB1FB2;
	Thu, 25 Jan 2024 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151328; cv=none; b=Cy0lkdiyZp60I4bqaSwz5gq4X9LTU49jN5XjtJuLEUA0QrkhXOEOSypWLZP/7kur4DvxejGS59BbPCl/YAeH2VTPV5B/xJaedtxKC4bfVIPydf0393ZJtDEZM1ojIJRPeSkve1PRFUgAqzyk+CjJLyNJkvacV+NWgNMDmlJoz5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151328; c=relaxed/simple;
	bh=XlfRlivdUQW1sAwDNDH/UEwgJtqmjkPpXNS9B0baTNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mA9ZVYFkLUeoiBADX4vdU4Ethti2VmRCiSRhaJ5bL3kHbpT45HjzlF7dvZZJ9Vw3IWg3rosTE7gu5ddtoJ30pVle7OPqoHLdGeEeYqoEJkb0Jf4N0ALqr2qHl8sGY1XB4XILiu3JSaE2kh37A/AXqkJvm9zWGh3ERTqqOOt28Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZQ6nlzlH; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706151327; x=1737687327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlfRlivdUQW1sAwDNDH/UEwgJtqmjkPpXNS9B0baTNk=;
  b=ZQ6nlzlHPjOFNbQlrTXT7jSn7Pe9tZP+ok35Tn1aqoWHMPxC5K8bAm6z
   DHQeb2FpVMrLW4Jt5XKXvNCxFugOs9U8wte+VifB7atH8HGd8Eq5lV0Bh
   M9w6ZyxKtzzRO0EpA2wXKnv8vqXmOM8zGyqQVfGqGcIIfsDcQrBiJH37M
   havn5A6dJqVJzgVn1GvM5lI277Q4ibP87kKo17PV2CGI1559JyHvMIUTp
   uzgAsfYgIwdwSu9gqdYKGFNq4WLzEg3LdsRu0+zYHSdwqTK7GoXmzBxfR
   MxCBI+oTLycaetRplgUYqgKa2QwyChr7//reWcoPDmFn6YQAAvUbyX3G+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="399197743"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="399197743"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 18:55:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929882085"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929882085"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 18:55:26 -0800
Date: Wed, 24 Jan 2024 18:56:52 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20240125025652.GA15039@ranerica-svr.sc.intel.com>
References: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Dec 12, 2023 at 02:25:15PM -0800, Ricardo Neri wrote:
> Hi,
> 
> The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
> if CPUs have different numbers of subleaves in CPUID 4. This is the case
> of Intel Meteor Lake.

Hello. Wondering if there is any feedback on this patchset. The interface
/sys/devices/system/cpu/cpuX/cache is still broken on Meteor Lake with
v6.8-rc1.

I verified that this patchset applies cleanly on v6.8-rc1.

Thanks and BR,
Ricardo

