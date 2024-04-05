Return-Path: <linux-kernel+bounces-132425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903468994C1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20FD1C22766
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 05:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E6722EF2;
	Fri,  5 Apr 2024 05:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SX2yZXrs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883321A19
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 05:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712295317; cv=none; b=WmkmFUNAle1W09Nd9LdZvWGsQbNP072pjL4STdscf4H/gv3PkfnIIqqOT9TFuLQ3M1vOzy0zvYmqFnWU+y4RgXbZ3a2SWgVb2xNTgFNVXXQ08c2GpfSUCKoLsYgufE6dJ/VbwykCKcmI4wuXNRQ6x/7MiUHcCz/ODy3A/kpsd8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712295317; c=relaxed/simple;
	bh=0EwsJFsFqxelfzk3PZ8b/+zJHvbghrn5+keHiziw9TE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Puw6kUPa+UTRugET1/RBrvQpOkKJhisQmEKJrKeoR1M8s9GNumxVgBqatzH5eZAZWYTtqvhrfE84vp4ZF6rcwEtyVqyMXM6JxvhPNa2UfasjytCH67s90WnfFUzDF+xmEPpFasx2NLBBqS3SzMlo2L9NNicgwoLyGCcM/jGEZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SX2yZXrs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61561dbdf14so29386417b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 22:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712295314; x=1712900114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fbFnbwv9ZL9vnT6aD0Y4iZUVe+aMA3yOt75trlF6TiA=;
        b=SX2yZXrsFa9FkNg9hBL4bKCR+uQQYS0p9nASGiSjhlicAZnJ7a9+T59aJgHa+26Y/K
         0V5yzBxEyzv4OdMmYl/MJtZEIf1D4VIKFpVr7+SOnl1Et4GS0yM9wk6YHmOqQMGpsB2Y
         RSEYZxxIFKYvTbXbkCvYXvFK9P8Wx4hKaejvEE7SyF6MYay2HJiaoxgBTfsAOlSwacZL
         1Fbn20B5vLAi1gCeqLaKLVVaiKe3mBF9BmX9MPzGnXlXBeNrJ+x/PDHBLV0N4OIUgFXS
         e9gktuCbE/Bs2YIcRmkZQsfX5zNK02ATEsQUZGDz3Jkjm9LquJMRMjWEQP3EIRfgWloD
         NE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712295314; x=1712900114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fbFnbwv9ZL9vnT6aD0Y4iZUVe+aMA3yOt75trlF6TiA=;
        b=Z8PmiKC0CiQVB2+QP02YpnV24noFa5ljnwdE8oj8vIXyaszFCswTxaqWJZfXwncxy4
         1iD9cl+K2xRs2VT2p17HUpDUnUQeeKiGSniuAD0LZZDrj6ZS/2IA3OBj/p5fdlNKSkF0
         1vYGIZWw//phXGQXrDqAcXAVS+nCwE/rmFyNLq6zFwcNtE4OwF/8S6JeHGUlUmuV7KKC
         9FVVTt6JDGKbQutW2KpCpZlgmrcndm4xWTaXMm2xaUYYHGG1NeynG2bg8x2Pu1ujlqJb
         +u2eEpVX41EKWykWCms/DwHnFqNVOZ13tocmH3ngx0QAUvZ7wm/rNz60al/yO1JYXpAT
         z90A==
X-Forwarded-Encrypted: i=1; AJvYcCVVKOWby+DpRYQ/3+kySaDWwNxkSYgfdIl4Q8JIObp+XNIMl6IFobxyQW09OxPdT98zoc/yta4z1Cm556YnTqQ2Yd1opMewgCbRxfe6
X-Gm-Message-State: AOJu0YxtrNAXSPKE0SoXkjHymywLCOwru73xmaQGP9rZ2upNjlnlO8cE
	yba5vP6cGhdgV52uMQm06Bx1iJnaJ5M3qbvoKtqXUUaDRgl2MiorLCQ8CJ2IsrzzUyVHDyeKKGM
	gDk73I2m3ILKmO41Hzw==
X-Google-Smtp-Source: AGHT+IFlLjixyUEVN4p+xx4HWF7PyspM95D8o4YEWmVCPSbSGxL2ZvuIRWMLaNCJ7MC52j1a09GwvbWQG08Vtp36
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:e84:b0:dc7:463a:46d2 with SMTP
 id dg4-20020a0569020e8400b00dc7463a46d2mr387870ybb.0.1712295314619; Thu, 04
 Apr 2024 22:35:14 -0700 (PDT)
Date: Fri,  5 Apr 2024 05:35:06 +0000
In-Reply-To: <20240405053510.1948982-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405053510.1948982-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405053510.1948982-2-yosryahmed@google.com>
Subject: [PATCH v2 1/5] mm: zswap: always shrink in zswap_store() if zswap_pool_reached_full
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The cleanup code in zswap_store() is not pretty, particularly the
'shrink' label at the bottom that ends up jumping between cleanup
labels.

Instead of having a dedicated label to shrink the pool, just use
zswap_pool_reached_full directly to figure out if the pool needs
shrinking. zswap_pool_reached_full should be true if and only if the
pool needs shrinking.

The only caveat is that the value of zswap_pool_reached_full may be
changed by concurrent zswap_store() calls between checking the limit and
testing zswap_pool_reached_full in the cleanup code. This is fine
because:
- If zswap_pool_reached_full was true during limit checking then became
  false during the cleanup code, then someone else already took care of
  shrinking the pool and there is no need to queue the worker. That
  would be a good change.
- If zswap_pool_reached_full was false during limit checking then became
  true during the cleanup code, then someone else hit the limit
  meanwhile. In this case, both threads will try to queue the worker,
  but it never gets queued more than once anyway. Also, calling
  queue_work() multiple times when the limit is hit could already happen
  today, so this isn't a significant change in any way.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index c4979c76d58e3..1cf3ab4b22e64 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1429,12 +1429,12 @@ bool zswap_store(struct folio *folio)
 	if (cur_pages >= max_pages) {
 		zswap_pool_limit_hit++;
 		zswap_pool_reached_full = true;
-		goto shrink;
+		goto reject;
 	}
 
 	if (zswap_pool_reached_full) {
 		if (cur_pages > zswap_accept_thr_pages())
-			goto shrink;
+			goto reject;
 		else
 			zswap_pool_reached_full = false;
 	}
@@ -1540,6 +1540,8 @@ bool zswap_store(struct folio *folio)
 	zswap_entry_cache_free(entry);
 reject:
 	obj_cgroup_put(objcg);
+	if (zswap_pool_reached_full)
+		queue_work(shrink_wq, &zswap_shrink_work);
 check_old:
 	/*
 	 * If the zswap store fails or zswap is disabled, we must invalidate the
@@ -1550,10 +1552,6 @@ bool zswap_store(struct folio *folio)
 	if (entry)
 		zswap_entry_free(entry);
 	return false;
-
-shrink:
-	queue_work(shrink_wq, &zswap_shrink_work);
-	goto reject;
 }
 
 bool zswap_load(struct folio *folio)
-- 
2.44.0.478.gd926399ef9-goog


