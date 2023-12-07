Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15A6808FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443578AbjLGSPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjLGSPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:15:38 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9097310E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:15:44 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b6f19f3af9so35258339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 10:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701972944; x=1702577744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4OjwNy8mbYcl7XPkSSgPHOa+dg/ygA00wlk4vTz/nQ=;
        b=LD5pRtYKXE8ostzbgZeFos6wUmsjoOh1aRrzvBjfU6/mo6kQn1B6qq5Mm3Dl1DUiHU
         KKTZRHLRTOQnbR0Vaug0r9TirzbR4416+UdF+tYEHmCUQci9J0k/ipaM32Tjg3/pOzb8
         yI5r/fCt+7PKDf730hM60mBa+WPktpkI6UxR/BcaEwKnAGmeS6Vyk9hCEHen53jwVaXm
         wM1DY8sdoo2Exb6yktHh6KSaNPrlF7ZiEFeTlDfIQZJEWx9OiMEM3tiobaIgqYDg2lHA
         Xyr4lI8n28yPSjzcQhNxzy6w7mTvp+jTaleO1kEXU6TL+3DXhnkz56gCRA+ZjME9jjGp
         sY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972944; x=1702577744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4OjwNy8mbYcl7XPkSSgPHOa+dg/ygA00wlk4vTz/nQ=;
        b=X0KwdHEF9OUj/lT2IadvTiasBESsojQseZdj5EVOqK4cs/abjlu4luH3f9MR+hsN1M
         ZK5PuPdwmHu46sxrs+bycMStigzr0eGiJR1lgjeNmlCtz52vctY54ieZfkcibA+FRGna
         wllg8lVvWDj+CnVm4mMEFGis4I8uFTmC6eI4sA+sVw03ixM2CQ7MmEoCzZwXnVGwzsrh
         KPUnbmVpIJAG15awDSDmuMkmtGYXOnq/0QOa4/nKyBa26Ilxq8K5AyR2nibOg9DEkAaN
         tY288GALAlnWw0buaZgX25BGYZKHecZRJO2t8l0UDajmBdXJKqopuVTyS7L99lJgai2S
         U+3A==
X-Gm-Message-State: AOJu0Yx2WjJnuK0qfgRn/xtNFh6ZCVZCOmv7Kyut1dtGtZoU2Oi9xgOy
        HfQqtbTAm1CUOeikS9nnzkJ5vpXBcpbtPzyb+/s=
X-Google-Smtp-Source: AGHT+IHvOAiE2ju1GBZ/CFHTHGpNGr5Vi2yEZRVmfREFCMD3Vl7ucKNaRzMspe0VPKbiMSg0BdH4+eOvpvJeIDGnMOU=
X-Received: by 2002:a05:6602:3981:b0:79f:da3d:c47f with SMTP id
 bw1-20020a056602398100b0079fda3dc47fmr4069859iob.13.1701972943812; Thu, 07
 Dec 2023 10:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=OqMK881u3kPB99KX_9UWreddz-cUT5ArzdwpHwQjQ6yA@mail.gmail.com>
 <ee7631a5-b167-43d9-af19-a5a12dcac03a@bytedance.com> <6bf18314-7749-476e-aece-064ecfb0dffc@bytedance.com>
In-Reply-To: <6bf18314-7749-476e-aece-064ecfb0dffc@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 7 Dec 2023 10:15:32 -0800
Message-ID: <CAKEwX=NX5T1AL6jXuW0oonW_GtPOos+oXdWGAE3hxdWQyavBPA@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 7:18=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> On 2023/12/7 11:13, Chengming Zhou wrote:
> > On 2023/12/7 04:08, Nhat Pham wrote:
> >> On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
> >> <zhouchengming@bytedance.com> wrote:
> >>> When testing the zswap performance by using kernel build -j32 in a tm=
pfs
> >>> directory, I found the scalability of zswap rb-tree is not good, whic=
h
> >>> is protected by the only spinlock. That would cause heavy lock conten=
tion
> >>> if multiple tasks zswap_store/load concurrently.
> >>>
> >>> So a simple solution is to split the only one zswap rb-tree into mult=
iple
> >>> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This id=
ea is
> >>> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB tr=
unks").
> >>>
> >>> Although this method can't solve the spinlock contention completely, =
it
> >>> can mitigate much of that contention.
> >>
> >> By how much? Do you have any stats to estimate the amount of
> >> contention and the reduction by this patch?
> >
> > Actually, I did some test using the linux-next 20231205 yesterday.
> >
> > Testcase: memory.max =3D 2G, zswap enabled, make -j32 in tmpfs.
> >
> >                       20231205        +patchset
> > 1. !shrinker_enabled:   156s          126s
> > 2.  shrinker_enabled:   79s           70s
> >
> > I think your zswap shrinker fix patch can solve !shrinker_enabled case.
> >
> > So will test again today using the new mm-unstable branch.
> >
>
> Updated test data based on today's mm-unstable branch:
>
>                         mm-unstable     +patchset
> 1. !shrinker_enabled:   86s             74s
> 2.  shrinker_enabled:   63s             61s
>
> Shows much less optimization for the shrinker_enabled case, but still
> much optimization for the !shrinker_enabled case.
>
> Thanks!

I'm gonna assume this is build time since it makes the zswap shrinker
look pretty good :)
I think this just means some of the gains between this patchset and
the zswap shrinker overlaps. But on the positive note:

a) Both are complementary, i.e enable both (bottom right corner) gives
us the best result.
b) Each individual change improves the runtime. If you disable the
shrinker, then this patch helps tremendously, so we're onto something.
c) The !shrinker_enabled is no longer *too* bad - once again, thanks
for noticing the regression and help me fix it! In fact, every cell
improves compared to the last run. Woohoo!
