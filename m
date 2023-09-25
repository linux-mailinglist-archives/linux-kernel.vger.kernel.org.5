Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08647AD193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjIYHZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjIYHZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F0AC6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695626649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rBYVDv59hkrAfmI0h5SRhnoDO8K6NGX5hpGfXWLtREA=;
        b=e9FeroFrdAbBkcz9aJ+sD8Atooyn74KFP5pjkLl9q+OST2sIn7o4yxmGT9xeU+oqpiBI+H
        yQQQJUyphIAdMQLyjl7bRxkZbtm9hPSVrOtackKxQUoKIHTcOEH4bTxKKcc9+nbLWPT9G0
        Oic/cSjEQsm6QllV1fVwJThlZgLDQXQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-nHXeW2WnMVmRtwo5f9ybsg-1; Mon, 25 Sep 2023 03:24:08 -0400
X-MC-Unique: nHXeW2WnMVmRtwo5f9ybsg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2776a4c47c3so435941a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695626646; x=1696231446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBYVDv59hkrAfmI0h5SRhnoDO8K6NGX5hpGfXWLtREA=;
        b=Oi+j8YDQ2EKdmmIYCsxo/iGsaNo/ZvXtBt+WoDJQvtYRzEiWPD64AeQtMtQLGpwGEO
         /l5tWg4tGwc7E3pAzjUCGH4o4gxS1N1YWZ7OUdmd9XRZf9aeIRXFwruxDv7CdLFvoZFI
         kTdXbzNmMyk7M4VxlELgda6PmLZgjl2OloL/FZUBMz0GjYJZAswOrEm9qvEh2QmqQZRH
         qAeyUEqwJxK+rukb/d7Kzo5w96GjNcfPKObe/4frzwmHZzc/PYGOuBv6znsAZCbbOTFO
         nu0u9j4ZSFu0x1Li0gqmPCtAhsqEB66HSKARX149/Ba0wWJAO6YkBSxeTfoEr3ByGCzT
         1iNw==
X-Gm-Message-State: AOJu0Yyun0GRDPRzFZqswWDCpZHe/q05+330yOQ38Vb/l1RJW8GC4ojc
        PBDfgyuXgXxATYPAjRhLH5D8IRxDCdEjXyUo81bYtLJ6/04uTzQmo72oHpLBakErn8FGrZWm6sC
        i8gik8aaPgL/4ISz0+RbQGFncALuUo50o1U4/cPLV78zvh0JcX08=
X-Received: by 2002:a17:90a:bc8f:b0:274:6f67:e7a8 with SMTP id x15-20020a17090abc8f00b002746f67e7a8mr3492882pjr.45.1695626646538;
        Mon, 25 Sep 2023 00:24:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhzuwiDu+C3Qa+Azw1g/b0tA+ssVnU7jrLFt/a/nt4NNBzTQg2Ww8KFDbh0FHMsHITpWO2zDNu3lPYhux5+ss=
X-Received: by 2002:a17:90a:bc8f:b0:274:6f67:e7a8 with SMTP id
 x15-20020a17090abc8f00b002746f67e7a8mr3492869pjr.45.1695626646245; Mon, 25
 Sep 2023 00:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230828020021.2489641-1-yukuai1@huaweicloud.com>
 <20230828020021.2489641-4-yukuai1@huaweicloud.com> <CALTww2-5F=C5N6YZ-3weD9xSWhpT6Mx8NkaevfXZWqR6=Bwc4A@mail.gmail.com>
In-Reply-To: <CALTww2-5F=C5N6YZ-3weD9xSWhpT6Mx8NkaevfXZWqR6=Bwc4A@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Mon, 25 Sep 2023 15:23:54 +0800
Message-ID: <CALTww2_VHCihAYBj39abNCO+M+HuHybnzVh6T_jf25NiBBLZ-g@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 3:21=E2=80=AFPM Xiao Ni <xni@redhat.com> wrote:
>
> On Mon, Aug 28, 2023 at 10:04=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Advantages for new apis:
> >  - reconfig_mutex is not required;
> >  - the weird logical that suspend array hold 'reconfig_mutex' for
> >    mddev_check_recovery() to update superblock is not needed;
> >  - the specail handling, 'pers->prepare_suspend', for raid456 is not
> >    needed;
> >  - It's safe to be called at any time once mddev is allocated, and it's
> >    designed to be used from slow path where array configuration is chan=
ged;
> >
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/md/md.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/md/md.h |  3 ++
> >  2 files changed, 86 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 7fa311a14317..6236e2e395c1 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -443,12 +443,22 @@ void mddev_suspend(struct mddev *mddev)
> >                         lockdep_is_held(&mddev->reconfig_mutex));
> >
> >         WARN_ON_ONCE(thread && current =3D=3D thread->tsk);
> > -       if (mddev->suspended++)
> > +
> > +       /* can't concurrent with __mddev_suspend() and __mddev_resume()=
 */
> > +       mutex_lock(&mddev->suspend_mutex);
> > +       if (mddev->suspended++) {
> > +               mutex_unlock(&mddev->suspend_mutex);
> >                 return;
> > +       }
> > +
> >         wake_up(&mddev->sb_wait);
> >         set_bit(MD_ALLOW_SB_UPDATE, &mddev->flags);
> >         percpu_ref_kill(&mddev->active_io);
> >
> > +       /*
> > +        * TODO: cleanup 'pers->prepare_suspend after all callers are r=
eplaced
> > +        * by __mddev_suspend().
> > +        */
> >         if (mddev->pers && mddev->pers->prepare_suspend)
> >                 mddev->pers->prepare_suspend(mddev);
> >
> > @@ -459,14 +469,21 @@ void mddev_suspend(struct mddev *mddev)
> >         del_timer_sync(&mddev->safemode_timer);
> >         /* restrict memory reclaim I/O during raid array is suspend */
> >         mddev->noio_flag =3D memalloc_noio_save();
> > +
> > +       mutex_unlock(&mddev->suspend_mutex);
> >  }
> >  EXPORT_SYMBOL_GPL(mddev_suspend);
> >
> >  void mddev_resume(struct mddev *mddev)
> >  {
> >         lockdep_assert_held(&mddev->reconfig_mutex);
> > -       if (--mddev->suspended)
> > +
> > +       /* can't concurrent with __mddev_suspend() and __mddev_resume()=
 */
> > +       mutex_lock(&mddev->suspend_mutex);
> > +       if (--mddev->suspended) {
> > +               mutex_unlock(&mddev->suspend_mutex);
> >                 return;
> > +       }
> >
> >         /* entred the memalloc scope from mddev_suspend() */
> >         memalloc_noio_restore(mddev->noio_flag);
> > @@ -477,9 +494,72 @@ void mddev_resume(struct mddev *mddev)
> >         set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> >         md_wakeup_thread(mddev->thread);
> >         md_wakeup_thread(mddev->sync_thread); /* possibly kick off a re=
shape */
> > +
> > +       mutex_unlock(&mddev->suspend_mutex);
> >  }
> >  EXPORT_SYMBOL_GPL(mddev_resume);
> >
> > +void __mddev_suspend(struct mddev *mddev)
> > +{
> > +
> > +       /*
> > +        * hold reconfig_mutex to wait for normal io will deadlock, bec=
ause
> > +        * other context can't update super_block, and normal io can re=
ly on
> > +        * updating super_block.
> > +        */
> > +       lockdep_assert_not_held(&mddev->reconfig_mutex);
> > +
> > +       mutex_lock(&mddev->suspend_mutex);
> > +
> > +       if (mddev->suspended) {
> > +               WRITE_ONCE(mddev->suspended, mddev->suspended + 1);
> > +               mutex_unlock(&mddev->suspend_mutex);
> > +               return;
> > +       }
> > +
> > +       percpu_ref_kill(&mddev->active_io);
> > +       wait_event(mddev->sb_wait, percpu_ref_is_zero(&mddev->active_io=
));
> > +
> > +       /*
> > +        * For raid456, io might be waiting for reshape to make progres=
s,
> > +        * allow new reshape to start while waiting for io to be done t=
o
> > +        * prevent deadlock.
> > +        */
> > +       WRITE_ONCE(mddev->suspended, mddev->suspended + 1);
>
> It changes the order of setting suspended and checking active_io.
> suspended is used to stop I/O. Now it checks active_io first and then
> adds suspended, if the i/o doesn't stop, it looks like active_io can't
> be 0. So it will stuck at waiting active_io to be 0?

Ah, I c, you add the state of active_io to judge if a raid is suspended.

Regards
Xiao
>
> Best Regards
> Xiao
>
> > +
> > +       del_timer_sync(&mddev->safemode_timer);
> > +       /* restrict memory reclaim I/O during raid array is suspend */
> > +       mddev->noio_flag =3D memalloc_noio_save();
> > +
> > +       mutex_unlock(&mddev->suspend_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(__mddev_suspend);
> > +
> > +void __mddev_resume(struct mddev *mddev)
> > +{
> > +       lockdep_assert_not_held(&mddev->reconfig_mutex);
> > +
> > +       mutex_lock(&mddev->suspend_mutex);
> > +       WRITE_ONCE(mddev->suspended, mddev->suspended - 1);
> > +       if (mddev->suspended) {
> > +               mutex_unlock(&mddev->suspend_mutex);
> > +               return;
> > +       }
> > +
> > +       /* entred the memalloc scope from __mddev_suspend() */
> > +       memalloc_noio_restore(mddev->noio_flag);
> > +
> > +       percpu_ref_resurrect(&mddev->active_io);
> > +       wake_up(&mddev->sb_wait);
> > +
> > +       set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> > +       md_wakeup_thread(mddev->thread);
> > +       md_wakeup_thread(mddev->sync_thread); /* possibly kick off a re=
shape */
> > +
> > +       mutex_unlock(&mddev->suspend_mutex);
> > +}
> > +EXPORT_SYMBOL_GPL(__mddev_resume);
> > +
> >  /*
> >   * Generic flush handling for md
> >   */
> > @@ -667,6 +747,7 @@ int mddev_init(struct mddev *mddev)
> >         mutex_init(&mddev->open_mutex);
> >         mutex_init(&mddev->reconfig_mutex);
> >         mutex_init(&mddev->sync_mutex);
> > +       mutex_init(&mddev->suspend_mutex);
> >         mutex_init(&mddev->bitmap_info.mutex);
> >         INIT_LIST_HEAD(&mddev->disks);
> >         INIT_LIST_HEAD(&mddev->all_mddevs);
> > diff --git a/drivers/md/md.h b/drivers/md/md.h
> > index fb3b123f16dd..1103e6b08ad9 100644
> > --- a/drivers/md/md.h
> > +++ b/drivers/md/md.h
> > @@ -316,6 +316,7 @@ struct mddev {
> >         unsigned long                   sb_flags;
> >
> >         int                             suspended;
> > +       struct mutex                    suspend_mutex;
> >         struct percpu_ref               active_io;
> >         int                             ro;
> >         int                             sysfs_active; /* set when sysfs=
 deletes
> > @@ -811,6 +812,8 @@ extern void md_rdev_clear(struct md_rdev *rdev);
> >  extern void md_handle_request(struct mddev *mddev, struct bio *bio);
> >  extern void mddev_suspend(struct mddev *mddev);
> >  extern void mddev_resume(struct mddev *mddev);
> > +extern void __mddev_suspend(struct mddev *mddev);
> > +extern void __mddev_resume(struct mddev *mddev);
> >
> >  extern void md_reload_sb(struct mddev *mddev, int raid_disk);
> >  extern void md_update_sb(struct mddev *mddev, int force);
> > --
> > 2.39.2
> >

