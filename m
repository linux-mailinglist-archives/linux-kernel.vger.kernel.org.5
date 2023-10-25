Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2612E7D6CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjJYNQg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjJYNQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:16:33 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FBF111;
        Wed, 25 Oct 2023 06:16:31 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a86b6391e9so55982767b3.0;
        Wed, 25 Oct 2023 06:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239790; x=1698844590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bhDHPAul78LD2824BVXA4iCfuI07/2hT5EkQSJobW90=;
        b=OFTXvQI2SUJClwdlHrZvPBexmMkmtaL8BSVfdIuWf52kyDKZwxdySFrXyZtP6KfAlI
         GmB4J9KLwWA4AFBgrEGwpUOfLVNMNOLp8UwLtB6XwSkFdYsPMqA19kTTwMpy0LJXL5P3
         Von5s8xtvOQuYrCvoK6vek2H68EPFRWhaitpT049owcLsKVEeEOlyrh5x3lk5jg61W8l
         Q2fVs7u55iNSOmlSv6a90nE25vC0NesVPauUWwMVfPbRnMR61OdB/480JJKe5QrNdlGF
         NXQIK0D2nZirp/P1hZl0qnZLna5fSE1lM8p6BB5STkpAfqqo4jF/X5Lqqu8dqS38LqOL
         xuhQ==
X-Gm-Message-State: AOJu0YxRf8pJk7XxVbVTgy/IEn3Q85mdC5uCUHM3XHFB86fSb2T7TaMN
        qHaAKdp0WXpEKXIXUgNLMhaI9Vh3oZJPHA==
X-Google-Smtp-Source: AGHT+IHqmeFX73+zk8SaC43O8gmaoGU+oEle8ITv9nU1wxnW4ln96u2XQHeAb0hp7/Rc5viCY9xqxQ==
X-Received: by 2002:a0d:e20a:0:b0:59b:fb69:1639 with SMTP id l10-20020a0de20a000000b0059bfb691639mr16292128ywe.32.1698239790374;
        Wed, 25 Oct 2023 06:16:30 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id y83-20020a0dd656000000b0056d51c39c1fsm4989318ywd.23.2023.10.25.06.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 06:16:29 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d84c24a810dso4890585276.2;
        Wed, 25 Oct 2023 06:16:28 -0700 (PDT)
X-Received: by 2002:a25:dc52:0:b0:da0:4bda:dc41 with SMTP id
 y79-20020a25dc52000000b00da04bdadc41mr4238651ybe.37.1698239788460; Wed, 25
 Oct 2023 06:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <169815917362.8695.13904684741526725648.stgit@devnote2>
 <ZTfd3A3Unz6SWFD3@FVFF77S0Q05N.cambridge.arm.com> <20231025084255.bc70b9d0e5af9f6f3d2d4735@kernel.org>
 <ZTjuH074CJuLh7Zw@FVFF77S0Q05N> <1bce4bc5ccd38bf9108283535470a7a8eb7e06e9.camel@physik.fu-berlin.de>
In-Reply-To: <1bce4bc5ccd38bf9108283535470a7a8eb7e06e9.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Oct 2023 15:16:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXrOt3vWrJcoVZNUSJRH4E45iJgdeXMi6ncb4vOSg6_jw@mail.gmail.com>
Message-ID: <CAMuHMdXrOt3vWrJcoVZNUSJRH4E45iJgdeXMi6ncb4vOSg6_jw@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for arch_cmpxchg_local()
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Oct 25, 2023 at 12:32 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2023-10-25 at 11:30 +0100, Mark Rutland wrote:
> > On Wed, Oct 25, 2023 at 08:42:55AM +0900, Masami Hiramatsu wrote:
> > > On Tue, 24 Oct 2023 16:08:12 +0100
> > > Mark Rutland <mark.rutland@arm.com> wrote:
> > > > On Tue, Oct 24, 2023 at 11:52:54PM +0900, Masami Hiramatsu (Google) wrote:
> > > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >
> > > > > Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> > > > > in SH architecture because it does not implement arch_cmpxchg_local().
> > > >
> > > > I do not think this is correct.
> > > >
> > > > The implementation in <asm-generic/cmpxchg-local.h> is UP-only (and it only
> > > > disables interrupts), whereas arch/sh can be built SMP. We should probably add
> > > > some guards into <asm-generic/cmpxchg-local.h> for that as we have in
> > > > <asm-generic/cmpxchg.h>.
> > >
> > > Isn't cmpxchg_local for the data which only needs to ensure to do cmpxchg
> > > on local CPU?
> > > So I think it doesn't care about the other CPUs (IOW, it should not touched by
> > > other CPUs), so it only considers UP case. E.g. on x86, arch_cmpxchg_local() is
> > > defined as raw "cmpxchg" without lock prefix.
> > >
> > > #define __cmpxchg_local(ptr, old, new, size)                            \
> > >         __raw_cmpxchg((ptr), (old), (new), (size), "")
> > >
> >
> > Yes, you're right; sorry for the noise.
> >
> > For your original patch:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Geert, what's your opinion on this?

While this looks OK on first sight (ARM includes the same file, even
on SMP), it does not seem to work?

For sh-allnoconfig, as reported by kernel test robot:

$ make ARCH=sh CROSS_COMPILE=sh2-linux- allnoconfig lib/objpool.o
lib/objpool.c: In function 'objpool_try_add_slot':
./include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit
declaration of function 'arch_cmpxchg_local'; did you mean
'raw_cmpxchg_local'? [-Werror=implicit-function-declaration]
  384 | #define raw_cmpxchg_local arch_cmpxchg_local
      |                           ^~~~~~~~~~~~~~~~~~
./include/linux/atomic/atomic-arch-fallback.h:392:16: note: in
expansion of macro 'raw_cmpxchg_local'
  392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
      |                ^~~~~~~~~~~~~~~~~
./include/linux/atomic/atomic-instrumented.h:4980:9: note: in
expansion of macro 'raw_try_cmpxchg_local'
 4980 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
      |         ^~~~~~~~~~~~~~~~~~~~~
lib/objpool.c:169:19: note: in expansion of macro 'try_cmpxchg_local'
  169 |         } while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
      |                   ^~~~~~~~~~~~~~~~~

For an SMP defconfig:

$ make ARCH=sh CROSS_COMPILE=sh4-linux-gnu- sdk7786_defconfig lib/objpool.o

./include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit
declaration of function ‘arch_cmpxchg_local’; did you mean
‘try_cmpxchg_local’? [-Werror=implicit-function-declaration]
  384 | #define raw_cmpxchg_local arch_cmpxchg_local
      |                           ^~~~~~~~~~~~~~~~~~
./include/linux/atomic/atomic-arch-fallback.h:392:16: note: in
expansion of macro ‘raw_cmpxchg_local’
  392 |         ___r = raw_cmpxchg_local((_ptr), ___o, (_new)); \
      |                ^~~~~~~~~~~~~~~~~
./include/linux/atomic/atomic-instrumented.h:4980:9: note: in
expansion of macro ‘raw_try_cmpxchg_local’
 4980 |         raw_try_cmpxchg_local(__ai_ptr, __ai_oldp, __VA_ARGS__); \
      |         ^~~~~~~~~~~~~~~~~~~~~
lib/objpool.c:169:19: note: in expansion of macro ‘try_cmpxchg_local’
  169 |         } while (!try_cmpxchg_local(&slot->tail, &tail, tail + 1));
      |                   ^~~~~~~~~~~~~~~~~

Hiramatsu-san: do these build for you?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
