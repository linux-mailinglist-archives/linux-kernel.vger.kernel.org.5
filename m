Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828287AD18E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjIYHXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjIYHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:22:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1FCC1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695626519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzztqiTccNd/WUIopmBC+PbliphbDEU0hH26bTuwFVE=;
        b=JstlfAO3GcJ1DmIg11x9J54fmqC3CtU4Y04dyjk9KGbytqL8UjaSKJR1Ay8a+fcSwFZJSU
        DS0i3880IwB7ZQjJuecXObygUvXmerRHuO/i5seq+Wt6jWFmJpFlQIM2yjJfNEhPSsay4P
        jdERT4Y+VLoYpjFsH+OiIHiDUICxMjM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-PCdRBHgWNq6mmCV6ZPuwTA-1; Mon, 25 Sep 2023 03:21:58 -0400
X-MC-Unique: PCdRBHgWNq6mmCV6ZPuwTA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-692b5134675so4358229b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695626517; x=1696231317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzztqiTccNd/WUIopmBC+PbliphbDEU0hH26bTuwFVE=;
        b=rxtJ4NRRsK5t0DCL0TG6p1GlzqwmbY03+9jFZjjzR0hqz67P/h1rg/xzFW2QKtC6Zy
         Bqk8JK7pCWXHWyAiT02SOe0bayMLoUAXtzhhN00Za0JJd2o6uCz22t83CSb68CudhXae
         yTVyUtdQ9yBiguZiaXRtQ2KfcfY6EVLCmCNtfgTGwORgUgMBjBZHlx88IBFm/TuW8kMF
         8h4iynUKWS9yW5c761Lhv+itq35o867/QC4hLQYQFx9GTFI2lKjHnzmfsQAhGN15PYD+
         H20Uv6IZhPfonYSIKXqiGYxDtyU42wmKpmV4NCYwz/T2h5SWCFX2B61TQatCBuvetCFk
         TCIw==
X-Gm-Message-State: AOJu0Yya+WynKWam8KGS7J7vPk4EHvc2ipQwu59GHILmejVjAMgvt6q3
        sXxiA/OSVyOYnmrPgXXjV6TefQkjrpiyXIclWt1XXdxadgjZOTbPXxTXh7TtowwwqwAMn7Iru7Z
        jifNW6mCQyo4oW3p2wbtrsOixx4f5PGFQqAddc939
X-Received: by 2002:a05:6a20:f392:b0:14d:396e:6e1c with SMTP id qr18-20020a056a20f39200b0014d396e6e1cmr3937739pzb.28.1695626517216;
        Mon, 25 Sep 2023 00:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJGOJfpxHnsNy6HUSrcPHkZKwrs+s1jrli3TQ1B3bFrk79pIC+NE3vVlCSfd8E9+GPVWsiNkvel8RS82ZzTfM=
X-Received: by 2002:a05:6a20:f392:b0:14d:396e:6e1c with SMTP id
 qr18-20020a056a20f39200b0014d396e6e1cmr3937728pzb.28.1695626516919; Mon, 25
 Sep 2023 00:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com> <20230828020021.2489641-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230828020021.2489641-4-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Mon, 25 Sep 2023 15:21:45 +0800
Message-ID: <CALTww2-5F=C5N6YZ-3weD9xSWhpT6Mx8NkaevfXZWqR6=Bwc4A@mail.gmail.com>
Subject: Re: [PATCH -next v2 03/28] md: add new helpers to suspend/resume array
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Advantages for new apis:
>  - reconfig_mutex is not required;
>  - the weird logical that suspend array hold 'reconfig_mutex' for
>    mddev_check_recovery() to update superblock is not needed;
>  - the specail handling, 'pers->prepare_suspend', for raid456 is not
>    needed;
>  - It's safe to be called at any time once mddev is allocated, and it's
>    designed to be used from slow path where array configuration is change=
d;
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/md/md.h |  3 ++
>  2 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7fa311a14317..6236e2e395c1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -443,12 +443,22 @@ void mddev_suspend(struct mddev *mddev)
>                         lockdep_is_held(&mddev->reconfig_mutex));
>
>         WARN_ON_ONCE(thread && current =3D=3D thread->tsk);
> -       if (mddev->suspended++)
> +
> +       /* can't concurrent with __mddev_suspend() and __mddev_resume() *=
/
> +       mutex_lock(&mddev->suspend_mutex);
> +       if (mddev->suspended++) {
> +               mutex_unlock(&mddev->suspend_mutex);
>                 return;
> +       }
> +
>         wake_up(&mddev->sb_wait);
>         set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
>         percpu_ref_kill(&mddev->active_io);
>
> +       /*
> +        * TODO: cleanup 'pers->prepare_suspend after all callers are rep=
laced
> +        * by __mddev_suspend().
> +        */
>         if (mddev->pers && mddev->pers->prepare_suspend)
>                 mddev->pers->prepare_suspend(mddev);
>
> @@ -459,14 +469,21 @@ void mddev_suspend(struct mddev *mddev)
>         del_timer_sync(&mddev->safemode_timer);
>         /* restrict memory reclaim I/O during raid array is suspend */
>         mddev->noio_flag =3D memalloc_noio_save();
> +
> +       mutex_unlock(&mddev->suspend_mutex);
>  }
>  EXPORT_SYMBOL_GPL(mddev_suspend);
>
>  void mddev_resume(struct mddev *mddev)
>  {
>         lockdep_assert_held(&mddev->reconfig_mutex);
> -       if (--mddev->suspended)
> +
> +       /* can't concurrent with __mddev_suspend() and __mddev_resume() *=
/
> +       mutex_lock(&mddev->suspend_mutex);
> +       if (--mddev->suspended) {
> +               mutex_unlock(&mddev->suspend_mutex);
>                 return;
> +       }
>
>         /* entred the memalloc scope from mddev_suspend() */
>         memalloc_noio_restore(mddev->noio_flag);
> @@ -477,9 +494,72 @@ void mddev_resume(struct mddev *mddev)
>         set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>         md_wakeup_thread(mddev->thread);
>         md_wakeup_thread(mddev->sync_thread); /* possibly kick off a resh=
ape */
> +
> +       mutex_unlock(&mddev->suspend_mutex);
>  }
>  EXPORT_SYMBOL_GPL(mddev_resume);
>
> +void __mddev_suspend(struct mddev *mddev)
> +{
> +
> +       /*
> +        * hold reconfig_mutex to wait for normal io will deadlock, becau=
se
> +        * other context can't update super_block, and normal io can rely=
 on
> +        * updating super_block.
> +        */
> +       lockdep_assert_not_held(&mddev->reconfig_mutex);
> +
> +       mutex_lock(&mddev->suspend_mutex);
> +
> +       if (mddev->suspended) {
> +               WRITE_ONCE(mddev->suspended, mddev->suspended + 1);
> +               mutex_unlock(&mddev->suspend_mutex);
> +               return;
> +       }
> +
> +       percpu_ref_kill(&mddev->active_io);
> +       wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io))=
;
> +
> +       /*
> +        * For raid456, io might be waiting for reshape to make progress,
> +        * allow new reshape to start while waiting for io to be done to
> +        * prevent deadlock.
> +        */
> +       WRITE_ONCE(mddev->suspended, mddev->suspended + 1);

It changes the order of setting suspended and checking active_io.
suspended is used to stop I/O. Now it checks active_io first and then
adds suspended, if the i/o doesn't stop, it looks like active_io can't
be 0. So it will stuck at waiting active_io to be 0?

Best Regards
Xiao

> +
> +       del_timer_sync(&mddev->safemode_timer);
> +       /* restrict memory reclaim I/O during raid array is suspend */
> +       mddev->noio_flag =3D memalloc_noio_save();
> +
> +       mutex_unlock(&mddev->suspend_mutex);
> +}
> +EXPORT_SYMBOL_GPL(__mddev_suspend);
> +
> +void __mddev_resume(struct mddev *mddev)
> +{
> +       lockdep_assert_not_held(&mddev->reconfig_mutex);
> +
> +       mutex_lock(&mddev->suspend_mutex);
> +       WRITE_ONCE(mddev->suspended, mddev->suspended - 1);
> +       if (mddev->suspended) {
> +               mutex_unlock(&mddev->suspend_mutex);
> +               return;
> +       }
> +
> +       /* entred the memalloc scope from __mddev_suspend() */
> +       memalloc_noio_restore(mddev->noio_flag);
> +
> +       percpu_ref_resurrect(&mddev->active_io);
> +       wake_up(&mddev->sb_wait);
> +
> +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> +       md_wakeup_thread(mddev->thread);
> +       md_wakeup_thread(mddev->sync_thread); /* possibly kick off a resh=
ape */
> +
> +       mutex_unlock(&mddev->suspend_mutex);
> +}
> +EXPORT_SYMBOL_GPL(__mddev_resume);
> +
>  /*
>   * Generic flush handling for md
>   */
> @@ -667,6 +747,7 @@ int mddev_init(struct mddev *mddev)
>         mutex_init(&mddev->open_mutex);
>         mutex_init(&mddev->reconfig_mutex);
>         mutex_init(&mddev->sync_mutex);
> +       mutex_init(&mddev->suspend_mutex);
>         mutex_init(&mddev->bitmap_info.mutex);
>         INIT_LIST_HEAD(&mddev->disks);
>         INIT_LIST_HEAD(&mddev->all_mddevs);
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index fb3b123f16dd..1103e6b08ad9 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -316,6 +316,7 @@ struct mddev {
>         unsigned long                   sb_flags;
>
>         int                             suspended;
> +       struct mutex                    suspend_mutex;
>         struct percpu_ref               active_io;
>         int                             ro;
>         int                             sysfs_active; /* set when sysfs d=
eletes
> @@ -811,6 +812,8 @@ extern void md_rdev_clear(struct md_rdev *rdev);
>  extern void md_handle_request(struct mddev *mddev, struct bio *bio);
>  extern void mddev_suspend(struct mddev *mddev);
>  extern void mddev_resume(struct mddev *mddev);
> +extern void __mddev_suspend(struct mddev *mddev);
> +extern void __mddev_resume(struct mddev *mddev);
>
>  extern void md_reload_sb(struct mddev *mddev, int raid_disk);
>  extern void md_update_sb(struct mddev *mddev, int force);
> --
> 2.39.2
>

