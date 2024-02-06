Return-Path: <linux-kernel+bounces-54208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A2D84AC3F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC772879A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536626E2A3;
	Tue,  6 Feb 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nfg7gER3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AB956B62;
	Tue,  6 Feb 2024 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186970; cv=none; b=dZCciEQGJkRDYY2Qs59y3dKVFAXRFQw/c9/vwNcJt5myEReKwoc32aqWjEfh9Y9ESJeDBWLnEDT49U20NcvG+SkXIMC/lyBdzDiN+5qpl4qTCNABE1ZDogx6aOpyULwHs4DbLJJzCmWbp0JsdxUJl65c51LobMFATqqA7zLT0vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186970; c=relaxed/simple;
	bh=wHtkFY2fDJUWJ8e33irKst+rMbyCcBXZ5MzpPjvbXvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5Q7N0/VX0yKAFSeqpKUE5gGZwkEsD2wdPN6PlbgwJX/ioIsNMPxayQDFDMEclHfdXLpqTDWNUI/PsSZRrznkfRTy/mf+QLbaYK7IOOGi6TvFhFdAvxp0R/ADRB7ocgP1jmkT7+UmgeSgG+zU/HoBh/5v9jQsnVfeDGAplLy9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nfg7gER3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707186969; x=1738722969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHtkFY2fDJUWJ8e33irKst+rMbyCcBXZ5MzpPjvbXvk=;
  b=nfg7gER3L/VsMs75Ei9+VRmeu/MIkyRbxiAz/pdG1bgcDDs3oaQHh9pE
   tj4iCQ91aJs5dZkLvNPFKv+kE59j1c7cgjWgV+/unEBi4u+CHwDWAZEDV
   jBgCe9Ssymb6hIsOWrayWgBmYZ9HY1SwvbJ8OgTaTs5DLf364jDFb4DHK
   +SmiKzeQsdg9ctPjhJhYMKqwiAAHGBFXYQ3TKAQQXrkd9ytaPGm4DifQR
   iKEjLNMGmTvkg31tfZPsXfdwlKgChoayf61KaNfXthe6K6P4STOjisiCO
   rc47xvoEAdH/UX1t0nBb8QIhcvqnv4T3aHXOCfCOv9EEIY6NWSc+CTFcw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="557677"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="557677"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:36:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1169095"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:36:07 -0800
Date: Mon, 5 Feb 2024 18:37:26 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 8/9] x86/hreset: Configure history reset
Message-ID: <20240206023726.GC17602@ranerica-svr.sc.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-9-ricardo.neri-calderon@linux.intel.com>
 <20240203093857.GBZb4JsahiDx2Ouegj@fat_crate.local>
 <20240204035552.GC26316@ranerica-svr.sc.intel.com>
 <20240204104904.GAZb9roHMCug6P9P8f@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204104904.GAZb9roHMCug6P9P8f@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sun, Feb 04, 2024 at 11:49:04AM +0100, Borislav Petkov wrote:
> On Sat, Feb 03, 2024 at 07:55:52PM -0800, Ricardo Neri wrote:
> > I can set hardware_history_features from bsp_init_intel() but I still
> > need to call setup_hreset() on every CPU.
> 
> init_intel() runs on every CPU.

I see. Yes, this looks like the place to setup HRESET. Thank you for
the pointer!

