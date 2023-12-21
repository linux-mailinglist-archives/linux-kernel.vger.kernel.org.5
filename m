Return-Path: <linux-kernel+bounces-9023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B378681BF5A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CCF1F220F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E05B76DA0;
	Thu, 21 Dec 2023 20:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D1d+7ZX8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1D56EB77
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJpT5npX9+Mi4/2vKIXBMX5Zb3QcQCwOWJP1qz8pE0M=;
	b=D1d+7ZX8K/5XJRivQkOs08EDlsgfMyw9smPDLE+z0+/A5XJO1xiUqRuZmE0KKjzXfCVjOl
	B9Re2Z/G6jvedBYwergcLq/h7gQe6/xiCIpFFxCDZnzStwThLFWfJDZzzYMVmxbBjsmc1F
	kpPC6wGFc7aq4172XBiDkq6JKDgFx/0=
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
Subject: [PATCH mm 05/11] kasan: update kasan_poison documentation comment
Date: Thu, 21 Dec 2023 21:04:47 +0100
Message-Id: <992a302542059fc40d86ea560eac413ecb31b6a1.1703188911.git.andreyknvl@google.com>
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

The comment for kasan_poison says that the size argument gets aligned by
the function to KASAN_GRANULE_SIZE, which is wrong: the argument must be
already aligned when it is passed to the function.

Remove the invalid part of the comment.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 38af25b9c89c..1c34511090d7 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -513,8 +513,6 @@ static inline bool kasan_byte_accessible(const void *addr)
  * @size - range size, must be aligned to KASAN_GRANULE_SIZE
  * @value - value that's written to metadata for the range
  * @init - whether to initialize the memory range (only for hardware tag-based)
- *
- * The size gets aligned to KASAN_GRANULE_SIZE before marking the range.
  */
 void kasan_poison(const void *addr, size_t size, u8 value, bool init);
 
-- 
2.25.1


