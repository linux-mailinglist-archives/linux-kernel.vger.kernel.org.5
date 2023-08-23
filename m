Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E9784EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 04:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjHWC3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 22:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjHWC3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F19FFB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692757741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PHoyPB6fdwlZo0rv+RRNeP2XexnPFlJevWCB+hETQnY=;
        b=W3C/BrmbXXozM9Eriz26YsD2kKbdMdNh7xPgMXbf7Vso542t62vv6XfM/w8H39cFN/adeH
        E0MGDa2qQEQ8KHoLpd2UYFOZOBBoYVjrQczU/5OobkIm3Dy4+6cIDctAbo/K6qj2vU4K1c
        eZG6FeiblQ9WnKK8r3mBpRRVoXZPeGY=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-5rKAEW1VM7SmaVkCm9bstA-1; Tue, 22 Aug 2023 22:29:00 -0400
X-MC-Unique: 5rKAEW1VM7SmaVkCm9bstA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-68a3d6ce18cso4117139b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 19:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692757739; x=1693362539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHoyPB6fdwlZo0rv+RRNeP2XexnPFlJevWCB+hETQnY=;
        b=RPLwcI5PXBOJetLZ/BjSgQhlOV+qtMobPbArn/j/5czShp4UlJznP+LEsnG4U+cD0E
         Fbl/TXha5++DUeKHyPgJH5NOymYLZER0k5O3F784t5pGNnOo51pPRV1FLORceHpffypN
         EyKeW3h2enIL1egBd/f79EY1PrjvVuyjjpGTfdyM3p6K+QWddQbOd8J8AnjMum8eA+1F
         ZsoaUVCE/ESum6G7moWczpsCi5yYC4Whg+llaMUTclherPQ/etdIjV/8kYZvKufQfzFi
         HoZYRXttwEV6YM7GKEgkrfS+jvvJ3JuM+lTVfK2Zgb4lQC+acmqBDQfvHYGrZe2AHM8e
         j6PA==
X-Gm-Message-State: AOJu0Yw6x9E9VvtZ5cvG0WjDD/1vim6wHZxUKX3/kJCqK0qPEj81tdUk
        Y5/n+iVNVyYi53KmmgxRQ4SlbnS41VMFmAnMaColL8bi27WIhRkFZPlabD5sXpvsWwE8/gv9kBO
        xvRRfiwaIMldUxYsO0u+N6Ay3ubjv7Ct+bwNkbF7MDe4qJ2XpObBSeQ==
X-Received: by 2002:a05:6a00:4692:b0:68a:2260:c84d with SMTP id de18-20020a056a00469200b0068a2260c84dmr13308988pfb.10.1692757739317;
        Tue, 22 Aug 2023 19:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGudGZREZyEnBHgQfHNztSMsv0KUVLA8pexCc2cTkPyY7n3tBTy4gUCac65Dd08oLW1olPBKRFnR8vUNwTWR48=
X-Received: by 2002:a05:6a00:4692:b0:68a:2260:c84d with SMTP id
 de18-20020a056a00469200b0068a2260c84dmr13308977pfb.10.1692757739026; Tue, 22
 Aug 2023 19:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com>
 <20230820090949.2874537-6-yukuai1@huaweicloud.com> <CALTww28fa_LUVfzswTmpascZEYr-PdyjgoU88A+H9Q7CP04VXA@mail.gmail.com>
In-Reply-To: <CALTww28fa_LUVfzswTmpascZEYr-PdyjgoU88A+H9Q7CP04VXA@mail.gmail.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Wed, 23 Aug 2023 10:28:48 +0800
Message-ID: <CALTww2-gdFHh4j+_bwuT2fX_OHMFfra3p34PM4rNZv0OCqPKcw@mail.gmail.com>
Subject: Re: [PATCH -next v3 5/7] md: factor out a helper rdev_is_spare() from remove_and_add_spares()
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

On Wed, Aug 23, 2023 at 10:20=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
>
> On Sun, Aug 20, 2023 at 5:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com>=
 wrote:
> >
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > There are no functional changes, just to make the code simpler and
> > prepare to delay remove_and_add_spares() to md_start_sync().
> >
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> > ---
> >  drivers/md/md.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index ceace5ffadd6..11d27c934fdd 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -9169,6 +9169,14 @@ static bool rdev_removeable(struct md_rdev *rdev=
)
> >         return true;
> >  }
> >
> > +static bool rdev_is_spare(struct md_rdev *rdev)
> > +{
> > +       return !test_bit(Candidate, &rdev->flags) && rdev->raid_disk >=
=3D 0 &&
> > +              !test_bit(In_sync, &rdev->flags) &&
> > +              !test_bit(Journal, &rdev->flags) &&
> > +              !test_bit(Faulty, &rdev->flags);
> > +}
> > +
> >  static int remove_and_add_spares(struct mddev *mddev,
> >                                  struct md_rdev *this)
> >  {
> > @@ -9217,13 +9225,10 @@ static int remove_and_add_spares(struct mddev *=
mddev,
> >         rdev_for_each(rdev, mddev) {
> >                 if (this && this !=3D rdev)
> >                         continue;
> > +               if (rdev_is_spare(rdev))
> > +                       spares++;
> >                 if (test_bit(Candidate, &rdev->flags))
> >                         continue;
>
> Hi Kuai
>
> Why not put rdev_is_spare after testing Candidate?
>
> Best Regards
> Xiao

I know the answer now, Because the next patch wants to put codes into
the function rdev_addable
>
> > -               if (rdev->raid_disk >=3D 0 &&
> > -                   !test_bit(In_sync, &rdev->flags) &&
> > -                   !test_bit(Journal, &rdev->flags) &&
> > -                   !test_bit(Faulty, &rdev->flags))
> > -                       spares++;
> >                 if (rdev->raid_disk >=3D 0)
> >                         continue;
> >                 if (test_bit(Faulty, &rdev->flags))
> > --
> > 2.39.2
> >

Reviewed-by: Xiao Ni <xni@redhat.com>

