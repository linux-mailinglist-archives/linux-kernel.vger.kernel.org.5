Return-Path: <linux-kernel+bounces-6053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5018193A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366C7285D97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5053DB82;
	Tue, 19 Dec 2023 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kt1rNfuv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC21F3D0AB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVsX1wYh/u3bsgXc0v6541Y+g0kgoewEBIuD2sVrVOE=;
	b=Kt1rNfuvx7+wT5H8UNOgwHCeTbOEvaDygKRpZZi3u1FYmus+bD/11ubTVW79B+oIdiaNwz
	JlwOYJnlQA+xJy+dqmZh3LmC25rgn5CNTohHAkyMco9Blc+/P3IIuddLLDTvM6CJy8A9+O
	KeuWbai25yfJ/zAiqqyvZxcC5VTNrDs=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 13/21] mempool: skip slub_debug poisoning when KASAN is enabled
Date: Tue, 19 Dec 2023 23:28:57 +0100
Message-Id: <98a4b1617e8ceeb266ef9a46f5e8c7f67a563ad2.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
References: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

With the changes in the following patch, KASAN starts saving its metadata
within freed mempool elements.

Thus, skip slub_debug poisoning and checking of mempool elements when
KASAN is enabled. Corruptions of freed mempool elements will be detected
by KASAN anyway.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes RFC->v1:
- This is a new patch.
---
 mm/mempool.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mempool.c b/mm/mempool.c
index 7e1c729f292b..1fd39478c85e 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -56,6 +56,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
 
 static void check_element(mempool_t *pool, void *element)
 {
+	/* Skip checking: KASAN might save its metadata in the element. */
+	if (kasan_enabled())
+		return;
+
 	/* Mempools backed by slab allocator */
 	if (pool->free == mempool_kfree) {
 		__check_element(pool, element, (size_t)pool->pool_data);
@@ -81,6 +85,10 @@ static void __poison_element(void *element, size_t size)
 
 static void poison_element(mempool_t *pool, void *element)
 {
+	/* Skip poisoning: KASAN might save its metadata in the element. */
+	if (kasan_enabled())
+		return;
+
 	/* Mempools backed by slab allocator */
 	if (pool->alloc == mempool_kmalloc) {
 		__poison_element(element, (size_t)pool->pool_data);
-- 
2.25.1


