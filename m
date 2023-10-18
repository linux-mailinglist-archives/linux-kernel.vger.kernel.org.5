Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D1E7CE58E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjJRR5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjJRR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:56:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2DC11B;
        Wed, 18 Oct 2023 10:56:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4E2C433CA;
        Wed, 18 Oct 2023 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697651812;
        bh=On89OY8ilM1LOGMg2pTUJunXnv8xHwn8qw/DQ7bs6kI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IZaG5ojOoF1SFDrMX4wXoW213U2hbkkePOMqa+v6Hqg6u9d+cOb/XCsLeMLewk549
         lMaLiGmMBqQhCWexU91Meo++4VNrv29EJ8rCqFA9YKf2bKSuUfYf+Qgjxara7vQRmo
         XRjqCZ6xkSoDT+qW1QjGIz7Im9NaS/FdbUZsMWaBERaQZ/DKOTwgL7aFUdUBR7Dits
         xAf8zpqr5jBuNOOraDGtlJrrb8uy/6uY7PPLXUlzu0oEvbNYu5RCkoL+t/8+yCWvsQ
         7+rT5xzxZg6veUS/scNSzyCpU4HRT9qtFVdpoL2R7hXDnafaxwUM1pglpCi1ZYFcVh
         Ga3hhHMQWY5gg==
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ca816f868fso25722835ad.1;
        Wed, 18 Oct 2023 10:56:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YwgxIY6sU0+RVEn3ws11DHaKLN3jBepRKNMXvFal2EqTfOjQpmn
        h4UNzuHx4zQgKZeTJcwGO7uQ42kiiDceNgsjOrc=
X-Google-Smtp-Source: AGHT+IEI6B6F4AMAvI/3ntHQNxZ+S2nD/RsiZ0Nbs3qlMEghlK3lsQ1y7m5iG1/xEW3sG3xXuuV3laL6qWf/lG2bqaM=
X-Received: by 2002:a17:902:ab4e:b0:1ca:15ad:1c6 with SMTP id
 ij14-20020a170902ab4e00b001ca15ad01c6mr106464plb.33.1697651812363; Wed, 18
 Oct 2023 10:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231016092439.493646-1-yukuai1@huaweicloud.com> <20231016092439.493646-4-yukuai1@huaweicloud.com>
In-Reply-To: <20231016092439.493646-4-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Oct 2023 10:56:37 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-a6XjM=yox9oa7bUnqOEdB+=T+zvot1ueUx5=nqOrRQ@mail.gmail.com>
Message-ID: <CAPhsuW5-a6XjM=yox9oa7bUnqOEdB+=T+zvot1ueUx5=nqOrRQ@mail.gmail.com>
Subject: Re: [PATCH -next 3/6] md/raid1: remove rcu protection to access rdev
 from conf
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Sun, Oct 15, 2023 at 6:28=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> It's safe to accees rdev from conf:
>  - If any spinlock is held, because synchronize_rcu() from
>    md_kick_rdev_from_array() will prevent 'rdev' to be freed until
>    spinlock is released;
>  - If 'reconfig_lock' is held, because rdev can't be added or removed fro=
m
>    array;

Maybe add lockdep asserts for the above cases?

Thanks,
Song

>  - If there is normal IO inflight, because mddev_suspend() will prevent
>    rdev to be added or removed from array;
>  - If there is sync IO inflight, because 'MD_RECOVERY_RUNNING' is
>    checked in remove_and_add_spares().
>
> And these will cover all the scenarios in raid1.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/raid1.c | 57 +++++++++++++++++-----------------------------
>  1 file changed, 21 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 4348d670439d..5c647036663d 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -609,7 +609,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         int choose_first;
>         int choose_next_idle;
>
> -       rcu_read_lock();
>         /*
>          * Check if we can balance. We can balance on the whole
>          * device if no resync is going on, or below the resync window.
> @@ -642,7 +641,7 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>                 unsigned int pending;
>                 bool nonrot;
>
> -               rdev =3D rcu_dereference(conf->mirrors[disk].rdev);
> +               rdev =3D conf->mirrors[disk].rdev;
>                 if (r1_bio->bios[disk] =3D=3D IO_BLOCKED
>                     || rdev =3D=3D NULL
>                     || test_bit(Faulty, &rdev->flags))
> @@ -773,7 +772,7 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>         }
>
>         if (best_disk >=3D 0) {
> -               rdev =3D rcu_dereference(conf->mirrors[best_disk].rdev);
> +               rdev =3D conf->mirrors[best_disk].rdev;
>                 if (!rdev)
>                         goto retry;
>                 atomic_inc(&rdev->nr_pending);
> @@ -784,7 +783,6 @@ static int read_balance(struct r1conf *conf, struct r=
1bio *r1_bio, int *max_sect
>
>                 conf->mirrors[best_disk].next_seq_sect =3D this_sector + =
sectors;
>         }
> -       rcu_read_unlock();
>         *max_sectors =3D sectors;
>
>         return best_disk;
> @@ -1235,14 +1233,12 @@ static void raid1_read_request(struct mddev *mdde=
v, struct bio *bio,
>
>         if (r1bio_existed) {
>                 /* Need to get the block device name carefully */
> -               struct md_rdev *rdev;
> -               rcu_read_lock();
> -               rdev =3D rcu_dereference(conf->mirrors[r1_bio->read_disk]=
.rdev);
> +               struct md_rdev *rdev =3D conf->mirrors[r1_bio->read_disk]=
.rdev;
> +
>                 if (rdev)
>                         snprintf(b, sizeof(b), "%pg", rdev->bdev);
>                 else
>                         strcpy(b, "???");
> -               rcu_read_unlock();
>         }
>
>         /*
> @@ -1396,10 +1392,9 @@ static void raid1_write_request(struct mddev *mdde=
v, struct bio *bio,
>
>         disks =3D conf->raid_disks * 2;
>         blocked_rdev =3D NULL;
> -       rcu_read_lock();
>         max_sectors =3D r1_bio->sectors;
>         for (i =3D 0;  i < disks; i++) {
> -               struct md_rdev *rdev =3D rcu_dereference(conf->mirrors[i]=
.rdev);
> +               struct md_rdev *rdev =3D conf->mirrors[i].rdev;
>
>                 /*
>                  * The write-behind io is only attempted on drives marked=
 as
> @@ -1465,7 +1460,6 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>                 }
>                 r1_bio->bios[i] =3D bio;
>         }
> -       rcu_read_unlock();
>
>         if (unlikely(blocked_rdev)) {
>                 /* Wait for this device to become unblocked */
> @@ -1617,15 +1611,16 @@ static void raid1_status(struct seq_file *seq, st=
ruct mddev *mddev)
>         struct r1conf *conf =3D mddev->private;
>         int i;
>
> +       lockdep_assert_held(&mddev->lock);
> +
>         seq_printf(seq, " [%d/%d] [", conf->raid_disks,
>                    conf->raid_disks - mddev->degraded);
> -       rcu_read_lock();
>         for (i =3D 0; i < conf->raid_disks; i++) {
> -               struct md_rdev *rdev =3D rcu_dereference(conf->mirrors[i]=
.rdev);
> +               struct md_rdev *rdev =3D READ_ONCE(conf->mirrors[i].rdev)=
;
> +
>                 seq_printf(seq, "%s",
>                            rdev && test_bit(In_sync, &rdev->flags) ? "U" =
: "_");
>         }
> -       rcu_read_unlock();
>         seq_printf(seq, "]");
>  }
>
> @@ -1785,7 +1780,7 @@ static int raid1_add_disk(struct mddev *mddev, stru=
ct md_rdev *rdev)
>                          */
>                         if (rdev->saved_raid_disk < 0)
>                                 conf->fullsync =3D 1;
> -                       rcu_assign_pointer(p->rdev, rdev);
> +                       WRITE_ONCE(p->rdev, rdev);
>                         break;
>                 }
>                 if (test_bit(WantReplacement, &p->rdev->flags) &&
> @@ -1801,7 +1796,7 @@ static int raid1_add_disk(struct mddev *mddev, stru=
ct md_rdev *rdev)
>                 rdev->raid_disk =3D repl_slot;
>                 err =3D 0;
>                 conf->fullsync =3D 1;
> -               rcu_assign_pointer(p[conf->raid_disks].rdev, rdev);
> +               WRITE_ONCE(p[conf->raid_disks].rdev, rdev);
>         }
>
>         return err;
> @@ -1835,7 +1830,7 @@ static int raid1_remove_disk(struct mddev *mddev, s=
truct md_rdev *rdev)
>                         err =3D -EBUSY;
>                         goto abort;
>                 }
> -               p->rdev =3D NULL;
> +               WRITE_ONCE(p->rdev, NULL);
>                 if (conf->mirrors[conf->raid_disks + number].rdev) {
>                         /* We just removed a device that is being replace=
d.
>                          * Move down the replacement.  We drain all IO be=
fore
> @@ -1856,7 +1851,7 @@ static int raid1_remove_disk(struct mddev *mddev, s=
truct md_rdev *rdev)
>                                 goto abort;
>                         }
>                         clear_bit(Replacement, &repl->flags);
> -                       p->rdev =3D repl;
> +                       WRITE_ONCE(p->rdev, repl);
>                         conf->mirrors[conf->raid_disks + number].rdev =3D=
 NULL;
>                         unfreeze_array(conf);
>                 }
> @@ -2253,8 +2248,7 @@ static void fix_read_error(struct r1conf *conf, int=
 read_disk,
>                         sector_t first_bad;
>                         int bad_sectors;
>
> -                       rcu_read_lock();
> -                       rdev =3D rcu_dereference(conf->mirrors[d].rdev);
> +                       rdev =3D conf->mirrors[d].rdev;
>                         if (rdev &&
>                             (test_bit(In_sync, &rdev->flags) ||
>                              (!test_bit(Faulty, &rdev->flags) &&
> @@ -2262,15 +2256,14 @@ static void fix_read_error(struct r1conf *conf, i=
nt read_disk,
>                             is_badblock(rdev, sect, s,
>                                         &first_bad, &bad_sectors) =3D=3D =
0) {
>                                 atomic_inc(&rdev->nr_pending);
> -                               rcu_read_unlock();
>                                 if (sync_page_io(rdev, sect, s<<9,
>                                          conf->tmppage, REQ_OP_READ, fals=
e))
>                                         success =3D 1;
>                                 rdev_dec_pending(rdev, mddev);
>                                 if (success)
>                                         break;
> -                       } else
> -                               rcu_read_unlock();
> +                       }
> +
>                         d++;
>                         if (d =3D=3D conf->raid_disks * 2)
>                                 d =3D 0;
> @@ -2289,29 +2282,24 @@ static void fix_read_error(struct r1conf *conf, i=
nt read_disk,
>                         if (d=3D=3D0)
>                                 d =3D conf->raid_disks * 2;
>                         d--;
> -                       rcu_read_lock();
> -                       rdev =3D rcu_dereference(conf->mirrors[d].rdev);
> +                       rdev =3D conf->mirrors[d].rdev;
>                         if (rdev &&
>                             !test_bit(Faulty, &rdev->flags)) {
>                                 atomic_inc(&rdev->nr_pending);
> -                               rcu_read_unlock();
>                                 r1_sync_page_io(rdev, sect, s,
>                                                 conf->tmppage, WRITE);
>                                 rdev_dec_pending(rdev, mddev);
> -                       } else
> -                               rcu_read_unlock();
> +                       }
>                 }
>                 d =3D start;
>                 while (d !=3D read_disk) {
>                         if (d=3D=3D0)
>                                 d =3D conf->raid_disks * 2;
>                         d--;
> -                       rcu_read_lock();
> -                       rdev =3D rcu_dereference(conf->mirrors[d].rdev);
> +                       rdev =3D conf->mirrors[d].rdev;
>                         if (rdev &&
>                             !test_bit(Faulty, &rdev->flags)) {
>                                 atomic_inc(&rdev->nr_pending);
> -                               rcu_read_unlock();
>                                 if (r1_sync_page_io(rdev, sect, s,
>                                                     conf->tmppage, READ))=
 {
>                                         atomic_add(s, &rdev->corrected_er=
rors);
> @@ -2322,8 +2310,7 @@ static void fix_read_error(struct r1conf *conf, int=
 read_disk,
>                                                 rdev->bdev);
>                                 }
>                                 rdev_dec_pending(rdev, mddev);
> -                       } else
> -                               rcu_read_unlock();
> +                       }
>                 }
>                 sectors -=3D s;
>                 sect +=3D s;
> @@ -2704,7 +2691,6 @@ static sector_t raid1_sync_request(struct mddev *md=
dev, sector_t sector_nr,
>
>         r1_bio =3D raid1_alloc_init_r1buf(conf);
>
> -       rcu_read_lock();
>         /*
>          * If we get a correctably read error during resync or recovery,
>          * we might want to read from a different device.  So we
> @@ -2725,7 +2711,7 @@ static sector_t raid1_sync_request(struct mddev *md=
dev, sector_t sector_nr,
>                 struct md_rdev *rdev;
>                 bio =3D r1_bio->bios[i];
>
> -               rdev =3D rcu_dereference(conf->mirrors[i].rdev);
> +               rdev =3D conf->mirrors[i].rdev;
>                 if (rdev =3D=3D NULL ||
>                     test_bit(Faulty, &rdev->flags)) {
>                         if (i < conf->raid_disks)
> @@ -2783,7 +2769,6 @@ static sector_t raid1_sync_request(struct mddev *md=
dev, sector_t sector_nr,
>                                 bio->bi_opf |=3D MD_FAILFAST;
>                 }
>         }
> -       rcu_read_unlock();
>         if (disk < 0)
>                 disk =3D wonly;
>         r1_bio->read_disk =3D disk;
> --
> 2.39.2
>
