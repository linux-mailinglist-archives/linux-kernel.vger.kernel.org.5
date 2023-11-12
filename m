Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE667E935D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 00:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjKLXhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 18:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLXhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 18:37:42 -0500
Received: from matoro.tk (unknown [IPv6:2600:1700:4b10:9d80::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AC1E1BF7;
        Sun, 12 Nov 2023 15:37:37 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=G9DOnKiqePfdjSNqfxs9XjDwYou9Jpa9MccluFS19vc=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20230917; t=1699832244; v=1; x=1700264244;
 b=jhDtBx05KIuwgC3hHt1B2P2kj4oa158AsNfNoTLQuzNeUI0KJlDTzofXuxC8V0Tjrj4fq8O/
 JvDi81bGPDK90hwMhVykcHO9ld05yULnPU5BMRWNJmkA/TPVU9639i2N7QFn7oEH5fM2y0RsylV
 ss8b/IR855BpdAp4iKMYvyUTCmNH9khPHb2oMZRZIEntX+LvP+5bELuTd3nrXzZYvlDPySM19px
 v/+nyazB2ZlCxSJY3K2NcQE/WHY9rkLSrc7f0WRR+SJSWlIyQGzb4Y2CIzxZiuUCzBefwtH1sxf
 bLUv5mZ/o9TuGOrNPpdwAm3Scm2qLqkkES2XVeNNYcok7G4usvIHEz9Vxck7nEi6Uu9tXOlxGUK
 kp9VEKXabNLX423u0lpIaBlhQh/8gqTzu2eP8zMf2lHj+Y7NUe5kOt4VDYcRlpVuB9M+K5DeeI1
 9n05onMc4n4Mh3HI57ix1sW6p+SpNt5lZ2iOMo40xLU0+cJBLAGfmwZ26/Z6lq24NfPi6nTG/i1
 agQ34deYKYShDFXsp+rV9F++D5D6uBI9LzWPcU7AERgI1sgT/K5S9zlXEnyosp9F+CLVf10UASr
 gX0ebmDCTEQ3q/pyGGDw/R7rjf7irA5g6vbQMJuPq+3Oi4y7Y2r0eM+mmmi1ok1Mismz4yHD/Ai
 GTZY+HBxEDU=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 73f273a8; Sun, 12 Nov
 2023 18:37:24 -0500
MIME-Version: 1.0
Date:   Sun, 12 Nov 2023 18:37:24 -0500
From:   matoro <matoro_mailinglist_kernel@matoro.tk>
To:     Helge Deller <deller@gmx.de>
Cc:     Sam James <sam@gentoo.org>, linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bisected stability regression in 6.6
In-Reply-To: <ZVE0DJ5LS/BSO9xy@p100>
References: <75318812c588816e0c741b4cd094524f@matoro.tk>
 <71ab4fa2-311f-4221-9f50-2f49f2f80b5c@gmx.de> <87edgw6kuz.fsf@gentoo.org>
 <9a84b68e9a538a66842dccc5efb8bdf8@matoro.tk> <ZVE0DJ5LS/BSO9xy@p100>
Message-ID: <43096cfbf1d87eff4cbd81c8a13a66f0@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-12 15:22, Helge Deller wrote:
> * matoro <matoro_mailinglist_kernel@matoro.tk>:
>> On 2023-11-11 16:27, Sam James wrote:
>> > Helge Deller <deller@gmx.de> writes:
>> >
>> > > On 11/11/23 07:31, matoro wrote:
>> > > > Hi Helge, I have bisected a regression in 6.6 which is causing
>> > > > userspace segfaults at a significantly increased rate in kernel 6.6.
>> > > > There seems to be a pathological case triggered by the ninja build
>> > > > tool.  The test case I have been using is cmake with ninja backend to
>> > > > attempt to build the nghttp2 package.  In 6.6, this segfaults, not at
>> > > > the same location every time, but with enough reliability that I was
>> > > > able to use it as a bisection regression case, including immediately
>> > > > after a reboot.  In the kernel log, these show up as "trap #15: Data
>> > > > TLB miss fault" messages.  Now these messages can and do show up in
>> > > > 6.5 causing segfaults, but never immediately after a reboot and
>> > > > infrequently enough that the system is stable.  With kernel 6.6 I am
>> > > > completely unable to build nghttp2 under any circumstances.
>> > > >
>> > > > I have bisected this down to the following commit:
>> > > >
>> > > > $ git bisect good
>> > > > 3033cd4307681c60db6d08f398a64484b36e0b0f is the first bad commit
>> > > > commit 3033cd4307681c60db6d08f398a64484b36e0b0f
>> > > > Author: Helge Deller <deller@gmx.de>
>> > > > Date:   Sat Aug 19 00:53:28 2023 +0200
>> > > >
>> > > >      parisc: Use generic mmap top-down layout and brk randomization
>> > > >
>> > > >      parisc uses a top-down layout by default that exactly fits
>> > > > the generic
>> > > >      functions, so get rid of arch specific code and use the
>> > > > generic version
>> > > >      by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
>> > > >
>> > > >      Note that on parisc the stack always grows up and a "unlimited stack"
>> > > >      simply means that the value as defined in
>> > > > CONFIG_STACK_MAX_DEFAULT_SIZE_MB
>> > > >      should be used. So RLIM_INFINITY is not an indicator to use
>> > > > the legacy
>> > > >      memory layout.
>> > > >
>> > > >      Signed-off-by: Helge Deller <deller@gmx.de>
>> > > >
>> > > >   arch/parisc/Kconfig             | 17 +++++++++++++
>> > > >   arch/parisc/kernel/process.c    | 14 -----------
>> > > >   arch/parisc/kernel/sys_parisc.c | 54
>> > > > +----------------------------------------
>> > > >   mm/util.c                       |  5 +++-
>> > > >   4 files changed, 22 insertions(+), 68 deletions(-)
>> > >
>> > > Thanks for your report!
>> > > I think it's quite unlikely that this patch introduces such a bad
>> > > regression.
> 
> I was wrong.
> Indeed, by switching to the generic implementation with this patch
> the calculation of mmap_base is wrong for parisc (because parisc
> is the only architecture left where the stack grows upwards).
> 
> Could you please test the patch below. It did fixed the crashes
> when building nghttp2 for me.
> 
> Helge
> 
> ---
> 
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] parisc: Adjust ARCH_MMAP_RND_BITS* to previous values
> 
> Matoro reported various userspace crashes in kernel 6.6 and bisected it to
> commit 3033cd430768 ("parisc: Use generic mmap top-down layout and brk
> randomization").
> 
> The problem is, that mmap_base is calculated wrongly for the
> stack-grows-upwards case (as on parisc). On parisc, mmap_base is simply just
> below the stack start.
> 
> Reported-by: matoro <matoro_mailinglist_kernel@matoro.tk>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 3033cd430768 ("parisc: Use generic mmap top-down layout and brk 
> randomization")
> Cc:  <stable@vger.kernel.org> # v6.6+
> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index a15ab147af2e..68cbe666510a 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -138,11 +138,11 @@ config ARCH_MMAP_RND_COMPAT_BITS_MIN
>  	default 8
> 
>  config ARCH_MMAP_RND_BITS_MAX
> -	default 24 if 64BIT
> -	default 17
> +	default 18 if 64BIT
> +	default 13
> 
>  config ARCH_MMAP_RND_COMPAT_BITS_MAX
> -	default 17
> +	default 13
> 
>  # unless you want to implement ACPI on PA-RISC ... ;-)
>  config PM
> diff --git a/arch/parisc/include/asm/elf.h b/arch/parisc/include/asm/elf.h
> index 140eaa97bf21..2d73d3c3cd37 100644
> --- a/arch/parisc/include/asm/elf.h
> +++ b/arch/parisc/include/asm/elf.h
> @@ -349,15 +349,7 @@ struct pt_regs;	/* forward declaration... */
> 
>  #define ELF_HWCAP	0
> 
> -/* Masks for stack and mmap randomization */
> -#define BRK_RND_MASK	(is_32bit_task() ? 0x07ffUL : 0x3ffffUL)
> -#define MMAP_RND_MASK	(is_32bit_task() ? 0x1fffUL : 0x3ffffUL)
> -#define STACK_RND_MASK	MMAP_RND_MASK
> -
> -struct mm_struct;
> -extern unsigned long arch_randomize_brk(struct mm_struct *);
> -#define arch_randomize_brk arch_randomize_brk
> -
> +#define STACK_RND_MASK	0x7ff	/* 8MB of VA */
> 
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
>  struct linux_binprm;
> diff --git a/arch/parisc/include/asm/processor.h 
> b/arch/parisc/include/asm/processor.h
> index ff6cbdb6903b..ece4b3046515 100644
> --- a/arch/parisc/include/asm/processor.h
> +++ b/arch/parisc/include/asm/processor.h
> @@ -47,6 +47,8 @@
> 
>  #ifndef __ASSEMBLY__
> 
> +struct rlimit;
> +unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
>  unsigned long calc_max_stack_size(unsigned long stack_max);
> 
>  /*
> diff --git a/arch/parisc/kernel/sys_parisc.c 
> b/arch/parisc/kernel/sys_parisc.c
> index ab896eff7a1d..98af719d5f85 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
>   * indicating that "current" should be used instead of a passed-in
>   * value from the exec bprm as done with arch_pick_mmap_layout().
>   */
> -static unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
> +unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
>  {
>  	unsigned long stack_base;
> 
> diff --git a/mm/util.c b/mm/util.c
> index 8cbbfd3a3d59..0b7e715a71f2 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -414,6 +414,15 @@ static int mmap_is_legacy(struct rlimit *rlim_stack)
> 
>  static unsigned long mmap_base(unsigned long rnd, struct rlimit 
> *rlim_stack)
>  {
> +#ifdef CONFIG_STACK_GROWSUP
> +	/*
> +	 * For an upwards growing stack the calculation is much simpler.
> +	 * Memory for the maximum stack size is reserved at the top of the
> +	 * task. mmap_base starts directly below the stack and grows
> +	 * downwards.
> +	 */
> +	return PAGE_ALIGN(mmap_upper_limit(rlim_stack) - rnd);
> +#else
>  	unsigned long gap = rlim_stack->rlim_cur;
>  	unsigned long pad = stack_guard_gap;
> 
> @@ -431,6 +440,7 @@ static unsigned long mmap_base(unsigned long rnd, struct 
> rlimit *rlim_stack)
>  		gap = MAX_GAP;
> 
>  	return PAGE_ALIGN(STACK_TOP - gap - rnd);
> +#endif
>  }
> 
>  void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)

Works here!  Thanks Helge!!
