Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A597EAAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjKNHiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjKNHiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:38:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23D1A3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699947497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3006YXq71zofahS5HIR2HNeE61EXtDmyay156piXbE=;
        b=EgRLRdm72OGkqh41moKbQNr+0ykeMPgBeVjbpQj5f3U4BIDwddCvAuGbP8vkI5Y6DUJBxW
        8do/Z1O2lkKcyMY9ukQBIowYyYHPVXbLAw4GJ1hfdaDvAHnkjNsSsUKBN//WyG+43wRx8a
        zc8pEQz6C3Ut1fSWWRaYLvnmB/hyEPo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-nPAJobxdMRijkBF2XsKTag-1; Tue, 14 Nov 2023 02:38:16 -0500
X-MC-Unique: nPAJobxdMRijkBF2XsKTag-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-28014ce75d5so7479796a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:38:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699947495; x=1700552295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3006YXq71zofahS5HIR2HNeE61EXtDmyay156piXbE=;
        b=fjkDe4HgMvpYAsKH6A1U/upc0J+RnQd8JHMslI1N01+Q5YsjDOSCU39XtXwh/QV4Ar
         XTt+RlYnL88WurSK2vV4MXc9B+DFChSSfTSoaescrDuzG62Z5crH4mQTt/sBz4i5As7n
         2QzOlPDrfZd22AZzF4UCcUtC6Wn/8Hjp6MhVStPzu9V1FIre1z+evX6sT+LX7e+Czf8I
         ChZoQfk/QK9lSdXIS5bTTcWyNeCelJ3qtCzpxdJ4zO8WkW9enI0pW5mIifP++6DxELOY
         P2LljoCExpXfIqwiHuoR713sPctJBbduUh2vZv47OZf0SCV1TCIb5uFHGZfNmW6U/LkE
         z1Zg==
X-Gm-Message-State: AOJu0Yzu/OnWijYibOuHKxtNDO+aw75zGyQ5BipW/RzCoUejOWMiIbRK
        lx4+tG/u+ttRQ45ZH5nRZidMF4pOlLrRt7Q1yOEqMoZUtr6oA77ItK9J8+zCo/umzVX6Il8hjgr
        /evNo53a92nKg4PTlwpU2nwss/DGTvUX0AgGcdu3TmYnaIpStZrBv5w==
X-Received: by 2002:a17:90b:1647:b0:27d:853:9109 with SMTP id il7-20020a17090b164700b0027d08539109mr8478772pjb.20.1699947494782;
        Mon, 13 Nov 2023 23:38:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQ1GucCooBT96zncbDfoU/DxKAf0P4bmLmmoLwBRidI9yJroh1UJIAOS0KfBBMqDd8GcKRK8xYG2jl3TOwTIQ=
X-Received: by 2002:a17:90b:1647:b0:27d:853:9109 with SMTP id
 il7-20020a17090b164700b0027d08539109mr8478748pjb.20.1699947494027; Mon, 13
 Nov 2023 23:38:14 -0800 (PST)
MIME-Version: 1.0
References: <20231110172834.3939490-1-yukuai1@huaweicloud.com> <20231110172834.3939490-7-yukuai1@huaweicloud.com>
In-Reply-To: <20231110172834.3939490-7-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 14 Nov 2023 15:37:58 +0800
Message-ID: <CALTww2_z-a_njriXVsXttS9C052qTCnVjgYNuTs4qnU8x=xc4g@mail.gmail.com>
Subject: Re: [PATCH -next 6/8] md: factor out a helper to stop sync_thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, yukuai3@huawei.com, neilb@suse.de,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

It's good to put the common codes into one function. Before this, I
want to check a problem. Does idle_sync_thread need to stop sync
thread? The sync thread can be run again immediately after stopping
the sync thread when echo idle > sync_action. It looks like there is
no meaning to stop the sync thread for idle_sync_thread. If we don't
need to stop sync thread in idle_sync_thread, there is no need to
introduce mddev->sync_seq and only needs to clear MD_RECOVERY_FROZEN
in idle_sync_thread. Then it can make this patch simpler. Something
like this

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3484a0fc4d2a..34245c4c71b8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -716,7 +716,6 @@ int mddev_init(struct mddev *mddev)
        timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
        atomic_set(&mddev->active, 1);
        atomic_set(&mddev->openers, 0);
-       atomic_set(&mddev->sync_seq, 0);
        spin_lock_init(&mddev->lock);
        atomic_set(&mddev->flush_pending, 0);
        init_waitqueue_head(&mddev->sb_wait);
@@ -4848,38 +4847,33 @@ action_show(struct mddev *mddev, char *page)
        return sprintf(page, "%s\n", type);
 }

-static int stop_sync_thread(struct mddev *mddev)
+static void stop_sync_thread(struct mddev *mddev)
 {
        int ret =3D 0;

-       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-               return 0;

-       ret =3D mddev_lock(mddev);
-       if (ret)
-               return ret;
+       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+               return;

-       /*
-        * Check again in case MD_RECOVERY_RUNNING is cleared before lock i=
s
-        * held.
-        */
-       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
-               mddev_unlock(mddev);
-               return 0;
+       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
+               did_freeze =3D 1;
+               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+               md_wakeup_thread(mddev->thread);
        }

-       if (work_pending(&mddev->sync_work))
-               flush_workqueue(md_misc_wq);
-
        set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+
        /*
         * Thread might be blocked waiting for metadata update which will n=
ow
         * never happen
         */
        md_wakeup_thread_directly(mddev->sync_thread);

-       mddev_unlock(mddev);
-       return 0;
+        mddev_unlock(mddev);
+       wait_event(resync_wait, (mddev->sync_thread =3D=3D NULL &&
+                                       !test_bit(MD_RECOVERY_RUNNING,
+                                       &mddev->recovery)));
+        mddev_lock_nointr(mddev);
 }

 static int idle_sync_thread(struct mddev *mddev)
@@ -4891,8 +4885,14 @@ static int idle_sync_thread(struct mddev *mddev)
        if (ret)
                return ret;

-       mddev_lock(mddev);
-       test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+       ret =3D mddev_lock(mddev);
+       if (ret) {
+               mutex_unlock(&mddev->sync_mutex);
+               return ret;
+       }
+
+       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+
        mddev_unlock(mddev);
        mutex_unlock(&mddev->sync_mutex);
        return ret;
@@ -4906,17 +4906,15 @@ static int frozen_sync_thread(struct mddev *mddev)
        if (ret)
                return ret;

-       flag =3D test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-       ret =3D stop_sync_thread(mddev);
-       if (ret)
-               goto out;
+       ret =3D mddev_lock(mddev);
+       if (ret) {
+               mutex_unlock(&mddev->sync_mutex);
+               return ret;
+       }

-       ret =3D wait_event_interruptible(resync_wait,
-                       mddev->sync_thread =3D=3D NULL &&
-                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
-out:
-       if (ret && !flag)
-               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+       stop_sync_thread(mddev);
+
+       mddev_unlock(mddev);
        mutex_unlock(&mddev->sync_mutex);
        return ret;
 }
@@ -6388,22 +6386,9 @@ static int md_set_readonly(struct mddev *mddev,
struct block_device *bdev)
        if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_fl=
ags))
                return -EBUSY;

-       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
-               did_freeze =3D 1;
-               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-       }
-       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-
-       /*
-        * Thread might be blocked waiting for metadata update which will n=
ow
-        * never happen
-        */
-       md_wakeup_thread_directly(mddev->sync_thread);
+       stop_sync_thread(mddev);

        mddev_unlock(mddev);
-       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
-                                         &mddev->recovery));
        wait_event(mddev->sb_wait,
                   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
        mddev_lock_nointr(mddev);
@@ -6448,25 +6433,8 @@ static int do_md_stop(struct mddev *mddev, int mode,
        struct md_rdev *rdev;
        int did_freeze =3D 0;

-       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
-               did_freeze =3D 1;
-               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-       }
-       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
-               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-
-       /*
-        * Thread might be blocked waiting for metadata update which will n=
ow
-        * never happen
-        */
-       md_wakeup_thread_directly(mddev->sync_thread);
-
-       mddev_unlock(mddev);
-       wait_event(resync_wait, (mddev->sync_thread =3D=3D NULL &&
-                                !test_bit(MD_RECOVERY_RUNNING,
-                                          &mddev->recovery)));
-       mddev_lock_nointr(mddev);
-
+       stop_sync_thread(mddev);
+
        mutex_lock(&mddev->open_mutex);
        if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
            mddev->sysfs_active ||
@@ -9622,7 +9590,6 @@ void md_reap_sync_thread(struct mddev *mddev)

        /* resync has finished, collect result */
        md_unregister_thread(mddev, &mddev->sync_thread);
-       atomic_inc(&mddev->sync_seq);

        if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
            !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&

Best Regards
Xiao

On Fri, Nov 10, 2023 at 5:34=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> stop_sync_thread(), md_set_readonly() and do_md_stop() are trying to
> stop sync_thread() the same way, hence factor out a helper to make code
> cleaner, and also prepare to use the new helper to fix problems later.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Signed-off-by: Yu Kuai <yukuai1@huaweicloud.com>
> ---
>  drivers/md/md.c | 129 ++++++++++++++++++++++++++----------------------
>  1 file changed, 69 insertions(+), 60 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index c0f2bdafe46a..7252fae0c989 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4848,29 +4848,46 @@ action_show(struct mddev *mddev, char *page)
>         return sprintf(page, "%s\n", type);
>  }
>
> -static int stop_sync_thread(struct mddev *mddev)
> +static bool sync_thread_stopped(struct mddev *mddev, int *seq_ptr)
>  {
> -       int ret =3D 0;
> +       if (seq_ptr && *seq_ptr !=3D atomic_read(&mddev->sync_seq))
> +               return true;
>
> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               return 0;
> +       return (!mddev->sync_thread &&
> +               !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
> +}
>
> -       ret =3D mddev_lock(mddev);
> -       if (ret)
> -               return ret;
> +/*
> + * stop_sync_thread() - stop running sync_thread.
> + * @mddev: the array that sync_thread belongs to.
> + * @freeze: set true to prevent new sync_thread to start.
> + * @interruptible: if set true, then user can interrupt while waiting fo=
r
> + * sync_thread to be done.
> + *
> + * Noted that this function must be called with 'reconfig_mutex' grabbed=
, and
> + * fter this function return, 'reconfig_mtuex' will be released.
> + */
> +static int stop_sync_thread(struct mddev *mddev, bool freeze,
> +                           bool interruptible)
> +       __releases(&mddev->reconfig_mutex)
> +{
> +       int *seq_ptr =3D NULL;
> +       int sync_seq;
> +       int ret =3D 0;
> +
> +       if (freeze) {
> +               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       } else {
> +               clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +               sync_seq =3D atomic_read(&mddev->sync_seq);
> +               seq_ptr =3D &sync_seq;
> +       }
>
> -       /*
> -        * Check again in case MD_RECOVERY_RUNNING is cleared before lock=
 is
> -        * held.
> -        */
>         if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>                 mddev_unlock(mddev);
>                 return 0;
>         }
>
> -       if (work_pending(&mddev->sync_work))
> -               flush_workqueue(md_misc_wq);
> -
>         set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>         /*
>          * Thread might be blocked waiting for metadata update which will=
 now
> @@ -4879,53 +4896,58 @@ static int stop_sync_thread(struct mddev *mddev)
>         md_wakeup_thread_directly(mddev->sync_thread);
>
>         mddev_unlock(mddev);
> -       return 0;
> +       if (work_pending(&mddev->sync_work))
> +               flush_work(&mddev->sync_work);
> +
> +       if (interruptible)
> +               ret =3D wait_event_interruptible(resync_wait,
> +                                       sync_thread_stopped(mddev, seq_pt=
r));
> +       else
> +               wait_event(resync_wait, sync_thread_stopped(mddev, seq_pt=
r));
> +
> +       return ret;
>  }
>
>  static int idle_sync_thread(struct mddev *mddev)
>  {
>         int ret;
> -       int sync_seq =3D atomic_read(&mddev->sync_seq);
>         bool flag;
>
>         ret =3D mutex_lock_interruptible(&mddev->sync_mutex);
>         if (ret)
>                 return ret;
>
> -       flag =3D test_and_clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery)=
;
> -       ret =3D stop_sync_thread(mddev);
> +       flag =3D test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       ret =3D mddev_lock(mddev);
>         if (ret)
> -               goto out;
> +               goto unlock;
>
> -       ret =3D wait_event_interruptible(resync_wait,
> -                       sync_seq !=3D atomic_read(&mddev->sync_seq) ||
> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))=
;
> -out:
> +       ret =3D stop_sync_thread(mddev, false, true);
>         if (ret && flag)
>                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +unlock:
>         mutex_unlock(&mddev->sync_mutex);
>         return ret;
>  }
>
>  static int frozen_sync_thread(struct mddev *mddev)
>  {
> -       int ret =3D mutex_lock_interruptible(&mddev->sync_mutex);
> +       int ret;
>         bool flag;
>
> +       ret =3D mutex_lock_interruptible(&mddev->sync_mutex);
>         if (ret)
>                 return ret;
>
> -       flag =3D test_and_set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       ret =3D stop_sync_thread(mddev);
> +       flag =3D test_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +       ret =3D mddev_lock(mddev);
>         if (ret)
> -               goto out;
> +               goto unlock;
>
> -       ret =3D wait_event_interruptible(resync_wait,
> -                       mddev->sync_thread =3D=3D NULL &&
> -                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))=
;
> -out:
> +       ret =3D stop_sync_thread(mddev, true, true);
>         if (ret && !flag)
>                 clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> +unlock:
>         mutex_unlock(&mddev->sync_mutex);
>         return ret;
>  }
> @@ -6397,22 +6419,10 @@ static int md_set_readonly(struct mddev *mddev, s=
truct block_device *bdev)
>         if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_=
flags))
>                 return -EBUSY;
>
> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>                 did_freeze =3D 1;
> -               set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       }
> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>
> -       /*
> -        * Thread might be blocked waiting for metadata update which will=
 now
> -        * never happen
> -        */
> -       md_wakeup_thread_directly(mddev->sync_thread);
> -
> -       mddev_unlock(mddev);
> -       wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
> -                                         &mddev->recovery));
> +       stop_sync_thread(mddev, true, false);
>         wait_event(mddev->sb_wait,
>                    !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
>         mddev_lock_nointr(mddev);
> @@ -6421,6 +6431,10 @@ static int md_set_readonly(struct mddev *mddev, st=
ruct block_device *bdev)
>         if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>             mddev->sync_thread ||
>             test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +               /*
> +                * This could happen if user change array state through
> +                * ioctl/sysfs while reconfig_mutex is released.
> +                */
>                 pr_warn("md: %s still in use.\n",mdname(mddev));
>                 err =3D -EBUSY;
>                 goto out;
> @@ -6457,30 +6471,25 @@ static int do_md_stop(struct mddev *mddev, int mo=
de,
>         struct md_rdev *rdev;
>         int did_freeze =3D 0;
>
> -       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> +       if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
>                 did_freeze =3D 1;
> +
> +       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +               stop_sync_thread(mddev, true, false);
> +               mddev_lock_nointr(mddev);
> +       } else {
>                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>         }
> -       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> -
> -       /*
> -        * Thread might be blocked waiting for metadata update which will=
 now
> -        * never happen
> -        */
> -       md_wakeup_thread_directly(mddev->sync_thread);
> -
> -       mddev_unlock(mddev);
> -       wait_event(resync_wait, (mddev->sync_thread =3D=3D NULL &&
> -                                !test_bit(MD_RECOVERY_RUNNING,
> -                                          &mddev->recovery)));
> -       mddev_lock_nointr(mddev);
>
>         mutex_lock(&mddev->open_mutex);
>         if ((mddev->pers && atomic_read(&mddev->openers) > !!bdev) ||
>             mddev->sysfs_active ||
>             mddev->sync_thread ||
>             test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +               /*
> +                * This could happen if user change array state through
> +                * ioctl/sysfs while reconfig_mutex is released.
> +                */
>                 pr_warn("md: %s still in use.\n",mdname(mddev));
>                 mutex_unlock(&mddev->open_mutex);
>                 if (did_freeze) {
> --
> 2.39.2
>

