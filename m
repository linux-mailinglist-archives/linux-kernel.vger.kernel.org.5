Return-Path: <linux-kernel+bounces-50034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38E84737E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D8D1F27192
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BEA145B3D;
	Fri,  2 Feb 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XGJzCeg3"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556EC14462A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888435; cv=none; b=EVNyyLOKewl6OtgF7YxOwh1D7JWImb2ovM6cartJRMeBKKdpbWrypML2sMgsuE1h+IqGIfSSqbgIOxwrnfLoWf9v4O4vRzDcWsFhD4zt1CZv6eZ3EMYRY/Yg3xk+7SCfIXF0Pxgyvg6DpgtzamoerTAqwSpMd60LqvW0arjih3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888435; c=relaxed/simple;
	bh=bjIeEnCETjahOnKi5daTQMdziDOVMdzR9xtwT+pTcTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pry2pxHD8GYHI3vzXiTUj4Yg8aYrdW2hTUwrd+PPE2js0JZWl6V97pK0BUb2+pfu6u0UJPuDzBFOenBvBQ70Ya5dmLN+BHqkr789MxBmw7BfxpcmLJ0I+fcSp00hJlOKRenp4xcC9MG5zJj5CpA2VJsttjJ3d1t23syb+esXf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XGJzCeg3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-13.bstnma.fios.verizon.net [173.48.116.13])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 412FdRxW008430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 10:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706888371; bh=v0OLpV7O3ASnwWjO7516vRjTb6yQU2eLSXzlY93D1cM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XGJzCeg3fmqBhPg4vD7D6xLDHGgGhGgsPMfYWQeyAhW6rnWvl6xHyqi7NrD+O1+W0
	 fAIIBZ/eA4pzLHh/A/xY0pctC9d5tM7Dvr4s3UAMulTvuVXupKOH/ksLulOLiJAbvn
	 xV089O95IFxB0XcIkXQ+R0+bHKdpV7N8HT9T3lxorg8OwvSaoRdVJ+eGE31EjJfs6p
	 KeihLYQmHWjzGnpEIYcAviO7/5EQiyuyXq0QUYU7d9bAv8t+4LRrntKAMMBuHSLGBv
	 2j53Q8jX5X2l/bQvrFBVLKbhtKXANON78rqQrcuOzpaTEvDOsMlVqlM2ZeJ4Jhe2N4
	 4VlgC47RUgkDg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0C25815C02FC; Fri,  2 Feb 2024 10:39:27 -0500 (EST)
Date: Fri, 2 Feb 2024 10:39:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <20240202153927.GA119530@mit.edu>
References: <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>

On Fri, Feb 02, 2024 at 07:25:42AM +0000, Reshetova, Elena wrote:
> This is a great summary of options, thank you Jason!
> My proposal would be to wait on result of our internal investigation 
> before proceeding to choose the approach. 

I'm happy for the option "Do nothing for now", but if we do want to do
something in the absence of more detailed information, I'd suggest
doing something simple for first, on the theory that it doesn't make
things worse, and we can always do something more complicated if it
turns out to be needed.

In that vein, my suggestion is:

> > Solution B) BUG_ON(is_early_boot && is_coco_system) in the RDRAND
> > failure path (> 10 retries).
> > 
> > This is slightly less simple than A, because we have to plumb
> > CoCo-detection through to the RDRAND helper. [Side note: I feel
> > ridiculous typing 'CoCo'.] Systems-wise, I don't see drawbacks.
> > RNG-wise, the drawback is that this doesn't help deal with secure
> > reseeding later in time, which is a RNG property that we otherwise
> > enjoy.

If there isn't a global variable we can test to see if Confidential
Compute is enabled, I suspect we should just add one.  I would assume
that /dev/random isn't the only place where we might need to do
whether Confidential Compute is enabled.

So I don't think plumbing CC into the /dev/random code, and since we
are only doing this in early boot, I wouldn't put it in the RDRAND
helper, but rather in the caller of the RDRAND helper that gets used
in the early boot path.

(Side note, internally, at least in my part of my company, we use CC
as the acronym of convenience.  And any comments that I make are my
own opinion, and do not reflect the positions or desires of my
employer...)

> > Question iii) How likely is Intel to actually fix this in a
> > satisfactory way (see "specifying this is an interesting question" in
> > [1])? And if they would, what would the timeline even be?

Here are at least two obvious ways that Intel could fix or mitigate
this issue:

(1) Add more hardware RNG IP's for chips with a huge number of cores.
This is the *obvious* way to address the problem with hundreds of CPU
cores, although it's only something that can be done on newer chips.

(2) Have a per-core throttle where a core is not allowed to issue
RDRAND or RDSEED instructions more than N times per millisecond (or
some other unit of time).  So long as N is larger than the maximum
number of SSL connections that a front-end server can actually
terminate, it's not going to impact legitimate workloads.  This can be
approximated by the number of public key operations per unit time that
a single CPU core achieve.  And if RDRAND isn't sufficient to support
that today, then see solution (1), or CPU customers should switch to
some other CPU vendor that can...  

(3) Provide some kind of perf counter so the host can see which cores
are issuing a huge number of RDRAND/RDSEED instructions, and which
cores have been suffering from entropy exhaustion RDRAND/RDSEED
failures.  This would allow the operator of the host to detect which
VM's might be carrying out DOS attacks, so that the operator can kill
those VM's, and disable the customer account that was launching these
abusive VM's.


Hopefully mitigation #2 in particular (and maybe mitigation #3) is
something that Intel could implement as a firmware update; I'd love
comments from Intel if that is the case.

I'll also note that the threat model where customer A is trying to
start a CC VM, and customer B has purchased VM's that use all of the
other cores on a server, is primarily the sort of thing that a public
cloud vendor would need to worry about.  And *if* this become a real
issue, where some researcher demonstrates that there is a problem, the
cloud provider will be hugely incentivized to apply host-side
mitigations, and to lean on the guest OS providers to apply guest-side
mitigations.

So if this is only a DOS which applies for CC VM's, and it turns out
that solution (B) is not sufficient, we can do something more
complicated, such as having the guest retry the RDRAND instruction for
ten seconds.  And if some hypothetical "RandExhaust" attack is being
written about by the New York Times, I suspect it won't be that hard
to get Red Hat to apply mitigations to the RHEL kernel.  :-)

So I don't think it really is *that* big of a deal; if it turns out to
be an issue, we will be able to deal with it.

      	     	     	     	     - Ted

