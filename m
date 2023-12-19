Return-Path: <linux-kernel+bounces-5199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619288187E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41A228A334
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AC1A5A5;
	Tue, 19 Dec 2023 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRlvAXUP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B255A1A287
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:47:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6DCC433CB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702990047;
	bh=hnFmc+s8sR5Tye7KepwE2+51ZjDZCNpery1XwfqQ5F0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jRlvAXUP+1kY4QMJTKSXR/xxbNRW8HMS8vmuY/SHgxSH96hz9NsXqUwlVvIg69m5o
	 0zl4BHCdPgqAaJ8wZKcdyZCUrGhrZ9+XelrYMbbAzyJf6BcqJ1HpdW+RY2VNYicUVC
	 lRqSTI4HGQchFRUGJNDtpqWF26XVwlbpYIkWkZUhHNggUQnEZK+I+VPcW5M7e6jFUd
	 A/jB2WOvcqJcXn7iXekaQj3StDLPU7sJjqLRgt9F1o2x5vghQuEyO48nAqt5HenAf5
	 MRgc3+omDjDckG+PTJUTdh6r8y6bXKzu8MUM56q6qcJjdWeCtI4FoYZFO0BEucb6xR
	 sks6WiLQe6jNQ==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28ba18740d6so1305509a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:47:27 -0800 (PST)
X-Gm-Message-State: AOJu0YxjN3XMmlJA/WZAOkYu5QumfmpneyyzgnqDacrM5gnCpQJJ+Qru
	5l1uzFD1NsupVOWU4naDeWqlTfO1T4rAL8ryJDZrzQ==
X-Google-Smtp-Source: AGHT+IE48aXiDCbcHxbz9HcyCylBO3zRDq2Z4NyaPTm/pSzXxwWB9ViYMnRA83jxVStJWBss1SRBcsIeg/jy+9eMFbo=
X-Received: by 2002:a17:90b:2285:b0:28b:904a:93f2 with SMTP id
 kx5-20020a17090b228500b0028b904a93f2mr2011222pjb.32.1702990046576; Tue, 19
 Dec 2023 04:47:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com> <20231213-zswap-dstmem-v3-4-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-4-4eac09b94ece@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 04:47:14 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOnBhVRcC9bPJrqSDQYynbG+CpJDveFn9MJNmsBsFyM+g@mail.gmail.com>
Message-ID: <CAF8kJuOnBhVRcC9bPJrqSDQYynbG+CpJDveFn9MJNmsBsFyM+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] mm/zswap: cleanup zswap_load()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Dan Streetman <ddstreet@ieee.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> After the common decompress part goes to __zswap_load(), we can cleanup
> the zswap_load() a little.
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3433bd6b3cef..86886276cb81 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1759,7 +1759,6 @@ bool zswap_load(struct folio *folio)
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry;
>         u8 *dst;
> -       bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>
> @@ -1776,19 +1775,16 @@ bool zswap_load(struct folio *folio)
>                 dst =3D kmap_local_page(page);
>                 zswap_fill_page(dst, entry->value);
>                 kunmap_local(dst);
> -               ret =3D true;
> -               goto stats;
> +       } else {
> +               __zswap_load(entry, page);

Very minor nitpick. I think this change you only take out the "ret",
you don't have to remove the goto. Personally I prefer the one with
the goto because If (!entry->length) is a rare case, having them
indented match the normal execution flow is the streamlined one
without indentation.

If you keep the else statement without the goto. You can move
__zswap_load(entry,page) to the if statement so most common case go
through the if statement rather than else.

I also think this commit can fold into the previous one. As I said,
this is minor comment, it is your call.

Acked-by: Chis Li <chrisl@kernel.org> (Google)

Chris

