Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8F7F6DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjKXIRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjKXIRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:17:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4F4D44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:17:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF90C433C7;
        Fri, 24 Nov 2023 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700813868;
        bh=My6t/4lELH5lffuRbzYd/07LMKGvpSJ4RoXCARNgkfc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=khh6aaIl0PDLiDwRLm1pyeU7WmQFiNwYErtC9tBfDOu7bfy/IMAZJVuMKFGirFTUs
         gqW02cLjr2IgC4xb51iXPr9iPmjpXx/d1ApF2B7rdpPPbUAhMXkcliclPjYn7h4ezx
         RGDlxSrTQYdU8V8H4TGa7HKEZMoX0MI30CksamvuAEn/mkm5Z+R6p77DPfGd7XMPop
         cuKP35HG783mYpa4RNQBPh6uyZ8r4LaTKHMXJHzuKSApuM50cLoK16mP+NY78ERPYn
         6uZ1Tv1032s50oAKeOQ1I1V8myYvZaeB8jvqwNSyUOlm/AUiWQlJPViNayxA0VdxcV
         Vl0kqNXZdR3uw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso20576011fa.3;
        Fri, 24 Nov 2023 00:17:48 -0800 (PST)
X-Gm-Message-State: AOJu0YzJpcQgEe/kQOUGzywoUelvfFbOPEMnVMwEfDAQMW60AWLJsW+D
        StxLYl/gl1CxbTvQ4LJXT8QP3xflgzyjsMfdnMg=
X-Google-Smtp-Source: AGHT+IH/OSNw7GQoUF5Ms8HgzQc7uOhLywTmR57ZZJe1sQFjm1lQQayj3fLZt2Np94PYPdVOWDSDMIL0O5X3n4RiLx8=
X-Received: by 2002:a2e:a41b:0:b0:2bc:b557:cee9 with SMTP id
 p27-20020a2ea41b000000b002bcb557cee9mr1419511ljn.43.1700813866356; Fri, 24
 Nov 2023 00:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20231021102059.3198284-1-yukuai1@huaweicloud.com> <20231021102059.3198284-2-yukuai1@huaweicloud.com>
In-Reply-To: <20231021102059.3198284-2-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 24 Nov 2023 00:17:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5=fDpsAofik+4jHObFkRMcTTeQPbtXSBG_KAes0YgQGA@mail.gmail.com>
Message-ID: <CAPhsuW5=fDpsAofik+4jHObFkRMcTTeQPbtXSBG_KAes0YgQGA@mail.gmail.com>
Subject: Re: [PATCH -next v2 1/6] md: remove useless debug code to print configuration
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 7:25=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> One the one hand, print_conf() can be called without grabbing
> 'reconfig_mtuex' and current rcu protection to access rdev through 'conf'
> is not safe. Fortunately, there is a separate rcu protection to access
> rdev from 'mddev->disks', and rdev is always removed from 'conf' before
> 'mddev->disks'.
>
> On the other hand, print_conf() is just used for debug,
> and user can always grab such information(/proc/mdstat and mdadm).
>
> There is no need to always enable this debug and try to fix misuse rcu
> protection for accessing rdev from 'conf', hence remove print_conf().
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

I wouldn't call these debug functions useless. There is probably some
users who use them for debugging (or even in some automations).
How hard is it to keep these functions? Can we just add some lockdep
to these functions to make sure they are called from safe places?

Thanks,
Song

[...]
