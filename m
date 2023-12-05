Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA28280437A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjLEAgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjLEAgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:36:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D690102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:36:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61C3C433B7
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701736569;
        bh=nh5OvhQxlRfLMDVGUATaUP5xmIGHhybcttjxqWDsn3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c6zhY/03sYoUPxFSOAzcqpJZNdgcpIlguB8F8Ya6QtatTsdz1qTJrxroGNpHDCz+k
         63siMOOcIga85eiVqw+IX/X812bDb4yBSEqrDk9+o5uVWH/9ctrNBM23BfhFgLPrsT
         I4nqhdNFK8iX8f1eHUSVJvzq8t9Do5uJJCXj7TPuI5lJpjHGDiiRrOhXElPMv17s9y
         6KIy8W6mYttmVmJm3RacrZOIa2pvOM3aPhO1Zfjf3mfBReG/qxdPROL1ds0WTuQwEH
         KQTj/QzUOPlguiUi08443cGHf6c0PFubwpXdFlPzxWgELpwCX6rG5Gf394rdIFTzJJ
         xdbZJUcVlK+wA==
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ce52d796d2so1431343b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:36:09 -0800 (PST)
X-Gm-Message-State: AOJu0YzvGygr8wXO4SEy6Dfp9uo1HUJxZFgp4Lsp59U+Q+d6pcyNw8mc
        7AU5+b9R2PQ+YMDJJbKlZ31Sn09xbNzfiE8cNLT0wQ==
X-Google-Smtp-Source: AGHT+IFEGHhgC5vm9lb6tIiaRJZgs/RHNtib/ITvbq5Wlcj1rLMMGwqG+hEI5SF0R/fth38EIgqoS5P+F/X0FUD92DU=
X-Received: by 2002:a05:6a21:6215:b0:18c:1248:bb17 with SMTP id
 wm21-20020a056a21621500b0018c1248bb17mr4976625pzb.21.1701736568967; Mon, 04
 Dec 2023 16:36:08 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-3-nphamcs@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 4 Dec 2023 16:35:57 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
Message-ID: <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nhat,

Very minor nitpick. This patch can fold with the later patch that uses
it. That makes the review easier, no need to cross reference different
patches. It will also make it harder to introduce API that nobody
uses.

Chris

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

Very minor nitpick. This patch can fold with the later patch that uses
it. That makes the review easier, no need to cross reference different
patches. It will also make it harder to introduce API that nobody
uses.

Chris

>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
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
>
