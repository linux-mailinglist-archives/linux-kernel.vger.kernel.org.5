Return-Path: <linux-kernel+bounces-110805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F9886425
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCB471F210FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE741DFD6;
	Thu, 21 Mar 2024 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwYMi7iG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8761E526
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065204; cv=none; b=ryzusqPbn6b7VQXgIKl0y+0shmxPz0eSJZQgxswTlPBvIgiI9OuEaKcLFziLAO3+uNQCRnKxqzuGKmaWWUtp7YS+tILsdEl56R0xnTr8CfpDHy1mBf7sCbaGCe3uzulRR95NnbDghJ2lITqPEk4JT9U9gKH/mVE5EfChfwpp99Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065204; c=relaxed/simple;
	bh=btGZzD1NGaWl5rIl1fGIHLafZR6K2hXr+pUs+/6xQ04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=blQRQmRZAnY1KlKx5F7VW6xOeIPYxZjpYGlb2DdmcyultErxcjZi5Cfd+C2uGsFU0bkFGkYqjjp9Vf38dy3pTCptn+9yRFXZWXArhQiLkVV8R+KMd2MrNtia3TSwQWCAxnnaeVmEkTJCJy1XHPqhtAKrdeYY6GNC8/L+NtNO8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwYMi7iG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EB0C433C7;
	Thu, 21 Mar 2024 23:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711065204;
	bh=btGZzD1NGaWl5rIl1fGIHLafZR6K2hXr+pUs+/6xQ04=;
	h=From:Date:Subject:To:Cc:From;
	b=EwYMi7iG7QWryLlhggsH0fDY5JjvXm8l1nyjC/vY10MDmqPAkczLUmBRrI/K4oTUl
	 QLgYAVTFpm1LrTJFuUzwADY2YVDrW7jyzT2jk8edq99+EZauOV1GbMpels6jc+vMrL
	 gaAFhkAXke4mdSN/PYE+BGEerwwEf6IguJ3lrSlW67G+pnzRcXCf9MMdRlSSikud+f
	 K+s8l5lyFA4uHyXPE53SrX4Mo3PhCVKAM+5LYpUM+kQa65rdJCX27B5RljYM327yj3
	 7m4F2BJHG8YhAMePGWNwtGmAnjlDy5qms4RNRPLvRw+9Hv100XkQyv1+p2z17JK5XS
	 mWhd7wy2oYr4Q==
From: Chris Li <chrisl@kernel.org>
Date: Thu, 21 Mar 2024 16:53:17 -0700
Subject: [PATCH] zswap: initialize entry->pool on same filled entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240321-zswap-fill-v1-1-b6180dbf7c27@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGzI/GUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDY0NT3ari8sQC3bTMnBzdNDPTNBMTU3MTczMDJaCGgqLUtMwKsGHRsbW
 1AHATTS5cAAAA
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Chengming Zhou <zhouchengming@bytedance.com>, Chris Li <chrisl@kernel.org>
X-Mailer: b4 0.12.4

Current zswap will leave the entry->pool uninitialized if
the page is same  filled. The entry->pool pointer can
contain data written by previous usage.

Initialize entry->pool to zero for the same filled zswap entry.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
Per Yosry's suggestion to split out this clean up
from the zxwap rb tree to xarray patch.

https://lore.kernel.org/all/ZemDuW25YxjqAjm-@google.com/
---
 mm/zswap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index b31c977f53e9..f04a75a36236 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1527,6 +1527,7 @@ bool zswap_store(struct folio *folio)
 			kunmap_local(src);
 			entry->length = 0;
 			entry->value = value;
+			entry->pool = 0;
 			atomic_inc(&zswap_same_filled_pages);
 			goto insert_entry;
 		}

---
base-commit: a824831a082f1d8f9b51a4c0598e633d38555fcf
change-id: 20240315-zswap-fill-f65f44574760

Best regards,
-- 
Chris Li <chrisl@kernel.org>


