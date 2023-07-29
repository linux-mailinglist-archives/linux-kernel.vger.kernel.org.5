Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05939767E51
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjG2KuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjG2KuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDB7D1;
        Sat, 29 Jul 2023 03:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4847060AF2;
        Sat, 29 Jul 2023 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F4DC433C7;
        Sat, 29 Jul 2023 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690627812;
        bh=nMRxqe90NG6qwfKrs0AMv60mFb3S/AUU2zXFwE/YiOU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MlLoHUq64r2MMASa9Y3YKBYdHFgCXccG64YxihC8jPhIeYAprc4SkVtopex58+FaQ
         lhf71tmZF/DVpeLf0x4WICLA1iPd7vnoMfMpGOluzV9ubSHap20KR89entoFbeMJRZ
         vzAPvP5wxsTX0XpWNFH6x9uBCvJPfvfxYDGqwVTIhdK2l+TqjCCun5YgVhGCevgpLV
         tJ0xe4qjplrls8XMngVSGNyXmo2t1Ed/K8kZTwd8SkPmhxgxKxW6eNoVql+pDl3V44
         8qxtWUqcqMExTtz8j3pFqij+C7TNJ2NevoEjMzW7U72hSfau4bW47kCNapV8coimnw
         +liw9Xb5gYM8A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fe0c566788so4903908e87.0;
        Sat, 29 Jul 2023 03:50:12 -0700 (PDT)
X-Gm-Message-State: ABy/qLbZ4dJlGZqK+T2r8Ex3su5Vs0KAa4j+fHtB5dGK85n1UcPPUXUS
        KJ3hgCxFa2UXvWXOE5CXM744QC4qL6eMGbSa+hY=
X-Google-Smtp-Source: APBJJlECiEcJ4l5hfce1FjgDtK+kxUbUwbKoCbhZIjMkEPr5mcIzIhAecCGIVuKj32kQqKcHOqTUynCwaMaPPW7NEFc=
X-Received: by 2002:a05:6512:457:b0:4f8:d385:41bd with SMTP id
 y23-20020a056512045700b004f8d38541bdmr3138437lfk.8.1690627810611; Sat, 29 Jul
 2023 03:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_0D24426FAC6A21B69AC0C03CE4143A508F09@qq.com> <d8fde5d9-3ac5-0945-dc8e-315092a67528@huaweicloud.com>
In-Reply-To: <d8fde5d9-3ac5-0945-dc8e-315092a67528@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Sat, 29 Jul 2023 18:49:58 +0800
X-Gmail-Original-Message-ID: <CAPhsuW6UnqTowo0CZVZXcb_Z=OjV5xFwYqD1O6FO3CLqiKx2DQ@mail.gmail.com>
Message-ID: <CAPhsuW6UnqTowo0CZVZXcb_Z=OjV5xFwYqD1O6FO3CLqiKx2DQ@mail.gmail.com>
Subject: Re: [PATCH v2] md: raid1: fix potential OOB in raid1_remove_disk()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Zhang Shurong <zhang_shurong@foxmail.com>,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:12=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> =E5=9C=A8 2023/07/22 15:53, Zhang Shurong =E5=86=99=E9=81=93:
> > If rddev->raid_disk is greater than mddev->raid_disks, there will be
> > an out-of-bounds in raid1_remove_disk(). We have already found
> > similar reports as follows:
> >
> > 1) commit d17f744e883b ("md-raid10: fix KASAN warning")
> > 2) commit 1ebc2cec0b7d ("dm raid: fix KASAN warning in raid5_remove_dis=
k")
> >
> > Fix this bug by checking whether the "number" variable is
> > valid.
>
> LGTM
>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> >
> > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > ---
> > Changes in v2:
> >   - Using conf->raid_disks instead of mddev->raid_disks.
> >
> >   drivers/md/raid1.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> > index dd25832eb045..80aeee63dfb7 100644
> > --- a/drivers/md/raid1.c
> > +++ b/drivers/md/raid1.c
> > @@ -1829,6 +1829,10 @@ static int raid1_remove_disk(struct mddev *mddev=
, struct md_rdev *rdev)
> >       struct r1conf *conf =3D mddev->private;
> >       int err =3D 0;
> >       int number =3D rdev->raid_disk;
> > +
> > +     if (unlikely(number >=3D conf->raid_disks))
> > +             goto abort;

We need err =3D -EINVAL here.

> > +
> >       struct raid1_info *p =3D conf->mirrors + number;
> >
> >       if (rdev !=3D p->rdev)
> >
>
