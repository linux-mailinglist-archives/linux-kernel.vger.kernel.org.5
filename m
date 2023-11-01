Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16597DE02D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbjKALL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjKALLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:11:55 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1139DFC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 04:11:48 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso92461161fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698837106; x=1699441906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WljMIn9oOVQ8xvgl/cyiqAsCMw6Ur1FNTMuZ2oBE+gw=;
        b=EiD8IRTAcbxeZLYteg296XQlerco54RyGGC+tc6wu+uf5ffFOII7WNDwO2r1fX3SgT
         Y4PUBMiM/6wO7lvP1iV58KZ2I/9TTChZTs95P6/wO9YIBnR67LSCdUcEmT2LXDua3WE3
         xTk/OkowTg0E3mtN8aAmYKSHiJicRRWEwiJNjVnJEKsbfyJsKEuR7b06d/jfFvHyaIR6
         RzrIYtBiUasApFXhkIaZMHOetSZR8WBdQNxpcP9sB5ZkwojWRhCvpIFkAJICl560Fqis
         mEANTNW+QdYkKaETOi0ljA5SoTF36ReJayvLZ+wXtrQIwEjmkL4e3IAAa1gN+BYRK2QY
         B3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698837106; x=1699441906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WljMIn9oOVQ8xvgl/cyiqAsCMw6Ur1FNTMuZ2oBE+gw=;
        b=lKydDqmxVgyUMorSX09gCesW/U1ItpA65xTmfIXjpHF82rib5CdTbHuK76RbgpTu0s
         Tn476S4PA43UuuBuUxNUs3bQNVKmKkve+/yClDRH7bYEGpwwj7oQyHZdGzM/qKUeVoEV
         zXugv2YR8MhaszU1ucQYAl90Llmpa+MRfrlcLDTtVen4Wfe7UtFuaE7R9mumop6/rZnq
         cl7okJbGSzwuuBvzTlEBb8EOlDUH1tLYWS2SnZsaiA2qbm1skiSCvNZ4ntVlOZZPg3K5
         vxzdV9A8JaS7fqYgVYkAU6kF/jhyMKevL8HTJ9vdHoprAj65K/1cjgKoi6gkvb3VdWLK
         gusg==
X-Gm-Message-State: AOJu0YwzzfyoNVvQINNzqbUtD/B6mUU1mG408cuV7/pq9YVIW9UiuZAl
        68bZ5Maw1VPJ9WPfWBCLhQlbnTCv4S9cdyzLoedQFA==
X-Google-Smtp-Source: AGHT+IEERy59/IWp+6dIDuWyJKEXUBb4ORPPPzSmdWnQwEDxVK4Rm6OzsdMBvXm42b1Hb5I5OFDnRRjHTqziQDUvCJs=
X-Received: by 2002:ac2:4846:0:b0:507:aaa4:e3b3 with SMTP id
 6-20020ac24846000000b00507aaa4e3b3mr10709203lfy.50.1698837106260; Wed, 01 Nov
 2023 04:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231030091256.2915394-1-shaojijie@huawei.com>
In-Reply-To: <20231030091256.2915394-1-shaojijie@huawei.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Wed, 1 Nov 2023 13:11:10 +0200
Message-ID: <CAC_iWj+V8KB2TE=6e0z4SRoq7pY+3gStKawX_-8UfYh+cP9ndQ@mail.gmail.com>
Subject: Re: [PATCH net] net: page_pool: add missing free_percpu when
 page_pool_init fail
To:     Jijie Shao <shaojijie@huawei.com>
Cc:     hawk@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jdamato@fastly.com,
        shenjian15@huawei.com, wangjie125@huawei.com,
        liuyonglong@huawei.com, linyunsheng@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 11:17, Jijie Shao <shaojijie@huawei.com> wrote:
>
> From: Jian Shen <shenjian15@huawei.com>
>
> When ptr_ring_init() returns failure in page_pool_init(), free_percpu()
> is not called to free pool->recycle_stats, which may cause memory
> leak.
>
> Fixes: ad6fa1e1ab1b ("page_pool: Add recycle stats")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  net/core/page_pool.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 77cb75e63aca..31f923e7b5c4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -221,8 +221,12 @@ static int page_pool_init(struct page_pool *pool,
>                 return -ENOMEM;
>  #endif
>
> -       if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0)
> +       if (ptr_ring_init(&pool->ring, ring_qsize, GFP_KERNEL) < 0) {
> +#ifdef CONFIG_PAGE_POOL_STATS
> +               free_percpu(pool->recycle_stats);
> +#endif
>                 return -ENOMEM;
> +       }
>
>         atomic_set(&pool->pages_state_release_cnt, 0);
>
> --
> 2.30.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
