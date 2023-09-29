Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513D7B29A7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjI2Aiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2Aio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:38:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BAAB3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:38:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b281a2aa94so1187454066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695947921; x=1696552721; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45d+IBpPQ99/+1Gj6Jf9YvBwKOBDNkQcunQHUXPJFp8=;
        b=nrXga9XZXBtC18XqoWXmLMaPA62wTjkwn2TYQbdLEBeyr75m4VnJ+lpbvILCUxJfAg
         mDqYmYcl6yFbno0W/6PHOmYadFpHimnH4Y74hUNJjK99xbCVFOQjOPOg+wfnEpH6jdgS
         rdX1ga885dtgTvx4Y7ETsZRgqwbfNRxB7dhDQPfs/ZsyxDNjsvY+/dr44FcSH1O9MVY3
         7l6sLOWaCP70kXO6kJJzbUWYUDAf2zoTeDlGxV1yqPZWdsKTQhKczqglIbZpU6Y8TvJV
         zfkXphyoeAek1d5Kn4crG+9fvBc7S0YAYwPBtEjlnUtp02BZapUv1D32ihVQFphotthg
         bRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947921; x=1696552721;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45d+IBpPQ99/+1Gj6Jf9YvBwKOBDNkQcunQHUXPJFp8=;
        b=Wp8QvnccL06L3kOpd4r9fVwGnFuSd5orXu7CJOVKuPMUiSZe6za8QlkSbhQT+A85TA
         AXTgs97FldJmJBVlHr+qQFT+MGWB7+bBHnSPnFaBHmDcoikh9VVwAAC6R8rmWEDHR2Vi
         4OwpqbhqAKRM7Fme9oBVmw1bZ4TFmAZIkAiJlQFtC1JRJ0ghHfzjmyeYrn8wqbFG5Nem
         VRAv99wOk3t08tk1om3gknOk0wNzSMFWGeYhXhaQNWRi4NXJ8o4zU5/G5VrKCRQoD3WZ
         qhf/EGiKDYF4/ijOf4vLdnp1Tn0UdrIUGLkcrcbB5g+u3OeO0qmd22O7MHPDF+QTjRod
         EwVQ==
X-Gm-Message-State: AOJu0Yzs0DZUCqs0yQKozsbNScSr0BSOZBfnXk0yp6qCU4/Qwe4QYpr9
        5C+Ytfp34oFkgPufFwaxBcLye2QnUdU/9VJ/gG86aQ==
X-Google-Smtp-Source: AGHT+IEpi/1or+NKN/RfJkcGWCFTZxjbKVATnUt74MN/BxUwEMwAr8ylk7EU3yfD119SsDCYLFHYCtHNfM5R6qnD9EY=
X-Received: by 2002:a17:907:7801:b0:9ae:72b8:4a84 with SMTP id
 la1-20020a170907780100b009ae72b84a84mr2276590ejc.41.1695947921024; Thu, 28
 Sep 2023 17:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230928005723.1709119-1-nphamcs@gmail.com> <20230928005723.1709119-2-nphamcs@gmail.com>
In-Reply-To: <20230928005723.1709119-2-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 28 Sep 2023 17:38:01 -0700
Message-ID: <CAJD7tkanr99d_Y=LefQTFsykyiO5oZpPUC=suD3P-L5eS=0SXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlb: memcg: account hugetlb-backed memory in
 memory controller
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>
> +
> +/**
> + * mem_cgroup_hugetlb_charge_folio - Charge a newly allocated hugetlb folio.
> + * @folio: folio to charge.
> + * @gfp: reclaim mode
> + *
> + * This function charges an allocated hugetlbf folio to the memcg of the
> + * current task.
> + *
> + * Returns 0 on success. Otherwise, an error code is returned.
> + */
> +int mem_cgroup_hugetlb_charge_folio(struct folio *folio, gfp_t gfp)
> +{
> +       struct mem_cgroup *memcg;
> +       int ret;
> +
> +       if (mem_cgroup_disabled() ||
> +               !(cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING))

What happens if the memory controller is mounted in a cgroup v1
hierarchy? It appears to me that we *will* go through with hugetlb
charging in this case?

>
> +               return 0;
> +
> +       memcg = get_mem_cgroup_from_current();
> +       ret = charge_memcg(folio, memcg, gfp);
> +       mem_cgroup_put(memcg);
> +
> +       return ret;
> +}
> +
>  /**
>   * mem_cgroup_swapin_charge_folio - Charge a newly allocated folio for swapin.
>   * @folio: folio to charge.
> --
> 2.34.1
