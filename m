Return-Path: <linux-kernel+bounces-46489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E525844073
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C04AF1C281FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BAA7BAFF;
	Wed, 31 Jan 2024 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHddOYP+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D40A7D3E3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707465; cv=none; b=rtjnmxrNaqOFNF/ltm+fGCNKdMxDJrROuBE/bcHf/Vf7+SDurNU9rHd2NCsHUja5zKUbKE1GpZNFOBJ8Vszz4P3+nLyCTdWgA70261M0NKSK5OLLpa1wS0aHFh4HO5iiT84kmsWh6AEXZ5goTHDo6bkm35Aj4YJ5PFBlrnn6tjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707465; c=relaxed/simple;
	bh=Qqf/UeSmjtXbkfGb1ggwNrtJYnwihR+82214TBpnMiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6HbBE7TQ0QPjbg9rWMkSWLaxKjpeuOuPK0I10Z0x9RWHLt+p2KhHUbL+xItyLwJCG+DzNOFx3aWDQtgzzTYf23hR5rjbvhsgkxf7lEJmhqyH8XpdkXp7/1ltgj0POtWvjtmf+EVQz3TuQZFdHsiu3rWHoPocnh1eLBEjHztYCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHddOYP+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706707463; x=1738243463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qqf/UeSmjtXbkfGb1ggwNrtJYnwihR+82214TBpnMiU=;
  b=HHddOYP+CSg7mNMCIvr5UcJaoKvoEvTmDURiOW4lb28iPt8ryGaqQL+t
   AS5/u03lofozbL9kFJIQBR+ElRqtR3pERcPUhbo5CAoZ6XZ60FvvfysjH
   ecL9zkxoyDgZMINQpFIs9AQUGa60qTZX3YnXB0VYBum7XgH/fz3VFkHi6
   1FKhQXMGogScAZbjHIGvAgvN5U9kTmIr/ULGeAHrsCQpg2gTh382VpLdx
   cYWM7rtFoEA5XzmrCqlYG9Rr+yQND8dmKpW+Q7CD9yEslP5jeeq6rLHvc
   hR2PjdHQnvgInYYGoahUoOYZsaiTbIKl0XWhkaXI2vJmknvjkHDN0K6e2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="25074820"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="25074820"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:24:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788575863"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788575863"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 05:24:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B45731CB; Wed, 31 Jan 2024 14:58:57 +0200 (EET)
Date: Wed, 31 Jan 2024 14:58:57 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Isaku Yamahata <isaku.yamahata@intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH, RESEND] x86/pat: Simplifying the PAT programming protocol
Message-ID: <uvm2vudogp3mkkhpx723l6nmmy3dzivneoyaacx6cfbbrlvjqc@wc5q7m27mmzr>
References: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124130650.496056-1-kirill.shutemov@linux.intel.com>

On Wed, Jan 24, 2024 at 03:06:50PM +0200, Kirill A. Shutemov wrote:
> The programming protocol for the PAT MSR follows the MTRR programming
> protocol. However, this protocol is cumbersome and requires disabling
> caching (CR0.CD=1), which is not possible on some platforms.
> 
> Specifically, a TDX guest is not allowed to set CR0.CD. It triggers
> a #VE exception.
> 
> Turned out the requirement to follow the MTRR programming protocol for
> PAT programming is unnecessarily strict. The new Intel Software
> Developer Manual[1] (December 2023) relaxes this requirement. Please
> refer to the section titled "Programming the PAT" for more information.
> 
> The AMD documentation does not link PAT programming to MTRR.
> 
> The kernel only needs to flush the TLB after updating the PAT MSR. The
> set_memory code already takes care of flushing the TLB and cache when
> changing the memory type of a page.
> 
> [1] http://www.intel.com/sdm
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Any feedback?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

