Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4F67DA55C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 08:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjJ1GoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJ1GoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 02:44:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C997AB;
        Fri, 27 Oct 2023 23:44:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3221C433C9;
        Sat, 28 Oct 2023 06:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698475458;
        bh=dwWbOPIf2uWAMXmhSQIynTHTbZsemQlqSM9b/f6BDlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aA6GYP0nGlgOIHepk7aNmZFYb3QGD3WuyEbeC7nn/qtDxehdB94TDc1o12B94Vl8a
         zQNRzpQxBmDl53840gS8k7A2spJe4w+rFvzTJ6m1jiS33w9pMMlUYmazBawCx+YpWH
         R3tpUyWPlFofo5JjQd6KFPQJy3Y+JHtZISP3ael7kFeL4HSU+gXH2+S3T+dCD5/SkJ
         L09S2wjnVM+R9WymLfqLJ9G2aek1sn+h4zXQeWcPJZyY5DL2yxzZiPtJ38yovqbYvS
         YYimutwflOavuaGc3eW8fE8m1/qoPU0l3EQniKGywyzRCLRS9S1+nh+DDD/D3mt09N
         3kjxqItMNFwzw==
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7ba0d338367so361074241.2;
        Fri, 27 Oct 2023 23:44:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YyAGQxX7NpEmPKf9elf4maVAVMJfx2bx5riaET85uXdXbTGngAT
        fZpgL9ygzvBm9h/IOkbEVy25t4ZzjKxvt/pSvZw=
X-Google-Smtp-Source: AGHT+IEtSf0sXKNDqL3U/J8AvmS6jcRIXaiBt2WTHVRrZcMGatGrwAEyBC4D8idnsxc8WWapvt51zmVY7tDm3a6krO4=
X-Received: by 2002:a1f:1c4a:0:b0:49b:289a:cc4a with SMTP id
 c71-20020a1f1c4a000000b0049b289acc4amr4971311vkc.3.1698475457794; Fri, 27 Oct
 2023 23:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231023-imx214-v1-0-b33f1bbd1fcf@apitzsch.eu>
 <20231023-imx214-v1-2-b33f1bbd1fcf@apitzsch.eu> <CAPybu_2gya-XP2-JH8roYgyROUAeTbVBaY1ypMKyVp+ujb=t6A@mail.gmail.com>
 <8332c443fe33a74774f2375009a31e7895fcf37a.camel@apitzsch.eu>
In-Reply-To: <8332c443fe33a74774f2375009a31e7895fcf37a.camel@apitzsch.eu>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Sat, 28 Oct 2023 08:44:01 +0200
X-Gmail-Original-Message-ID: <CAPybu_3FF__5hpcSeAgc0pkxnBjbX5aGt9yif+CvYp4_JFAp-w@mail.gmail.com>
Message-ID: <CAPybu_3FF__5hpcSeAgc0pkxnBjbX5aGt9yif+CvYp4_JFAp-w@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: i2c: imx214: Move controls init to separate function
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andr=C3=A9

On Fri, Oct 27, 2023 at 11:23=E2=80=AFPM Andr=C3=A9 Apitzsch <git@apitzsch.=
eu> wrote:
>
> Hi Ricardo,
>
> Am Freitag, dem 27.10.2023 um 14:25 +0200 schrieb Ricardo Ribalda
> Delgado:
> > Hi Andre
> > On Mon, Oct 23, 2023 at 11:49=E2=80=AFPM Andr=C3=A9 Apitzsch <git@apitz=
sch.eu>
> > wrote:
> > >
> > > Code refinement, no functional changes.
> > >
> > > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> >
> > With Jacopos comments (don't use de_err_probe())
> > Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> >
> > > +       ret =3D imx214_ctrls_init(imx214);
> > > +       if (ret < 0)
> > >                 goto free_ctrl;
> >
> > It seems like we can mutex_destroy a non inited mutex. Could you send
> > a follow-up patch to fix that?
> >
> Sorry, I don't get it. Could you explain what you mean. Thanks.
>

If the controls are initialized incorrectly we will jump to free_ctrl
in line 1046, which calls
mutex_destroy(&imx214->mutex);

But that mutex initialized in line 1050.

You did not introduce the bug, but since you have the hardware and are
sending the other patches it would be great if you could add a new
patch to fix it :)

Thanks!


> > Thanks!
>
