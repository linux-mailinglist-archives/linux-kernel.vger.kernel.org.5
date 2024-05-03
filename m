Return-Path: <linux-kernel+bounces-168345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098118BB70D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C4851C22AEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551E860BBF;
	Fri,  3 May 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Hny7mL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04B54BD8;
	Fri,  3 May 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775021; cv=none; b=B9lT1LO6taUL7ih8f6Mx9rJyI4AL6TzICKwKhi6elvLsTeBbKW1jfSW5yzQOdZB+9oVI/HG0FQr5YHynxBssTtdShP5Y3vM4YfKSMW7fL8ItbGmEbFuUiAlYAzUHNm4GLdFB2+OBeU62t854zf9MK+/m13P3zQWgEUs+T4flrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775021; c=relaxed/simple;
	bh=q3zMuThyMbc2WOrC0iwqs1HYXtKJQklPkENzvWozpIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXeBKaB7xmK095nbK+sjJ4WQkgS+F2v/UkToyHUBstgXDlOj3noiFtcNQ3bL6qwwsfUaUnwY0gb/6W+7EuiycIsavSH+gtLI1eayyYonK7KSAyEIM+HdAYhbPscs6qKTqHJtocnQfubLfMdTYThmZVWh7Gk/PmqukdwBIcarvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Hny7mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1484AC116B1;
	Fri,  3 May 2024 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714775020;
	bh=q3zMuThyMbc2WOrC0iwqs1HYXtKJQklPkENzvWozpIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0Hny7mLbScpjCtZfYZTYXPn4YZCgV91SriWlGuL55hybXRAZF4vdAifu20ycmhGU
	 M3NZhCqOw+wFFNc9jfPhCpAKVyCfkjUjmIYWv3HlDUir0Vpi2exmMdCb/dvnE6N9qX
	 cs+pD42YY26q55leq1bDHzSGUA7JkI5yoVTL63E782k7Tsbj2M9UrW9NjMiLB30t+y
	 KFunGVHg818gtjzcyLOvGeJQEffea0qfGIjNvNDROJlPQMLuX1HpzbPfxiNXTB4anG
	 NVVCblsCfEODl7Bs+dZ3CbuSGCkCCuwhHtKDymeIV/UZ+8o0bB55HUmFoXI0/ax8d2
	 avbvK6HyLbPiw==
Date: Fri, 3 May 2024 15:23:38 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, kernel test robot <lkp@intel.com>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
Message-ID: <20240503222338.GA1908482@thelio-3990X>
References: <20240502092443.6845-2-visitorckw@gmail.com>
 <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name>
 <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name>
 <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X>
 <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjVdbavKgDo8a0CZ@yury-ThinkPad>

On Fri, May 03, 2024 at 02:55:57PM -0700, Yury Norov wrote:
> On Fri, May 03, 2024 at 08:54:01AM -0700, Nathan Chancellor wrote:
> > On Fri, May 03, 2024 at 03:38:59PM +0800, Kuan-Wei Chiu wrote:
> > > On Fri, May 03, 2024 at 03:31:26PM +0800, Kuan-Wei Chiu wrote:
> > > > On Thu, May 02, 2024 at 09:17:01PM -0700, Nathan Chancellor wrote:
> > > > > Hi Kuan-Wei,
> > > > > 
> > > > > On Fri, May 03, 2024 at 09:34:28AM +0800, Kuan-Wei Chiu wrote:
> > > > > > On Fri, May 03, 2024 at 08:49:00AM +0800, kernel test robot wrote:
> > > > > > > Hi Kuan-Wei,
> > > > > > > 
> > > > > > > kernel test robot noticed the following build errors:
> > > > > > > 
> > > > > > > [auto build test ERROR on linus/master]
> > > > > > > [also build test ERROR on v6.9-rc6 next-20240502]
> > > > > > > [cannot apply to akpm-mm/mm-everything akpm-mm/mm-nonmm-unstable]
> > > > > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > > > > 
> > > > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Kuan-Wei-Chiu/lib-test_bitops-Add-benchmark-test-for-fns/20240502-172638
> > > > > > > base:   linus/master
> > > > > > > patch link:    https://lore.kernel.org/r/20240502092443.6845-2-visitorckw%40gmail.com
> > > > > > > patch subject: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
> > > > > > > config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240503/202405030808.UsoMKFNP-lkp@intel.com/config)
> > > > > > > compiler: clang version 18.1.4 (https://github.com/llvm/llvm-project e6c3289804a67ea0bb6a86fadbe454dd93b8d855)
> > > > > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030808.UsoMKFNP-lkp@intel.com/reproduce)
> > > > > > > 
> > > > > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > > > > the same patch/commit), kindly add following tags
> > > > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202405030808.UsoMKFNP-lkp@intel.com/
> > > > > > > 
> > > > > > > All errors (new ones prefixed by >>):
> > > > > > > 
> > > > > > > >> lib/test_bitops.c:56:39: error: variable 'tmp' set but not used [-Werror,-Wunused-but-set-variable]
> > > > > > >       56 |         static volatile __used unsigned long tmp __initdata;
> > > > > > >          |                                              ^
> > > > > > >    1 error generated.
> > > > > > > 
> > > > > > > 
> > > > > > > vim +/tmp +56 lib/test_bitops.c
> > > > > > > 
> > > > > > >     52	
> > > > > > >     53	static int __init test_fns(void)
> > > > > > >     54	{
> > > > > > >     55		static unsigned long buf[10000] __initdata;
> > > > > > >   > 56		static volatile __used unsigned long tmp __initdata;
> > > > > > 
> > > > > > I apologize for causing the compilation failure with clang. I'm not
> > > > > > very familiar with clang and I'm not sure why something marked as
> > > > > > __used would result in the warning mentioned above. Perhaps clang does
> > > > > > not support attribute((used))? Is there a way to work around this
> > > > > > issue?
> > > > > 
> > > > > It looks like __attribute__((__used__)) is not enough to stop clang from
> > > > > warning, unlike GCC. I can likely fix that in clang if it is acceptable
> > > > > to the clang maintainers (although more below on why this might be
> > > > > intentional) but the warning will still need to be resolved for older
> > > > > versions. Looking at the current clang source code and tests, it looks
> > > > > like __attribute__((__unused__)) should silence the warning, which the
> > > > > kernel has available as __always_unused or __maybe_unused, depending on
> > > > > the context.
> > > > > 
> > > > > $ cat test.c
> > > > > void foo(void)
> > > > > {
> > > > >         int a;
> > > > >         a = 1;
> > > > > }
> > > > > 
> > > > > void bar(void)
> > > > > {
> > > > >         static int b;
> > > > >         b = 2;
> > > > > }
> > > > > 
> > > > > void baz(void)
> > > > > {
> > > > >         static int c __attribute__((__used__));
> > > > >         c = 3;
> > > > > }
> > > > > 
> > > > > void quux(void)
> > > > > {
> > > > >         static int d __attribute__((__unused__));
> > > > >         d = 4;
> > > > > }
> > > > > 
> > > > > void foobar(void)
> > > > > {
> > > > >         static int e __attribute__((__used__)) __attribute__((__unused__));
> > > > >         e = 1;
> > > > > }
> > > > > 
> > > > > $ gcc -Wunused-but-set-variable -c -o /dev/null test.c
> > > > > test.c: In function ‘foo’:
> > > > > test.c:3:13: warning: variable ‘a’ set but not used [-Wunused-but-set-variable]
> > > > >     3 |         int a;
> > > > >       |             ^
> > > > > test.c: In function ‘bar’:
> > > > > test.c:9:20: warning: variable ‘b’ set but not used [-Wunused-but-set-variable]
> > > > >     9 |         static int b;
> > > > >       |                    ^
> > > > > 
> > > > > $ clang -fsyntax-only -Wunused-but-set-variable test.c
> > > > > test.c:3:6: warning: variable 'a' set but not used [-Wunused-but-set-variable]
> > > > >     3 |         int a;
> > > > >       |             ^
> > > > > test.c:9:13: warning: variable 'b' set but not used [-Wunused-but-set-variable]
> > > > >     9 |         static int b;
> > > > >       |                    ^
> > > > > test.c:15:13: warning: variable 'c' set but not used [-Wunused-but-set-variable]
> > > > >    15 |         static int c __attribute__((__used__));
> > > > >       |                    ^
> > > > > 3 warnings generated.
> > > > > 
> > > > > I've attached a diff below that resolves the warning for me and it has
> > > > > no code generation differences based on objdump. While having used and
> > > > > unused attributes together might look unusual, reading the GCC attribute
> > > > > manual makes it seem like these attributes fulfill similar yet different
> > > > > roles, __unused__ prevents any unused warnings while __used__ forces the
> > > > > variable to be emitted:
> > > > > 
> > > > > https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Common-Variable-Attributes.html#index-unused-variable-attribute
> > > > > 
> > > > > A strict reading of that does not make it seem like __used__ implies
> > > > > disabling unused warnings, so I can understand why clang's behavior is
> > > > > the way that it is.
> > > > > 
> > > > Thank you for your explanation and providing the solution. I tested the
> > > > diff stat you provided, and it works well for me.
> > > > 
> > > Should I submit an updated version of the patch to the bitmap
> > > maintainer, or should this be a separate patch since the patch causing
> > > build failure has already been accepted? My instinct is the latter, but
> > > I'm concerned it might make git bisection more challenging.
> > 
> > Yury would be the best person to answer these questions since each
> > maintainer is different, some never rebase their trees while others will
> > squash simple fixes in to avoid bisection issues and such. I've added
> > him to the thread now to chime in (somehow he got dropped? the thread
> > starts at https://lore.kernel.org/202405030808.UsoMKFNP-lkp@intel.com/).
> > 
> > I think the diff in my email should be directly applicable on top of
> > your change with no conflicts so he could just squash that in if you are
> > both happy with that.
> > 
> > Cheers,
> > Nathan
> > 
> > > > > diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> > > > > index 5c627b525a48..28c91072cf85 100644
> > > > > --- a/lib/test_bitops.c
> > > > > +++ b/lib/test_bitops.c
> > > > > @@ -53,7 +53,7 @@ static unsigned long order_comb_long[][2] = {
> > > > >  static int __init test_fns(void)
> > > > >  {
> > > > >  	static unsigned long buf[10000] __initdata;
> > > > > -	static volatile __used unsigned long tmp __initdata;
> > > > > +	static volatile __always_unused __used unsigned long tmp __initdata;
> > > > >  	unsigned int i, n;
> > > > >  	ktime_t time;
> 
> Hi Nathan,
> 
> Thank you for sharing this.
> 
> I think this __used __unused thing may confuse readers when spotted in
> a random test code. What do you think if we make it a new macro and
> comment properly to avoid confusion?
> 
> I did that in the patch below. If you like it, I can prepend the 
> Kuan-Wei's series and fix the test inplace.
> 
> Thanks,
> Yury
> 
> From 987a021cc76495b32f680507e0c55a105e8edff3 Mon Sep 17 00:00:00 2001
> From: Yury Norov <yury.norov@gmail.com>
> Date: Fri, 3 May 2024 12:12:00 -0700
> Subject: [PATCH] Compiler Attributes: Add __always_used macro
> 
> In some cases like performance benchmarking, we need to call a
> function, but don't need to read the returned value. If compiler
> recognizes the function as pure or const, it can remove the function
> invocation, which is not what we want.
> 
> To prevent that, the common practice is assigning the return value to
> a temporary static volatile __used variable. This works with GCC, but
> clang still emits Wunused-but-set-variable. To suppress that warning,
> we need to teach clang to do that with the 'unused' attribute.
> 
> Nathan Chancellor explained that in details:
> 
>   While having used and unused attributes together might look unusual,
>   reading the GCC attribute manual makes it seem like these attributes
>   fulfill similar yet different roles, __unused__ prevents any unused
>   warnings while __used__ forces the variable to be emitted. A strict
>   reading of that does not make it seem like __used__ implies disabling
>   unused warnings
> 
> The compiler documentation makes it clear what happens behind the used
> and unused attributes, but the chosen names may confuse readers if such
> combination catches an eye in a random code.
> 
> This patch adds __always_used macro, which combines both attributes
> and comments on what happens for those interested in details.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405030808.UsoMKFNP-lkp@intel.com/
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Yeah I think this is reasonable to make this a macro, I am sure there
are other places where this might be useful.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Adding Miguel as compiler attributes maintainer to make him aware of the
change. I think it would be reasonable to have you take it through the
bitops tree with your ack so that the test patch can make use of this as
the fix for the robot's issue.

One gotcha that might be worth mentioning is that this combination only
works on functions and non-local variables (i.e., static or global).

> ---
>  include/linux/compiler_attributes.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> index 8bdf6e0918c1..957b2d914119 100644
> --- a/include/linux/compiler_attributes.h
> +++ b/include/linux/compiler_attributes.h
> @@ -361,6 +361,18 @@
>   */
>  #define __used                          __attribute__((__used__))
>  
> +/*
> + * The __used attribute guarantees that the attributed variable will be
> + * always emitted by a compiler. It doesn't prevent the compiler from
> + * throwing the 'unused' warnings when it can't detect how the variable
> + * is actually used. It's a compiler implementation details either emit
> + * the warning in that case or not.
> + *
> + * The combination of both 'used' and 'unused' attributes ensures that
> + * the variable would be emitted, and will not trigger 'unused' warnings.
> + */
> +#define __always_used			__used __maybe_unused
> +
>  /*
>   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-warn_005funused_005fresult-function-attribute
>   * clang: https://clang.llvm.org/docs/AttributeReference.html#nodiscard-warn-unused-result
> -- 
> 2.40.1
> 

