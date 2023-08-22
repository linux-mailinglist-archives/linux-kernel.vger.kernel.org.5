Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C42783DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjHVKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjHVKUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C9C1B0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692699569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sBfhKxkrMmsGIzpY/0/vS1cgmtOXfCWjIYyuonQhTsA=;
        b=VVUBNjlVGz3yzHtZ5sswZ/vYCA++qAzjKHKBiU28BZpjwUeIp4+/cWFDXViuHGPR8IR2Dd
        vOMJlrR8H56qWuIs4VYGr0n2j0CBGj3F4TCm9Dibl+FtvRcENUEoY+qwavfM8bU8t0JVMs
        heUttD3sevbsCQkkh3zFTfB+5eSe030=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-wWk4OKBePyKFMABXQpMXTg-1; Tue, 22 Aug 2023 06:19:28 -0400
X-MC-Unique: wWk4OKBePyKFMABXQpMXTg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-267f00f6876so4644653a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692699567; x=1693304367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBfhKxkrMmsGIzpY/0/vS1cgmtOXfCWjIYyuonQhTsA=;
        b=cBo2ui4v8DCKZIooyzH1FwvKivWe/9KN1+P3IcGA8vmaP907S++qDtwA3dvJMhaq4v
         1dGWUM5g4cXhz0ld2D7rREguTfZw9DFm2IPyv+VlcE5LzGtc3bAs94DONXTPAYu+bAgT
         WOPQcRgKhCta46FPfVOHgFwa2r28idZ5OiEfKfOije6nWImaWBosangq9f7q0EzJcOgt
         cyZ2oQ4DBm05C02KfyBCYtJfFLsN7lKhHxM9GkC8PQq3ABX/iqgmcgYO0UKsDuTzm2Rl
         QLQjfEUn0EsVOPtIkouz5YMy529tddIvcCAJZnLJaIyqdRNGlkS6KGbIB0SDjfgAhrl1
         FCLw==
X-Gm-Message-State: AOJu0Yy+33TzRc2SH7Klyb7jJB63EtKsyHjvZH7z7KBoDBWsCtxby1+t
        BpZGmVlDKf5XVpzStJTJ5/XPFLlO+FUkDHJsz9vjDs33Jcc8rnnfyCC2idB3LNBJ/M47O1ujw9F
        C6HUeieCnHtBSt4NUVeWGmB2lVSkJOCB2BYHaFliX
X-Received: by 2002:a17:90b:4b82:b0:269:2356:19fb with SMTP id lr2-20020a17090b4b8200b00269235619fbmr6028270pjb.15.1692699567345;
        Tue, 22 Aug 2023 03:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhrxNdfMXnk16axJ2zWyGj7XP3x5wGyIuVvaTa3xh1G5lcPseQp05Y7UWtFr1Un5KLIHBv8FbCEavHO6u+CnI=
X-Received: by 2002:a17:90b:4b82:b0:269:2356:19fb with SMTP id
 lr2-20020a17090b4b8200b00269235619fbmr6028263pjb.15.1692699567027; Tue, 22
 Aug 2023 03:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230820090949.2874537-1-yukuai1@huaweicloud.com> <20230820090949.2874537-5-yukuai1@huaweicloud.com>
In-Reply-To: <20230820090949.2874537-5-yukuai1@huaweicloud.com>
From:   Xiao Ni <xni@redhat.com>
Date:   Tue, 22 Aug 2023 18:19:16 +0800
Message-ID: <CALTww2-mH7SW3Dz0DOd+NyBpZAZzB8r50UCBOkMipNtV4VxWTw@mail.gmail.com>
Subject: Re: [PATCH -next v3 4/7] md: factor out a helper rdev_removeable()
 from remove_and_add_spares()
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

On Sun, Aug 20, 2023 at 5:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> There are no functional changes, just to make the code simpler and
> prepare to delay remove_and_add_spares() to md_start_sync().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 561cac13ff96..ceace5ffadd6 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9153,6 +9153,22 @@ void md_do_sync(struct md_thread *thread)
>  }
>  EXPORT_SYMBOL_GPL(md_do_sync);
>
> +static bool rdev_removeable(struct md_rdev *rdev)
> +{
> +       if (rdev->raid_disk < 0 || test_bit(Blocked, &rdev->flags) ||
> +           atomic_read(&rdev->nr_pending))
> +               return false;
> +
> +       if (test_bit(RemoveSynchronized, &rdev->flags))
> +               return true;
> +
> +       if (test_bit(In_sync, &rdev->flags) ||
> +           test_bit(Journal, &rdev->flags))
> +               return false;
> +
> +       return true;
> +}
> +
>  static int remove_and_add_spares(struct mddev *mddev,
>                                  struct md_rdev *this)
>  {
> @@ -9166,11 +9182,7 @@ static int remove_and_add_spares(struct mddev *mdd=
ev,
>                 return 0;
>
>         rdev_for_each(rdev, mddev) {
> -               if ((this =3D=3D NULL || rdev =3D=3D this) &&
> -                   rdev->raid_disk >=3D 0 &&
> -                   !test_bit(Blocked, &rdev->flags) &&
> -                   test_bit(Faulty, &rdev->flags) &&
> -                   atomic_read(&rdev->nr_pending)=3D=3D0) {
> +               if ((this =3D=3D NULL || rdev =3D=3D this) && rdev_remove=
able(rdev)) {

There is a small change with the original method. Before this patch,
it checks the Faulty flag when setting RemoveSynchronized and it
checks RemoveSynchronized and "!In_sync && !Journal". I'm not sure if
it's right or not.

>                         /* Faulty non-Blocked devices with nr_pending =3D=
=3D 0
>                          * never get nr_pending incremented,
>                          * never get Faulty cleared, and never get Blocke=
d set.
> @@ -9185,19 +9197,12 @@ static int remove_and_add_spares(struct mddev *md=
dev,
>                 synchronize_rcu();
>         rdev_for_each(rdev, mddev) {
>                 if ((this =3D=3D NULL || rdev =3D=3D this) &&
> -                   rdev->raid_disk >=3D 0 &&
> -                   !test_bit(Blocked, &rdev->flags) &&
> -                   ((test_bit(RemoveSynchronized, &rdev->flags) ||
> -                    (!test_bit(In_sync, &rdev->flags) &&
> -                     !test_bit(Journal, &rdev->flags))) &&
> -                   atomic_read(&rdev->nr_pending)=3D=3D0)) {
> -                       if (mddev->pers->hot_remove_disk(
> -                                   mddev, rdev) =3D=3D 0) {
> +                   rdev_removeable(rdev) &&
> +                   mddev->pers->hot_remove_disk(mddev, rdev) =3D=3D 0) {
>                                 sysfs_unlink_rdev(mddev, rdev);
>                                 rdev->saved_raid_disk =3D rdev->raid_disk=
;
>                                 rdev->raid_disk =3D -1;
>                                 removed++;
> -                       }
>                 }
>                 if (remove_some && test_bit(RemoveSynchronized, &rdev->fl=
ags))
>                         clear_bit(RemoveSynchronized, &rdev->flags);
> --
> 2.39.2
>

