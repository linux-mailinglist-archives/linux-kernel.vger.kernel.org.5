Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F44D7F6DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjKXIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjKXIOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:14:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B044210FB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:14:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A708C433C8;
        Fri, 24 Nov 2023 08:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700813645;
        bh=yY7r0NmTSZjwOmhPQa1HduXqguztxuo72o3wVU0BM/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tSFjxlsV4uUVdscw2Un4otEoKDU8EHh/lJWjPTYF1X81EbiWZaKqCJ0fB2QoYv0wY
         dZ2ae0GtK3jH6bDEZlBDTlDBv0cgtcxK3KuMSAT7SBXyOIZXbLXqAl+b2QQwnO57lY
         l3cK0ykmmlHxNSRichzloioBCm16fpJyIIMcN/TxRboVjCtZj6SKyxk/qz/AiEgrY9
         5IxuIAaocEqD7y3lCunXXMei/7QSlvd+/xFzSO697iKFUgIKGwX9nAR9DAqEJyuplV
         BIkFmd4f7V8Ve0QKWOlhlRVHPSIox/SjBrvLRpudL6AGKfwR/i0EgqmdRtq3G83Bnn
         Rn+m+2BA8RHHA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507962561adso2468390e87.0;
        Fri, 24 Nov 2023 00:14:05 -0800 (PST)
X-Gm-Message-State: AOJu0YzB8y7ZDCjmZwalUhyE6DV/5gkB7SyCjXVHuUh35iNrcgisp8P9
        /MCO1G/r5jBKTtSX3dBTOVF2vuAUt+PCQjE/pG8=
X-Google-Smtp-Source: AGHT+IE3KT95bqnnUerosyzzgkim9S3Sv+AY1QhFZK/9JDq0XzMUAQIcC7eMMz5H2OuLGtaw1ByW6nqT9rBVBprx4Ls=
X-Received: by 2002:a19:6415:0:b0:504:4165:54ab with SMTP id
 y21-20020a196415000000b00504416554abmr946580lfb.56.1700813643560; Fri, 24 Nov
 2023 00:14:03 -0800 (PST)
MIME-Version: 1.0
References: <20231021102059.3198284-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231021102059.3198284-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 24 Nov 2023 00:13:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7gJkcpEV32EUesMNycRbN0t7t+00-q9RiVTgRiY2sFwA@mail.gmail.com>
Message-ID: <CAPhsuW7gJkcpEV32EUesMNycRbN0t7t+00-q9RiVTgRiY2sFwA@mail.gmail.com>
Subject: Re: [PATCH -next v2 0/6] md: remove rcu protection to access rdev
 from conf
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 7:25=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> The lifetime of rdev:
>
> 1. md_import_device() generate a rdev based on underlying disk;
>
>    mddev_lock()
>    rdev =3D kzalloc();
>    rdev->bdev =3D blkdev_get_by_dev();
>    mddev_unlock()
>
> 2. bind_rdev_to_array() add this rdev to mddev->disks;
>
>    mddev_lock()
>    kobject_add(&rdev->kobj, &mddev->kobj, ...);
>    list_add_rcu(&rdev->same_set, &mddev->disks);
>    mddev_unlock()
>
> 3. remove_and_add_spares() add this rdev to conf;
>
>    mddev_lock()
>    rdev_addable();
>    pers->hot_add_disk();
>    rcu_assign_pointer(conf->rdev, rdev);
>    mddev_unlock()
>
> 4. Use this array with rdev;
>
> 5. remove_and_add_spares() remove rdev from conf;
>
>    mddev_lock()
>    // triggered by sysfs/ioctl
>    rdev_removeable();
>    pers->hot_remove_disk();
>     rcu_assign_pointer(conf->rdev, NULL);
>     synchronize_rcu();
>    mddev_unlock()
>
>    // triggered by daemon
>    mddev_lock()
>    rdev_removeable();
>    synchronize_rcu(); -> this can't protect accessing rdev from conf
>    pers->hot_remove_disk();
>     rcu_assign_pointer(conf->rdev, NULL);
>    mddev_unlock()
>
> 6. md_kick_rdev_from_array() remove rdev from mddev->disks;
>
>    mddev_lock()
>    list_del_rcu(&rdev->same_set);
>    synchronize_rcu();
>    list_add(&rdev->same_set, &mddev->deleting)
>    mddev_unlock()
>     export_rdev
>
> There are two separate rcu protection for rdev, and this pathset remove
> the protection of conf(step 3 and 5), because it's safe to access rdev
> from conf in following cases:
>
>  - If 'reconfig_mutex' is held, because rdev can't be added or rmoved to
>  conf;
>  - If there is normal IO inflight, because mddev_suspend() will wait for
>  IO to be done and prevent rdev to be added or removed to conf;
>  - If sync thread is running, because remove_and_add_spares() can only be
>  called from daemon thread when sync thread is done, and
>  'MD_RECOVERY_RUNNING' is also checked for ioctl/sysfs;
>  - if any spinlock or rcu_read_lock() is held, because synchronize_rcu()
>  from step 6 prevent rdev to be freed until spinlock is released or
>  rcu_read_unlock();

Thanks for the cover letter.

Song

>
> Yu Kuai (6):
>   md: remove useless debug code to print configuration
>   md: remove flag RemoveSynchronized
>   md/raid1: remove rcu protection to access rdev from conf
>   md/raid10: remove rcu protection to access rdev from conf
>   md/raid5: remove rcu protection to access rdev from conf
>   md/md-multipath: remove rcu protection to access rdev from conf
>
>  drivers/md/md-multipath.c |  29 ++---
>  drivers/md/md.c           |  37 +-----
>  drivers/md/raid1.c        |  94 ++++-----------
>  drivers/md/raid10.c       | 248 +++++++++-----------------------------
>  drivers/md/raid5-cache.c  |  11 +-
>  drivers/md/raid5-ppl.c    |  16 +--
>  drivers/md/raid5.c        | 225 ++++++++++------------------------
>  drivers/md/raid5.h        |   4 +-
>  8 files changed, 163 insertions(+), 501 deletions(-)
>
> --
> 2.39.2
>
