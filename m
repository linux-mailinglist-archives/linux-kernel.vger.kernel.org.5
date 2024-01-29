Return-Path: <linux-kernel+bounces-43163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2508840C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4BD81C234B0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF20B15705A;
	Mon, 29 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/w/xzoV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8F4155A5F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547549; cv=none; b=awF53WnnQDSJy7L1eBaiQWMx7vmdHsb5c5Ddf9aSc681FN9bLJPze6ZFdzQwobWWlkT8lJx+QUewEy+5Oo8rn22QdOfALDxgIWBIggCyiyvFS9jZ0LhD+Hj+PofOUa5XQHmpn/SOy5eECsY77SNGoUxCKRILrQhuthoEpDOC4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547549; c=relaxed/simple;
	bh=orEs8V0KcQLlcZg+WsnWSS40wmP3mUbL/yu7YTdCOOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdWNUTDxWuQ3YZb+0lS+vtVyFI1GnTZ10tnFFKdnTaITeUJqTRFXtOYGJXw03WMiTD162IgVm6+OumiE+E+KuRggbWJE12+2eN5ZWcZBcW81U1ZnEYRKTHSL3FSMC0x+CEcXgOeUW9Z7iFTLjwfNPkWKuuywKwjJwYqIFhIirEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/w/xzoV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706547548; x=1738083548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=orEs8V0KcQLlcZg+WsnWSS40wmP3mUbL/yu7YTdCOOI=;
  b=O/w/xzoVKBgNoD1OkahskHDUDbwiHoi2qKYCDOgG7kkeRnF3NUxXNRdR
   yxGZTR+2LlPsGHKEXMUaM8UR1R35JR9p3KaklcD9fddjumZ1C1vLI9QcG
   xrc7SjkD8jZ6YE8jAKDk/ytLcUckRu+sjqJhgzl/RkYF+WIfg8gYlAb/4
   8MRclTa3jP/im9RT89jTzONBDqz30JM64MsVEj+H3/dGlYvqz8OAXayON
   fGEcgS3Dy7dP1mXKARzVVpOV8NtXnSVr0jd33q/lUY6O+yxWmQAhkZSt1
   CuWMRWrtYKsJlzKdhY9eC/dsT2M0ZlRTseVobPPjutLa70sj9C0ftlW6y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2871385"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2871385"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 08:59:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="911123505"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="911123505"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 29 Jan 2024 08:59:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AE38DFF; Mon, 29 Jan 2024 18:41:49 +0200 (EET)
Date: Mon, 29 Jan 2024 18:41:49 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	"Kalra, Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Randomness on confidential computing platforms
Message-ID: <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>

On Mon, Jan 29, 2024 at 08:30:11AM -0800, Dave Hansen wrote:
> On 1/26/24 05:42, Kirill A. Shutemov wrote:
> > 3. Panic after enough re-tries of RDRAND/RDSEED instructions fail.
> >    Another DoS variant against the Guest.
> 
> I think Sean was going down the same path, but I really dislike the idea
> of having TDX-specific (or CoCo-specific) policy here.
> 
> How about we WARN_ON() RDRAND/RDSEED going bonkers?  The paranoid folks
> can turn on panic_on_warn, if they haven't already.

Sure, we can do it for kernel, but we have no control on what userspace
does.

Sensible userspace on RDRAND/RDSEED failure should fallback to kernel
asking for random bytes, but who knows if it happens in practice
everywhere.

Do we care?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

