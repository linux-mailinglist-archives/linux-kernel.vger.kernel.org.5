Return-Path: <linux-kernel+bounces-5958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577781922A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AEE1F25C50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E11C3D0D7;
	Tue, 19 Dec 2023 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wLCvb7tP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716533D0BE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703020796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=edMpd9BGEGYDrNpVSYxtSqq0y4QzGBIBITzoL+fELBg=;
	b=wLCvb7tPTet1ewSEyphPkF5jb5wDKB5Vbjqh4le8R0Rn4fxhBnuoKo1fqvqY8SToVNk61x
	B1M4ri9j+O+GWc0OTT6fKsTtU9b1+XLXknmEYWgtYmEYdY8Rhj98SmDUO40SSsLlBIWU+r
	c2X4Jz1fohy0rf+kfz6yYZ33Z5V2yZ0=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 mm 0/4] lib/stackdepot, kasan: fixes for stack eviction series
Date: Tue, 19 Dec 2023 22:19:49 +0100
Message-Id: <cover.1703020707.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

A few fixes for the stack depot eviction series.

Changes v2->v3:
- Use raw spinlock instead of spinlock to avoid issues on RT kernels.

Changes v1->v2:
- Add Fixes tags.
- Use per-object spinlock for protecting aux stack handles instead of a
  global one.

Andrey Konovalov (4):
  lib/stackdepot: add printk_deferred_enter/exit guards
  kasan: handle concurrent kasan_record_aux_stack calls
  kasan: memset free track in qlink_free
  lib/stackdepot: fix comment in include/linux/stackdepot.h

 include/linux/stackdepot.h |  2 --
 lib/stackdepot.c           |  9 +++++++++
 mm/kasan/generic.c         | 32 +++++++++++++++++++++++++++++---
 mm/kasan/kasan.h           |  8 ++++++++
 mm/kasan/quarantine.c      |  2 +-
 5 files changed, 47 insertions(+), 6 deletions(-)

-- 
2.25.1


