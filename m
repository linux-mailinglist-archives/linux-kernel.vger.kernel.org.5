Return-Path: <linux-kernel+bounces-46396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA044843F19
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80451290A26
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E4A76C85;
	Wed, 31 Jan 2024 12:04:16 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8068071B39
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702656; cv=none; b=OtNjzdS/zFx7fXpAXtPWNyElIhb3Iu8/fPbDFQxkgexE/haxckfougOsB7wX6Nus0a/dHYLJzfJZ/oxgi6E87Si0wsOLq5+Xu5hahSb1SbZgrBFQpaAdkddwDNTnRDJcfN7Nu9je/RJizfsqo7uRBgGoSXCkrVLYcLvk79Z55t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702656; c=relaxed/simple;
	bh=/0iLm9Atvy/JSiwLXNWauydouf0fB7129/ouQ1lxNas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ns3dbIs+H81xWwfF+SmfWbW4N0SluOH19d9xenDqgwbh//y0/dvnxRNF0PfTOOoev4Kry+q0Y9ZnfJaJPiEl7MSFeC1pzVb7m6t2K3GrjiokfUZ2IBJWGmKXQbQkJSlOC6Znq2TgtNwdxunfulbWfOy9u6a6EKGyCzq5Zi804xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 40VBx1Dj007499;
	Wed, 31 Jan 2024 05:59:01 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 40VBx0nZ007498;
	Wed, 31 Jan 2024 05:59:00 -0600
Date: Wed, 31 Jan 2024 05:59:00 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Daniel P. Berrang??" <berrange@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <20240131115900.GA7394@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com> <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 31 Jan 2024 05:59:01 -0600 (CST)

On Wed, Jan 31, 2024 at 08:16:56AM +0000, Reshetova, Elena wrote:

Good morning, I hope the week is going well for everyone.

> > On Tue, Jan 30, 2024 at 06:49:15PM +0100, Jason A. Donenfeld wrote:
> > > On Tue, Jan 30, 2024 at 6:32???PM Dave Hansen <dave.hansen@intel.com> wrote:
> > > >
> > > > On 1/30/24 05:45, Reshetova, Elena wrote:
> > > > >> You're the Intel employee so you can find out about this with much
> > > > >> more assurance than me, but I understand the sentence above to be _way
> > > > >> more_ true for RDRAND than for RDSEED. If your informed opinion is,
> > > > >> "RDRAND failing can only be due to totally broken hardware"
> > > > > No, this is not the case per Intel SDM. I think we can live under a simple
> > > > > assumption that both of these instructions can fail not just due to broken
> > > > > HW, but also due to enough pressure put into the whole DRBG construction
> > > > > that supplies random numbers via RDRAND/RDSEED.
> > > >
> > > > I don't think the SDM is the right thing to look at for guidance here.
> > > >
> > > > Despite the SDM allowing it, we (software) need RDRAND/RDSEED failures
> > > > to be exceedingly rare by design.  If they're not, we're going to get
> > > > our trusty torches and pitchforks and go after the folks who built the
> > > > broken hardware.
> > > >
> > > > Repeat after me:
> > > >
> > > >         Regular RDRAND/RDSEED failures only occur on broken hardware
> > > >
> > > > If it's nice hardware that's gone bad, then we WARN() and try to make
> > > > the best of it.  If it turns out that WARN() was because of a broken
> > > > hardware _design_ then we go sharpen the pitchforks.
> > > >
> > > > Anybody disagree?
> > >
> > > Yes, I disagree. I made a trivial test that shows RDSEED breaks easily
> > > in a busy loop. So at the very least, your statement holds true only
> > > for RDRAND.
> > >
> > > But, anyway, if the statement "RDRAND failures only occur on broken
> > > hardware" is true, then a WARN() in the failure path there presents no
> > > DoS potential of any kind, and so that's a straightforward conclusion
> > > to this discussion. However, that really hinges on  "RDRAND failures
> > > only occur on broken hardware" being a true statement.
> > 
> > There's a useful comment here from an Intel engineer
> > 
> > https://web.archive.org/web/20190219074642/https://software.intel.com/en-
> > us/blogs/2012/11/17/the-difference-between-rdrand-and-rdseed
> > 
> >   "RDRAND is, indeed, faster than RDSEED because it comes
> >    from a hardware-based pseudorandom number generator.
> >    One seed value (effectively, the output from one RDSEED
> >    command) can provide up to 511 128-bit random values
> >    before forcing a reseed"
> > 
> > We know we can exhaust RDSEED directly pretty trivially. Making your
> > test program run in parallel across 20 cpus, I got a mere 3% success
> > rate from RDSEED.
> > 
> > If RDRAND is reseeding every 511 values, RDRAND output would have
> > to be consumed significantly faster than RDSEED in order that the
> > reseed will happen frequently enough to exhaust the seeds.
> > 
> > This looks pretty hard, but maybe with a large enough CPU count
> > this will be possible in extreme load ?
> > 
> > So I'm not convinced we can blindly wave away RDRAND failures as
> > guaranteed to mean broken hardware.

> This matches both my understanding (I do have cryptography
> background and understanding how cryptographic RNGs work) and
> official public docs that Intel published on this matter.  Given
> that the physical entropy source is limited anyhow, and by giving
> enough pressure on the whole construction you should be able to make
> RDRAND fail because if the intermediate AES-CBC MAC extractor/
> conditioner is not getting its min entropy input rate, it wont
> produce a proper seed for AES CTR DRBG.  Of course exact
> details/numbers can wary between different generations of Intel DRNG
> implementation, and the platforms where it is running on, so be
> careful to sticking to concrete numbers.
>
> That said, I have taken an AR to follow up internally on what can be
> done to improve our situation with RDRAND/RDSEED. But I would still
> like to finish the discussion on what people think should be done in
> the meanwhile keeping in mind that the problem is not intel
> specific, despite us intel people bringing it for public discussion
> first. The old saying is still here: "Please don't shoot the
> messenger" )) We are actually trying to be open about these things
> and create a public discussion.

Based on Dave Hansen's comments above, it appears that the COCO
community needs to break out the oil and whetstones and hone the tips
of their pitchforks.. :-)

The positive issue in all of this is that, to date, TDX hardware has
not seen significant public availability.  I suspect that when that
happens, if this problem isn't corrected, there will be the usual
flood of papers demonstrating quasi-practical lab attacks that stem
from the fruits of a poisonable random number source.

The problem reproduces pretty easily, albeit on somewhat dated
hardware.

One of our lab machines, that reports a model name of 'Intel(R)
Core(TM) i5-6500 CPU @ 3.20GHz', shows a consistent failure rate of
65% for RDSEED on a single-threaded test.  It gets worse when more
simultaneous demand is placed on the hardware randomness source, as
was demonstrated elsewhere.

Corrupted randomness has the potential to strike pretty deeply into
the TDX attestation architecture, given the need to generate signed
attestation reports and the SGX/TDX key generation architecture that
requires 'wearout protection'.  Beyond that, there is the subsequent
need to conduct userspace attestation, currently by IMA as I believe
is the intent, that in turn requires cryptography with undeniable
integrity.

At this point, given that all this is about confidentiality, that in
turn implies a trusted platform, there is only one option, panic and
hard fail the boot if there is any indication that the hardware has
not been able to provide sound instruction based randomness.  Doing
anything else breaks the 'contract' that a user is pushing a workload
into a trusted/confidential environment.

RDSEED is the root of hardware instruction based randomness and its
randomness comes from quantum noise across a diode junction
(simplistically).  The output of RDSEED drives the AES derived RDRAND
randomness.

Additional clarification from inside of Intel on this is needed, but
the problem would appear to be that the above infrastructure
(RDSEED/RDRAND) is part of the 'Uncore' architecture, rather than
being core specific.  This creates an incestuous relationship across
all of the cores sharing a resource, that as in the past, creates
security issues.

This issue was easily anticipated and foreshadowed by the
demonstration of the CVE-2020-0543/CrossTalk vulnerability.

If the above interpretion is correct, a full fix should be 'straight
forward', for some definition of 'straight forward'... :-)

On TDX capable hardare, the RDSEED noise source needs to come from a
piece of core specific silicon.  If the boot of a TDX VM is core
locked, this would create an environment where a socket based sibling
adversary would be unable to compromise the root of the randomness
source.

Once the Linux random number generator is properly seeded, the issue
should be over, given that by now, everyone has agreed that a properly
initialized Linux RNG cannot 'run out' of randomness.

Given that it seems pretty clear that timing and other 'noise'
information in a COCO environment can't be trusted, having core
specific randomness would be a win for the overall cryptographic
health of VM's that are running in a COCO environment.

Once again, an attack doesn't need to be practical, only demonstrable.
Once demonstrated, faith is lost in the technology, SGX clearly
demonstrated that, as did the micro-architectural attacks.

Both SGX and TDX operate from the notion of 'you trust Intel and the
silicon', so the fix is for Intel to implement a secure silicon based
source of randomness.

AMD will probably need the same thing.

> Best Regards,
> Elena. 

Hopefuly the above is helpful in furthering these discussions.

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

