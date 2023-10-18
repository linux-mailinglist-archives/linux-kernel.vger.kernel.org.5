Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7071A7CE339
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjJRQ4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 12:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjJRQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 12:56:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03621118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 09:55:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB57FC433C7;
        Wed, 18 Oct 2023 16:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697648158;
        bh=FhJt2vNLVuhy7x9s2wmhEtB3RvSozgHH/YZh9yYPj4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3cQz036JQg3nyZgCDH2boZgyUF6nTnxBXrYb7RH6+XduR0hU21m9oh5M6+bCuKYZ
         J4pg5smzBj5uG44HDZVsNQJNCSIKp25eAlha1DymuL3TVRm/hurMUmHCA79FKXl/ME
         z0O93xG2uhS1OtXHMLnSzSzuDb2/2ReI0z7GspQ2isDYSGTtJmsidvm33pCdrjdqS2
         /g1xPQRCvu1UnCBYJNs2qGfUdcuvyz1NzXDVFVKjfOaNenfXLfWFDRMD44xMIBiB3U
         ZONOH1PO5UwFdYlrVjIBry1fZMgaOXOs8TRl3KMn6UsrN9XWF6QguZ3jZ3nHZlR8jl
         31ZuH141YOH0Q==
Date:   Wed, 18 Oct 2023 09:55:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Hamza Mahfooz <hamza.mahfooz@amd.com>,
        linux-kernel@vger.kernel.org,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kasan-dev@googlegroups.com,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] lib: Kconfig: disable dynamic sanitizers for test builds
Message-ID: <20231018165556.GA3842315@dev-arch.thelio-3990X>
References: <20231018153147.167393-1-hamza.mahfooz@amd.com>
 <CANpmjNPZ0Eii3ZTrVqEL2Ez0Jv23y-emLBCLSZ==xmH--4E65g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPZ0Eii3ZTrVqEL2Ez0Jv23y-emLBCLSZ==xmH--4E65g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 06:22:14PM +0200, Marco Elver wrote:
> On Wed, 18 Oct 2023 at 17:32, 'Hamza Mahfooz' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:

<snip>

> > diff --git a/lib/Kconfig.kmsan b/lib/Kconfig.kmsan
> > index ef2c8f256c57..eb05c885d3fd 100644
> > --- a/lib/Kconfig.kmsan
> > +++ b/lib/Kconfig.kmsan
> > @@ -13,6 +13,7 @@ config KMSAN
> >         depends on HAVE_ARCH_KMSAN && HAVE_KMSAN_COMPILER
> >         depends on SLUB && DEBUG_KERNEL && !KASAN && !KCSAN
> >         depends on !PREEMPT_RT
> > +       depends on !COMPILE_TEST
> 
> KMSAN already selects FRAME_WARN of 0 and should not cause you any
> issues during build testing.

Yeah, this particular case is a bug in the AMDGPU dml2 Makefile, where
CONFIG_FRAME_WARN=0 is not respected.

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/Makefile b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
index f35ed8de260d..66431525f2a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2/Makefile
@@ -61,7 +61,7 @@ ifneq ($(CONFIG_FRAME_WARN),0)
 frame_warn_flag := -Wframe-larger-than=2048
 endif
 
-CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_core.o := $(dml2_ccflags) -Wframe-larger-than=2048
+CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_core.o := $(dml2_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml2/display_mode_util.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml2_wrapper.o := $(dml2_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml2/dml2_utils.o := $(dml2_ccflags)

I will try to send that patch soon, unless one of the AMDGPU folks wants
to beat me to it.

Cheers,
Nathan
