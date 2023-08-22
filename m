Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE9783D8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjHVKFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjHVKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CE8CD8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692698656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eunSjqXebVmPJQFHfHymAQbG2gyuuDWNReWk5LCjmQE=;
        b=IeU1W60CKmIsdha2OxVWsKJyDeewaM8LYGZs7CniTnw9zySCMGjdEMOhYeJnGZFEIeQl4M
        U0EDzJxA2EXlHPpWZO99c94eq0s79Bv5E9P0lFlT7ulkJPu+rjrQVBJAyLXshrDkiL57j9
        rm49c0axkvoAg0bC5jDT0x63+1U/2E0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687--9CtqCg-MzigZm2MUsEAfQ-1; Tue, 22 Aug 2023 06:04:14 -0400
X-MC-Unique: -9CtqCg-MzigZm2MUsEAfQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26b3e13a776so4476117a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698654; x=1693303454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eunSjqXebVmPJQFHfHymAQbG2gyuuDWNReWk5LCjmQE=;
        b=Q5ZEB+s5SFC0C6pgqoc4joY+clZuWH96BIbrsohQjDDEzL7jbxMRX60iX+D8+a0rSZ
         fIslTEhiXBn15/4SnMR5VDfJ+vwzqyxhEBEe11wEbLWPUalzl5Xi16tlLwbuIcVMcMb2
         Jg2a4+2ijfpySZxWamgyxob/Cf9d+1MroQmnybPnQ4N8vASYal5IYb8AgPARMRffl4bd
         e3GFRjAHO05pSety3x76ZQ9WXFOX+U9uMkCv7L22bXVWDGAIh+V/TqFAQtBLOcROTorb
         qfK48s4czFO3Y7FXKS83ntdASBRJtc5d5tw0ozJurn4rG8PYbGlDieBK363U4DhuvPmX
         X4vg==
X-Gm-Message-State: AOJu0Yym6sfGDOiyDMLYP2LMoHRPKm15SApp2VeV59y6mbCTMFc2QZtC
        PAdS63hLW7q+5pnoAuRiVNyVXfdGABEJ9B+lTdYeNoflwq+Rb6HKMFywix3nv7xG6VilVZTihHJ
        q0Bodmnhwfdyi9V8YmMHgINGbrRIFGnZG4Mqo2xTK
X-Received: by 2002:a17:90a:8681:b0:267:fba3:ed96 with SMTP id p1-20020a17090a868100b00267fba3ed96mr5698302pjn.3.1692698653956;
        Tue, 22 Aug 2023 03:04:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQAyUGLu26v0m9FhbT8nXHCmebwasow1EknDEE9+bi+15V6BUlty4S6j9T52Z0FdgUC5Ho6Jjv+/2I19wxkQc=
X-Received: by 2002:a17:90a:8681:b0:267:fba3:ed96 with SMTP id
 p1-20020a17090a868100b00267fba3ed96mr5698287pjn.3.1692698653590; Tue, 22 Aug
 2023 03:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com> <20230820090949.2874537-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230820090949.2874537-2-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 22 Aug 2023 18:04:02 +0800
Message-ID: <CALTww2_XL7j_OMjNMNdCti8TyOxC_U69v6Dg1UXHfajaWeN4Cg@mail.gmail.com>
Subject: Re: [PATCH -next v3 1/7] md: use separate work_struct for md_start_sync()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 5:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> It's a little weird to borrow 'del_work' for md_start_sync(), declare
> a new work_struct 'sync_work' for md_start_sync().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 10 ++++++----
>  drivers/md/md.h |  5 ++++-
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5c3c19b8d509..90815be1e80f 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -631,13 +631,13 @@ void mddev_put(struct mddev *mddev)
>                  * flush_workqueue() after mddev_find will succeed in wai=
ting
>                  * for the work to be done.
>                  */
> -               INIT_WORK(&mddev->del_work, mddev_delayed_delete);
>                 queue_work(md_misc_wq, &mddev->del_work);
>         }
>         spin_unlock(&all_mddevs_lock);
>  }
>
>  static void md_safemode_timeout(struct timer_list *t);
> +static void md_start_sync(struct work_struct *ws);
>
>  void mddev_init(struct mddev *mddev)
>  {
> @@ -662,6 +662,9 @@ void mddev_init(struct mddev *mddev)
>         mddev->resync_min =3D 0;
>         mddev->resync_max =3D MaxSector;
>         mddev->level =3D LEVEL_NONE;
> +
> +       INIT_WORK(&mddev->sync_work, md_start_sync);
> +       INIT_WORK(&mddev->del_work, mddev_delayed_delete);
>  }
>  EXPORT_SYMBOL_GPL(mddev_init);
>
> @@ -9245,7 +9248,7 @@ static int remove_and_add_spares(struct mddev *mdde=
v,
>
>  static void md_start_sync(struct work_struct *ws)
>  {
> -       struct mddev *mddev =3D container_of(ws, struct mddev, del_work);
> +       struct mddev *mddev =3D container_of(ws, struct mddev, sync_work)=
;
>
>         rcu_assign_pointer(mddev->sync_thread,
>                            md_register_thread(md_do_sync, mddev, "resync"=
));
> @@ -9458,8 +9461,7 @@ void md_check_recovery(struct mddev *mddev)
>                                  */
>                                 md_bitmap_write_all(mddev->bitmap);
>                         }
> -                       INIT_WORK(&mddev->del_work, md_start_sync);
> -                       queue_work(md_misc_wq, &mddev->del_work);
> +                       queue_work(md_misc_wq, &mddev->sync_work);
>                         goto unlock;
>                 }
>         not_running:
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 9bcb77bca963..64d05cb65287 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -450,7 +450,10 @@ struct mddev {
>         struct kernfs_node              *sysfs_degraded;        /*handle =
for 'degraded' */
>         struct kernfs_node              *sysfs_level;           /*handle =
for 'level' */
>
> -       struct work_struct del_work;    /* used for delayed sysfs removal=
 */
> +       /* used for delayed sysfs removal */
> +       struct work_struct del_work;
> +       /* used for register new sync thread */
> +       struct work_struct sync_work;
>
>         /* "lock" protects:
>          *   flush_bio transition from NULL to !NULL
> --
> 2.39.2
>

Reviewed-by: Xiao Ni <xni@redhat.com>

