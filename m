Return-Path: <linux-kernel+bounces-46881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05708445BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D79285EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED912DDBB;
	Wed, 31 Jan 2024 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="giYx9HtT"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C484C12DD99
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721087; cv=none; b=l3WsmIx3lYGkFSYd/uaeDe103gh1+F+pG0flcTEjW8oCkhzlBGdWEJ2fmbzZu44yjT2noW0ynISnc/Z7rcGaISr5YeoDEDlJoODHI1S7SGHjpYZyS0sXeLX2pBwCSjAAlKVSAE49XhQELz12vXfYNnMelbSAd/PwGyM60WweYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721087; c=relaxed/simple;
	bh=tozDlWWoHJlBWRSsavVjeW3OOgiv9gnUfCqGWWzjZro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYFui5Ax4MxDJnOq+2Z7yJnuTpH/QET7XF/EOy9tSnqUNj3Bi02nNU6BJRZgohB4p2Xhbvk9b8zFsLyP/XimAHwOjlo0SyLmRQRFprLiKPG1UeF9vykF9XoTz7yNSRKajL/r0xe9YRyxsaxopqkO0jGuBZSOYRX5bahb+S7caCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=giYx9HtT; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 40VHAgLW030230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 12:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706721048; bh=c1wII69E6ZxWvvPsnKwrgulp70ifnQl9OU32+K8hAVk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=giYx9HtT83tHpzmgsba5unHIRE0RvVcYbR2/jWs5DgCz3JJ4tl/Q+9vjp3vcO0rcH
	 fVqZvhx0TzkguaoAhZt7Oi4EDw19LBSYEgrCKrRXSMxj+1C3qnjdqYAJmjh7ek83P4
	 ctMvyfUM8hS32E5UK1jxOowr3Io9+jH9qtVj3142mDoUtapfv2wVuFaz2a4w4qHuJE
	 SA+NRtIiLDaYiCQ8bHL2krvVJcdWWaIezNb9xpshoS12IRUbdv0tS2EusU9wDbBS4x
	 noS/DRV0pkKaEvgxv4BarmWz8+0te1TF2nSQ2g/dHN3h7bBMJI6N6iOzhS1Vd1nlou
	 iIQDb4rG3W4bQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 0C01215C0667; Wed, 31 Jan 2024 12:10:42 -0500 (EST)
Date: Wed, 31 Jan 2024 12:10:42 -0500
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
Message-ID: <20240131171042.GA2371371@mit.edu>
References: <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbpc8tppxuKr-hnN@zx2c4.com>

On Wed, Jan 31, 2024 at 03:45:06PM +0100, Jason A. Donenfeld wrote:
> On Wed, Jan 31, 2024 at 09:07:56AM -0500, Theodore Ts'o wrote:
> > What about simply treating boot-time initialization of the /dev/random
> > state as special.  That is, on x86, if the hardware promises that
> > RDSEED or RDRAND is available, we use them to initialization our RNG
> > state at boot.  On bare metal, there can't be anyone else trying to
> > exhaust the on-chip RNG's entropy supply, so if RDSEED or RDRAND
> > aren't working available --- panic, since the hardware is clearly
> > busted.
> 
> This is the first thing I suggested here: https://lore.kernel.org/all/CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com/
> 
> But Elena found this dissatisfying because we still can't guarantee new
> material later.

Right, but this is good enough that modulo in-kernel RNG state
compromise, or the ability to attack the underlying cryptographic
primitives (in which case we have much bigger vulnerabilities than
this largely theoretical one), even if we don't have new material
later, the in-kernel RNG for the CC VM should be sufficiently
trustworthy for government work.

> Yea, maybe bubbling the RDRAND DoS up to another DoS in the CoCo case is
> a good tradeoff that will produce the right pitchforkers without
> breaking anything real.

<Evil Grin>

					- Ted

