Return-Path: <linux-kernel+bounces-57872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAE84DE6B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753A31F27E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740541A88;
	Thu,  8 Feb 2024 10:36:39 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F61DFC4
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388598; cv=none; b=jT5HCH6SHE23qXCuxDpkOxz0GADy1jo41mYEorQHxHqdlCP2vESZVF07cdcVvoHXXedeB0De//EzcPbMocwcUDbx8LwP46VutPy+0tksJYgXcY+Y/52H4t2HGCJ8YzmoPGwVnnWhqQGyms92SMDfFIbtqX+jgGPhN8Z4JDMRVso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388598; c=relaxed/simple;
	bh=HEbzkWf7E48tqxLX+5DXDAgO+/sJmFhalyk/7wcrN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbbdl8Gci5iBdtTnbF5UQKde0ieIz/syM7m6OPpGmOM5JLGnjf1WewtqBx9IjHSo4khP4Zzjlwb3qqaMon5gfxYtAPiXik8jLNL66Dipy02tL9UwY3GFDqW1Ot8q2sVhycHslYdgz4UVHjc3N+HsnKT1QWOOv+IOZc9I5b9SbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 418AVCnJ023148;
	Thu, 8 Feb 2024 04:31:12 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 418AVBGq023147;
	Thu, 8 Feb 2024 04:31:11 -0600
Date: Thu, 8 Feb 2024 04:31:11 -0600
From: "Dr. Greg" <dg@enjellic.com>
To: "Daniel P. Berrang??" <berrange@redhat.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20240208103111.GA22549@wind.enjellic.com>
Reply-To: "Dr. Greg" <dg@enjellic.com>
References: <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <20240206011247.GA29224@wind.enjellic.com> <ZcHoKUElwXGPzrWb@redhat.com> <20240206120445.GA1247@wind.enjellic.com> <ZcItU5FKlIVEEVte@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcItU5FKlIVEEVte@redhat.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 08 Feb 2024 04:31:12 -0600 (CST)

On Tue, Feb 06, 2024 at 01:00:03PM +0000, Daniel P. Berrang?? wrote:

Good morning.

> On Tue, Feb 06, 2024 at 06:04:45AM -0600, Dr. Greg wrote:
> > On Tue, Feb 06, 2024 at 08:04:57AM +0000, Daniel P. Berrang?? wrote:
> > 
> > Good morning to everyone.
> > 
> > > On Mon, Feb 05, 2024 at 07:12:47PM -0600, Dr. Greg wrote:
> > > > 
> > > > Actually, I now believe there is clear evidence that the problem is
> > > > indeed Intel specific.  In light of our testing, it will be
> > > > interesting to see what your 'AR' returns with respect to an official
> > > > response from Intel engineering on this issue.
> > > > 
> > > > One of the very bright young engineers collaborating on Quixote, who
> > > > has been following this conversation, took it upon himself to do some
> > > > very methodical engineering analysis on this issue.  I'm the messenger
> > > > but this is very much his work product.
> > > > 
> > > > Executive summary is as follows:
> > > > 
> > > > - No RDRAND depletion failures were observable with either the Intel
> > > >   or AMD hardware that was load tested.
> > > > 
> > > > - RDSEED depletion is an Intel specific issue, AMD's RDSEED
> > > >   implementation could not be provoked into failure.
> > 
> > > My colleague ran a multithread parallel stress test program on his
> > > 16core/2HT AMD Ryzen (Zen4 uarch) and saw a 80% failure rate in
> > > RDSEED.
> > 
> > Interesting datapoint, thanks for forwarding it along, so the issue
> > shows up on at least some AMD platforms as well.
> > 
> > On the 18 core/socket Intel Skylake platform, the parallelized
> > depletion test forces RDSEED success rates down to around 2%.  It
> > would appear that your tests suggest that the AMD platform fairs
> > better than the Intel platform.

> Yes, given the speed of the AMD RDRAND/RDSEED ops, compared to my
> Intel test platforms, their DRBG looks better able to keep up with
> the demand for bits.

We now believe the observed resiliency of AMD's RNG infrastructure
comes down to the fact that the completion times of their RNG
instructions are significantly slower than Intel's.

SkyLake and KabyLake instruction completion times are documented at
463 clock cycles, regardless of operand size.

AMD Ryzen documents variable completion times based on operand size.
16 and 32 bit transfers complete in 1200 clock cycles with 64 bit
requests completing in 2500 clock cycles.

Given that Jason's test program was issueing 64-bit RNG requests, the
AMD platforms are going to be approximately 5.4 times slower than
Intel platforms, provided the results are corrected for CPU clock
rates.

AMD's entropy source is execution jitter time over a bank of inverter
based ring oscillors, presumably sampled by a constant clock rate
sampler.  Slower instruction retirement times consumes less of the
constant rate entropy production.

Intel uses thermal/quantum noise across a diode junction retrieved by
a self-clocked sampler.  Faster instruction retirement translates into
increased bandwidth demands on the sampler.

> > Of course, the other variable may be how the parallelized stress test
> > is conducted.  If you would like to share your implementation source
> > we could give it a twirl on the systems we have access to.
> 
> It is just Jason's earlier test program, but moved into one thread
> for each core....
> 
> $ cat cpurngstress.c
> #include <stdio.h>
> #include <immintrin.h>
> #include <pthread.h>
> #include <unistd.h>
> 
> /*
>  * Gives about 25 seconds walllock time on my Alderlake CPU
>  *
>  * Probably want to reduce this x10, or possibly even x100
>  * on AMD due to much slower ops.
>  */
> #define MAX_ITER 10000000
> 
> #define MAX_CPUS 4096
> 
> void *doit(void *f) {
>     unsigned long long rand;
>     unsigned int i, success_rand = 0, success_seed = 0;
> 
>     for (i = 0; i < MAX_ITER; ++i) {
>         success_seed += !!_rdseed64_step(&rand);
>     }
>     for (i = 0; i < MAX_ITER; ++i) {
>         success_rand += !!_rdrand64_step(&rand);
>     }
> 
>     fprintf(stderr,
> 	    "RDRAND: %.2f%%, RDSEED: %.2f%%\n",
> 	    success_rand * 100.0 / MAX_ITER,
> 	    success_seed * 100.0 / MAX_ITER);
> 
>     return NULL;
> }
> 
> 
> int main(int argc, char *argv[])
> {
>     pthread_t th[MAX_CPUS];
>     int nproc = sysconf(_SC_NPROCESSORS_ONLN);
>     if (nproc > MAX_CPUS) {
>       nproc = MAX_CPUS;
>     }
>     fprintf(stderr, "Stressing RDRAND/RDSEED across %d CPUs\n", nproc);
> 
>     for (int i = 0 ; i < nproc;i ++) {
>       pthread_create(&th[i], NULL, doit,NULL);
>     }
> 
>     for (int i = 0 ; i < nproc;i ++) {
>       pthread_join(th[i], NULL);
>     }
> 
>     return 0;
> }
> 
> $ gcc -march=native -o cpurngstress cpurngstress.c

Thanks for forwarding your test code along, we've added it to our
tests for comparison.

> > If there is the possibility of over-harvesting randomness, why not
> > design the implementations to be clamped at some per core value such
> > as a megabit/second.  In the case of the documented RDSEED generation
> > rates, that would allow the servicing of 3222 cores, if my math at
> > 0530 in the morning is correct.
> > 
> > Would a core need more than 128 kilobytes of randomness, ie. one
> > second of output, to effectively seed a random number generator?
> > 
> > A cynical conclusion would suggest engineering acquiesing to marketing
> > demands... :-)

> My assumption is that it was simply easier to not implement a rate
> limiting feature at the CPU level and punt the starvation problem to
> software :-)

Could be, it does seem unlikely that random number generation speed
would be seen as fertile ground for marketing types.

Punting to software is certainly rationale, perhaps problematic in a
CoCo environment depending on the definition of 'astronomical'.  See
my response to Borislav who was kind enough to respond to all of this.

> With regards,
> Daniel

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

