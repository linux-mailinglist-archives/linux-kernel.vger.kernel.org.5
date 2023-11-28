Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3918D7FAECB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjK1AAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjK1AAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:00:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A0F187
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:00:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB610C433CB;
        Tue, 28 Nov 2023 00:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701129639;
        bh=MFEYzA5mRp7AN8cKcjjH0SZ29aaBIB6cSEEMifvx+zw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eifm4jkYBFRMkBOPOuob5rBVQ7w5SXk6nIyLpDUpZLLrIUNuI+qpRwDJD2/GbeTnz
         tONKnd+oiwb+AMT8veEAYETnAt85sducm8I3E9Yr/MzzADjwSaLrdKPYANbkrVcwyX
         8XdylOxWFR5FF6pb7qIs47BJkrNaW8y8Nj2395n5Ps0zGHd3eiMgf5JY6UAgXL+Eu9
         alXjK8+ZQuijh4/CjFcseJD2PXMg5BWhJSul8uN7bgZclS73FMMQHeco3e8NaxNjte
         At5doBMqxOUGU0M6mBAF1n9W+T/5NR8xRQ8uI7rG0+BHtvl6Xg2OLT/ASXYql4CPyi
         +HKlSojyUuVtA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50abb83866bso6576358e87.3;
        Mon, 27 Nov 2023 16:00:39 -0800 (PST)
X-Gm-Message-State: AOJu0Yz3Vv4+VOWu8tk8WgNtgzziMgd49HFRi60SxwIRFK3J8HXcoqtO
        vxb3TTsJtlxvdNYsbHcbbdxbQNASbT26lCvEvU4=
X-Google-Smtp-Source: AGHT+IEyxhwV57xREqVEVRtoPCW8vyDy/j2VuC8DuuHZeidKON0ZGwnmElAZKaE5wzBJzzYqQMbpK2tDy+55ue8AU+8=
X-Received: by 2002:ac2:5973:0:b0:504:30eb:f2ac with SMTP id
 h19-20020ac25973000000b0050430ebf2acmr7821132lfp.68.1701129637794; Mon, 27
 Nov 2023 16:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20231124075953.1932764-1-yukuai1@huaweicloud.com> <20231124075953.1932764-7-yukuai1@huaweicloud.com>
In-Reply-To: <20231124075953.1932764-7-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Nov 2023 16:00:25 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5jDzOo=2NVHO17jfjmpR0LV9+Q1a9FkBA8NBshX9t=ig@mail.gmail.com>
Message-ID: <CAPhsuW5jDzOo=2NVHO17jfjmpR0LV9+Q1a9FkBA8NBshX9t=ig@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] dm-raid: delay flushing event_work() after
 reconfig_mutex is released
To:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@lists.linux.dev
Cc:     yukuai3@huawei.com, xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
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

+ dm-devel@lists.linux.dev

On Fri, Nov 24, 2023 at 12:00=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> After commit db5e653d7c9f ("md: delay choosing sync action to
> md_start_sync()"), md_start_sync() will hold 'reconfig_mutex', however,
> in order to make sure event_work is done, __md_stop() will flush
> workqueue with reconfig_mutex grabbed, hence if sync_work is still
> pending, deadlock will be triggered.
>
> Fortunately, former pacthes to fix stopping sync_thread already make sure
> all sync_work is done already, hence such deadlock is not possible
> anymore. However, in order not to cause confusions for people by this
> implicit dependency, delay flushing event_work to dm-raid where
> 'reconfig_mutex' is not held, and add some comments to emphasize that
> the workqueue can't be flushed with 'reconfig_mutex'.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/dm-raid.c |  3 +++
>  drivers/md/md.c      | 11 ++++++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
> index a4692f8f98ee..51f15c20f621 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -3317,6 +3317,9 @@ static void raid_dtr(struct dm_target *ti)
>         mddev_lock_nointr(&rs->md);
>         md_stop(&rs->md);
>         mddev_unlock(&rs->md);
> +
> +       if (work_pending(&rs->md.event_work))
> +               flush_work(&rs->md.event_work);
>         raid_set_free(rs);
>  }
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index fb8a7d1eebee..86efc9c2ae56 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -82,6 +82,14 @@ static struct module *md_cluster_mod;
>
>  static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
>  static struct workqueue_struct *md_wq;
> +
> +/*
> + * This workqueue is used for sync_work to register new sync_thread, and=
 for
> + * del_work to remove rdev, and for event_work that is only set by dm-ra=
id.
> + *
> + * Noted that sync_work will grab reconfig_mutex, hence never flush this
> + * workqueue whith reconfig_mutex grabbed.
> + */
>  static struct workqueue_struct *md_misc_wq;
>  struct workqueue_struct *md_bitmap_wq;
>
> @@ -6328,9 +6336,6 @@ static void __md_stop(struct mddev *mddev)
>         struct md_personality *pers =3D mddev->pers;
>         md_bitmap_destroy(mddev);
>         mddev_detach(mddev);
> -       /* Ensure ->event_work is done */
> -       if (mddev->event_work.func)
> -               flush_workqueue(md_misc_wq);
>         spin_lock(&mddev->lock);
>         mddev->pers =3D NULL;
>         spin_unlock(&mddev->lock);
> --
> 2.39.2
>
