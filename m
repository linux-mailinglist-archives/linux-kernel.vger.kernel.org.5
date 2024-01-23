Return-Path: <linux-kernel+bounces-35045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE061838AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2781C213A1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B759B77;
	Tue, 23 Jan 2024 09:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+BgiAgR"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124DB59B69
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003683; cv=none; b=AFYm9mYRsNhYUj6XlGfl2giQwFD8/lTK5AnegMubncuUKux0xrSPzSS4FnY3BTzo3j40ZIem0dgtKZtf92K7AK6jk3QNyY/+QAwj9D9yBCPa9N+YnJSQ9ysceqUOUWRQXkI4eKPeX6KBeXixBspeteeqsRI/+ZBqRPBg4BV0mkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003683; c=relaxed/simple;
	bh=eV1aYAij36ErrxE/KFibUvTwNYPn7OUCmx40RKggj5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBGfzf0HR5wg/B0TJGlCTp7q/m9MYaRBzy5wzT/b/iwBIyeMwGNOqpimfgK1A3BHUTCYXVZ/J9xmifXPJSU/SyeZJ0Cfz9ngyUMrWESrNsQ5AI13OMshIzS7sn5VkbxPaM0h9X1V/brIPRr0fkXZNEYWG3ZXJN2ynzaLaWE3PW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+BgiAgR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so404884166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706003680; x=1706608480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5pQ0aAjBUgS36bFeU8hxTh3VJtNzSaVjd2DImOspnw=;
        b=a+BgiAgRJ6WwILOqJySZOmTShWuZ2Rwc3tetL+odpA8K1Vt2nacmkahvWOYJMJIIy/
         5GiVZ56nAYB2g1J0WiG2I+0uOZInh/UWpiCDDIhDHMKQ1JxwUGt7P9MEBVzLQoQ6CYHv
         IAzTvMaECt9gkripXnZOoCZmyLMtMITQmb5dHGHpdQlUEWRYlraA7Fv29tUSRmMllMSA
         mqpimlMBADEaFmMzuCSKnRbo+g9tEOw0nj68gf3OJoYlVsYJ/IWwIRvRRIw6mCWRf4rT
         YI11e73b0Ul+yH3yaTJ2XZFHKaM+1Gi1rBAmomklUKa/OQlVBvrnPKFdJLt31Devf6N2
         zsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003680; x=1706608480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5pQ0aAjBUgS36bFeU8hxTh3VJtNzSaVjd2DImOspnw=;
        b=pl4x5bSMPGnJ41au0yAybSBvExUb+8JN//DqVzejRP9g7pVDYSAqCj6ePqPyjurppS
         Wmjxw0c9Ht44fYUgxAbpRF+ij/+oXLqgEzfiXUWfEOH+XE/Grl75LE9CNAPXW0S+fK9F
         GnK1R30jiO9p/lzKS659iYH1oPFHZ+5q9AZg7dO112kUY6HOnlQtS73cn1Vh+ZvA3X6r
         BYPPPISXerDQKTvBF407tuC/u/HhxqjA0Btd3bJqWPaeYUkkTAfxG+Z/VsxKt6FvIjpW
         vNd2emQcDUZLxBlh97Y+2FFSxj+2MazsWOmu9btP2R2duASizY03+pIsYTZlbta12pGR
         GauA==
X-Gm-Message-State: AOJu0YwPrI2/nK+l9ia3iXdVuVv12zCqnWopgeadYpBh5qiCcg9+X7Ps
	ZxtyPxTG8hNBTxpbb50JqxKdqQIUmebQS8YvgLmAi3AD1lixFWFFLryzmLgsvbj/taf+rFd3lxx
	QciN3gA5Ox7KYcFHd5ZL7SmBTnnYhQxoDnQEm
X-Google-Smtp-Source: AGHT+IFiNb0gII9xlJrGDRXcA2JW5tXZJ5H5zdCdISF6vOZZl7rkbRXWVdFZCvKRB3/OFzNy1LpZIq/WvS4eFotWuHE=
X-Received: by 2002:a17:906:3adb:b0:a2c:34e8:6429 with SMTP id
 z27-20020a1709063adb00b00a2c34e86429mr3144327ejd.69.1706003679963; Tue, 23
 Jan 2024 01:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-2-yosryahmed@google.com> <87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
In-Reply-To: <CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 01:54:03 -0800
Message-ID: <CAJD7tkZSY4SJ89VxCotkLoB6VWN1SexuOTeNTaUKxqqPwbDvFQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are done
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Alternatively, we may just hold the spinlock in try_to_unuse() when we
> check si->inuse_pages at the end. This will also ensure that any calls
> to swap_range_free() have completed. Let me know what you prefer.

To elaborate, I mean replacing this patch and the memory barriers with
the diff below.

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2fedb148b9404..9b932ecbd80a8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2046,6 +2046,7 @@ static int try_to_unuse(unsigned int type)
        struct swap_info_struct *si = swap_info[type];
        struct folio *folio;
        swp_entry_t entry;
+       unsigned int inuse;
        unsigned int i;

        if (!READ_ONCE(si->inuse_pages))
@@ -2123,8 +2124,14 @@ static int try_to_unuse(unsigned int type)
         * and even shmem_writepage() could have been preempted after
         * folio_alloc_swap(), temporarily hiding that swap.  It's easy
         * and robust (though cpu-intensive) just to keep retrying.
+        *
+        * Read si->inuse_pages with the lock held to make sure that cleanups in
+        * swap_range_free() are completed when we read si->inuse_pages == 0.
         */
-       if (READ_ONCE(si->inuse_pages)) {
+       spin_lock(&si->lock);
+       inuse = si->inuse_pages;
+       spin_unlock(&si->lock);
+       if (inuse) {
                if (!signal_pending(current))
                        goto retry;
                return -EINTR;

