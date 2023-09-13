Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA7679E824
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240630AbjIMMgr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Sep 2023 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbjIMMgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:36:45 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FC19AD;
        Wed, 13 Sep 2023 05:36:41 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59bdb3d03b1so3248407b3.3;
        Wed, 13 Sep 2023 05:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694608600; x=1695213400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwtaANT9Ahfm5hnU8wwR0DNxicByDj4BLG+WrQta//U=;
        b=lMDM5zADeUOlTQ7h5pObDFnGbpUYl/qrEkw+eS8k2HQwXHYQd5oYg5QjXiZK9O4m/Z
         wMM1RJ+a+z8/pKiEsJi7MO+MrUAulOI2KQCpyCyyIHAQuT+8eKUEEI5yAyAwecSIpPKs
         7yYm9ZfZ1we3awZeshVrsZYf0Ckx/x9tv/UP0rl+IzfsSniOnvtZ/Mv3mbK/JNGs+6Fh
         C9NuS0TT5zv0GEmQQn79rVIT+jdwqWX+kn8dsqY/LpQ5W3Ppp7Ns7E8nvwQVtEkKOqqe
         6F68Q3lgsWSsxOhUjwWm+YHIaiRZZzpcAL+MBSYJww7NqhJ0MfCVWRuSAkyI9IjLStIk
         fwlw==
X-Gm-Message-State: AOJu0YylodeLT1LiiuE2FEU6GB1RhM3pLI4JdPsFGzzEz3+g/zfpL0k0
        E5cRV+Si2hbCaeSQrWoUZMgneERWtNlgng==
X-Google-Smtp-Source: AGHT+IG+oI4JIBl1jocufW6N1ceXNJ+C+OeNL/6hea+Hoo1f1LarJTCUx6/koBKOdhMNqVFkq2ctWg==
X-Received: by 2002:a81:6c87:0:b0:59b:5456:a9bb with SMTP id h129-20020a816c87000000b0059b5456a9bbmr2469645ywc.42.1694608600302;
        Wed, 13 Sep 2023 05:36:40 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id d206-20020a814fd7000000b00598d67585d7sm3131612ywb.117.2023.09.13.05.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:36:39 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d7225259f52so6145186276.0;
        Wed, 13 Sep 2023 05:36:39 -0700 (PDT)
X-Received: by 2002:a25:7449:0:b0:d77:fc5c:cc0 with SMTP id
 p70-20020a257449000000b00d77fc5c0cc0mr2293089ybc.12.1694608599727; Wed, 13
 Sep 2023 05:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230818194136.4084400-1-evan@rivosinc.com> <20230818194136.4084400-2-evan@rivosinc.com>
In-Reply-To: <20230818194136.4084400-2-evan@rivosinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Sep 2023 14:36:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
Message-ID: <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
To:     Evan Green <evan@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-kernel@vger.kernel.org,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        David Laight <David.Laight@aculab.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On Fri, Aug 18, 2023 at 9:44 PM Evan Green <evan@rivosinc.com> wrote:
> Rather than deferring unaligned access speed determinations to a vendor
> function, let's probe them and find out how fast they are. If we
> determine that an unaligned word access is faster than N byte accesses,
> mark the hardware's unaligned access as "fast". Otherwise, we mark
> accesses as slow.
>
> The algorithm itself runs for a fixed amount of jiffies. Within each
> iteration it attempts to time a single loop, and then keeps only the best
> (fastest) loop it saw. This algorithm was found to have lower variance from
> run to run than my first attempt, which counted the total number of
> iterations that could be done in that fixed amount of jiffies. By taking
> only the best iteration in the loop, assuming at least one loop wasn't
> perturbed by an interrupt, we eliminate the effects of interrupts and
> other "warm up" factors like branch prediction. The only downside is it
> depends on having an rdtime granular and accurate enough to measure a
> single copy. If we ever manage to complete a loop in 0 rdtime ticks, we
> leave the unaligned setting at UNKNOWN.
>
> There is a slight change in user-visible behavior here. Previously, all
> boards except the THead C906 reported misaligned access speed of
> UNKNOWN. C906 reported FAST. With this change, since we're now measuring
> misaligned access speed on each hart, all RISC-V systems will have this
> key set as either FAST or SLOW.
>
> Currently, we don't have a way to confidently measure the difference between
> SLOW and EMULATED, so we label anything not fast as SLOW. This will
> mislabel some systems that are actually EMULATED as SLOW. When we get
> support for delegating misaligned access traps to the kernel (as opposed
> to the firmware quietly handling it), we can explicitly test in Linux to
> see if unaligned accesses trap. Those systems will start to report
> EMULATED, though older (today's) systems without that new SBI mechanism
> will continue to report SLOW.
>
> I've updated the documentation for those hwprobe values to reflect
> this, specifically: SLOW may or may not be emulated by software, and FAST
> represents means being faster than equivalent byte accesses. The change
> in documentation is accurate with respect to both the former and current
> behavior.
>
> Signed-off-by: Evan Green <evan@rivosinc.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for your patch, which is now commit 584ea6564bcaead2 ("RISC-V:
Probe for unaligned access speed") in v6.6-rc1.

On the boards I have, I get:

    rzfive:
        cpu0: Ratio of byte access time to unaligned word access is
1.05, unaligned accesses are fast

    icicle:

        cpu1: Ratio of byte access time to unaligned word access is
0.00, unaligned accesses are slow
        cpu2: Ratio of byte access time to unaligned word access is
0.00, unaligned accesses are slow
        cpu3: Ratio of byte access time to unaligned word access is
0.00, unaligned accesses are slow

        cpu0: Ratio of byte access time to unaligned word access is
0.00, unaligned accesses are slow

    k210:

        cpu1: Ratio of byte access time to unaligned word access is
0.02, unaligned accesses are slow
        cpu0: Ratio of byte access time to unaligned word access is
0.02, unaligned accesses are slow

    starlight:

        cpu1: Ratio of byte access time to unaligned word access is
0.01, unaligned accesses are slow
        cpu0: Ratio of byte access time to unaligned word access is
0.02, unaligned accesses are slow

    vexriscv/orangecrab:

        cpu0: Ratio of byte access time to unaligned word access is
0.00, unaligned accesses are slow

I am a bit surprised by the near-zero values.  Are these expected?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
