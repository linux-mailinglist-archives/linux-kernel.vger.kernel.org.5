Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B5788019
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbjHYGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbjHYGkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:40:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41A92133;
        Thu, 24 Aug 2023 23:39:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 270CF65D38;
        Fri, 25 Aug 2023 06:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9087DC433C9;
        Fri, 25 Aug 2023 06:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692945597;
        bh=+s9Koxy+TTugL21cIgmab6DIs5KPUzfsaLnpEMPjvp0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PftxFfPsqmjM96yXBpsER0XAs1j2lNUhEx2JdTIu55RGddcad4EGCynCy5aUnXuyx
         eXs/xTgmkOZTt2MkQDDrkrBIvrZlQ37Qw5fU4dx+4EMZRbg/mba4DEBOTxfLz27+MB
         NW88zbxmdUjdGWfNDZtTqVkWRtPFEY+Azne0i96/Se8HnpVaNxP8dVKqf1nYEeH9v1
         i/CudMJ9rS2H+OmInNs6Ef5L6dIKjYD+i2UI6C1C2CXOAPj3kbUilLVHU9fORHioSi
         1DmfCBeMhvADgk8l10TbVZKDwkgSYXl81RLMjhzCCiIsH906sObZvd8IvOqbgS/usT
         2tt1nJ4ahnR8A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5007abb15e9so860899e87.0;
        Thu, 24 Aug 2023 23:39:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPvAgix6OSbp4jNpsUqUPmwzxQWNqJ0RjTzhVgHmPtkQ1Bs3nh
        P45Jr1HosFxGGdXtYVs4Whgjj63Ea2+vgJJF5tc=
X-Google-Smtp-Source: AGHT+IGObpDVPkI2f3gHr+eNk39SieeXXdBFR5o42FZlpllf6UoziXUH5g+xRTGeYzlJmnL15n5EctIxGgedfI8pCCE=
X-Received: by 2002:ac2:4f15:0:b0:4fb:911b:4e19 with SMTP id
 k21-20020ac24f15000000b004fb911b4e19mr14250662lfr.35.1692945595602; Thu, 24
 Aug 2023 23:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230825031622.1530464-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Aug 2023 23:39:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4rQ1V7EHgfpfx9rL2=pUAcjr+Eint2iD0_EfVAbzcKOQ@mail.gmail.com>
Message-ID: <CAPhsuW4rQ1V7EHgfpfx9rL2=pUAcjr+Eint2iD0_EfVAbzcKOQ@mail.gmail.com>
Subject: Re: [PATCH -next v4 0/7] md: make rdev addition and removal
 independent from daemon thread
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Thu, Aug 24, 2023 at 8:20=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v4:
>  - add some review tag;
>  - add comments to make code more readadble for patch 4,6;
>  - rework patch 7 a litter;

Applied v4 to md-next. But this set won't go into 6.6.

Thanks,
Song

>
> Changes in v3:
>  - rename md_choose_sync_direction() to md_choose_sync_action() in patch =
2;
>  - fix an error in patch 3;
>  - add flush_work(&mddev->sync_work) while change read-only array to
>  read-write;
>
> Changes in v2:
>  - remove patch 1 from v1 and some related patches, those patches will
>  be sent later when rcu protection for rdev is removed.
>  - add patch 2.
>
> This is the third patchset to do some preparatory work to synchronize
> io with array reconfiguration.
>
> 1) The first patchset refactor 'active_io', make sure that mddev_suspend(=
)
> will wait for io to be done. [1]
>
> 2) The second patchset remove 'quiesce' callback from mddev_suspend(), so
> that mddev_suspend() doesn't rely on 'quiesce' callback is registered,
> and can be used for all personalites; [2]
>
> 3) This patchset make array reconfiguration independent from daemon threa=
d,
> and synchronize it with io will be much easier because io may rely on
> daemon thread to be done.
>
> More patchset on the way!
>
> Yu Kuai (7):
>   md: use separate work_struct for md_start_sync()
>   md: factor out a helper to choose sync action from md_check_recovery()
>   md: delay choosing sync action to md_start_sync()
>   md: factor out a helper rdev_removeable() from remove_and_add_spares()
>   md: factor out a helper rdev_is_spare() from remove_and_add_spares()
>   md: factor out a helper rdev_addable() from remove_and_add_spares()
>   md: delay remove_and_add_spares() for read only array to
>     md_start_sync()
>
>  drivers/md/md.c | 308 +++++++++++++++++++++++++++++++++---------------
>  drivers/md/md.h |   5 +-
>  2 files changed, 218 insertions(+), 95 deletions(-)
>
> --
> 2.39.2
>
