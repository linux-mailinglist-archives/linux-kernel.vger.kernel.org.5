Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9BA7CE5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344792AbjJRR6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjJRR6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:58:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C911F;
        Wed, 18 Oct 2023 10:58:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA39C433C8;
        Wed, 18 Oct 2023 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697651898;
        bh=/isgDa3v9zNknX7QZEqdxkgEg2GyI4Du6HRXsQvYGgs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qefmb/S9J/ASH7JHOtHxmi3fbQPkKJXAOY0fn1dIx/SuO8JXi+PsL6Ou5qTuhnGtw
         9NtL/vobL/Rd/nIvZGnIcMzR8kk3T6P9PHb/TfNldPjsNFnsWiuoGvbuR5f2+fOHiI
         8vGEsB0pGI6xFnZAO1lLlRujG4LI3YvftUHtGBtNFrBb0DSuKQSfFDumRxW5bmSuGT
         hHesQvv1D4qu+IOs214Q6nLMgkt3XeGuJ3/UBUsUVvF8iOz0lTfP4ApBNqqc3y8gif
         qz9x1wlItdXf2k8bbYCoYAJLwNo3jxGHsg4YdSewAUbRTW/Aj5jBuB2UrCZ33IW6cl
         ewmlMzr/W01nA==
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so4186479b3a.1;
        Wed, 18 Oct 2023 10:58:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YwFn1ncsX2r+EqrKu1vuIfPtMRjMmN07JWlq/we4C9z7AArvluv
        n6DsexFOuZBbRsJniZXi/LJNKCE1tcAUkgHsfgU=
X-Google-Smtp-Source: AGHT+IFDNBZkNDwbekm5S+AjjsdT+NNyK4J5gTKqdMpQMndj72n6hVxnSKWGsRH5stMVlgqm8V6QwI7RvEjqBtqtPG4=
X-Received: by 2002:a05:6a20:1584:b0:147:fd40:2482 with SMTP id
 h4-20020a056a20158400b00147fd402482mr6309428pzj.44.1697651897912; Wed, 18 Oct
 2023 10:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231016092439.493646-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231016092439.493646-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 18 Oct 2023 10:58:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6vE7O1uPXnC3yrUT4maghKdx+E0odqF7UxP5esgBC=2A@mail.gmail.com>
Message-ID: <CAPhsuW6vE7O1uPXnC3yrUT4maghKdx+E0odqF7UxP5esgBC=2A@mail.gmail.com>
Subject: Re: [PATCH -next 0/6] md: remvoe rcu protection to access rdev from conf
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Sun, Oct 15, 2023 at 6:28=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Yu Kuai (6):
>   md: remove useless debug code to print configuration
>   md: remove flag RemoveSynchronized
>   md/raid1: remove rcu protection to access rdev from conf
>   md/raid10: remove rcu protection to access rdev from conf
>   md/raid5: remove rcu protection to access rdev from conf
>   md/md-multipath: remove rcu protection to access rdev from conf

While a cover letter is highly recommended for a patchset. An empty
cover letter like this doesn't really add value. If the description of each
patch is clear enough, it is OK to not have a cover-letter.

Thanks,
Song

>
>  drivers/md/md-multipath.c |  29 ++---
>  drivers/md/md.c           |  37 +-----
>  drivers/md/raid1.c        |  94 ++++-----------
>  drivers/md/raid10.c       | 248 +++++++++-----------------------------
>  drivers/md/raid5-cache.c  |  11 +-
>  drivers/md/raid5-ppl.c    |  16 +--
>  drivers/md/raid5.c        | 225 ++++++++++------------------------
>  drivers/md/raid5.h        |   4 +-
>  8 files changed, 163 insertions(+), 501 deletions(-)
>
> --
> 2.39.2
>
