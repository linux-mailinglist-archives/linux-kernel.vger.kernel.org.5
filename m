Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F0B784FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 07:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjHWF0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 01:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbjHWF0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 01:26:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFCEE54;
        Tue, 22 Aug 2023 22:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FAE761507;
        Wed, 23 Aug 2023 05:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7A1C433CB;
        Wed, 23 Aug 2023 05:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692768377;
        bh=BBwZpX/GgoL6l6P+HgxREh074ABE6q6co7ZigJJSIOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JcuEDjOuWMVrG7FQ3Xc00YUIU1/4CglEVneCb7SvnmaIvhgpACI9dz/B53dhdLh7J
         RKp4YBoTE6+Ad8HFDBNtFIxeQSafkGUVuPrVXC2d+Gzu+LwmRnuf88Of/eFRdH74L8
         gq6qmcWd09qNPv0qy7I1j+XNdxuPElNn9k1IL0r6CTRa94cYh3v1GOvaCW56AHPVZ5
         P5T/dV+GFX3eKTy3OYWGX7UJQQOH9fMhID8HG3WJ2au9Uk3BmDLizqIYFHs6rGUu86
         N+gDoZnSaxrN4Tccp6LaSEntZCJiiIFdgrXcvg/GRIFYiyq2bHBvKKTcNtpvRXzpVm
         oofP6o53nbS4g==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe11652b64so7989718e87.0;
        Tue, 22 Aug 2023 22:26:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YwTXXKKNYQbY/UbwyU192kxnS6QsOCmb9l8+DvgxD+F0nj6EwUS
        HOVEhCzDvD6dnEDgjKk7JqlKX/8IXdB3d5JB1jg=
X-Google-Smtp-Source: AGHT+IHmbsWO2ByPVoKPKaeVR8PpuAL7K8TN3cDSqRTEkeZrnzlZbwnNLGeNVZjkyssmCvYH/aoUtQh4oNz+EJLATEg=
X-Received: by 2002:a05:6512:477:b0:4ff:8f12:c4d7 with SMTP id
 x23-20020a056512047700b004ff8f12c4d7mr8673269lfd.31.1692768375519; Tue, 22
 Aug 2023 22:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-7-yukuai1@huaweicloud.com> <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
 <c7a82fb2-cf4b-2095-e813-84aed2418ff0@huaweicloud.com> <2766d001-f618-d224-f8a9-ec38ed1dc2a7@huaweicloud.com>
In-Reply-To: <2766d001-f618-d224-f8a9-ec38ed1dc2a7@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 22 Aug 2023 22:26:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6JQX7ujeO77NVTme8t0DvzVBrsXRHmayVnp4fwWoYhZg@mail.gmail.com>
Message-ID: <CAPhsuW6JQX7ujeO77NVTme8t0DvzVBrsXRHmayVnp4fwWoYhZg@mail.gmail.com>
Subject: Re: [PATCH -next v3 6/7] md: factor out a helper rdev_addable() from remove_and_add_spares()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
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

On Tue, Aug 22, 2023 at 8:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/08/22 10:17, Yu Kuai =E5=86=99=E9=81=93:
> > Hi,
> >
> > =E5=9C=A8 2023/08/22 7:22, Song Liu =E5=86=99=E9=81=93:
> >> On Sun, Aug 20, 2023 at 2:13=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>>
> >>> From: Yu Kuai <yukuai3@huawei.com>
> >>>
> >>> There are no functional changes, just to make the code simpler and
> >>> prepare to delay remove_and_add_spares() to md_start_sync().
> >>>
> >>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >>> ---
> >>>   drivers/md/md.c | 28 ++++++++++++++++------------
> >>>   1 file changed, 16 insertions(+), 12 deletions(-)
> >>>
> >>> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >>> index 11d27c934fdd..cdc361c521d4 100644
> >>> --- a/drivers/md/md.c
> >>> +++ b/drivers/md/md.c
> >>> @@ -9177,6 +9177,20 @@ static bool rdev_is_spare(struct md_rdev *rdev=
)
> >>>                 !test_bit(Faulty, &rdev->flags);
> >>>   }
> >>>
> >>> +static bool rdev_addable(struct md_rdev *rdev)
> >>> +{
> >>> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >=3D=
 0 ||
> >>> +           test_bit(Faulty, &rdev->flags))
> >>> +               return false;
> >>> +
> >>> +       if (!test_bit(Journal, &rdev->flags) &&
> >>> !md_is_rdwr(rdev->mddev) &&
> >>
> >> Instead of straightforward refactoring, I hope we can make these rdev_=
*
> >> helpers more meaningful, and hopefullly reusable. For example, let's
> >> define
> >> the meaning of "addable", and write the function to match that
> >> meaning. In
> >> this case, I think we shouldn't check md_is_rdwr() inside rdev_addable=
().
> >>
> >> Does this make sense?
> >
> > Yes, this make sense, rdev can be added to read-only array.
> >
> > There are total three callers of pers->hot_add_sisk, I'll try to find i=
f
> > they have common conditions.
>
> Unfortunately, the conditions is quite different, and It's difficult to
> factor out a common helper for them to use.
>
> In this case, !md_is_rdwr() is one of the four conditions, which means
> if the array is read-only, there is a special case that rdev can't be
> added to the configuration. Perhaps it's okay to keep this?

My main concern is that rdev_addable() is not making the code easier to
understand. We have a few different cases at this point:

1. rdev is not suitable for add (Faulty, raid_disk>=3D0, Candidate);
2. rdev is Journal;
3. Re-add rdev to RO array;
4. Non-re-add rdev to RO array;
5. Other cases.

Current rdev_addable() handles more or less all of this, which is
confusing. Maybe we can do something along similar to the
following (not tested). Does this look more clear?

Thanks,
Song

diff --git i/drivers/md/md.c w/drivers/md/md.c
index 78be7811a89f..8cb855d03e0a 100644
--- i/drivers/md/md.c
+++ w/drivers/md/md.c
@@ -9117,6 +9117,20 @@ void md_do_sync(struct md_thread *thread)
 }
 EXPORT_SYMBOL_GPL(md_do_sync);

+static bool rdev_addable(struct md_rdev *rdev)
+{
+       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >=3D 0 ||
+           test_bit(Faulty, &rdev->flags))
+               return false;
+       return true;
+}
+
+static bool rdev_is_readd(struct md_rdev *rdev)
+{
+       return rdev->saved_raid_disk >=3D 0 ||
+               !test_bit(Bitmap_sync, &rdev->flags);
+}
+
 static int remove_and_add_spares(struct mddev *mddev,
                                 struct md_rdev *this)
 {
@@ -9176,25 +9190,24 @@ static int remove_and_add_spares(struct mddev *mdde=
v,
        rdev_for_each(rdev, mddev) {
                if (this && this !=3D rdev)
                        continue;
-               if (test_bit(Candidate, &rdev->flags))
-                       continue;
                if (rdev->raid_disk >=3D 0 &&
                    !test_bit(In_sync, &rdev->flags) &&
                    !test_bit(Journal, &rdev->flags) &&
                    !test_bit(Faulty, &rdev->flags))
                        spares++;
-               if (rdev->raid_disk >=3D 0)
+
+               if (!rdev_addable(rdev))
                        continue;
-               if (test_bit(Faulty, &rdev->flags))
+
+               if (test_bit(Journal, &rdev->flags))
+                       goto hot_add_disk;
+
+               if (!md_is_rdwr(mddev) && !rdev_is_readd(rdev))
                        continue;
-               if (!test_bit(Journal, &rdev->flags)) {
-                       if (!md_is_rdwr(mddev) &&
-                           !(rdev->saved_raid_disk >=3D 0 &&
-                             !test_bit(Bitmap_sync, &rdev->flags)))
-                               continue;

-                       rdev->recovery_offset =3D 0;
-               }
+               rdev->recovery_offset =3D 0;
+
+       hot_add_disk:
                if (mddev->pers->hot_add_disk(mddev, rdev) =3D=3D 0) {
                        /* failure here is OK */
                        sysfs_link_rdev(mddev, rdev);
