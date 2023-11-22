Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8597F4009
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbjKVIYF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 03:24:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjKVIYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:24:04 -0500
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AABA4;
        Wed, 22 Nov 2023 00:23:59 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so622354276.0;
        Wed, 22 Nov 2023 00:23:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700641439; x=1701246239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy1My54yzyi9AiFrv2nlq4bEUpW9uWwjs7YqVEJrmzU=;
        b=OnFcIRLIzEC2kvMWX5FRgkaaQ/kS8UeBDhRzQg9gP6s9xBFge+L+qPePC48TWBsG+m
         E1kOyyiLstRvLbSXKtsB0LE5bazCvbfMzW3EItYe/qXJyGbj6PWhKijo7S6ovkQgvXbS
         10s3FlHPXh48A5N69K8DuMJXE/V+hc118oFH3h9Q1Ln0QNPgQ5LLhKp6lMvmV8PuIsCj
         AHZBfRw91Ty7J6+XLJiao/xFHkRvZOu0wPWgbwehjdCGsJFmIhtfSETEIuFq2wksZbs9
         OBzxifp6bOhTiws46UVCwNtPOxkoX/pxt5lTYrsjdosQo0CUefFIgmMUZqQDnsE/bSHT
         PAmA==
X-Gm-Message-State: AOJu0YwLM5MIJ/HWirrUSxoXnk0Kfak6SPLZpr1ktmcUIqHdCYgePCSI
        hTGMY8dmZww0lYw5lroHl6W90ZTKCJKZWA==
X-Google-Smtp-Source: AGHT+IFvfzpHACzFnQwn+vsv0ZZY4cK89OcH/XPBZTjHfYPaVATZSt8axcfLiD4RjF2EUXZWvC1mrQ==
X-Received: by 2002:a25:9d01:0:b0:d9a:fd65:f97f with SMTP id i1-20020a259d01000000b00d9afd65f97fmr1383177ybp.17.1700641438739;
        Wed, 22 Nov 2023 00:23:58 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k16-20020a056902025000b00d9a36ded1besm1230779ybs.6.2023.11.22.00.23.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 00:23:58 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so622341276.0;
        Wed, 22 Nov 2023 00:23:58 -0800 (PST)
X-Received: by 2002:a25:d742:0:b0:d9a:d16f:dddf with SMTP id
 o63-20020a25d742000000b00d9ad16fdddfmr1200974ybg.24.1700641437861; Wed, 22
 Nov 2023 00:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20231121202459.36874-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231121202459.36874-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Nov 2023 09:23:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXozB7PVOZM+SQa9D6Zca3x_+LE63RhmBGPDvmOma1fUA@mail.gmail.com>
Message-ID: <CAMuHMdXozB7PVOZM+SQa9D6Zca3x_+LE63RhmBGPDvmOma1fUA@mail.gmail.com>
Subject: Re: [PATCH] riscv: errata: andes: Probe IOCP during boot stage
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Yu Chien Peter Lin <peterlin@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Nov 21, 2023 at 9:25 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> We should be probing for IOCP during boot stage only. As we were probing
> for IOCP for all the stages this caused the below issue during module-init
> stage,
>
> [9.019104] Unable to handle kernel paging request at virtual address ffffffff8100d3a0
> [9.027153] Oops [#1]
> [9.029421] Modules linked in: rcar_canfd renesas_usbhs i2c_riic can_dev spi_rspi i2c_core
> [9.037686] CPU: 0 PID: 90 Comm: udevd Not tainted 6.7.0-rc1+ #57
> [9.043756] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
> [9.050339] epc : riscv_noncoherent_supported+0x10/0x3e
> [9.055558]  ra : andes_errata_patch_func+0x4a/0x52
> [9.060418] epc : ffffffff8000d8c2 ra : ffffffff8000d95c sp : ffffffc8003abb00
> [9.067607]  gp : ffffffff814e25a0 tp : ffffffd80361e540 t0 : 0000000000000000
> [9.074795]  t1 : 000000000900031e t2 : 0000000000000001 s0 : ffffffc8003abb20
> [9.081984]  s1 : ffffffff015b57c7 a0 : 0000000000000000 a1 : 0000000000000001
> [9.089172]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : ffffffff8100d8be
> [9.096360]  a5 : 0000000000000001 a6 : 0000000000000001 a7 : 000000000900031e
> [9.103548]  s2 : ffffffff015b57d7 s3 : 0000000000000001 s4 : 000000000000031e
> [9.110736]  s5 : 8000000000008a45 s6 : 0000000000000500 s7 : 000000000000003f
> [9.117924]  s8 : ffffffc8003abd48 s9 : ffffffff015b1140 s10: ffffffff8151a1b0
> [9.125113]  s11: ffffffff015b1000 t3 : 0000000000000001 t4 : fefefefefefefeff
> [9.132301]  t5 : ffffffff015b57c7 t6 : ffffffd8b63a6000
> [9.137587] status: 0000000200000120 badaddr: ffffffff8100d3a0 cause: 000000000000000f
> [9.145468] [<ffffffff8000d8c2>] riscv_noncoherent_supported+0x10/0x3e
> [9.151972] [<ffffffff800027e8>] _apply_alternatives+0x84/0x86
> [9.157784] [<ffffffff800029be>] apply_module_alternatives+0x10/0x1a
> [9.164113] [<ffffffff80008fcc>] module_finalize+0x5e/0x7a
> [9.169583] [<ffffffff80085cd6>] load_module+0xfd8/0x179c
> [9.174965] [<ffffffff80086630>] init_module_from_file+0x76/0xaa
> [9.180948] [<ffffffff800867f6>] __riscv_sys_finit_module+0x176/0x2a8
> [9.187365] [<ffffffff80889862>] do_trap_ecall_u+0xbe/0x130
> [9.192922] [<ffffffff808920bc>] ret_from_exception+0x0/0x64
> [9.198573] Code: 0009 b7e9 6797 014d a783 85a7 c799 4785 0717 0100 (0123) aef7
> [9.205994] ---[ end trace 0000000000000000 ]---
>
> This is because we called riscv_noncoherent_supported() for all the stages
> during IOCP probe. riscv_noncoherent_supported() function sets
> noncoherent_supported variable to true which has an annotation set to
> "__ro_after_init" due to which we were seeing the above splat. Fix this by
> probing IOCP during boot stage only.
>
> Fixes: e021ae7f5145 ("riscv: errata: Add Andes alternative ports")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/riscv/errata/andes/errata.c
> +++ b/arch/riscv/errata/andes/errata.c
> @@ -60,7 +60,8 @@ void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct al
>                                               unsigned long archid, unsigned long impid,
>                                               unsigned int stage)
>  {
> -       errata_probe_iocp(stage, archid, impid);
> +       if (stage == RISCV_ALTERNATIVES_BOOT)
> +               errata_probe_iocp(stage, archid, impid);
>
>         /* we have nothing to patch here ATM so just return back */
>  }

I believe this still causes errata_probe_iocp() to be called twice:
once from apply_boot_alternatives(), and a second time (if CONFIG_MMU=y)
from apply_vdso_alternatives().  Is that OK?

Perhaps instead you want to add a check to errata_probe_iocp() (after
the check for CONFIG_ERRATA_ANDES_CMO), to bail out if the function
was called before?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
