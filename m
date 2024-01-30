Return-Path: <linux-kernel+bounces-43748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8768484188F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F86286776
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADF381B1;
	Tue, 30 Jan 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="DhOdvnCB"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F2C381AC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578947; cv=none; b=dZ2MtH8wSOuyOQQhon8cEURM2MMimcwgC2/TQ7zsLmzt3LtG+67u/y2DO6ZyaTkD/1ssx8BQxMh+cU/R/bHYbEZ9upc73xGuV6THTD9mX/4ES6QysVLttn1uvy94C5sl3/m0MxZ8HG1SlKkKGezEAmsLBh8yVnnG74tn5Doaqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578947; c=relaxed/simple;
	bh=NSf7/7XE+Ua256/ji15QEBMmIEdQMUCKLsK1Z44ZjCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/vFRtOgl9amIAJyn3GjG54FE4hmAGYYb++qAzs5+sSXSQnsxbVJS1W1HUX0HWzBichdKno7lO6AqMWJ3fc+r114gUcxEuv/rAkGjbGSsfo3GzsiZYPHxCZ/rR7HOR0sqoX0XtXSqZlUVpDpZ1TFVFbSW+G77C2ZJxDEksnLjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=DhOdvnCB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-68c495ba558so13028036d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578944; x=1707183744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YF/Bz5keaw8EKm3mlmWlxcJJmelaMJ52iqxIOq55K14=;
        b=DhOdvnCBSRNAf53Ma4noBLU2yvWiveDDh04yo/cRMvwHODciaBPksZq2Um17ckQaBW
         0Hq/LTjG8OCgdTAaVLJMan+5TSM/zVx3GYd88SehecPaB/dMtgFz16XEPOkyC7aggE5M
         rTz0WgWmFlQbokM4jmBd03rZPyCFNvZ8xkPXKP9+zNTHKc/BfFJZPe5cERZGUVS5fF9M
         kHqCh7U2z3EN06jjKsbtQrS61ytqBPo5CcyxMA+IlMyOPBGzj8XF8bTrqJEKX3jXcWTW
         33/y8xyjQCz8C2rCFxYsRjzyt9PrS/ocBoiZ+t/DyuarHKcykpDOUwoXDQ4cS4IyDjAk
         XW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578944; x=1707183744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YF/Bz5keaw8EKm3mlmWlxcJJmelaMJ52iqxIOq55K14=;
        b=VxZUgJdCHPXLOVt9IERw4w9zP0wZPa5yA07kaunP6Rt4B1yFG5Q7T8MVIuDu4bGbi9
         Am9GgL7o2nTZKZpa2QVvfSQ4c/5QFyryNWs/mjBCcdo9INZegG6wHtOHyg6MviPiOySc
         PGNaChibAhxKjHVG26oUD308oUxXNjAzVYtbNs3FgpFZRcOgnmPgul+doC6An0h+kqEa
         c4Vx8eGvsQFSbbDHMEuXlDLTC2Cgx+PXVfCpIMF/xd/GO98GqUUQ8jekLy3PZBzh7TDk
         wJWVB1FmjqKQ8lfRjAXLIrJu5DmCu0NWS6hj9abcYVxVnjoJpFyGFJBKzxetc5mIJGcF
         1gOw==
X-Gm-Message-State: AOJu0YyFEUdG5rj392Tdt1qd7MwgWbMFzlul8M8+Cb0RHLXpetvKynNB
	03afODnVpnkpnmwRULJcrTh/LoZj/8X0kRHcsRnf7T0m8zF1BIzoruWwFvy96sc=
X-Google-Smtp-Source: AGHT+IEJUv991aH24M+mVS5b+IJCVkoWklj7Vk7Ouj1HKmo2haOgY/W/6O3BRf6ukVaZRAeczwm31g==
X-Received: by 2002:a05:6214:1804:b0:68c:623d:13d3 with SMTP id o4-20020a056214180400b0068c623d13d3mr24326qvw.68.1706578944683;
        Mon, 29 Jan 2024 17:42:24 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id kf4-20020a056214524400b006837a012417sm3992019qvb.51.2024.01.29.17.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:24 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] mm: zswap: simplify zswap_invalidate()
Date: Mon, 29 Jan 2024 20:36:45 -0500
Message-ID: <20240130014208.565554-10-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The branching is awkward and duplicates code. The comment about
writeback is also misleading: yes, the entry might have been written
back. Or it might have never been stored in zswap to begin with due to
a rejection - zswap_invalidate() is called on all exiting swap entries.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index cde309c539b3..082d076a758d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1739,15 +1739,10 @@ void zswap_invalidate(int type, pgoff_t offset)
 	struct zswap_tree *tree = swap_zswap_tree(swp_entry(type, offset));
 	struct zswap_entry *entry;
 
-	/* find */
 	spin_lock(&tree->lock);
 	entry = zswap_rb_search(&tree->rbroot, offset);
-	if (!entry) {
-		/* entry was written back */
-		spin_unlock(&tree->lock);
-		return;
-	}
-	zswap_invalidate_entry(tree, entry);
+	if (entry)
+		zswap_invalidate_entry(tree, entry);
 	spin_unlock(&tree->lock);
 }
 
-- 
2.43.0


