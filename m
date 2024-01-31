Return-Path: <linux-kernel+bounces-46622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C1384421E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915B91F267B9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864584A35;
	Wed, 31 Jan 2024 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ggL8SJR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76B8287A;
	Wed, 31 Jan 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712314; cv=none; b=B/yf/b/eJ0LMwurXAVXE+fsu5ulRSv7SY5QjtSjigtDNklhGdvOLrI8Egswhj9EP12PsqNcNOzf+uVWivQsp/9eTNtjApUlWut4FnC8OwJPyXIfIwNObMSCZFtg0ucWF5v4SU/ySZE0wtAFxu3/PZJKW2WEDRbp7hf/ppvhqDC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712314; c=relaxed/simple;
	bh=kCZwcyMb+5WvH3zc/WuE5q1/NFvJGsx1BENTOF5FEqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IecajaxYBleBageA4CczfYtm5ThH+Z5u0AdEjbV862bZ5SaRT6yVCt+nxbZ4MFwFIyb7ks0T0PA7UjJx8A//9ZkNMMBvO2+oJKTlx8mtFYPbuY6THeGsr2Iq9/aYOV26xd513AWuCDOElJhRoMlFwhcVxWjKkm1n/Ppzn+rcUbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ggL8SJR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D56C433C7;
	Wed, 31 Jan 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ggL8SJR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706712309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1fYt8wXatgG3kv/t9njHjlDMwjUnGLZdfGdlIyn9zH8=;
	b=ggL8SJR/RILxNt5QWNzEkGHkToTXzWqitmbTeVOu0EhBIQQ7kbLc1XgjyvE36XvNvJYm7y
	H8FC17DEUpipkFq7yh/dsR+Nx8M8ynfLwAL/eMtcDFuybrN9WcXAs5CiCC4VJWPgkFLRa2
	4K5X0qRKOqiyzyKwNmEmzFlTqd5/7ow=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a7d12a80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jan 2024 14:45:09 +0000 (UTC)
Date: Wed, 31 Jan 2024 15:45:06 +0100
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
Message-ID: <Zbpc8tppxuKr-hnN@zx2c4.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
 <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oC=GE-7QS2m9FA5cs_ss+tQgB9Pj3tKnTtMMFpQmUshg@mail.gmail.com>
 <DM8PR11MB5750B861F7A105886AA5FCE4E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131140756.GB2356784@mit.edu>

On Wed, Jan 31, 2024 at 09:07:56AM -0500, Theodore Ts'o wrote:
> What about simply treating boot-time initialization of the /dev/random
> state as special.  That is, on x86, if the hardware promises that
> RDSEED or RDRAND is available, we use them to initialization our RNG
> state at boot.  On bare metal, there can't be anyone else trying to
> exhaust the on-chip RNG's entropy supply, so if RDSEED or RDRAND
> aren't working available --- panic, since the hardware is clearly
> busted.

This is the first thing I suggested here: https://lore.kernel.org/all/CAHmME9qsfOdOEHHw_MOBmt6YAtncbbqP9LPK2dRjuOp1CrHzRA@mail.gmail.com/

But Elena found this dissatisfying because we still can't guarantee new
material later.

> On a guest OS, if confidential compute is enabled, and if RDSEED and
> RDRAND don't work after N retries, and we know CC is enabled, panic,
> since the kernel can't provide the promised security gaurantees, and
> the CC developers and users are cordially invited to sharpen their
> pitchforks and to send their tender regards to the Intel RNG
> engineers.

Yea, maybe bubbling the RDRAND DoS up to another DoS in the CoCo case is
a good tradeoff that will produce the right pitchforkers without
breaking anything real.

> For non-confidential compute guests, the question is what is the
> appropriate reaction if another VM, possibly belonging to a different
> user/customer, is carrying out a RDRAND DOS attack.  I'd argue that in
> these cases, if the guest VM is using virtio-random, then the host's
> /dev/random should be able to cover for cases of Intel RNG exhaustion,
> and allowing other customer to be able to prevent other user's VM's
> from being able to boot is the the greater evil, so we shouldn't treat
> boot-time RDRAND/RDSEED failures as panic-worthy.

The non-CoCo case is fine, because guests can trust hosts, so things are
as they have been forever.

Jason

