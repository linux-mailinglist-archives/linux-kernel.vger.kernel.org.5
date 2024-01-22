Return-Path: <linux-kernel+bounces-34086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE4783732F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F551C2686A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29507405CE;
	Mon, 22 Jan 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mb5uGjqO"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D523FE53
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705952986; cv=none; b=tHIgoShvFA8LOG67RFU9hvabcWDYFidGmp0v4qcBZFizWKDiG9GfA3qdVjRoKuaewuJ0cavXTnGxNY+SMj5TIZIKGU+DpsKdqlPJE+2eGK1RBhOGfzlQgcPLwtFCDbJTHbpXRDSh6LwS52KdSCiSSJlsnllKtUknjl/fTbdkD2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705952986; c=relaxed/simple;
	bh=N5/02QQcKOFzVJAx5+uukXGNVlRapVJpelm/ZexGgDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2qkc8wyIXhdmrHwhERbbqCJWX6tYBdQ8OUBnPof592pt3A8yx7PXUuVmRXipc8brF7A7DfdJ/npwSUocIw111cM+pJEmELhPAhLypQ1b3G6C9daLilIztGAJH60LuQiYE81QQKmkkZ8ZuYaTa1UR+SjpIb6uZyqTKsRrErMH14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mb5uGjqO; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100409e31eso209928e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705952983; x=1706557783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmmFjd1D1SG8gXESzpiPv0tTaSblIwyR7+CuwIgKAtU=;
        b=Mb5uGjqOLdxeckGf5S77ezdfQss2r2XWpnVhWJDJixZI6Yz/KxFHSMdBc3pAhEx7Rn
         4vWveEbjRalqBTfWdAQmue5GrwIQemU3FzrVxvLYJ4a+LGI3qUzBZUiiK38XUXNKvipJ
         lNT5Wip/hPA0VLDhwVhHkFz3VYzY+0SdtBmfNMM9ZViq1DtN33F1lWqvhY/keD/1/WLN
         y/jRfJp7LM4pgvXn67umRfStj/F8aZoNgyLQiNO4YcD8fCGuALNIa9ppumSTb0SE1nHq
         pw34AY0g6FjPHfOcgkJVWgOtrHNzRFO9rpYrO+dB9IKgBCjMAvyoCzBLrTqZXbiWa1QC
         lnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705952983; x=1706557783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmmFjd1D1SG8gXESzpiPv0tTaSblIwyR7+CuwIgKAtU=;
        b=NZ/KFqfCsEC+dshLk87fPy90ALrX5me5LW4GW2IlLqTIYBdVD1EKqjWMaI/jb9BW9C
         YEtmIgYO1fVnfcRUwx3w+TCDBMI26ucPnG4FWdLm/8yddsxXK+N64IlodaUua2ojvC7Q
         Rw+v8LwZPxU9ZhqUto7ZbyS/fn8WtK0myiNXkY4tpCLR7XY0o64y36u+suqnfpSbay6t
         LWroonfiytKjUHd6gVrl6csfAN7mcMqshqI6SbHo/YszvKXDVCSjd0L3BBqXN6dMhBhU
         8XGp1C9xGo2uO3UhB/jeQJqqKFb9Oh31zhdvTqFODITbzJR+jQhs4EUxnZLugpb15vke
         ko+w==
X-Gm-Message-State: AOJu0YyhNCQIF/sjvCID6CZ6zFvfp9GONG6rIYw5Btr9OKr7oFlSoq8v
	4J/iAqVwBBQpYbI6pYyxs1PfVC/rztua5PiOn5bOBkDRmBjjb8jiV9eaefj7DiWc/1ojcOVVTt+
	z76U9V0ue7easu/mlTXIKJ6k/VA4z8LAE7vfL
X-Google-Smtp-Source: AGHT+IHwEYx3Exd15BVvGjkkGlcFwLPytwHOu/ASU6tibw2uMUBmjgKDeCLv71mOUL21U2r8DyjfoZpQZefxk0Mf/2Q=
X-Received: by 2002:a05:6512:e9b:b0:50e:8106:9e86 with SMTP id
 bi27-20020a0565120e9b00b0050e81069e86mr2770324lfb.43.1705952982619; Mon, 22
 Jan 2024 11:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-b4-zswap-lock-optimize-v2-0-b5cc55479090@bytedance.com> <20240117-b4-zswap-lock-optimize-v2-2-b5cc55479090@bytedance.com>
In-Reply-To: <20240117-b4-zswap-lock-optimize-v2-2-b5cc55479090@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jan 2024 11:49:05 -0800
Message-ID: <CAJD7tkbYv_TfEZ3Dj1JE=NXA323MdxGR9ib34PUoCmbfFaSCRQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/zswap: split zswap rb-tree
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chriscli@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:22=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> Each swapfile has one rb-tree to search the mapping of swp_entry_t to
> zswap_entry, that use a spinlock to protect, which can cause heavy lock
> contention if multiple tasks zswap_store/load concurrently.
>
> Optimize the scalability problem by splitting the zswap rb-tree into
> multiple rb-trees, each corresponds to SWAP_ADDRESS_SPACE_PAGES (64M),
> just like we did in the swap cache address_space splitting.
>
> Although this method can't solve the spinlock contention completely, it
> can mitigate much of that contention. Below is the results of kernel buil=
d
> in tmpfs with zswap shrinker enabled:
>
>      linux-next  zswap-lock-optimize
> real 1m9.181s    1m3.820s
> user 17m44.036s  17m40.100s
> sys  7m37.297s   4m54.622s
>
> So there are clearly improvements.

If/when you respin this, can you mention that testing was done with a
single swapfile? I assume the improvements will be less with multiple
swapfiles as lock contention should be better.

>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Nhat Pham <nphamcs@gmail.com>

I think the diff in zswap_swapoff() should be much simpler with the
tree(s) cleanup removed. Otherwise LGTM.

Acked-by: Yosry Ahmed <yosryahmed@google.com>

