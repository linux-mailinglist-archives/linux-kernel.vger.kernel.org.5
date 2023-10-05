Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2857BA2AD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjJEPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjJEPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:44:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C17513C89;
        Thu,  5 Oct 2023 07:32:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E9FC433C9;
        Thu,  5 Oct 2023 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696478137;
        bh=wuWCiZeLK8eowg0O1RUlNwG96Sm5kArsyTUGbyYKRws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rgPbuVAluwPxpi4o0Q5OiMpObQXVAVRC6cUA3FTkSG9X1IDs0OK4RL2F2NNLzkhLN
         y4tQmU3rWMB/LJNkl+b65SknX11Z+lSH8vqnLn8gNq8NroAWket/rdO79wyXeAgxY7
         KoMoOvFlKjWuznhJPN3bthvcnXx1LpZ8DHyRUM08s0dn8QdCw9jCsW91LhnGt6H0in
         w742IPIkZKhMBVWv5xG/NAiAUpIu8shnOBz85h5kFcA8UbSsoK/lxek722OGBpaI7r
         PFRd5qRY5xIz0WZG+IGsQSo6WnCK8rkJuRp+d/+8oxePcAuS2xqYMd9NMP74NFExKD
         GznZbPFb0PxOw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50337b43ee6so657387e87.3;
        Wed, 04 Oct 2023 20:55:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YzwlBqXlCVdBWxqHZYhguBBwtxiiyTo7gTvrd/RtvZ2c0+M6CgJ
        20v5cod3UP226lP28aov5A39N6lnp/hJXkohGH0=
X-Google-Smtp-Source: AGHT+IF4f5QmJaGGVsNqoYOF0xWkXAqZSUr24CPLmmG2eoBzxwZx9lS3Df5pF0TkOAs5eR6dHn8LDX9R5GAPIAxf2z8=
X-Received: by 2002:a19:8c0e:0:b0:500:bc14:3e06 with SMTP id
 o14-20020a198c0e000000b00500bc143e06mr3731394lfd.44.1696478135549; Wed, 04
 Oct 2023 20:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
 <CAPhsuW5cUgqy9fqj+Z4nGPQrAok-eQ=NipNxb0TL_kuCFaPMcw@mail.gmail.com> <f59cbb99-33dd-c427-2e43-5a07ab9fbf51@huaweicloud.com>
In-Reply-To: <f59cbb99-33dd-c427-2e43-5a07ab9fbf51@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 4 Oct 2023 20:55:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7TRODsR_N95AmXJCZvpTuSKgbOjnYGxMGAWtmt3x9Vkw@mail.gmail.com>
Message-ID: <CAPhsuW7TRODsR_N95AmXJCZvpTuSKgbOjnYGxMGAWtmt3x9Vkw@mail.gmail.com>
Subject: Re: [PATCH -next v3 00/25] md: synchronize io with array reconfiguration
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

On Wed, Oct 4, 2023 at 8:42=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2023/09/29 3:15, Song Liu =E5=86=99=E9=81=93:
> > Hi Kuai,
> >
> > Thanks for the patchset!
> >
> > A few high level questions/suggestions:
>
> Thanks a lot for these!
> >
> > 1. This is a big change that needs a lot of explanation. While you mana=
ged to
> > keep each patch relatively small (great job btw), it is not very clear =
why we
> > need these changes. Specifically, we are adding a new mutex, it is wort=
h
> > mentioning why we cannot achieve the same goal without it. Please add
> > more information in the cover letter. We will put part of the cover let=
ter in
> > the merge commit.
>
> Yeah, I realize that I explain too little. I will add background and
> design.
> >
> > 2. In the cover letter, please also highlight that we are removing
> >   MD_ALLOW_SB_UPDATE and MD_UPDATING_SB. This is a big improvement.
> >
>
> Okay.
> > 3. Please rearrange the patch set so that the two "READ_ONCE/WRITE_ONCE=
"
> > patches are at the beginning.
>
> Okay.
> >
> > 4. Please consider merging some patches. Current "add-api =3D> use-api =
=3D>
> > remove-old-api" makes it tricky to follow what is being changed. For th=
is set,
> > I found the diff of the whole set easier to follow than some of the big=
 patches.
> I refer to some other big patchset to replace an old api, for example:
>
> https://lore.kernel.org/all/20230818123232.2269-1-jack@suse.cz/

Yes, this is a safe way to replace old APIs. Since the scale of this
patchset is
smaller, I was thinking it might not be necessary to go that path. But
I will let
you make the decision.

> Currently I prefer to use one patch for each function point. And I do
> merged some patches in this version, and for remaining patches, do you
> prefer to use one patch for one file instead of one function point?(For
> example, merge patch 10-12 for md/raid5-cache, and 13-16 for md/raid5).

I think 10 should be a separate patch, and we can merge 11 and 12. We can
merge 13-16, and maybe also 5-7 and 18-20.

Thanks,
Song
