Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB4C799123
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjIHUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjIHUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:42:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C6A9C;
        Fri,  8 Sep 2023 13:42:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67468C433C9;
        Fri,  8 Sep 2023 20:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205746;
        bh=ul+CBQpfMlZflOKb70XP4HN0iC7et/ZQ6zPMxvlfJOo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uiShtJXH3VttMe0N1du+nWy/tsFHr7pLHDHailnzHa4OhIYfSV3bWqYoz/knbsfkT
         EBzA3Fnp8si5p3WchfC2teLyZXoOYOSGsLU5Oi5J9nr2S3iQTqbAgBhmtQztVHD4iE
         5LeSTLEw+WwnTdQKHg104KKyN0i5DAwCQi1g3Gk+YapbtjMF/0nMPM1q8K/fz1IR2R
         ywmOt5I02/Z5ISEDDIsj4xT3JGvnSggVvG82Klyos3lvfhZQf1TOK0lqH8noUp699L
         2uiNcnogNK3BqIUZBIjNtVYQPNzu5Zie2BSpm1fdVPIUW0jmOMucdhGLItWEZ0bGTF
         gMejFjhOB6uNw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2bd0d135ca3so43257431fa.3;
        Fri, 08 Sep 2023 13:42:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YzEWvq/HDVS0mjiX/eTIIp8wquhNU51MnknJpS6Pv3C+mL27X5p
        Zng9igvnJnsDIJlARG3CZEcE8s9Fz309a2tetFg=
X-Google-Smtp-Source: AGHT+IHK4R7sPxhWaKKBStUGMciJ+DDN0gdADBvUSA5XMRd90dI3BrXenqc44gyUikLiypaRf+p3ETA/Qo1q30EqBhk=
X-Received: by 2002:a19:9148:0:b0:4f9:cd02:4af1 with SMTP id
 y8-20020a199148000000b004f9cd024af1mr2458118lfj.34.1694205744584; Fri, 08 Sep
 2023 13:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230906093720.1070929-1-linan122@huawei.com> <e67775c0-2d41-5541-a644-e5239ada3333@huaweicloud.com>
In-Reply-To: <e67775c0-2d41-5541-a644-e5239ada3333@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Sep 2023 13:42:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5+Qxa4SKoaFrqZWKDmLaR0arXV7vqDX-Hy_OCEjmtA1w@mail.gmail.com>
Message-ID: <CAPhsuW5+Qxa4SKoaFrqZWKDmLaR0arXV7vqDX-Hy_OCEjmtA1w@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: only update stack limits with the device in use
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
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

On Wed, Sep 6, 2023 at 11:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/09/06 17:37, Li Nan =E5=86=99=E9=81=93:
> > Spare device affects array stack limits is unreasonable. For example,
> > create a raid1 with two 512 byte devices, the logical_block_size of arr=
ay
> > will be 512. But after add a 4k devcie as spare, logical_block_size of
> > array will change as follows.
> >
> >    mdadm -C /dev/md0 -n 2 -l 10 /dev/sd[ab]   //sd[ab] is 512
> >    //logical_block_size of md0: 512
> >
> >    mdadm --add /dev/md0 /dev/sdc                      //sdc is 4k
> >    //logical_block_size of md0: 512
> >
> >    mdadm -S /dev/md0
> >    mdadm -A /dev/md0 /dev/sd[ab]
> >    //logical_block_size of md0: 4k
> >
> > This will confuse users, as nothing has been changed, why did the
> > logical_block_size of array change?
> >
> > Now, only update logical_block_size of array with the device in use.
> >
> > Signed-off-by: Li Nan <linan122@huawei.com>
> > ---
> >   drivers/md/raid1.c | 19 ++++++++-----------
> >   1 file changed, 8 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index 95504612b7e2..d75c5dd89e86 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -3140,19 +3140,16 @@ static int raid1_run(struct mddev *mddev)
>
> I'm not sure about this behaviour, 'logical_block_size' can be
> increased while adding new underlying disk, the key point is not when
> to increase 'logical_block_size'. If there is a mounted fs, or
> partition in the array, I think the array will be corrupted.

How common is such fs/partition corruption? I think some fs and partition
table can work properly with 512=3D>4096 change?

Thanks,
Song

>
> Perhaps once that array is started, logical_block_size should not be
> changed anymore, this will require 'logical_block_size' to be metadate
> inside raid superblock. And the array should deny any new disk with
> bigger logical_block_size.
>
> Thanks,
> Kuai
>
>
> >       if (mddev->queue)
> >               blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
> >
> > -     rdev_for_each(rdev, mddev) {
> > -             if (!mddev->gendisk)
> > -                     continue;
> > -             disk_stack_limits(mddev->gendisk, rdev->bdev,
> > -                               rdev->data_offset << 9);
> > -     }
> > -
> >       mddev->degraded =3D 0;
> > -     for (i =3D 0; i < conf->raid_disks; i++)
> > -             if (conf->mirrors[i].rdev =3D=3D NULL ||
> > -                 !test_bit(In_sync, &conf->mirrors[i].rdev->flags) ||
> > -                 test_bit(Faulty, &conf->mirrors[i].rdev->flags))
> > +     for (i =3D 0; i < conf->raid_disks; i++) {
> > +             rdev =3D conf->mirrors[i].rdev;
> > +             if (rdev && mddev->gendisk)
> > +                     disk_stack_limits(mddev->gendisk, rdev->bdev,
> > +                                       rdev->data_offset << 9);
> > +             if (!rdev || !test_bit(In_sync, &rdev->flags) ||
> > +                 test_bit(Faulty, &rdev->flags))
> >                       mddev->degraded++;
> > +     }
> >       /*
> >        * RAID1 needs at least one disk in active
> >        */
> >
>
