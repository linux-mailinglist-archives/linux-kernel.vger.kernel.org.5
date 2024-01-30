Return-Path: <linux-kernel+bounces-44811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 339468427B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3B11F2645F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC86DD10;
	Tue, 30 Jan 2024 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fYHyC8VM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498654F94;
	Tue, 30 Jan 2024 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627546; cv=none; b=BUnIdP45dSjY3qeXADmUyETphwFgMbKGTzR88trg9iQ7leFRGWdJmi1bxJhjUe9e6veykbg2ltXF76Vw8gtDoI2mYlAn4FOFbRqEXU3qwZT1oP3QyTf4yFMIYXNiJC13Qwwu4TaY9E+uL/TZ/ZZC5Z9XKRPTIKjqZ2EZUyF5Ubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627546; c=relaxed/simple;
	bh=mND0/asZNEjOD27agRTV1UOdcbQ9NaBVstFsI7+cWZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVxPqTc4Gnm/R6QuTzGBIvJ3hH+sly0Bq9kNBNf8YQGtHVe8TBnc3HmP7WOsPx+TRpEsy2DoZLBSaK7WKE7ADWOIXQIy8qedV+tLIQgBBGwbbf+utHugY2aIxY75OpUHFjjbMdT1g597nhJ4ZE+W6cngA8ctVuNhkxntxIQe/Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fYHyC8VM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559EEC433F1;
	Tue, 30 Jan 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fYHyC8VM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706627542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CE+dHfwhchbF76+8SdQnvFtWXgv6n6pDLWAAkhWYuhY=;
	b=fYHyC8VMnKFjridhhmbE30U+37ezIZg1lnRsT+RTZdNcyK5/Io9NCQCkOSJyRltBfKOyMD
	KVpaLvYMLJdKrLlVMtcBchYysH98nDW0OLV8rn9rVtcZQ/X89q0j/6WTerC6UAcLQ9Kvfa
	T20Ef0+WgIQ0av4WyqHgdlyqszj3uYQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c91b9cdd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 15:12:22 +0000 (UTC)
Date: Tue, 30 Jan 2024 16:12:22 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <ZbkR1qGl3_qy_tNs@zx2c4.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <ZbkLBwLlTNMFZ-2B@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbkLBwLlTNMFZ-2B@redhat.com>

On Tue, Jan 30, 2024 at 02:43:19PM +0000, Daniel P. Berrangé wrote:
> On Tue, Jan 30, 2024 at 03:06:14PM +0100, Jason A. Donenfeld wrote:
> > Is that an accurate summary? If it is, then the actual problem is that
> > the hardware provided to solve this problem doesn't actually solve it
> > that well, so we're caught deciding between guest-guest DoS (some
> > other guest on the system uses all RDRAND resources) and cryptographic
> > failure because of a malicious host creating a deterministic
> > environment.
> 
> In a CoCo VM environment, a guest DoS is not a unique threat
> scenario, as it is unrelated to confidentiality. Ensuring
> fair subdivision of resources between competeing guests is
> just a general VM threat. There are many easy ways a host
> admin can stop a guest making computational progress. Simply
> not scheduling the guest vCPU threads is one. CoCo doesn't
> try to solve this problem.
> 
> Preserving confidentiality is the primary aim of CoCo.
> 
> IOW, if the guest boot is stalled because the kernel is spinning
> waiting on RDRAND to return data, that's fine. If the kernel
> panics after "n" RDRAND failures in a row that's fine too. They
> are both just yet another DoS scenario. 
> 
> If the kernel ignores the RDRAND failure and lets it boot with
> degraded RNG state there were susceptible to attacks, that would
> not be OK for CoCo. 

Yea, that's why I said "we're caught deciding..." One case is a DoS that
would affect all VMs, so while one guest preventing new guests from
booting seems like not a CoCo problem, yes, it is still a problem.

At least in theory. And in practice this is easy with RDSEED too. In
practice, could you actually indefinably starve RDRAND between guests?
Is this pretty easy to do with a little tinkering, or is this a
practically impossible DoS vector? I don't actually know.

