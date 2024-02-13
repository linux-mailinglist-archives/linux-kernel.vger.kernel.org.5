Return-Path: <linux-kernel+bounces-62557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D07388522DC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3B1F22F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5D5399;
	Tue, 13 Feb 2024 00:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gd4M4ax6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF417E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707782530; cv=none; b=VChmr/tCTL9RQC8vMIuPl+XGqsA9wE8zte96tONb9JXTWfC3+Q0+So0vUMeKu868YOxBvI9w9WVFFc+SIcF+el8QjFT5MnkT8b/eBNqFPPO181woqDWJeCIvuNSkCWhYwf/K6aiHsGDjgS765svWuJeBU9g3yh/WprGh+rq9DUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707782530; c=relaxed/simple;
	bh=L9LcqahDRz0VRwbvbqgcXymgClOX4tSh6GkWiJOqMJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E41EPeNr+8TiUAwWSPifQp8C72EIy2g6Yws30A3IV6bte6crQoDz+GSyacgQyd0L5p6o/LZb0tv5f3q+FWYBBXIrWATpmviWJQ372UKxkW7rpxQBFF6grfANphICuY4TLdnunjn0q9Nq3k9FqDYtzNO4HRDcRJ9iWzWN0Ddheos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gd4M4ax6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707782528; x=1739318528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L9LcqahDRz0VRwbvbqgcXymgClOX4tSh6GkWiJOqMJs=;
  b=Gd4M4ax6ip3AQ1/lF8w/OIQfkYytI1VPp2xPR0x5NKx42hpH1qXzSHlQ
   yOIsAymWyLwGCmt95MJxLRCoTtfbF61diEHMPADS/YCqgcr3okRxTuIvO
   9IOP/592Gtu5feiesmpFgH5347/V2ZAHf2NgCcJb+jhbXb/mGbPN7mJ8Y
   pdPO3L/1WelkFRvjLZ9u+pUlK9wDyUl3vA5B7EE5Zsqww0dAMZ/pACyfz
   KadEsOS3C/BpHLp8ZzOL/gBqzmybMq1PsWPP0oWiBtpLRCisxkN3jCfSQ
   FVGauxWUQw1VK0hN9YtwSlWGxY0qcciV32zCGNM51B5e27Ixv499L2GkR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1658248"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1658248"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 16:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="33528040"
Received: from mpai-mobl1.amr.corp.intel.com (HELO desk) ([10.209.55.176])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 16:02:07 -0800
Date: Mon, 12 Feb 2024 16:02:06 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	antonio.gomez.iglesias@linux.intel.com,
	alyssa.milburn@linux.intel.com, andrew.cooper3@citrix.com,
	linux-kernel@vger.kernel.org,
	Alyssa Milburn <alyssa.milburn@intel.com>
Subject: Re: [PATCH] x86/bugs: Default retbleed to =stuff when retpoline is
 auto enabled
Message-ID: <20240213000206.ctuf4hrcplwg5him@desk>
References: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
 <20240209185625.hca6lts6dv4cd3fu@treble>
 <20240209203346.gwbfyx3huiaozg4s@desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209203346.gwbfyx3huiaozg4s@desk>

On Fri, Feb 09, 2024 at 12:33:46PM -0800, Pawan Gupta wrote:
> > And what's the point of checking spectre_v2= anyway?  Shouldn't retbleed
> > be mitigated by default, independently of whatever the user may have
> > specified for Spectre v2?
> 
> @Borislav, what do you think about this approach?

Looks like there is no objection. I will send the next version with
retbleed mitigation enabled by default.

