Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52587856B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbjHWLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjHWLZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:25:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907A6E5D;
        Wed, 23 Aug 2023 04:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D94B633E0;
        Wed, 23 Aug 2023 11:25:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B46C433CA;
        Wed, 23 Aug 2023 11:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692789948;
        bh=RSCJlzoIbu2nlYcjtm3+Lb4Gn8zUZAZHIVtrObxXzo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RGiib85dt5uA6aY3/2p9G7+Bs7q7Sz+pXnpIYFsSS7X5RmvEfOIogU6c44Lho01tL
         ZEWrHJUQokNdmiPP1smDt+NYE3K6F2cU5Ss9biwA71J2KeOMels2UiCUiLDMU8tsBW
         b4XPVuptrenJrvcu1GE93yj0e6mXbdmXDaaG8vXHD49xETSjNRVh9ArppbCdh6dt/6
         FlklOgoJMgQ/Scs3+TCvxdpLx9C806iLsu7ujNL39KP6UVRA/lPCZCk9oPfGiaG5LJ
         K4Vx/qCjyBnSELAgApq9NKID5WTbYbghYqgvjzN73NRaFAWAuLyDv9C3RmegvqrnZk
         kVlAl4vFLo2Yg==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so7106242e87.1;
        Wed, 23 Aug 2023 04:25:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YzDe2QPSp4XfxFls1oGbV7Ub5aNJvRes19bLOymZeD0AsGd1k94
        STryBWXz4Qfhj2Tx2HGcrYzTJ7YeQfAK1jFe06Y=
X-Google-Smtp-Source: AGHT+IELapgOBqpwM40rIzya34pA9XlKPFJCkDxTTQzrLkf8tzHmZ4T6gCjCJYT+7vnZEnBAlszgxFCwUeylImtP8Jc=
X-Received: by 2002:ac2:4e03:0:b0:4fe:19ef:8791 with SMTP id
 e3-20020ac24e03000000b004fe19ef8791mr9385078lfr.38.1692789946212; Wed, 23 Aug
 2023 04:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-7-yukuai1@huaweicloud.com> <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
 <c7a82fb2-cf4b-2095-e813-84aed2418ff0@huaweicloud.com> <2766d001-f618-d224-f8a9-ec38ed1dc2a7@huaweicloud.com>
 <CAPhsuW6JQX7ujeO77NVTme8t0DvzVBrsXRHmayVnp4fwWoYhZg@mail.gmail.com> <a004ed5b-cf4a-2392-c7e5-fcd1161a29a4@huaweicloud.com>
In-Reply-To: <a004ed5b-cf4a-2392-c7e5-fcd1161a29a4@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 23 Aug 2023 04:25:33 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5DytoZDTi1NEv_EDaKoaHNE9Vd3UU_O_-2XzVqq0YNwg@mail.gmail.com>
Message-ID: <CAPhsuW5DytoZDTi1NEv_EDaKoaHNE9Vd3UU_O_-2XzVqq0YNwg@mail.gmail.com>
Subject: Re: [PATCH -next v3 6/7] md: factor out a helper rdev_addable() from remove_and_add_spares()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 1:37=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
[...]
> > diff --git i/drivers/md/md.c w/drivers/md/md.c
> > index 78be7811a89f..8cb855d03e0a 100644
> > --- i/drivers/md/md.c
> > +++ w/drivers/md/md.c
> > @@ -9117,6 +9117,20 @@ void md_do_sync(struct md_thread *thread)
> >   }
> >   EXPORT_SYMBOL_GPL(md_do_sync);
> >
> > +static bool rdev_addable(struct md_rdev *rdev)
> > +{
> > +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >=3D 0=
 ||
> > +           test_bit(Faulty, &rdev->flags))
> > +               return false;
> > +       return true;
> > +}
> > +
> > +static bool rdev_is_readd(struct md_rdev *rdev)
> > +{
> > +       return rdev->saved_raid_disk >=3D 0 ||
> > +               !test_bit(Bitmap_sync, &rdev->flags);
> This should use '&&' instead of '||' ?
>
> > +}
> > +
> >   static int remove_and_add_spares(struct mddev *mddev,
> >                                   struct md_rdev *this)
> >   {
> > @@ -9176,25 +9190,24 @@ static int remove_and_add_spares(struct mddev *=
mddev,
> >          rdev_for_each(rdev, mddev) {
> >                  if (this && this !=3D rdev)
> >                          continue;
> > -               if (test_bit(Candidate, &rdev->flags))
> > -                       continue;
> >                  if (rdev->raid_disk >=3D 0 &&
> >                      !test_bit(In_sync, &rdev->flags) &&
> >                      !test_bit(Journal, &rdev->flags) &&
> >                      !test_bit(Faulty, &rdev->flags))
> >                          spares++;
> > -               if (rdev->raid_disk >=3D 0)
> > +
> > +               if (!rdev_addable(rdev))
> >                          continue;
> > -               if (test_bit(Faulty, &rdev->flags))
> > +
> > +               if (test_bit(Journal, &rdev->flags))
> > +                       goto hot_add_disk;
> > +
>
> I understand what you mean now, but I must use the exact same judgement
> in the new helper md_spares_need_change() in patch 7, there will be
> redundant code this way.
>
> How about this, rework rdev_addable():

Yeah, this was another option that I was thinking about. Let's go with
this version.

Thanks,
Song

>
>    static bool rdev_addable(struct md_rdev *rdev)
>    {
> +         /* rdev is already used, don't add it again. */
>            if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >=3D =
0 ||
>                test_bit(Faulty, &rdev->flags))
>                    return false;
>
> ~         /* Allow to add journal disk. */
> ~         if (test_bit(Journal, &rdev->flags))
> ~_                return true;
>
> ~         /* Allow to add if array is read-write. */
> +         if (md_is_rdwr(rdev->mddev))
> +                 return true;
> +
> +         /*
> +          * For read-only array, only allow to readd a rdev. And if
> bitmap is
> +          * used, don't allow to readd a rdev that is too old.
> +          */
> +         if (rdev->saved_raid_disk >=3D0 && !test_bit(Bitmap_sync,
> &rdev->flags))
> +                 return true;
> +
> +         return false;
>    }
