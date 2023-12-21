Return-Path: <linux-kernel+bounces-9029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BED81BF68
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7133B1C2468B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8851376DAE;
	Thu, 21 Dec 2023 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UstQbyfW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8D745FC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLiJLNrkVOviOAnhN8fsOfgjq7KcvOUpOIZZlqspNbg=;
	b=UstQbyfWlazleiIZsd06p6GGsiGbF7Mk+SEC7V7KErkAUJltuZuqjmSUhenEEKoFJe2Ldb
	4tUiUzH6Uvv0RFu+cj+WbPn+gOqF8clgrSf7LbqyBVZlfKgonrRaUwbKKmHlfEcXGpHP7+
	mC3opDKQo6UxTJoeylICS86c/ZXC9RI=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 11/11] kasan: speed up match_all_mem_tag test for SW_TAGS
Date: Thu, 21 Dec 2023 21:04:53 +0100
Message-Id: <6fe51262defd80cdc1150c42404977aafd1b6167.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Checking all 256 possible tag values in the match_all_mem_tag KASAN test
is slow and produces 256 reports. Instead, just check the first 8 and the
last 8.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 798df4983858..9c3a1aaab21b 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -1785,6 +1785,14 @@ static void match_all_mem_tag(struct kunit *test)
 
 	/* For each possible tag value not matching the pointer tag. */
 	for (tag = KASAN_TAG_MIN; tag <= KASAN_TAG_KERNEL; tag++) {
+		/*
+		 * For Software Tag-Based KASAN, skip the majority of tag
+		 * values to avoid the test printing too many reports.
+		 */
+		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
+		    tag >= KASAN_TAG_MIN + 8 && tag <= KASAN_TAG_KERNEL - 8)
+			continue;
+
 		if (tag == get_tag(ptr))
 			continue;
 
-- 
2.25.1


