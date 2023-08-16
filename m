Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212DB77DA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbjHPGkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242105AbjHPGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:39:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D6B1FC1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692167928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmJHjQ292lqN87qzle3ANyA09jD7wHhM+sI6dQ6S1ZE=;
        b=fqsVw8bOCAaV8Z7gNP/2ZY+curJE0hh2p2/HfGJxF/Uu1wRqle+UoHwRwlKwKnGXKmVsg2
        /18/9+nde1BNYrXClotG1/eRVSUY3gXmq0z68vO9QsVT155mWEESS3adLjQN3yLr+bzq29
        CkCy3WRKMCd4tipYD7PiZ8KLyFKXGWo=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-FGXDz8XdPXe9j0OjIkyTKQ-1; Wed, 16 Aug 2023 02:38:46 -0400
X-MC-Unique: FGXDz8XdPXe9j0OjIkyTKQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-68874dd23feso1449237b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692167926; x=1692772726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmJHjQ292lqN87qzle3ANyA09jD7wHhM+sI6dQ6S1ZE=;
        b=WaIPzOOPyiFrqTxH3j/YQisXzGIsdueOPzo8O/PwV+ZVJXi1Us/Sphi9gP5CHyY0eo
         p5p5YnMrl1r9jJ1FsCim42IxPNIg+UwVNftKnirZ1CnNnuFYguQVn75q6QQVMO1FYjuu
         oEMsVqoY9qaBRSUTulXsJ4nqj+sQHUBCcXkth0bN7KLBbOSkIimRlB5X/fYR6T9vwlAd
         9VsZFajK3hgQOG3F0St5OjB0dbQk3YA8DTvVGmvZEeOJoEK1aKfv0rVEN0gF6r876UlB
         zXbiCM2LtAd9BrNKqpQwZjGSWkqi34TpvB6VLo4jMzVm63xNSrTQ/xQ4wtOnPxASZ9oX
         gx1A==
X-Gm-Message-State: AOJu0YyIDDB+j2CQVhGJEDMgw15BAEN7SbkCjiIZy4cGLm2qpy42WUjY
        wEAPdQSxegPH0Gb3bP6CBm8dUd5PLVrgjlC59Nfbvsn73CvgtsDmIMZyGAtpCq8se/kL4aK6eg0
        t7DGl6wlBrU53X0tqpfKkyVV/YGistC523YIkiwHb
X-Received: by 2002:a05:6a00:194b:b0:688:4c21:a6f0 with SMTP id s11-20020a056a00194b00b006884c21a6f0mr1079192pfk.18.1692167925738;
        Tue, 15 Aug 2023 23:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWfcq431Do8loQK17HGXw7niLwHH+ell6c5jaAO7JHWDgH8Cd1TSfBBc4udvpHVXz5GOIPzZUri9WA2GizgcY=
X-Received: by 2002:a05:6a00:194b:b0:688:4c21:a6f0 with SMTP id
 s11-20020a056a00194b00b006884c21a6f0mr1079182pfk.18.1692167925441; Tue, 15
 Aug 2023 23:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230815030957.509535-1-yukuai1@huaweicloud.com> <20230815030957.509535-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230815030957.509535-4-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 16 Aug 2023 14:38:33 +0800
Message-ID: <CALTww2-LzW76_=vH+TKjZGzChrsz_JJKJxh1-+SCNZ9NHv0N2A@mail.gmail.com>
Subject: Re: [PATCH -next v2 3/7] md: delay choosing sync direction to md_start_sync()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:13=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Before this patch, for read-write array:
>
> 1) md_check_recover() found that something need to be done, and it'll
>    try to grab 'reconfig_mutex'. The case that md_check_recover() need
>    to do something:
>    - array is not suspend;
>    - super_block need to be updated;
>    - 'MD_RECOVERY_NEEDED' or ''MD_RECOVERY_DONE' is set;
>    - unusual case related to safemode;
>
> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>    md_check_recover() will try to choose a sync direction, and then
>    queue a work md_start_sync().
>
> 3) md_start_sync() register sync_thread;
>
> After this patch,
>
> 1) is the same;
> 2) if 'MD_RECOVERY_RUNNING' is not set, and 'MD_RECOVERY_NEEDED' is set,
>    queue a work md_start_sync() directly;
> 3) md_start_sync() will try to choose a sync direction, and then
>    register sync_thread();
>
> Because 'MD_RECOVERY_RUNNING' is cleared when sync_thread is done, 2)
> and 3) is always ran in serial and they can never concurrent, this
> change should not introduce any behavior change for now.
>
> Also fix a problem that md_start_sync() can clear 'MD_RECOVERY_RUNNING'
> without protection in error path, which might affect the logical in
> md_check_recovery().
>
> The advantage to change this is that array reconfiguration is
> independent from daemon now, and it'll be much easier to synchronize it
> with io, consider that io may rely on daemon thread to be done.

Hi Kuai

What's the meaning of "array reconfiguration" here? "mdadm -f/-r/-a"
something like this, right?. Because before and after this patch, only
one sync thread can be running, so If we don't do this change, are
there bugs or performance problems?

If it's only a patch that wants to make md_check_recovery more clearer
and easier, I'm good with this idea too.

Best Regards
Xiao
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 70 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 4846ff6d25b0..03615b0e9fe1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9291,6 +9291,22 @@ static bool md_choose_sync_direction(struct mddev =
*mddev, int *spares)
>  static void md_start_sync(struct work_struct *ws)
>  {
>         struct mddev *mddev =3D container_of(ws, struct mddev, sync_work)=
;
> +       int spares =3D 0;
> +
> +       mddev_lock_nointr(mddev);
> +
> +       if (!md_choose_sync_direction(mddev, &spares))
> +               goto not_running;
> +
> +       if (!mddev->pers->sync_request)
> +               goto not_running;
> +
> +       /*
> +        * We are adding a device or devices to an array which has the bi=
tmap
> +        * stored on all devices. So make sure all bitmap pages get writt=
en.
> +        */
> +       if (spares)
> +               md_bitmap_write_all(mddev->bitmap);
>
>         rcu_assign_pointer(mddev->sync_thread,
>                            md_register_thread(md_do_sync, mddev, "resync"=
));
> @@ -9298,20 +9314,27 @@ static void md_start_sync(struct work_struct *ws)
>                 pr_warn("%s: could not start resync thread...\n",
>                         mdname(mddev));
>                 /* leave the spares where they are, it shouldn't hurt */
> -               clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> -               clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> -               wake_up(&resync_wait);
> -               if (test_and_clear_bit(MD_RECOVERY_RECOVER,
> -                                      &mddev->recovery))
> -                       if (mddev->sysfs_action)
> -                               sysfs_notify_dirent_safe(mddev->sysfs_act=
ion);
> -       } else
> -               md_wakeup_thread(mddev->sync_thread);
> +               goto not_running;
> +       }
> +
> +       mddev_unlock(mddev);
> +       md_wakeup_thread(mddev->sync_thread);
>         sysfs_notify_dirent_safe(mddev->sysfs_action);
>         md_new_event();
> +       return;
> +
> +not_running:
> +       clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> +       clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> +       mddev_unlock(mddev);
> +
> +       wake_up(&resync_wait);
> +       if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
> +           mddev->sysfs_action)
> +               sysfs_notify_dirent_safe(mddev->sysfs_action);
>  }
>
>  /*
> @@ -9379,7 +9402,6 @@ void md_check_recovery(struct mddev *mddev)
>                 return;
>
>         if (mddev_trylock(mddev)) {
> -               int spares =3D 0;
>                 bool try_set_sync =3D mddev->safemode !=3D 0;
>
>                 if (!mddev->external && mddev->safemode =3D=3D 1)
> @@ -9467,29 +9489,11 @@ void md_check_recovery(struct mddev *mddev)
>                 clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
>
>                 if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recov=
ery) ||
> -                   test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
> -                       goto not_running;
> -               if (!md_choose_sync_direction(mddev, &spares))
> -                       goto not_running;
> -               if (mddev->pers->sync_request) {
> -                       if (spares) {
> -                               /* We are adding a device or devices to a=
n array
> -                                * which has the bitmap stored on all dev=
ices.
> -                                * So make sure all bitmap pages get writ=
ten
> -                                */
> -                               md_bitmap_write_all(mddev->bitmap);
> -                       }
> +                   test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>                         queue_work(md_misc_wq, &mddev->sync_work);
> -                       goto unlock;
> -               }
> -       not_running:
> -               if (!mddev->sync_thread) {
> +               } else {
>                         clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
>                         wake_up(&resync_wait);
> -                       if (test_and_clear_bit(MD_RECOVERY_RECOVER,
> -                                              &mddev->recovery))
> -                               if (mddev->sysfs_action)
> -                                       sysfs_notify_dirent_safe(mddev->s=
ysfs_action);
>                 }
>         unlock:
>                 wake_up(&mddev->sb_wait);
> --
> 2.39.2
>

