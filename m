Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C07A7990F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242392AbjIHUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjIHUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:22:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671C98E;
        Fri,  8 Sep 2023 13:22:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E88C433C7;
        Fri,  8 Sep 2023 20:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694204553;
        bh=e16P9xW9C+d4tSLnP+okZqHGPvQNrZo/ehkhKcvH+1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k+d8zrVmlgo5BbTvTUjz9ywe8/kX7mPycN4GcRjnwV3INi3SlFARanzsrBobH49zq
         wfHa+jF6/wSOwiMBi8B1eXTBhsfEzFlXrjX2c0Hvt22LF3sBGIh+H/cHwyFItCj3Dj
         YC/KPBUoe32fxkizDfL6TOjfhYimARZG/Uj1mXZKici1ATEuJKIWacX/wd8L7GdA6E
         mx3vOtZvm2l5jhvw5cpRv/f7OI2cKouP+WI7z9qFoi6Vp25/dLKq970n6JdjdMmrWK
         ZBBtRYZbI3m7nxcfyIfa+QqYpyHz+vqProWJlD2kSAq+K1rJ+bmqPRXyxgnRx61jrT
         rAnQlE5bkEx7g==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-502a7e1bdc7so263531e87.0;
        Fri, 08 Sep 2023 13:22:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YyBSwgKroRWAVW3Uo3OgrEP44Tq6ts/7boAXFl2B5aomduHvK1q
        0L1F7CdxEBZ+92RVi9CGEwRo+YMpts6fwYmTtro=
X-Google-Smtp-Source: AGHT+IGSdkZj1l/XvKWToISgZ9w4muU6hYTmhbPfDa3yJQt+XxcvxldKyDqHZy3mN+070us8dp/tNoKXhAZ9WfPxBpY=
X-Received: by 2002:a05:6512:788:b0:4fb:9e1a:e592 with SMTP id
 x8-20020a056512078800b004fb9e1ae592mr2478517lfr.4.1694204552130; Fri, 08 Sep
 2023 13:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com> <bd46efce-07ee-4cb3-a5d0-f133a1e79fd9@redhat.com>
In-Reply-To: <bd46efce-07ee-4cb3-a5d0-f133a1e79fd9@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Sep 2023 13:22:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7FOt7FJ_01i5NgaEoNRG7URAcNdAb=sKVxiMpdK_QfsQ@mail.gmail.com>
Message-ID: <CAPhsuW7FOt7FJ_01i5NgaEoNRG7URAcNdAb=sKVxiMpdK_QfsQ@mail.gmail.com>
Subject: Re: [PATCH v2] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>, yukuai1@huaweicloud.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
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

On Fri, Sep 8, 2023 at 6:48=E2=80=AFAM Nigel Croxon <ncroxon@redhat.com> wr=
ote:
>
>
> On 7/22/23 3:53 AM, Zhang Shurong wrote:
>
> If rddev->raid_disk is greater than mddev->raid_disks, there will be
> an out-of-bounds in raid1_remove_disk(). We have already found
> similar reports as follows:
>
> 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_disk"=
)
>
> Fix this bug by checking whether the "number" variable is
> valid.
>
> Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> ---
> Changes in v2:
>  - Using conf->raid_disks instead of mddev->raid_disks.
>
>  drivers/md/raid1.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index dd25832eb045..80aeee63dfb7 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev, =
struct md_rdev *rdev)
>   struct r1conf *conf =3D mddev->private;
>   int err =3D 0;
>   int number =3D rdev->raid_disk;
> +
> + if (unlikely(number >=3D conf->raid_disks))
> + goto abort;
> +
>   struct raid1_info *p =3D conf->mirrors + number;
>
>   if (rdev !=3D p->rdev)
>
> When compiling this patch.. I get the following error
>
> drivers/md/raid1.c: In function 'raid1_remove_disk':
> drivers/md/raid1.c:1844:9: error: ISO C90 forbids mixed declarations and =
code [-Werror=3Ddeclaration-after-statement]
>  1844 |         struct raid1_info *p =3D conf->mirrors + number;
>       |         ^~~~~~
>
> And that's because the new code was inserted before the struct.
> Here is a fix:
>
>     raid1: fix error: ISO C90 forbids mixed declarations
>
>     There is a compile error when commit is added:
>     md: raid1: fix potential OOB in raid1_remove_disk()
>
>     drivers/md/raid1.c: In function 'raid1_remove_disk':
>     drivers/md/raid1.c:1844:9: error: ISO C90 forbids mixed declarations
>     and code [-Werror=3Ddeclaration-after-statement]
>      1844 |         struct raid1_info *p =3D conf->mirrors + number;
>           |         ^~~~~~
>
>     And that's because the new code was inserted before the struct.
>     The change is move the struct command above the new commit.
>
>     Fixes: md: raid1: fix potential OOB in raid1_remove_disk()
>     commit 8b0472b50bcf
>
>     Signed-off-by: Nigel Croxon <ncroxon@redhat.com>

Thanks for catching this! Would you mind sending an official patch for it?

Song

>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a5453b126aab..4f1483bb708b 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1846,11 +1846,11 @@ static int raid1_remove_disk(struct mddev *mddev,=
 struct md_rdev *rdev)
>         int err =3D 0;
>         int number =3D rdev->raid_disk;
>
> +       struct raid1_info *p =3D conf->mirrors + number;
> +
>         if (unlikely(number >=3D conf->raid_disks))
>                 goto abort;
>
> -       struct raid1_info *p =3D conf->mirrors + number;
> -
>         if (rdev !=3D p->rdev)
>                 p =3D conf->mirrors + conf->raid_disks + number;
>
>
