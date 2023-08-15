Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527F877CFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 17:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbjHOPy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 11:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238382AbjHOPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 11:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B232A6;
        Tue, 15 Aug 2023 08:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FBFD65D14;
        Tue, 15 Aug 2023 15:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D7BC433CA;
        Tue, 15 Aug 2023 15:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692114865;
        bh=f3AES7Qvap7AQxgmzAF0sTBsS1ui0bwzqitDzBDmy4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qXSsNVIBvksPVNGRJgrZ/6plAWktlqu3663Hn9tEJkd62aFh4oZbnXdoNrjOuSg+l
         o0Foqb0DoK0nYxMfQGJUfxAB+v4ATo5s6EL+47eM+yt0xSMRwTjbDeLzdHsEXkABmS
         9XyS1A+xHgtdipGX0B+wnVJyFNdbuIT/vKxeOYs5ZztcVIlY+YiwPIJSq5kb6M58Al
         GAmalJBbdWTfAFpGi4MwIZ2BnRO8vHmgEPCUN+hscEUHRAfe04RuwioP8rchX5MSTd
         FU2UddCiPrdWt6qLMfae0hy37qh77IM7WMz9P9t9L2KEUloRgwc//Bh7zQqLX6w7h9
         Aa6I7FrjIvAEw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso82313921fa.3;
        Tue, 15 Aug 2023 08:54:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyg9lLb7cxaBbc8ak+2cstoUKw/A6mod46Q8k/2r1+Yjnjx7X2d
        ZE+D3dFeeikgDBL9WjaHlgG/+UaeSXrwfNhyG0c=
X-Google-Smtp-Source: AGHT+IHEoPC/PD8Hgr/AlB1Qcq1QWWjoXM51m7xNPZOU/zNuBv4WmDP0RNhcp6D+73fu8XvZ5yjv51VayK4g2Je7Q1Y=
X-Received: by 2002:a2e:87ce:0:b0:2b6:df23:2117 with SMTP id
 v14-20020a2e87ce000000b002b6df232117mr10276086ljj.43.1692114863484; Tue, 15
 Aug 2023 08:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230815030957.509535-1-yukuai1@huaweicloud.com>
 <20230815030957.509535-4-yukuai1@huaweicloud.com> <bb11d6ca-978a-8e1d-e721-d9d84c9dc5e3@huaweicloud.com>
In-Reply-To: <bb11d6ca-978a-8e1d-e721-d9d84c9dc5e3@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 15 Aug 2023 23:54:10 +0800
X-Gmail-Original-Message-ID: <CAPhsuW65Hxq=+D6M6zV8n+k4FarTHui=pSs2YPNKs9MYBD4MHA@mail.gmail.com>
Message-ID: <CAPhsuW65Hxq=+D6M6zV8n+k4FarTHui=pSs2YPNKs9MYBD4MHA@mail.gmail.com>
Subject: Re: [PATCH -next v2 3/7] md: delay choosing sync direction to md_start_sync()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Tue, Aug 15, 2023 at 2:00=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
[...]
> > +
> > +not_running:
> > +     clear_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> > +     clear_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
> > +     clear_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
> > +     clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
> > +     clear_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
> > +     mddev_unlock(mddev);
> > +
> > +     wake_up(&resync_wait);
> > +     if (test_and_clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery) &&
> > +         mddev->sysfs_action)
> > +             sysfs_notify_dirent_safe(mddev->sysfs_action);
> >   }
> >
> >   /*
> > @@ -9379,7 +9402,6 @@ void md_check_recovery(struct mddev *mddev)
> >               return;
> >
> >       if (mddev_trylock(mddev)) {
> > -             int spares =3D 0;
> >               bool try_set_sync =3D mddev->safemode !=3D 0;
> >
> >               if (!mddev->external && mddev->safemode =3D=3D 1)
> > @@ -9467,29 +9489,11 @@ void md_check_recovery(struct mddev *mddev)
> >               clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
> >
> >               if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recov=
ery) ||
> > -                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery))
> > -                     goto not_running;
> > -             if (!md_choose_sync_direction(mddev, &spares))
> > -                     goto not_running;
> > -             if (mddev->pers->sync_request) {
> > -                     if (spares) {
> > -                             /* We are adding a device or devices to a=
n array
> > -                              * which has the bitmap stored on all dev=
ices.
> > -                              * So make sure all bitmap pages get writ=
ten
> > -                              */
> > -                             md_bitmap_write_all(mddev->bitmap);
> > -                     }
> > +                 test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
>
> Sorry that I made a mistake here while rebasing v2, here should be
>
> !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)
>
> With this fixed, there are no new regression for mdadm tests using loop
> devicein my VM.

                if (!test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recover=
y) ||
                    !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
                        queue_work(md_misc_wq, &mddev->sync_work);
                } else {

This doesn't look right. Should we do

                if (test_and_clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery=
) &&
                    !test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
                        queue_work(md_misc_wq, &mddev->sync_work);
                } else {

instead?

Thanks,
Song
