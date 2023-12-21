Return-Path: <linux-kernel+bounces-8901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1281BDEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FF51F215A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF43634FC;
	Thu, 21 Dec 2023 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="de36pMIh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D32627E2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703181999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i0GLSbu+FVh1lkI5GuUWSCHjI1Tbl3xktQLpxtmlTZ0=;
	b=de36pMIhG8dcEtDj1hZGl0phPdkCusN9KYUxUjLrW6Qo7MOPk83R1yaVV2uQEqBzQ9Yi+I
	YrcwyKMDU4VHAw2fGeiuG8vGwQh9gvchz92Kt9bLVQkBDV56hk2bCBHS9o+9voTcf8YRmx
	25kNS+cuLp7JEOirxbMf5QL/HnObxa0=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] kasan: fix for "kasan: rename and document kasan_(un)poison_object_data"
Date: Thu, 21 Dec 2023 19:06:37 +0100
Message-Id: <20231221180637.105098-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Update references to renamed functions in comments.

Fixes: ac6b240e1ede ("kasan: rename and document kasan_(un)poison_object_data")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/shadow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index d687f09a7ae3..0154d200be40 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -130,7 +130,7 @@ void kasan_poison(const void *addr, size_t size, u8 value, bool init)
 
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
-	 * some of the callers (e.g. kasan_poison_object_data) pass tagged
+	 * some of the callers (e.g. kasan_poison_new_object) pass tagged
 	 * addresses to this function.
 	 */
 	addr = kasan_reset_tag(addr);
@@ -170,7 +170,7 @@ void kasan_unpoison(const void *addr, size_t size, bool init)
 
 	/*
 	 * Perform shadow offset calculation based on untagged address, as
-	 * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
+	 * some of the callers (e.g. kasan_unpoison_new_object) pass tagged
 	 * addresses to this function.
 	 */
 	addr = kasan_reset_tag(addr);
-- 
2.25.1


