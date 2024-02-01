Return-Path: <linux-kernel+bounces-48942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2292584636F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD5B28C1D9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CBB3FE48;
	Thu,  1 Feb 2024 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wErVjros"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EC3FB34
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826579; cv=none; b=b2zMDL/LRUbpkacuOZHO/InkMsBcJBgW/Oqqs4xiSsbhTj/n1Gv8DoSduxgdqrl7OTqDghqotyZBt38pxHRqeY7NL43qZwp2Kihnizzta5Sc049kSq3Au/yOBEjI5tB1PJHNR7e9wIgV4g05yq7SZwgPRqNP6oQXAdpvHlpStoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826579; c=relaxed/simple;
	bh=dEloljQr9NL2fQj+p5tojv6uWV6NH/+lSQT7Nh2TvXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIRQboZYupUvdAgA94FO+dJDqRh1XxIPhC9qegnc8IaT3LCfGf1Aauc3q6ZqZx66QKMFp6COD6mDkizJ5gxbHa2q/AuLRTMGEWE+BXwpNTQco5k3QXgVS819vn7MvbhUxVeh1HKVPzk6/M12uRuiNtOOSWMirBiFjOLczf473w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wErVjros; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso5018020a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706826576; x=1707431376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGDKw/IQ4kdSzFRMSnxN+nzueWWpVC66gEX7pOJuy80=;
        b=wErVjrosp7/KZjmtztomcDUfTaTxvv8l1rNd27ZFmiJEvYwUHgH3Dhgmg6JAmw1g77
         2uTRMUjNzK0gN6IpdQQj5QMUnOB/T4VfwHK3KNgJyutITIWpIRUoX7XBN71UCGr4yyTD
         6eEwLJHVKXXK8pB+X/smglsF2e2pjlh8vXSHAScL7RWqyVR6Qd63OQF5cNF13hC7zdu0
         sbMUuNUcdw0/5Fq+HGZCqxBS8eZj7f//t0it0Aomp5OQZ6NjVYlrIsYIxg2ceMmAKE2Q
         5whWy0edpnFCEt/MmSC40HRqZvC8G5s5KlT9YHL2d+oQ9m8L3Mg7mpvSZuQTie7LjAP1
         qsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826576; x=1707431376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGDKw/IQ4kdSzFRMSnxN+nzueWWpVC66gEX7pOJuy80=;
        b=tqUzYSBy7zpt7ElTi0ghvXUPTsiReFMt1DKeQxfxBKXKVqgkt6/jthM3wQvFAVo2ws
         nYLc3oT5dQQMb+dEiYa7uFfdWo87N6EFrklNcOiuPcKbB8oQYTgSaKemtsytJwmfjgfc
         JHSkLu/r3J0jSCPFSXnjbvkdqs/jXx7H5jl1Eg0ClZUs0D1LUiptz1OVBlQnpIdlVS+x
         BIZ/yUg9RXuuhzsAB/IcLXtTCoiJxsJHMx/q+soxZlqhy1SUy8jojdZ6LL5ipslj128p
         9sWXH+AGIEQzEIFpRbKCP0KMi5VEKVEOFql878QcR5FmDlg+WPCnPGp2a2mT5gThi3Ub
         eutQ==
X-Gm-Message-State: AOJu0Yxd9/11aBub3xQw2iVBwdAJj5HVGQou+wSxqmcqLIOPeL67dI/8
	3Dqw1777hfRPui8IgPCXJRQ7hGf7qQ0ViH3tRR3rqDscoOfT+6tNGQx8BmQaI/iPUrnG+P/ucsS
	XGR1DRUCb0vQOfZl5hdU+zKbIK1D8dMnaFBqJ
X-Google-Smtp-Source: AGHT+IEuhiZvixWFGymGW7m4qj1dTBRZUXAhAcduL9snVjgqkWJ4xtPr92++LvjpCa9nwtPiSV2wXnbN3Xjfiu/tP6M=
X-Received: by 2002:a17:906:43:b0:a36:c8fa:45a2 with SMTP id
 3-20020a170906004300b00a36c8fa45a2mr320163ejg.1.1706826576073; Thu, 01 Feb
 2024 14:29:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201193014.2785570-1-tatashin@google.com>
In-Reply-To: <20240201193014.2785570-1-tatashin@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 1 Feb 2024 14:28:58 -0800
Message-ID: <CAJD7tkbDwwzTfm5h6v5f8XSN8KduBy6h7EVuQt0CAfX--Nb0gQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/iova: use named kmem_cache for iova magazines
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rientjes@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 11:30=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> The magazine buffers can take gigabytes of kmem memory, dominating all
> other allocations. For observability prurpose create named slab cache so
> the iova magazine memory overhead can be clearly observed.
>
> With this change:
>
> > slabtop -o | head
>  Active / Total Objects (% used)    : 869731 / 952904 (91.3%)
>  Active / Total Slabs (% used)      : 103411 / 103974 (99.5%)
>  Active / Total Caches (% used)     : 135 / 211 (64.0%)
>  Active / Total Size (% used)       : 395389.68K / 411430.20K (96.1%)
>  Minimum / Average / Maximum Object : 0.02K / 0.43K / 8.00K
>
> OBJS ACTIVE  USE OBJ SIZE  SLABS OBJ/SLAB CACHE SIZE NAME
> 244412 244239 99%    1.00K  61103       4    244412K iommu_iova_magazine
>  91636  88343 96%    0.03K    739     124      2956K kmalloc-32
>  75744  74844 98%    0.12K   2367      32      9468K kernfs_node_cache
>
> On this machine it is now clear that magazine use 242M of kmem memory.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/iova.c | 57 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index d30e453d0fb4..617bbc2b79f5 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -630,6 +630,10 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>
>  #define IOVA_DEPOT_DELAY msecs_to_jiffies(100)
>
> +static struct kmem_cache *iova_magazine_cache;
> +static unsigned int iova_magazine_cache_users;
> +static DEFINE_MUTEX(iova_magazine_cache_mutex);
> +
>  struct iova_magazine {
>         union {
>                 unsigned long size;
> @@ -654,11 +658,51 @@ struct iova_rcache {
>         struct delayed_work work;
>  };
>
> +static int iova_magazine_cache_init(void)
> +{
> +       int ret =3D 0;
> +
> +       mutex_lock(&iova_magazine_cache_mutex);
> +
> +       iova_magazine_cache_users++;
> +       if (iova_magazine_cache_users > 1)
> +               goto out_unlock;
> +
> +       iova_magazine_cache =3D kmem_cache_create("iommu_iova_magazine",
> +                                               sizeof(struct iova_magazi=
ne),
> +                                               0, SLAB_HWCACHE_ALIGN, NU=
LL);

Could this slab cache be merged with a compatible one in the slab
code? If this happens, do we still get a separate entry in
/proc/slabinfo?

It may be useful to use SLAB_NO_MERGE if the purpose is to
specifically have observability into this slab cache, but the comments
above the flag make me think I may be misunderstanding it.

