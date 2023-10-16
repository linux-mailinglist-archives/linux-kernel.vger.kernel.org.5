Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4557CA7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjJPMYK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 08:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPMYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:24:09 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912CA9C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:24:07 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7afd45199so56248117b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697459046; x=1698063846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZcwFp66xptXd4AEmlGTA3AEv44O/pe/cNK0gPURnGg=;
        b=SitQSu1pObqEqqnLXdJaBetrO9D3WpVpDKi7WXfLCcBCK3DL8x6e2fzuorpJnP7rZ8
         AXhHUmnM2pRHF0PIC1NwFIDmkJhkeN1LTH3xc4EU8paNIt1gz2VaGzQBvwRnMGsdiN+/
         W4OLpDfg9FzW2qMndLNk+w2CG9ocsluw74Kha1LvRIZGUJgVTzH5Kj+914RXh+Sacm+N
         np89dmY1mPXMPw7Sosd062/mHHjW3aTYK9wA14AVoh8KVV+4YhBigMcEoey5xAlq+FCs
         XFL+D9VHX5UWUqzK7rZEo7kJI3v5zGkywLjmsi02PXXWk0dq9B0NzKxeLmD4ZJwIb1AW
         ztDg==
X-Gm-Message-State: AOJu0YzCuren2RXjdExvdlvSBeGm7Xz2WtdEH8H1b2vAP2whOtETe1N4
        nKyXH2rRiD3mpuvdTmk6wcjXHT6XM8Szfw==
X-Google-Smtp-Source: AGHT+IHMgMTw+3HdmyZR3+mGHaI1cbXhXRtj9Ers60/pmUcxjQBYlqE7pj5dl7hdh64uOMqmxfCzNw==
X-Received: by 2002:a81:5388:0:b0:59f:5da9:d53c with SMTP id h130-20020a815388000000b0059f5da9d53cmr32439631ywb.35.1697459046553;
        Mon, 16 Oct 2023 05:24:06 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id w192-20020a8149c9000000b0059f650f46b2sm2170763ywa.7.2023.10.16.05.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 05:24:06 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7afd45199so56247947b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 05:24:06 -0700 (PDT)
X-Received: by 2002:a81:5751:0:b0:5a7:b723:8fa3 with SMTP id
 l78-20020a815751000000b005a7b7238fa3mr18207000ywb.26.1697459045950; Mon, 16
 Oct 2023 05:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
In-Reply-To: <7858a184cda66e0991fd295c711dfed7e4d1248c.1696603287.git.geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 16 Oct 2023 14:23:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQ72KOPw5vxNfhjoTR-SsaELeKneBmyQPYEWa_o5OZZA@mail.gmail.com>
Message-ID: <CAMuHMdUQ72KOPw5vxNfhjoTR-SsaELeKneBmyQPYEWa_o5OZZA@mail.gmail.com>
Subject: Re: [PATCH/RFC] m68k: Add full preempt support
To:     Greg Ungerer <gerg@linux-m68k.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
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

On Fri, Oct 6, 2023 at 4:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Currently, a Preemptible Kernel is only supported on the Coldfire CPU
> family.  Extend preempt support to the full Classic M68K CPU family
> (68020+ with MMU, and 68000-derivatives without MMU).
>
> Make sure preemption is disabled in loops involving cache and TLB
> flushing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested on ARAnyM, using none/voluntary/full preemption.
> Compile-tested on 68000.
>
> I don't know if all of the preempt_{dis,en}able() pairs are really
> needed, or if we need more of them.  I just followed what some other
> architectures are doing.
>
> Without the preempt_{dis,en}able() pairs, the kernel panics on ARAnyM while
> starting early userspace (Debian 4.0), cfr. below.
> Does full preemption work on Coldfire without?
> Thanks for your comments!
>
>     BUG: Bad rss-counter state mm:93ade98e type:MM_FILEPAGES val:-7
>     BUG: Bad rss-counter state mm:93ade98e type:MM_ANONPAGES val:-1
>     Kernel panic - not syncing: table already free!

Ran into one of these again, once, so probably we need more
preempt_{dis,en}able() pairs, but where?

    BUG: Bad rss-counter state mm:9bb416c6 type:MM_FILEPAGES val:-20
    BUG: Bad rss-counter state mm:9bb416c6 type:MM_ANONPAGES val:-6
    Kernel panic - not syncing: table already free!
    CPU: 0 PID: 480 Comm: grep Not tainted
6.6.0-rc6-atari-01887-g1ab3ae298649 #1601
    Stack from 018c9c8c:
            018c9c8c 0048a940 0048a940 00000000 00000001 003c0caa
0048a940 003b9b96
            00000001 00000001 01a58000 01a62100 01a5b000 000cf316
018c9dd2 00006440
            0047d67f 80039000 c0000000 01a58b00 80039000 80000000
c0000000 01a62100
            01a5b000 000cfd0e 01a58b00 00000001 ffffffff 018c9db2
00000000 000cfb36
            80000000 01a60a68 01a60a68 003aa02e 000dbd0a 000d557c
80000000 80038fff
            80038fff bfffffff 000cfd8e 018c9dd2 80000000 80039000
00000000 c0000000
    Call Trace: [<003c0caa>] dump_stack+0xc/0x10
     [<003b9b96>] panic+0xd8/0x256
     [<000cf316>] pmd_offset.isra.0+0x0/0x20
     [<00006440>] free_pointer_table+0x68/0x124
     [<000cfd0e>] free_pgd_range+0x1d8/0x1ea
     [<000cfb36>] free_pgd_range+0x0/0x1ea
     [<003aa02e>] mas_find+0x0/0x4c
     [<000dbd0a>] unlink_anon_vmas+0x0/0x108
     [<000d557c>] unlink_file_vma+0x0/0x40
     [<000cfd8e>] free_pgtables+0x6e/0x80
     [<00045eec>] up_read+0x0/0x62
     [<000d63fc>] exit_mmap+0x118/0x1ee
     [<0000c001>] asinbig+0x25/0x34
     [<0000ffff>] EXPTBL+0x2eb/0x400
     [<0000ffff>] EXPTBL+0x2eb/0x400
     [<00021f10>] __mmput+0x18/0xae
     [<00025cce>] do_exit+0x2b4/0x7ba
     [<00026316>] do_group_exit+0x1e/0x96
     [<0002e354>] get_signal+0x19c/0x694
     [<000032fc>] test_ti_thread_flag+0x0/0x14
     [<0002d6b6>] force_sig_info_to_task+0xb0/0xea
     [<00003caa>] do_notify_resume+0x36/0x4a0
     [<0002d970>] force_sig_fault_to_task+0x32/0x3e
     [<0002d990>] force_sig_fault+0x14/0x1a
     [<0000597c>] send_fault_sig+0x24/0x84
     [<00002632>] do_signal_return+0x10/0x1a
     [<00088000>] adjust_reg_min_max_vals+0x106/0x140c

    ---[ end Kernel panic - not syncing: table already free! ]---

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
