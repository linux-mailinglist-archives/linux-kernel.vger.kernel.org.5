Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE3780031
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355445AbjHQVyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355441AbjHQVxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6E26A5;
        Thu, 17 Aug 2023 14:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 741D764EBE;
        Thu, 17 Aug 2023 21:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8AEC433C7;
        Thu, 17 Aug 2023 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692309228;
        bh=PIkPtcVuTQ4fow5tuKu+Z1UsUidKJ3VdnJ65htCV/LM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fxvroAxGXA6y4sooGpWKcJfOmYpfqKB4GL+vD+AqMtK65bphykV533DnKVM4LkFSf
         lLqs9Qn379KSCiWcPJNEAiMT0ksXYeBQUZU9JjhaBgjW/72don9oOKDatyb6Q3efTB
         k6JrcccuMUj2TZFlm+Hj8Igu0EIyPO1DoUn0Hmtk5e35OC05D4UuU27Eg1/Bgxzdy1
         wbW7CRJe48MOFHF9pnuxKd2JRgGGFGOOlNu2QOOad9u1AflVZKUpYA4+HRv99fQ4qQ
         Vm3j3UlvIELiXS0IE9BLYgHP9RyzQZe2vgxqieCsORDE6dnHZguLDOMeplRDznqs7c
         o0cHC+lkhwFXQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe85fd3d27so337235e87.0;
        Thu, 17 Aug 2023 14:53:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtchG1saE1m+NIBBTmXn7D1jtXzXKSHFi5DBUOfenqlMRnXwi1
        SNuQdzPurVyj30fypphteZ6ESlC8yZBV7W2qkso=
X-Google-Smtp-Source: AGHT+IFVppjEdzaJSuap4dY9p5XayMzYRDmhzLSVtEMwi3dFNgOYhSJHVgW6PF6u7sZiuE8ujqsKgTb9xEtfcOHcRNY=
X-Received: by 2002:a05:6512:2520:b0:4fb:889c:c53d with SMTP id
 be32-20020a056512252000b004fb889cc53dmr376761lfb.10.1692309226819; Thu, 17
 Aug 2023 14:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-4-yukuai1@huaweicloud.com> <bb11d6ca-978a-8e1d-e721-d9d84c9dc5e3@huaweicloud.com>
 <CAPhsuW65Hxq=+D6M6zV8n+k4FarTHui=pSs2YPNKs9MYBD4MHA@mail.gmail.com> <bd0a6f0f-2766-deb9-bbfd-5310d3f18e12@huaweicloud.com>
In-Reply-To: <bd0a6f0f-2766-deb9-bbfd-5310d3f18e12@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 17 Aug 2023 14:53:34 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5a6+x6k3x6jvz7L5oVbHCd-EdmfXc4E4v5i0kCs6WPkw@mail.gmail.com>
Message-ID: <CAPhsuW5a6+x6k3x6jvz7L5oVbHCd-EdmfXc4E4v5i0kCs6WPkw@mail.gmail.com>
Subject: Re: [PATCH -next v2 3/7] md: delay choosing sync direction to md_start_sync()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 6:07=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/08/15 23:54, Song Liu =E5=86=99=E9=81=93:
> > On Tue, Aug 15, 2023 at 2:00=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> > [...]
> >>> +
> >>> +not_running:
> >>> +     clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> >>> +     clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> >>> +     clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> >>> +     clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> >>> +     clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> >>> +     mddev_unlock(mddev);
> >>> +
> >>> +     wake_up(&resync_wait);
> >>> +     if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &=
&
> >>> +         mddev->sysfs_action)
> >>> +             sysfs_notify_dirent_safe(mddev->sysfs_action);
> >>>    }
> >>>
> >>>    /*
> >>> @@ -9379,7 +9402,6 @@ void md_check_recovery(struct mddev *mddev)
> >>>                return;
> >>>
> >>>        if (mddev_trylock(mddev)) {
> >>> -             int spares =3D 0;
> >>>                bool try_set_sync =3D mddev->safemode !=3D 0;
> >>>
> >>>                if (!mddev->external && mddev->safemode =3D=3D 1)
> >>> @@ -9467,29 +9489,11 @@ void md_check_recovery(struct mddev *mddev)
> >>>                clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
> >>>
> >>>                if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->re=
covery) ||
> >>> -                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
> >>> -                     goto not_running;
> >>> -             if (!md_choose_sync_direction(mddev, &spares))
> >>> -                     goto not_running;
> >>> -             if (mddev->pers->sync_request) {
> >>> -                     if (spares) {
> >>> -                             /* We are adding a device or devices to=
 an array
> >>> -                              * which has the bitmap stored on all d=
evices.
> >>> -                              * So make sure all bitmap pages get wr=
itten
> >>> -                              */
> >>> -                             md_bitmap_write_all(mddev->bitmap);
> >>> -                     }
> >>> +                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> >>
> >> Sorry that I made a mistake here while rebasing v2, here should be
> >>
> >> !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)
> >>
> >> With this fixed, there are no new regression for mdadm tests using loo=
p
> >> devicein my VM.
> >
> >                  if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->re=
covery) ||
> >                      !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> >                          queue_work(md_misc_wq, &mddev->sync_work);
> >                  } else {
> >
> > This doesn't look right. Should we do
> >
> >                  if (test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->rec=
overy) &&
> >                      !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
> >                          queue_work(md_misc_wq, &mddev->sync_work);
> >                  } else {
> >
> > instead?
> >
>
> Yes you're right, this is exactly what I did in v1, sorry that I keep
> making mistake while rebasing.

Please fix this, address comments from other reviews, and resend the
patches. Also, there are some typos in the commit logs, please also fix the=
m.

Unfortunately, we won't ship this (and the two other big sets) in 6.6.

Thanks,
Song
