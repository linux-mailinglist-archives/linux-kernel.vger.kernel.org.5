Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C360D7E5F0E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 21:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjKHUUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 15:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 15:20:07 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F8E2127
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 12:20:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so73000a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 12:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699474803; x=1700079603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtLYKaLVdpiXryZk2aF3ie1bDJ0QyIbGRi7qd0RZPcs=;
        b=bIMJ9gcHLeLu8Szyrk81xRGyC5duCD4oH8FPEBSIsiq5Pq62YTudtoX02bNhUmhB+f
         CXlryZz6D44E6/e1gJuRBe2I/Q3prlNO6Xth9MrIycz2R+5z4QNwvXxTRbllA011vprR
         gFHvSpj/ukv045TGIhICLZ8chAdpKAvMDP+063LISOcSLP1qm/m5KUdY//mCp4hoMfzG
         4Wt1YqIrTBudA8jjpPxH2Y9QGpjSvvgoLdfuqjIUbouHf9cQx+vG6y4uwADX6A3BPjia
         adoy2jv1T8SRGc9DILtOXRwkqJaKQ9Jq3qaX4gvlcP56eO9MlG6SwuwKThRrzJ10z1P2
         NiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699474803; x=1700079603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtLYKaLVdpiXryZk2aF3ie1bDJ0QyIbGRi7qd0RZPcs=;
        b=M1dQeXnpyH4mUS08HyLt11RmHgR/wDjj/xQPzK+XLvNbB3Jo4VCexRRetsIFeOGzFL
         P9qdXFR1KxMlqrYCuQScT/f1qsjUADUCZWq92K+aYhutFRczhACsGOL0AeT7KobHBO9s
         pc4NOUKiVq+s+nnKO50N30kac4nKBj8kFqkwa5FImt34Xvx0QvpKFDSdoBTA7fY7/MJV
         z2/y5kJdmJ2vhi0C1Hk54/iy1K6GV78ZYtIA7w8jJ7VFrgYD3Oe6lxi1c0t1GK6UYkwt
         3ek4u/MmqcMLp41Ey9A/QFPQKtAJ1FDXPf9wSie/CwuqpOzAvwlBmAW0/en/HtPLKYGz
         lQQw==
X-Gm-Message-State: AOJu0YxCOlM0kqWZuEeGSLYesc4EflwLLFtEE+jfvYZfhHAT1KUei1uB
        izqiNOXQgtbhit7iMATwZFV8md/3m0BOq2Wbe/rwNwem5jkNsk4N6rc=
X-Google-Smtp-Source: AGHT+IHCdfIlDdpR1DaNWL/TEHJsCdP+QHVVPRQ+4hQG1IKuBMgUn8ycyu9oxzLbmezdCYYsrlfuSXUz/zrVlrKqFpc=
X-Received: by 2002:a17:906:d553:b0:9e0:5dab:a0ec with SMTP id
 cr19-20020a170906d55300b009e05daba0ecmr2661945ejc.76.1699474803026; Wed, 08
 Nov 2023 12:20:03 -0800 (PST)
MIME-Version: 1.0
References: <20231108164920.3401565-1-jackmanb@google.com>
In-Reply-To: <20231108164920.3401565-1-jackmanb@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 12:19:23 -0800
Message-ID: <CAJD7tkbZ3=yRj5XDR=zoQfxEYdy70hw8bBogyRFRhKhn6=LPBg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: Dedupe some memcg uncharging logic
To:     Brendan Jackman <jackmanb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 8:49=E2=80=AFAM Brendan Jackman <jackmanb@google.com=
> wrote:
>
> The duplication makes it seem like some work is required before
> uncharging in the !PageHWPoison case. But it isn't, so we can simplify
> the code a little.
>
> Note the PageMemcgKmem check is redundant, but I've left it in as it
> avoids an unnecessary function call.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 733732e7e0ba..dd5e8a759d27 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1086,13 +1086,11 @@ static __always_inline bool free_pages_prepare(st=
ruct page *page,
>         trace_mm_page_free(page, order);
>         kmsan_free_page(page, order);
>
> +       if (memcg_kmem_online() && PageMemcgKmem(page))
> +               __memcg_kmem_uncharge_page(page, order);
> +
>         if (unlikely(PageHWPoison(page)) && !order) {
> -               /*
> -                * Do not let hwpoison pages hit pcplists/buddy
> -                * Untie memcg state and reset page's owner
> -                */
> -               if (memcg_kmem_online() && PageMemcgKmem(page))
> -                       __memcg_kmem_uncharge_page(page, order);
> +               /* Do not let hwpoison pages hit pcplists/buddy */
>                 reset_page_owner(page, order);
>                 page_table_check_free(page, order);
>                 return false;
> @@ -1123,8 +1121,6 @@ static __always_inline bool free_pages_prepare(stru=
ct page *page,
>         }
>         if (PageMappingFlags(page))
>                 page->mapping =3D NULL;
> -       if (memcg_kmem_online() && PageMemcgKmem(page))
> -               __memcg_kmem_uncharge_page(page, order);

Nothing happening in the function before this point seems to affect
the memcg uncharging. It only acts on the head page, and most of the
code up until here is acting on tail pages.

LGTM, but I'd be more comfortable if Roman took a look as well.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>         if (is_check_pages_enabled()) {
>                 if (free_page_is_bad(page))
>                         bad++;
> --
> 2.42.0.869.gea05f2083d-goog
>
>
