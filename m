Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D6C8018C1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 01:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjLBALG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442087AbjLBAKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 19:10:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE0211B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 16:09:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08173C433C8;
        Sat,  2 Dec 2023 00:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701475796;
        bh=LvQ+hpkBsu8TeEFks/pEelULPxEdZN5/1mEWxIG41QY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rsgmBaxf3DHbUkV7ZKatrfyqAvyIR8UNw55ENxmdZJ+F6m6JSvOO2mmPKNOBfIQeQ
         Kd0r8k0lBpxmC3jIU2k+MH1kURbiGX1VGwm/cs8XB8suzUzxJEu1/u1/mTthJfr+jG
         Q1pzTtcNAYZJoUpLpuvzDsLauqf0AmcBpqnSw1ODIErol7eQ8nRO5NQgfWxIwQn8C4
         o7sxTMJn25R/caDxthGF8r2AfnqfJytBwhCRBGLHG1uCAWVmdlY1jaqJtUyu/Jn/U5
         ppKV8g99C1MElVge9hH78Fj/53sOnW+YwSkdwo1BF8id17UnbOqSgUvwuw6czKC7u7
         78+joPo376vzw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2c9b7bd6fffso37039671fa.3;
        Fri, 01 Dec 2023 16:09:55 -0800 (PST)
X-Gm-Message-State: AOJu0YwTBKDHg2RQ6gqlzMsQ8JPxoRtOtErIjnQcWt+ZurNO9lkdErPJ
        IoETgiwc5WXldR44uq5KpJ026XOoBlW70DhBSHc=
X-Google-Smtp-Source: AGHT+IG9J89jAlcdA4aNs6b3791DSFKoZ076ordsTFP4k9d4OWL7hdCdU7pVpEqHL+y+MJK4+qzmxwXqBVtOW2KU3Zs=
X-Received: by 2002:a2e:b712:0:b0:2c9:d863:2c35 with SMTP id
 j18-20020a2eb712000000b002c9d8632c35mr1359085ljo.94.1701475794205; Fri, 01
 Dec 2023 16:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20231129020234.1586910-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231129020234.1586910-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Dec 2023 16:09:42 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4P9Zd9nzVW=_4BieEAe4zdQtFEoBc9VLEnWDGTuOo+OA@mail.gmail.com>
Message-ID: <CAPhsuW4P9Zd9nzVW=_4BieEAe4zdQtFEoBc9VLEnWDGTuOo+OA@mail.gmail.com>
Subject: Re: [PATCH v3] md: synchronize flush io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     neilb@suse.de, maan@systemlinux.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Tue, Nov 28, 2023 at 6:03=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently rcu is used to protect iterating rdev from submit_flushes():
>
> submit_flushes                  remove_and_add_spares
>                                 synchronize_rcu
>                                 pers->hot_remove_disk()
>  rcu_read_lock()
>  rdev_for_each_rcu
>   if (rdev->raid_disk >=3D 0)
>                                 rdev->radi_disk =3D -1;
>    atomic_inc(&rdev->nr_pending)
>    rcu_read_unlock()
>    bi =3D bio_alloc_bioset()
>    bi->bi_end_io =3D md_end_flush
>    bi->private =3D rdev
>    submit_bio
>    // issue io for removed rdev
>
> Fix this problem by grabbing 'acive_io' before iterating rdev, make sure
> that remove_and_add_spares() won't concurrent with submit_flushes().
>
> Fixes: a2826aa92e2e ("md: support barrier requests on all personalities."=
)
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next. Thanks!

Song

> ---
> Changes in v3:
>  - use WARN_ON(percpu_ref_is_zero()) and use percpu_ref_get().
> Changes in v2:
>  - Add WARN_ON in case md_flush_request() is not called from
>  md_handle_request() in future.
>  drivers/md/md.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 05902e36db66..75ff96d53266 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -529,6 +529,9 @@ static void md_end_flush(struct bio *bio)
>         rdev_dec_pending(rdev, mddev);
>
>         if (atomic_dec_and_test(&mddev->flush_pending)) {
> +               /* The pair is percpu_ref_get() from md_flush_request() *=
/
> +               percpu_ref_put(&mddev->active_io);
> +
>                 /* The pre-request flush has finished */
>                 queue_work(md_wq, &mddev->flush_work);
>         }
> @@ -548,12 +551,8 @@ static void submit_flushes(struct work_struct *ws)
>         rdev_for_each_rcu(rdev, mddev)
>                 if (rdev->raid_disk >=3D 0 &&
>                     !test_bit(Faulty, &rdev->flags)) {
> -                       /* Take two references, one is dropped
> -                        * when request finishes, one after
> -                        * we reclaim rcu_read_lock
> -                        */
>                         struct bio *bi;
> -                       atomic_inc(&rdev->nr_pending);
> +
>                         atomic_inc(&rdev->nr_pending);
>                         rcu_read_unlock();
>                         bi =3D bio_alloc_bioset(rdev->bdev, 0,
> @@ -564,7 +563,6 @@ static void submit_flushes(struct work_struct *ws)
>                         atomic_inc(&mddev->flush_pending);
>                         submit_bio(bi);
>                         rcu_read_lock();
> -                       rdev_dec_pending(rdev, mddev);
>                 }
>         rcu_read_unlock();
>         if (atomic_dec_and_test(&mddev->flush_pending))
> @@ -617,6 +615,18 @@ bool md_flush_request(struct mddev *mddev, struct bi=
o *bio)
>         /* new request after previous flush is completed */
>         if (ktime_after(req_start, mddev->prev_flush_start)) {
>                 WARN_ON(mddev->flush_bio);
> +               /*
> +                * Grab a reference to make sure mddev_suspend() will wai=
t for
> +                * this flush to be done.
> +                *
> +                * md_flush_reqeust() is called under md_handle_request()=
 and
> +                * 'active_io' is already grabbed, hence percpu_ref_is_ze=
ro()
> +                * won't pass, percpu_ref_tryget_live() can't be used bec=
ause
> +                * percpu_ref_kill() can be called by mddev_suspend()
> +                * concurrently.
> +                */
> +               WARN_ON(percpu_ref_is_zero(&mddev->active_io));
> +               percpu_ref_get(&mddev->active_io);
>                 mddev->flush_bio =3D bio;
>                 bio =3D NULL;
>         }
> --
> 2.39.2
>
>
