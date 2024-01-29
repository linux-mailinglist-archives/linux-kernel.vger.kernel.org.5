Return-Path: <linux-kernel+bounces-42535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25D28402C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4636F1F22BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3545644E;
	Mon, 29 Jan 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RUTE91N7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A838257866
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706524035; cv=none; b=ZC9Im2np+vpBLuxKVKyYs0fxmkn9f6wFKYnZsk7VSyHi318CMJKzOdOFDHvIihWp0jA3MowtufE2b8ZujxvyoPpHvqFNncEGnONclmlsv4/5umRELc9KOtr1slRYbCdhQbGIsFyVg5UeiBM/udAb7m+8h7CLaOI67oPBd6C4e5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706524035; c=relaxed/simple;
	bh=TZw77lvnUmLd4BsEez3krlMll5qulnz4EXOmo2VAFDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGDwKSQnhFgSeB3WNeY20hfW91iLbR1UkBsCIis9ufpYa95NEanALt0Pr6xG5pLBQ1FBndbzLeac3N3s0Haq4kWzO7aEFnsPm51RVa8XVZfCtur3ZwG9yrAi5O3QHrxmJhlafJPl3vn22mUZj1oCqxkvqA40fZpx2o7G2tLxOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RUTE91N7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706524033; x=1738060033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TZw77lvnUmLd4BsEez3krlMll5qulnz4EXOmo2VAFDM=;
  b=RUTE91N7hhk5NEmRFX94GY9TgMTIf2/xxNFfZEvHir1cMLVvNoKxD2YH
   0EITzptMp6eLdxK6ujQ9xfN9dhEbjvsrrt6JfMoBsKvp6gzmRwjLiLhWS
   gYQQ+z8n4TlCBoytdwedhkfafkPvtrkB9/ogcbS1CJEjMBLr+M/UgAIae
   1fspm2Ey39Xv5xUcJI/Pvl0heFpufktFwk0HyWNVgnqYKagtliU99MmcF
   wFV3MwWy0ke7+zKU0C/p2giafzWVbXbsX3xvlippbrEO0rGWwLezZWQPI
   kJs/+OfyFLvCozBos9bh/dT1vowyQt+CAHM8hw5FXmsjxU8u93z+rm0Ko
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="10025339"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="10025339"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 02:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="858057395"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="858057395"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2024 02:27:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id E12EE125; Mon, 29 Jan 2024 12:27:07 +0200 (EET)
Date: Mon, 29 Jan 2024 12:27:07 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Jun Nakajima <jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Randomness on confidential computing platforms
Message-ID: <ajyeah2brs4mfogkxmp7wdteoesevpsvpwt7pxz7k5ifo76ihk@imfaevj2s4ms>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <ZbPOi0760srv0rE0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbPOi0760srv0rE0@google.com>

On Fri, Jan 26, 2024 at 07:23:55AM -0800, Sean Christopherson wrote:
> On Fri, Jan 26, 2024, Kirill A. Shutemov wrote:
> > Problem Statement
> > 
> > Currently Linux RNG uses the random inputs obtained from x86
> > RDRAND/RDSEED instructions (if present) during early initialization
> > stage (by mixing the obtained input into the random pool via
> > _mix_pool_bytes()), as well as for seeding/reseeding ChaCha-based CRNG.
> > When the calls to both RDRAND/RDSEED fail (including RDRAND internal
> > retries), the timing-based fallbacks are used in the latter case, and
> > during the early boot case this source of entropy input is simply
> > skipped. Overall Linux RNG has many other sources of entropy that it
> > uses (also depending on what HW is used), but the dominating one is
> > interrupts.
> > 
> > In a Confidential Computing Guest threat model, given the absence of any
> > special trusted HW for the secure entropy input, RDRAND/RDSEED
> > instructions is the only entropy source that is unobservable outside of
> > Confidential Computing Guest TCB. However, with enough pressure on these
> > instructions from multiple cores (see Intel SDM, Volume 1, Section
> > 7.3.17, “Random Number Generator Instructions”), they can be made to
> > fail on purpose and force the Confidential Computing Guest Linux RNG to
> > use only Host/VMM controlled entropy sources.
> > 
> > Solution options
> > 
> > There are several possible solutions to this problem and the intention
> > of this RFC is to initiate a joined discussion. Here are some options
> > that has been considered:
> > 
> > 1. Do nothing and accept the risk.
> > 2. Force endless looping on RDRAND/RDSEED instructions when run in a
> >    Confidential Computing Guest (this patch). This option turns the
> >    attack against the quality of cryptographic randomness provided by
> >    Confidential Computing Guest’s Linux RNG into a DoS attack against
> >    the Confidential Computing Guest itself (DoS attack is out of scope
> >    for the Confidential Computing threat model).
> > 3. Panic after enough re-tries of RDRAND/RDSEED instructions fail.
> >    Another DoS variant against the Guest.
> > 4. Exit to the host/VMM with an error indication after a Confidential
> >    Computing Guest failed to obtain random input from RDRAND/RDSEED
> >    instructions after reasonable number of retries. This option allows
> >    host/VMM to take some correction action for cases when the load on
> >    RDRAND/RDSEED instructions has been put by another actor, i.e. the
> >    other guest VM. The exit to host/VMM in such cases can be made
> >    transparent for the Confidential Computing Guest in the TDX case with
> >    the assistance of the TDX module component.
> 
> Hell no.  Develop better hardware if you want to guarantee forward progress.
> Don't push more complexity into the host stack for something that in all likelihood
> will never happen outside of buggy software or hardware.

My idea for this option was to make TDH.VP.ENTER return TDX_RND_NO_ENTROPY
in such case. VMM can simply retry or maybe schedule other workload and
let entropy pool to recover.

I don't think making RDRAND/RDSEED never-fail on HW level is feasible. And
it is definitely not guaranteed by current architecture.

> > 5. Anything other better option?
> 
> Give the admin the option to choose between "I don't care, carry-on with less
> randomness" and "I'm paranoid, panic, panic, panic!".  In other words, let the
> admin choose between #1 and #3 at boot time.  You could probably even let the
> admin control the number of retries, though that's probably a bit excessive.
> 
> And don't tie it to CoCo VMs, e.g. if someone is relying on randomness for a bare
> metal workload, they might prefer to panic if hardware is acting funky.

If we go this path, I still the option has to have strict default for
CoCo VMs as they don't have options to fallback to.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

