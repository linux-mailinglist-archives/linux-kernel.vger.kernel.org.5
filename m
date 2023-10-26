Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C0E7D8020
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjJZJ5F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 05:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjJZJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:57:04 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59850198;
        Thu, 26 Oct 2023 02:57:02 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a87ac9d245so5223897b3.3;
        Thu, 26 Oct 2023 02:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698314221; x=1698919021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uFMGKk4XVhVY8W08VRVOiCtZ/hducJ/tdn29JUZaZ4=;
        b=bakNyPvZHiTrsfM4aE6puyKL4w2dJ0T1pbmTEdGyHH2PtFvDAqdvQtyOJ+GtQuOCUG
         ZE5SCprvDCXKaE4KpPU7dSCszldvZxM2u0AppkSdD+SyvG5UN29opVqAAW6o4403Xs4O
         Rap+tTXqY2/6LE31+kUcfpE1k0tLR+Wb2rPkBljx9dTBS4ChryDZGPxFYXVMa0SW+qM7
         dSeyTbkEQLUJc1NrfxaKRr3x7mKZaUlQBi2GDKaQg5OE7vKsg8HjRWEmFwjP/KWks5LV
         ZpOYPS1nL2FnmoSuhCzgFlfS0zhxtZkZsif56QY0fD2qrB3oh9R3lAwR0RYs+EcL4R/T
         F3zw==
X-Gm-Message-State: AOJu0YweYZlx1RsjAN3PQze0k0kiDsJWDuuJBIDLj9zHgLGFN6hwtPxy
        7Fm+Rf93IswFQ9K+yNid2pnRPj4fdx61UA==
X-Google-Smtp-Source: AGHT+IH7wIeOjlSJvNMBfUxVOGODAbusdsWocVpyUz6ss9ux9H3elCLDRA4ze+BVHMz7eI2nmkcXRw==
X-Received: by 2002:a81:a1c9:0:b0:595:887f:e180 with SMTP id y192-20020a81a1c9000000b00595887fe180mr18741028ywg.40.1698314221076;
        Thu, 26 Oct 2023 02:57:01 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id b190-20020a0dd9c7000000b005a23ab90366sm5845748ywe.11.2023.10.26.02.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 02:57:00 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5a87ac9d245so5223797b3.3;
        Thu, 26 Oct 2023 02:57:00 -0700 (PDT)
X-Received: by 2002:a5b:60e:0:b0:da0:84b2:5e3e with SMTP id
 d14-20020a5b060e000000b00da084b25e3emr3856249ybq.21.1698314220279; Thu, 26
 Oct 2023 02:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <169824660459.24340.14614817132696360531.stgit@devnote2>
In-Reply-To: <169824660459.24340.14614817132696360531.stgit@devnote2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Oct 2023 11:56:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUQg1KNtq0+pNcT3JANM_XS8518Jd7a=JUafToS3etrzw@mail.gmail.com>
Message-ID: <CAMuHMdUQg1KNtq0+pNcT3JANM_XS8518Jd7a=JUafToS3etrzw@mail.gmail.com>
Subject: Re: [PATCH v2] locking/atomic: sh: Use generic_cmpxchg_local for arch_cmpxchg_local()
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "wuqiang . matt" <wuqiang.matt@bytedance.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 5:10 PM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Use __generic_cmpxchg_local() for arch_cmpxchg_local() implementation
> in SH architecture because it does not implement arch_cmpxchg_local().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
