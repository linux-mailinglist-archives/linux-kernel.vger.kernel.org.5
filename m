Return-Path: <linux-kernel+bounces-74375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DB85D32E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05651F21DBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEDC3D0AF;
	Wed, 21 Feb 2024 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vu0jg/5v"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0FA3C497
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708506914; cv=none; b=qBRQhdBamwMSHojvLkJqOJ0dAaT24FRwg8FEnWis/9y1TTa8ld2sfaCSwqtiNHrpFQ7RyUqWv24ayxs3hXngO5iZy7KjKw08Dfp+SLKE0uCOBAN+BiqgtcMNsK+93K+pRlsm0iN9dsOe6zZjxfjsmS7MIf8NwDPuoVnVAKQ6z1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708506914; c=relaxed/simple;
	bh=O+k60KXhe6ydsgPOue3vkwVXPDTuZawFf/KRF+wbA6k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXsk24ghjUmGKRTqLiGD0O+US+GY9KbxGz69z6npVQkC9+U3kfS5+y5yeE0MCYh47BySA4tyITiNYmJDNvNIdkGj3zZoHaur4XZhT3bahUgKfHBkgUIRknJLtDPI+B90u8PUzRo9USmbm/Bj+YNEBPlwZqlmTmsu+h1ANwBohM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vu0jg/5v; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708506910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eq+O6ms5ESQqGMHJ3Rpnbjo33AA6S0boN32ymHEEf2A=;
	b=Vu0jg/5v1jB3M52ap6QS1b5wvPa1UihMxp+36PSAQY/8xNuTc7sWiseB4gk1sIN6Ryxr/1
	ATRFx25L6E39AIJc5XWe8bBXRbh7FWXs2AyjYr1ICXI43XA23LELbW6hnIjH136Knf5GLT
	+Ha+7PYPiEUN2WrpQioMV36icYOem1M=
From: Yajun Deng <yajun.deng@linux.dev>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lstoakes@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] mm/mmap: return early if it can't merge in vma_merge()
Date: Wed, 21 Feb 2024 17:14:53 +0800
Message-Id: <20240221091453.1785076-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In most cases, the range of the area is valid. But in do_mprotect_pkey(),
the minimum value of end and vma->vm_end is passed to mprotect_fixup().
This will lead to the end is less than the end of prev.

In this case, the curr will be NULL, but the next will be equal to the
prev. So it will attempt to merge before, the vm_pgoff check will cause
this case to fail.

To avoid the process described above and reduce unnecessary operations.
Add a check to immediately return NULL if the end is less than the end of
prev.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v2: remove the case label.
v1: https://lore.kernel.org/all/20240218085028.3294332-1-yajun.deng@linux.dev/
---
 mm/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0fccd23f056e..7668854d2246 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -890,6 +890,9 @@ static struct vm_area_struct
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	if (prev && end < prev->vm_end)
+		return NULL;
+
 	/* Does the input range span an existing VMA? (cases 5 - 8) */
 	curr = find_vma_intersection(mm, prev ? prev->vm_end : 0, end);
 
-- 
2.25.1


