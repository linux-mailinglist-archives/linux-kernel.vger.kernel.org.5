Return-Path: <linux-kernel+bounces-10853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB8A81DD68
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 02:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91341B2111D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 01:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778A87F2;
	Mon, 25 Dec 2023 01:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdlZYrpW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F16632;
	Mon, 25 Dec 2023 01:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB15C433C7;
	Mon, 25 Dec 2023 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703466675;
	bh=d4mJqlfdedbmYfVGJKIxN2wD9IVAoX/SkySuUqr/AJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qdlZYrpWaTELwpw49MScHs/wIDJXiu9ZF62GIymKoFFW5sszsUGthLBYO6NL7BoiR
	 VpgSjuAZYa51Y0EPsvnUl6pIU0Y8Qx6SpKZpZUrIzlnwY7OdcFuWEnzr3YEqyu+MJL
	 D2GnecJlg98XJH3oCw2t/lLWvH2bSsF037k0LVRHPrzvPbzc8QGll9Ds955Guj8tA0
	 kjGx62FhA5h1M6K0IzUdbRSoeWrH6AnDc0X8lNwiI06Q3lkJhZpDdnj50QWsdezaBr
	 89lUT5yqi0HVuMk6OF2z9TzzkeCFJhaY8A7mtoNOb1gwTJHH4Izpeqac3hhs8S1STL
	 lFBeukMByZvlg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e70b0b869so1336518e87.2;
        Sun, 24 Dec 2023 17:11:15 -0800 (PST)
X-Gm-Message-State: AOJu0Yyjk5euzlyegYxmb0Be3KKS4nDJ5WYtx55MQdXShBj6QG9hPJ+E
	sk/V6tXqXJig9MAMGSuBVxzB6huHeqixZ/atE/Q=
X-Google-Smtp-Source: AGHT+IHVsl0iBzxZ2kMCsZ+neddUqM0kEyuSRulhu5Y9UCTpNTSA83oMT4XLaIcChgsapUFjfAbaA6LbUkeDLkAo3Ys=
X-Received: by 2002:a05:6512:3c9d:b0:50e:74f4:d1e6 with SMTP id
 h29-20020a0565123c9d00b0050e74f4d1e6mr954423lfv.18.1703466673405; Sun, 24 Dec
 2023 17:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221071109.1562530-1-linan666@huaweicloud.com>
 <20231221071109.1562530-2-linan666@huaweicloud.com> <CAPhsuW5SPiy5bsSfagYrSLa3JTn2Gw0VJKUToS2PS9h4w2=zSA@mail.gmail.com>
 <d00e6729-6e13-b1ab-0991-ce79b1245cfd@huaweicloud.com>
In-Reply-To: <d00e6729-6e13-b1ab-0991-ce79b1245cfd@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Sun, 24 Dec 2023 17:11:02 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6CBdM=8kmZDwQ2Ko4rN3cAW6z0=LpAOc+_t--FJZO9KQ@mail.gmail.com>
Message-ID: <CAPhsuW6CBdM=8kmZDwQ2Ko4rN3cAW6z0=LpAOc+_t--FJZO9KQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] md: fix WARN_ON if create symlink fail in bind_rdev_to_array()
To: Li Nan <linan666@huaweicloud.com>
Cc: yukuai3@huawei.com, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, houtao1@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 5:17=E2=80=AFPM Li Nan <linan666@huaweicloud.com> w=
rote:
>
>
>
> =E5=9C=A8 2023/12/22 2:58, Song Liu =E5=86=99=E9=81=93:
[...]
> > In general, I would like to avoid adding flags if possible.
> >
>
> This flag is mainly used to fix deadlock in next patch. Or should we
> export bd_find_holder_disk()? Link hodler if it return NULL.
> just like:
>
>    rdev_for_each_rcu
>      if (!bd_find_holder_disk)
>        bd_link_disk_holder

I was thinking we will not need the flag if we fail bind_rdev_to_array()
on error (below).

>
>
> >>   };
> >>
> >>   static inline int is_badblock(struct md_rdev *rdev, sector_t s, int =
sectors,
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index e05858653a41..d6612b922c76 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -2526,7 +2526,8 @@ static int bind_rdev_to_array(struct md_rdev *rd=
ev, struct mddev *mddev)
> >>                  sysfs_get_dirent_safe(rdev->kobj.sd, "bad_blocks");
> >>
> >>          list_add_rcu(&rdev->same_set, &mddev->disks);
> >> -       bd_link_disk_holder(rdev->bdev, mddev->gendisk);
> >> +       if (!bd_link_disk_holder(rdev->bdev, mddev->gendisk))
> >> +               set_bit(SymlinkCreated, &rdev->flags);
> >
> > Shall we just fail bind_rdev_to_array() if bd_link_disk_holder()
> > returns non-zero?
> >
>
> I keep this action because of commit 00bcb4ac7ee7 ("md: reduce
> dependence on sysfs."). Fail bind_rdev_to_array is good to me.

I wonder whether the assumption in 00bcb4ac7ee7 is still true. If
bd_link_disk_holder() fails for valid reasons, we need to handle it
properly (set a flag, check the flag on unlink, etc.). If we only fail
bd_link_disk_holder() on extreme cases (ENOMEM, etc.), we can
just fail bind_rdev_to_array().

Thanks,
Song

