Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2F4807683
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378236AbjLFRYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjLFRYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:24:36 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D84584
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:24:43 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b3905b1b86so377635139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701883482; x=1702488282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFtw+JoIilNzXGrK1+eC18U9vk6uZG0kOBjgadIHka0=;
        b=MnejqmE5jBPm6sWmE608gloSJO4EShWcmsUSzBtgQvR8LOxXX2ctJ33TDvKkjCj/Ua
         E6Z2pawZpE/iQCOy+xFnuOHjRfULnuq0HuveKvGmaYwan4p1vjPwsV1MJvMFCWrC7fRt
         x2urupDDM2scNO5yNeXMIlMEsmf2MMHY+/b5IXzJNBO6WjLSKoLYE5LfOSm+IXcxzqVS
         rzdmJMPs7w9+Iw3Rudxapr0dwfeq5dACX/CMVQNGtEjxU1XmNGhAePj+z5qaS4vDEt/E
         g4QxUPA8OYAwN5JMIYc5vQxKwrb07MHMbtDI0efmlq+5bzCAXemt1lax227z3xX/FAUr
         daPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883482; x=1702488282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFtw+JoIilNzXGrK1+eC18U9vk6uZG0kOBjgadIHka0=;
        b=wYUxfGIoYl2r1GEyadSdeCDS0z3DIlu4zkKfuKIqQHHl2YuxfTYtd9i9ea7wRKjEZi
         C5pvrEhgRtq0hrKVdBPqh0XIrGN888kiPJXc3smaugtlQkUajLA3/06zQ+gTiFSX5IRU
         yvYh9T5HdB5msb5AeU3tIbb2pG3mrFXV98OrX1g9q0lth4MNJLaI6VCyTrhMk/CtgCca
         fL0tRPkl/2n5miUyMYEJj/7bXGmjLU6iNLaIaRcSFWlUiprvuubpL+e9YgtcME/Xy2Tc
         vclQDXcmYzO/wQt1NCo3FVBevi7PiEwqo+2BhfcE0tvs27zyCTOtcw6XZiJtZwrZaCUL
         FPbw==
X-Gm-Message-State: AOJu0YyPBUhj8k1TbWoH36YP4OXREbycBJamnS5DjvvgJju40lCNm3/k
        hbCIYnzYq3pQgGDnzQwaYjbFNIi8JdJDagR+9+c=
X-Google-Smtp-Source: AGHT+IH7S9uNub8N0q1SiSQSHC7lCi8nYYBBtFWhavsWZKjHB+uJudW8tQXA6tPZhyR9gH09WSBlAsXlpppM4xUVtFA=
X-Received: by 2002:a05:6602:29ca:b0:7b3:95d6:62df with SMTP id
 z10-20020a05660229ca00b007b395d662dfmr1830560ioq.21.1701883482412; Wed, 06
 Dec 2023 09:24:42 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 6 Dec 2023 09:24:31 -0800
Message-ID: <CAKEwX=NXcY3_GuKbh0=Ceg9wj=7u4y0NgmfSVEG3-+deY0jiWQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] mm/zswap: optimize the scalability of zswap rb-tree
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>
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

+ Chris Li

Chris, I vaguely remember from our last conversation that you have
some concurrent efforts to use xarray here right?

On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Hi everyone,
>
> This patch series is based on the linux-next 20231205, which depends on
> the "workload-specific and memory pressure-driven zswap writeback" series
> from Nhat Pham.
>
> When testing the zswap performance by using kernel build -j32 in a tmpfs
> directory, I found the scalability of zswap rb-tree is not good, which
> is protected by the only spinlock. That would cause heavy lock contention
> if multiple tasks zswap_store/load concurrently.
>
> So a simple solution is to split the only one zswap rb-tree into multiple
> rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M). This idea i=
s
> from the commit 4b3ef9daa4fc ("mm/swap: split swap cache into 64MB trunks=
").
>
> Although this method can't solve the spinlock contention completely, it
> can mitigate much of that contention.
>
> Another problem when testing the zswap using our default zsmalloc is that
> zswap_load() and zswap_writeback_entry() have to malloc a temporary memor=
y
> to support !zpool_can_sleep_mapped().
>
> Optimize it by reusing the percpu crypto_acomp_ctx->dstmem, which is also
> used by zswap_store() and protected by the same percpu crypto_acomp_ctx->=
mutex.
>
> Thanks for review and comment!
>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Seth Jennings <sjenning@redhat.com>
> To: Dan Streetman <ddstreet@ieee.org>
> To: Vitaly Wool <vitaly.wool@konsulko.com>
> To: Nhat Pham <nphamcs@gmail.com>
> To: Johannes Weiner <hannes@cmpxchg.org>
> To: Yosry Ahmed <yosryahmed@google.com>
> To: Michal Hocko <mhocko@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>
> ---
> Chengming Zhou (7):
>       mm/zswap: make sure each swapfile always have zswap rb-tree
>       mm/zswap: split zswap rb-tree
>       mm/zswap: reuse dstmem when decompress
>       mm/zswap: change dstmem size to one page
>       mm/zswap: refactor out __zswap_load()
>       mm/zswap: cleanup zswap_load()
>       mm/zswap: cleanup zswap_reclaim_entry()
>
>  include/linux/zswap.h |   4 +-
>  mm/swapfile.c         |  10 ++-
>  mm/zswap.c            | 233 +++++++++++++++++++++-----------------------=
------
>  3 files changed, 106 insertions(+), 141 deletions(-)
> ---
> base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
> change-id: 20231206-zswap-lock-optimize-06f45683b02b
>
> Best regards,
> --
> Chengming Zhou <zhouchengming@bytedance.com>
