Return-Path: <linux-kernel+bounces-43741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7961841886
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73805283375
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4705D364C7;
	Tue, 30 Jan 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="AHQnVhmf"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF63611F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578939; cv=none; b=LSCL1VQFe9DzhQ33GvyJt//i8gLebVo739elpmm+42OEPmYAV2c8ACf4jl/NSNnvj5plHBolYXcCcMOZ19KtoiBeEhHanN3hifRxqRTp1RYeaGjvdZbbd/oB1kjiehV1mNTdC8gRxFYZvBKbc29SadOlanxhOgwbrEeZ3KzOTDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578939; c=relaxed/simple;
	bh=noTUjFASFtVL4nlWHNtBmau/aPj35kRvuT1b3oVbdds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ticA+TNKMA4HOSB1dmjjnFbGBmBC+CjvpBVxYqRF+tBvcDSM0Q8ZHmsRMoAfhk/u1geYg9GkNoZF1LOqg9mxPIxMVf2QOLlbhVzP8GlXyI9OCvfcfH7++pJrN5HmgUOia2C1dPKjdwGIvrM468mjI9BpkQiRUZoY0kR//zR3G2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=AHQnVhmf; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78405c9a152so63648485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706578936; x=1707183736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjDB9WMZenyNFfJ6FneP+eMAzd2uIdtYL+Q7hbWifG0=;
        b=AHQnVhmfY/h2MSmZfnwrS6AYxkZk5EaAGvdfE38xjFK8XKBZlDE+qovV+t0qQzPL9s
         /vDe7m7wjXt709NpxVHlYnWfXQvvkfBct0TKRyRaDdYW7oMuFOgPUIdj+ZhlIoPW/7+h
         jMva+3EKv4QkIij+RymXA7615Y95jZiXt/ZW0UotZSLSa9uDWI7eRv+tgFzYwbiWmWEY
         kUwSvHqZW17L6kK43DwfUzdUmhb41hI4WCmqpp6RsZTqmB7eFoZ0grAnbm20sEszWqxA
         GsosJoiiBqZwQUe6e+L4t+XuQnJ0k0VS86IW0BTETz18/ZIKpr+vtn/nS0IIuU+JEz+B
         NtnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706578936; x=1707183736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjDB9WMZenyNFfJ6FneP+eMAzd2uIdtYL+Q7hbWifG0=;
        b=masuGMnK3+F55a5AVXBLMF7R/lMUx/J4WlJsAIxrtTD9YVdtIaumzRNCF/gV1ZJkM1
         Yp0Qrm6oQVfge9N6I0wxFc73JWCs1/K5SsHkIAAuByx9q24rXun02JNxAuvGXBGcAVDm
         v5kIdwMiXXyhkoddECAYu68Kn0Q9iBOgAxNZs55iRJW6iFqhjtR1ocB7uS3GgxHNTlyy
         CrXqnD755vG5dZ7XjyXDwv8tNFomGSHBqWH1KD40vafx/QBFvjekVodPIl5ftFyDw6GY
         /z1Ye/iCvMhHn/F+EZRaJClBY0czptKtDVRrj3w6wVHEGJepJUp3+oVxwLke4HPc/qDX
         nL7A==
X-Gm-Message-State: AOJu0Yw76JVSBQdjd+GKSRRKAZX68Ymecf0yfnOspzwZolabwuakmmyF
	CmCQ03Vb/wWRr+tZ7fjuCirvSaoVu3JgKC2cGryim2KjmFEOlHxBx9clZPoJgPg=
X-Google-Smtp-Source: AGHT+IHh4RV/gyq1SbWHKSfxOL3yFJXOcLXUJDddqpgCqc+YTjcqv3Unc9iTscwNHWga7GShhVQD0g==
X-Received: by 2002:ad4:5c4d:0:b0:686:ac5b:fe7d with SMTP id a13-20020ad45c4d000000b00686ac5bfe7dmr9546558qva.125.1706578936382;
        Mon, 29 Jan 2024 17:42:16 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id u12-20020a0cea4c000000b0068c43ac393asm2518373qvp.146.2024.01.29.17.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:42:16 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 02/20] mm: zswap: inline and remove zswap_entry_find_get()
Date: Mon, 29 Jan 2024 20:36:38 -0500
Message-ID: <20240130014208.565554-3-hannes@cmpxchg.org>
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

There is only one caller and the function is trivial. Inline it.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zswap.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 173f2e6657de..cf864aaa214d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -559,19 +559,6 @@ static void zswap_entry_put(struct zswap_entry *entry)
 	}
 }
 
-/* caller must hold the tree lock */
-static struct zswap_entry *zswap_entry_find_get(struct rb_root *root,
-				pgoff_t offset)
-{
-	struct zswap_entry *entry;
-
-	entry = zswap_rb_search(root, offset);
-	if (entry)
-		zswap_entry_get(entry);
-
-	return entry;
-}
-
 /*********************************
 * shrinker functions
 **********************************/
@@ -1708,13 +1695,13 @@ bool zswap_load(struct folio *folio)
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
-	/* find */
 	spin_lock(&tree->lock);
-	entry = zswap_entry_find_get(&tree->rbroot, offset);
+	entry = zswap_rb_search(&tree->rbroot, offset);
 	if (!entry) {
 		spin_unlock(&tree->lock);
 		return false;
 	}
+	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
 	if (entry->length)
-- 
2.43.0


