Return-Path: <linux-kernel+bounces-44651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1A884257E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D16D1C28275
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7A6D1AF;
	Tue, 30 Jan 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PiouhNgE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770936A03D;
	Tue, 30 Jan 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619119; cv=none; b=A081Re/xDHUG8h6NtlV/RY3uZGnnI2Bv82p7ZXEAn9RAtC3TVgxAKA7WHBm0xSSoorKcmXyXD23rgRwQGIpJY/NSf6BlsC3c9YCSH4Fg2UwIFZhWJzY4BlL5VqDrqgzKo5Wsbx3QHK6zm5YSn6PSeWfAqcIP6alY9WVtTuyD5QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619119; c=relaxed/simple;
	bh=aBk5+VWkG4cNGh47tXvJDU5HnIOUxCrTDjLxWlIqvqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ir7jEh5TnzpJchrhXHtpn3iA1vMrsMs9bLk42GXHuwMaG4p65FBHtVzrhgSzvmNVIBubcbFWcRKOlcCH+5C3NGZUFREVgSnhOCOOsFrku7wls+jIyNI7QhupxHfg0sL+WAjiE8UolTJ65o/vzJhhzh1rOMcMlt3E+NGB5cYwRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PiouhNgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C91FC433C7;
	Tue, 30 Jan 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PiouhNgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1706619115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TC3oFPy/shCqYB/wfDkQYsAYOqfeKR8NPFtOPaWnRlk=;
	b=PiouhNgEcbn2347veB7bxHWm/Y5+0oYReMvszPlpE52JAfLqL+r9y5C0tR8emIEGMWQ3AS
	NYC+1ZkjzOubei5eyAF5bZ4NeUp63JoDkQ5U4/i4s/kbNrG7If54WyqY7xPVnG9oSKFtLy
	KeKqnnLxumpFZIbuVVkTU6pWUrrq0sQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8247577a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jan 2024 12:51:53 +0000 (UTC)
Date: Tue, 30 Jan 2024 13:51:50 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Message-ID: <Zbjw5hRHr_E6k18r@zx2c4.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>

On Tue, Jan 30, 2024 at 01:29:10PM +0100, Jason A. Donenfeld wrote:
> Hi Kirill,
> 
> I've been following the other discussion closely thinking about the
> matter, but I suppose I'll jump in here directly on this patch, if
> this is the approach the discussion is congealing around.
> 
> A comment below:
> 
> On Tue, Jan 30, 2024 at 9:30 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >  static inline bool __must_check rdseed_long(unsigned long *v)
> >  {
> > +       unsigned int retry = RDRAND_RETRY_LOOPS;
> >         bool ok;
> > -       asm volatile("rdseed %[out]"
> > -                    CC_SET(c)
> > -                    : CC_OUT(c) (ok), [out] "=r" (*v));
> > -       return ok;
> > +
> > +       do {
> > +               asm volatile("rdseed %[out]"
> > +                            CC_SET(c)
> > +                            : CC_OUT(c) (ok), [out] "=r" (*v));
> > +
> > +               if (ok)
> > +                       return true;
> > +       } while (--retry);
> > +
> > +       return false;
> >  }
> 
> So, my understanding of RDRAND vs RDSEED -- deliberately leaving out
> any cryptographic discussion here -- is roughly that RDRAND will
> expand the seed material for longer, while RDSEED will mostly always
> try to sample more bits from the environment. AES is fast, while
> sampling is slow, so RDRAND gives better performance and is less
> likely to fail, whereas RDSEED always has to wait on the hardware to
> collect some bits, so is more likely to fail.
> 
> For that reason, most of the usage of RDRAND and RDSEED inside of
> random.c is something to the tune of `if (!rdseed(out)) rdrand(out);`,
> first trying RDSEED but falling back to RDRAND if it's busy. That
> still seems to me like a reasonable approach, which this patch would
> partly undermine (in concert with the next patch, which I'll comment
> on in a follow up email there).
> 
> So maybe this patch #1 (of 2) can be dropped?

Unless there's a difference between ring 0 and ring 3, this simple test
is telling:

  #include <stdio.h>
  #include <immintrin.h>
  
  int main(int argc, char *argv[])
  {
    unsigned long long rand;
    unsigned int i, success_rand = 0, success_seed = 0;
    enum { TOTAL = 1000000 };
  
    for (i = 0; i < TOTAL; ++i)
    	success_rand += !!_rdrand64_step(&rand);
    for (i = 0; i < TOTAL; ++i)
    	success_seed += !!_rdseed64_step(&rand);
    
    printf("RDRAND: %.2f%%, RDSEED: %.2f%%\n", success_rand * 100.0 / TOTAL, success_seed * 100.0 / TOTAL);
    return 0;
  }

Result on my i7-11850H:

  RDRAND: 100.00%, RDSEED: 29.26%

And this doesn't even test multicore stuff.

Jason

