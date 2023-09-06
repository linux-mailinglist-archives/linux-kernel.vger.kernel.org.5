Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D26794390
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 21:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbjIFTGv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjIFTGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 15:06:40 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F0E59;
        Wed,  6 Sep 2023 12:06:36 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5920efd91c7so1809307b3.2;
        Wed, 06 Sep 2023 12:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694027195; x=1694631995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hr7cLgUZCclofomOdxpQVhNfG1jKUPi2HnqwisL8720=;
        b=dFeUIem4ioHWxmv0UHjOK0O5qM8vmFeL/0VlulfvLSGXDDXLT5dozYVZOce4rmIZlz
         RUx1xeDlh6QPWSfAEUdrlGYG8IhkmLsTJLaGG+eDI1+893hhAfh4GRYKpsvXXG5CiXAy
         MDhRc57H046duSixq8c3OpdbTqm+yoFZFeyT//96AMNweOt/2J3YhFiMdC12//afeKFx
         lI2I6blH1XZeipTY7PSzhU/rtO+FY85/BwBNMk0pNAiVI+hXJMPqursB7mlrHyfxYAiJ
         lVWiom5cfh4st2PkCdXKXjpeHeV8N4LcP4ic3bMjOOB1Y5yZFpCzvFcmR0E+eMOWoiEe
         Vd+A==
X-Gm-Message-State: AOJu0Yw31Rz5lwWmzp/nL/U08uNY6Gi5ahUNf/n2RH/f6OhEBVehFwy1
        Frunw5s3bitIXS6OuD7RGIEKWvMkc/726g==
X-Google-Smtp-Source: AGHT+IEYLksrmP27A7LLEl9wreOXL9OC9W9fyxL9g12q4xJm1463tomIab6qsn0eiHMTKibW07at7Q==
X-Received: by 2002:a0d:cf04:0:b0:573:d3cd:3d2a with SMTP id r4-20020a0dcf04000000b00573d3cd3d2amr16695468ywd.28.1694027195495;
        Wed, 06 Sep 2023 12:06:35 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p189-20020a815bc6000000b0054bfc94a10dsm3906178ywb.47.2023.09.06.12.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 12:06:35 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7b91422da8so158292276.2;
        Wed, 06 Sep 2023 12:06:34 -0700 (PDT)
X-Received: by 2002:a25:7691:0:b0:d6b:8ea4:b8a1 with SMTP id
 r139-20020a257691000000b00d6b8ea4b8a1mr18126841ybc.12.1694027194758; Wed, 06
 Sep 2023 12:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230819004356.1454718-1-Liam.Howlett@oracle.com>
 <20230819004356.1454718-2-Liam.Howlett@oracle.com> <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
In-Reply-To: <20230906152325.dblzauybyoq5kd35@revolver>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Sep 2023 21:06:22 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com>
Message-ID: <CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
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

Hi Liam,

On Wed, Sep 6, 2023 at 5:24 PM Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > The current implementation of append may cause duplicate data and/or
> > > incorrect ranges to be returned to a reader during an update.  Although
> > > this has not been reported or seen, disable the append write operation
> > > while the tree is in rcu mode out of an abundance of caution.
>
> ...
> > >
> > > Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> >
> > Thanks for your patch, which is now commit cfeb6ae8bcb96ccf
> > ("maple_tree: disable mas_wr_append() when other readers are
> > possible") in v6.5, and is being backported to stable.
> >
> > On Renesas RZ/A1 and RZ/A2 (single-core Cortex-A9), this causes the
> > following warning:
> >
> >      clocksource: timer@e803b000: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 28958491609 ns
> >      sched_clock: 32 bits at 66MHz, resolution 15ns, wraps every 32537631224ns
> >      /soc/timer@e803b000: used for clocksource
> >      /soc/timer@e803c000: used for clock events
> >     +------------[ cut here ]------------
> >     +WARNING: CPU: 0 PID: 0 at init/main.c:992 start_kernel+0x2f0/0x480
> >     +Interrupts were enabled early
>
> Note that the maple tree is involved in tracking the interrupts, see
> kernel/irq/irqdesc.c irq_insert_desc(), etc.
>
> >     +CPU: 0 PID: 0 Comm: swapper Not tainted 6.5.0-rza2mevb-10197-g99b80d6b92b5 #237
>
> I cannot find commit id 99b80d6b92b5.

That's my local tree, based on renesas-drivers-2023-08-29-v6.5.

>
> >     +Hardware name: Generic R7S9210 (Flattened Device Tree)
> >     + unwind_backtrace from show_stack+0x10/0x14
> >     + show_stack from dump_stack_lvl+0x24/0x3c
> >     + dump_stack_lvl from __warn+0x74/0xb8
> >     + __warn from warn_slowpath_fmt+0x78/0xb0
> >     + warn_slowpath_fmt from start_kernel+0x2f0/0x480
> >     + start_kernel from 0x0
> >     +---[ end trace 0000000000000000 ]---
> >      Console: colour dummy device 80x30
> >      printk: console [tty0] enabled
> >      Calibrating delay loop (skipped) preset value.. 1056.00 BogoMIPS (lpj=5280000)
> >
> > Reverting this commit fixes the issue.
>
> I have set up testing with qemu for powerpc 32b, and reverting this
> patch does not fix it for me.  Did you revert the patch or bisect to the
> issue?

I did bisect the issue (on RZ/A) to cfeb6ae8bcb96ccf.
Reverting that commit on top of my local tree fixed the issue.

> It also happens on 0e0e9bd5f7b9 (I ran git checkout cfeb6ae8bcb96ccf^ to
> get the commit immediately before cfeb6ae8bcb96ccf).

That is not the case on Renesas RZ/A (which is arm32).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
