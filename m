Return-Path: <linux-kernel+bounces-47921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73A8454AB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94138287215
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE24157E8C;
	Thu,  1 Feb 2024 09:59:52 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B0A4D9F4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781592; cv=none; b=Ij0e9+GwW95NMK8jL7DDuky0GWHSEClUuAayOFAMslZQNSDXIyKT9aV5mYEPm+Y/Z6rKI2ZNJVpIKNUQ+4uvJZ5HZqFsr43oMKEXi/ZuKeblvY/HSInSt8TCQGWqfzO7qKYcMDeWqNkJ+gIWiPMb/xzC2o2WAKs/myvdZDPG0jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781592; c=relaxed/simple;
	bh=HpRKshTR53h1WMYXI/4/LpBIWmTwxTMmuHtPn3QrAg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHLaQAAdHH7eoWeySvTCc0zCVUUm2QHo/tDFY6CWfr5N1Kl6rzSiF0d7Gxc4p2ACsx+iKFFXq2r8tgAJddaYQxzPCn7+nkkISAeSTENfx9oQAe9Ki68mxlVrePALTy4SlOu2VqjIFgSXxIG/vPa9jx5g5ujGpq6NsWktWwFjDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 4119sqmr017945;
	Thu, 1 Feb 2024 03:54:52 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 4119sp8g017944;
	Thu, 1 Feb 2024 03:54:51 -0600
Date: Thu, 1 Feb 2024 03:54:51 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Daniel P. Berrang??" <berrange@redhat.com>,
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
Message-ID: <20240201095451.GA17612@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240130083007.1876787-2-kirill.shutemov@linux.intel.com> <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com> <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com> <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com> <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com> <Zbk6h0ogqeInLa_1@redhat.com> <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com> <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com> <20240131203531.GA12035@wind.enjellic.com> <20240201044735.GC2356784@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201044735.GC2356784@mit.edu>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Thu, 01 Feb 2024 03:54:53 -0600 (CST)

On Wed, Jan 31, 2024 at 11:47:35PM -0500, Theodore Ts'o wrote:
> On Wed, Jan 31, 2024 at 02:35:32PM -0600, Dr. Greg wrote:
> > I think it would demonstrate a lack of appropriate engineering
> > diligence on the part of our community to declare RDRAND 'busted' at
> > this point.
> > 
> > While it appeares to be trivially easy to force RDSEED into depletion,
> > there does not seem to be a suggestion, at least in the open
> > literature, that this directly or easily translates into stalling
> > output from RDRAND in any type of relevant adversarial fashion.
> > 
> > If this were the case, given what CVE's seem to be worth on a resume,
> > someone would have rented a cloud machine and come up with a POC
> > against RDRAND in a multi-tenant environment and then promptly put up
> > a web-site called 'Random Starve' or something equally ominous.

> I suspect the reason why DOS attacks aren't happening in practice, is
> because of concerns over the ability to trust the RDRAND (how do you
> prove that the NSA didn't put a backdoor into the hardware with
> Intel's acquisence --- after all, the NSA absolutely positively didn't
> encourage the kneecaping of WEP and absolutely didn't put a trapdoor
> into DUAL_EC_DRBG...)  since it can not externally audited and verfied
> by a third party, in contrast to the source code for the /dev/random
> driver or the RNG used in OpenSSL.
> 
> As a result, most random number generators use RDRAND in combination
> with other techniques.  If RDRAND is absolutely trustworthy, the extra
> sources won't hurt --- and if it isn't trustworthy mixing in other
> sources will likely make things harder for Fort Meade.  And even if
> these other sources might be observable for someone who can listen in
> on the inter-packet arrival times on the LAN (for example), it might
> not be so easy for an analyst sitting at their desk in Fort Meade.
> 
> And once you do _that_, you don't need to necessarily loop on RDRAND,
> because it's one of multiple sources of entropies that are getting
> mixed togethwer.  Hence, even if someone drives RDRAND into depletion,
> if they are using getrandom(2), it's not a big deal.

All well taken points, the Linux RNG and associated community has
benefited from your and Jason's concerns and work on all of this.

However, whether or not DOS attacks based on RNG depletion are
happening in the wild, and the reasons they are not, are orthogonal to
whether or not they can be proven to exist, which was the point I was
trying to make.

Demonstrating a vulnerability in something as critical as Intel's RNG
implementation would be a big motivation for some research group.  The
fact that hasn't occurred would seem to suggest that the RDRAND
resource depletion we are concerned with is not adversarially
exploitable.

I suspect that the achievable socket core count cannot effectively
overwhelm the 1022x amplification factor inherent in the design of the
RDSEED based seeding of RDRAND.

We will see if Elena can come up with what Intel engineering's
definition of 'astronomical' is.. :-)

> There's a special case with Confidential Compute VM's, since the
> assumption is that you want to protect against even a malicious
> hypervisor who could theoretically control all other sources of
> timing uncertainty.  And so, yes, in that case, the only thing we
> can do is Panic if RDRAND fails.

Indeed.

The bigger question, which I will respond to Elena with, is how much
this issue calls the entire question of confidential computing into
question.

>    	    	  		     	 - Ted

Have a good day, it has been a long time since you and I were standing
around with Phil Hughes in the Galleria in Atlanta argueing about
whether or not Active Directory was going to dominate enterprise
computing.

It does seem to have gained some significant amount of traction... :-)

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

