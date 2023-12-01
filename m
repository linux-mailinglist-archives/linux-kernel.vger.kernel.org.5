Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD58014D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379618AbjLAUxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:53:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D5F9A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:53:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF65C433C9;
        Fri,  1 Dec 2023 20:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701464023;
        bh=wD6Jai5Z6eOt34oUVbS2GgQXkDc/gl9dotnnn2cqqgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F+zt3yjybvfdRpuXOCYuMprFSepkR5tEJl93tYALkj7A7UOGb57vOwgaMV12mYZbD
         3V5uneF/jocIAOliE3T4X11e2wxcj78/zo06tXffb6pub2cbJuT0AhP5NKqENfPD1H
         R5nRw7DI90Q3wO6yNkSm0BLu7xqjgsVRvu/VLbedtzJEaeXkjTuJCUYgsIzq+dW2XR
         +Di/dIpHDxo7YVbcJ9FkB+pjsED0/I0iVX84f+NFh0Sg2udEkIkqmq9BWwMGX4vI5y
         c6+figDUcvvOEn8ytN0gfkBEUBsCeJ5gy0XZF6wTtRVmwIOnmxjhUNGDkOTLMF2VQj
         lxO7t8l0Ml95w==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50bce42295eso3037829e87.2;
        Fri, 01 Dec 2023 12:53:43 -0800 (PST)
X-Gm-Message-State: AOJu0Yx+7ospLi1kQzn9FzQNqr1h+qqT4GCnyBQ1cm2CL9OgXw9XND7r
        yjXFTqzXCESpQ1IoAQnLkRi2gM8z4MoliCD1b6s=
X-Google-Smtp-Source: AGHT+IHa0ADuo5W7wjVuQiyPdvhr+vVxBJ9UQ9nycBbdc3wukIBfY9EVdWxYP4xpxmL5MhQz99GdgsHqbrkgeHvKjys=
X-Received: by 2002:a05:6512:3b23:b0:509:49fc:c261 with SMTP id
 f35-20020a0565123b2300b0050949fcc261mr1738205lfv.51.1701464021881; Fri, 01
 Dec 2023 12:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20231129043127.2245901-1-yukuai1@huaweicloud.com> <20231129043127.2245901-3-yukuai1@huaweicloud.com>
In-Reply-To: <20231129043127.2245901-3-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 1 Dec 2023 12:53:29 -0800
X-Gmail-Original-Message-ID: <CAPhsuW75Qmn1QamykogAnMBDMGwMrfTKh+VeNCtxmjkyszgEag@mail.gmail.com>
Message-ID: <CAPhsuW75Qmn1QamykogAnMBDMGwMrfTKh+VeNCtxmjkyszgEag@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] md: don't leave 'MD_RECOVERY_FROZEN' in error path
 of md_set_readonly()
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
> If md_set_readonly() failed, the array could still be read-write, however
> 'MD_RECOVERY_FROZEN' could still be set, which leave the array in an
> abnormal state that sync or recovery can't continue anymore.
> Hence make sure the flag is cleared after md_set_readonly() returns.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Acked-by: Xiao Ni <xni@redhat.com>

Since we are shipping this via the md-fixes branch, we need a Fixes tag.

> ---
>  drivers/md/md.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5640a948086b..2d8e45a1af23 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -6355,6 +6355,9 @@ static int md_set_readonly(struct mddev *mddev, str=
uct block_device *bdev)
>         int err =3D 0;
>         int did_freeze =3D 0;
>
> +       if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_=
flags))
> +               return -EBUSY;
> +
>         if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>                 did_freeze =3D 1;
>                 set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> @@ -6369,8 +6372,6 @@ static int md_set_readonly(struct mddev *mddev, str=
uct block_device *bdev)
>          */
>         md_wakeup_thread_directly(mddev->sync_thread);
>
> -       if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_=
flags))
> -               return -EBUSY;
>         mddev_unlock(mddev);
>         wait_event(resync_wait, !test_bit(MD_RECOVERY_RUNNING,
>                                           &mddev->recovery));
> @@ -6383,29 +6384,30 @@ static int md_set_readonly(struct mddev *mddev, s=
truct block_device *bdev)
>             mddev->sync_thread ||
>             test_bit(MD_RECOVERY_RUNNING, &mddev->recovery)) {
>                 pr_warn("md: %s still in use.\n",mdname(mddev));
> -               if (did_freeze) {
> -                       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> -                       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> -                       md_wakeup_thread(mddev->thread);
> -               }

This change (move did_freeze, etc.) is not explained in the commit log.
Is it just refactor?

Thanks,
Song


>                 err =3D -EBUSY;
>                 goto out;
>         }
> +
>         if (mddev->pers) {
>                 __md_stop_writes(mddev);
>
> -               err  =3D -ENXIO;
> -               if (mddev->ro =3D=3D MD_RDONLY)
> +               if (mddev->ro =3D=3D MD_RDONLY) {
> +                       err  =3D -ENXIO;
>                         goto out;
> +               }
> +
>                 mddev->ro =3D MD_RDONLY;
>                 set_disk_ro(mddev->gendisk, 1);
> +       }
> +
> +out:
> +       if ((mddev->pers && !err) || did_freeze) {
>                 clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
>                 set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
>                 md_wakeup_thread(mddev->thread);
>                 sysfs_notify_dirent_safe(mddev->sysfs_state);
> -               err =3D 0;
>         }
> -out:
> +
>         mutex_unlock(&mddev->open_mutex);
>         return err;
>  }
> --
> 2.39.2
>
