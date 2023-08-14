Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC977BDD8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjHNQVm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Aug 2023 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHNQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:21:14 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8556EF1;
        Mon, 14 Aug 2023 09:21:13 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5899ed05210so47216097b3.3;
        Mon, 14 Aug 2023 09:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692030072; x=1692634872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LQvPgG2h1/fLfnTL/EIPEHhur13Ow7MR7eEqaGIBCU=;
        b=BcM161IaZP8yd1CaIbtvBSkxW+TPDrPTs46TxOWnWOJ3iE/Tvxaw+AwkI2VUMT1lkt
         DRnFw82wDxrUz3kmncvnj/4XbqIC7fuM5//L/24fb0Hn6/n/FuBB0ecwYw4ywCAyL50a
         kfKStLvIFn9vZ08bJUNXLwLC67Vj9wLVwl200czXCP2bYwmH7IQnGlOBIcnm45B45K3g
         BNPkcEW0cIf6xrtXDnGY0OKE6ClxJaQEiFsvUyU6hjoDBhpmgvjeoH1gvmf4xKS3y7pc
         DiyjAPgJqLZ+AqXwr26XhNBledxtN+GqB6trdlsDYMHOmottGDczC8Ro6bZ5tgD7sgBm
         +32g==
X-Gm-Message-State: AOJu0YwAqLwfo6YFYRytX4pNCN1OabM7WHtnmZICBaooUSkCoTQQez6c
        j/IUwieJabsL216LvSs21rtssTXc042Ayg==
X-Google-Smtp-Source: AGHT+IEf6L/iS4ShmH/QjRXmuRIkIRuzWe1qcS9HzdpxBcSEUj2dYpsYjDG4kteu1T+H/RSdVXV5aQ==
X-Received: by 2002:a0d:d684:0:b0:583:d32f:ed61 with SMTP id y126-20020a0dd684000000b00583d32fed61mr11057131ywd.27.1692030072394;
        Mon, 14 Aug 2023 09:21:12 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id h125-20020a0df783000000b005869cf151ebsm2831363ywf.144.2023.08.14.09.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 09:21:12 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso4592481276.3;
        Mon, 14 Aug 2023 09:21:12 -0700 (PDT)
X-Received: by 2002:a25:ae98:0:b0:d0f:926b:c734 with SMTP id
 b24-20020a25ae98000000b00d0f926bc734mr10259367ybj.61.1692030071857; Mon, 14
 Aug 2023 09:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi4Yau-3Bsv2rXYmtXMTLaj3=Wyf4cdM6d89czFvkVsRQ@mail.gmail.com>
 <20230724122626.1701631-1-geert@linux-m68k.org> <88f83d73-781d-bdc-126-aa629cb368c@linux-m68k.org>
 <202307281551.D894AA39@keescook>
In-Reply-To: <202307281551.D894AA39@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Aug 2023 18:20:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRiacSxqDzYmakWAQB99kYvY0Bi9zALP9ZnC9Xs_xO5g@mail.gmail.com>
Message-ID: <CAMuHMdXRiacSxqDzYmakWAQB99kYvY0Bi9zALP9ZnC9Xs_xO5g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.5-rc3
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

On Sat, Jul 29, 2023 at 12:57 AM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 24, 2023 at 02:43:02PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 24 Jul 2023, Geert Uytterhoeven wrote:
> > > JFYI, when comparing v6.5-rc3[1] to v6.5-rc2[3], the summaries are:
> > >  - build errors: +5/-0
> >
> >   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 583:25, 493:25
> >
> > mips-gcc13/mips-allmodconfig
> >
> > Full context:
> >
> >     In function 'fortify_memset_chk',
> >       inlined from 'memset_io' at /kisskb/src/arch/mips/include/asm/io.h:486:2,
> >       inlined from 'build_auth_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:2697:2:
> >     /kisskb/src/include/linux/fortify-string.h:493:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >       493 |                         __write_overflow_field(p_size_field, size);
> >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >     In function 'fortify_memcpy_chk',
> >       inlined from 'memcpy_toio' at /kisskb/src/arch/mips/include/asm/io.h:494:2,
> >       inlined from 'translate_frame' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:955:3,
> >       inlined from 'ray_hw_xmit.constprop' at /kisskb/src/drivers/net/wireless/legacy/ray_cs.c:912:12:
> >     /kisskb/src/include/linux/fortify-string.h:583:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >       583 |                         __write_overflow_field(p_size_field, size);
> >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Single-element flexible array abuse in drivers/net/wireless/legacy/rayctl.h:tx_msg.var
>
> ^^^^
> is this line from you or is there a tool outputting this? Because, yes,

It is a line from me.

(should I take it as a compliment that I start sounding like a tool? ;-)

> very true:
>
> struct tx_msg {
>     struct tib_structure tib;
>     struct phy_header phy;
>     struct mac_header mac;
>     UCHAR  var[1];
> };
>
> I'll send a patch.

Thanks, I noticed you took care while I was enjoying summer holidays ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
