Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D500E8015DC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjLAWIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAWIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:08:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5B210D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:08:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D893BC433C7;
        Fri,  1 Dec 2023 22:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701468505;
        bh=J5w34K9IrU/nR2a8B14bwImOYjReMdTVS9JU/XNvSsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qfXuNNACF7hA0zP4Ro4689MIjK0/2F1aOBAT/G0zwtzTIjnYMcoxCWS6RjHDeVk/x
         xZu0qNhJlmR9figpgQo5rTN1w+7GOjYTz3FoZPYMwrDQG+zQ7rsG8dnfrO81tO0o1P
         aoEzy25IPws+/yPeAB6HkdxNzdmNHXqc6FPGU/n9qxk3v3Gyn1ElCs3W+hqdUN95pW
         emw6LaECUJNUM3oyvzY11C98NWqYRF4LmMa5MSBe9XeRAGE2g+RBlEEpf8i4GE/N+m
         V8RPAxz998LeavKHGQdSdaO8mIwp0G26dy2y5wIkCw8CjHCNGcilVyTT4dhNhFPoEN
         naaRKXvkSlueA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c9ee6fed3eso1451721fa.0;
        Fri, 01 Dec 2023 14:08:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwfMraCFkEz1mh/xCiWER8971UVzPUVe/r7Wm3VuuKUAVFv6Clo
        t258WL5//KVk+9Dsav8GXKjJSwsErdhI0N+qVPk=
X-Google-Smtp-Source: AGHT+IFyU0hHoUTao7qYuN1h9ap95jN4vHRIrlLsDHJbqiCnwLomDQNsV4I8eA8CmODrnx8Irt6bLh40Ub599KVaRh8=
X-Received: by 2002:a2e:99c5:0:b0:2c9:e9eb:8ccb with SMTP id
 l5-20020a2e99c5000000b002c9e9eb8ccbmr345272ljj.69.1701468504052; Fri, 01 Dec
 2023 14:08:24 -0800 (PST)
MIME-Version: 1.0
References: <20231129043127.2245901-1-yukuai1@huaweicloud.com> <20231129043127.2245901-4-yukuai1@huaweicloud.com>
In-Reply-To: <20231129043127.2245901-4-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Dec 2023 14:08:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6ato6HNAosJZa1o2WHpoF1Y+qcSPLd3Y_rwW1ZiHAydQ@mail.gmail.com>
Message-ID: <CAPhsuW6ato6HNAosJZa1o2WHpoF1Y+qcSPLd3Y_rwW1ZiHAydQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] md: fix stopping sync thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, yukuai3@huawei.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 8:32=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently sync thread is stopped from multiple contex:
>  - idle_sync_thread
>  - frozen_sync_thread
>  - __md_stop_writes
>  - md_set_readonly
>  - do_md_stop
>
> And there are some problems:
> 1) sync_work is flushed while reconfig_mutex is grabbed, this can
>    deadlock because the work function will grab reconfig_mutex as well.
> 2) md_reap_sync_thread() can't be called directly while md_do_sync() is
>    not finished yet, for example, commit 130443d60b1b ("md: refactor
>    idle/frozen_sync_thread() to fix deadlock").
> 3) If MD_RECOVERY_RUNNING is not set, there is no need to stop
>    sync_thread at all because sync_thread must not be registered.
>
> Factor out a helper prepare_to_stop_sync_thread(), so that above contex
> will behave the same. Fix 1) by flushing sync_work after reconfig_mutex
> is released, before waiting for sync_thread to be done; Fix 2) bt
> letting daemon thread to unregister sync_thread; Fix 3) by always
> checking MD_RECOVERY_RUNNING first.
>
> Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
> Acked-by: Xiao Ni <xni@redhat.com>
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 96 +++++++++++++++++++++++--------------------------
>  1 file changed, 45 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 2d8e45a1af23..05902e36db66 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4840,26 +4840,9 @@ action_show(struct mddev *mddev, char *page)
>         return sprintf(page, "%s\n", type);
>  }
>
> -static void stop_sync_thread(struct mddev *mddev)
> +static void prepare_to_stop_sync_thread(struct mddev *mddev)
> +       __releases(&mddev->reconfig_mutex)
>  {
> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
> -               return;
> -
> -       if (mddev_lock(mddev))
> -               return;
> -
> -       /*
> -        * Check again in case MD_RECOVERY_RUNNING is cleared before lock=
 is
> -        * held.
> -        */
> -       if (!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> -               mddev_unlock(mddev);
> -               return;
> -       }
> -
> -       if (work_pending(&mddev->sync_work))
> -               flush_workqueue(md_misc_wq);
> -
>         set_bit(MD_RECOVERY_INTR, &mddev->recovery);
>         /*
>          * Thread might be blocked waiting for metadata update which will=
 now
> @@ -4868,6 +4851,8 @@ static void stop_sync_thread(struct mddev *mddev)
>         md_wakeup_thread_directly(mddev->sync_thread);
>
>         mddev_unlock(mddev);
> +       if (work_pending(&mddev->sync_work))
> +               flush_work(&mddev->sync_work);
>  }
>
>  static void idle_sync_thread(struct mddev *mddev)
> @@ -4876,10 +4861,20 @@ static void idle_sync_thread(struct mddev *mddev)
>
>         mutex_lock(&mddev->sync_mutex);
>         clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -       stop_sync_thread(mddev);
>
> -       wait_event(resync_wait, sync_seq !=3D atomic_read(&mddev->sync_se=
q) ||
> +       if (mddev_lock(mddev)) {
> +               mutex_unlock(&mddev->sync_mutex);
> +               return;
> +       }
> +
> +       if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
> +               prepare_to_stop_sync_thread(mddev);
> +               wait_event(resync_wait,
> +                       sync_seq !=3D atomic_read(&mddev->sync_seq) ||
>                         !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))=
;
> +       } else {
> +               mddev_unlock(mddev);
> +       }

We have a few patterns like this:

        if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
                prepare_to_stop_sync_thread(mddev);
                wait_event(resync_wait,
                        sync_seq !=3D atomic_read(&mddev->sync_seq) ||
                        !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
        } else {
                mddev_unlock(mddev);
        }

This is pretty confusing. Maybe try something like (untested)

static void stop_sync_thread(struct mddev *mddev,
                             bool do_unlock, bool check_sync_seq)
{
        if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
                if (do_unlock)
                        mddev_unlock(mddev);
                return;
        }
        set_bit(MD_RECOVERY_INTR, &mddev->recovery);
        /*
         * Thread might be blocked waiting for metadata update which will n=
ow
         * never happen
         */
        md_wakeup_thread_directly(mddev->sync_thread);

        mddev_unlock(mddev);
        if (work_pending(&mddev->sync_work))
                flush_work(&mddev->sync_work);
        wait_event(resync_wait,
                   !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
                   (check_sync_seq && sync_seq !=3D
atomic_read(&mddev->sync_seq)));
        if (!do_unlock)
                mddev_lock_nointr(mddev);
}

Thanks,
Song
