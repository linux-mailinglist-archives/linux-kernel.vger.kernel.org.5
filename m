Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7AB7F7A7F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjKXRgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXRgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2B170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:36:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F2FC433C8;
        Fri, 24 Nov 2023 17:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700847409;
        bh=Olz0jPHIcl5EtQacm8JgI+yY2ypimzcwd2gPIun1kJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VwkZ4VqH5T10liHNpHjVoi9JlOybx52kdqVVO4yhpZGutmm/piF9vuNJS5XBtqIdE
         SpDAF61n+kwvtxRmrQupv1NrFzOMnRlgurUgSP7O34cvpDzJAGdvIXQ0KF9ZoIgWLJ
         iHF2XB1FjRjRfKTynWaoPQZTEcivjT8xMSDTfixsotbC9khsh+3d05zrfXAQKEAGwn
         99VdsAFwdQLNlhDNYBP6/6he74hWgpVjdfNjQa0GteqtftoUgy2AwK0/vVi9JzXTjZ
         mfuv+v9XmhXOA3eD4ZCKUUwPwCMdPPDqOSuj1OafPb84CXBYrtEbEXghgf93E+KhTp
         F8RVGg8fnyMlQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2c5071165d5so28356541fa.0;
        Fri, 24 Nov 2023 09:36:48 -0800 (PST)
X-Gm-Message-State: AOJu0YxD2TO9Rf6eG4VJZuDdjoyDgtbW0ZvehKOeaRxVFGzloe1K9Ckd
        QDrILutbwIQGxp8xfkmrUVgoX3nZVbJOBSxqJCY=
X-Google-Smtp-Source: AGHT+IHcsAirvViTKl3O44TbsIBneeUalhap9x+zLwuPia+nDDJSnoYb4cciYXrR0waMFJNpUdnsmB7sgxjhN826v6Q=
X-Received: by 2002:a2e:9d09:0:b0:2bc:c650:81b with SMTP id
 t9-20020a2e9d09000000b002bcc650081bmr2475428lji.15.1700847407182; Fri, 24 Nov
 2023 09:36:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108180210.3657203-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231108180210.3657203-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 24 Nov 2023 09:36:35 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7kkSMNpo9cm3L23o7T676iLa=7gq8V9YkCx0MA6ad+QQ@mail.gmail.com>
Message-ID: <CAPhsuW7kkSMNpo9cm3L23o7T676iLa=7gq8V9YkCx0MA6ad+QQ@mail.gmail.com>
Subject: Re: [PATCH -next] md: synchronize flush io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, maan@systemlinux.org, neilb@suse.de,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Wed, Nov 8, 2023 at 2:07=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently rcu is used to protect iterating rdev from submit_flushes():
>
> submit_flushes                  remove_and_add_spares
>                                  synchronize_rcu
>                                  pers->hot_remove_disk()
>  rcu_read_lock()
>  rdev_for_each_rcu
>   if (rdev->raid_disk >=3D 0)
>                                  rdev->radi_disk =3D -1;
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

LGTM.

> ---
>  drivers/md/md.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4ee4593c874a..eb3e455bcbae 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -529,6 +529,9 @@ static void md_end_flush(struct bio *bio)
>         rdev_dec_pending(rdev, mddev);
>
>         if (atomic_dec_and_test(&mddev->flush_pending)) {
> +               /* The pair is percpu_ref_tryget() from md_flush_request(=
) */
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
> @@ -617,6 +615,17 @@ bool md_flush_request(struct mddev *mddev, struct bi=
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
> +                * 'active_io' is already grabbed, hence percpu_ref_tryge=
t()
> +                * won't fail, percpu_ref_tryget_live() can't be used bec=
ause
> +                * percpu_ref_kill() can be called by mddev_suspend()
> +                * concurrently.
> +                */
> +               percpu_ref_tryget(&mddev->active_io);

Probably add an warn_on here to catch any issues in the future.

Thanks,
Song

>                 mddev->flush_bio =3D bio;
>                 bio =3D NULL;
>         }
> --
> 2.39.2
>
