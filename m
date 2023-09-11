Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C38D79C2D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbjILC2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjILC2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C20B138950;
        Mon, 11 Sep 2023 18:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8853C4166B;
        Mon, 11 Sep 2023 21:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468638;
        bh=YYwF/q724HwNSDMy+qGl7+I+64RYR/rfZ2c+ySlsNWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cQfkmNmL1Zg4FIzZ86Dny7cT0/R5nNeMsVdE19IhQ9Yp1aPh4yjXXbQZ5EnCP3Aic
         vQuE7yWPzXcXqT28AqJebu5bcKKOQIYorgtGdUlM1sFmoZVvl8BssoW8tpcF6MZ0lc
         UraoXh20Q6R612ICMhUgVHSRYEYd/fwVlQslAd/n62aQtkABAU0LyAh4bszCVELjXi
         92eN/kKnSYSZUSSoF0nGvmvarrHVpijpVR25zSzacC/jS+w5UluvqQcY63lHMj0nVP
         BG/ObtknkyWGcR4JtzMZ0PoUeb618vgF6eM5dtaGRIXj4n1kOX0dLbywysWUpWPGVC
         jQahGIMumy5MQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5009d4a4897so8338385e87.0;
        Mon, 11 Sep 2023 14:43:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwFjtTFuGZljFfwW9zX04HkAQmCpYWzc7dftneS+AqX2oYCXpA
        M5vu0B991ucZuRsYXn5HR8ExpMcC5DYuOdQLMXI=
X-Google-Smtp-Source: AGHT+IGEdfLVAE+TeZhkDYsO0EcSvVryQ/8lZa/b9BG3glnYOGGlFneB1jIbr0nrIJH0PsUlFYIFKChL2SD0RG1oX8A=
X-Received: by 2002:a05:6512:3711:b0:4ff:8742:4488 with SMTP id
 z17-20020a056512371100b004ff87424488mr7388651lfr.52.1694468637170; Mon, 11
 Sep 2023 14:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230908193656.3464052-1-sashal@kernel.org> <20230908193656.3464052-2-sashal@kernel.org>
 <ZP7ivTQR0bjM6WU/@duo.ucw.cz>
In-Reply-To: <ZP7ivTQR0bjM6WU/@duo.ucw.cz>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Sep 2023 14:43:44 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5vRg1EQgiJeV4p4ALsQNL36vJrSrT6ESCkYUuDJmhodA@mail.gmail.com>
Message-ID: <CAPhsuW5vRg1EQgiJeV4p4ALsQNL36vJrSrT6ESCkYUuDJmhodA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.14 2/3] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Pavel Machek <pavel@denx.de>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Zhang Shurong <zhang_shurong@foxmail.com>,
        Yu Kuai <yukuai3@huawei.com>, linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 2:49=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Zhang Shurong <zhang_shurong@foxmail.com>
> >
> > [ Upstream commit 8b0472b50bcf0f19a5119b00a53b63579c8e1e4d ]
> >
> > If rddev->raid_disk is greater than mddev->raid_disks, there will be
> > an out-of-bounds in raid1_remove_disk(). We have already found
> > similar reports as follows:
> >
> > 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> > 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_dis=
k")
> >
> > Fix this bug by checking whether the "number" variable is
> > valid.
>
> > +++ b/drivers/md/raid1.c
> > @@ -1775,6 +1775,10 @@ static int raid1_remove_disk(struct mddev *mddev=
, struct md_rdev *rdev)
> >       struct r1conf *conf =3D mddev->private;
> >       int err =3D 0;
> >       int number =3D rdev->raid_disk;
> > +
> > +     if (unlikely(number >=3D conf->raid_disks))
> > +             goto abort;
> > +
> >       struct raid1_info *p =3D conf->mirrors + number;
> >
> >       if (rdev !=3D p->rdev)
>
> Wow. Mixing declarations and code. I'm pretty sure that's not ok
> according to our coding style, and I'd be actually surprised if all
> our compiler configurations allowed this.
>

We have a fix queued for this:

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=3Dmd-=
fixes&id=3Ddf203da47f4428bc286fc99318936416253a321c

Thanks,
Song
