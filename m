Return-Path: <linux-kernel+bounces-110806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70710886428
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5C284510
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15715288AE;
	Thu, 21 Mar 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jSiEApUe"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B175429A9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065406; cv=none; b=DB6sZhJjbGOSw4K2yCZUn2TDJyi3wyyTBZGd4x4NhNltOHwh8nRD8qfo6YVModlEGkoWtaKx5/tIut1/SAGKjcm6wA2nipe6qjbgyyJRv8aVqz/W10P03UeJnfqRqabKC3NDxoASa+lIc4PnK8bznC6z7GOn8IvSVtnu9LHoOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065406; c=relaxed/simple;
	bh=7bIfYiaYkeJwspESoCS4UBIhEkQ37NoZG52mzXvOdQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0Zpcelr0m4RevKWwXqhB5htmTTpb2/mpmgL87oHO16yA9Jc4IcgeFc1LmngmvO8F5nATEG46ri9+DvXHWvRh3KEIEB2/rjU5AJhgQEj6OycZkL9mSC7potMuou08ytsHsaSORsIMWNrLHC2CmPkk6iS1nNlMKMl9VXryJeQMAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jSiEApUe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso1576523e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711065403; x=1711670203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7hLBXZVRvGfE/2Hpd2oBop/g59lqRf4KQplnrPKrJs=;
        b=jSiEApUefNvwvKJwV6EfVniTOsOPTup055VGS/MW9ceKdGhitkG7mymFpztRVN7/wq
         E2zxlZQgz9IQutyF82c6FBwR24JAnrcVnZzosuVpdIDUTAUErfe6fVVbLBLuqaVtf1E7
         p7gAJVwzApeAH1KxI9VsMtK5caZS/OBE1YVp6rAC4y3DMhOHgMmA5Z8Xd5s1FFZKhQz3
         kN5bVVBbc4l2zUJ8TYUUiuoiiPStBDBELaZa8nShUhOb2uhiKH7IeqtGYYCLwD26mD0Z
         /80D/fwoBaAu/ccryNyDDiWxNjcKVFMSVHBw3BdAxL3K1eTROYHV7Ft7Ao8lvD3fJurG
         nnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711065403; x=1711670203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7hLBXZVRvGfE/2Hpd2oBop/g59lqRf4KQplnrPKrJs=;
        b=F4zv7BonMDHnhsY2ZDTJGOff9ZM09i+TGlmHI4Hh1UN8v1QH1cLUmHrQqgJAsli7Jx
         sXmVSq2ob4FbJPB+Ei+mnP9acwX2+lI23Cy4o2m5vU3W+0GFV4kLHuNTQqqmm2GmiRpm
         dowDYfxOIqBoVqusruPGmJQ5BAxBqIlXuCdniDlMDZbDr586c2gUyQahk7ZPmORuY20S
         7N6VNAUqdIL6qFRotJ1PXQNaAca0NiLg04yX03HugmXtIojvTKQxBgE/ktHezhZfvi3j
         r5xmyD0uD4mebruiSRh3vLJ3dbpdTa4bS3sMfPeo2hOujTZPZz8DLywHzD+YoKY4+yTF
         FSEw==
X-Forwarded-Encrypted: i=1; AJvYcCWk75boEIuRMVYYCFfDmujDkHHu3wbrq0TACSKQaCDwdqT3VTpmN/Ezq0yHGw5fdzIzFqjhWaYNJKMsr0sOaOocNv035KMRbUsFKSrU
X-Gm-Message-State: AOJu0Yyc/hJPEq6pcvRerWoA5PcvJFK2+NSFRF8sdoG4RTiHTI+QiS/U
	MDqomR9Iw42bBdpZgN4e1ReYKBaq/YWY7jfsJXFL4qMggEdO9yIurt1pGouFs3slDHSkBUcAsQm
	RFk9DUY7aiqvFDfb9bI51aYm6zGLWqWvwdThHvFIyKjUJqpg30w==
X-Google-Smtp-Source: AGHT+IEBnyEucTPs+PzbUoRwIWW8ICXSNiNdqnOVM+OXaugIGXlD0uviQekxj8YFoz7OGp2LjhUyW0jv+uHGl/MM6KY=
X-Received: by 2002:a05:6512:2ea:b0:513:46b4:4eb4 with SMTP id
 m10-20020a05651202ea00b0051346b44eb4mr526727lfq.3.1711065402566; Thu, 21 Mar
 2024 16:56:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
In-Reply-To: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 21 Mar 2024 16:56:05 -0700
Message-ID: <CAJD7tkY8os3yvYLiotaiRuYa1jdEGiPHQsZEU6E52zRBQ34kQQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: initialize entry->pool on same filled entry
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:53=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> Current zswap will leave the entry->pool uninitialized if
> the page is same  filled. The entry->pool pointer can
> contain data written by previous usage.
>
> Initialize entry->pool to zero for the same filled zswap entry.
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Per Yosry's suggestion to split out this clean up
> from the zxwap rb tree to xarray patch.
>
> https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
> ---
>  mm/zswap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b31c977f53e9..f04a75a36236 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
>                         kunmap_local(src);
>                         entry->length =3D 0;
>                         entry->value =3D value;
> +                       entry->pool =3D 0;

This should be NULL.

That being said, I am working on a series that should make non-filled
entries not use a zswap_entry at all. So I think this cleanup is
unnecessary, especially that it is documented in the definition of
struct zswap_entry that entry->pool is invalid for same-filled
entries.

>                         atomic_inc(&zswap_same_filled_pages);
>                         goto insert_entry;
>                 }
>
> ---
> base-commit: a824831a082f1d8f9b51a4c0598e633d38555fcf
> change-id: 20240315-zswap-fill-f65f44574760
>
> Best regards,
> --
> Chris Li <chrisl@kernel.org>
>

