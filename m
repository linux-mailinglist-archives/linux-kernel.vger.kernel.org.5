Return-Path: <linux-kernel+bounces-47372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF8844CEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2376228353F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9F3FE4F;
	Wed, 31 Jan 2024 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1DPav01"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2759C3A8FC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743473; cv=none; b=jX3wOJxdJyB0XbRLaKvYfVO9Tir+wRSlndxEE6WSdjD4skWRuyVNJOLxncoC9+ck+752rc5PgwhetKUHQPVk+aIkcORFZkgXTLo/qTNrwXw/FIJx7shu1aa/YKFTFYq/oZP6biyc5b+XMi1Lcxpf551+55p8EB8cjBa3DXEKdRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743473; c=relaxed/simple;
	bh=0dUTagYMP3ifGj+3mqf45+Pb/VzGMHLkAj8F2m+W17I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNiZtO73K5WvbF73GKSo0qrqYR/+W3ThDcGviIEy63/xfSMRBHNqH3p+Oul0WTFW05iMTmSA0pxoNFDXVwXUCfN3XIXM49o8dxH0ZSYdKn87Z2d0rdDAhZNGaaP2avDgXUBD+UJbEKardO6+l6c8qYbvDdf9TeAI5HqerySdKvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1DPav01; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7baa8097064so15726439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706743471; x=1707348271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdhkAvN2zMAgv21EXTQPE0zKw/2sDB8RKNrBCMHc8lw=;
        b=l1DPav017H0ytwBGYoPvw/E4AMeyDBBmcWCIGrbvaQ3B4BXMxYXoaYDCABMVmdTK8A
         eZXV+HjKGyE+FMDsLhniXKCkqptR16uk8L3VliEdluXPVmGYMcvKoF/zRQOQa75TUmKc
         fiBKoQPsxWfH9IEeKEURTJEP11591cFe4qjuEw9rioxoqcDHPAHAqPmtgR+zvfa5IEAg
         CIWRu1mL0RuJQJO10l1oxT344UOoR4o5cwx4QVD1skUDGiJ5kmTej7iEtNSPof0koGVF
         LYVQm6rvt+Zy+2ylUPHpLwOB0QFjqRescmNYerlBu/Lvkxvb5hxAPlM5+LkfgYwZuQwh
         vSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743471; x=1707348271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdhkAvN2zMAgv21EXTQPE0zKw/2sDB8RKNrBCMHc8lw=;
        b=Ji4S0epf7IQEPC6OzU0oHPmpha8JxIaZRdYNrswH3+yh+nO73meOA592ANJKfs+L6S
         K8j74g/YphtrMk9RbLGdZj6zv8IcH+hkcXs0X1RgdzQmGIg7uRLcAuZjTOvZT6xWsm+2
         BYTXQ8edqOY6TjK+2T6syu2uQYVYIcORyJkZNpSJuDvny12z7RgA30MXFz/cyvI2SlgF
         raEiK9fTUhuhZYPOXkAZI+0OpRFJxntCQK3uz+ZhLiZD+N0uHVk/e9qUg+YFSrfxRYkp
         2j2qlOAc2KmhMnUrwD279FpR3BRArAMf3oCop1cBmBRZMVrtXYaQB4R3DT5kgv05rRUB
         h8IA==
X-Gm-Message-State: AOJu0Ywe0VkZOASzQbtA0o12nygTc7bZEs2+3GmLwFz9mwqU5F17MW+Y
	F0LNjbrVSPp9VXmbtKvjSgvsUgLRAsq/6j/ea+qKGy7K7D0AHIfNMKQA5e8YzxU2dJl5OIPggSQ
	9NrW4p7R1aD+3SaclcbQ0UIQxmOA=
X-Google-Smtp-Source: AGHT+IEisZ+S3+7LJdEokZUvIL8kCenOSv/6NynWpo43lqclmLC30dpPbegWsTeBAi3g1eSYFwiHJ/0OSKDChuiBN0A=
X-Received: by 2002:a6b:f218:0:b0:7bf:ec4f:3c3d with SMTP id
 q24-20020a6bf218000000b007bfec4f3c3dmr3450799ioh.14.1706743471151; Wed, 31
 Jan 2024 15:24:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-17-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-17-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jan 2024 15:24:20 -0800
Message-ID: <CAKEwX=O80fOpFVoB-uxrxY2yk3JTW4iJyv6o2HqNs0K6yqBV2w@mail.gmail.com>
Subject: Re: [PATCH 16/20] mm: zswap: function ordering: move entry section
 out of tree section
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The higher-level entry operations modify the tree, so move the entry
> API after the tree section.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

> ---
>  mm/zswap.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 756d4d575efe..80adc2f7d1a2 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -848,27 +848,6 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *=
memcg)
>         spin_unlock(&zswap_pools_lock);
>  }
>
> -/*********************************
> -* zswap entry functions
> -**********************************/
> -static struct kmem_cache *zswap_entry_cache;
> -
> -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> -{
> -       struct zswap_entry *entry;
> -       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> -       if (!entry)
> -               return NULL;
> -       entry->refcount =3D 1;
> -       RB_CLEAR_NODE(&entry->rbnode);
> -       return entry;
> -}
> -
> -static void zswap_entry_cache_free(struct zswap_entry *entry)
> -{
> -       kmem_cache_free(zswap_entry_cache, entry);
> -}
> -
>  /*********************************
>  * rbtree functions
>  **********************************/
> @@ -930,6 +909,27 @@ static bool zswap_rb_erase(struct rb_root *root, str=
uct zswap_entry *entry)
>         return false;
>  }
>
> +/*********************************
> +* zswap entry functions
> +**********************************/
> +static struct kmem_cache *zswap_entry_cache;
> +
> +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> +{
> +       struct zswap_entry *entry;
> +       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> +       if (!entry)
> +               return NULL;
> +       entry->refcount =3D 1;
> +       RB_CLEAR_NODE(&entry->rbnode);
> +       return entry;
> +}
> +
> +static void zswap_entry_cache_free(struct zswap_entry *entry)
> +{
> +       kmem_cache_free(zswap_entry_cache, entry);
> +}
> +
>  static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
>  {
>         int i =3D 0;
> --
> 2.43.0
>

