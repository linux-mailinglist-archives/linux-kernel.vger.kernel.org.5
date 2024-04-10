Return-Path: <linux-kernel+bounces-138767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C9489FA19
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE96D28B2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3140B16EC1D;
	Wed, 10 Apr 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9a28EKK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C4816E88F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759845; cv=none; b=HCQ3re1qXN/Giphl4aD8GWhar4Dpeg6K2ukdOR7aD+KbEk4Cqh5VP7avkGKjRqGh0A0dVo9KCurge8yoL6Uzb1aDxehZu4DY671/T1HgcE0Q3JOinLDCQbQLdO+TE/4NZ/svZo8NZ48G8spbY3kyMeHFzVenoXyBxdsgHQwE0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759845; c=relaxed/simple;
	bh=n+cLkEOjKL1anCHA3V8uRbdu3cG6cI+aZxRQnEPEUCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7+0vu7igxK89g5ASLcQi7dbpLHDfYhQIkPemtE70S3q0Vt0HzhgC2y0wS8z4HcM2NmtBTfm3AtJ/gqqFzd6PxXUccN6pJedcwxq8Ad3rEb01+umJfZqSn4MZaLRsNTQs5VKzSdwlFijmUu3efRHL51kKHbgfqIVjuxc0ii54+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9a28EKK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712759844; x=1744295844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n+cLkEOjKL1anCHA3V8uRbdu3cG6cI+aZxRQnEPEUCY=;
  b=n9a28EKK3F8AjAuZSkw1Jr/hHVNISM1SA1lrv+2+/1akNl4SbO5YG8hi
   w+xUJ0rvjih3eSXqclSNUcVrB/kNFZk3aQDTZugU8iSeLy+wJ/cYcp9VH
   /GxnAKpHKirKr1/SfWLPDRVYgMgIiQ6FrXP7nlAiz1UlDjeM70b3Toe3Z
   P5ZYHu5c84aavoJL63u8pEbxOIziHZWVsoibIpRyTwUt5RgG5uD3TFFds
   PPJxkCpaPirtTlgSnRhlRQHujKF8RCN1rrbMCHsMGjuYqMoGpIlGuu+kK
   Ml00xgNIumdaw9ePo3comKUaN5P+qruZ84nRAojhsTBVtkyIB5x5Ak/iN
   g==;
X-CSE-ConnectionGUID: wc/eqgiCQv+9k4YUiPkEGw==
X-CSE-MsgGUID: x5aY72gmSWWj7JQhwIJncA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25565982"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25565982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 07:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937095210"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937095210"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 07:37:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 4EB19161; Wed, 10 Apr 2024 17:37:19 +0300 (EEST)
Date: Wed, 10 Apr 2024 17:37:19 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, hpa@zytor.com, 
	seanjc@google.com, elena.reshetova@intel.com, rick.p.edgecombe@intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 0/4] x86/tdx: Adjust TD settings on boot
Message-ID: <sbunoj5dm6xifhqog5aaeujrbiilfqufum5msoiqtp2di3nsbs@wdoa37qkziwe>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>

On Mon, Mar 25, 2024 at 12:46:03PM +0200, Kirill A. Shutemov wrote:
> Adjust TD setting on boot:
> 
>   - Disable EPT violation #VE on private memory if TD can
>     control it;
> 
>   - Enable virtualization of topology-related CPUID leafs
>     X2APIC_APICID MSR;

Any feedback?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

