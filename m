Return-Path: <linux-kernel+bounces-54229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C4E84AC93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634D32888E7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20307317C;
	Tue,  6 Feb 2024 02:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JIpeAfys"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C2745D9;
	Tue,  6 Feb 2024 02:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188294; cv=none; b=mXGMYcGHdkPIQD0UJy2UigHT188ls9kb9uP/uWfYx7ANydKCknTj9rs+EGL6k2vSEfYxUANOnZ8MxIvVpJn8BdVcm4MS8Y9PKoK8wrzyF66JyCtzlbh0JEnelmZ9V89M8d9lTshmUflizuDfaANVhscwXnx2aaYq9GmQYWLhflU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188294; c=relaxed/simple;
	bh=CvUr7qGf2/+uNhEFADlo4awZNKOXCALRrrLUubt7MWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0A9gvT58SY/ZeDXTDGSR89xLwbbLTsdNcFOLsMH5vvotQcFBBVLi/EwXdW+ieCzhdyfESey8DI4UpfZshweXQuN9h4UijfiKL/CpZAxwipYdWwH4qQ4GxgGY/N2ohTh+VRBzqtWXvjKXN0Z6rR8SmdqAYaXt0vnlcUW7wTsihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JIpeAfys; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707188291; x=1738724291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CvUr7qGf2/+uNhEFADlo4awZNKOXCALRrrLUubt7MWk=;
  b=JIpeAfys3nu2kaqKczy+/sGpEccU6SpFQjqqGkt3Qu0q2KerRxA0sa4Z
   4uR8m3aqkzrsJpGE2i05XWdGg9/t1ce/rdJC8fxx44x2zNno9mNWn/I5B
   6OVLaJFvLlRqZ0eAmU2mPtfpCdmiAqIwkQ3gG4lGVIydvL+CMtQDo/7vU
   qUWYNGSAJQqZIH4bR/oytFasUTtCygSxSMuN1ViqBXSn32pPFdMNuZDjE
   USyIICWKhW0iabdPliKoiTsOI31xu+49xpjhF7iWlCLeO2Q8Nt6D4hWXT
   YsY+rbFeZEpy+XtlatqtcnR8enuQ5fW2Gbkqei4ILgryVWGgJEOPEvMq8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26098292"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="26098292"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,246,1701158400"; 
   d="scan'208";a="5495436"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:57:59 -0800
Date: Mon, 5 Feb 2024 18:59:18 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] thermal: intel: hfi: Prework for the virtualization
 of HFI
Message-ID: <20240206025918.GF17602@ranerica-svr.sc.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Feb 02, 2024 at 08:05:06PM -0800, Ricardo Neri wrote:
> Zhao Liu will soon post a patchset to virtualize the Hardware Feedback
> Interface (HFI) and Intel Thread Director (ITD) for the benefit of virtual
> machines that make use of ITD for scheduling. His experiments show up to
> 14% improvement in performance in some workloads and configurations. This
> series lays the foundation for his patchset. I will share Zhao's patchset
> when available.

Here are Zhao and Zhuocheng's patches:

https://lore.kernel.org/lkml/20240203091214.411862-1-zhao1.liu@linux.intel.com/
 

