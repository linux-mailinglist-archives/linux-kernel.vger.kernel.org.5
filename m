Return-Path: <linux-kernel+bounces-50096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E4E84742F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611F028F9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4191474D0;
	Fri,  2 Feb 2024 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XXcPMMbC"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28314A4D4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889988; cv=none; b=Yi1fpGms9kLnCPAPPsclOHG1UPuoSLg4a2q/9DcluujS8cpaFC5s98f2lcZOG/Xt3RQGj/l75ni9CQ7lFjKQZzdzV8seJe4gC3+Z1Z9FKNl/WPqEQJ7kjHlwIui+x7DtNyFwbsT04qrBlAYIKvqhztoMlczUToM7Dr9FSiTVqZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889988; c=relaxed/simple;
	bh=Dvndydm0WQiAr8SlU79W28MqK5iSck9hcErAZtsmIyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJX7CaKS4YVkQsP3hnAzh2PmO61lssxJwFhp7GpTUzVGn11hM/jF1PZpK4Hh0I4PLf+6AE4lQctI3dZpjwe63c+BNYowi7RXo4kx9M/BKBql0L4W+HmXQ1IDk7FDGRyGGLGmreVrqJ4H0kuV66V2gRpSZapvAZtyvUaMgY59+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XXcPMMbC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-13.bstnma.fios.verizon.net [173.48.116.13])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 412G5FUn028060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 11:05:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706889920; bh=YNDwaYqILYROFbZ2T7wdnv8w+SAS5ZpbU073hZkeTiI=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=XXcPMMbCQXCYHB/LLJaHRJrNlhp80U9c2YRyCNdycadKxv7zueJalMaApizf6gv1t
	 z5l6HH5428VQbFp7BT1GMx3w8iiZIHFaCp+X+FNmjqXFUtrjibjupf6AzfI/+9HS91
	 Jtr+FgTOtX4Atz4KN4UwZlglm4rZbd5SbAG5DPOYKXLeDa/+ztBh9WD0bY5RvniO2Q
	 Nhk4HXt6Uw5zh1+ZaLrC9b/dO41Er4QHPDGMBGoFBpBduyM1ybZ8IEZ/vCsIVb+Wip
	 jSxLpDJckcw46RAkCyQEb2zfAV+xW2RseHs79eg2+ZoZOpQLNXI43iB+twSQunUJnH
	 Gypz0AcZcNs/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 536D015C02FC; Fri,  2 Feb 2024 11:05:15 -0500 (EST)
Date: Fri, 2 Feb 2024 11:05:15 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Bottomley <jejb@linux.ibm.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20240202160515.GC119530@mit.edu>
References: <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <ad1a131a006bf98a506e767a01f5022358b3e291.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad1a131a006bf98a506e767a01f5022358b3e291.camel@linux.ibm.com>

On Fri, Feb 02, 2024 at 04:47:11PM +0100, James Bottomley wrote:
> 
> It's a lot to quote, so I cut it, but all of your solutions assume a
> rdseed/rdrand failure equates to a system one but it really doesn't: in
> most systems there are other entropy sources.  In confidential
> computing it is an issue because we have no other trusted sources.  The
> problem with picking on rdseed/rdrand is that there are bound to be
> older CPUs somewhere that have rng generation bugs that this will
> expose.

I'm not sure what you're concerned about.  As far as I know, all of
the CPU's have some variant of Confidential Compute have some kind of
RDRAND-like command.  And while we're using the term RDRAND, I'd
extend this to any CPU architecture-level RNG instruction which can
return failure if it is subject to exhaustion attacks.

> How about making the failure contingent on the entropy pool
> not having any entropy when the first random number is requested?

We have tried to avoid characterizing entropy sources as "valid" or
"invalid".  First of all, it's rarely quite so black-and-white.
Something which is vulnerable to someone who can spy on inter-packet
arrival times by having a hardware tap between the CPU and the network
switch, or a wireless radio right next to the device being attacked,
might not be easily carried out by someone who doesn't have local
physical access.

So we may be measuring various things that might or might not have
"entropy".  In the case of Confidential Compute, we have declared that
none of those other sources constitute "entropy".  But that's not a
decision that can be made by the computer, or at least until we've
tracked the AGI problem.  (At which point, we might have other
problems --- "I'm sorry, I'm afraid I can't do that.")

	     	  	     	      - Ted

