Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBD79C2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbjILC2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjILC2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:28:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CBD130F84;
        Mon, 11 Sep 2023 18:52:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0C7C43142;
        Mon, 11 Sep 2023 21:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694468577;
        bh=Ag/MFnka3ZnPLSy5WMSn6IxdyE0vi9B+yEJg4mBMGTQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQ9lQUHBxXbrfTm2DxwmUvlWBAVisYCwnHt0bhq7nc+e/3BS1NWJAZ6WsSzclvhiL
         iNDZnkt2jzW0oBt8avx0G6n8puvL5S0/vXLMIzkGsmUpS7UlOTZfY60mgrXZghCdJg
         pUG3SNPdHHlCDWNm9gwqh9Z/z/D4xirKDsYt3l09ciDFlGfWEuPuKsmPeZPXxEATkZ
         t4cjSmVQzAHkWHfZfBbIp0vxZir0sNYEienYs8N3YtpFE67JNjjc4iF7lLrkWQap4p
         wLLt9ewzxxiBtMQvMqqVwNQnsaLz9ivDruVHuw0XHg9gJos2G4vfIXE3rtr17oYwQ6
         pwKPhMTsaUtQQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-501bd164fbfso8025490e87.0;
        Mon, 11 Sep 2023 14:42:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyGFwP50aUqdQgu7V0aq6CF0lMj1WLfCvuUWmW4+glBeLcOh05u
        HndRWRYPrWB3H/FhfC/9qFO2MRfsU2Y7C+lFeJo=
X-Google-Smtp-Source: AGHT+IFrCviCM3IpvjWVAqlwTRZ8SaJi9Q+Hl5L1DMRhKxrw7BsiVZTh/LdGvY6nPjYcRmSaWDwbNY/a2XY+OtzJMLw=
X-Received: by 2002:a05:6512:2026:b0:500:12c6:c91b with SMTP id
 s6-20020a056512202600b0050012c6c91bmr7662891lfs.40.1694468575702; Mon, 11 Sep
 2023 14:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <46d929d0-2aab-4cf2-b2bf-338963e8ba5a@redhat.com>
In-Reply-To: <46d929d0-2aab-4cf2-b2bf-338963e8ba5a@redhat.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 11 Sep 2023 14:42:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7zmj_+7cUocbi4bmLoJ8OR3m-expVixAY7E=GNcpyF1g@mail.gmail.com>
Message-ID: <CAPhsuW7zmj_+7cUocbi4bmLoJ8OR3m-expVixAY7E=GNcpyF1g@mail.gmail.com>
Subject: Re: [PATCH] raid1: fix error: ISO C90 forbids mixed declarations
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     yukuai1@huaweicloud.com, Zhang Shurong <zhang_shurong@foxmail.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 9, 2023 at 4:53=E2=80=AFAM Nigel Croxon <ncroxon@redhat.com> wr=
ote:
>
> There is a compile error when this commit is added:
> md: raid1: fix potential OOB in raid1_remove_disk()
>
> drivers/md/raid1.c: In function 'raid1_remove_disk':
> drivers/md/raid1.c:1844:9: error: ISO C90 forbids mixed declarations
> and code [-Werror=3Ddeclaration-after-statement]
> 1844 |         struct raid1_info *p =3D conf->mirrors + number;
>       |         ^~~~~~
>
> That's because the new code was inserted before the struct.
> The change is move the struct command above this commit.
>
> Fixes: md: raid1: fix potential OOB in raid1_remove_disk()
> commit 8b0472b50bcf
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>

Applied to md-fixes after some minor fixes.

Thanks,
Song

> ---
>   drivers/md/raid1.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index a5453b126aab..4f1483bb708b 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -1846,11 +1846,11 @@ static int raid1_remove_disk(struct mddev
> *mddev, struct md_rdev *rdev)
>       int err =3D 0;
>       int number =3D rdev->raid_disk;
>
> +    struct raid1_info *p =3D conf->mirrors + number;
> +
>       if (unlikely(number >=3D conf->raid_disks))
>           goto abort;
>
> -    struct raid1_info *p =3D conf->mirrors + number;
> -
>       if (rdev !=3D p->rdev)
>           p =3D conf->mirrors + conf->raid_disks + number;
>
> --
> 2.31.1
>
