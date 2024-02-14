Return-Path: <linux-kernel+bounces-64983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53C85462F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E0E1C214F0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70EA12E76;
	Wed, 14 Feb 2024 09:35:27 +0000 (UTC)
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA411CA9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903327; cv=none; b=CeNhuoOn6FRYu0yoXtyAU+liWe/UAQ88T21OnMDqSGEyVA/qB56xzFcWV3OPZKJqyl/zdbCveRpco+p2ownH0JtEMUJL9E7ZYzjP4BMV4AFIwTFE0Y7ZYfp3xmBPWIllU4HUj0QdZGq2bWQ78yQ1U92sF3naNisZJuKfFpG5yjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903327; c=relaxed/simple;
	bh=BhPisRloYBOp5JHEYXaJkZ4QaiijqmCKzndK4WLH23A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3stkZEVtbUwHtta6RX9MgeVIGTDj4rpzEei3VYhPI147Y4s4/5KPhZIqrNG3L9BabvNr1AFVLb5Xz9A1AJmULErEzrd0FMCj9SmWxAL06/3fncDwxJOV9f0D0eS1IWu8s7oNo1LsqBb40Y+5hxBGoDpucygMVvbPbq8Kdq5w3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 41E9YACA010558;
	Wed, 14 Feb 2024 03:34:10 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 41E9Y9d2010555;
	Wed, 14 Feb 2024 03:34:09 -0600
Date: Wed, 14 Feb 2024 03:34:09 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dan Williams <dan.j.williams@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <20240214093409.GA10124@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20240202153927.GA119530@mit.edu> <Zb4RlTzq_LV7AzsH@zx2c4.com> <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com> <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com> <20240212163236.GA444708@mit.edu> <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch> <20240213231341.GB394352@mit.edu> <65cc0ef2c7be_29b12948d@dwillia2-mobl3.amr.corp.intel.com.notmuch> <20240214043245.GC394352@mit.edu> <b786185e-fc57-4d4a-b0aa-741b92de0c5c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b786185e-fc57-4d4a-b0aa-741b92de0c5c@suse.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Wed, 14 Feb 2024 03:34:10 -0600 (CST)

On Wed, Feb 14, 2024 at 10:34:48AM +0200, Nikolay Borisov wrote:

Hi, I hope the week is going well for everyone.

> On 14.02.24 ??. 6:32 ??., Theodore Ts'o wrote:
> >On Tue, Feb 13, 2024 at 04:53:06PM -0800, Dan Williams wrote:
> >>
> >>Indeed it is. Typically when you have x86, riscv, arm, and s390 folks
> >>all show up at a Linux Plumbers session [1] to talk about their approach
> >>to handling a new platform paradigm, that is a decent indication that
> >>the technology is more real than not. Point taken that it is not here
> >>today, but it is also not multiple hardware generations away as the
> >>Plumbers participation indicated.
> >
> >My big concerns with TDISP which make me believe it may not be a
> >silver bullet is that (a) it's hyper-complex (although to be fair
> >Confidential Compute isn't exactly simple, and (b) it's one thing to
> >digitally sign software so you know that it comes from a trusted
> >source; but it's a **lot** harder to prove that hardware hasn't been
> >tampered with --- a digital siganture can't tell you much about
> >whether or not the hardware is in an as-built state coming from the
> >factory --- this requires things like wrapping the device with
> >resistive wire in multiple directions with a whetstone bridge to
> >detect if the wire has gotten cut or shorted, then dunking the whole
> >thing in epoxy, so that any attempt to tamper with the hardware will
> >result it self-destructing (via a thermite charge or equivalent :-)

> This really reminds me of the engineering that goes into the
> omnipresent POS terminals ate every store, since they store
> certificates from the card (Visa/Master) operators. So I wonder if
> at somepoint we'll have a pos-like device (by merit of its
> engineering) in every server....

It already exists.  CoCo, at least the Intel implementation, is
dependent on what amounts to this concept.

> >Remember, the whole conceit of Confidential Compute is that you don't
> >trust the cloud provider --- but if that entity controls the PCI cards
> >installed in their servers, and and that entity has the ability to
> >*modify* the PCI cards in the server, all of the digital signatures
> >and fancy-schmancy TDISP complexity isn't necessarily going to save
> >you.

> Can't the same argument go for the CPU, though it's a lot more
> "integrated" into the silicong substrate, yet we somehow believe
> CoCo ascertains that a vm is running on trusted hardware? But
> ultimately the CPU is still a part that comes from the untrusted
> CSP.

The attestation model for TDX is largely built on top of SGX.

The Intel predicate with respect to SGX/TDX is that you have to trust
the CPU silicon implementation, if you can't entertain that level of
trust, it is game over for security.

To support that security model, Intel provides infrastructure that
proves that the software is running on a 'Genuine Intel' CPU.

Roughly, a root key is burned into the silicon that is used as the
basis for additional derived keys.  The key access and derivation
processes can only occur when the process is running software with a
known signature in a protected region of memory (enclave).

The model is to fill a structure with data that defines the
hardware/software state.  A keyed checksum is run over the structure
that allows a relying party to verify that the data structure contents
could have only been generated on a valid Intel CPU.

This process verifies that the CPU is from a known vendor, which is of
course only the initial starting point for verifying that something
like a VM is running in a known and trusted state.  But, if you can't
start with that predicate you have nothing to build on.

The actual implementation nowadays is a bit more complex, given that
all of this has to happen on multi-socket systems which involve more
than one CPU, but the concept is the same.

Have a good day.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

