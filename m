Return-Path: <linux-kernel+bounces-48834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09339846232
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7ED1F26472
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6E3CF68;
	Thu,  1 Feb 2024 20:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8Ofmlh+"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830633C48D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820993; cv=none; b=LTZky2aSeEp20GyHXaivroKeZD+12SSVMzBnkuh+vJOAydSvtuwbwrVu9kIe/WkiHWBfyH0261XKODY/0GQTh41hCXRAsO6hA8k7k/bX0EHKqWNDNKSSlyKMrvp9dePfR+lhY8UE3TM54tICcYoz1lg38FQjkO2gX3fmXVf1OFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820993; c=relaxed/simple;
	bh=Y/nlONtiYcjv2EyDK5zfAVRy4ImGtBKSD5gjZQq28ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpyZ7yQFvgnuFdT0W6AUl62xFyAglVsiIPlgXZL0Il/OdIknP2Juo1j2ur03Ms9COrbrSG0vyj0bNRYv2JCxKrVQqGnxVcWVKflvhLMhLbga3UIr02XpzcHgD9mmX9wsQFF6drKrTrFOSj+Xdtk69v2iuQ54MEhfawkBQMZ3QL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8Ofmlh+; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bc32b04dc9so51914539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706820991; x=1707425791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/nlONtiYcjv2EyDK5zfAVRy4ImGtBKSD5gjZQq28ZQ=;
        b=X8Ofmlh+Tx1DtvcII31UGUR5PQRXyiTGsgv2mL+DE2SPuus1YA9qO4kJ3nAfGAAbod
         CzsOPkjWjWN/no98gCHk7+Mr0uk1GW6ihcggtTvp/Zlm/lwnLYcwPrRFh6dmTImsI+br
         vQf/gvQtZtB/ECcLWdB6c/67kQVfbV1wx8fHvbfelIusIzrcpw7RWDQonuBMei3cT7Qo
         Thh90ZG6r05RVGhBLXzuUyV7wzXm0+iVyO7lYOz06t82XqzRWOhc/hGBl3bTCfeA8lSJ
         Fwz520BDSEuaPZ7DK90q8qRLPOkGmtWJ3Puc60sDqmqW8/XNtZ/eBn3dcoDyyCNuGWmV
         oNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820991; x=1707425791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/nlONtiYcjv2EyDK5zfAVRy4ImGtBKSD5gjZQq28ZQ=;
        b=Tyd4PJh8jOdopgKdc3p0KWhE4EUcHjB+ApHBJkrnUwghl6DTph306H3H70o/8KjcWY
         bMMMsCOzij5lMoAUEmanSXh2p1vJTthS/uG5BfH4LwZchqWrsG1sW4lW5MeQE/m5p9xK
         d5rMKKfX8jDm9dYaarrwldz4ucwHVH3eOXYRwk2FZ7ovqcChCEGhGgBrs3azIdF+pAVN
         mktskyACQnrCpDI2d2wTpWroLMRWHQJbmZ+WxOSZkPWOGETIBNqNCbROFuxOiS44j1g4
         kMMfLP74dvK2UM9WxwhoYDQI2SXyXA6PgXAs/VP42EZ+F7cS8H1xMv5o7fWmvM2T3vYs
         +yXA==
X-Gm-Message-State: AOJu0YwKZtkVcLwNsZwQYj39fcIWpLr3SYi/fI5Cfbrk85gIx2WWut2u
	ttZo6jKDLCZhNxj9JpBSHWMxJQk0y/peFEIkgM93FfwvUWL5uPB2ebZtYOc8DNMPQP8UiTnM1eh
	Tj1NkTBxB99ghrGbq2HC/5yG4sB/hHZl6Qeo=
X-Google-Smtp-Source: AGHT+IGU6/ukryg7CNAjrwNw3tDKXPo+KgiC525TZ85ZpPd4sQ7N5NRpEnDzmHWjJDpHf5LtQpnwBOTkF2NCyLlvjwE=
X-Received: by 2002:a5d:8acf:0:b0:7bf:fd6a:dba4 with SMTP id
 e15-20020a5d8acf000000b007bffd6adba4mr7019607iot.5.1706820991520; Thu, 01 Feb
 2024 12:56:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-2-56ed496b6e55@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 1 Feb 2024 12:56:20 -0800
Message-ID: <CAKEwX=MCr8qAbDhREWdVdLMujso7+JNoBozfDWLx5cqoMWhNiA@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/zswap: invalidate zswap entry when swap entry free
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> During testing I found there are some times the zswap_writeback_entry()
> return -ENOMEM, which is not we expected:
>
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=3Dcount()}'
> @[-12]: 1563
> @[0]: 277221
>
> The reason is that __read_swap_cache_async() return NULL because
> swapcache_prepare() failed. The reason is that we won't invalidate
> zswap entry when swap entry freed to the per-cpu pool, these zswap
> entries are still on the zswap tree and lru list.
>
> This patch moves the invalidation ahead to when swap entry freed
> to the per-cpu pool, since there is no any benefit to leave trashy
> zswap entry on the tree and lru list.
>
> With this patch:
> bpftrace -e 'kr:zswap_writeback_entry {@[(int32)retval]=3Dcount()}'
> @[0]: 259744

Nice!
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

