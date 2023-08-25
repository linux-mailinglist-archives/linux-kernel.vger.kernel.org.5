Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC68478801D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbjHYGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242264AbjHYGk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE4B1BDB;
        Thu, 24 Aug 2023 23:40:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 409BB63435;
        Fri, 25 Aug 2023 06:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5815C433CA;
        Fri, 25 Aug 2023 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692945656;
        bh=sBMIVekm7z5dJED9CCKgiR+YzYCHzNiyNOpOdEkw/uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UU86Lyz7bEs4FeSBM++1RO2akLfMte4Ax6tJnviZdEsHxGA+VC824QjLqnT1C9agk
         FOHL879E/Mv/SwPC03Va4qwpJihf8q5fQiPYsIDH1szmwg//U8v4BQ9KOdpGFPw2s1
         Lv0sQqHwx0B7oExm4wxK/OSQn6F9ZPtBFx8y+Fa3z1BahkoKx9pbig8d/4UPxih1sX
         BTZcsqCt905XJ/nzdwvzuFbcsXG8uLZHdj/x3Y7bl1TCk/wosUI/6yJFc531CaATOY
         bAMM3JiOAUmt4rR6lQ4UdBXwjlQKeladpYrlkZzY+ON3UCGDStYTkd/jiNby9927tz
         ysJKHFDCZmvkg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so817806e87.2;
        Thu, 24 Aug 2023 23:40:56 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7OJ7pS7FAby+U1D7jBAa1bomwU8C7dwJ2vFQaro7MgbrslNOS
        uqypKNLPVJuaDdOyUVE97frQEyNolOFTlO6JoKo=
X-Google-Smtp-Source: AGHT+IGPD2aEMvFaklo3jAklk1fPCfCMIW5CcacHp0PxUv2igIzNHi2IlxZxuK4troY9ylLDd3v70bdKU+nHof0qYUU=
X-Received: by 2002:a05:6512:3b0b:b0:500:a08e:2fd3 with SMTP id
 f11-20020a0565123b0b00b00500a08e2fd3mr3250301lfv.21.1692945654672; Thu, 24
 Aug 2023 23:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230825030956.1527023-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 24 Aug 2023 23:40:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7dYaJYx8xa-CAG1YSwggZdGRfcQWqTBY0915=_UdL49Q@mail.gmail.com>
Message-ID: <CAPhsuW7dYaJYx8xa-CAG1YSwggZdGRfcQWqTBY0915=_UdL49Q@mail.gmail.com>
Subject: Re: [PATCH -next v2 0/7] md: initialize 'active_io' while allocating mddev
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com,
        xni@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
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

On Thu, Aug 24, 2023 at 8:14=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v2:
>  - rebase for md-next;
>  - update commit message for patch 3;

Applied v2 to md-next. But this set won't go into 6.6.

Thanks,
Song

>
> This is the 4th patchset to do some preparatory work to synchronize
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
> 3) Make array reconfiguration independent from daemon thread,
> and synchronize it with io will be much easier because io may rely on
> daemon thread to be done.
>
> 4) This patchset move initialization of 'active_io' from md_run() to
> md_alloc(), so that mddev_suspend() won't rely on holding 'reconfig_mutex=
'
> to check if 'mddev->pers' is set, and it can be called at any time after
> mddev is allocated.(Done by patch 1, and other patches are cleanup)
>
> Yu Kuai (7):
>   md: initialize 'active_io' while allocating mddev
>   md: initialize 'writes_pending' while allocating mddev
>   md: don't rely on 'mddev->pers' to be set in mddev_suspend()
>   md-bitmap: remove the checking of 'pers->quiesce' from
>     location_store()
>   md-bitmap: suspend array earlier in location_store()
>   md: don't check 'mddev->pers' from suspend_hi_store()
>   md: don't check 'mddev->pers' and 'pers->quiesce' from
>     suspend_lo_store()
>
> [1] https://lore.kernel.org/all/20230621165110.1498313-1-yukuai1@huaweicl=
oud.com/
> [2] https://lore.kernel.org/all/20230628012931.88911-2-yukuai1@huaweiclou=
d.com/
>
> Yu Kuai (7):
>   md: initialize 'active_io' while allocating mddev
>   md: initialize 'writes_pending' while allocating mddev
>   md: don't rely on 'mddev->pers' to be set in mddev_suspend()
>   md-bitmap: remove the checking of 'pers->quiesce' from
>     location_store()
>   md-bitmap: suspend array earlier in location_store()
>   md: don't check 'mddev->pers' from suspend_hi_store()
>   md: don't check 'mddev->pers' and 'pers->quiesce' from
>     suspend_lo_store()
>
>  drivers/md/dm-raid.c   |   7 ++-
>  drivers/md/md-bitmap.c |  47 +++++++++----------
>  drivers/md/md.c        | 100 ++++++++++++++++++++---------------------
>  drivers/md/md.h        |   4 +-
>  drivers/md/raid1.c     |   3 +-
>  drivers/md/raid10.c    |   3 --
>  drivers/md/raid5.c     |   3 --
>  7 files changed, 78 insertions(+), 89 deletions(-)
>
> --
> 2.39.2
>
