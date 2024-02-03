Return-Path: <linux-kernel+bounces-51116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE18486B8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FE09B2334E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D625D919;
	Sat,  3 Feb 2024 14:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="YYN4u85c"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D12BAEF
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706970998; cv=none; b=UB4lUjZmw64KekFHjLMc23qFuDVxwPPqcLdSgjNJ/YEXjOxmGnn6A+esQ7jBPS7/e8wxEr+dYjmP01nhN9liijlznODdM2BJeF4RluzbANCG/UcFrlECF1y2gjosLlZFBo/OjhHBg7euDvQfST/zQ24FrDYL0HQcQ9LwRCdUsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706970998; c=relaxed/simple;
	bh=5zVRnjyDndBGcBDaYKnA/6ke/KUEwTKEduciNLtEb20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l577PJBBSwDHBwLk9wa4MavSR2Br0xu/bG891gh6bdelyxdg0hvFFS7qiHhPPEOGfKOBUKJXOY12nWFL4IRECgVZ5hhktTuOWcs7jXd1jhyeBscz1iMIQnOTLNbvnEymJPqZrn4KjC9/uj4q68K889I4k++6uzL5ehy2BthN+Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=YYN4u85c; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 413EZl0m014620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 09:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1706970953; bh=W9QRnEoj1oim8rFp3GQ1Wc3cLjSRInO2QO0PatD71QY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=YYN4u85clNWA8JLLCI02AQorfr9PBNeSBudlXfEAghMoEz0ZTBX7ghOZdHIcOLzER
	 sso4j0KZjG5omETRiKLSrvvArg1CpQdW2ZKYU70F/1fp0It9dsx+x1eYjohjvHk+nf
	 406gLLSAJ5fqnLdQ1gcAXvLTYBNF9SjoTKDI8WNOxTCktL/Onfows6h/+K6AcFK08V
	 ZYvbJ/8duGPRC2fjNpSO9okEUmqeh8fSquvfsUZ+VDk243VZuek02iZIlznCVtdQS7
	 xZDoCTyPpPoEfN2tP5um/biKDEPB4YKgDbbh1C4dH1GPafv2aU4xzocVoRJQDCKITn
	 i/su3IuLPf62g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 3ED9915C02FC; Sat,  3 Feb 2024 09:35:47 -0500 (EST)
Date: Sat, 3 Feb 2024 09:35:47 -0500
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
Message-ID: <20240203143547.GC36616@mit.edu>
References: <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <ad1a131a006bf98a506e767a01f5022358b3e291.camel@linux.ibm.com>
 <20240202160515.GC119530@mit.edu>
 <6ccd8c7998542f1ac68514700fb9e31049a3a3c7.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ccd8c7998542f1ac68514700fb9e31049a3a3c7.camel@linux.ibm.com>

On Fri, Feb 02, 2024 at 10:28:01PM +0100, James Bottomley wrote:
> 
> My big concern is older cpus where rdrand/rdseed don't produce useful
> entropy.  Exhaustion attacks are going to be largely against VMs not
> physical systems, so I worry about physical systems with older CPUs
> that might have rdrand issues which then trip our Confidential
> Computing checks.

For (non-CC) VM's the answer is virtio-rng.  This solves the
exhaustion problem, since if you can't trust the host, the VM's
security is taost anyway (again, ignoring Confidential Compute).

> The signal for rdseed failing is fairly clear, so if the node has other
> entropy sources, it should continue otherwise it should signal failure.
> Figuring out how a confidential computing environment signals that
> failure is TBD.

That's a design decision, and I believe we've been converging on a
panic during early boot.  Post boot, if we've successfully succeeded
in initializing the guest kernel's RNG, we're secure so long as the
cryptographic primitives haven't been defeated --- and if we have,
such as if Quantuum Computing because practical, we've got bigger
problems anyway.

					- Ted

