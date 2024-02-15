Return-Path: <linux-kernel+bounces-66936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A96888563CB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB431C237A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866912F39C;
	Thu, 15 Feb 2024 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KSpbnvKz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566212B162;
	Thu, 15 Feb 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708001933; cv=none; b=g7LnPkp9zdptm+dEvjlHPSoVDldGhB9UO0iVCOjedJXyNjuXDq2BeOPIZq5hwCCfJPPNO82DarpU2bIGJLjC8EX37ZW6a4X5hWQSHMGNvAB+Mzt2AJkmNR1e8XikL7GIsgp1MtBAnm80Ub74A1yobmBjHJxfgtRCZVCrrw1elww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708001933; c=relaxed/simple;
	bh=Ad/rzeg0qm+b8E72/V5gLfBzXXiMiZDjEciTC6pPZ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSPzFhM8yRiRu6RBOr3xgTR6MdWOx0oM+9uqm8MocUHPTo31Cj1TqPVwJ29SBa9TeN96MVlPq4iNUMKiFHFMl3V8x8DiIPesQG5vQ4fNm5KSIF/Cac52RnE2azZQ41fSrCUUpp5nMUs3XiX+moWwjGGaRmmAltduOnSauaARehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KSpbnvKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564EC433F1;
	Thu, 15 Feb 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KSpbnvKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708001929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dsxfcdPhD8kEeco8ZBp7CrkSEujEWrVukxbbEuEYW4M=;
	b=KSpbnvKzEbTsf3lyoqZVbKXYcOb0fjXmc8hoHRG/bglLZ20AuWeR/meJcQb1fLN8cv2zVb
	c9rvaJgbwrw8hLuUNPNSafs3KnvRFXTKZCvBZ9xeeQryDN1c+qySTFjzPpkmvSeAzss8Ii
	/DRRfnIN6ggqZ3N21gDSKiNZTK5rA78=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e0407208 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 12:58:48 +0000 (UTC)
Date: Thu, 15 Feb 2024 13:58:47 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <Zc4Kh6IPHYM56IcS@zx2c4.com>
References: <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
 <DM8PR11MB57503E654C8A0E9A41CB68AFE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zc0VW_NQGLWCSJwF@zx2c4.com>
 <DM8PR11MB5750D504AC62AA407441901BE74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB5750D504AC62AA407441901BE74D2@DM8PR11MB5750.namprd11.prod.outlook.com>

On Thu, Feb 15, 2024 at 07:07:45AM +0000, Reshetova, Elena wrote:
> > You said that RDRAND is faster than the bus, so failures won't be
> > observable, while RDSEED is not because it requires collecting entropy
> > from the ether which is slow. That makes intuitive sense on a certain
> > dumb simplistic level: AES is just an algorithm so is fast, while
> > entropy collection is a more physical thing so is slow. But if you read
> > the implementation details, RDRAND is supposed to reseed after 511
> > calls. So what's to stop you from exhausting RDSEED in one place, while
> > also getting RDRAND to the end of its 511 calls, and *then* having your
> > victim make the subsequent RDRAND call, which tries to reseed (or is in
> > progress of doing so), finds that RDSEED is out of batteries, and
> > underflows? What's the magic detail that makes this scenario not
> > possible?
> 
> This was on my list of scenarios to double check whenever it is possible
> or not, and the answer is that it is not possible (at least for Intel).
> This scenario is also briefly described in the public doc [1]:
> 
> " Note that the conditioner does not send the same seed values to both the
>  DRBG and the ENRNG. This pathway can be thought of as an alternating
> switch, with one seed going to the DRGB and the next seed going to the ENRNG. 
> *This construction ensures* that a software application can never obtain the
>  value used to seed the DRBG, *nor can it launch a Denial of Service (DoS) 
> attack against the DRBG through repeated executions of the RDSEED instruction.*"

Interesting, and good to hear. So also implicit must be that the time
required by 511 calls to RDRAND exceeds the reseeding time, so that you
couldn't exhaust the seeds indirectly by flushing RDRAND.

Jason

