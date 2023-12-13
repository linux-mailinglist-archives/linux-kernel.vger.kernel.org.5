Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AF1811905
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjLMQSj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 11:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjLMQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:18:36 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F253A111;
        Wed, 13 Dec 2023 08:18:37 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbccfd048d4so734135276.3;
        Wed, 13 Dec 2023 08:18:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702484317; x=1703089117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLKu1P2+s5HPJe4aX+Y8g8yeSmcwgqyYxJynBDMhKCY=;
        b=JD5zqHzCu30CVnKA5HzYBB/7A58fNv5TwV5XpGqud4saEkwOVG4+3Et8JwDILPVcKu
         RpF6M5LhyHqtl+RXmm4QvBW6fF6TVPgkq2MxVWmmGxBarcJoV7V8XaTa5MqWvFBwpYL1
         BsYr8KV19gmx34L/x7GvuBMV+wITg8vA55jArQtM38CwLLTynrmVbjepUqN4xYqhKZyu
         g6I+1ZMIXF2Xf2UuEwH8cTU6SE1PiXuevXl3+CPSmBO3qlF7QlPsI6sShr9VCoMWxWlj
         rlACiKx1bg84Rg/Nzpgyb/m16rm9mOUWUDEV0CWYZzHME4MoEgKYWESeJNBELf7Mm54/
         mbwA==
X-Gm-Message-State: AOJu0YxeArZi2j/ganryjNbwaPr5Vo6SCHY/MNn6DQU6AyB6/Uso7umT
        HQlewnPYqak5a1jIe9206mYLMmoRy0uOVg==
X-Google-Smtp-Source: AGHT+IFm/dp5IjcrLxV/DKalCk+/kJoncrG3EssM0Q+O458mBMw0F5Gq5WpWY/y9rXPnHmBraMvWeg==
X-Received: by 2002:a25:bec3:0:b0:db5:483d:b4f8 with SMTP id k3-20020a25bec3000000b00db5483db4f8mr4662861ybm.14.1702484316951;
        Wed, 13 Dec 2023 08:18:36 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id j143-20020a252395000000b00dbcdb6e1251sm190757ybj.31.2023.12.13.08.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 08:18:36 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbc72b692adso3857997276.2;
        Wed, 13 Dec 2023 08:18:36 -0800 (PST)
X-Received: by 2002:a25:bec3:0:b0:db5:49d8:bcd1 with SMTP id
 k3-20020a25bec3000000b00db549d8bcd1mr5064654ybm.55.1702484315962; Wed, 13 Dec
 2023 08:18:35 -0800 (PST)
MIME-Version: 1.0
References: <20231211-primate-arbitrate-fbcd307a0b00@spud> <CAMuHMdX0bETuMoZCZM7pAodbwyf0ttZMpKuq0ibBZX7S-YV8xw@mail.gmail.com>
 <20231212-ambition-karma-4834afd4eb16@wendy>
In-Reply-To: <20231212-ambition-karma-4834afd4eb16@wendy>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Dec 2023 17:18:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUS4zjgZp4r1CwE-sO7Ggdk2D=fgfHHqaCpW7dR4Prx6A@mail.gmail.com>
Message-ID: <CAMuHMdUS4zjgZp4r1CwE-sO7Ggdk2D=fgfHHqaCpW7dR4Prx6A@mail.gmail.com>
Subject: Re: [PATCH v1] soc: renesas: make ARCH_R9A07G043 depend on !DMA_DIRECT_REMAP
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>
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

On Tue, Dec 12, 2023 at 9:43 AM Conor Dooley <conor.dooley@microchip.com> wrote:
> On Tue, Dec 12, 2023 at 09:19:32AM +0100, Geert Uytterhoeven wrote:
> > On Mon, Dec 11, 2023 at 11:06 PM Conor Dooley <conor@kernel.org> wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> > >
> > > Randy reported yet another build issue with randconfigs on rv32:
> > > WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
> > >   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=n] && !DMA_DIRECT_REMAP [=y]
> > >   Selected by [y]:
> > >   - ARCH_R9A07G043 [=y] && SOC_RENESAS [=y] && RISCV [=y] && NONPORTABLE [=y] && RISCV_ALTERNATIVE [=y] && !RISCV_ISA_ZICBOM [=n] && RISCV_SBI [=y]
> > >
> > > This happens when DMA_DIRECT_REMAP is selected by the T-Head CMO erratum
> >
> > or by the Zicbom extension support?
>
> Probably, yeah. That was just the conditions for this particular
> randconfig IIRC.
>
> > > option and DMA_GLOBAL_POOL is selected by the Andes CMO erratum. Block
> > > selecting the RZ/Five config option, and by extension DMA_GLOBAL_POOL,
> > > if DMA_DIRECT_REMAP has already been enabled.
> > >
> > > Fixes: 484861e09f3e ("soc: renesas: Kconfig: Select the required configs for RZ/Five SoC")
> > > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > > Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> > > Closes: https://lore.kernel.org/all/24942b4d-d16a-463f-b39a-f9dfcb89d742@infradead.org/
> > > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.8.
> >
> > Or should this be queued as a fix for v6.7 instead?
>
> Depends on your opinion on how critical such a fix is I suppose.
>
> > > ---
> > > I don't know what the exact fixes tag here is as I did not bisect with
> > > the randconfig, so I blamed the one that added DMA_GLOBAL_POOL.
> >
> > Bisection leads to commit da323d4640704001 ("dma-direct: add
> > dependencies to CONFIG_DMA_GLOBAL_POOL") in v6.7-rc1, but that is
> > merely making visible the symptoms, so I think your Fixes tag is fine.

Actually this change cannot be applied (by hand) to the commit in
the Fixes tag, as at that time RISCV_DMA_NONCOHERENT still selected
DMA_DIRECT_REMAP, thus causing a recursive dependency :-(
So I'm gonna drop the Fixes tag, and just queue it for v6.8.  After all
it's "just a randconfig failure", and I don't want anyone to encourage
backporting any of this NONPORTABLE mess to older stable kernels...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
