Return-Path: <linux-kernel+bounces-80915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25061866E06
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A927D2851D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DC04F1FA;
	Mon, 26 Feb 2024 08:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlPoI1dI"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EC4EB3D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936544; cv=none; b=V71hViW4SH6o8aw9c3pZcXcQj+txws1NdzLZhnUy0hiFkl+edaxfvj4LJ1gqwjifrES+Ez9YapheUJURg/NpuSD9RwDVXe/4CmjTr8kFwEd0K1DyUELCmhPZOZwOQbaE2j5lbVv2Mc8KhgBiPaD9Ew7mhjVFt1/KKGVnHDPJR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936544; c=relaxed/simple;
	bh=zNA1Yfqch7a5STznQ53JRctc8/WuTTnA1dmui3K75Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8gL9kPOiDSa3zarsXjQ5pWSyASbyHEhLsXGtATx/PtNh5YGbfN1y+kixG5TIJtuipCv8h7Cjh6RSV7iQRQIaqJgvKkzSWwWnyRgbe+lMkc3uGj5HrNmUS78D+T/CM4ULf8WxOuT6PjuTr4r4qyCTLk3mgqXRAkWYfVPK95gapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlPoI1dI; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a03933eb55so1222594eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 00:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708936541; x=1709541341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdYQqHEJJJI11/ipVni8GrP2S03GNzAze5eIL2s7PE4=;
        b=WlPoI1dIn1KJX7toFWD/qsdcoNjOMKrqOSz2Ov5MC2++7GJ30HBGF1R16P20ctcy4g
         1dBVssA4F+UuGKFuIhw5/ghM8udHnPgAkUxBAu+qmEX04yzVBwngsfNkfsoVWGJeNSsI
         K3J+1xeJMV++YgwgNfFa6yL7SDhH5VcDQ7hU52uWOux8B5im1HGcUXtX+vyTfMvgNLzO
         s0rLJrKoMLZ2tdBI3hMSuPUxp9ndI6BrVszeFtItQnEThl/8RQxFtJBpcrF9D1LqH2Kk
         ogbTllrqJEyQ03r9OYgCIQkKCtPJJTDO6Jjs4G1NuiqtyMj62u7xlQ7mHkxwXUVAQv3D
         eDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708936541; x=1709541341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdYQqHEJJJI11/ipVni8GrP2S03GNzAze5eIL2s7PE4=;
        b=YLKaGy71bg9LvcP7Rl+59JeilV/GNsKkAJKO280vUGQg2sGOdUCStDjhbSmSXd0MfH
         7N3oaGLwYUTfN0KBHaBOlUbxZNDJOC8nMGHq2c5HtCwRx/oWOl2o0NT7DZAxNX8eEfhz
         j5ZkJQTRz4di7KsF0ECrKjFrxLWANfNVZLfdNVJEeRYYVWWMCHqsXlfT3SQNN0d96NBB
         v0QelNL6zdDIS4c6spbsHGf0YNr5MNjeovxhtH4ULRltAGzJFLEpL+p3B/SQqFdw8s2p
         ZBaBcbLROvJtOnTY659a4mSck23tDaHq4oi8JTLEaiEytMB7fxzz++GsTFsuQZKNGli4
         wS8g==
X-Forwarded-Encrypted: i=1; AJvYcCX1/oDs7DNbJch+vnqcMr7qhEV5zNH/LLCaE83dYUEaSRKa40qTNeBYAw0Iqeb2k8E2AqcsK3XH7YNImZ3FyVvSqKJRUh2rJUc0MwUU
X-Gm-Message-State: AOJu0Yy0qDI/WBMGx/xoT2BiFKc5R0cnG+/mPZqIaMXIUR7BzpD5g2Hx
	XT9gKALk53A7gCxTHj5BK+XKBze13sQrmURbepd46yTT2+EGaBm2
X-Google-Smtp-Source: AGHT+IH4PkVIaVoOs64w6k8JWc2tU/Teg2aT3h4+Q7j8DPp6zpjshNbc8fd/yXbczzFtEWws04FsSA==
X-Received: by 2002:a05:6358:1298:b0:17b:6171:ada5 with SMTP id e24-20020a056358129800b0017b6171ada5mr8155972rwi.19.1708936541490;
        Mon, 26 Feb 2024 00:35:41 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.225.117])
        by smtp.gmail.com with ESMTPSA id h14-20020a63df4e000000b005dc4806ad7dsm3508416pgj.40.2024.02.26.00.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 00:35:41 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: fengwei.yin@intel.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	songmuchun@bytedance.com,
	wangkefeng.wang@huawei.com,
	zokeefe@google.com,
	21cnbao@gmail.com
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Mon, 26 Feb 2024 16:35:26 +0800
Message-Id: <20240226083526.26002-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <df416acb-d913-4e67-b810-cd991003242e@intel.com>
References: <df416acb-d913-4e67-b810-cd991003242e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey Fengwei,

Thanks for taking time to review!

> On Mon, Feb 26, 2024 at 10:38 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
> > On Sun, Feb 25, 2024 at 8:32 PM Lance Yang <ioworker0@gmail.com> wrote:
[...]
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
> >                */
> >               if (folio_test_large(folio)) {
> >                       int err;
> > +                     unsigned long next_addr, align;
> >
> > -                     if (folio_estimated_sharers(folio) != 1)
> > -                             break;
> > -                     if (!folio_trylock(folio))
> > -                             break;
> > +                     if (folio_estimated_sharers(folio) != 1 ||
> > +                         !folio_trylock(folio))
> > +                             goto skip_large_folio;
> > +
> > +                     align = folio_nr_pages(folio) * PAGE_SIZE;
> > +                     next_addr = ALIGN_DOWN(addr + align, align);
> There is a possible corner case:
> If there is a cow folio associated with this folio and the cow folio
> has smaller size than this folio for whatever reason, this change can't
> handle it correctly.

Thanks for pointing that out; it's very helpful to me!
I made some changes. Could you please check if this corner case is now resolved?

As a diff against this patch.

diff --git a/mm/madvise.c b/mm/madvise.c
index bcbf56595a2e..c7aacc9f9536 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -686,10 +686,12 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			next_addr = ALIGN_DOWN(addr + align, align);
 
 			/*
-			 * If we mark only the subpages as lazyfree,
-			 * split the large folio.
+			 * If we mark only the subpages as lazyfree, or
+			 * if there is a cow folio associated with this folio,
+			 * then split the large folio.
 			 */
-			if (next_addr > end || next_addr - addr != align)
+			if (next_addr > end || next_addr - addr != align ||
+			    folio_total_mapcount(folio) != folio_nr_pages(folio))
 				goto split_large_folio;
 
 			/*
---

Thanks again for your time!

Best,
Lance

