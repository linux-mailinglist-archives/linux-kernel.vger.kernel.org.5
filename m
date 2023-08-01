Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D5276AC8B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjHAJKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjHAJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536F46B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:07:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9BD614E1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:05:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF87CC43140
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690880749;
        bh=ahFDZkG3uB6gt5CXk13eA4lfV0UiHUFqChNpbvLIrZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L9Gz8w1Y8zXgHls4hV9dnWrTg6XbW620mjJn1nYcUdu09Blf/K/IHj+85KJ6mqviJ
         P69WzDeCdaaVwLmh87f4EpDj6Um2vREBh6nwX6FHlOT75F1Tb6j6m+8tuDfN2uZInU
         JM+0EcwPO/gkDMuy2BT2gxrWNuPhGkqSSBpkGgD67zvdEi065neRqQEvpZ/gunH83D
         IwcDnwOS5bEE4IofrFQrG0+YbGzRpujvvhQ4WqFtAzQVrbPqbt650d8UXQn0AEGxpV
         03gRdwMrmsN9b0+sHOhnYj213Z3xn/HRszJ8v0zg/2nNcWMwJazzbF7oVw2BnwK410
         KjuFYBdcOxwIg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so13060511fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:05:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLZSf0ISN5guPFlAWgGKd18YdCy1pfV9R8i7134a+8HeA0caTgnE
        XOP12q1MTh6Y7FLUJsP7xn60KDQTl2Cqo5Rr6aQ=
X-Google-Smtp-Source: APBJJlFyL5Rr/t9XHuQAHtfsKRciAKpYSXbhhNkZ/pZqJ6eT33e8g+/B+VjFpim1Hv2h0TXC0heRePu62xBWVFYPvyw=
X-Received: by 2002:a19:6908:0:b0:4f8:4512:c846 with SMTP id
 e8-20020a196908000000b004f84512c846mr1443298lfc.49.1690880747644; Tue, 01 Aug
 2023 02:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org> <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
 <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com>
In-Reply-To: <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Aug 2023 17:05:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
Message-ID: <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fixup cmpxchg sematic for memory barrier
To:     WANG Rui <wangrui@loongson.cn>
Cc:     chenhuacai@kernel.or, kernel@xen0n.name, arnd@arndb.de,
        andi.shyti@linux.intel.com, andrzej.hajda@intel.com,
        peterz@infradead.org, will@kernel.org, boqun.feng@gmail.com,
        mark.rutland@arm.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 5:02=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Aug 1, 2023 at 10:29=E2=80=AFAM WANG Rui <wangrui@loongson.cn> wr=
ote:
> >
> > Hello,
> >
> > On Tue, Aug 1, 2023 at 9:16=E2=80=AFAM <guoren@kernel.org> wrote:
> > > diff --git a/arch/loongarch/include/asm/cmpxchg.h b/arch/loongarch/in=
clude/asm/cmpxchg.h
> > > index 979fde61bba8..6a05b92814b6 100644
> > > --- a/arch/loongarch/include/asm/cmpxchg.h
> > > +++ b/arch/loongarch/include/asm/cmpxchg.h
> > > @@ -102,8 +102,8 @@ __arch_xchg(volatile void *ptr, unsigned long x, =
int size)
> > >         "       move    $t0, %z4                        \n"          =
   \
> > >         "       " st "  $t0, %1                         \n"          =
   \
> > >         "       beqz    $t0, 1b                         \n"          =
   \
> > > -       "2:                                             \n"          =
   \
> > >         __WEAK_LLSC_MB                                               =
   \
> > > +       "2:                                             \n"          =
   \
> >
> > Thanks for the patch.
> >
> > This would look pretty good if it weren't for the special memory
> > barrier semantics of the LoongArch's LL and SC instructions.
> >
> > The LL/SC memory barrier behavior of LoongArch:
> >
> > * LL: <memory-barrier> + <load-exclusive>
> > * SC: <store-conditional> + <memory-barrier>
> >
> > and the LoongArch's weak memory model allows load/load reorder for the
> > same address.
> The CoRR problem would cause wider problems than this.For this case,
> do you mean your LL -> LL would be reordered?
>
> CPU 0
>           CPU1
> LL(2) (set ex-monitor)
>
>                 store (break the ex-monitor)
> LL(1) (reordered instruction set ex-monitor
> SC(3) (successes ?)
Sorry for the mail client reformat, I mean:

CPU0  LL(2) (set ex-monitor)
CPU1  STORE (break the ex-monitor)
CPU0  LL(1) (reordered instruction set ex-monitor
CPU0  SC(3) (success?)

>
> >
> > So, the __WEAK_LLSC_MB[1] is used to prevent load/load reorder and no
> > explicit barrier instruction is required after SC.
> >
> > [1] https://lore.kernel.org/loongarch/20230516124536.535343-1-chenhuaca=
i@loongson.cn/
> >
> > Regards,
> > --
> > WANG Rui
> >
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
