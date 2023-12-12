Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C9380EC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376270AbjLLMof convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 07:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346709AbjLLMod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:44:33 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A308A95;
        Tue, 12 Dec 2023 04:44:39 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5906cf5bfdfso709782eaf.1;
        Tue, 12 Dec 2023 04:44:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702385079; x=1702989879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjNQcDTYQAnfr3fmRJK2oEAdeLqwcqbUN0XY6oKXCQg=;
        b=GuQPLw6pYh5LJl1UQSwdDQ9rqxyFJpoR6OsTRL921eIPGQWboXcM+1UzKqzOv2b6/T
         cf2zcC1pmAaHX+FZxRH3pIWz9gT0ewnYJmn0L8GXlJDI4YaAAQAGzUw+l9+87Lmh5Enh
         u2tNVQ/Acof0BczVSwQLBQ9mIFqmaE6jTxjWvuHgMXtQ0rekf9yh4EjcXBxEVdoRQ6OX
         CScSjsmkWsO66LkcM7LZ7sfSmVhum3CtaJPgpePsbY/LG8fwdVhBqLVNhWHgRB5D/31N
         +hKpiQ68PYkcXpriUlIQOq8Ja8HGpx3zH5YMR+NRaEvj4ubfcotVh6TkmKXzxmvObRp5
         YEgw==
X-Gm-Message-State: AOJu0YzyzhBhmbnckMESlvIIpE8QNhoYVH1fWpWjEYoTWLXIuTR1eADI
        l5y1HZeAVJtgew9keNUny73eMbG2YI+9lzeWq0MpmFdk
X-Google-Smtp-Source: AGHT+IFaPqOHnGROxU51VloRyUwzh2mE3uuFsYRSkl9p6/M1CPM363s335XjMw3rU46H2ueCDRDitZHWueNa+uX/JeU=
X-Received: by 2002:a4a:da02:0:b0:590:7b43:47e4 with SMTP id
 e2-20020a4ada02000000b005907b4347e4mr10218441oou.1.1702385078795; Tue, 12 Dec
 2023 04:44:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1700048610.git.quic_nprakash@quicinc.com> <2153c549-2a45-3d1d-a407-e175a34b77bf@quicinc.com>
In-Reply-To: <2153c549-2a45-3d1d-a407-e175a34b77bf@quicinc.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Dec 2023 13:44:27 +0100
Message-ID: <CAJZ5v0jqDEEw0CCAxCOcK+u+BtEa1M1B4t3OZj8umw=rxigu_g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 0/4] PM: hibernate: LZ4 compression support
To:     Nikhil V <quic_nprakash@quicinc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_kprasan@quicinc.com, quic_mpilaniy@quicinc.com,
        quic_shrekk@quicinc.com, mpleshivenkov@google.com,
        ericyin@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 29, 2023 at 11:20 AM Nikhil V <quic_nprakash@quicinc.com> wrote:
>
>
> On 11/15/2023 5:52 PM, Nikhil V wrote:
> > This patch series covers the following:
> > 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
> > used in the next patch where we move to crypto based APIs for
> > compression. There are no functional changes introduced by this
> > approach.
> >
> >
> > 2. Replace LZO library calls with crypto generic APIs
> >
> > Currently for hibernation, LZO is the only compression algorithm
> > available and uses the existing LZO library calls. However, there
> > is no flexibility to switch to other algorithms which provides better
> > results. The main idea is that different compression algorithms have
> > different characteristics and hibernation may benefit when it uses
> > alternate algorithms.
> >
> > By moving to crypto based APIs, it lays a foundation to use other
> > compression algorithms for hibernation.
> >
> >
> > 3. LZ4 compression
> >
> > Extend the support for LZ4 compression to be used with hibernation.
> > The main idea is that different compression algorithms have different
> > characteristics and hibernation may benefit when it uses any of these
> > algorithms: a default algorithm, having higher compression rate but is
> > slower(compression/decompression) and a secondary algorithm, that is
> > faster(compression/decompression) but has lower compression rate.
> >
> > LZ4 algorithm has better decompression speeds over LZO. This reduces
> > the hibernation image restore time.
> > As per test results:
> >                                      LZO             LZ4
> > Size before Compression(bytes)   682696704       682393600
> > Size after Compression(bytes)    146502402       155993547
> > Decompression Rate               335.02 MB/s     501.05 MB/s
> > Restore time                       4.4s             3.8s
> >
> > LZO is the default compression algorithm used for hibernation. Enable
> > CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
> >
> > Compression Benchmarks: https://github.com/lz4/lz4
> >
> >
> > 4. Support to select compression algorithm
> >
> > Currently the default compression algorithm is selected based on
> > Kconfig. Introduce a kernel command line parameter "hib_compression" to
> > override this behaviour.
> >
> > Users can set "hib_compression" command line parameter to specify
> > the algorithm.
> > Usage:
> >      LZO: hib_compression=lzo
> >      LZ4: hib_compression=lz4
> > LZO is the default compression algorithm used with hibernation.
> >
> >
> > Changes in v2:
> >   - Fixed build issues reported by kernel test robot for ARCH=sh, [1].
> > [1] https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@intel.com/
> >
> > Nikhil V (4):
> >    PM: hibernate: Rename lzo* to make it generic
> >    PM: hibernate: Move to crypto APIs for LZO compression
> >    PM: hibernate: Add support for LZ4 compression for hibernation
> >    PM: hibernate: Support to select compression algorithm
> >
> >   .../admin-guide/kernel-parameters.txt         |   6 +
> >   kernel/power/Kconfig                          |  26 ++-
> >   kernel/power/hibernate.c                      |  85 +++++++-
> >   kernel/power/power.h                          |  19 ++
> >   kernel/power/swap.c                           | 189 +++++++++++-------
> >   5 files changed, 251 insertions(+), 74 deletions(-)
> >
> >
> > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
>
> Hi @Rafael/@Pavel/@Len,
>
> Could you please let me know if you have any concerns on this approach?

Not really a concern, but that is a significant change that I would
rather make early in the cycle, which means after the 6.8 merge
window.

No need to resend unless there is something to address in which case
I'll let you know.

Thanks!

> FYI: We have tested this on QEMU and its working fine.
>
> Logs(suspend):
> [   75.242227] PM: Using 3 thread(s) for lz4 compression
> [   75.243043] PM: Compressing and saving image data (17495 pages)...
> [   75.243917] PM: Image saving progress:   0%
> [   75.261727] PM: Image saving progress:  10%
> [   75.277968] PM: Image saving progress:  20%
> [   75.290927] PM: Image saving progress:  30%
> [   75.305186] PM: Image saving progress:  40%
> [   75.318252] PM: Image saving progress:  50%
> [   75.330310] PM: Image saving progress:  60%
> [   75.345906] PM: Image saving progress:  70%
> [   75.359054] PM: Image saving progress:  80%
> [   75.372176] PM: Image saving progress:  90%
> [   75.388411] PM: Image saving progress: 100%
> [   75.389775] PM: Image saving done
> [   75.390397] PM: hibernation: Wrote 69980 kbytes in 0.14 seconds
> (499.85 MB/s)
> [   75.391591] PM: Image size after compression: 28242 kbytes
> [   75.393089] PM: S|
> [   75.399784] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> [   75.439170] sd 0:0:0:0: [sda] Stopping disk
> [   75.501461] ACPI: PM: Preparing to enter system sleep state S5
> [   75.502766] reboot: Power down
>
>
>
> Logs(resume):
> [    1.063248] PM: hibernation: resume from hibernation
> [    1.072868] Freezing user space processes
> [    1.073707] Freezing user space processes completed (elapsed 0.000
> seconds)
> [    1.075192] OOM killer disabled.
> [    1.075837] Freezing remaining freezable tasks
> [    1.078010] Freezing remaining freezable tasks completed (elapsed
> 0.001 seconds)
> [    1.087489] PM: Using 3 thread(s) for lz4 decompression
> [    1.088570] PM: Loading and decompressing image data (17495 pages)...
> [    1.125549] PM: Image loading progress:   0%
> [    1.190380] PM: Image loading progress:  10%
> [    1.204963] PM: Image loading progress:  20%
> [    1.218988] PM: Image loading progress:  30%
> [    1.233697] PM: Image loading progress:  40%
> [    1.248658] PM: Image loading progress:  50%
> [    1.262910] PM: Image loading progress:  60%
> [    1.276966] PM: Image loading progress:  70%
> [    1.290517] PM: Image loading progress:  80%
> [    1.305427] PM: Image loading progress:  90%
> [    1.320666] PM: Image loading progress: 100%
> [    1.321866] PM: Image loading done
> [    1.322599] PM: hibernation: Read 69980 kbytes in 0.23 seconds
> (304.26 MB/s)
> [    1.324795] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [   74.943801] ata1.00: Entering standby power mode
>
>
> Thanks,
> Nikhil V
