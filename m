Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A571783851
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjHVDMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHVDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD179185;
        Mon, 21 Aug 2023 20:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B2F61BF4;
        Tue, 22 Aug 2023 03:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91CCC433C8;
        Tue, 22 Aug 2023 03:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692673952;
        bh=kGrY/nWtrxCnA6j0E+QQnIMmxsJmX8ouBz54xNiRQxA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vFYkhfYmCKKSANpfwr2JRFFkk1sLurhfwyyPhbAYquhYTptnmT1jblg46BXZJl1BE
         2/l3X7HnfMYtjjqF4JW1DV5zXiUW/r8hOFOazHyeVLiLPLiUT7klkodGT5VEJaece9
         KjLJb/PwsyUkDpwnttmM3h74kNDfYHP4TgVxQgDcXQV2vSjrWSMJLmdSUq6RfsWNo/
         TCaKmUfBsOexHjmlweQFuFnbyW9L3sxdVClR3m2DNt9ipmsBQzsFeEp0CPIEqn06/f
         4qxNwdrmaZbk7qvmuFNRcSlCTDfVeaws+tTkLiRtMnH0oKNuEGJpTArs8GeL4rnZTu
         riE6eTBfojxcg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso3916911e87.1;
        Mon, 21 Aug 2023 20:12:32 -0700 (PDT)
X-Gm-Message-State: AOJu0YzxdhslrXTcCLyckkx79YvBBdLzC+5K54VrSa0mUurE/NDBWryV
        dpxRz3aDUIAaqe5e0WU++gWgdjn8vsj5xUhDDkU=
X-Google-Smtp-Source: AGHT+IH4pFmSg3XDl+h3JnH9YL/8/XsxNMGD0PcEl2fl6dtIlbvGII7oMeTt3k8/0tI0exHTGfDCvGB4bm9GA4lLeRA=
X-Received: by 2002:a05:6512:1149:b0:4fd:d0bd:2401 with SMTP id
 m9-20020a056512114900b004fdd0bd2401mr6161999lfg.66.1692673950694; Mon, 21 Aug
 2023 20:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230803132751.2741652-1-yukuai1@huaweicloud.com>
 <20230803132751.2741652-4-yukuai1@huaweicloud.com> <CAPhsuW6Q6Mf=GqRcGbMrrU_4gPvyOdJz2ZkEKZVOT=mfeQtpjg@mail.gmail.com>
 <2771400f-d4bb-d650-b075-0c2b56006545@huaweicloud.com>
In-Reply-To: <2771400f-d4bb-d650-b075-0c2b56006545@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 21 Aug 2023 20:12:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5NSeCfMkx-6MmW-am1BSVfAo9zg0aF_P9ZqVhmnmPnpQ@mail.gmail.com>
Message-ID: <CAPhsuW5NSeCfMkx-6MmW-am1BSVfAo9zg0aF_P9ZqVhmnmPnpQ@mail.gmail.com>
Subject: Re: [PATCH -next 3/7] md: don't rely on 'mddev->pers' to be set in mddev_suspend()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 7:08=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/08/22 8:13, Song Liu =E5=86=99=E9=81=93:
> > On Thu, Aug 3, 2023 at 6:30=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Now that active io is initialized when mddev is allocated, it's safe t=
o
> >> call mddev_suspend() before 'mddev->pers' is set.
> >>
> >> This also prevent null-ptr-def in some cases that caller doesn't
> >> guarantee 'mddev->pers' to be set.
> >
> > This description is a little confusing (to me at least). Please revise =
it.
>
> Sorry about this, how about this:
>
> 'active_io' used to be initialized while the array is running, and
> 'mddev->pers' is set while the array is running as well. Hence caller
> must hold 'reconfig_mutex' and guarantee 'mddev->pers' is set before
> calling mddev_suspend().
>
> Now that 'active_io' is initialized when mddev is allocated, such
> restriction doesn't exist anymore. In the meantime, follow up patches
> will refactor mddev_suspend(), hence add checking for 'mddev->pers' to
> prevent null-ptr-deref.

This is much better. Thanks!

Song
