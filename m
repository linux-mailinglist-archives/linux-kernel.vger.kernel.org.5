Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726697D036B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbjJSUvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:51:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F52C2;
        Thu, 19 Oct 2023 13:51:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE170C433C7;
        Thu, 19 Oct 2023 20:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697748680;
        bh=avvVhk562RDsloShDfVKbRwRR54xodJjv+T6J94vhjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rJ+cw6Yu53WaCZw4SBhXOsLU55656lONyJVrRglH9t56UjH5t/DpaapyQldAZrWeZ
         MRJgZQBaWmn2reW0SrFN3YZAmcSvnfvFGKwIv4gTBRwLJBm+TRlPVL5v3ldSHwXc84
         utZz868f+bdzqjHsX9nFyzcZYScMeqEv++Wv4GLHiMtEoALOvIzrVH0wim6LaAvwVP
         /Qq0RA8xOHjLsB5N3jJ40NqlLeco5kc2Ejje+V+9kjj1vT2NpiorfWBEweKmmS3Lgr
         7j7IH7yb5s0p5v6paWW9zXY5d9GvJVbGBVmvTHVAIsWDOcbgNvhscLeC4qjk/iVRTc
         Xqx3C52GjjO6Q==
Date:   Thu, 19 Oct 2023 13:51:17 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Potapenko <glider@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Nick Terrell <terrelln@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Li Hua <hucool.lihua@huawei.com>, Rae Moar <rmoar@google.com>,
        rust-for-linux@vger.kernel.org, bpf@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
Message-ID: <20231019205117.GA839902@dev-arch.thelio-3990X>
References: <20231018182412.80291-1-hamza.mahfooz@amd.com>
 <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
 <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
 <CAG_fn=XcJ=rZEJN+L1zZwk=qA90KShhZK1MA6fdW0oh7BqSJKw@mail.gmail.com>
 <22580470-7def-4723-b836-1688db6da038@app.fastmail.com>
 <20231019155600.GB60597@dev-arch.thelio-3990X>
 <a9237e7a-e08c-4904-b84a-f6198333a78c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9237e7a-e08c-4904-b84a-f6198333a78c@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 04:17:26PM -0400, Hamza Mahfooz wrote:
> On 10/19/23 11:56, Nathan Chancellor wrote:
> > On Thu, Oct 19, 2023 at 02:53:01PM +0200, Arnd Bergmann wrote:
> > > On Thu, Oct 19, 2023, at 12:04, Alexander Potapenko wrote:
> > > > So the remaining option would be to just increase the frame size every
> > > > time a new function surpasses the limit.
> > > 
> > > That is clearly not an option, though we could try to
> > > add Kconfig dependencies that avoid the known bad combinations,
> > > such as annotating the AMD GPU driver as
> > > 
> > >        depends on (CC_IS_GCC || CLANG_VERSION >=180000) || !(KASAN || KCSAN)
> > 
> > This would effectively disable the AMDGPU driver for allmodconfig, which
> > is somewhat unfortunate as it is an easy testing target.
> > 
> > Taking a step back, this is all being done because of a couple of
> > warnings in the AMDGPU code. If fixing those in the source is too much
> > effort (I did note [1] that GCC is at the current limit for that file
> > even with Rodrigo's series applied [2]), couldn't we just take the
> > existing workaround that this Makefile has for this file and its high
> > stack usage and just extend it slightly for clang?
> 
> I personally don't mind fixing these issues in the driver, but the fact
> that they the creep back every time a new major version of Clang rolls
> out (that has been true for the past couple of years at the very
> least), makes it rather annoying to deal with.

I am not sure I agree with that characterization of the situation. clang
has been pretty consistent for the most part (which is certainly on us),
as all versions that the kernel supports warns about this code. I
believe it is more so the fact that there is a new copy of the dcn code
added every year that has none of the fixes applied from earlier
generations... It is not just me that has fixed issues like this, just
run 'git log --grep=stack drivers/gpu/drm/amd/display'. It is not just
clang that complains about the code when sanitizers are turned on, GCC
does as well since Stephen reported them.

Cheers,
Nathan

> > diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> > index 66431525f2a0..fd49e3526c0d 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> > +++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
> > @@ -58,7 +58,7 @@ endif
> >   endif
> >   ifneq ($(CONFIG_FRAME_WARN),0)
> > -frame_warn_flag := -Wframe-larger-than=2048
> > +frame_warn_flag := -Wframe-larger-than=$(if $(CONFIG_CC_IS_CLANG),3072,2048)
> >   endif
> >   CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
> > 
> > That would address the immediate concern of the warning breaking builds
> > with CONFIG_WERROR=y while not raising the limit for other files in the
> > kernel (just this one file in AMDGPU) and avoiding disabling the whole
> > driver. The number could be lower, I think ~2500 bytes is the most usage
> > I see with Rodrigo's series applied, so maybe 2800 would be a decent
> > limit? Once there is a fix in the compiler, this expression could be
> > changed to use clang-min-version or something of that sort.
> > 
> > [1]: https://lore.kernel.org/20231017172231.GA2348194@dev-arch.thelio-3990X/
> > [2]: https://lore.kernel.org/20231016142031.241912-1-Rodrigo.Siqueira@amd.com/
> > 
> > Cheers,
> > Nathan
> -- 
> Hamza
> 
