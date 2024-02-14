Return-Path: <linux-kernel+bounces-64731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD57854215
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 05:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB541C21D50
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26163BE5D;
	Wed, 14 Feb 2024 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="SouPc8Yt"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E93D72
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707885209; cv=none; b=jUJCkzbgMtXQwI9L+11vdMDKI80kqx6vYxv7m7xOGogz1s5XGVY50VmHDBw5r7kYC6s1cRYxBeq64kNlNlT34M3ENbbcebmEsy+tadVGV7NeF5dmgKaH/is0GMdeCuIOxkcKK8v9lqigEV4lRLdnzlh5NRYlOrFFH7N/uF9Hf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707885209; c=relaxed/simple;
	bh=vbnx9bJUFXBRdpjFIh87IE7ClG+etFV3y7XeKgjW7vA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbzD4TZbx6t2Dbn2c6VlpsDpWTtYCKSxWn4Aw5xWNaJaOhqeUvoR4IHdGYZDCyuR0ycKLYidp+PoITXa1oIm2eO347Q9jCP1sQ+4GWTi9wy3+8j1ol9L+SJNgdaxsdXN17xwaSFGxQ7bE7IzfrvE2Cg45M3N0kSCaNVUeHhpcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=SouPc8Yt; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-68.bstnma.fios.verizon.net [173.48.116.68])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41E4Wj0A032414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 23:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1707885169; bh=dz5E+Iw3PUPxiWRO7UVNU2WbDjDTPtv7kKqud3GVzw4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=SouPc8Yt4ZkxzMtK1pAWmR5yuzdqxFQkwBpVP+R3qxrDAW115Vbu0Om7KPuL9LU9a
	 i5I1ot3dGA0qemmrpvDTlBqHuvRbbPgrAdty5KbPFNcpjUBdhALso9G/agiPyuKnNA
	 FN09Agn0EFhx/Zj5HUggFFHK2hxkU+9Y8W/hGsr6e/XoguWuDXlZJiP5lJvSapkRcl
	 veG71bofsrr3xkWJyslZxLrft7CdiGbEracALOkZ17iPA5qF7RxoBERWRC92ljc/sS
	 l1yFzPff3SqYZtNC+H3iXPf9E1n7qTbRVIgzu6ryVQgTaRg1thRH771x+oFW3kKUSo
	 pDZr06SjhbHlQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 60E9715C0336; Tue, 13 Feb 2024 23:32:45 -0500 (EST)
Date: Tue, 13 Feb 2024 23:32:45 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <20240214043245.GC394352@mit.edu>
References: <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
 <Zb4RlTzq_LV7AzsH@zx2c4.com>
 <CAHmME9owdbHzfb66xisoWmvWeT_-hkxCu7tR2=Rbye_ik1JgQQ@mail.gmail.com>
 <DM8PR11MB5750C1A848A9F1EF6BE66241E7482@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240212163236.GA444708@mit.edu>
 <65cb1a1fe2dda_29b1294e@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240213231341.GB394352@mit.edu>
 <65cc0ef2c7be_29b12948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65cc0ef2c7be_29b12948d@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Tue, Feb 13, 2024 at 04:53:06PM -0800, Dan Williams wrote:
> 
> Indeed it is. Typically when you have x86, riscv, arm, and s390 folks
> all show up at a Linux Plumbers session [1] to talk about their approach
> to handling a new platform paradigm, that is a decent indication that
> the technology is more real than not. Point taken that it is not here
> today, but it is also not multiple hardware generations away as the
> Plumbers participation indicated.

My big concerns with TDISP which make me believe it may not be a
silver bullet is that (a) it's hyper-complex (although to be fair
Confidential Compute isn't exactly simple, and (b) it's one thing to
digitally sign software so you know that it comes from a trusted
source; but it's a **lot** harder to prove that hardware hasn't been
tampered with --- a digital siganture can't tell you much about
whether or not the hardware is in an as-built state coming from the
factory --- this requires things like wrapping the device with
resistive wire in multiple directions with a whetstone bridge to
detect if the wire has gotten cut or shorted, then dunking the whole
thing in epoxy, so that any attempt to tamper with the hardware will
result it self-destructing (via a thermite charge or equivalent :-)

Remember, the whole conceit of Confidential Compute is that you don't
trust the cloud provider --- but if that entity controls the PCI cards
installed in their servers, and and that entity has the ability to
*modify* the PCI cards in the server, all of the digital signatures
and fancy-schmancy TDISP complexity isn't necessarily going to save
you.

The final concern is that it may take quite a while before these
devices become real, and then for cloud providers like Amazon, Azure,
to actually deploy them.  And in the meantime, Confidential Compute
VM's are already something which are available for customers to
purchase *today*.  So we need some kind of solution right now, and
preferably, something which is simple enough that it is likely to be
back-portable to RHEL.

(And I fear that even if TDISP hardware existed today, it is so
complicated that it may be a heavy lift to get it backported into
enterprise distro kernels.)

Ultimately, if CPU's can actually have an architectgural RNG ala
RDRAND/RDSEED that actually can do the right thing in the face of
entropy draining attacks, that seems to be a **much** simpler
solution.  And even if it requires waiting for the next generation of
CPU's, this might be faster than waiting for the TDISP ecosystem
mature.

					- Ted

