Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEDB805DB8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345830AbjLESDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLESC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:02:58 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B874D40
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:03:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f85eff28so46542551fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701799383; x=1702404183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2joey/D+/Fter5JFQfAZeSyog4t3NYaVzZzIbt4q+Y=;
        b=K4NqijX6vzRxeN5fCvsWetxzBFw6RHkzrjJOLDgmkOqrYLrnEQ3/IaQLc5h8M3pY5f
         ecFe6bfGAlf/0KNTUgYgUyfkxEcwKS2JJ+htNv87SnIIFuJVBUtxFm8z5u+sSmn+4mJO
         HzHcnfWtHdPReGa9Lf/QP4BHM4djMBauSIbj/0om0skuCWZpx5NAgFgnGBQFP5JMNe9b
         kFHfU8pQln5C/y3zicrHTUKNdj8KSaXOyvXAlPPvPV9r8GpmlzCVqQuijl0bOQRNObZU
         rIEETgW+gJw1a6+pNiBDHHVrjMWq4661p2eMHl6GBRybFHYu58CZI5gidxJmHp7ZYFgP
         IcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701799383; x=1702404183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2joey/D+/Fter5JFQfAZeSyog4t3NYaVzZzIbt4q+Y=;
        b=ftj65MujeZFK9s3JHDTkB3r2haT4Pt1IOy8N6fMl1OHoQUchvGv9DFGpXdcf2WdXnO
         pQElOfDqObOTkoN9sEqSDyk/dSObT4Xo8yjmQS0f57OrfQBzwZgS6yg3GH8yUdsWCrl1
         tOdR0G6yWa4rZkXrQkJ4+UdDk+McBZLav9pZEGCVCKONoZcCw5+eRYjdvHRjrFS1+nCQ
         WlWeEbYSHYSBEJYwFlpmjSlh8AkgysCNvIqWAo0oOvboDN/VYzxAmrphTlEBCqajmeWb
         e2WVNXCCGkk5isk3zICONnHw8sEAkp4+wXzMqcuNuj7yWMWzInY0mrTaCVga9f0rgGi7
         d/+Q==
X-Gm-Message-State: AOJu0YzYJCS4ximjy5LggvvHUYzbJNLB56J262Z62DCgAzzZbfn0znPm
        bFsnVz6fwCqy83OYunV5EOPosAOYikqFx8TeSNHRLg==
X-Google-Smtp-Source: AGHT+IEXzOUK5t8bzip+5ZofybxHjbqPtQkvb0sQwnXT+0r4S9PaBhfe3FGVUffgOkL3/lvjFblZ2xbK3YEUDgy6Tw0=
X-Received: by 2002:a05:651c:1056:b0:2c9:f5ec:40ff with SMTP id
 x22-20020a05651c105600b002c9f5ec40ffmr2569169ljm.26.1701799382434; Tue, 05
 Dec 2023 10:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-3-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Dec 2023 10:02:23 -0800
Message-ID: <CAJD7tka+e-RWVN8qkCLv52z8G0KAXNO87CqV3p5Wgkx6BvneLw@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> This patch implements a helper function that try to get a reference to
> an memcg's css, as well as checking if it is online. This new function
> is almost exactly the same as the existing mem_cgroup_tryget(), except
> for the onlineness check. In the !CONFIG_MEMCG case, it always returns
> true, analogous to mem_cgroup_tryget(). This is useful for e.g to the
> new zswap writeback scheme, where we need to select the next online
> memcg as a candidate for the global limit reclaim.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/linux/memcontrol.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7bdcf3020d7a..2bd7d14ace78 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_cgro=
up *memcg)
>         return !memcg || css_tryget(&memcg->css);
>  }
>
> +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> +{
> +       return !memcg || css_tryget_online(&memcg->css);
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>         if (memcg)
> @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct mem_cg=
roup *memcg)
>         return true;
>  }
>
> +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg)
> +{
> +       return true;
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>  }
> --
> 2.34.1
