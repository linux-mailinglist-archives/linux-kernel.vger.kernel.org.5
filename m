Return-Path: <linux-kernel+bounces-17072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A71A8247E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7464CB216E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85FB28DC5;
	Thu,  4 Jan 2024 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/UCZHo3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7D928DB8;
	Thu,  4 Jan 2024 18:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255C2C433C8;
	Thu,  4 Jan 2024 18:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704391380;
	bh=MV5Ut801c9LMt/NfTstc6Va2WGqhm/J8yUioixdQxSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/UCZHo3I3qltVdCmyxEdTDzwFRcE6+OlW1ndxmr2H0P2lwU7cMVCnjhOW/F6pMhd
	 w29mAixY7DWegPvGey/JO546a6P5POrmC1vVEdxc/dv6E5UfgyeWKI+2nhybaNBGsY
	 Qd2zmwcyr+IzBSgqxV4x9xLyL0wJs/DsggEzVr+wtZGo5lpIFlk1CbDufr1dQOuPSb
	 jszDteOpTmlQCeLA/DIvg80/YFWAzTOiqf+SjVf2LstCP9rRbXy2Nq8jZfBbrwVidU
	 wxoGsWwt6JNvjOuFfrGCLd9whoBbrp/ToGrl0juWpZtdDJm7vv4YCL/AUrxxsuxEqb
	 VyMfX4l86UrhA==
Date: Thu, 4 Jan 2024 10:02:58 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>, hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [RFC PATCH 00/13] RISC-V crypto with reworked asm files
Message-ID: <20240104180258.GB1127@sol.localdomain>
References: <20240102064743.220490-1-ebiggers@kernel.org>
 <CAMj1kXEAqxCZ_PNM9a=CyciSHUzDU_yqemKh51oncHyLbYUKtA@mail.gmail.com>
 <20240103143557.GA773@quark.localdomain>
 <20EF7A6D-19AE-49C0-982F-8FE7733E375A@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20EF7A6D-19AE-49C0-982F-8FE7733E375A@sifive.com>

On Thu, Jan 04, 2024 at 06:23:42PM +0800, Jerry Shih wrote:
> On Jan 3, 2024, at 22:35, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Wed, Jan 03, 2024 at 03:00:29PM +0100, Ard Biesheuvel wrote:
> >> On Tue, 2 Jan 2024 at 07:50, Eric Biggers <ebiggers@kernel.org> wrote:
> >>> 
> >>> As discussed previously, the proposed use of the so-called perlasm for
> >>> the RISC-V crypto assembly files makes them difficult to read, and these
> >>> files have some other issues such extensively duplicating source code
> >>> for the different AES key lengths and for the unrolled hash functions.
> >>> There is/was a desire to share code with OpenSSL, but many of the files
> >>> have already diverged significantly; also, for most of the algorithms
> >>> the source code can be quite short anyway, due to the native support for
> >>> them in the RISC-V vector crypto extensions combined with the way the
> >>> RISC-V vector extension naturally scales to arbitrary vector lengths.
> >>> 
> >>> Since we're still waiting for prerequisite patches to be merged anyway,
> >>> we have a bit more time to get this cleaned up properly.  So I've had a
> >>> go at cleaning up the patchset to use standard .S files, with the code
> >>> duplication fixed.  I also made some tweaks to make the different
> >>> algorithms consistent with each other and with what exists in the kernel
> 
> Do you mean the xts gluing part only? Do we have the different algorithms
> for the actual implementation in .S? 

I did change both the XTS assembly and XTS glue code slightly.  However, the
general approach is still the same, except for a couple minor optimizations that
I dropped.  See what I wrote below:

    All the same functionality and general optimizations are still included,
    except for some minor optimizations in XTS that I dropped since it's not
    clear they are worth the complexity.  (Note that almost all users of XTS
    in the kernel only use it with block-aligned messages, so it's not very
    important to optimize the ciphertext stealing case.)

> >>> The result is this series, which passes all tests and is about 2400
> >>> lines shorter than the latest version with the perlasm
> >>> (https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sifive.com/).
> 
> For the unrolled hash functions case(sha256/512), the .S implementation uses
> macro instead. But I think the macro expanded code will be the same. Do we
> care about the source code size instead of the final binary code size?

Yes, because it's very difficult to review code that's been hand-unrolled.
Essentially what I had been doing to review your code was to reverse engineer
what the loop that was being unrolled was, and then go through each unrolled
iteration and verify that it matches what it is supposed to.  (While also
ignoring the code comments, as some of the comments had been copy+pasted without
being updated to be correct for what iteration they were commenting.)

It's much simpler to just use .rept to unroll the code for us.

> For the AES variants part, the .S uses branches inside the inner loop.

No, it does not.  The macros generate a separate inner loop for each AES key
length, just like what the perl scripts had.  The source code just isn't
duplicated 3 times anymore.

> 
> >>> All the same functionality and general optimizations are still included,
> >>> except for some minor optimizations in XTS that I dropped since it's not
> >>> clear they are worth the complexity.  (Note that almost all users of XTS
> >>> in the kernel only use it with block-aligned messages, so it's not very
> >>> important to optimize the ciphertext stealing case.)
> 
> The aesni/neon are SIMD, so I think the rvv version could have the different
> design. And I think my implementation is very similar to x86-xts except the
> tail block numbers for ciphertext stealing case.
> The x86-xts-like implementation uses the fixed 2 block for the ciphertext
> stealing case.
> 
> +		int xts_blocks = DIV_ROUND_UP(req->cryptlen,
> +					      AES_BLOCK_SIZE) - 2;

The two specific XTS optimizations that I dropped are:
    
1. There was a parameter 'update_iv' that told the assembly code whether to
   calculate and return the next tweak or not.  Computing the next tweak is a
   fairly small computation; it's not clear to me that it's worth adding a
   branch and extra code complexity to skip that computation.

2. For XTS encryption with ciphertext stealing, the assembly code encrypted the
   last full block during the main loop instead of separately, in order to take
   better advantage of parallelism.  I don't like how this optimization only
   applied to inputs whose length is not a multiple of 16, which are very rare.
   Also, it only applied to encryption, not to decryption.  That meant that
   separate code was needed for encryption and decryption.  Note that for disk
   encryption, decryption is more performance-critical than encryption.

Again, we could bring these back later.  I'd just like to error on the side of
simplicity for the initial version.  If we include optimizations that aren't
actually worthwhile, it might be hard to remove them later.

> >>> I'd appreciate people's thoughts on this series.  Jerry, I hope I'm not
> >>> stepping on your toes too much here, but I think there are some big
> >>> improvements here.
> >>> 
> >> 
> >> As I have indicated before, I fully agree with Eric here that avoiding
> >> perlasm is preferable: sharing code with OpenSSL is great if we can
> >> simply adopt the exact same code (and track OpenSSL as its upstream)
> >> but this never really worked that well for skciphers, due to API
> >> differences. (The SHA transforms can be reused a bit more easily)
> 
> In my opinion, I would prefer the perlasm with the usage of asm mnemonics.
> I could see the expanded asm source from perlsm. I don't know how to dump the
> expanded asm source when we use asm `.macro` directives. I use objdump to
> see the final asm.

Yes, you can always use objdump to see everything expanded out.  But there's not
much of a need to do that when you can just read the source code instead.

> And we could use function to modularize the asm implementations. The macro
> might do the same things, but it's more clear for me for the argument passing
> and more powerful string manipulation.

The perl scripts were not using any advanced capabilities of perl, and in some
cases they even emitted assembly macros like .rept instead of using perl.  So
the use of perl seemed unnecessary and just over-complicated things.

BTW, we could always use perlasm for specific algorithms where we actually need
advanced scripting, like to interleave two independent computations with each
other.  It doesn't have to be all one or the other.  It's just that the code
that's been written for RISC-V so far is relatively straightforward and doesn't
seem to benefit from perlasm.

> And I could have scope for the register name binding. It's more clear to me
> comparing with a long list of `#define xxx`.

I think it's good enough.  We can always re-#define things later in the file, or
just split functions with different parameters into different files.

BTW, the reason that some of the lists of defines got longer is that I actually
gave things proper names, whereas some the perl scripts used trivial names like
"V28" for the v28 register.

- Eric

