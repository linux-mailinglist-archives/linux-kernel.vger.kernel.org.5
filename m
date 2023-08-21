Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5E6783631
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjHUXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHUXWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF710E;
        Mon, 21 Aug 2023 16:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35EDC6310B;
        Mon, 21 Aug 2023 23:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DE9C433CA;
        Mon, 21 Aug 2023 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692660165;
        bh=BarXtWf8LLGfZYp+dfsYDTkiHtsu62fLTsmmUhGyBvc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s3qkdvWscoZrkbateydQOyws0J3McBDSuOG/1D6jNCspNKEjyTvOiA5P9mHlPer6R
         UJwttaC9autU6r9uBsmtRf8cp11LZM9oxBDJdI6QP1B4dJUBYjQQgENu3eE2tAS+vL
         bNEuv8wA25Da8zREP3OIT9rAbPXqnwjX7Ns04iqCww1JbJfn5QDYjMm0C2Lb7SsYGE
         ciduDgE2Agf6/URVxWlSMBykt9Sz/QyacyvT004zzKct6+zwWyQ6jFTP7mNvtYg1yZ
         +rLa9oiW0F8gb0N+o863e5fWySj8NFGl/Qk3QKGUq5eFs+uUI2qi8e+n/Am2MdOBdH
         kuXtUDJI/nTDw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe2d152f62so5958144e87.0;
        Mon, 21 Aug 2023 16:22:45 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy9rkMTX3PdqSg9+zjMQwy02tNoyEzSdpKbEPxr6PxZhjQsNewT
        8LNQXQZD0557aB1QgUj4F5Jo1HBUmXoI9dUAMzA=
X-Google-Smtp-Source: AGHT+IGyACduf5O3k20YR2XVhRVSxkHhqIq/9qUvLg7O1cESm2tUz0N7N/jnmmeEZU6uufOIx3sFektG/Xv9Jk4oALU=
X-Received: by 2002:a05:6512:3ca2:b0:500:8257:4b34 with SMTP id
 h34-20020a0565123ca200b0050082574b34mr3093531lfv.68.1692660163515; Mon, 21
 Aug 2023 16:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com> <20230820090949.2874537-7-yukuai1@huaweicloud.com>
In-Reply-To: <20230820090949.2874537-7-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Aug 2023 16:22:31 -0700
X-Gmail-Original-Message-ID: <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
Message-ID: <CAPhsuW74MEFjNTNErYfOT1gX+BUdbDwaV1oTmmcz=_76Ym3ZuA@mail.gmail.com>
Subject: Re: [PATCH -next v3 6/7] md: factor out a helper rdev_addable() from remove_and_add_spares()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, mariusz.tkaczyk@linux.intel.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Sun, Aug 20, 2023 at 2:13=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are no functional changes, just to make the code simpler and
> prepare to delay remove_and_add_spares() to md_start_sync().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 11d27c934fdd..cdc361c521d4 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9177,6 +9177,20 @@ static bool rdev_is_spare(struct md_rdev *rdev)
>                !test_bit(Faulty, &rdev->flags);
>  }
>
> +static bool rdev_addable(struct md_rdev *rdev)
> +{
> +       if (test_bit(Candidate, &rdev->flags) || rdev->raid_disk >=3D 0 |=
|
> +           test_bit(Faulty, &rdev->flags))
> +               return false;
> +
> +       if (!test_bit(Journal, &rdev->flags) && !md_is_rdwr(rdev->mddev) =
&&

Instead of straightforward refactoring, I hope we can make these rdev_*
helpers more meaningful, and hopefullly reusable. For example, let's define
the meaning of "addable", and write the function to match that meaning. In
this case, I think we shouldn't check md_is_rdwr() inside rdev_addable().

Does this make sense?

Thanks,
Song


> +           !(rdev->saved_raid_disk >=3D 0 &&
> +             !test_bit(Bitmap_sync, &rdev->flags)))
> +               return false;
> +
> +       return true;
> +}
> +
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this)
>  {
> @@ -9227,20 +9241,10 @@ static int remove_and_add_spares(struct mddev *md=
dev,
>                         continue;
>                 if (rdev_is_spare(rdev))
>                         spares++;
> -               if (test_bit(Candidate, &rdev->flags))
> +               if (!rdev_addable(rdev))
>                         continue;
> -               if (rdev->raid_disk >=3D 0)
> -                       continue;
> -               if (test_bit(Faulty, &rdev->flags))
> -                       continue;
> -               if (!test_bit(Journal, &rdev->flags)) {
> -                       if (!md_is_rdwr(mddev) &&
> -                           !(rdev->saved_raid_disk >=3D 0 &&
> -                             !test_bit(Bitmap_sync, &rdev->flags)))
> -                               continue;
> -
> +               if (!test_bit(Journal, &rdev->flags))
>                         rdev->recovery_offset =3D 0;
> -               }
>                 if (mddev->pers->hot_add_disk(mddev, rdev) =3D=3D 0) {
>                         /* failure here is OK */
>                         sysfs_link_rdev(mddev, rdev);
> --
> 2.39.2
>
