Return-Path: <linux-kernel+bounces-44789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD18184276A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D9381C26FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C927FBA3;
	Tue, 30 Jan 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U0S1J1X2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BD7E578;
	Tue, 30 Jan 2024 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626849; cv=none; b=V7b6FFmrkto1E9wx/RDHlu/Nz1WPC0vmC18BvEwhmgS/nIR7i7vv3pRa7t8xshsb+eGpo7BKGA8Ln25pvhTCTSMGz1g9Vj/xuvrrP+UHqfWSPb0czf0UHnltw3sVz0jVVJRIboY9uRSgRjlK+vHSoUd2aOW69IVL/AHZEwSWc4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626849; c=relaxed/simple;
	bh=4qpjlgFvnRxSYoqozHHFiDmpvUwGwaRo34COft/1gDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIVzNE/RFt5GES1lO6Xo0hz/H+MAsp2gHI3RhMKmXfuzTya47/18WND/tDukJdWO4bs3LwVKB/VkQfFgmdNBbUIvv6Mxc6o0LAU2vYNsgGqxVxikvJ9PSd3wAA5JarjJ/Kp/aoMlK5nmOmrdw4Aj3XHczzZ/t2Cq1itxHbLvnIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=U0S1J1X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D8DC433F1;
	Tue, 30 Jan 2024 15:00:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U0S1J1X2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706626844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zblYLYwNZ4cge9X2bnUsN+nY4bwbL11gVrn6W4nM2wc=;
	b=U0S1J1X2olcCsxMv+q5Da9spxGrhLCSJEkRJuyqeVJ3ZgO8ut8Da/arMIk1BiCn5Sy1rlx
	QaKBb1CKNsb/x17Wf2JpMzQGB43WUgnbSTK0XlSN4lrUXaJ/n4MQd9H4yBBNdvvCQxANmD
	cprKPTOvGH07V2eICjEOkEQ8VsK6J2E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 42f035c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 15:00:44 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:00:42 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/random: Issue a warning if RDRAND or RDSEED fails
Message-ID: <ZbkPGl7sdg5NZMtn@zx2c4.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <20240130083007.1876787-2-kirill.shutemov@linux.intel.com>
 <CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com>
 <DM8PR11MB57507611D651E6D7CBC2A2F3E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9odqcxdak3HK-XD6-H0SjYmecnTsxzDhYy+-0shhTFygQ@mail.gmail.com>
 <DM8PR11MB57507D16E4A4679AD4B4B964E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM8PR11MB57507D16E4A4679AD4B4B964E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 02:55:08PM +0000, Reshetova, Elena wrote:
> 
> 
> > On Tue, Jan 30, 2024 at 2:45 PM Reshetova, Elena
> > <elena.reshetova@intel.com> wrote:
> > > No, this is not the case per Intel SDM. I think we can live under a simple
> > > assumption that both of these instructions can fail not just due to broken
> > > HW, but also due to enough pressure put into the whole DRBG construction
> > > that supplies random numbers via RDRAND/RDSEED.
> > 
> > Yea, thought so.
> > 
> > > I guess your concern about DoS here is for the case when we don’t
> > > trust the host/VMM *and* assume malicious userspace, correct?
> > > Because in non-confidential computing case, the Linux RNG in such
> > > case will just use non-RDRAND fallbacks, no DoS will happen and we
> > > should have enough entropy that is outside of userspace control.
> > 
> > Don't think about the RNG for just one second. The basic principle is
> > simpler: if you have a
> > `WARN_ON(unprivd_userspace_triggerable_condition)`, that's usually
> > considered a DoS - panic_on_warn and such.
> 
> Ok, agree, you do bring a valid point that we should not create new 
> DoS attack vectors from  userspace in such cases. 
> 
> > 
> > > >
> > > > And if the DoS thing _is_ a concern, and the use case for this WARN_ON
> > > > in the first place is the trusted computing scenario, so we basically
> > > > only care about early boot, then one addendum would be to only warn if
> > > > we're in early boot, which would work because seeding via RDRAND is
> > > > attempted pretty early on in init.c.
> > >
> > > I don’t think we are only concerned with initial early boot and initial seeding.
> > > What about periodic reseeding of ChaCha CSPRNG? If you don’t get
> > > RDRAND/RDSEED output during this step, don’t we formally loose the forward
> > > prediction resistance property of Linux RNG assuming this is the only source
> > > of entropy that is outside of attacker control?
> > 
> > If you never add new material, and you have the initial seed, then
> > it's deterministic. But you still mostly can't backtrack if the state
> > leaks at some future point in time.
> 
> I am not talking about backtrack resistance, i.e. when attacker learns about 
> RNG state and then can recover the past output. I was talking about an attacker
> learning the RNG state at some point of time (RNG compromise) and
> then for RNG being able to recover over time from this state to a secure state using 
> fresh entropy input that is outside of attacker control/observance.
> Does Linux RNG aim to provide this property? Do people care about this? 
> If noone cares about this one and Linux RNG doesn’t aim to provide it anyhow,
> then I agree that we should just ensure that early entropy collection includes
> RDRAND/RDSEED input for confidential VMs one way or another.

That's the first thing I mentioned -- "If you never add new material,
and you have the initial seed, then it's deterministic." The property
you mention is a good one to have and Linux usually has it. 


> 
> Best Regards,
> Elena.
> 
> > 
> > Jason

