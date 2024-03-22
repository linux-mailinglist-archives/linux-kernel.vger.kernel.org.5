Return-Path: <linux-kernel+bounces-112116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E3F8875E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04A91C22C82
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF882C76;
	Fri, 22 Mar 2024 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="SXauouqK"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42477F7C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711151316; cv=none; b=EX/IKktIwmAZY1TSf8zkYaGzHqGXNp2vu/sTm8LapwdL9FyyI3udzQtmtcVXusY69RbMqAAHCtt6BIMA2N8DIA1N9BSD00RSo1yiIupgHOH9t4KsKVgSeIsGqF7EM8LL5nFCJDuye4j+p2eF3Q1Q69g4Zx4koBceLle6H0fDGAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711151316; c=relaxed/simple;
	bh=hcKBDiMUJsBoEdgfB9qLx2QhWRupkFN5gOimH9pMYOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCxG9KMko1XO+thZi2QC/jwrGPoq+E+W4RMv1J5vbjTFoZKQNE+drB+o7nKlW5aIVksqztV3bK/b5QCeLQDwilMd8mFbHtexEpQmyGaaRmCZh6oBAcvc9jFDB8gS5+3R4v/m2iWplMEFsH2b/ROd8XHYgG47RhFrVDuYNvFr9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=SXauouqK; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-787edfea5adso117150485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1711151311; x=1711756111; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aQTSZTryQ/MFlPGn7Q0hFHJjxKUSl2BjvJPBr2Zsm+8=;
        b=SXauouqK/81PTKDXstXbDyAZxjyJpqZL3pqfz1HUXqIm4MHTd3PtGGjVvrzKXW43HA
         5w0WPqjTBAAarkSBVsYgwtPJQ3mFKyAs+dlkAstbD0i1mK2nnxBi9TBKFWYLgQNvi7o7
         Ru/ZUn2CJyFWfWAA0cN0Hn9ypUvVCz17QuIB6YxUUshYQZ5/SmNVCwKcDxeCIwZl6VHr
         O0p6uUOvNqaoS4CDfIPC7qr7+O+CcYprWO7D4lbjGulPeQWbzIrxOgUgh0aAVp89uAoW
         9JZ/LR/5SrohsQyQ/MEE4SmpS09oo6U8sVDwXh4gH+hak1rRpcAoqH2tfNf5R4wIdfvV
         v9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711151311; x=1711756111;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQTSZTryQ/MFlPGn7Q0hFHJjxKUSl2BjvJPBr2Zsm+8=;
        b=gUUTkkDQYNnpTpApoUe5w+Y0PNtqdJzrq33jweUv59oteqy0oZzM3RiO3vZ9bht2DE
         G/TOlTUp+vqSFEn+dDh7sVuipMY+s0M0loxkrbbsuPaBGmX7bIiBYW3Zq8RS4Hswld4x
         NbsS/Zl7xrCi5WcalYGBxmnabNLZ2wBu7gfwJOHdMF5vUjV7/8K4+9UnzqfqRAErca8x
         RAUSIW84u3SnP7HUMXmtQZd4m0mG/KkAc/2uRVJmsyJAg38D/lf60ISBZzPcim7R8VQx
         UC3cMF2P+pGO4LoztZaJQQeAyi7ZxANvnKjxujZgzX5BoEOoPejPV+uOU/dkWmQaVZyJ
         wsYw==
X-Forwarded-Encrypted: i=1; AJvYcCXcmFEmluhbAKcKYy5R/iHJypX8uDH/t5E4dqCffKSStV1Cn3zho3epzK64rQ3wROI6tZSgYzIgKrkZQ9o+pWNRD+5d+RliDasfx7VB
X-Gm-Message-State: AOJu0YwyNaej/rz8/Betm3KDIktBcL8ieKUWOl3p8nIND+Gt+fR98eRU
	IaSWjuDWWlfUUQLWd4lBL8PXYR2w4xufepwlHapxNrtJ4pnwtq4gpfkf0QHaeoyNPMHoiLEvJ4I
	J
X-Google-Smtp-Source: AGHT+IEOFk5l+pdXqCde0pKSmp+mbC8Z5Cvz7pS7D37/Pv3CRjhdK62gKP0NzpZao7K84yhG3hJXeA==
X-Received: by 2002:a05:620a:40d0:b0:78a:4598:2ae7 with SMTP id g16-20020a05620a40d000b0078a45982ae7mr674879qko.16.1711151311436;
        Fri, 22 Mar 2024 16:48:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:16be])
        by smtp.gmail.com with ESMTPSA id n17-20020a05620a223100b0078a384a4854sm274125qkh.7.2024.03.22.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:48:31 -0700 (PDT)
Date: Fri, 22 Mar 2024 19:48:26 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, chengming.zhou@linux.dev,
	nphamcs@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: Re: [RFC PATCH] mm: add folio in swapcache if swapin from zswap
Message-ID: <20240322234826.GA448621@cmpxchg.org>
References: <20240322163939.17846-1-chengming.zhou@linux.dev>
 <CAJD7tkYuYEsKFvjKKRxOx3fCekA03jPpOpmV7T20q=9K=Jb2bA@mail.gmail.com>
 <CAGsJ_4yc-XB3+FkcZTy1aZ0n6ZKEkfWVYk_TjqqrdcROa5VYtA@mail.gmail.com>
 <Zf4HKUpKpDWZygni@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zf4HKUpKpDWZygni@google.com>

On Fri, Mar 22, 2024 at 10:33:13PM +0000, Yosry Ahmed wrote:
> On Sat, Mar 23, 2024 at 10:41:32AM +1300, Barry Song wrote:
> > On Sat, Mar 23, 2024 at 8:38 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Fri, Mar 22, 2024 at 9:40 AM <chengming.zhou@linux.dev> wrote:
> > > >
> > > > From: Chengming Zhou <chengming.zhou@linux.dev>
> > > >
> > > > There is a report of data corruption caused by double swapin, which is
> > > > only possible in the skip swapcache path on SWP_SYNCHRONOUS_IO backends.
> > > >
> > > > The root cause is that zswap is not like other "normal" swap backends,
> > > > it won't keep the copy of data after the first time of swapin. So if
> > 
> > I don't quite understand this, so once we load a page from zswap, zswap
> > will free it even though do_swap_page might not set it to PTE?
> > 
> > shouldn't zswap free the memory after notify_free just like zram?
> 
> It's an optimization that zswap has, exclusive loads. After a page is
> swapped in it can stick around in the swapcache for a while. In this
> case, there would be two copies in memory with zram (compressed and
> uncompressed). Zswap implements exclusive loads to drop the compressed
> copy. The folio is marked as dirty so that any attempts to reclaim it
> cause a new write (compression) to zswap. It is also for a lot of
> cleanups and straightforward entry lifetime tracking in zswap.
> 
> It is mostly fine, the problem here happens because we skip the
> swapcache during swapin, so there is a possibility that we load the
> folio from zswap then just drop it without stashing it anywhere.
> 
> > 
> > > > the folio in the first time of swapin can't be installed in the pagetable
> > > > successfully and we just free it directly. Then in the second time of
> > > > swapin, we can't find anything in zswap and read wrong data from swapfile,
> > > > so this data corruption problem happened.
> > > >
> > > > We can fix it by always adding the folio into swapcache if we know the
> > > > pinned swap entry can be found in zswap, so it won't get freed even though
> > > > it can't be installed successfully in the first time of swapin.
> > >
> > > A concurrent faulting thread could have already checked the swapcache
> > > before we add the folio to it, right? In this case, that thread will
> > > go ahead and call swap_read_folio() anyway.
> > >
> > > Also, I suspect the zswap lookup might hurt performance. Would it be
> > > better to add the folio back to zswap upon failure? This should be
> > > detectable by checking if the folio is dirty as I mentioned in the bug
> > > report thread.
> > 
> > I don't like the idea either as sync-io is the fast path for zram etc.
> > or, can we use
> > the way of zram to free compressed data?
> 
> I don't think we want to stop doing exclusive loads in zswap due to this
> interaction with zram, which shouldn't be common.
> 
> I think we can solve this by just writing the folio back to zswap upon
> failure as I mentioned.

Instead of storing again, can we avoid invalidating the entry in the
first place if the load is not "exclusive"?

The reason for exclusive loads is that the ownership is transferred to
the swapcache, so there is no point in keeping our copy. With an
optimistic read that doesn't transfer ownership, this doesn't
apply. And we can easily tell inside zswap_load() if we're dealing
with a swapcache read or not by testing the folio.

The synchronous read already has to pin the swp_entry_t to be safe,
using swapcache_prepare(). That blocks __read_swap_cache_async() which
means no other (exclusive) loads and no invalidates can occur.

The zswap entry is freed during the regular swap_free() path, which
the sync fault calls on success. Otherwise we keep it.

diff --git a/mm/zswap.c b/mm/zswap.c
index 535c907345e0..686364a6dd86 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1622,6 +1622,7 @@ bool zswap_load(struct folio *folio)
 	swp_entry_t swp = folio->swap;
 	pgoff_t offset = swp_offset(swp);
 	struct page *page = &folio->page;
+	bool swapcache = folio_test_swapcache(folio);
 	struct zswap_tree *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 	u8 *dst;
@@ -1634,7 +1635,8 @@ bool zswap_load(struct folio *folio)
 		spin_unlock(&tree->lock);
 		return false;
 	}
-	zswap_rb_erase(&tree->rbroot, entry);
+	if (swapcache)
+		zswap_rb_erase(&tree->rbroot, entry);
 	spin_unlock(&tree->lock);
 
 	if (entry->length)
@@ -1649,9 +1651,10 @@ bool zswap_load(struct folio *folio)
 	if (entry->objcg)
 		count_objcg_event(entry->objcg, ZSWPIN);
 
-	zswap_entry_free(entry);
-
-	folio_mark_dirty(folio);
+	if (swapcache) {
+		zswap_entry_free(entry);
+		folio_mark_dirty(folio);
+	}
 
 	return true;
 }

