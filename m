Return-Path: <linux-kernel+bounces-51021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD89848521
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3311F24915
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73834CB41;
	Sat,  3 Feb 2024 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jUTnY4su"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A15D72E;
	Sat,  3 Feb 2024 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706955164; cv=none; b=He6pLdDwcw+YTBRjHoHh7FWcUUiTBUnlF4ZBR/tC1z75TwT/FmHBOYg06pHeXKmkvmqQo6yKmJeYAqkDgh3rYOWoTiO/GAzol2F+eiLrd6VBg1MDSroW62kp0ncSiY1vqJygH3ha0NrFc924oMIDT7FgV3e5oPtW+F26TB1SknA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706955164; c=relaxed/simple;
	bh=DvXqZtbYFVinLivL3K4A/ClltCGxOW4cow1fDLrjL9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCEHmCdeIoAKFsMF4yDZr8L8Bmn/NIAf5zoiqbxlqrcB7Qb+L4oQkxll2ZJ2VkevjZUmzLfHoTTuuamGmGvuxDFjoH6PaEL50yMGh4OyPqc9nKi37Zfz2kXHVqRrNfzeHb2WGoRDMQ0alXlDUcXXJeUyKnKlZ3RvnhOk8WWWTB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jUTnY4su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9402BC433F1;
	Sat,  3 Feb 2024 10:12:42 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jUTnY4su"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706955161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fyk47rv6PoXblVb+58I9Tj/qLrH+SfbKgfIIMGJ0GzE=;
	b=jUTnY4su1U7l4f/7BLAhdUi1vD/Oo6HHZp5XMY5o3SvJ0sasDgJTMby5wxjTzpIsXSjRbt
	zMYNSdoHnQaFRj5S54sERYGFkowrbnduWTcpq7o8vrE2BErJMTjfKmTYZ8NKQQk8yRi941
	lIjlYerzkuq0HNN8mnPkQD1pz1IAi4M=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id be5d1e7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 3 Feb 2024 10:12:40 +0000 (UTC)
Date: Sat, 3 Feb 2024 11:12:37 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>,
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
Message-ID: <Zb4RlTzq_LV7AzsH@zx2c4.com>
References: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu>
 <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20240202153927.GA119530@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202153927.GA119530@mit.edu>

Hi Ted, Kirill,

On Fri, Feb 02, 2024 at 10:39:27AM -0500, Theodore Ts'o wrote:
> On Fri, Feb 02, 2024 at 07:25:42AM +0000, Reshetova, Elena wrote:
> > This is a great summary of options, thank you Jason!
> > My proposal would be to wait on result of our internal investigation 
> > before proceeding to choose the approach. 
> 
> I'm happy for the option "Do nothing for now", but if we do want to do
> something in the absence of more detailed information, I'd suggest
> doing something simple for first, on the theory that it doesn't make
> things worse, and we can always do something more complicated if it
> turns out to be needed.
> 
> In that vein, my suggestion is:
> 
> > > Solution B) BUG_ON(is_early_boot && is_coco_system) in the RDRAND
> > > failure path (> 10 retries).
> > > 
> > > This is slightly less simple than A, because we have to plumb
> > > CoCo-detection through to the RDRAND helper. [Side note: I feel
> > > ridiculous typing 'CoCo'.] Systems-wise, I don't see drawbacks.
> > > RNG-wise, the drawback is that this doesn't help deal with secure
> > > reseeding later in time, which is a RNG property that we otherwise
> > > enjoy.
> 
> If there isn't a global variable we can test to see if Confidential
> Compute is enabled, I suspect we should just add one.  I would assume
> that /dev/random isn't the only place where we might need to do
> whether Confidential Compute is enabled.
> 
> So I don't think plumbing CC into the /dev/random code, and since we
> are only doing this in early boot, I wouldn't put it in the RDRAND
> helper, but rather in the caller of the RDRAND helper that gets used
> in the early boot path.

Yea, actually, I had a pretty similar idea for something like that
that's very non-invasive, where none of this even touches the RDRAND
core code, much less random.c. Specifically, we consider "adding some
extra RDRAND to the pool" like any other driver that wants to add some
of its own seeds to the pool, with add_device_randomness(), a call that
lives in various driver code, doesn't influence any entropy readiness
aspects of random.c, and can safely be sprinkled in any device or
platform driver.

Specifically what I'm thinking about is something like:

void coco_main_boottime_init_function_somewhere_deep_in_arch_code(void)
{
  // [...]
  // bring up primary CoCo nuts
  // [...]

  /* CoCo requires an explicit RDRAND seed, because the host can make the
   * rest of the system deterministic.
   */
  unsigned long seed[32 / sizeof(long)];
  size_t i, longs;
  for (i = 0; i < ARRAY_SIZE(seed); i += longs) {
    longs = arch_get_random_longs(&seed[i], ARRAY_SIZE(seed) - i);
    /* If RDRAND is being DoS'd, panic, because we can't ensure
     * confidentiality.
     */
    BUG_ON(!longs);
  }
  add_device_randomness(seed, sizeof(seed));
  memzero_explicit(seed, sizeof(seed));

  // [...]
  // do other CoCo things
  // [...]
}

I would have no objection to the CoCo people adding something like this
and would give it my Ack, but more importantly, my Ack for that doesn't
even matter, because add_device_randomness() is pretty innocuous.

So Kirill, if nobody else here objects to that approach, and you want to
implement it in some super minimal way like that, that would be fine
with me. Or maybe we want to wait for that internal inquiry at Intel to
return some answers first. But either way, this might be an easy
approach that doesn't add too much complexity.

Jason

