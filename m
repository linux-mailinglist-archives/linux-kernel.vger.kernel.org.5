Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB217ABB3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjIVVxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIVVxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 17:53:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC1FCA;
        Fri, 22 Sep 2023 14:53:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7D6C433C7;
        Fri, 22 Sep 2023 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695419626;
        bh=N3Dz+vxCmsz2/Y3Z5iSJBrL8PYLkn2PrfmVPk92gy9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z1jNOx1vPMrYz+6RETg78xQz51AFZcjpvo/xLWu6riRNWX/v+S3V6ZSvRP2EWmdYB
         KdaEZO40Mr8bMLpX2+M8kwfwS2XS5QaRnwoTqUieqXCpnJQLlKuPYpxezeYYEpojO6
         zYR/cuFqw3h1o9agttqYhTb3iXVznR7wZ3orfNz/FitXS5wm9pgU5lSxkeej4AoqJ7
         7UVrt60v7ryEsnAtR72WMsxG9e7DVE8fYw8baebCGPQqsWCk/vxX76zImqRIZLYBgo
         CfJSujRHg+Kzxy2nZ7g4RjggZjNv3IAJ/U/4r/ZK0mtWdpUoPiWG8ST9I/zoetP1ys
         R2VApQeVkSCCw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so4619812e87.1;
        Fri, 22 Sep 2023 14:53:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YxCdkR7WcMxYPkvh2M+KhLTj04RZI/Jn5AElordIu1z0nO0eZoA
        zOnSSF455dPCXqSyer0724gtobawhVeRCRuYa4M=
X-Google-Smtp-Source: AGHT+IE22tb6NDZhf8tsSCgX1RkcEii4xfJbpgNtZAHGFG7uB7OQt0BkdV2ZcEIx+5HrnU4r7EjJiN+2uqlPDKb2tvc=
X-Received: by 2002:a19:6710:0:b0:503:95d:f2bd with SMTP id
 b16-20020a196710000000b00503095df2bdmr552070lfc.34.1695419624892; Fri, 22 Sep
 2023 14:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230906093720.1070929-1-linan122@huawei.com> <e67775c0-2d41-5541-a644-e5239ada3333@huaweicloud.com>
 <CAPhsuW5+Qxa4SKoaFrqZWKDmLaR0arXV7vqDX-Hy_OCEjmtA1w@mail.gmail.com> <5e08c3aa-7bd5-f5dd-3d38-b93fb772ea56@huaweicloud.com>
In-Reply-To: <5e08c3aa-7bd5-f5dd-3d38-b93fb772ea56@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 22 Sep 2023 14:53:32 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4pP5yJGJyfA67754Y-5GOABrUmNRb9FK75=Jfa=zBGMQ@mail.gmail.com>
Message-ID: <CAPhsuW4pP5yJGJyfA67754Y-5GOABrUmNRb9FK75=Jfa=zBGMQ@mail.gmail.com>
Subject: Re: [PATCH] md/raid1: only update stack limits with the device in use
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

On Sat, Sep 9, 2023 at 7:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2023/09/09 4:42, Song Liu =E5=86=99=E9=81=93:
> > On Wed, Sep 6, 2023 at 11:30=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/09/06 17:37, Li Nan =E5=86=99=E9=81=93:
> >>> Spare device affects array stack limits is unreasonable. For example,
> >>> create a raid1 with two 512 byte devices, the logical_block_size of a=
rray
> >>> will be 512. But after add a 4k devcie as spare, logical_block_size o=
f
> >>> array will change as follows.
> >>>
> >>>     mdadm -C /dev/md0 -n 2 -l 10 /dev/sd[ab]   //sd[ab] is 512
> >>>     //logical_block_size of md0: 512
> >>>
> >>>     mdadm --add /dev/md0 /dev/sdc                      //sdc is 4k
> >>>     //logical_block_size of md0: 512
> >>>
> >>>     mdadm -S /dev/md0
> >>>     mdadm -A /dev/md0 /dev/sd[ab]
> >>>     //logical_block_size of md0: 4k
> >>>
> >>> This will confuse users, as nothing has been changed, why did the
> >>> logical_block_size of array change?
> >>>
> >>> Now, only update logical_block_size of array with the device in use.
> >>>
> >>> Signed-off-by: Li Nan <linan122@huawei.com>
> >>> ---
> >>>    drivers/md/raid1.c | 19 ++++++++-----------
> >>>    1 file changed, 8 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> >>> index 95504612b7e2..d75c5dd89e86 100644
> >>> --- a/drivers/md/raid1.c
> >>> +++ b/drivers/md/raid1.c
> >>> @@ -3140,19 +3140,16 @@ static int raid1_run(struct mddev *mddev)
> >>
> >> I'm not sure about this behaviour, 'logical_block_size' can be
> >> increased while adding new underlying disk, the key point is not when
> >> to increase 'logical_block_size'. If there is a mounted fs, or
> >> partition in the array, I think the array will be corrupted.
> >
> > How common is such fs/partition corruption? I think some fs and partiti=
on
> > table can work properly with 512=3D>4096 change?
>
> For fs, that should depend on fs bs that is usually set in mkfs, if bs
> is less than 4096, then such fs can't be mounted.
>
> For partition, that is much worse, start sector and end sector will stay
> the same, while sector size is changed. And 4096 -> 512 change is the
> same.

Thanks for this information.

> >>
> >> Perhaps once that array is started, logical_block_size should not be
> >> changed anymore, this will require 'logical_block_size' to be metadate
> >> inside raid superblock. And the array should deny any new disk with
> >> bigger logical_block_size.

I really hope we can avoid adding this to the raid superblock. But I am not
sure what would be a better solution (that is also backward compatible).
Do we have real world reports of such issues?

Thanks,
Song
