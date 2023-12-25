Return-Path: <linux-kernel+bounces-11112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C42B81E166
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5709C282306
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4DB524DB;
	Mon, 25 Dec 2023 15:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W5ZZFxgU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7149524B5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703517571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gtILRKJ0trYPt8tyQFLeNeQ04NHz6IkEJP80Wwo1cS0=;
	b=W5ZZFxgU6MSYmdopEzAXGGE5gDJPmo+ZGGRKS5J86ZPztZXzJAEQqPRhg4fyqL04jDMR/z
	IHOXw6OLflgQdNazumo25AwO9vVwiBAngimhVCkwhQQIUYOZ+IjO6LfImbya93vttgit5h
	CqIx/6co65o646yEzapsHxuwiZOyubE=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mm] xtensa, kasan: define KASAN_SHADOW_END
Date: Mon, 25 Dec 2023 16:19:24 +0100
Message-Id: <20231225151924.5422-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Common KASAN code might rely on the definitions of the shadow mapping
start, end, and size. Define KASAN_SHADOW_END in addition to
KASAN_SHADOW_START and KASAN_SHADOW_SIZE.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312240755.MqsWuTno-lkp@intel.com/
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Andrew, please put this patch before
"kasan: improve kasan_non_canonical_hook".
---
 arch/xtensa/include/asm/kasan.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/xtensa/include/asm/kasan.h b/arch/xtensa/include/asm/kasan.h
index 216b6f32c375..8d2b4248466f 100644
--- a/arch/xtensa/include/asm/kasan.h
+++ b/arch/xtensa/include/asm/kasan.h
@@ -18,6 +18,8 @@
 #define KASAN_SHADOW_START (XCHAL_PAGE_TABLE_VADDR + XCHAL_PAGE_TABLE_SIZE)
 /* Size of the shadow map */
 #define KASAN_SHADOW_SIZE (-KASAN_START_VADDR >> KASAN_SHADOW_SCALE_SHIFT)
+/* End of the shadow map */
+#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
 /* Offset for mem to shadow address transformation */
 #define KASAN_SHADOW_OFFSET __XTENSA_UL_CONST(CONFIG_KASAN_SHADOW_OFFSET)
 
-- 
2.25.1


