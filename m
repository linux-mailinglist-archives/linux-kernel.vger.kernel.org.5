Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815A47BC43A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbjJGClK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233755AbjJGClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:41:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1337CBD;
        Fri,  6 Oct 2023 19:41:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFD2C433C9;
        Sat,  7 Oct 2023 02:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696646466;
        bh=bwGFUBVwK4SPl5rUi0AHrK68P2vjEQfazBcMlXR+RaE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cc9BmNrUYE8AeM1xNtAiR2C/DMgquJeOU1TfGVTWdiIW+2YakX18Dz4i0I06K0yUN
         rxxvnMdzitm6jKkR47hAfHfhNvmg/OdFfhrXU2rQenKRGEmgpJJMgMuKhiPtN+NJuh
         EsnJDhrfsk2Rsd+/f6Vumr20boJdghkx71XfMxlwjFV4kkFfJ/L/lhMVDpx5lUPjJ9
         yiDSokDJ9fMrRnoGTYkhvIqVTDaDZa5lEnsZtESzdd8tgSYEzSAr6c4wvUh+qHkQDw
         iM41xZ5gRnb/KlE9gHeXf+2xMI6Oo9D3iRGgUs6yDfzqpO9ZP7lQINxaa5ZkDbOwnA
         mS05KERFyeK1g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-504427aae4fso4720054e87.1;
        Fri, 06 Oct 2023 19:41:06 -0700 (PDT)
X-Gm-Message-State: AOJu0YzouflLaTFxi+fyAHznnn1zXuBmObOJQpFQMtilsU09qh+8PM44
        CUo/u5ERY8vyhQWjy5OBWDUTMpLL1lgVckTf1dc=
X-Google-Smtp-Source: AGHT+IFZKXFMDdbJlrwzbWL763LgpyNh7kR9JWexcBVJPWIm2fnTDvq0yf/QIAKmPc6vXoFQVrJuE1yWYhbC0z4c0N4=
X-Received: by 2002:a05:6512:3995:b0:4f8:586a:d6ca with SMTP id
 j21-20020a056512399500b004f8586ad6camr4814291lfu.9.1696646464789; Fri, 06 Oct
 2023 19:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
 <CAPhsuW5cUgqy9fqj+Z4nGPQrAok-eQ=NipNxb0TL_kuCFaPMcw@mail.gmail.com>
 <f59cbb99-33dd-c427-2e43-5a07ab9fbf51@huaweicloud.com> <CAPhsuW7TRODsR_N95AmXJCZvpTuSKgbOjnYGxMGAWtmt3x9Vkw@mail.gmail.com>
 <eb4ea24d-f7b4-899b-9259-2d48dc83e48f@huaweicloud.com>
In-Reply-To: <eb4ea24d-f7b4-899b-9259-2d48dc83e48f@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 6 Oct 2023 19:40:52 -0700
X-Gmail-Original-Message-ID: <CAPhsuW72zSALeSk96QAdq4cHf=y_n13MOBmxH-dTUKjkbc_jig@mail.gmail.com>
Message-ID: <CAPhsuW72zSALeSk96QAdq4cHf=y_n13MOBmxH-dTUKjkbc_jig@mail.gmail.com>
Subject: Re: [PATCH -next v3 00/25] md: synchronize io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Fri, Oct 6, 2023 at 7:32=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2023/10/05 11:55, Song Liu =E5=86=99=E9=81=93:
> > On Wed, Oct 4, 2023 at 8:42=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com=
> wrote:
> >>
> >> Hi,
> >>
> >> =E5=9C=A8 2023/09/29 3:15, Song Liu =E5=86=99=E9=81=93:
> >>> Hi Kuai,
> >>>
> >>> Thanks for the patchset!
> >>>
> >>> A few high level questions/suggestions:
> >>
> >> Thanks a lot for these!
> >>>
> >>> 1. This is a big change that needs a lot of explanation. While you ma=
naged to
> >>> keep each patch relatively small (great job btw), it is not very clea=
r why we
> >>> need these changes. Specifically, we are adding a new mutex, it is wo=
rth
> >>> mentioning why we cannot achieve the same goal without it. Please add
> >>> more information in the cover letter. We will put part of the cover l=
etter in
> >>> the merge commit.
> >>
> >> Yeah, I realize that I explain too little. I will add background and
> >> design.
> >>>
> Can you take a look about this new cover letter?

I don't have time right now to look into all the details, but it looks
great at first glance. We can still edit it a little bit when applying the
patchset, but that may not be necessary.

Thanks,
Song

>
> ##### Backgroud
>
> Our testers started to test raid10 last year, and we found that there
> are lots of problem in the following test scenario:
>
> - add or remove disks to the array
> - issue io to the array
