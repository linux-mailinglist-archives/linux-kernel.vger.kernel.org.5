Return-Path: <linux-kernel+bounces-47639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D084508D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A1C1F2249E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E46121;
	Thu,  1 Feb 2024 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MqwSgJtn"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2C3BB3C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706763465; cv=none; b=NlxTgAN/40Yt+xotvT5qOvIk2sUfXtPbl1cPcpV7VR5M74rubU4mrPRPcqKJbPjOmbv63E5bHSEsB18qn2re9NYB7sLhxDzaX5ILDiFEyKSc8GA1Y5CA9dFbVYS2FWgt9nsOrSs6/O4L44lYV5wHZ9FBVyd6NxN67cSi4pw5nWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706763465; c=relaxed/simple;
	bh=zYVGiC1rLRFF+J+Yr82QEPl5LjdWofkbHi4aPWTR5Z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJgufzWSVhYcCWmMf0mfg3hfOejE4mPjnHNAFCaKdeQpzTbN3xU/hfuT+abHD5RjBHXL2wTArdubT6QbOW9qgEbgxFlDgmzHQjsmpiU9gk5SjgBxhpHfRXad9tzV9oufoNc2FZBPbX92HhgFWhCc9LL+k7mtx95QJpaPFkVJHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MqwSgJtn; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4114vATx012056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 23:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706763434; bh=s5ToCA1JK1JWcXOK8/ttVS+ZKfu8UHQRYtgp6PPZIrk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MqwSgJtnw4X94zDhBAH6QhHOATjVVZYoLWGI0YKJLSWQwmWWTNJLtmHmrkbkdW3YG
	 ov/cwRHzxDcMWkoZ+QGs2/X3qO/+Is1sILcwTcZXCKj+eQ7gvpgX2Filnj+BmfPxHW
	 zEKcY6ib7BfLs8zNsKvX7hAdPz9r9gOLKR7hx3IXW1jnhf71C5GCcnfEPsk3adQL0r
	 EhjRDnSms1WnNOFHwou6YDmR5oanEQg0PfTf4ENs5Gl+zhjh3f/D5WnmGfHA+ZCkzv
	 tYq2GVgzrjDM2UzjbnuirVULtYw+A0i/N85rQVmy/uelT+3CQNYIXvJzH0Cfv2+erM
	 UhQsg/cq8tdYw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4E15B15C0667; Wed, 31 Jan 2024 23:57:10 -0500 (EST)
Date: Wed, 31 Jan 2024 23:57:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <20240201045710.GD2356784@mit.edu>
References: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>

On Wed, Jan 31, 2024 at 07:01:01PM +0100, Jason A. Donenfeld wrote:
> So if this is what we're congealing around, I guess we can:
> 
> 0) Leave RDSEED alone and focus on RDRAND.
> 1) Add `WARN_ON_ONCE(in_early_boot);` to the failure path of RDRAND
> (and simply hope this doesn't get exploited for guest-guest boot DoS).
> 2) Loop forever in RDRAND on CoCo VMs, post-boot, with the comments
> and variable naming making it clear that this is a hardware bug
> workaround, not a "feature" added for "extra security".
> 3) Complain loudly to Intel and get them to fix the hardware.
> 
> Though, a large part of me would really like to skip that step (2),
> first because it's a pretty gross bandaid that adds lots of
> complexity, and second because it'll make (3) less poignant

If we need to loop more than, say, 10 seconds in a CoCo VM, I'd just
panic with a repeated RDRAND failure message.  This makes the point of
(3) that much pointed, and it's better than having a CoCo VM
mysteriously hang in the face of a DOS attack.

I'll note that it should be relatively easy for Intel to make sure
that if there is an undue draw on RDRAND, to at that point enforce
"fair share" mode where each of the N cores get at most 1/N of the
available entropy.  So if you have single core CoCo VM on a 256 core
machine trying to boot, and the evil attacker has purchased 255 cores
worth of VM's, all of which are busy-looping on RDRAND, while the CoCo
VM is booting, if it is looping on RDRAND, it should be getting
1/256th of the availabe RDRAND output, and since it is only trying to
grab enough randomness to seed the /dev/random CRNG, if it can't get
enough randomness in 10 seconds --- well, Intel's customers should be
finding another vendor's CPU that can do a better job.

			     	      	 - Ted

