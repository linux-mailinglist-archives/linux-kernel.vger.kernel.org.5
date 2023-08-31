Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F65A78E7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbjHaI0J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242547AbjHaI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:26:05 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF501CE8;
        Thu, 31 Aug 2023 01:26:01 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59231a1ca9eso7226617b3.1;
        Thu, 31 Aug 2023 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470361; x=1694075161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gECEIQ8q4bEKdtz9WWubbyYY9T718J8FYjKOYpkjsQ=;
        b=lpU5kXSM5krRHhk+mcnYFiNZpoDhUUPzAqIc2koRA8NcliTNRuL4wQJnCls+HdW3s9
         8eXvEReJBiWlVIiwG70a9okI0KBZz0oOOYRTmf3gK2+/HYGqBFVZ6s1OfD4o3w88e313
         raVCaTQddzNpTgHBFUF71T/v6cWn0QR6swqPDSoq9HMiezSzrvcyklFfY2qzHJvMIyye
         qw2CIOh+3sKsAnLVF9jDWhE2qX+spWpI51Oggrfkmt9P6rXsiF6K1LA7h/R5nbReDe+q
         ItOSBLhrExl7X7/IddrnZA0+hrBWx+LDC60s7ymHYNvK1TnEM9LNuXGrUT326JcM8Vcf
         Gd9A==
X-Gm-Message-State: AOJu0YzZ5e+Am+u7SgPUeMVoWZSjHNTvbosnTuz2+cuVnPiSG60sCKCB
        dnU0NOmFkNnDW2F11+kDBXERv7APALpGoQ==
X-Google-Smtp-Source: AGHT+IFfzUILuB4Xi4UdqMtWcIOvPL6mXkpH73lGDKDyiBylA6efSc+Ofe4nuGFEZU0givCpy09tLA==
X-Received: by 2002:a0d:ea15:0:b0:592:4fb1:be46 with SMTP id t21-20020a0dea15000000b005924fb1be46mr4415583ywe.39.1693470360768;
        Thu, 31 Aug 2023 01:26:00 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id m125-20020a0de383000000b00583d44b4b30sm276164ywe.99.2023.08.31.01.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:26:00 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d776e1f181bso338618276.3;
        Thu, 31 Aug 2023 01:26:00 -0700 (PDT)
X-Received: by 2002:a25:f50d:0:b0:d7b:5d30:5f80 with SMTP id
 a13-20020a25f50d000000b00d7b5d305f80mr4093448ybe.24.1693470360206; Thu, 31
 Aug 2023 01:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com> <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <87v8cv22jh.fsf@mail.lhotse>
In-Reply-To: <87v8cv22jh.fsf@mail.lhotse>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 31 Aug 2023 10:25:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXMpr0spdprjwsV56nJE3vHGTFaodcnVXUa=GMYaB5yKw@mail.gmail.com>
Message-ID: <CAMuHMdXMpr0spdprjwsV56nJE3vHGTFaodcnVXUa=GMYaB5yKw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
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

Hi Michael,

On Thu, Aug 31, 2023 at 7:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> >> The current implementation of append may cause duplicate data and/or
> >> incorrect ranges to be returned to a reader during an update.  Although
> >> this has not been reported or seen, disable the append write operation
> >> while the tree is in rcu mode out of an abundance of caution.
> >>
> >> During the analysis of the mas_next_slot() the following was
> >> artificially created by separating the writer and reader code:
> >>
> >> Writer:                                 reader:
> >> mas_wr_append
> >>    set end pivot
> >>    updates end metata
> >>    Detects write to last slot
> >>    last slot write is to start of slot
> >>    store current contents in slot
> >>    overwrite old end pivot
> >>                                        mas_next_slot():
> >>                                                read end metadata
> >>                                                read old end pivot
> >>                                                return with incorrect range
> >>    store new value
> >>
> >> Alternatively:
> >>
> >> Writer:                                 reader:
> >> mas_wr_append
> >>    set end pivot
> >>    updates end metata
> >>    Detects write to last slot
> >>    last lost write to end of slot
> >>    store value
> >>                                        mas_next_slot():
> >>                                                read end metadata
> >>                                                read old end pivot
> >>                                                read new end pivot
> >>                                                return with incorrect range
> >>    set old end pivot
> >>
> >> There may be other accesses that are not safe since we are now updating
> >> both metadata and pointers, so disabling append if there could be rcu
> >> readers is the safest action.
> >>
> >> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >
> > Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> > ("maple_tree: disable mas_wr_append() when other readers are
> > possible") in v6.5, and is being backported to stable.
> >
> > On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> > following warning:
> >
> >       clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
> >       sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
> >       /soc/timer@e803b000: used for clocksource
> >       /soc/timer@e803c000: used for clock events
> >      +------------[ cut here ]------------
> >      +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
> >      +Interrupts were enabled early
> ...
> >
> > I do not see this issue on any other platform
> > (arm/arm64/risc-v/mips/sh/m68k), several of them use the same
> > RCU configuration.
>
> There's something similar on pmac32 / mac99.
>
> > Do you have a clue?
>
> It seems something in the maple tree code is setting TIF_NEED_RESCHED,
> and that causes a subsequent call to cond_resched() to call schedule()
> and enable interrupts.
>
> On pmac32 enabling CONFIG_DEBUG_ATOMIC_SLEEP fixes/hides the problem.
> But I don't see why.

Enabling CONFIG_DEBUG_ATOMIC_SLEEP on RZ/A1 and RZ/A2 does
fix the problem.
But there must be more to it, as some of my test configs had it enabled,
and others hadn't, while only RZ/A showed the issue.
I tried disabling it on R-Car M2-W (arm32) and R-Car H3 (arm64), and
that did not cause the problem to happen...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
