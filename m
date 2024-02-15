Return-Path: <linux-kernel+bounces-66972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2885643A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20021C216E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C16130AC9;
	Thu, 15 Feb 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="acPd2w66"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286412FF96;
	Thu, 15 Feb 2024 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003380; cv=none; b=Zr7vzWtY5SyPKgtGpdQ68A8IHJRicB4ePNyUB9/TYsn0Pzsem0QLmQ+GPcwxXQsskgBPzpiBpZOgzEJU30jQGo+5qE06DnxqGKVYYWZEDbZ8tDboc8oNm1RinMV+hyBO6UVbGcqjmM+llqszqju88zJGtLiELbm1Wna9wYuoUD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003380; c=relaxed/simple;
	bh=aprbRSSrNekh4TziwkCVNUHRLpaysztfD/0uIJPTDW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgngwCBplxK1nQEXNKsGPH1eL5aqYwNCYQ70vQ2cuuFNubipXNuzv+sHoFAnzMcJnJYSu/GL6RibQ4VGlkFvruWXkjRcNOvj60hCP8pFk3iudJAseAyCiERhnXmHq2w85K8AiYcgUoj2MsZVafST/D6Z58yvbL5rMLtx5YSWLV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=acPd2w66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70453C433F1;
	Thu, 15 Feb 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="acPd2w66"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1708003376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gH77Wpl45QrIFBHWb9b04lKTCLb8JnPiulNkEJpR7rI=;
	b=acPd2w666YPwPoBmmYcpxXoBMPlZJs0SNmmkL9TCA+lQlT1Zm6T6KZ0f3iXVWWKih+FqKq
	obzfyijfvmrEJfrm7VbRwPqyCWhN6RFDnIieWuohlqUjcsI92E/lTUYYvEGPPRKorkHo9a
	lyUe3j2gHzo+XBDxJ4rVMOICfjWJT0k=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8cd6da92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 13:22:56 +0000 (UTC)
Date: Thu, 15 Feb 2024 14:22:56 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Message-ID: <Zc4QMAnrMiiCwkmX@zx2c4.com>
References: <20240214195744.8332-1-Jason@zx2c4.com>
 <20240214195744.8332-3-Jason@zx2c4.com>
 <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>

Hi Elena,

On Thu, Feb 15, 2024 at 07:30:32AM +0000, Reshetova, Elena wrote:
> Should we just go back to the approach to add one more check in random_init_early()
> to panic in the CoCo case if both rdseed and rdrand fails to give us anything? 

Yea, no, definitely not. That is, in my opinion, completely backwards
and leads to impossible maintainability. CoCo is not some special
snowflake that gets to sprinkle random conditionals in generic code.

First, consider the motivation for doing this:
- This is to abort on a physical defective CPU bug -- presumably a
  highly implausible thing to ever happen.
- This is for a threat model that few people are really compelled by
  anyway, e.g. it's whack-a-mole season with host->guest vectors.
- This is for a single somewhat obscure configuration of a single
  architecture with a feature only available on certain chipsets.
- This is not an "intrinsic" problem that necessitates plumbing complex
  policy logic all over the place, but for a very special
  driver-specific case.

Rather, what this patch does is...

> Now with this patch, the logic becomes

Your description actually wasn't quite accurate so I'll write it out
(and I'll clarify in the commit message/comments for v3 - my fault for
being vague):

1. At early boot, x86/CoCo is initialized. As part of that
   initialization, it makes sure it can get 256 bits of RDRAND output
   and adds it to the pool, in exactly the same way that the SD card
   driver adds inserted memory card serial numbers to the pool. If it
   can't get RDRAND output, it means CoCo loses one of its "Co"s, and so
   it panic()s.

2. Later, the generic RNG initializes in random_init_early() and
   random_init(), where it opportunistically tries to use everything it
   can to get initialized -- architectural seed, architectural rand,
   jitter, timers, boot seeds, *seeds passed from other drivers*, and
   whatever else it can.

Now what you're complaining about is that in this step 2, we wind up
adding *even more* rdrand (though, more probably rdseed), in addition to
what was already added in the platform-specific driver in step 1. Boo
hoo? I can't see how that's a bad thing. Step 1 was CoCo's policy driver
*ensuring* that it was able to push at least *something good* into the
RNG, and taking a CoCo-specific policy decision (panic()ing) if it
can't. Step 2 is just generic RNG stuff doing its generic RNG thing.

You might also want to needle on the fact that if RDRAND is somehow
intermittently physically defective, and so step 1 succeeds, but in step
2, the RNG doesn't manage to get seeded by RDRAND and so initializes
based on jitter or IRQs or something. Okay, fine, but who cares? First,
you'd be talking here about a hugely unlikely defective hardware case,
and second, the end state remains basically identical: there's a good
seed from RDRAND and the RNG itself is able to initialize.

So I really don't want to litter the generic code with a bunch of
platform-specific hacks. The function add_device_randomness()
specifically exists so that individual platforms and devices that have
some unique insight into an entropy source or entropy requirements or
policy or whatever else can do that in their own platform or device
driver code where it belongs.

Jason

