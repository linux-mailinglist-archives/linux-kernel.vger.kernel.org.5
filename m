Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081837FB0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjK1DoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1DoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:44:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF1131
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:44:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78668C433C7;
        Tue, 28 Nov 2023 03:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701143070;
        bh=jZVtKdg3uUmw3uHl6QOUyGKbzs5bk3U+PgKpgr5tU94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k1YFpsKDNqu++QXD5tJFWUI5ZAlwUJScVY0zR44JmTdzIVJjo9MK7jchMTcGRbq5X
         Nr4kfLvR9eSWSoO1uoyWknhW0fzVXXh3XrGv8r8dXsaUnJjrYXOZR4m2A6PU3O4Iui
         0tuLcygJpFoDnlVAiJm532qesv+hV9onn71Wnubhf1yRJ5CAL/1HbHV9qHi6Dvas5h
         Vk9RwDC1+bWSgdZPCbUwQ4T9ubQabJ1A+C5lhhiskaUOD2UWTSMJ01Xxw5fB8UUt88
         MoSC6czFPXR5W9EdG8tJWqdRbHXytQG+d2i0weXDTJ2fvkf6slZX+kNCp4rkNOEqio
         NeG8mEJ9Ea6YA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c8872277fcso50467001fa.1;
        Mon, 27 Nov 2023 19:44:30 -0800 (PST)
X-Gm-Message-State: AOJu0YxrCNDtPPBnlO9RYSiktdXHM/rIIClDThZBVtEB+eWuM5Hz18nP
        wR6fRqL20hb6vWe777rn7BdP+UAH3jNmtlyNuKE=
X-Google-Smtp-Source: AGHT+IH2z47wozKU81jgZhzavWFn37VHv3IbNpyIomXMIeJKjCG+ZurozSNlSL5O32XroF7ofHJAixpVXzt5Ygqi6O0=
X-Received: by 2002:a2e:910d:0:b0:2c9:a38b:57d8 with SMTP id
 m13-20020a2e910d000000b002c9a38b57d8mr1834190ljg.16.1701143068686; Mon, 27
 Nov 2023 19:44:28 -0800 (PST)
MIME-Version: 1.0
References: <20231125065419.3518254-1-yukuai1@huaweicloud.com>
 <CAPhsuW4YsDXdpHMuscQrW4NdXZxhg8-k4J0Xt_47twA8sG_Fmg@mail.gmail.com>
 <CAPhsuW57SuytxCY-fV74qx6B8AYb65nFC_t2VVeTN34Pamp=gQ@mail.gmail.com> <ac4470c6-f9a4-ba63-63d7-69b56ef92cc7@huaweicloud.com>
In-Reply-To: <ac4470c6-f9a4-ba63-63d7-69b56ef92cc7@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Nov 2023 19:44:16 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7iy9rD3_z+ug1qaHrBEkSj-g1d8wC0YPX+s-93FuU-Gw@mail.gmail.com>
Message-ID: <CAPhsuW7iy9rD3_z+ug1qaHrBEkSj-g1d8wC0YPX+s-93FuU-Gw@mail.gmail.com>
Subject: Re: [PATCH -next v2] md: synchronize flush io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     maan@systemlinux.org, neilb@suse.de, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Mon, Nov 27, 2023 at 6:12=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/11/28 7:32, Song Liu =E5=86=99=E9=81=93:
> > On Mon, Nov 27, 2023 at 2:16=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> >>
> >> On Fri, Nov 24, 2023 at 10:54=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.=
com> wrote:
> >>>
> >>> From: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> Currently rcu is used to protect iterating rdev from submit_flushes()=
:
> >>>
> >>> submit_flushes                  remove_and_add_spares
> >>>                                  synchronize_rcu
> >>>                                  pers->hot_remove_disk()
> >>>   rcu_read_lock()
> >>>   rdev_for_each_rcu
> >>>    if (rdev->raid_disk >=3D 0)
> >>>                                  rdev->radi_disk =3D -1;
> >>>     atomic_inc(&rdev->nr_pending)
> >>>     rcu_read_unlock()
> >>>     bi =3D bio_alloc_bioset()
> >>>     bi->bi_end_io =3D md_end_flush
> >>>     bi->private =3D rdev
> >>>     submit_bio
> >>>     // issue io for removed rdev
> >>>
> >>> Fix this problem by grabbing 'acive_io' before iterating rdev, make s=
ure
> >>> that remove_and_add_spares() won't concurrent with submit_flushes().
> >>>
> >>> Fixes: a2826aa92e2e ("md: support barrier requests on all personaliti=
es.")
> >>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>> ---
> >>> Changes v2:
> >>>   - Add WARN_ON in case md_flush_request() is not called from
> >>>   md_handle_request() in future.
> >>>
> >>>   drivers/md/md.c | 22 ++++++++++++++++------
> >>>   1 file changed, 16 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >>> index 86efc9c2ae56..2ffedc39edd6 100644
> >>> --- a/drivers/md/md.c
> >>> +++ b/drivers/md/md.c
> >>> @@ -538,6 +538,9 @@ static void md_end_flush(struct bio *bio)
> >>>          rdev_dec_pending(rdev, mddev);
> >>>
> >>>          if (atomic_dec_and_test(&mddev->flush_pending)) {
> >>> +               /* The pair is percpu_ref_tryget() from md_flush_requ=
est() */
> >>> +               percpu_ref_put(&mddev->active_io);
> >>> +
> >>>                  /* The pre-request flush has finished */
> >>>                  queue_work(md_wq, &mddev->flush_work);
> >>>          }
> >>> @@ -557,12 +560,8 @@ static void submit_flushes(struct work_struct *w=
s)
> >>>          rdev_for_each_rcu(rdev, mddev)
> >>>                  if (rdev->raid_disk >=3D 0 &&
> >>>                      !test_bit(Faulty, &rdev->flags)) {
> >>> -                       /* Take two references, one is dropped
> >>> -                        * when request finishes, one after
> >>> -                        * we reclaim rcu_read_lock
> >>> -                        */
> >>>                          struct bio *bi;
> >>> -                       atomic_inc(&rdev->nr_pending);
> >>> +
> >>>                          atomic_inc(&rdev->nr_pending);
> >>>                          rcu_read_unlock();
> >>>                          bi =3D bio_alloc_bioset(rdev->bdev, 0,
> >>> @@ -573,7 +572,6 @@ static void submit_flushes(struct work_struct *ws=
)
> >>>                          atomic_inc(&mddev->flush_pending);
> >>>                          submit_bio(bi);
> >>>                          rcu_read_lock();
> >>> -                       rdev_dec_pending(rdev, mddev);
> >>>                  }
> >>>          rcu_read_unlock();
> >>>          if (atomic_dec_and_test(&mddev->flush_pending))
> >>> @@ -626,6 +624,18 @@ bool md_flush_request(struct mddev *mddev, struc=
t bio *bio)
> >>>          /* new request after previous flush is completed */
> >>>          if (ktime_after(req_start, mddev->prev_flush_start)) {
> >>>                  WARN_ON(mddev->flush_bio);
> >>> +               /*
> >>> +                * Grab a reference to make sure mddev_suspend() will=
 wait for
> >>> +                * this flush to be done.
> >>> +                *
> >>> +                * md_flush_reqeust() is called under md_handle_reque=
st() and
> >>> +                * 'active_io' is already grabbed, hence percpu_ref_t=
ryget()
> >>> +                * won't fail, percpu_ref_tryget_live() can't be used=
 because
> >>> +                * percpu_ref_kill() can be called by mddev_suspend()
> >>> +                * concurrently.
> >>> +                */
> >>> +               if (WARN_ON(percpu_ref_tryget(&mddev->active_io)))
> >>
> >> This should be "if (!WARN_ON(..))", right?
>
> Sorry for the mistake, this actually should be:
>
> if (WARN_ON(!percpu_ref_tryget(...))
> >>
> >> Song
> >>
> >>> +                       percpu_ref_get(&mddev->active_io);
> >
> > Actually, we can just use percpu_ref_get(), no?
>
> Yes, we can, but if someone else doesn't call md_flush_request() under
> md_handle_request() in the fulture, there will be problem and
> percpu_ref_get() can't catch this, do you think it'll make sense to
> prevent such case?

This combination is really weird

+               if (WARN_ON(percpu_ref_tryget(&mddev->active_io)))
+                       percpu_ref_get(&mddev->active_io);

We can use percpu_ref_get() here, and add
WARN_ON(percpu_ref_is_zero()) earlier in the function. Does this
make sense?

Thanks,
Song
