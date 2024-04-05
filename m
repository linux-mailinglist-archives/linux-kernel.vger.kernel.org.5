Return-Path: <linux-kernel+bounces-132312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013848992D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DA31C2355B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8C01CD2B;
	Fri,  5 Apr 2024 01:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cp6dUbSb"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708C8DF5B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712280960; cv=none; b=kWPdSouTPAjaHnvOWxSHkrs7SyqPg5WH06YazpN8lAJ0ahQbjNLqyMm1teuqkYo0QGjNwZrpPoVYDfFDoVNzFEaZCoTTrDxKLVGBFKcfitWrF1OiNEtOJbTZiJRhK85kWXgutqc3UhMe5HV5+XmyB6erFADfx908NKqJQsxvm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712280960; c=relaxed/simple;
	bh=EKrGZSwVFwew2HMPiLb4JaHCc0fDKmV9LIy0S8SK7FM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oeSNJD6hZubvPqjMyAQIgBPt72W+lVt35J8UWTqimD28sxoLh5z1bGDWsewo0Wewwca509vOxt28VBy6ss3neh2c/Au4MPP/Ifnx0mak6u3lf6u73jF4VrSywBHpEjBOrQomGunU/Lu9sey0iuLQaTpheY63zMHHjDHzxqaimdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cp6dUbSb; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so2641502276.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712280958; x=1712885758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ1QXrjwhIal4gIkbl9SlMnvEbBP+lXyDn0RpoWpImY=;
        b=cp6dUbSbSNHw7ZVlTrAfUK7741QJsSJ0N6uQVXswNL8uzz1QjPSHNn+2VTZT3hc//f
         Dhm5sdWjZko1pUmWRuVFHU/pFTOGnDzqfG2HlFz7dV+9jFYz/7KF0sNm9aYCwxmKuehj
         8uFDScG+bFnMP0z0MUBKhqyRuykYzO6KNFe4AM6++Zupw2eXJQ8sH/x0HkQZ5SLSarnn
         RsTXI5r9Jczb4b/+7CvnPiaDJExwag6rFzU84Jm08yVm1jkzzcbUrP2OQsEgldhopoEn
         9MW2mbrYiXjYk4Eo5aoUCfXsipvrUawefuTtXv0GDRqVfDdfG8QCuI2N//XdE4HJvJfp
         ThPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712280958; x=1712885758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZ1QXrjwhIal4gIkbl9SlMnvEbBP+lXyDn0RpoWpImY=;
        b=jzYMbIQrKDqu3L346DkcqzwBxZoXScFg1kv4XkQV0pNhC1DyFtx1NY3xywbR1gDFx6
         MVCYTwNtQ9yjOh7PqICGgEildVsqu1R6eWW69K5xh8+lUU9gQAjch2aawyNFG/UD0HT5
         wrwD5wFTTJ2YLq56jRxN5KTC7GynnaLVSlY6w41aqpLhaNZY+igCV7UJPpdWsf0+xKMA
         ddElXGHYbNBb0CSxtpZQKenF2pcTFSUXtpVS+btGqXELqNz0xpMEZOIcjge75KcPIvA0
         2/CFSGNcwfZjLGJV5dIyzz5dSBleujMoDiT+YYjnSmuO0gn7ggYpSYhcpTHXspYRpJs6
         aV/w==
X-Forwarded-Encrypted: i=1; AJvYcCW3iGopi/XKq5kT8dkTOp/hS/1I5FBh2Qz3IQU4VkQRqwKg7LXxZ2QzSgqR2i06ikFnt4zWnahS73f0ecgltSCQ60V21zcmS5k/nrPF
X-Gm-Message-State: AOJu0YzcS+2aM5NnxrZCIijJMBvm6Tk+iyInsfX8dZ515lJk94UUEtKZ
	E4QEucwk7VtSloEGRKBeU/vRLU+unwbUG0GFGfTNsMex/JfaXMeoI/V9I3PoXD+810VQ3T86t89
	w9uuk+NCqm/35aUKxvA==
X-Google-Smtp-Source: AGHT+IF08nd+KBQE70LXZSIBvDA4LHuHsKmvLNuPmdBMBqFS4+vTxuqxYNRCiDtgu7m3HgM9JubMSqb0OVDe26Bd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:2b05:b0:dc6:e1ed:bd1a with
 SMTP id fi5-20020a0569022b0500b00dc6e1edbd1amr351076ybb.2.1712280958518; Thu,
 04 Apr 2024 18:35:58 -0700 (PDT)
Date: Fri,  5 Apr 2024 01:35:47 +0000
In-Reply-To: <20240405013547.1859126-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405013547.1859126-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405013547.1859126-6-yosryahmed@google.com>
Subject: [PATCH v1 5/5] mm: zswap: do not check the global limit for
 same-filled pages
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

When storing same-filled pages, there is no point of checking the global
zswap limit as storing them does not contribute toward the limit Move
the limit checking after same-filled pages are handled.

This avoids having same-filled pages skip zswap and go to disk swap if
the limit is hit. It also avoids queueing the shrink worker, which may
end up being unnecessary if the zswap usage goes down on its own before
another store is attempted.

Ignoring the memcg limits as well for same-filled pages is more
controversial. Those limits are more a matter of per-workload policy.
Some workloads disable zswap completely by setting memory.zswap.max = 0,
and those workloads could start observing some zswap activity even after
disabling zswap. Although harmless, this could cause confusion to
userspace. Remain conservative and keep respecting those limits.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a85c9235d19d3..8763a1e938441 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1404,6 +1404,7 @@ bool zswap_store(struct folio *folio)
 	struct zswap_entry *entry, *old;
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
+	bool same_filled = false;
 	unsigned long value;
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
@@ -1427,7 +1428,8 @@ bool zswap_store(struct folio *folio)
 		mem_cgroup_put(memcg);
 	}
 
-	if (zswap_check_full())
+	same_filled = zswap_is_folio_same_filled(folio, &value);
+	if (!same_filled && zswap_check_full())
 		goto reject;
 
 	/* allocate entry */
@@ -1437,7 +1439,7 @@ bool zswap_store(struct folio *folio)
 		goto reject;
 	}
 
-	if (zswap_is_folio_same_filled(folio, &value)) {
+	if (same_filled) {
 		entry->length = 0;
 		entry->value = value;
 		atomic_inc(&zswap_same_filled_pages);
-- 
2.44.0.478.gd926399ef9-goog


