Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103777DB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242348AbjHPHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjHPHTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9872110
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692170334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y9YpilQCL3ynVImiYsoeiobJXH6We3bG9cGLYb4gSg0=;
        b=Ig+UflvwZTZB4Uq2Q/GzC003TdkhaieRZcy9q1g11+dUh1zImgQHvGmrdIWLvQjG4onD2B
        2ivd6QHg5hRIvqyGCQeHdh9CzNTvdOkYKhGOZcvc4UYtGwPBwaR8KDOu3en//jzD50nxNT
        uGyXqGBLEWVOk1LaFNy/uPTCh5B6zks=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-_23N68-YOdCKeaYIkHJrig-1; Wed, 16 Aug 2023 03:18:53 -0400
X-MC-Unique: _23N68-YOdCKeaYIkHJrig-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-56506e5dbfeso6821900a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692170332; x=1692775132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9YpilQCL3ynVImiYsoeiobJXH6We3bG9cGLYb4gSg0=;
        b=MVOr/k08h9kIU6zpDjr5V5navqEVDWs/6bPJgTmJDKsZw1k61/dPWjwImzE9nSIudS
         d9kiTdFFK2JHYEzo+gRPB7WaA2qNRcw1EvbG9RT8fR6+uKvjcIujrXhMnMkh9qA0kzLz
         jzfh8QFn1CNEFK7YXV61DNgdOculWohelMxw2TfvikuOVWLj0nZypeirLW3FsuwHu9H4
         ooZrfnV2J4pppBSnStQWUIb/xpIB1QPF86lLMCQUi2BNY+QvN3scf7JwiwjxHAIbGKZ8
         w6IuhlgXjsZdppYiXRorUIBFFoflAbTlxayqMoElrTK9zjMCXIJFh/occA71HGmGgj7B
         frow==
X-Gm-Message-State: AOJu0Yz7n40Sd1gjLNqk+rTovFco9vIuCwxdZx6b+KkoRSSfOCkk5/aN
        3SskZmemvAL5DOswmm+LWCmItYEiUp5W+rpZKRl/vyyl4IBEatJl4AhWMdeYgzcCfEuIMHpHSSp
        Y1/ONwK/eV/jxn+gtOryDD+0r/KgDr0s9yCIlO5us
X-Received: by 2002:a05:6a20:914d:b0:132:79da:385a with SMTP id x13-20020a056a20914d00b0013279da385amr1199087pzc.23.1692170332422;
        Wed, 16 Aug 2023 00:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKG3xiXPLtvSBOy7UTZ4AJ+JKycafKj/HYMUsWrsaKDAi3ZvRcMzimuYXdqRkXCl1oe3Fr7TH132EJgtc4jh4=
X-Received: by 2002:a05:6a20:914d:b0:132:79da:385a with SMTP id
 x13-20020a056a20914d00b0013279da385amr1199071pzc.23.1692170332143; Wed, 16
 Aug 2023 00:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230815030957.509535-1-yukuai1@huaweicloud.com> <20230815030957.509535-8-yukuai1@huaweicloud.com>
In-Reply-To: <20230815030957.509535-8-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 16 Aug 2023 15:18:40 +0800
Message-ID: <CALTww28yBsGucpaPO9BiQO-gU3+F25MaNVgGhnOA3Mi+9enFjQ@mail.gmail.com>
Subject: Re: [PATCH -next v2 7/7] md: delay remove_and_add_spares() for read
 only array to md_start_sync()
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
> Before this patch, for read-only array:
>
> md_check_recovery() check that 'MD_RECOVERY_NEEDED' is set, then it will
> call remove_and_add_spares() directly to try to remove and add rdevs
> from array.
>
> After this patch:
>
> 1) md_check_recovery() check that 'MD_RECOVERY_NEEDED' is set, and the
>    worker 'sync_work' is not pending, and there are rdevs can be added
>    or removed, then it will queue new work md_start_sync();
> 2) md_start_sync() will call remove_and_add_spares() and exist;

Hi Kuai

If md_check_recovery returns and md_starts_sync doesn't start, during
the window the raid changes to read-write, the sync thread can be run
but MD_RECOVERY_RUNNING isn't set. Is there such a problem?

Regards
Xiao

>
> This change make sure that array reconfiguration is independent from
> daemon, and it'll be much easier to synchronize it with io, consier
> that io may rely on daemon thread to be done.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index d26d2c35f9af..74d529479fcf 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9191,6 +9191,16 @@ static bool rdev_addable(struct md_rdev *rdev)
>         return true;
>  }
>
> +static bool md_spares_need_change(struct mddev *mddev)
> +{
> +       struct md_rdev *rdev;
> +
> +       rdev_for_each(rdev, mddev)
> +               if (rdev_removeable(rdev) || rdev_addable(rdev))
> +                       return true;
> +       return false;
> +}
> +
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this)
>  {
> @@ -9309,6 +9319,12 @@ static void md_start_sync(struct work_struct *ws)
>
>         mddev_lock_nointr(mddev);
>
> +       if (!md_is_rdwr(mddev)) {
> +               remove_and_add_spares(mddev, NULL);
> +               mddev_unlock(mddev);
> +               return;
> +       }
> +
>         if (!md_choose_sync_direction(mddev, &spares))
>                 goto not_running;
>
> @@ -9403,7 +9419,8 @@ void md_check_recovery(struct mddev *mddev)
>         }
>
>         if (!md_is_rdwr(mddev) &&
> -           !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
> +           (!test_bit(MD_RECOVERY_NEEDED, &mddev->recovery) ||
> +            work_pending(&mddev->sync_work)))
>                 return;
>         if ( ! (
>                 (mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
> @@ -9431,15 +9448,8 @@ void md_check_recovery(struct mddev *mddev)
>                                  */
>                                 rdev_for_each(rdev, mddev)
>                                         clear_bit(Blocked, &rdev->flags);
> -                       /* On a read-only array we can:
> -                        * - remove failed devices
> -                        * - add already-in_sync devices if the array its=
elf
> -                        *   is in-sync.
> -                        * As we only add devices that are already in-syn=
c,
> -                        * we can activate the spares immediately.
> -                        */
> -                       remove_and_add_spares(mddev, NULL);
> -                       /* There is no thread, but we need to call
> +                       /*
> +                        * There is no thread, but we need to call
>                          * ->spare_active and clear saved_raid_disk
>                          */
>                         set_bit(MD_RECOVERY_INTR, &mddev->recovery);
> @@ -9447,6 +9457,13 @@ void md_check_recovery(struct mddev *mddev)
>                         clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
>                         clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>                         clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags)=
;
> +
> +                       /*
> +                        * Let md_start_sync() to remove and add rdevs to=
 the
> +                        * array.
> +                        */
> +                       if (md_spares_need_change(mddev))
> +                               queue_work(md_misc_wq, &mddev->sync_work)=
;
>                         goto unlock;
>                 }
>
> --
> 2.39.2
>

