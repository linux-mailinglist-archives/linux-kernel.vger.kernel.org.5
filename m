Return-Path: <linux-kernel+bounces-132053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B66FE898F23
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AC61C2475E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D56413443F;
	Thu,  4 Apr 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l2ZlUKV8"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C043134439
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712259672; cv=none; b=ejQ7RJpw7e9zy3hB78mxXh7bUmMXvDmv0A40KtRFOnKm2aFg9BQA1+siLjkAJzvlLjgwiwpuBWZ50Wt055YBcbeVWcIjwefVm/lWxr1EKpeXfqyl4xmvbot7KhrTB5ONGjRs1up587+cHpcSMYA1dddXTZ1YsdYyBsGuupEAmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712259672; c=relaxed/simple;
	bh=iz0bGXcbHiJkhtXDUOyY3n+qbZ2wRRxMNVVkahGIvWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0Euaysk2rQOZdOMXEV+YLQpNnUSWZXWgz7IOVebU0iFo1uNlPjai3dwDVv3J0VzScQQXg67syjwLcJaIS5tevqVg2Or7QmzRv82lsvlf3BHt+Dd4c1F8/4LHOYY9W3kbvOf2PFjswT25mZeU8QvadRhyMuzU9j1MC9r6SdZfWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l2ZlUKV8; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4765e6cf37aso534052137.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712259669; x=1712864469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7cHtC6/e0FV6wX3F6QbmB8ToyxlBVuDkaRhNf0o1y4=;
        b=l2ZlUKV8bz+Y9PlQFqAIh21mPwp4ygSAFRsegx3c/e6Gf3Y+x1FTuNV+rEiaGvzAXj
         QXF61z7s3J5CFogmym4a84s/KMCQT+FcqYg4+AHFt4dAQjSgzbeclq4xjZzyavBmBS90
         USd0uQAGS9yfBAV/1JLbxn55YLJqwh8vRasujUXVBlfw+IZIRCW39fN3UUYbHtcqCMZW
         KXzqZHVvV/M7ltdw+EkQkb0SPswvGUh7HO+VA4zMWxwJijx1W769eW5lksvslhPUp5eQ
         GudFxhJcNGJWPdaA/8UCj+ZrE+MqV4hT6ERqcF2obTGsuF6958grWN6SbLTVqUGNivSp
         dCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712259669; x=1712864469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7cHtC6/e0FV6wX3F6QbmB8ToyxlBVuDkaRhNf0o1y4=;
        b=VFIiycqwf7NKm7SYG6iCVrpF4SucGcax1v6rjd7UrTkcuPceYehVPsdWt2DT2qVMNe
         9FvA9NMnXBDyIL92AU9YTs/Z/8NmT+vwwzIko2rp7xXtCe9afxaZwCYZ4BC3geMJHvkW
         45K2jEuPGOs3cOX6AX7PoTa8uYvufXzwlKBct8DzcCTGBxrqJ6VTrjL3fezERl4quhBe
         +bdLRt3QCBjlXhlaK27FriOtkFIlwV8xr0636SZIwInL4zCPdUbKSF5Zk/UHVnb6hi2m
         szv/5+DsZxwFcQiCgS2mOtnLy3bWq58D+fd2LDBih88TrG9v7Ye5mJl75u8EJpSIjX5o
         PWlA==
X-Forwarded-Encrypted: i=1; AJvYcCXVa9JJt3dJmvG/jFqoP1Eg1dyd49gSr8Hj+3XfZNf2zC75k2vj236VF51aXPvP3quvdRPzIhQWqKa/AHaZry9GTJDQF9+O8+9hOsMF
X-Gm-Message-State: AOJu0YxAUMFAVzIiYQK493QgKZDw75zMa5i/n6eCRVp9AiZ4y0rGK2UZ
	2gjiX07CbJPOEo1E8uoE6228aEik7ILAhRfCOqHfAxBCzH2vHWm5Cn2aW/ScnbbmeVtIC7O/Thj
	aFopWBYo/iRg11yL1eAe0RpbOQaiD0bXjX6Ur
X-Google-Smtp-Source: AGHT+IHyHdgMOOC6Bh6I1UAtHxMqwBPQYPsx/NLvbA5MD/rct+UnDIeCbWQ76PaEjMfTzerscAEzQb/JI8uXmiQdPCo=
X-Received: by 2002:a67:f7ca:0:b0:475:fe59:f33 with SMTP id
 a10-20020a67f7ca000000b00475fe590f33mr3290471vsp.29.1712259669327; Thu, 04
 Apr 2024 12:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404162515.527802-1-fvdl@google.com> <20240404162515.527802-2-fvdl@google.com>
 <Zg7358ygxHBHUCy9@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Zg7358ygxHBHUCy9@P9FQF9L96D.corp.robot.car>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 4 Apr 2024 12:40:58 -0700
Message-ID: <CAPTztWYH5ANR2cYidf+frC2HBJiz6UUh5wC5khHJg8R-gYbcFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/hugetlb: pass correct order_per_bit to cma_declare_contiguous_nid
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org, muchun.song@linux.dev, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 11:56=E2=80=AFAM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Thu, Apr 04, 2024 at 04:25:15PM +0000, Frank van der Linden wrote:
> > The hugetlb_cma code passes 0 in the order_per_bit argument to
> > cma_declare_contiguous_nid (the alignment, computed using the
> > page order, is correctly passed in).
> >
> > This causes a bit in the cma allocation bitmap to always represent
> > a 4k page, making the bitmaps potentially very large, and slower.
> >
> > So, correctly pass in the order instead.
> >
> > Signed-off-by: Frank van der Linden <fvdl@google.com>
> > Cc: Roman Gushchin <roman.gushchin@linux.dev>
> > Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepag=
es using cma")
>
> Hi Frank,
>
> there is a comment just above your changes which explains why order_per_b=
it is 0.
> Is this not true anymore? If so, please, fix the comment too. Please, cla=
rify.
>
> Thanks!

Hi Roman,

I'm assuming you're referring to this comment:

/*
 * Note that 'order per bit' is based on smallest size that
 * may be returned to CMA allocator in the case of
 * huge page demotion.
 */

That comment was added in a01f43901cfb9 ("hugetlb: be sure to free
demoted CMA pages to CMA").

It talks about HUGETLB_PAGE_ORDER being the minimum order being given
back to the CMA allocator (after hugetlb demotion), therefore
order_per_bit must be HUGETLB_PAGE_ORDER. See the commit message for
that commit:

"Therefore, at region setup time we use HUGETLB_PAGE_ORDER as the
smallest possible huge page size that can be given back to CMA."

But the commit, while correctly changing the alignment, left the
order_per_bit argument at 0,  even though it clearly intended to set
it at HUGETLB_PAGE_ORDER. The confusion may have been that
cma_declare_contiguous_nid has 9 arguments, several of which can be
left at 0 meaning 'use default', so it's easy to misread.

In other words, the comment was correct, but the code was not. After
this patch, comment and code match.

