Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59487BA260
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJEPcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjJEPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:32:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B3C16AA2;
        Thu,  5 Oct 2023 07:37:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C044C433CA;
        Thu,  5 Oct 2023 04:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696478422;
        bh=FihUa0tBwKjEXiCm8gEOsR7cV+rqgCLeNbM/8aB0Or4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XPbmGea8ufH4Es7bR544Ur65RJ/+g4TjOjDlPCSsRE5Gd6QINI9E9iAeqeIloHvPG
         ZkNFNeowcdhxEd/YYjkMNDHApbTEB3Cnb1XMsicnX4ictwK7SN8Y30DyWRY+rBPBD7
         1l2xP6HYXD510T+82XzPnuIM6rZF854YM3Lrrv3h4yCxrI9p+wfAh6Wtpvxv6LsClB
         1IiOTt0G9bzSmamjoc5lcV1UvyD/8a4ysps+UTbEqoSAoTgjVN3nHrzmAtPSRV+FQ3
         apFmIWmZL1lD43tmsRt8rkQBxZR9ewEKlLcwRWCTAvfV0oNA/MAf5RC/wFzHHLFgkS
         yBu0jZrptePdQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2bff936e10fso19907581fa.1;
        Wed, 04 Oct 2023 21:00:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YyflS3k+epelRvg8Ba00Pprgy3WqcLF8M/ECJ9CMlhr3hvqUCvm
        Vt045erQ5VhxjkBxxVhSm2b0fJbOg6RNys3wMwk=
X-Google-Smtp-Source: AGHT+IFrweThNcOJampPvgPU+EwndkFznX8xeRJ6i/Tv4bnoHj/MpBOiktX/l28+v82Jez83Uz14NbrE9GegQdAU6UI=
X-Received: by 2002:a2e:b4b3:0:b0:2c1:86da:3f61 with SMTP id
 q19-20020a2eb4b3000000b002c186da3f61mr116977ljm.9.1696478420086; Wed, 04 Oct
 2023 21:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
 <20230928061543.1845742-4-yukuai1@huaweicloud.com> <CAPhsuW4tQ9A+ddpxGhfza3WSdkL+FXmS-4NLUUN7MNk0TOY0WA@mail.gmail.com>
 <0ae441ba-68db-b823-b48c-76e953d22067@huaweicloud.com>
In-Reply-To: <0ae441ba-68db-b823-b48c-76e953d22067@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 4 Oct 2023 21:00:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6ru-Chofq8ki6Xh9U0utH6+_mo0dd3Ty8fZPHGtJ1xvQ@mail.gmail.com>
Message-ID: <CAPhsuW6ru-Chofq8ki6Xh9U0utH6+_mo0dd3Ty8fZPHGtJ1xvQ@mail.gmail.com>
Subject: Re: [PATCH -next v3 03/25] md: add new helpers to suspend/resume array
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
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

On Wed, Oct 4, 2023 at 7:59=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2023/09/29 2:45, Song Liu =E5=86=99=E9=81=93:
> > On Wed, Sep 27, 2023 at 11:22=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.c=
om> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Advantages for new apis:
> >>   - reconfig_mutex is not required;
> >>   - the weird logical that suspend array hold 'reconfig_mutex' for
> >>     mddev_check_recovery() to update superblock is not needed;
> >>   - the specail handling, 'pers->prepare_suspend', for raid456 is not
> >>     needed;
> >>   - It's safe to be called at any time once mddev is allocated, and it=
's
> >>     designed to be used from slow path where array configuration is ch=
anged;
> >>   - the new helpers is designed to be called before mddev_lock(), henc=
e
> >>     it support to be interrupted by user as well.
> >>
> >> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> >> ---
> >>   drivers/md/md.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++=
+-
> >>   drivers/md/md.h |   3 ++
> >>   2 files changed, 103 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/md/md.c b/drivers/md/md.c
> >> index e460b380143d..a075d03d03d3 100644
> >> --- a/drivers/md/md.c
> >> +++ b/drivers/md/md.c
> >> @@ -443,12 +443,22 @@ void mddev_suspend(struct mddev *mddev)
> >>                          lockdep_is_held(&mddev->reconfig_mutex));
> >>
> >>          WARN_ON_ONCE(thread && current =3D=3D thread->tsk);
> >> -       if (mddev->suspended++)
> >> +
> >> +       /* can't concurrent with __mddev_suspend() and __mddev_resume(=
) */
> >> +       mutex_lock(&mddev->suspend_mutex);
> >> +       if (mddev->suspended++) {
> >> +               mutex_unlock(&mddev->suspend_mutex);
> >>                  return;
> >
> > Can we make mddev->suspended atomic_t, and use atomic_inc_return()
> > here?
>
> 'suspend_mutex' is needed, because concurrent caller of
> mddev_suspend() shound be ordered, they need to wait for the first
> mddev_suspend() to be done.
>
> Updating suspended is protected by 'suspend_mutex' in the new api, so I
> think it's not necessary to use atomic, WRITE/READ_ONCE() should be
> enough.

Thanks for the explanation.

Song
