Return-Path: <linux-kernel+bounces-39124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC9D83CB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFD61F2173F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6313A253;
	Thu, 25 Jan 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmS1DXts"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722121D68A;
	Thu, 25 Jan 2024 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207410; cv=none; b=K35v4Mvj0MmwjxJX9XF/trQx9k3W+2NfZuOZQMuZ/7iKiKjPuwAR/ekddDTXWa7aeJ4FmfWkmaDP1Z/0keYOH9DzZeiAjZz0e11mqpeTFGEnuKBeobII5vurpH8zg2E0pgHjp0tJniotnetf316ZRf+LhKRky19WM2v550xvigM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207410; c=relaxed/simple;
	bh=H9bCp64dzxsbnmZAsWi/mj9r/BE9YyzHQy06wvQ/5d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rmz4yjhAZnRRYOWf0PQi+6tSxZx/Vcaij7h2I+2oVgvi4wLTH0ISx5w1GOkqNLxFaimaG8NxdOr0lhXmjemHWk06iXYYon7VJCYiK9CW2zZwZ/LGFbxp5NIX6S9+1XDuRn/pdHvlEDCxANTI+4nG4rQoMkUjJLFxudbuAwsIyIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmS1DXts; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bed9f0ea20so298632339f.2;
        Thu, 25 Jan 2024 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207407; x=1706812207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDjqEa67xyb4l1N2TN+AplDaR+Q7JyAPtlhYu3ePq5w=;
        b=EmS1DXtsNl46EUX+1kDFifN+p0tjgiUKGN5Ll22nfUW9BjrZD3Xs6R1T8LUdxh0W1w
         YWnPujLjn1Oy+xSqjOmoqkT1icC1fFkxDlRoKGCYvRprAoRSM+1nHA7vbttbxqDYUKv4
         VcsPHWX9TY9G3EEFpz6R8CkZtNPOqCuArSw/wpApvbaQnHvGvKwN1hMlaZgEuVJQGgIi
         8IyPqsxBdBavjZcOmnve4CDQMsheYOkcZhRJ3LqCnQU2yk7+RL4vykBi4LIbbqiFIVze
         F5sUpr1WQSQAFd95qFW69c6SbuBcJ9rgaH2mK820KqC8/TBYRlix+BiEejBYrHEzl8eM
         5uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207407; x=1706812207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDjqEa67xyb4l1N2TN+AplDaR+Q7JyAPtlhYu3ePq5w=;
        b=u9bAmBhIDzu0t9d6xIwalkKkxnhCxyXYy29GnE05VSF7s4nXGkOTbsSq9Si83vaTJA
         j/c0YEXmkkBGBwMUkWHQlyZ1NfIR/m1xX2ArRkGdJqhb04X5JypQPzcrs/n8u9NqUu9v
         deVuLsKWsJUWRwpGT7M+YVmLzS8e1uiLz1a7ZyJzHHn+lYq+wX+E9i3+ZK/n8gBcI9wT
         hnUu6Nkk/xf3UDHClnVq1nhY2oh3+0C9rSXkSa3FfLpJT+f6CcL6LSXUc4B8d6h0kq3u
         0Tm8u+lakNoZS+EUv+RAEE0JGq56Et3gpKxDn2kkWvSGNmITdXspZMsnxIMlZm+Ji7+A
         Eegg==
X-Gm-Message-State: AOJu0YzwMGQVj+zVclML5IXOYoBo/RG5pZ7IHmd8+iwRWcFZ4YHsfzeY
	ZVnrGjsnWFbHT1X0DELi/v/G77vPOQZNiNOouc9NatBp4HaSogxcSv5hS85E1dCUOFpCsjtHVxh
	09SF01IaJmmFdm38kTDeK/moYo08=
X-Google-Smtp-Source: AGHT+IEwqeFlizQUS4uC69QekJVT/vm3JE+6/ph22uTAcYW+xjF+tKz2hPnOgQjzybDwL1+5W6uhPpA0dCvaSCexRHQ=
X-Received: by 2002:a05:6602:114:b0:7bf:246b:1416 with SMTP id
 s20-20020a056602011400b007bf246b1416mr177822iot.28.1706207407526; Thu, 25 Jan
 2024 10:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125085127.1327013-1-yosryahmed@google.com>
In-Reply-To: <20240125085127.1327013-1-yosryahmed@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 25 Jan 2024 10:29:56 -0800
Message-ID: <CAKEwX=Nb8DkYc=XRQdqGHasQaEWDxGn9T27TqkUDWQxa6D1P3Q@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix missing folio cleanup in writeback race path
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:51=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> In zswap_writeback_entry(), after we get a folio from
> __read_swap_cache_async(), we grab the tree lock again to check that the
> swap entry was not invalidated and recycled. If it was, we delete the
> folio we just added to the swap cache and exit.
>
> However, __read_swap_cache_async() returns the folio locked when it is
> newly allocated, which is always true for this path, and the folio is
> ref'd. Make sure to unlock and put the folio before returning.
>
> This was discovered by code inspection, probably because this path
> handles a race condition that should not happen often, and the bug would
> not crash the system, it will only strand the folio indefinitely.
>
> Fixes: 04fc7816089c ("mm: fix zswap writeback race condition")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/zswap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8f4a7efc2bdae..00e90b9b5417d 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1448,6 +1448,8 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) !=
=3D entry) {
>                 spin_unlock(&tree->lock);
>                 delete_from_swap_cache(folio);
> +               folio_unlock(folio);
> +               folio_put(folio);
>                 return -ENOMEM;
>         }
>         spin_unlock(&tree->lock);
> --
> 2.43.0.429.g432eaa2c6b-goog
>

Oof. Yeah this is probably rare IRL (that looks like a very specific
race condition), and the symptoms are rather subtle (no kernel crash).
LGTM.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

