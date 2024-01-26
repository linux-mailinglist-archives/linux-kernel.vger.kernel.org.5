Return-Path: <linux-kernel+bounces-40843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339683E6E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A631C221F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71BE605C9;
	Fri, 26 Jan 2024 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp5aYTgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B9605B0
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706311334; cv=none; b=EfuxmYn0b2rhfIDp7WQPzP0fg3OOjL9Wi0TriegnAHlj/j4ErtdYTcp9YBPNmVeYqDqBExTXGeIc/x2gRlrbjUHuO95lNrLPmqSzN5yLOpzvJ89zscSeCeskZsTKxLmYyFtg+ixCJo07bWwISpQSkEdNoCnqgiUyU+a39NJAkzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706311334; c=relaxed/simple;
	bh=b2arGmKMK+liWpR+Ih+bOXkfi45YnJqpve4R/L7zdlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ESLYvFx78ZcRbtzEuTHKFM3fgZvtwrXd/1+Nsv+P2026T2E4o2DizWwVFegfNzxT363InyPbsLrXf+EhiqNHQXBCOpJq4fPsS3dnDaclrGBorm5Tgb4Iv2+VyCUWHEgphxkbTodqZidm0klpiORnO05318/p5HhqmpblkNbUCKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp5aYTgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA5FC433B1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706311333;
	bh=b2arGmKMK+liWpR+Ih+bOXkfi45YnJqpve4R/L7zdlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xp5aYTgt+F9ZfykTSVpwbkaLjWAaDqpoA1t1jVQ7/kFXBQXt/10CvO1JpxZDsQfJa
	 bWMCMU7rMaHFWHxXIKdYAHgyR12304G+DU3EzooGzrZIQHuZI73fXXtJiAFdDX1ode
	 iQ9MgCUNZK4SQOeguiWxd0EUgJYy9jcXZZOHWE7mlI5Ih9w7Skhzm0ucrcdEjvHT9C
	 C5XZ/M2isO9cqdeQBUftvs8SvWaeWGLCD85yv4qTZsEIzatA3shstdzSam92nY2z7Z
	 mXEKWAa293ptW1o+MbHIa56+FrPriKDN8ifdVGqeDlokGd4NG6t8wOJa4KnhzcYU8D
	 mS184HO0kUVtA==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-362a24b13d7so1595215ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:22:13 -0800 (PST)
X-Gm-Message-State: AOJu0YwFqRIzQdgLtf80e3z5lwvpMNkqaEsMI1wjMIP0E82d2AX3abVM
	mRjXBqeFqYUTX4A8mfg+KBv8gsqV5BuiuG35aGWqB+UxMK45dchDFSIqpYz9AWPHi65o2fyKM73
	NdtE9r5POLd+kIc1uwzFhd43qiSK/AJir5CWk
X-Google-Smtp-Source: AGHT+IH1DsCrw815RmtRcucCScHq0lo1AgpoBFxYkaH6VQFWi2h4seiB5QaOx6GG+y/KaOGKFnSxVRTDzHtqHhqvqU0=
X-Received: by 2002:a92:a30d:0:b0:361:8ced:91be with SMTP id
 a13-20020a92a30d000000b003618ced91bemr605310ili.12.1706311333098; Fri, 26 Jan
 2024 15:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-4-21cnbao@gmail.com>
In-Reply-To: <20240118111036.72641-4-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 26 Jan 2024 15:22:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPjXJVhh40k2utk80ho1y9j5OjvgGwxp1D_Qbt2AmL7KQ@mail.gmail.com>
Message-ID: <CAF8kJuPjXJVhh40k2utk80ho1y9j5OjvgGwxp1D_Qbt2AmL7KQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/6] mm: swap: make should_try_to_free_swap() support large-folio
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org>

Chris

On Thu, Jan 18, 2024 at 3:11=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> should_try_to_free_swap() works with an assumption that swap-in is always=
 done
> at normal page granularity, aka, folio_nr_pages =3D 1. To support large f=
olio
> swap-in, this patch removes the assumption.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..f61a48929ba7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3714,7 +3714,7 @@ static inline bool should_try_to_free_swap(struct f=
olio *folio,
>          * reference only in case it's likely that we'll be the exlusive =
user.
>          */
>         return (fault_flags & FAULT_FLAG_WRITE) && !folio_test_ksm(folio)=
 &&
> -               folio_ref_count(folio) =3D=3D 2;
> +               folio_ref_count(folio) =3D=3D (1 + folio_nr_pages(folio))=
;
>  }
>
>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> --
> 2.34.1
>
>

