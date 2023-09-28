Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FBE7B2577
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjI1SqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1SqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:46:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D62BF;
        Thu, 28 Sep 2023 11:46:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E39C433CB;
        Thu, 28 Sep 2023 18:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695926762;
        bh=IeX1Us+HvLC3WWy3/NtNhm4t19D8HBadibrKzf5JSmI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ErBC501xTE55+ZNK/ojYVc/tyZWmWwSE2bTtO7LkkrAMdR+FUqXULd2Oj00dzDXDY
         9VfpC7cLQLzGrcwEL4sxbn4+Ecg3NK7sWUoGPx+8lqcQ4Isd7xWe2IcyKf9XTHHacx
         cpGaH37OowdmjXDMUsTL2KKlyXsxv/em+gFryb/uzF4AlacU0sBUkkZtuc67Dv6Xac
         RdpjO+0ItfroQrqJNLQg/+tqKQzlit+Ia0Ynd8rKJIxTk9ourBp9EZXlf8cZPojVGd
         hpoSwHwY6bSKR97V4AqSRmDrFIdPV2BVHldW/lvED8F5HsMCAErFLIFhm5K5hDn3ke
         bouY2XWiNtAvg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5033918c09eso21121436e87.2;
        Thu, 28 Sep 2023 11:46:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YxlsSFKoDBPifZyhBudEtK2zSMG1qYNQZpNp7rSnae2RH1M34FR
        5HtuQpkmrznzTI0RldXT4Q/fekxB81vuqUWG4KY=
X-Google-Smtp-Source: AGHT+IEP/A671di6lQEvr4rOqxf6W0ucETdxmobG5KsUclVSSm+4J94KeLxwDjY2OceTV/iDTvypyEilu52yJW74hMo=
X-Received: by 2002:a19:6557:0:b0:501:b8dc:6c45 with SMTP id
 c23-20020a196557000000b00501b8dc6c45mr1943815lfj.18.1695926760898; Thu, 28
 Sep 2023 11:46:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com> <20230928061543.1845742-4-yukuai1@huaweicloud.com>
In-Reply-To: <20230928061543.1845742-4-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 Sep 2023 11:45:48 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4tQ9A+ddpxGhfza3WSdkL+FXmS-4NLUUN7MNk0TOY0WA@mail.gmail.com>
Message-ID: <CAPhsuW4tQ9A+ddpxGhfza3WSdkL+FXmS-4NLUUN7MNk0TOY0WA@mail.gmail.com>
Subject: Re: [PATCH -next v3 03/25] md: add new helpers to suspend/resume array
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Wed, Sep 27, 2023 at 11:22=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Advantages for new apis:
>  - reconfig_mutex is not required;
>  - the weird logical that suspend array hold 'reconfig_mutex' for
>    mddev_check_recovery() to update superblock is not needed;
>  - the specail handling, 'pers->prepare_suspend', for raid456 is not
>    needed;
>  - It's safe to be called at any time once mddev is allocated, and it's
>    designed to be used from slow path where array configuration is change=
d;
>  - the new helpers is designed to be called before mddev_lock(), hence
>    it support to be interrupted by user as well.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/md/md.h |   3 ++
>  2 files changed, 103 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index e460b380143d..a075d03d03d3 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -443,12 +443,22 @@ void mddev_suspend(struct mddev *mddev)
>                         lockdep_is_held(&mddev->reconfig_mutex));
>
>         WARN_ON_ONCE(thread && current =3D=3D thread->tsk);
> -       if (mddev->suspended++)
> +
> +       /* can't concurrent with __mddev_suspend() and __mddev_resume() *=
/
> +       mutex_lock(&mddev->suspend_mutex);
> +       if (mddev->suspended++) {
> +               mutex_unlock(&mddev->suspend_mutex);
>                 return;

Can we make mddev->suspended atomic_t, and use atomic_inc_return()
here?

Thanks,
Song

[...]
