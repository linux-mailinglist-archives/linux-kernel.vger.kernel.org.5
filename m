Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323BB7AF862
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjI0DAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjI0C6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:58:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DD019781;
        Tue, 26 Sep 2023 17:15:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F719C433CA;
        Wed, 27 Sep 2023 00:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695773727;
        bh=Fsvg0F3lnuo5kK+BZq/zqgC2Z48DcX4ehDUq6zNzreo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sRu55kdVDEzBlTb4zAOUbXj0BTlPCL0Rrj94Us9wJKFyPwgdaEm3FixpHOuXhWqNo
         Fe+6mvKFcoNV+lDqqucRFOKmX3QYu42VTMaQtXCIbSKJPSY3/IWo80W2m1r9FQNcvi
         Jo00owrcTF2zURSaY459/yYcAmOUbPztZn1xFpiFFn9fESnSfqFUd/t57GyPKvUBmM
         p298XY8liHGtdKRFXBpcFwH9gZA+DKfKEDVR7PUHodtK9jMtdgiRa9x3trWV6ea1Bn
         utS/yV3glld7xMh4GKbWKi7sc87SV7uHZI8fN4lRyNlcuCi9gsAa5XZs8Bv4u7GIFP
         M747ozhHrvJGQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5046bf37ec1so6606642e87.1;
        Tue, 26 Sep 2023 17:15:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YwJHxK4i2TIAKBf9rBUpWSWwFo4WCnmyu+Pk97BfCKZY7VBcJZF
        4cvC9gpJlRsr0cl7n+5pe/Frt+R+iFoZsaO8/DY=
X-Google-Smtp-Source: AGHT+IFcLtBR93JZVmluOSkW5V/3fhryuI/xVKz9YCUlCelbPB+zXfpruHV7zhafNWKM1kRufSUbrXxg0JBgy1maNR0=
X-Received: by 2002:a05:6512:ac5:b0:503:3707:66ed with SMTP id
 n5-20020a0565120ac500b00503370766edmr340401lfu.34.1695773725474; Tue, 26 Sep
 2023 17:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230926025827.671407-1-yukuai1@huaweicloud.com> <20230926025827.671407-2-yukuai1@huaweicloud.com>
In-Reply-To: <20230926025827.671407-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 26 Sep 2023 17:15:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4dXrwt7VTifcdbdwH6Uz3b4m4Z54fBfD3LDjXy89PTkQ@mail.gmail.com>
Message-ID: <CAPhsuW4dXrwt7VTifcdbdwH6Uz3b4m4Z54fBfD3LDjXy89PTkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] md: factor out a new helper to put mddev
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     mariusz.tkaczyk@linux.intel.com, xni@redhat.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, Sep 25, 2023 at 8:04=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are no functional changes, the new helper will still hold
> 'all_mddevs_lock' after putting mddev, and it will be used to simplify
> md_seq_ops.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 10cb4dfbf4ae..a5ef6f7da8ec 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -616,10 +616,15 @@ static inline struct mddev *mddev_get(struct mddev =
*mddev)
>
>  static void mddev_delayed_delete(struct work_struct *ws);
>
> -void mddev_put(struct mddev *mddev)
> +static void __mddev_put(struct mddev *mddev, bool locked)
>  {
> -       if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
> +       if (locked) {
> +               spin_lock(&all_mddevs_lock);
> +               if (!atomic_dec_and_test(&mddev->active))
> +                       return;
> +       } else if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock)=
)
>                 return;
> +

This condition is indeed very confusing. No matter whether we call the
flag "locked" or "do_lock", it is not really accurate.

How about we factor out a helper with the following logic:

        if (!mddev->raid_disks && list_empty(&mddev->disks) &&
            mddev->ctime =3D=3D 0 && !mddev->hold_active) {
                /* Array is not configured at all, and not held active,
                 * so destroy it */
                set_bit(MD_DELETED, &mddev->flags);

                /*
                 * Call queue_work inside the spinlock so that
                 * flush_workqueue() after mddev_find will succeed in waiti=
ng
                 * for the work to be done.
                 */
                queue_work(md_misc_wq, &mddev->del_work);
        }

and then use it at the two callers?

Does this make sense?

Thanks,
Song
