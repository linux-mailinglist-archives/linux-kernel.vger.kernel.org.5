Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C260C7BEF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379009AbjJIXdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjJIXdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:33:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781D79E;
        Mon,  9 Oct 2023 16:33:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132A8C433C7;
        Mon,  9 Oct 2023 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696894416;
        bh=XjQLpSnKKBl6+0xF9NMa4bIa1sm/2ewlpC0N4jCimOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B3/Sd+/0rbIP/kuEe8ctsT36Q6YoxRJHI8kIx9Yt41lR/rQVuitEOGD2xWRhnXD/2
         RfcaOWnTGF+i8VqXIuBcYbPtcz+0bqdarbMFbaPU0BzPbfCSl4M727ymP8KUNpC7lN
         EcW0I4wfqx9eArZpbAhEEDZG5i6ETgRG5OB3HvS3Yt0rmtYeYGD/vjOktV/MalBNq+
         o1cOL4RM+elpHRx37c8jImwozWVPxPeGemOprKbHvZTrQ9P70RvoHhkg9edPI+C3Vw
         o9NbhREJkR3CwToGVpNBVlLSHGCjtiHpTJTkIOyXPyv79LDLKCIdupnMmKjYew+Ofw
         Ubj9bB7CItMUg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so6488183e87.2;
        Mon, 09 Oct 2023 16:33:35 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzh5emAI5kglN8RA3Y+9ohgRmBknmceQvooYDUQ+xVcndkcvR7M
        UelUGaSGQcDn80DTFdkOlainoiPT6HBdUmIlmB4=
X-Google-Smtp-Source: AGHT+IEe8UnWWmB8TjnYm6kXN3/n4gTehWA7M3N+LLdCj3vmBzJ2nj558NPt0sri4b6EqBcTNhACrt/vvi763Dg113M=
X-Received: by 2002:ac2:58cf:0:b0:502:b1b9:88c5 with SMTP id
 u15-20020ac258cf000000b00502b1b988c5mr12461478lfo.26.1696894414220; Mon, 09
 Oct 2023 16:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231007112105.407449-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231007112105.407449-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 9 Oct 2023 16:33:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Lv4SEJtVmH2AO1b0cNxErqazHH8Ew7jXt784rR59c8g@mail.gmail.com>
Message-ID: <CAPhsuW5Lv4SEJtVmH2AO1b0cNxErqazHH8Ew7jXt784rR59c8g@mail.gmail.com>
Subject: Re: [PATCH -next] md/raid1: don't split discard io for write behind
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Fri, Oct 6, 2023 at 8:24=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Currently, discad io is treated the same as normal write io, and for
> write behind case, io size is limited to:
>
> BIO_MAX_VECS * (PAGE_SIZE >> 9)
>
> For 0.5KB sector size and 4KB PAGE_SIZE, this is just 1MB. For
> consequence, if 'WriteMostly' is set to one of the underlying disks,
> then diskcard io will be splited into 1MB and it will take a long time
> for the diskcard to finish.
>
> Fix this problem by disable write behind for discard io.
>
> Reported-by: Roman Mamedov <rm@romanrm.net>
> Closes: https://lore.kernel.org/all/6a1165f7-c792-c054-b8f0-1ad4f7b8ae01@=
ultracoder.org/
> Reported-and-tested-by: Kirill Kirilenko <kirill@ultracoder.org>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-next. Thanks!

Song

> ---
>  drivers/md/raid1.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 3a78f79ee6d5..35d12948e0a9 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1345,6 +1345,7 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>         int first_clone;
>         int max_sectors;
>         bool write_behind =3D false;
> +       bool is_discard =3D (bio_op(bio) =3D=3D REQ_OP_DISCARD);
>
>         if (mddev_is_clustered(mddev) &&
>              md_cluster_ops->area_resyncing(mddev, WRITE,
> @@ -1405,7 +1406,7 @@ static void raid1_write_request(struct mddev *mddev=
, struct bio *bio,
>                  * write-mostly, which means we could allocate write behi=
nd
>                  * bio later.
>                  */
> -               if (rdev && test_bit(WriteMostly, &rdev->flags))
> +               if (!is_discard && rdev && test_bit(WriteMostly, &rdev->f=
lags))
>                         write_behind =3D true;
>
>                 if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
> --
> 2.39.2
>
