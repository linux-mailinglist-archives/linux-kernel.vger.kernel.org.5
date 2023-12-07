Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1A807D64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 01:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441909AbjLGAoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 19:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjLGAoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 19:44:04 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AD9E0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 16:44:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-286d6c9ce6dso411199a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 16:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701909850; x=1702514650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DqbVFJwL0a1ATt96jtGqFDNW6gtbbBO5rdQ1Nc1S/s=;
        b=ldpKWhiGeQeG9UGmVdAZdvz/LZe353mAg3RT7IjWDzwAcDOkH94kg4iMUlQSmakkH/
         qNFxmCtKqff2GNYSpNxmRVIFl4N+ryHxDbhRFLuGK5EW7T+CosxInwCUZTzUxCVeJWhk
         aDIvwMp5KWwYemN4Lyj3R2mCEk4g8pSORESv6PGDU1kf8dM0zNuVI4bVQ1MJKGyKVTKq
         eTW54hL+/nMB2+/abG9IYK0W+g07S/yAfqHe2LOingiAiGoUt9UFnz+/BIPOtKJXR/bR
         RUw3Sevc7n76EQ366KJOEPU/rHp5VQrodyZFSjxZrZr30mmVHXmzvgtM9t3KOaa+S0wv
         BIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701909850; x=1702514650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DqbVFJwL0a1ATt96jtGqFDNW6gtbbBO5rdQ1Nc1S/s=;
        b=M4gKL7Bbl9l2j1DL3OOlvdHdrz3k+OXJALRfP/JzDKlaAMBl343KSsr4WhOYqtXx0Q
         cqTVvQ2i483qo3qufYucPCb8sLXT1KIqMvfhp6+mFgSvcYL+0KAd3IJT6lGc96EaQnkz
         gt6CVfjTbAphnjOSO2vL0qjHCb6hJBXQQGJDKr18iCwUs20RGxftVKdn4719BIj68tTS
         EZPVzGTuxNR1oWZxn3TsVPqVxlWImfkWFj+o9izDT6eFLmb6iWjLWMH/Nshl8hzBbMLk
         FFtj2fvq2WSCNrLS4/ojgb1aeg077osPDnoA4QXHh+VYtnENEcFJIR7PIjSs5ey9UU4r
         6zqA==
X-Gm-Message-State: AOJu0YxS7vFWZ/vE2s3nY7KfNyEGY8z9y4VwefeD/dJfazeLVpX8S8HU
        NPKXCnJUBCzLHRJ1QmGmmJpDxAfz8cNo4KDfdL0Ccg==
X-Google-Smtp-Source: AGHT+IHbH12/27Dox62nWh31rnKZQQkO/EPVQAE4ObuI78sX9/bx8m37n7+pZtIAUV1UuCGd3+ftv5vf3lGpwqUF31M=
X-Received: by 2002:a17:90b:314a:b0:286:9e2f:4755 with SMTP id
 ip10-20020a17090b314a00b002869e2f4755mr1715556pjb.51.1701909850021; Wed, 06
 Dec 2023 16:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
 <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com> <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbErWz7Rjn-JdY8LjSW=GzEyyrNeJ5P1ipChFSufmQmLQ@mail.gmail.com>
From:   Chris Li <chriscli@google.com>
Date:   Wed, 6 Dec 2023 16:43:58 -0800
Message-ID: <CAF8kJuMegmMD3+YZfvsW3h1y1z1-kH7SiyJHPVnrSc89OZASuA@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat and Yosry,

On Wed, Dec 6, 2023 at 12:42=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Dec 6, 2023 at 9:24=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > + Chris Li
> >
> > Chris, I vaguely remember from our last conversation that you have
> > some concurrent efforts to use xarray here right?

Yes, I do have the zswap xarray for older versions of the kernel. The
recent mm-unstable tree has  a lot of zswap related updates. Give me 2
days to refresh and post it. The zswap invalid entry and the reference
count change is causing a good portion of the code to be updated. That
is the price to pay keeping out of tree patches. My fault is not
getting to it sooner.

>
> If I recall correctly, the xarray already reduces the lock contention
> as lookups are lockless, but Chris knows more here. As you mentioned

Yes. To be exact, xarray can use spin lock (same as current RB tree)
or take RCU read lock on the lookup path (depending on how you call
the xarray API). Not completely lockless but the RCU read lock should
have less lock contention than normal spinlock. +Matthew

> in a different email, it would be nice to get some data so that we can
> compare different solutions.

Yes, it is certainly welcome to see more data points. If I recall
correctly, the zswap xarray array makes the lookup similar to the swap
cache lookup. It has a noticeable difference in the long tail end.

Stay tuned.

Chris
