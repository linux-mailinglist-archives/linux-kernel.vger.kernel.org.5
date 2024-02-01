Return-Path: <linux-kernel+bounces-47632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206684507E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D041F22AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E03BB43;
	Thu,  1 Feb 2024 04:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="mJ30WTYx"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA03BB24
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762911; cv=none; b=d12FDbzFFU1GZjjwFJNOUF6IDYyN206WSIcwLGnszd+2aNo3FyqPzVzc6H48W9R9gZt/2R9ZKksBKe68IKYdYME9Ap7SfDv9qBJakTxffGpWwePSMZpJzk8M2CGqZc3lL2eyOTPdPlMMB2JaZFeZyIirU2k5hLMhoQ3Vtsozgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762911; c=relaxed/simple;
	bh=/6YbQjizUZMS23f4SnahTuQrczLTdM9PS2UdU1MpK0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmRAKjQGtX8yR3bGObhESfAt8Zk5dfWkwn9ElHhKUUljtFpcGPOo6Czi0MWPrRG6Nc58RifF93vBrtcdvSlt+2Ht30cNOLe2r95VBNwjdbO1iGqplcMtQzZvlE/96CmuW5QzMtrOX32sgW7qvC/1QdIA82nS8zjPGaRw3/DaOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=mJ30WTYx; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4114lZfQ008107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 23:47:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706762860; bh=BFvwTRtGW9jE9hJ9zWULwsFsLtUy+2JhKU5qj42LjRA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=mJ30WTYxc+jicP7NtTK/sK5Qfp95EW8SIPC2VIt9Hzvo9pTY5TmZllPzbBdvk4ZUo
	 UYSUOxqKUp5oiWbSqQ4fLsWLNA+3TypHcQyeiC6pMUGXELlycJAK2TaI3D0ffRaLr2
	 P7roc1WYEgo3lj+yK0jfWco5SSFrlRma8WYGCUyA2lt/8/dLbYLJbBR8CWcR2/MIqq
	 uEHH2OuzMoxaxAee9TKjipvL/uyGMktk1sdCKRS0A2EqBVzNSs95apz28LMfoHxakU
	 ig/XuRLSYNTpATsbWP9GAevXLr3TCr7olt7sb8FJ90hrMiMIqRa/OhLWBrEjuIYdVN
	 3MlsY+rvHfWSA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8C87115C0667; Wed, 31 Jan 2024 23:47:35 -0500 (EST)
Date: Wed, 31 Jan 2024 23:47:35 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Dr. Greg" <greg@enjellic.com>
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
Message-ID: <20240201044735.GC2356784@mit.edu>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <88a72370-e300-4bbc-8077-acd1cc831fe7@intel.com>
 <CAHmME9oSQbd3V8+qR0e9oPb7ppO=E7GrCW-a2RN8QNdY_ARbSQ@mail.gmail.com>
 <Zbk6h0ogqeInLa_1@redhat.com>
 <DM8PR11MB575052B985CA97B29A443F9AE77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9ps6W5snQrYeNVMFgfhMKFKciky=-UxxGFbAx_RrxSHoA@mail.gmail.com>
 <20240131203531.GA12035@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131203531.GA12035@wind.enjellic.com>

On Wed, Jan 31, 2024 at 02:35:32PM -0600, Dr. Greg wrote:
> I think it would demonstrate a lack of appropriate engineering
> diligence on the part of our community to declare RDRAND 'busted' at
> this point.
> 
> While it appeares to be trivially easy to force RDSEED into depletion,
> there does not seem to be a suggestion, at least in the open
> literature, that this directly or easily translates into stalling
> output from RDRAND in any type of relevant adversarial fashion.
> 
> If this were the case, given what CVE's seem to be worth on a resume,
> someone would have rented a cloud machine and come up with a POC
> against RDRAND in a multi-tenant environment and then promptly put up
> a web-site called 'Random Starve' or something equally ominous.

I suspect the reason why DOS attacks aren't happening in practice, is
because of concerns over the ability to trust the RDRAND (how do you
prove that the NSA didn't put a backdoor into the hardware with
Intel's acquisence --- after all, the NSA absolutely positively didn't
encourage the kneecaping of WEP and absolutely didn't put a trapdoor
into DUAL_EC_DRBG...)  since it can not externally audited and verfied
by a third party, in contrast to the source code for the /dev/random
driver or the RNG used in OpenSSL.

As a result, most random number generators use RDRAND in combination
with other techniques.  If RDRAND is absolutely trustworthy, the extra
sources won't hurt --- and if it isn't trustworthy mixing in other
sources will likely make things harder for Fort Meade.  And even if
these other sources might be observable for someone who can listen in
on the inter-packet arrival times on the LAN (for example), it might
not be so easy for an analyst sitting at their desk in Fort Meade.

And once you do _that_, you don't need to necessarily loop on RDRAND,
because it's one of multiple sources of entropies that are getting
mixed togethwer.  Hence, even if someone drives RDRAND into depletion,
if they are using getrandom(2), it's not a big deal.

There's a special case with Confidential Compute VM's, since the
assumption is that you want to protect against even a malicious
hypervisor who could theoretically control all other sources of timing
uncertainty.  And so, yes, in that case, the only thing we can do is
Panic if RDRAND fails.

   	    	  		     	 - Ted

