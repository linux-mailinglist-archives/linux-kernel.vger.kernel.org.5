Return-Path: <linux-kernel+bounces-8964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58A581BE93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4699C28546F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C54C651A3;
	Thu, 21 Dec 2023 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ner+DC5e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333965189;
	Thu, 21 Dec 2023 18:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3848FC433C7;
	Thu, 21 Dec 2023 18:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703185131;
	bh=j6UCPuNDbZ6kPS/Mzu96W0KCWZA5ifSOq9ApMbEEPhk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ner+DC5eOIxk+8hI74FeKIYb33YzoZOqH63n+C7KUxp0dezkbY/FyRe/z2No9XwEH
	 8mMSUijdeFHSAwX1n/HVn32XtFzxyQoxaY2dM13Co9gZS/IWnU4e/Hm7oeRWJ0fPEW
	 egWGBagN40prKCnYrun+v1XlnbghjkUbcx+GX+sbpSvxcs6McDl6QGFoanj3ZH8nuq
	 iWwj16okuEM4p2eSmJXm7FP8y2/UfNEC06R5UunQnvNZTqeEUmD5nc5ukscEKX/lZB
	 XOwU7vEktaVjFJRc9KFpImXCbJ65hzXVIPYe++ZF013SLnfdXut6tqRni7PhYgqeBv
	 SjgwXu86RJMhQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e281b149aso1399785e87.1;
        Thu, 21 Dec 2023 10:58:51 -0800 (PST)
X-Gm-Message-State: AOJu0YxMxhHgCaMlPEYS/56UG8iIV24+0Wt/lmOVLOgWAa05uxmG+DD1
	8Dzq8/RLvwlB7Y2iVlMg2V/up1iQdXUU5fBREmU=
X-Google-Smtp-Source: AGHT+IHePdvbMPNoNvP2Q+0znrhupUMEPxDIRt83N3i7rXk96XMCtaLGg61OHN2n/BF4oYf87sGgu00lh+ClKfiWx18=
X-Received: by 2002:a05:6512:210b:b0:50e:277a:5f79 with SMTP id
 q11-20020a056512210b00b0050e277a5f79mr38949lfr.128.1703185129418; Thu, 21 Dec
 2023 10:58:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221071109.1562530-1-linan666@huaweicloud.com> <20231221071109.1562530-2-linan666@huaweicloud.com>
In-Reply-To: <20231221071109.1562530-2-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Thu, 21 Dec 2023 10:58:38 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5SPiy5bsSfagYrSLa3JTn2Gw0VJKUToS2PS9h4w2=zSA@mail.gmail.com>
Message-ID: <CAPhsuW5SPiy5bsSfagYrSLa3JTn2Gw0VJKUToS2PS9h4w2=zSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] md: fix WARN_ON if create symlink fail in bind_rdev_to_array()
To: linan666@huaweicloud.com
Cc: yukuai3@huawei.com, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 20, 2023 at 11:13=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Removing a device can trigger WARN_ON in bd_unlink_disk_holder() if creat=
ing
> symlink failed while adding device.
>
>   WARNING: CPU: 0 PID: 742 at block/holder.c:145 bd_unlink_disk_holder+0x=
17b/0x1a0
>
> Fix it by adding the flag 'SymlinkCreated', which only be set after
> creating symlink success.
>
> Signed-off-by: Li Nan <linan122@huawei.com>
> ---
>  drivers/md/md.h | 3 +++
>  drivers/md/md.c | 8 ++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 8d881cc59799..427d17713a8c 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -207,6 +207,9 @@ enum flag_bits {
>                                  * check if there is collision between ra=
id1
>                                  * serial bios.
>                                  */
> +       SymlinkCreated,         /* This device has created the symlink
> +                                * with gendisk.
> +                                */

In general, I would like to avoid adding flags if possible.

>  };
>
>  static inline int is_badblock(struct md_rdev *rdev, sector_t s, int sect=
ors,
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e05858653a41..d6612b922c76 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -2526,7 +2526,8 @@ static int bind_rdev_to_array(struct md_rdev *rdev,=
 struct mddev *mddev)
>                 sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
>
>         list_add_rcu(&rdev->same_set, &mddev->disks);
> -       bd_link_disk_holder(rdev->bdev, mddev->gendisk);
> +       if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
> +               set_bit(SymlinkCreated, &rdev->flags);

Shall we just fail bind_rdev_to_array() if bd_link_disk_holder()
returns non-zero?

Thanks,
Song

