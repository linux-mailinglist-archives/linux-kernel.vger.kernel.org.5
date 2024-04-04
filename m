Return-Path: <linux-kernel+bounces-131456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2954898838
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D1AB2C816
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DD8061C;
	Thu,  4 Apr 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtcneFIy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A86BB44
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712234681; cv=none; b=MLRm9UPWSRpm5BZOUgso0V7arsO7LJCYaXZci3hHxLDJjFPIubdIIHZF+XSHFcpxS1XY0xn9OGOAocLFj3IkH+6aQvvdMh86rkYMxSgGAImP+5QzGeqJsHPUbu3RKqOZfOZq8ua+orZ5qWH/M/uaQSV2XDrQHjs67WsYQrGh1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712234681; c=relaxed/simple;
	bh=08CDsJO6NBDKJEPGS7ocACKAxk82FnZ00PtcXTPwoDw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G/UcD6F95qwDxAzISunadLgB4e9bTEtwnfZPblLVVQ8jbafPE1azsg+p8MoXnJd96uTzgUGYbqEHbIbo9dCV4A6lUzlTRrgR1RD0ozXlHSpwjF68nXgSQcfdmLyykEW9piO238aULcimGIp1ltLdjng1GdtpI/RMN+OTL14pi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtcneFIy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82830C433F1;
	Thu,  4 Apr 2024 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712234680;
	bh=08CDsJO6NBDKJEPGS7ocACKAxk82FnZ00PtcXTPwoDw=;
	h=From:To:Cc:Subject:Date:From;
	b=JtcneFIydec8F9GvoYdd+5vMKKldoWSpS7rCFzEIuw1MC4LLASzQitjbWKHr5whsJ
	 U8G2Z2N8mEzxCyiKOK7h53ZR49hJVCgayV1Tkr0ohh2ojERuMBpJsapSfYSOZJQGLo
	 oF0uTlOSt+Q1MmmNkEGKoD+CZBXF8bJ3eY0U/4hDPPo1vJJPWQ5ZYC1YL4Pc7Gciag
	 +jvle7MJSTgQtkOKDhJLtlHmqmVC+RA8g9dUNSJNT6Xb8e1JdkGf6uTJsuNWgeLhP6
	 sRsKrfVyKFPdVl6QHpm6hmySRRcanv+CHFYqWasEQoijkAAy/uqYIad3XXxqBdBFyc
	 CJBGeorgcLnBA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: hw_tags: include linux/vmalloc.h
Date: Thu,  4 Apr 2024 14:44:30 +0200
Message-Id: <20240404124435.3121534-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

This header is no longer included implicitly and instead needs to be
pulled in directly:

mm/kasan/hw_tags.c: In function 'unpoison_vmalloc_pages':
mm/kasan/hw_tags.c:280:16: error: implicit declaration of function 'find_vm_area'; did you mean 'find_vma_prev'? [-Werror=implicit-function-declaration]
  280 |         area = find_vm_area((void *)addr);
      |                ^~~~~~~~~~~~
      |                find_vma_prev
mm/kasan/hw_tags.c:280:14: error: assignment to 'struct vm_struct *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  280 |         area = find_vm_area((void *)addr);
      |              ^
mm/kasan/hw_tags.c:284:29: error: invalid use of undefined type 'struct vm_struct'
  284 |         for (i = 0; i < area->nr_pages; i++) {
      |                             ^~
mm/kasan/hw_tags.c:285:41: error: invalid use of undefined type 'struct vm_struct'
  285 |                 struct page *page = area->pages[i];
      |                                         ^~

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/kasan/hw_tags.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 2b994092a2d4..9958ebc15d38 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -16,6 +16,7 @@
 #include <linux/static_key.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/vmalloc.h>
 
 #include "kasan.h"
 
-- 
2.39.2


