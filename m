Return-Path: <linux-kernel+bounces-150073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC98A99FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257C5B20805
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388738F9B;
	Thu, 18 Apr 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="XGJKaNoS"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025E71EA8F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444053; cv=none; b=HsZLieb27jDmA8WMaEIZanJ1E29vGChhqCF6+CjWyx8g6MtMHgeDNOqzBQKQQI12SYpEp6mDrN3XPgH2eMxXEVPhPHcXGQPWXMFS7TPIAwzrXtYsyo15VzUTDI79sUEO3h4Vhl1WLVOwhHOD20a31H2YnyHNnr5ZYKky8HLzR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444053; c=relaxed/simple;
	bh=WIWI3yHKnVFiaW6pEn33UHdpoGSoHsOI9hbl8L7S3KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aONDvxh1RC2nG8+DYySPpNd/faMujNKi4lKf/+/dIO+xEl6hobbRj6ddyflW4rZiKOorhJCFmyztewZDtPDW2lvpaipVaXkjGkj9B0Luzk7PAv2Mm5YIyn0vMIJgfu3aYIfV56zwnZZNyKNOiPHjgmCEhlHl3d7YAEmW70ZWhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=XGJKaNoS; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de45385a1b4so914640276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1713444049; x=1714048849; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GsKNX1Jtc4wi0IxWCLI9huAtIgpytdCJy3O9dcSAXkc=;
        b=XGJKaNoSUHwS0aMz2Nt8GYvkHQPOunGIZtOjtSENXyxo8V67zeKLxZlJotT8d/9Uye
         XB00o3nMrAvnvzXEWG5kTMNr+7WoIAQl3YPIdTFg3U+q9rxqkOc9olKmKOA3QxiXGhec
         vul2+o3tbPtYSQRBbD8NxmU6ki317E6v5PDRM+VGKTPXKW5Nh/ER6tE7nVqiKMMDddel
         1OcM7BoxzQFO5FoKkJJGOL2BOrmhpoqio8aD8bNskudrReHSbjqha0T/IYb7t71dtXb0
         aS3HWU1yLq+oilAKnC8SWeeeW/QE/5hYiwToG4E2ZT487XUp0GvGBUfN3m+kxJ/hxlJP
         tCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713444049; x=1714048849;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsKNX1Jtc4wi0IxWCLI9huAtIgpytdCJy3O9dcSAXkc=;
        b=fDbvVJhLrTaumt8b2d7d4RxoFS306sQ/ni7lFUrPoEJb/nqk+PguNuHI/jNpnP4e7w
         r47SjDgxj3k5p6gBMXP5tGi2cTFPhCFW9dMzH1nJBS5ySGGSFXtGh8n0leyATxHjjpa/
         2RM9GfoRAbC/Cng9aKT2MiWnkkwmAuJUebrbeWcY7EjayHkVUQbJuYnhLuI4likgzDv4
         jBVbBh+96w6oMsQAL61AsvbbDnmKXNJr3UK8WEIXjqkqL1qinvLYtdpRgHm44HCCKsPD
         EmFYxRyl2GdKoJ/2Mgi5dLKRYpRzbH0CeHVnonPYU5U37VHAxfAVL415y+hhA63SadDg
         kCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvKH35EtwdRELh2XhVqQyNOwN9kVJUYu4cS+dpfuNtuRAeO0+R7ATmF/NHHQMXOIR1AGZixjVbqMDC9zACGrd7g72sMbgLdtgboKNF
X-Gm-Message-State: AOJu0Yxl49emyeyXAfyzX43b8bZYeBe9ku5g5aCpl2TJDeeE3lFvEZfr
	4T3s/IzmLciZ3jZ6QNKBfE7Cgw/Q/uiC0zdQr7ANtabn6o/e/KXUhJH0zZW+Qfw=
X-Google-Smtp-Source: AGHT+IERuqNJodHHhR9bpgG5Jr20Xw1NRIZhIY4E3cxpBfRykLDmFH6hSFHv4vP9FAislo8rM+OVMw==
X-Received: by 2002:a25:198b:0:b0:de4:5c94:f58f with SMTP id 133-20020a25198b000000b00de45c94f58fmr2504112ybz.15.1713444048816;
        Thu, 18 Apr 2024 05:40:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:fe4f])
        by smtp.gmail.com with ESMTPSA id a14-20020a0ce34e000000b0069b4fe0569fsm587500qvm.109.2024.04.18.05.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:40:48 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:40:43 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian Heusel <christian@heusel.eu>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Seth Jennings <sjenning@redhat.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Vitaly Wool <vitaly.wool@konsulko.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, David Runge <dave@sleepmap.de>,
	"Richard W.M. Jones" <rjones@redhat.com>,
	Mark W <instruform@gmail.com>, regressions@lists.linux.dev,
	Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [REGRESSION] Null pointer dereference while shrinking zswap
Message-ID: <20240418124043.GC1055428@cmpxchg.org>
References: <3iccc6vjl5gminut3lvpl4va2lbnsgku5ei2d7ylftoofy3n2v@gcfdvtsq6dx2>
 <CAKEwX=MZ3jTVpN4g-qrhTn2b0i0C6_M=8BtKt9KEPyFHb+4W2w@mail.gmail.com>
 <CAKEwX=NM1y-K1-Yw=CH3cM-8odER1PZBVoWo-rs7_OdjFG_puw@mail.gmail.com>
 <CAKEwX=MWPUf1NMGdn+1AkRdOUf25ifAbPyoP9zppPTx3U3Tv2Q@mail.gmail.com>
 <246c1f4d-af13-40fa-b968-fbaf36b8f91f@linux.dev>
 <20240417143324.GA1055428@cmpxchg.org>
 <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c3ppfjxnrqx6g52qvvhqzcc4pated2q5g4mi32l22nwtrkqfq@a4lk6s5zcwvb>

On Wed, Apr 17, 2024 at 07:18:14PM +0200, Christian Heusel wrote:
> On 24/04/17 10:33AM, Johannes Weiner wrote:
> >
> > Christian, can you please test the below patch on top of current
> > upstream?
> >
> 
> Hey Johannes,
> 
> I have applied your patch on top of 6.9-rc4 and it did solve the crash for
> me, thanks for hacking together a fix so quickly! 🤗
> 
> Tested-By: Christian Heusel <christian@heusel.eu>

Thanks for confirming it, and sorry about the breakage.

Andrew, can you please use the updated changelog below?

---

From 52f67f5fab6a743c2aedfc8e04a582a9d1025c28 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 18 Apr 2024 08:26:28 -0400
Subject: [PATCH] mm: zswap: fix shrinker NULL crash with cgroup_disable=memory

Christian reports a NULL deref in zswap that he bisected down to the
zswap shrinker. The issue also cropped up in the bug trackers of
libguestfs [1] and the Red Hat bugzilla [2].

The problem is that when memcg is disabled with the boot time flag,
the zswap shrinker might get called with sc->memcg == NULL. This is
okay in many places, like the lruvec operations. But it crashes in
memcg_page_state() - which is only used due to the non-node accounting
of cgroup's the zswap memory to begin with.

Nhat spotted that the memcg can be NULL in the memcg-disabled case,
and I was then able to reproduce the crash locally as well.

[1] https://github.com/libguestfs/libguestfs/issues/139
[2] https://bugzilla.redhat.com/show_bug.cgi?id=2275252

Fixes: b5ba474f3f51 ("zswap: shrink zswap pool based on memory pressure")
Cc: stable@vger.kernel.org	[v6.8]
Link: https://lkml.kernel.org/r/20240417143324.GA1055428@cmpxchg.org
Reported-by: Christian Heusel <christian@heusel.eu>
Debugged-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Tested-By: Christian Heusel <christian@heusel.eu>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index caed028945b0..6f8850c44b61 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1331,15 +1331,22 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	if (!gfp_has_io_fs(sc->gfp_mask))
 		return 0;
 
-#ifdef CONFIG_MEMCG_KMEM
-	mem_cgroup_flush_stats(memcg);
-	nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
-	nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
-#else
-	/* use pool stats instead of memcg stats */
-	nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
-	nr_stored = atomic_read(&zswap_nr_stored);
-#endif
+	/*
+	 * For memcg, use the cgroup-wide ZSWAP stats since we don't
+	 * have them per-node and thus per-lruvec. Careful if memcg is
+	 * runtime-disabled: we can get sc->memcg == NULL, which is ok
+	 * for the lruvec, but not for memcg_page_state().
+	 *
+	 * Without memcg, use the zswap pool-wide metrics.
+	 */
+	if (!mem_cgroup_disabled()) {
+		mem_cgroup_flush_stats(memcg);
+		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
+		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
+	} else {
+		nr_backing = zswap_pool_total_size >> PAGE_SHIFT;
+		nr_stored = atomic_read(&zswap_nr_stored);
+	}
 
 	if (!nr_stored)
 		return 0;
-- 
2.44.0

