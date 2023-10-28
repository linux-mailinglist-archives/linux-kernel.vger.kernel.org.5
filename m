Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B117DA5C2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 10:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjJ1INS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 04:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJ1INR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 04:13:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4623BAB;
        Sat, 28 Oct 2023 01:13:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7486C433C7;
        Sat, 28 Oct 2023 08:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698480794;
        bh=0K17GMprK6V7COZcCvIUI0Oj2dZxyTFkCjXFFAz65JQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DeSl9DZQBzwWg7oITNEEKKT1pglTJ3jEoW2vCPz3G/AXbnSsray5NZcuEZYFRdlmV
         tVkd7oaj/wHo8e7Ea0lyKAAAfZftL32cLZyXRPGZf854FfcX5vd0wUYY/HSoaVTaZO
         dCjqA799TpfGqgBYBQCdkdCW7QwxHBbfTjR67yHcKtNPZGTtUxcZD7QvGG0Nt6mj0B
         u9lXJa2UTPgQmaLKIGeHe8wBPZORZOR01Qcbe0VJkUqnsY2x/Dix4ufHzm1psfHUgi
         LeEJjf7xTkacgFO4wroaG/1/NYiBJ7KIZmrxtpjjmvlkXZOYjzIjmjfgwElzY+65CU
         eBgWLn4ZGYmEg==
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-457ee0df54eso1188970137.0;
        Sat, 28 Oct 2023 01:13:14 -0700 (PDT)
X-Gm-Message-State: AOJu0YzbKEcB2NV5+2uW2jrOteD/0QDdFjTH9tAf36+ZqYE2YdRkTakJ
        Su8+rxWFPAvHcIy+0/o1LPeHxToB/3I6j4E3FGQ=
X-Google-Smtp-Source: AGHT+IE4s0GJHDdy2sS75sTFkGBeWVQFdIrOqLP4UzM/awguC0ul1br+T81FzTd1G32GYHwY2qEqZYQkNyrMfzQthsc=
X-Received: by 2002:a67:c21b:0:b0:457:bc6c:937c with SMTP id
 i27-20020a67c21b000000b00457bc6c937cmr5358530vsj.4.1698480793871; Sat, 28 Oct
 2023 01:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231028-imx214-v2-0-69a8fb730d6e@apitzsch.eu>
 <20231028-imx214-v2-5-69a8fb730d6e@apitzsch.eu> <CAPybu_1rw8eC=hMXfW1aS-_vJNDnNGTJEL+_k=xK=q5ajz7kRw@mail.gmail.com>
 <72fc57142351331a8a42a6569727b6dd194d419c.camel@apitzsch.eu>
In-Reply-To: <72fc57142351331a8a42a6569727b6dd194d419c.camel@apitzsch.eu>
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
Date:   Sat, 28 Oct 2023 10:12:56 +0200
X-Gmail-Original-Message-ID: <CAPybu_16L0bkjC4qnzCGgqFs45w54bbYeavvJWJqjh3=1AGHVQ@mail.gmail.com>
Message-ID: <CAPybu_16L0bkjC4qnzCGgqFs45w54bbYeavvJWJqjh3=1AGHVQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] media: i2c: imx214: Fix cleanup after controls
 initialization error
To:     =?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
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

Hi Andre

On Sat, Oct 28, 2023 at 9:51=E2=80=AFAM Andr=C3=A9 Apitzsch <git@apitzsch.e=
u> wrote:
>
> Hi Ricardo,
>
> Am Samstag, dem 28.10.2023 um 09:30 +0200 schrieb Ricardo Ribalda
> Delgado:
> > Hi Andre
> >
> > On Sat, Oct 28, 2023 at 9:19=E2=80=AFAM Andr=C3=A9 Apitzsch <git@apitzs=
ch.eu>
> > wrote:
> > >
> > > If the controls are initialized incorrectly, don't destroy the
> > > mutex not
> > > initialized yet and don't free controls as that is handled in
> > > imx214_ctrls_init().
> > >
> > > Signed-off-by: Andr=C3=A9 Apitzsch <git@apitzsch.eu>
> >
> > Since you are calling v4l2_ctrl_handler_free() in imx214_ctrls_init,
> > I think you should squash this patch with 2/5.
> >
> > Sorry for asking for a follow-up patch :S
>
> I will squash it. Shall I keep the r-b tags?

That is ok

>
> Is it okay to send the new version now?

Yes please, thanks :)

>
> >
> > Regards!
> >
> >
> > > ---
> > >  drivers/media/i2c/imx214.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/imx214.c
> > > b/drivers/media/i2c/imx214.c
> > > index e0d9624a9d3f..0aba28d6dc2f 100644
> > > --- a/drivers/media/i2c/imx214.c
> > > +++ b/drivers/media/i2c/imx214.c
> > > @@ -1069,7 +1069,7 @@ static int imx214_probe(struct i2c_client
> > > *client)
> > >
> > >         ret =3D imx214_ctrls_init(imx214);
> > >         if (ret < 0)
> > > -               goto free_ctrl;
> > > +               goto error_power_off;
> > >
> > >         mutex_init(&imx214->mutex);
> > >         imx214->ctrls.lock =3D &imx214->mutex;
> > > @@ -1100,6 +1100,7 @@ static int imx214_probe(struct i2c_client
> > > *client)
> > >  free_ctrl:
> > >         mutex_destroy(&imx214->mutex);
> > >         v4l2_ctrl_handler_free(&imx214->ctrls);
> > > +error_power_off:
> > >         pm_runtime_disable(imx214->dev);
> > >
> > >         return ret;
> > >
> > > --
> > > 2.42.0
> > >
>
