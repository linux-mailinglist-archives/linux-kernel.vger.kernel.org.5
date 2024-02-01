Return-Path: <linux-kernel+bounces-48862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD34846277
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD321C21176
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46441218;
	Thu,  1 Feb 2024 21:09:38 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C6E41212
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706821777; cv=none; b=JGpDM960pqbNfCjDHdq73mYjyL1ANGOcFu2QD8xiDw5iSwHTkp+a6j8WCn6Y0G479U1L80AdlMvh9shGX0mdYdccpkSG6IFckt3cJp/HVFkWCvF+Z2chKuOOpwNi/BNi4yA0PX9Avj238BQfzlS63Nvujxwk39A+6owL2UZcCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706821777; c=relaxed/simple;
	bh=TBOTB9Czzf4Q8dqszUSC2KR1hcttocjMtosMwe5WxeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2nCqiK0rKJJWbYC6LQJLLJM7UgMrKaWC1wA2Humlt/uUME/Krj1265V2/+UtwDXQqWXK2JSjzohYJgk+SHqJ2EFAXuUmjNfb8+DP8GHAma5EDGQCiTb+Nf5j4lij33QCe+KVgrZz+IZqUQ8tHA7LGywjEPERCRD/5KiMSB7kCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 411L4BB7024212;
	Thu, 1 Feb 2024 15:04:11 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 411L4A9c024211;
	Thu, 1 Feb 2024 15:04:10 -0600
Date: Thu, 1 Feb 2024 15:04:10 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Daniel P. Berrang??" <berrange@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <20240201210410.GA24013@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com> <20240131203531.GA12035@wind.enjellic.com> <20240201044735.GC2356784@mit.edu> <20240201095451.GA17612@wind.enjellic.com> <Zbt7mXg9p6IOdcqp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbt7mXg9p6IOdcqp@redhat.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 01 Feb 2024 15:04:12 -0600 (CST)

On Thu, Feb 01, 2024 at 11:08:09AM +0000, Daniel P. Berrang?? wrote:

Hi Dan, thanks for the thoughts.

> On Thu, Feb 01, 2024 at 03:54:51AM -0600, Dr. Greg wrote:
> > I suspect that the achievable socket core count cannot effectively
> > overwhelm the 1022x amplification factor inherent in the design of the
> > RDSEED based seeding of RDRAND.

> In testing I could get RDSEED down to < 3% success rate when
> running on 20 cores in parallel on a laptop class i7. If that
> failure rate can be improved by a little more than one order
> of magnitude to 0.1% we're starting to get to the point where
> it might be enough to make RDRAND re-seed fail.
> 
> Intel's Sierra Forest CPUs are said to have a variant with 288
> cores per socket, which is an order of magnitude larger. It is
> conceivable this might be large enough to demonstrate RDRAND
> failure in extreme load. Then again who knows what else has
> changed that might alter the equation, maybe the DRBG is also
> better / faster. Only real world testing can say for sure.
> One thing is certain though, core counts per socket keep going
> up, so the potential worst case load on RDSEED will increase...

Indeed, that would seem to be the important and operative question
that Intel could answer, maybe Dave and Elena will be able to provide
some guidance.

Until someone can actually demonstrate a sustained RDRAND depletion
attack we don't have an issue, only a lot of wringing of hands and
other handwaving on what we should do.

The thing that intrigues me is that we have two AMD engineers
following this, do you guys have any comments, reflections?  Unless I
misunderstand, SEV-SNP has the same challenges and issues.

As of late you guys have been delivering higher core counts that would
make your platform more susceptible.  Does your hardware design not
have a socket common RNG architecture that makes RDSEED vulnerable to
socket adversarial depletion?  Is this a complete non-issue in
practice?

Big opportunity here to proclaim: "Just buy AMD"... :-)

> > We will see if Elena can come up with what Intel engineering's
> > definition of 'astronomical' is.. :-)
> > 
> > > There's a special case with Confidential Compute VM's, since the
> > > assumption is that you want to protect against even a malicious
> > > hypervisor who could theoretically control all other sources of
> > > timing uncertainty.  And so, yes, in that case, the only thing we
> > > can do is Panic if RDRAND fails.
> > 
> > Indeed.
> > 
> > The bigger question, which I will respond to Elena with, is how much
> > this issue calls the entire question of confidential computing into
> > question.

> A denial of service (from a panic on RDRAND fail) doesn't undermine
> confidental computing. Guest data confidentiality is maintained by
> panicing on RDRAND failure and DoS protection isn't a threat that CC
> claims to be able to mitigate in general.

Yes, if there is a problem with RDRAND we have a CoCo solution, full
stop.

The issue that I was raising with Elena is more generic, to wit:

Her expressed concern is that a code construct looking something like this,
rdrand() returning 0 on success:

for (i= 0; i < 9; ++i)
	if (!rdrand(&seed))
		break;
	sleep(some time);
}
if (i == 9)
	BUG("No entropy");

do_something_with(seed);

Could be sufficiently manipulated by a malicious hypervisor in a TDX
environment so as to compromise its functionality.

If this level of control is indeed possible, given the long history of
timing and side-channel attacks against cryptography, this would seem
to pose significant questions as to whether or not CoCo can deliver on
its stated goals.

> With regards,
> Daniel

Have a good evening.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

