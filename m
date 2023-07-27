Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28272765B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjG0SJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjG0SJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:09:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B72D64
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:09:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bcf2de59cso174336466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690481379; x=1691086179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFXw2+/KjQw8lFjUIikFW0fpJeY+CVFCOxN28DSc2EU=;
        b=u9Lcnt4AIVuUkFcAGaUnmpymF9rWEHPvOXpXB6dGhP3BOSP7gSH4v2E6z5lSYZkUyl
         0v0unc1ZvcWA6/dofZ0iAsJjUnlcOrkw/t7VbQf1vBMncRJymzx0Ob/i5xWsHuiHyJro
         mzdinAzZaleSfyM792cjxJXh+8ckauv3PEYzY9/oc25YwSgah//rUVvFFyDofJBQaSUr
         8wcgis6hBaE7K9wTpAQKokZufhksFyM28GVWKljwbLQ4MB9Fbe4YxjOea7Wx1UfRnC8C
         EZ51XNS29AKcr+QSK8p3pvrewa2uFhVr+Z1yc5cFpat5gIvM/b+T0u+1Iwi79EfmO1nS
         evfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481379; x=1691086179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFXw2+/KjQw8lFjUIikFW0fpJeY+CVFCOxN28DSc2EU=;
        b=JRrDKbYCgZF7NPfktk2WJB2OHzEimVpi621LZ1QplPL4NyeLgKUt5cX3utBNLB/kRR
         AdH8NA3wliBGSNBXE8kDAEZsfGNIbybUGiMh9Q6ZGp6VPryCZHosCkHcVH6NxCQPK9G2
         wY3ZO6gQ/DI7JAjIPejbGhLDUBEUTEmqowWuxlxUPnBg8hJWtWAPWHoL/3xlnYGmLaJ7
         57fnEyKWSwZNPaSKpGs7yMKFRG9ekbpQxfCETbdPBqItYk+uWTjO1ajFA5FBq37iaa6X
         UNWx1mfE529027jDtxmdkrpAEycjq5VLdBpXUGAZ1Al+CCIPvjM4RcHNHnwyLGAhumXn
         5akg==
X-Gm-Message-State: ABy/qLY+LA/LdkwkyaK6Sw150WDKzPzXTrawPZkdzMwfyxpd0YqmP28g
        q09VIQHJrkHRpjRSJX+5aGgB3Saw+Els2YaRXkYIrw==
X-Google-Smtp-Source: APBJJlHl5UMe26ZqOdJ7Wb5Cc+wP3dMkf8dMEosn/hCK/e11IH0Aq0+Ky3eDwmpJR1ZDe9gPp7oy/Y9Rf8VFX5KTgeU=
X-Received: by 2002:a17:907:2cc8:b0:99b:cc2f:c47c with SMTP id
 hg8-20020a1709072cc800b0099bcc2fc47cmr2592178ejc.53.1690481379333; Thu, 27
 Jul 2023 11:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162343.1415598-1-hannes@cmpxchg.org> <20230727162343.1415598-2-hannes@cmpxchg.org>
In-Reply-To: <20230727162343.1415598-2-hannes@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 27 Jul 2023 11:09:03 -0700
Message-ID: <CAJD7tkatLxSd_qv_g1AS-5dEZrX1RYHrqjUuzee8iOvo+eRxAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: zswap: use zswap_invalidate_entry() for duplicates
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 9:23=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Minor cleanup. Instead of open-coding the tree deletion and the put,
> use the zswap_invalidate_entry() convenience helper.
>
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

> ---
>  mm/zswap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 583ef7b84dc3..e123b1c7981c 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1344,9 +1344,7 @@ bool zswap_store(struct page *page)
>         spin_lock(&tree->lock);
>         while (zswap_rb_insert(&tree->rbroot, entry, &dupentry) =3D=3D -E=
EXIST) {
>                 zswap_duplicate_entry++;
> -               /* remove from rbtree */
> -               zswap_rb_erase(&tree->rbroot, dupentry);
> -               zswap_entry_put(tree, dupentry);
> +               zswap_invalidate_entry(tree, dupentry);
>         }
>         if (entry->length) {
>                 spin_lock(&entry->pool->lru_lock);
> --
> 2.41.0
>
