Return-Path: <linux-kernel+bounces-144406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEA28A4587
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE9E281D02
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00797136E0C;
	Sun, 14 Apr 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="je2xaR87"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFDD524C9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713128795; cv=none; b=iUMg1tWHenm8+drAd5f3RxWH357rGbxqstHKXGj5qKtsG8zcavVM/YXZ4331kOwKXrqeThog0b+cItcB+8tZOJBXDI7n0dPA9ig/5RKQ8YqmHrHgkrQDpGIMnQADyQ+QmK3B/ZMmZdce8j3UISinCFFm2ZX9VPcjqAsB1vY3nXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713128795; c=relaxed/simple;
	bh=SWZJ+CkHy7kq/UJMpVNF2zMXceuPlffYG1xqTphqKCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDdOmwqQTRUaiaw9bie3lykWO2Uo9VN0OzN0yxWsqJumBM2VHWHv7ZVXltfJb2QNwRqXrp9PGtIgrd02fB1Y/hZXoNgR2sMVf4ybuEO3jM0+KnT5ICco/otj1Q8kjOE6KjHWWw6PKuQKwLVk74oKtjAUT+JDwp5qdc1B06aQkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=je2xaR87; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2a2fec91d48so2346630a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713128793; x=1713733593; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BdBwYWuVW4AqQLpUoIhih1uGjNBTaB7zR1bxs61C0zI=;
        b=je2xaR870gaPSF7ujCnNbZ4bpTO//+gSv092pk748I6GHwaZzrhY2AYS7L88Hr9ALy
         pDpj7VzRKMn/89Z+RslPGGYdr7jB2tTd1QCLt8wREz6RewmcMfA1OogYFJg2ywjm5YF5
         UPct8PfNMuHMcwTnQhIom2jlTl+H4rnuYMye4m3oJ6HuOAW99ejFLiYv7cZXBT8fhIQw
         s+GJ4O29MMdqyMUREiMY53G56NrrF9zqNYUykGIqTUHh2bZ3rGTcJKFbmbun2m+z8nUd
         PxkidoXb6fDo7bQE+dOvZHPNmsIG3aEHLMBZKYMhGVAEJjWwe8OQhNZHEzPBnwMHg4dW
         WUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713128793; x=1713733593;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdBwYWuVW4AqQLpUoIhih1uGjNBTaB7zR1bxs61C0zI=;
        b=EVto3YOVLDX9RCnW8N1cNNQZqKOE6MO8yMuzT8irbADFhb6knkNlhyi8ZmSVCqBi39
         dG1z08Sptt0rEDkmUFNP9PYSaWdFVT2ypXKp9cGuIa29oRTFC5rXf00xV6NVqHQ7hwJA
         FoiO8nQxyRZ8HWkpUWspVlvI206k8HdmGXjVbZ6MWgvcduuhetbam9UD3ZnqJP2juMGF
         92qVuws+XFnizV9UxTZGbja6uFtCrMBUxRKJn4TylD69t+x7E7mSj8pmNUra9tjFXCZF
         sxRbTB74Sesi4dOeRKtqbHUHtqiMNdafRe8kM57nDVfW1sz8xg3N9qfQ5P9b0cRS3IgO
         AI5w==
X-Forwarded-Encrypted: i=1; AJvYcCWa68oAD9ekpSUqbZ68pKm31fT975xcOVA2qd7+r8MoacPC/ESRKaFdcK3bg6CRZIMXTrqeYiPWj3AhwZLZ9xxWsHdeCZ0WyVypmLUn
X-Gm-Message-State: AOJu0YznCfQUwV+uqY5oe5kktD8lmABTMSagcF+OatJgXS0JB8JNJoLt
	FLx74J28qbLIEHYq+TJIVEk2N2zG45dxPnx/jrYj2mgPlXW+6ZNGWS1eI4airSTTqlW45TcAAvg
	8ysTdtVVfkcMVz6GfJQ==
X-Google-Smtp-Source: AGHT+IGM2khxPg7tK4h8PAgGkzh+uhM2hW2ruzB5mqea7FJcnasbsCi94kbNLsJP4rHiG6MfRcvHI1SITe8WMKCD
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6a00:2d99:b0:6ea:f424:85ce with
 SMTP id fb25-20020a056a002d9900b006eaf42485cemr112155pfb.0.1713128792684;
 Sun, 14 Apr 2024 14:06:32 -0700 (PDT)
Date: Sun, 14 Apr 2024 21:06:30 +0000
In-Reply-To: <a7abb61f-0660-4c37-b2b2-e46817ca5b14@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240413022407.785696-1-yosryahmed@google.com>
 <20240413022407.785696-5-yosryahmed@google.com> <a7abb61f-0660-4c37-b2b2-e46817ca5b14@maciej.szmigiero.name>
Message-ID: <ZhxFVggdyvCo79jc@google.com>
Subject: Re: [PATCH v3 4/4] mm: zswap: remove same_filled module params
From: Yosry Ahmed <yosryahmed@google.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Sat, Apr 13, 2024 at 10:56:47PM +0200, Maciej S. Szmigiero wrote:
> On 13.04.2024 04:24, Yosry Ahmed wrote:
> > These knobs offer more fine-grained control to userspace than needed and
> > directly expose/influence kernel implementation; remove them.
> > 
> > For disabling same_filled handling, there is no logical reason to refuse
> > storing same-filled pages more efficiently and opt for compression.
> > Scanning pages for patterns may be an argument, but the page contents
> > will be read into the CPU cache anyway during compression. Also,
> > removing the same_filled handling code does not move the needle
> > significantly in terms of performance anyway [1].
> > 
> > For disabling non_same_filled handling, it was added when the compressed
> > pages in zswap were not being properly charged to memcgs, as workloads
> > could escape the accounting with compression [2]. This is no longer the
> > case after commit f4840ccfca25 ("zswap: memcg accounting"), and using
> > zswap without compression does not make much sense.
> > 
> > [1]https://lore.kernel.org/lkml/CAJD7tkaySFP2hBQw4pnZHJJwe3bMdjJ1t9VC2VJd=khn1_TXvA@mail.gmail.com/
> > [2]https://lore.kernel.org/lkml/19d5cdee-2868-41bd-83d5-6da75d72e940@maciej.szmigiero.name/
> > 
> > Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> > Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> > ---
> 
> I think you need to update zswap kernel docs, too.

Ah yes, I had local changes to update the docs but apparently never
committed them. Thanks for catching this.

Andrew, could you please fold in the following patch or merge it as as
separate one? Whatever you prefer. Thanks.

From 6191c528fee01a4c79b43c53ccbd0273b705965e Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Sun, 14 Apr 2024 21:03:43 +0000
Subject: [PATCH] mm: zswap: remove same_filled_pages from docs

The module parameters are now removed, remove all references from kernel
docs.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 Documentation/admin-guide/mm/zswap.rst        | 29 -------------------
 .../driver-api/crypto/iaa/iaa-crypto.rst      |  2 --
 2 files changed, 31 deletions(-)

diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin-guide/mm/zswap.rst
index b42132969e315..59783134afbe9 100644
--- a/Documentation/admin-guide/mm/zswap.rst
+++ b/Documentation/admin-guide/mm/zswap.rst
@@ -111,35 +111,6 @@ checked if it is a same-value filled page before compressing it. If true, the
 compressed length of the page is set to zero and the pattern or same-filled
 value is stored.
 
-Same-value filled pages identification feature is enabled by default and can be
-disabled at boot time by setting the ``same_filled_pages_enabled`` attribute
-to 0, e.g. ``zswap.same_filled_pages_enabled=0``. It can also be enabled and
-disabled at runtime using the sysfs ``same_filled_pages_enabled``
-attribute, e.g.::
-
-	echo 1 > /sys/module/zswap/parameters/same_filled_pages_enabled
-
-When zswap same-filled page identification is disabled at runtime, it will stop
-checking for the same-value filled pages during store operation.
-In other words, every page will be then considered non-same-value filled.
-However, the existing pages which are marked as same-value filled pages remain
-stored unchanged in zswap until they are either loaded or invalidated.
-
-In some circumstances it might be advantageous to make use of just the zswap
-ability to efficiently store same-filled pages without enabling the whole
-compressed page storage.
-In this case the handling of non-same-value pages by zswap (enabled by default)
-can be disabled by setting the ``non_same_filled_pages_enabled`` attribute
-to 0, e.g. ``zswap.non_same_filled_pages_enabled=0``.
-It can also be enabled and disabled at runtime using the sysfs
-``non_same_filled_pages_enabled`` attribute, e.g.::
-
-	echo 1 > /sys/module/zswap/parameters/non_same_filled_pages_enabled
-
-Disabling both ``zswap.same_filled_pages_enabled`` and
-``zswap.non_same_filled_pages_enabled`` effectively disables accepting any new
-pages by zswap.
-
 To prevent zswap from shrinking pool when zswap is full and there's a high
 pressure on swap (this will result in flipping pages in and out zswap pool
 without any real benefit but with a performance drop for the system), a
diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index de587cf9cbed4..4cb1d52ea6dc4 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -457,7 +457,6 @@ Use the following commands to enable zswap::
   # echo deflate-iaa > /sys/module/zswap/parameters/compressor
   # echo zsmalloc > /sys/module/zswap/parameters/zpool
   # echo 1 > /sys/module/zswap/parameters/enabled
-  # echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
   # echo 100 > /proc/sys/vm/swappiness
   # echo never > /sys/kernel/mm/transparent_hugepage/enabled
   # echo 1 > /proc/sys/vm/overcommit_memory
@@ -599,7 +598,6 @@ the 'fixed' compression mode::
   echo deflate-iaa > /sys/module/zswap/parameters/compressor
   echo zsmalloc > /sys/module/zswap/parameters/zpool
   echo 1 > /sys/module/zswap/parameters/enabled
-  echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
 
   echo 100 > /proc/sys/vm/swappiness
   echo never > /sys/kernel/mm/transparent_hugepage/enabled
-- 
2.44.0.683.g7961c838ac-goog



