Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776A57990FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243609AbjIHUaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjIHUaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:30:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36AD8E;
        Fri,  8 Sep 2023 13:30:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CC8C433C9;
        Fri,  8 Sep 2023 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694205013;
        bh=UBZzVIWBiQ4B80C/9DQ9Ox8AvmoOm/T3gLFsaf19zZs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iLoOfmHXxNNwVVf2qphHX8MXI4dKegtEkIKseIl1C4RcXahodPnJgeooRZRP9n5jR
         rhec8E1IGYW9EtCasxaFDVZ6qlzt/jzbcuOajph2c0h36gLR+32q3ZJ+k7SNyZtPvN
         TQZqVZWHqjM+5DujPcZXNHbEO1l3OmjdrD6XjbSqnC4sa4DCezKiv44xiAq3ut+14T
         fvnZ7uoJG6x4MjsVGVPTGWNPnngpfh/2oFlIpPGoT1KJEzilA2geBl7BDBEumVHulk
         2KwahNyBY3Mws8mjqmqjtIJqGAPmtYSQqtULC2VA9+0NUu0//BEORywuQBQxKy6g2H
         hQ52wrsEFwJcg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-501b9f27eb2so4396889e87.0;
        Fri, 08 Sep 2023 13:30:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YwbxY7909ZUx1uJzyO6JF8ghnBS0yUTrXxonG00Dsl3yHjOsxoc
        NgV1F0FxU+NDJ2Qfu2GarESKHlrC1QG4BUr+wzU=
X-Google-Smtp-Source: AGHT+IG84feGJ719OKNXJC70DM/+7y+vFk1L1QqAZu4eCHVvSr6aA0o2BbV+76w80o1f96Tt138l/0tn802rn29qPbA=
X-Received: by 2002:a05:6512:2033:b0:4fe:3724:fdb6 with SMTP id
 s19-20020a056512203300b004fe3724fdb6mr1014010lfs.30.1694205011415; Fri, 08
 Sep 2023 13:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230906084401.1027358-1-linan122@huawei.com> <e2befbc6-dfc4-f469-78f0-b648d0ad205d@huaweicloud.com>
In-Reply-To: <e2befbc6-dfc4-f469-78f0-b648d0ad205d@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Sep 2023 13:29:59 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4FjWohGYzWGocF+zxMcLRk7N3J8T45=QXzAmdqFFuNTA@mail.gmail.com>
Message-ID: <CAPhsuW4FjWohGYzWGocF+zxMcLRk7N3J8T45=QXzAmdqFFuNTA@mail.gmail.com>
Subject: Re: [PATCH] md: use interruptible apis in idle/frozen_sync_thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Li Nan <linan122@huawei.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 6, 2023 at 11:31=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> =E5=9C=A8 2023/09/06 16:44, Li Nan =E5=86=99=E9=81=93:
> > Before refactoring idle and frozen from action_store, interruptible api=
s
> > is used so that hungtask warning won't be triggered if it takes too lon=
g
> > to finish indle/frozen sync_thread. So change to use interruptible apis=
.
> >
> LGTM
>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
>
> > Signed-off-by: Li Nan <linan122@huawei.com>

I think we will need a fix tag and send this via md-fixes branch (to 6.6)?

Thanks,
Song



> > ---
> >   drivers/md/md.c | 13 +++++++++----
> >   1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 46badd13a687..52689adfa37f 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -4834,11 +4834,14 @@ static void idle_sync_thread(struct mddev *mdde=
v)
> >   {
> >       int sync_seq =3D atomic_read(&mddev->sync_seq);
> >
> > -     mutex_lock(&mddev->sync_mutex);
> > +     if (mutex_lock_interruptible(&mddev->sync_mutex))
> > +             return;
> > +
> >       clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >       stop_sync_thread(mddev);
> >
> > -     wait_event(resync_wait, sync_seq !=3D atomic_read(&mddev->sync_se=
q) ||
> > +     wait_event_interruptible(resync_wait,
> > +                     sync_seq !=3D atomic_read(&mddev->sync_seq) ||
> >                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))=
;
> >
> >       mutex_unlock(&mddev->sync_mutex);
> > @@ -4846,11 +4849,13 @@ static void idle_sync_thread(struct mddev *mdde=
v)
> >
> >   static void frozen_sync_thread(struct mddev *mddev)
> >   {
> > -     mutex_lock(&mddev->sync_mutex);
> > +     if (mutex_lock_interruptible(&mddev->sync_mutex))
> > +             return;
> > +
> >       set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
> >       stop_sync_thread(mddev);
> >
> > -     wait_event(resync_wait, mddev->sync_thread =3D=3D NULL &&
> > +     wait_event_interruptible(resync_wait, mddev->sync_thread =3D=3D N=
ULL &&
> >                       !test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))=
;
> >
> >       mutex_unlock(&mddev->sync_mutex);
> >
>
