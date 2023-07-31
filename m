Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA276993D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjGaOQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjGaOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:16:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE6B6;
        Mon, 31 Jul 2023 07:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17CF66116D;
        Mon, 31 Jul 2023 14:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78945C433CB;
        Mon, 31 Jul 2023 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690813010;
        bh=Ut2hG+F2DuNDxRZ9/khpr0nP7BCW47MsLF1TCuGRXBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tYp7cJAquUybQU0N48jI4zOIRZt889tzHjKkdDrzgNvcCALYkO2did5J1n99jX8lV
         rPgrI/7GoX0kOzl/2LwO6PEvDMaCr6XEltUtHrlqIS0zjNNajGPreT3ifDHmMLk2Hu
         PR0M/kuD9M/ti4h/4/LrYg9oKJh1kCmQF+nHRfgzUb43cNpY3VcKkKV5kHAT5/GAi+
         KXZGV3O81AFJOB++ASY6r+4H68XixengFA16cZEypSzqQARZsBCUqXQ8klf2m7gn+d
         G+qPYfw4ywsAxOrXhuM89xmVB6M2E8JpRHvo8x/5GdRRyw44rOjp+0ekRJ+u1vGScM
         lZE0kqCAQeIqQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so69931091fa.1;
        Mon, 31 Jul 2023 07:16:50 -0700 (PDT)
X-Gm-Message-State: ABy/qLY+02metpcIlkHfoc2NLyUc6/iqx1g3PkK1UnymYU56IUWdYMn1
        OyDxwSMaFp40Bq/Y2qaT7Dlp1fjuFgaSw0nNYXQ=
X-Google-Smtp-Source: APBJJlFTUuJmywyctSggpJfz4ebDazp0b2osAyb97HoNLBh38wz3JBdyEIdRdrHP3KogwnmJ2adx2KIoRtfYp3JDqoo=
X-Received: by 2002:a05:6512:36c8:b0:4fe:2d93:2b51 with SMTP id
 e8-20020a05651236c800b004fe2d932b51mr3219834lfs.27.1690813008469; Mon, 31 Jul
 2023 07:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230719063558.3131045-1-maobibo@loongson.cn> <f19c393b-8c2e-e3aa-988a-88a423b59b99@loongson.cn>
 <86h6prt2vx.wl-maz@kernel.org> <5a891302-9657-ec95-4438-bc19d0efb556@loongson.cn>
In-Reply-To: <5a891302-9657-ec95-4438-bc19d0efb556@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 31 Jul 2023 22:16:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wJiw43h2GfSey5CYUsmqX9SE+CAPSPUng9EQFMOcRdw@mail.gmail.com>
Message-ID: <CAAhV-H4wJiw43h2GfSey5CYUsmqX9SE+CAPSPUng9EQFMOcRdw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] irqchip/loongson-eiointc: Add simple irq routing method
To:     bibo mao <maobibo@loongson.cn>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Wed, Jul 26, 2023 at 6:08=E2=80=AFPM bibo mao <maobibo@loongson.cn> wrot=
e:
>
>
>
> =E5=9C=A8 2023/7/26 17:53, Marc Zyngier =E5=86=99=E9=81=93:
> > On Wed, 26 Jul 2023 10:45:51 +0100,
> > bibo mao <maobibo@loongson.cn> wrote:
> >>
> >> slight ping :)
> >
> > Given that you have sent this series 5 times in two weeks, I don't
> > think anyone is in a hurry to review it again. Just give it time.
> Ok, I see.
> Sorry to bring out some noise and thanks for your response.
1, If we really need a "virtual eiointc" variant, please document it
in Documentation/loongarch/irq-chip-model.rst and
Documentation/translations/zh_CN/loongarch/irq-chip-model.rst.
2, Then, I think it is better to only modify the type of 'index' in
Patch-1, and move the 'if (index < 0) ...' modifications to Patch-2.
Because all "virtual eiointc" code should be in a single patch.


Huacai
>
> Regards
> Bibo Mao
> >
> > Thanks,
> >
> >       M.
> >
> >>
> >> =E5=9C=A8 2023/7/19 14:35, Bibo Mao =E5=86=99=E9=81=93:
> >>> Fix return value checking of eiointc_index where int type
> >>> is converted uint32_t and check smaller than 0.
> >>>
> >>> Add simple irq route support on system with only one eiointc node,
> >>> rather than use anysend method.
> >>>
> >>> ---
> >>> Changes in v5:
> >>>   Modify typo issue.
> >>>
> >>> Changes in v4:
> >>>   Modify some spell checking problems.
> >>>   Add Fixes tag.
> >>>
> >>> Changes in v3:
> >>>   Modify some spell checking problems.
> >>>
> >>> Changes in v2:
> >>>   Use the simple irq routing on embeded board like 2K0500 and 2K2000
> >>> board, since there is only one eio node.
> >>>
> >>> ---
> >>> Bibo Mao (2):
> >>>   irqchip/loongson-eiointc: Fix return value checking of eiointc_inde=
x
> >>>   irqchip/loongson-eiointc: Simplify irq routing on some platforms
> >>>
> >>>  drivers/irqchip/irq-loongson-eiointc.c | 93 +++++++++++++++++++++++-=
--
> >>>  1 file changed, 82 insertions(+), 11 deletions(-)
> >>>
> >>
> >>
> >
>
