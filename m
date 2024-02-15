Return-Path: <linux-kernel+bounces-66947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E939A8563E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A931C2146A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F63A12FF98;
	Thu, 15 Feb 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pmsDStBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7512FB3A;
	Thu, 15 Feb 2024 13:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002068; cv=none; b=fEpufksKNgFnhhBMbZG9u4N/xI3sxBD5dLb+mQT2K5XBCcOZRdRb7avupuEDx8FUzex1qhDPRMsgqmiczedZ2bQWFkHkvJ+74SFYI61k28ObXUo/OoqMCvEeH1k6bgHi7X+zI2VIukq2bOG6vprDp8Lz2yO3RDiYYSeWk2r0Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002068; c=relaxed/simple;
	bh=FKlHtZWfNDxZ04AeiSEPpER0SNLeAdM4WdMorVnWmZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPiA24za8wTcbqcI1KvkhYXhMsREwzox/TxzLjGpyumw7lkcaXLcB274w/SXXSq5/M9TitdEtzi57onDXcOrenTx1lLfWH+DkvMp53a6JKqaWBA9vNZckljgnXNqoz4rUAbnGsye+ZWOMurxUpKReN/Fav4wRHbKi5QRkgA6InQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pmsDStBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C7BC433F1;
	Thu, 15 Feb 2024 13:01:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pmsDStBA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708002064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ILV4sGG7xolY2UKGldmnLNxgLZat+Tcj+GmnaSdLwRk=;
	b=pmsDStBAbQNsYJflCVc7Zp+TSrz5YVhfAPL4l1lhEOc67hoMGEa+k0dk932Ql4HicJd5Ng
	SAYbF+Jcx0egG8YLVoYE79nKC7JDyCnY9K9HCMddZV6AJLVI6bQR5+MTw7JAjcI1cBQ4K8
	RIGLSJb/JuYVL9tR/dqsy4hOmTvdEUY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bf99dffa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 13:01:04 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:01:04 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <Zc4LEAOCFOBcIRXy@zx2c4.com>
References: <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
 <696a5d98-b6a2-43aa-b259-fd85f68a5707@amd.com>
 <CAHmME9pzOTdkNr=mM7yKKqLWApQ5cxjvb7R9C2eQ2QFeUEqT6A@mail.gmail.com>
 <20240214201103.GD394352@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214201103.GD394352@mit.edu>

On Wed, Feb 14, 2024 at 03:11:03PM -0500, Theodore Ts'o wrote:
> On Wed, Feb 14, 2024 at 09:04:34PM +0100, Jason A. Donenfeld wrote:
> > AMD people, Intel people: what are the fullest statements we can rely
> > on here? Do the following two statements work?
> > 
> > 1) On newer chips, RDRAND never fails.
> > 2) On older chips, RDRAND never fails if you try 10 times in a loop,
> > unless you consider host->guest attacks, which we're not, because CoCo
> > is only a thing on the newer chips.
> > 
> > If those hold true, then the course of action would be to just add a
> > WARN_ON(!ok) but keep the loop as-is.
> 
> I think we may only want to do the WARN_ON in early boot.  Otherwise,
> on older chips, if a userspace process executes RDRAND is a tight
> loop, it might cause the WARN_ON to trigger, which is considered
> undesirable (and is certainly going to be something that could result
> in a syzbot complaint).

Yea, seems reasonable. Or maybe we just don't bother adding any WARN
there and just address the CoCo thing with the patch 2/2. As it turns
out, on normal systems, the RNG is designed anyway to deal with a broken
or missing RDRAND. So maybe adding these heuristics to warn when the CPU
is broken isn't worth it? Or maybe that's an interesting thing to do?
Dunno, I'm indifferent about it I suppose. But I agree if it's added,
doing it at early boot only makes most sense.

Jason

