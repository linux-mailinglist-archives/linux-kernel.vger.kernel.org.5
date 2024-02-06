Return-Path: <linux-kernel+bounces-54146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0DF84AB79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCA56B20E79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711DF15A4;
	Tue,  6 Feb 2024 01:18:15 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9D310F4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707182294; cv=none; b=qPg4Kv1O5ycRzmVoTIFu2KNVnrXGxSue6YyHOBvCBtg69b+msjJ5QaoY+Fc7lEc1/56TvCUpAtiUhSrcO9qiHtn61oznDVrUJRCRMzNSKTQadpfMwcFzM4NNpXOONybKB2n1fDi9gfmvbgVxii0YuITlHc4RMXszeUnCSavzea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707182294; c=relaxed/simple;
	bh=1OAsjmGWHUQHaPAdnmgD2EvriyaiRbFvOT6jgGrn8SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv9iSFNsK5UPFnJRSYw09ONXHTkQIMLXdKO21y1ZW1uzHAdmvtveBkwfu27u1XEoCa/wnw0w5yvNSErCrL1AsthkiV7QpL8A6jigLwTBv55N1nQlzNNB38ZEPoWjeEarLbVMPHLoD/SZyWwjM1dEY0pU1V/f7tZCXFsx/2+qXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4161CmKi029258;
	Mon, 5 Feb 2024 19:12:48 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4161ClJZ029257;
	Mon, 5 Feb 2024 19:12:47 -0600
Date: Mon, 5 Feb 2024 19:12:47 -0600
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
Message-ID: <20240206011247.GA29224@wind.enjellic.com>
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
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 05 Feb 2024 19:12:48 -0600 (CST)

On Wed, Jan 31, 2024 at 08:16:56AM +0000, Reshetova, Elena wrote:

Good evening, I hope the week has started well for everyone.

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

In the spirit of that philosophy we proffer the response below.

> That said, I have taken an AR to follow up internally on what can be
> done to improve our situation with RDRAND/RDSEED. But I would still
> like to finish the discussion on what people think should be done in
> the meanwhile keeping in mind that the problem is not intel
> specific, despite us intel people bringing it for public discussion
> first. The old saying is still here: "Please don't shoot the
> messenger" )) We are actually trying to be open about these things
> and create a public discussion.

Actually, I now believe there is clear evidence that the problem is
indeed Intel specific.  In light of our testing, it will be
interesting to see what your 'AR' returns with respect to an official
response from Intel engineering on this issue.

One of the very bright young engineers collaborating on Quixote, who
has been following this conversation, took it upon himself to do some
very methodical engineering analysis on this issue.  I'm the messenger
but this is very much his work product.

Executive summary is as follows:

- No RDRAND depletion failures were observable with either the Intel
  or AMD hardware that was load tested.

- RDSEED depletion is an Intel specific issue, AMD's RDSEED
  implementation could not be provoked into failure.

- AMD's RDRAND/RDSEED implementation is significantly slower than
  Intel's.

Here are the engineer's lab notes verbatim:

---------------------------------------------------------------------------
I tested both the single-threaded and OMP-multithreaded versions of
the RDSEED/RDRAND depletion loop on each of the machines below.

AMD: 2X AMD EPYC 7713 (Milan) 64-Core Processor @ 2.0 GHz, 128
physical cores total

Intel: 2X Intel Xeon Gold 6140 (Skylake) 18-Core Processor @ 2.3 GHz,
36 physical cores total

Single-threaded results:

Test case: 1,000,000 iterations each for RDRAND and RDSEED, n=100
tests, single-threaded.

AMD: 100% success rate for both RDRAND and RDSEED for all tests,
runtime 0.909-1.055s (min-max).

Intel: 100% success rate for RDRAND for all tests, 20.01-20.12%
(min-max) success rate for RSEED, runtime 0.256-0.281s (min-max)

OMP multithreaded results:

Test case: 1,000,000 iterations per thread, for both RDRAND and
RDSEED, n=100 tests, OMP multithreaded with OMP_NUM_THREADS=<total
physical cores> (i.e. 128 for AMD and 36 for Intel)

AMD: 100% success rate for both RDRAND and RDSEED for all tests,
runtime 47.229-47.603s (min-max).

Intel: 100% success rate for RDRAND for all tests, 1.77-5.62%
(min-max) success rate for RSEED, runtime 0.562-0.595s (min-max)

CONCLUSION

RDSEED failure was reproducibly induced on the Intel Skylake platform,
for both single- and multithreaded tests, whereas RDSEED failure could
not be induced on the AMD platform for either test. RDRAND did not
fail on either platform for either test.

AMD execution time was roughly 4x slower than Intel (1s vs 0.25s) for
the single-threaded test, and almost 100x slower than Intel (47s vs
0.5s) for the multithreaded test. The difference in clock rates (2.0
GHz for AMD vs 2.3 GHz for Intel) is not sufficient to explain these
runtime differences. So it seems likely that AMD is gating the rate at
which a new RDSEED value can be requested.
---------------------------------------------------------------------------

Speaking now with my voice:

Unless additional information shows up, despite our collective
handwringing, as long as the RDRAND instruction is used as the
cryptographic primitive, there appears to be little likelihood of a
DOS randomness attack against a TDX based CoCo virtual machine.

While it is highly unlikely we will ever get an 'official' readout on
this issue, I suspect there is a high probability that Intel
engineering favored performance with their RDSEED/RDRAND
implementation.

AMD 'appears', and without engineering feedback from AMD I would
emphasize the notion of 'appears', to have embraced the principal of
taking steps to eliminate the possibility of a socket based adversary
attack against their RNG infrastructure.

> Elena.

Hopefully the above is useful for everyone interested in this issue.

Once again, a thank you to our version of 'Sancho' for his legwork on
this, who has also read Cervantes at length... :-)

Have a good remainder of the week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

