Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D1078E140
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjH3VO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbjH3VO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:14:57 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADE4E49
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:14:28 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so1115425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693429693; x=1694034493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esGoaQrESWSgCrgMWkkf+OpwvlwkuP7zEkdpc5VTaeg=;
        b=chYsDXoxEx+mvA78qcfXVPu2t1aVUQVv11EZCsXcLlvCB/9TkrTYyW+SRBmX4cG0sP
         Sl6004gWHJr2Y3wWGu29+Jn+6UI5Nhf+TYvcUcTeU3L/tUmp9t2Iaatg1/stGHEWslBY
         ACyQ+Xm0Z8LB4EzMx6c5rMhLkyw1ESvtujxMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429693; x=1694034493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esGoaQrESWSgCrgMWkkf+OpwvlwkuP7zEkdpc5VTaeg=;
        b=BRjkGSP2tYYzhdvNR/G8s9m/MEo089P/sHKM4fvhRssq9WQ4T16fIYDPEP+we+D96B
         2B/cmlR6o9+SOYgUxIqrK5fo3Dk2rcETKH799HLVhqFpXfupTbQ9zU7W2VcHKsUuqc2D
         doVXDRvkT53/nDR6ABJmg/Z76zK1QfxYHjFJF/K5jXkCi31JLTfFIUT4lVQmZMewqTtI
         OtyLLowiOpj2YLfM0NeYvvjP5sCSdSpZItDWUaUbnq0/RiYHD6UEUuTIdPNYQghZLE2B
         nST2H/OVNMMutDHc4rE+0DL1w1NsCa62+ESw1bOowTmp2ZIg8D/DwYMna2EyYT2V5cfu
         CEdA==
X-Gm-Message-State: AOJu0YwCL7LWSHfDfO/INcgaLeZ7pM9+8tDZ5RdydKYdRVocG4GhaTct
        WkXRe/j4OIl3axAX+pSURmiysZQ8KsMb1fb5bsZsv4DN
X-Google-Smtp-Source: AGHT+IFLnP4lRs/PE+ajmvCUP0rY8UdzvNoymkchhTDJOTp0eCeOL1DrU/vhUPkS+pi++PkwcqynCg==
X-Received: by 2002:aa7:c6ce:0:b0:51e:362d:b172 with SMTP id b14-20020aa7c6ce000000b0051e362db172mr2365657eds.32.1693428879080;
        Wed, 30 Aug 2023 13:54:39 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b0052bdfc9b8dbsm9229edy.92.2023.08.30.13.54.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:54:38 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so32475e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:54:38 -0700 (PDT)
X-Received: by 2002:a05:600c:6020:b0:3f7:3e85:36a with SMTP id
 az32-20020a05600c602000b003f73e85036amr5538wmb.7.1693428878194; Wed, 30 Aug
 2023 13:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693416477.git.mirq-linux@rere.qmqm.pl> <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <56ae0bf828d942c92ca867afb3aae95fcabd5498.1693416477.git.mirq-linux@rere.qmqm.pl>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 13:54:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uzu=37nqGZYu4cU7fMMV2u+e8-GF1+izcvusOT+a1f=Q@mail.gmail.com>
Message-ID: <CAD=FV=Uzu=37nqGZYu4cU7fMMV2u+e8-GF1+izcvusOT+a1f=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] regulator/core: regulator_lock_nested: simplify
 nested locking
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 10:35=E2=80=AFAM Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:
>
> Simplify regulator locking by removing locking around locking.
> rdev->ref check when unlocking is moved inside the critical section.
>
> This patch depends on commit 12235da8c80a ("kernel/locking: Add context
> to ww_mutex_trylock()").
>
> Note: return -EALREADY is removed as no caller depends on it and in that
> case the lock count is incremented anyway.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)

Note that I didn't actually provide a Reviewed-by on this patch in v1.
I was hoping for something in the commit message that explained why
commit 12235da8c80a ("kernel/locking: Add context to
ww_mutex_trylock()") meant that we didn't need the extra lock. You
responded to the v1, but didn't add anything to the commit message
about it.

Looking at your response to v1, I'm not sure it helps enlighten me on
why adding the context removed the need for the extra lock. Can you
add more words? Pretend I don't know anything about ww_mutex, which is
not far from the truth since every time I look at ww_mutex I have to
re-learn how it works. :-P Specifically, what would actually have been
broken without the extra lock but before the context was added?


-Doug
