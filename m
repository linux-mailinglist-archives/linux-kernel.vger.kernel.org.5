Return-Path: <linux-kernel+bounces-9018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D581BF55
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BCC1C220B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CE1745D3;
	Thu, 21 Dec 2023 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="skZG0MAM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995777318F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sNjSVQSFVUV8ISkHCvyHjupyoa/1urB/LVlJZWSj/S8=;
	b=skZG0MAMyl6rsB9CCsmBPP7NznukYYsecWppGCwYHrmvvYnQyMvlOF6jBnMft0q/3vtPVN
	/GAZWrPBGeieQcJ4RhLnGqH2ikIUM3Ej5bau/5zQL2rkFZcQPeWhNOJhaGTDjqnJOhtaZ0
	ONn/64VbboXzqOkOPots7VsHnkIicy4=
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
Subject: [PATCH mm 00/11] kasan: assorted clean-ups
Date: Thu, 21 Dec 2023 21:04:42 +0100
Message-Id: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Code clean-ups, nothing worthy of being backported to stable.

This series goes on top of the "kasan: save mempool stack traces" one.

Andrey Konovalov (11):
  kasan/arm64: improve comments for KASAN_SHADOW_START/END
  mm, kasan: use KASAN_TAG_KERNEL instead of 0xff
  kasan: improve kasan_non_canonical_hook
  kasan: clean up kasan_requires_meta
  kasan: update kasan_poison documentation comment
  kasan: clean up is_kfence_address checks
  kasan: respect CONFIG_KASAN_VMALLOC for kasan_flag_vmalloc
  kasan: check kasan_vmalloc_enabled in vmalloc tests
  kasan: export kasan_poison as GPL
  kasan: remove SLUB checks for page_alloc fallbacks in tests
  kasan: speed up match_all_mem_tag test for SW_TAGS

 arch/arm64/include/asm/kasan.h  | 22 +--------------
 arch/arm64/include/asm/memory.h | 38 +++++++++++++++++++++-----
 arch/arm64/mm/kasan_init.c      |  5 ++++
 include/linux/kasan.h           |  1 +
 include/linux/mm.h              |  4 +--
 mm/kasan/common.c               | 26 +++++++++++-------
 mm/kasan/hw_tags.c              |  8 ++++++
 mm/kasan/kasan.h                | 48 ++++++++++++++++-----------------
 mm/kasan/kasan_test.c           | 45 ++++++++++++++-----------------
 mm/kasan/report.c               | 34 +++++++++++++----------
 mm/kasan/shadow.c               | 14 +---------
 mm/page_alloc.c                 |  2 +-
 12 files changed, 131 insertions(+), 116 deletions(-)

-- 
2.25.1


