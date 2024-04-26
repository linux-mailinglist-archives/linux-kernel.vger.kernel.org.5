Return-Path: <linux-kernel+bounces-160182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5048B3A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F5F286628
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3611494A3;
	Fri, 26 Apr 2024 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="avEdWTM/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95235149006
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142720; cv=none; b=ihHF9Z0bxyy7W1dnxzx2npR/hiAGcMO3n+l767J6EJkxXUNuDTlph0/umqyVEzGZ3wL7dCvZZHeQrSqTEfpSENDHkwYnmtAfh+QEWqkYJzF8a30tN+U4hH2TTJNxK//3FeAe9LHttcJvuwzl52ctQrycwJrFxviWT7vHtVHcsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142720; c=relaxed/simple;
	bh=2A0I/wQ02ZQClsJJvC2xC++2okdVlxUH4BTAOBbX1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLchBwNPU6Bf2DUZiZTGxE8CWEWkJnUbGlXDRem7e23rdTsvZd+a4yGuZ9OaTi3znPeF993dFL1hgpEYnUPvcUA029AG9DviHAAe4gHXtpzhqMSrfpOq/SRXNTmCpK8E6EGO0i7w5uexBVWre9NxpKJesxI+jZyMTY9EqEUg5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=avEdWTM/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=xiasNW2bjz4XwywyYv4zK4GYnJbH5N9m8U5+b7/FG0g=; b=avEdWTM/yAlNRrylBNlMhcItT8
	yT3lf5sbN2RA11wRK57vjoI6+cQ4lOshf22Lj4uL7AZ/b1ZfApFJfPwIoV+o5X89LxrtQKmovdkWp
	d6GdOd+oLFrtddsrmgjkb3tHhclq/QbDFb2K9UAk9I0CHB+msjtBqcV+NNzBx3RflOlaD9xy8Dxhk
	es3hCflPEq9bjg0W2B3ZvZt2nuIbUQ94Vbc6N/36fbLOt32SrhktKVGwgIfqJcg4UWo/Y/MU/xiW+
	LQeO3PqBRGk0YU47AeSqIQtKcSKBURhocodIXVgGTbeLOQplgj5BFtuB0HLDEw1g+kXORauvDvxQ1
	4dMG+cJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0Mp2-00000005Pl6-1hWT;
	Fri, 26 Apr 2024 14:45:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>,
	Peter Xu <peterx@redhat.com>,
	Jann Horn <jannh@google.com>
Subject: [PATCH 4/4] mm: Optimise vmf_anon_prepare() for VMAs without an anon_vma
Date: Fri, 26 Apr 2024 15:45:03 +0100
Message-ID: <20240426144506.1290619-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426144506.1290619-1-willy@infradead.org>
References: <20240426144506.1290619-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the mmap_lock can be taken for read, we can call __anon_vma_prepare()
while holding it, saving ourselves a trip back through the fault handler.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/memory.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7dc112d3a7e4..b5453b86ec4b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3232,16 +3232,21 @@ static inline vm_fault_t vmf_can_call_fault(const struct vm_fault *vmf)
 vm_fault_t vmf_anon_prepare(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	vm_fault_t ret = 0;
 
 	if (likely(vma->anon_vma))
 		return 0;
 	if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-		vma_end_read(vma);
-		return VM_FAULT_RETRY;
+		if (!mmap_read_trylock(vma->vm_mm)) {
+			vma_end_read(vma);
+			return VM_FAULT_RETRY;
+		}
 	}
 	if (__anon_vma_prepare(vma))
-		return VM_FAULT_OOM;
-	return 0;
+		ret = VM_FAULT_OOM;
+	if (vmf->flags & FAULT_FLAG_VMA_LOCK)
+		mmap_read_unlock(vma->vm_mm);
+	return ret;
 }
 
 /*
-- 
2.43.0


