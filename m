Return-Path: <linux-kernel+bounces-60250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1020A850239
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A7C28B02E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B7442D;
	Sat, 10 Feb 2024 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j3eae/Ut"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEAB63C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707532791; cv=none; b=otw0QXOM6aZKuZIsxQXHTESRNKhp890k9OFhwOsBGAJo5EVHkViHEuIR2KL82MWy0Rhxb12KFQKTn2KXaNzoOi/jsqwMhstaL4p2SpHZlV21BEnCcXSZ09ObuH84aiv6mw15bQ0O9v4dMJZZtP2Oxo9ZlM/YcAuiEaeeWwRyk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707532791; c=relaxed/simple;
	bh=KvmExit0TrANeclOjX4bPITu2Wj408sKc/29bhsRktE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbxqn/5y4jwEXbpKwSomqV+x/epB6vCkIGhX4jEh4y1jBBNZGEo/PVj+/hnQIWkPfTqnmA9zpsiIZU4Pv2Fvllo4IoqCsNCGlqEFvA2k/tNWtJEXSCK6iHY3n02Mw8ru16dZwZToVNAuAX+NpCRgpM3/MmIuwb3cX4UPviinxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j3eae/Ut; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707532790; x=1739068790;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KvmExit0TrANeclOjX4bPITu2Wj408sKc/29bhsRktE=;
  b=j3eae/UtTXziLRpflI9ktThe53IM+tacfzsGcuxfjZVsekDJWb6Akjlh
   okvBPpoKefLpgw/OzoJAswx5edaQIpdcc7aidbxhvqjHsOIovbtbpvUlw
   VH0IlmEP3ZOxFlVJpDix/KAoBiOERR3njvFoUplwm+33ZM+SVEGTrLspn
   R1d3kMj+XR+NlPd5GFKBiFnNl9jP4xuCOQ18XUPtaEVtrO/lYlJ2bWkbM
   4JJJJ8JDXcISkNa9ebwyRjETppZEFYrHXD6eydaA0iNa7wHZE5S/1jOU3
   uEwRF6OWv7ZSeC+eSo4gDdcyLAs3Gwkd8QL/+BKJuVfRGWwN4WhJHGGCg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5384172"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="5384172"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 18:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2077333"
Received: from karenaba-mobl1.amr.corp.intel.com (HELO desk) ([10.209.64.107])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 18:39:49 -0800
Date: Fri, 9 Feb 2024 18:39:47 -0800
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
Message-ID: <20240210023947.pefmjmogsxhissem@desk>
References: <20240208-retbleed-auto-stuff-v1-1-6f12e513868f@linux.intel.com>
 <20240210004328.n7uxevxfiqr3gsot@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210004328.n7uxevxfiqr3gsot@treble>

On Fri, Feb 09, 2024 at 04:43:28PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 08, 2024 at 05:12:15PM -0800, Pawan Gupta wrote:
> > -		 * The Intel mitigation (IBRS or eIBRS) was already selected in
> > +		 * If Intel mitigation (IBRS or eIBRS) was already selected in
> >  		 * spectre_v2_select_mitigation().  'retbleed_mitigation' will
> 
> 						 ^
> 						 should be a comma

Ok, will fix. Thanks for the review.

