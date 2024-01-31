Return-Path: <linux-kernel+bounces-46663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F266F844261
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919AB1F2E225
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86412A15E;
	Wed, 31 Jan 2024 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZM5My5wo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674A84A52;
	Wed, 31 Jan 2024 14:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712751; cv=none; b=UegH0DUL+ftOE9N9aM6kl8XY3Ynubqe8gmqZJlEx9HBOo+R6FLS2O8aEe87pvjCtIDJA6jRTfS+2RjJLTQH8qNfWNg4aP4q5jVXb1OE1L9omYOZlkuagSSmAmy+z245oQVjELabKEHzvJCQ4dbT9LyifVdAcJXxOHGeXjU/y2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712751; c=relaxed/simple;
	bh=CAVuopFYw2Cq9k4IZHTbz/jUD6sj9hYEe12XppGE8tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnOxWf5bZGT8ADzbWJwTLQk/XqKDb12vzqSEM2Gohxkj7LR47Yo7MyFAsKWSqggoV987bQRLfd2Qz19zgPaYvweQ5ZiD0MtdjLzPSUjev2ja09ouByAXATP5oIQ2kCOMeULMmzYYDaVhDuxoVG4BRwOkX6PReWQREY1OwX04W4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ZM5My5wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9202C43601;
	Wed, 31 Jan 2024 14:52:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZM5My5wo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706712747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08V5Tn/E3QHiknxLw9Mvmg79PQM1lmEyJEgFVM+dfA0=;
	b=ZM5My5woF1RnrEBzh7NrcqN2HvNxx1AExBaNWhqTm2lUemCmQdNGipM8JH9pThNLq7da16
	Ds4ggg+Q5amSpO0B9NQviIIWB9XJAC9hMytXOFyoNoLwP7JUVgqXDQudQK769svE+IqIhf
	VSfCOqaSPVBWKuBUK49CbbmqzMtSCVI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6f61bf04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jan 2024 14:52:27 +0000 (UTC)
Date: Wed, 31 Jan 2024 15:52:26 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <ZbpequdB0dQdH6aA@zx2c4.com>
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
Content-Type: text/plain; charset=utf-8
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
> 
> > On a guest OS, if confidential compute is enabled, and if RDSEED and
> > RDRAND don't work after N retries, and we know CC is enabled, panic,
> > since the kernel can't provide the promised security gaurantees, and
> > the CC developers and users are cordially invited to sharpen their
> > pitchforks and to send their tender regards to the Intel RNG
> > engineers.
> 
> Yea, maybe bubbling the RDRAND DoS up to another DoS in the CoCo case is
> a good tradeoff that will produce the right pitchforkers without
> breaking anything real.

One problem, though, is userspace can DoS the kernel's use of RDRAND.
So probably infinitely retrying in CoCo environments is better than
panicing/warning, since ostensibly a kthread will eventually succeed.

Maybe, though, the Intel platform just simply isn't ready for CoCo, and
marketing got a little bit ahead of the tech?

Jason

