Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D59276B268
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjHAKxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbjHAKxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:53:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E6F5587
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECDAC61519
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BF3C433CD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690886999;
        bh=u7I+zdXZxktdq8ChnbQrPRnPNrQrNqrJr3UZE+w6xVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YEg8q8AGO7PDRDEJdoUZsaCFcZLFriVWXApTzTAVI4en+f56NOAPhRiRI7jyTg0oh
         igyeJjI16GfahMSl5ri8osu7DEK1txIPZvIydHfEZ32Ot7cU5t61U9sUUMmx4q2/xc
         NCH1wbq346XELm23p2LOi8eUTU2+pYpIR6sfDC7Dau3fapXStyv4X7dUoxb2zMygXt
         eIxvk7ChiKlKyCSRqEdOXXN8OtcGoI3EiMwRUI3REjYEhGwTTcfaL+VlqW4fyDeDvX
         DfT6aj3Nf0MT+a8JR9Op4KlXpHdOdkzXYI9hqZmmgkQoDFAYJMvsm6SgrtAirccr5V
         mwZZ9x1VBMiBw==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-522ab301692so5429551a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 03:49:59 -0700 (PDT)
X-Gm-Message-State: ABy/qLY4JSLdJvQXYrL9JtskoxHER4bMpMIihwEAHZ5eaAiU0sJJ7XJw
        bxVcZ6sRsuUntaOrENwT9vaPb6lTAafog/LCyig=
X-Google-Smtp-Source: APBJJlGmfOzudB4zLRHM997HtkvDTsRmGasa+lA5ovwZauli5GP+7Ze4kTI2UNbtuJnb5revLg7J6IglOClWqNcHT40=
X-Received: by 2002:aa7:d507:0:b0:522:3a28:feca with SMTP id
 y7-20020aa7d507000000b005223a28fecamr2581715edq.24.1690886997423; Tue, 01 Aug
 2023 03:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230801011554.3950435-1-guoren@kernel.org> <CAHirt9ht8AsE=FC8+222JDZXH3T58uLt+o=_pq+1zBhv1MKRjg@mail.gmail.com>
 <CAJF2gTRa5erHomJzLgUFO4SGqd5zSDwn6r3WN7kM8aWpv1vesg@mail.gmail.com>
 <CAJF2gTQ1hV1vipAo3H4X4WiPO84kVVFZcdGq7u4f0bVTry_akQ@mail.gmail.com> <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com>
In-Reply-To: <CAHirt9gVqE=9vviJEY=kY=booVRmFPHrnFsKCXPXnXiWTB8bZQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Aug 2023 18:49:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR2ON33wc87iV564rkDbNiE56h_t0kzKKXdJtGqgJ1sOQ@mail.gmail.com>
Message-ID: <CAJF2gTR2ON33wc87iV564rkDbNiE56h_t0kzKKXdJtGqgJ1sOQ@mail.gmail.com>
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

On Tue, Aug 1, 2023 at 5:32=E2=80=AFPM WANG Rui <wangrui@loongson.cn> wrote=
:
>
> Hello,
>
> On Tue, Aug 1, 2023 at 5:05=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
> >
> > > The CoRR problem would cause wider problems than this.For this case,
> > > do you mean your LL -> LL would be reordered?
> > >
> > > CPU 0
> > >           CPU1
> > > LL(2) (set ex-monitor)
> > >
> > >                 store (break the ex-monitor)
> > > LL(1) (reordered instruction set ex-monitor
> > > SC(3) (successes ?)
> > Sorry for the mail client reformat, I mean:
> >
> > CPU0  LL(2) (set ex-monitor)
> > CPU1  STORE (break the ex-monitor)
> > CPU0  LL(1) (reordered instruction set ex-monitor
> > CPU0  SC(3) (success?)
>
> No. LL and LL won't reorder because LL implies a memory barrier(though
> not acquire semantics).
That means we could remove __WEAK_LLSC_MB totally, right?

>
> Regards,
> --
> WANG Rui
>


--=20
Best Regards
 Guo Ren
