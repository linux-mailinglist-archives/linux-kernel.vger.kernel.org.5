Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D987B25C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjI1TPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 15:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjI1TPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 15:15:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84519F;
        Thu, 28 Sep 2023 12:15:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7827C433C9;
        Thu, 28 Sep 2023 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695928533;
        bh=PmSQ/FB4sDVPgHeFaPw6PA6l5YgUDHfxaN1c2oSByZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BvKdts8kfTlOvNJcvxbEnLGm8Z7iB5UKNZPPVqkGsF0wWQ43r+Od8TNIRDDwqWsDw
         lTQsUnHirJnIBiOK0sRGnYt6lekGVPbgc+fRsLNPC++IOvzK8rhoWRFvsod6w3ROtF
         1UQFgr4mzesgWKFlctQvSY/zpRVplItvUpcfB/gnYyTim+rIemrk3sCTP8q+nm2wOY
         UtG9jun2C0FrJ1iWer/Zw/sb0lcVRkl4m8o2WMlJimeza+JBoLoHEFdoQok9n0Ff3o
         dQG71oc16g3FZd63HqFx61y4M2w4coBYsiE/2Glffd46gM6mT0EBHy2FiHobRB03Dt
         PVJ64J/7BWqbA==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5041bb9ce51so21139127e87.1;
        Thu, 28 Sep 2023 12:15:33 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx+dFKJwSy5lCbR+V3Ml0JFr7z9xIf9Z/d2ydiVHgohZu6ZlDYr
        DOR0ZwgAoGj7vTKQkGmz5sOl6Yb7x0WjrRnimhQ=
X-Google-Smtp-Source: AGHT+IEO1NmBSmnMxdEBJpHkUAXkaiTeoWOqTDYI2wL3GtNpnOuZ8NDHwQUXWf51YZnh8VhWkg0jh50rQABdPgFYg7Y=
X-Received: by 2002:a05:6512:1388:b0:500:97e4:587e with SMTP id
 fc8-20020a056512138800b0050097e4587emr2412880lfb.44.1695928532085; Thu, 28
 Sep 2023 12:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230928061543.1845742-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 28 Sep 2023 12:15:19 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5cUgqy9fqj+Z4nGPQrAok-eQ=NipNxb0TL_kuCFaPMcw@mail.gmail.com>
Message-ID: <CAPhsuW5cUgqy9fqj+Z4nGPQrAok-eQ=NipNxb0TL_kuCFaPMcw@mail.gmail.com>
Subject: Re: [PATCH -next v3 00/25] md: synchronize io with array reconfiguration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     xni@redhat.com, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
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

Hi Kuai,

Thanks for the patchset!

A few high level questions/suggestions:

1. This is a big change that needs a lot of explanation. While you managed =
to
keep each patch relatively small (great job btw), it is not very clear why =
we
need these changes. Specifically, we are adding a new mutex, it is worth
mentioning why we cannot achieve the same goal without it. Please add
more information in the cover letter. We will put part of the cover letter =
in
the merge commit.

2. In the cover letter, please also highlight that we are removing
 MD_ALLOW_SB_UPDATE and MD_UPDATING_SB. This is a big improvement.

3. Please rearrange the patch set so that the two "READ_ONCE/WRITE_ONCE"
patches are at the beginning.

4. Please consider merging some patches. Current "add-api =3D> use-api =3D>
remove-old-api" makes it tricky to follow what is being changed. For this s=
et,
I found the diff of the whole set easier to follow than some of the big pat=
ches.

Thanks again for your hard work into this!
Song

On Wed, Sep 27, 2023 at 11:22=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> =
wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
[...]
