Return-Path: <linux-kernel+bounces-29306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85292830C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1267DB235A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E922F02;
	Wed, 17 Jan 2024 18:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohX9ddmt"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748DE22EF6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705515119; cv=none; b=Vca8RJnnLldulbnvI+aTqPC/t5ssewBt+zlaLRe3XriFyiaZOj7O9FfhmYHxAtfaa2Xf98OwYLsuqcpt+TCvkCzQ8pukvWpBD/S6JGW22KpxwkMGThZ0m33cFe4LiC0vtHTbgDEWGh8xCSiWBDtfHWC+U5hfgJ3J1Nq1CwRJP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705515119; c=relaxed/simple;
	bh=VpKMkG/oPLhTsmEDt5kJORcf0cqo0mhP/+GF1Y87pr4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=EuZdmDQRy6snUPM9qllUtZC5w89J6XSBrcVtf4AFkG/TKs6FPNDigssx2iwONSsaQL652/N+t4XVC2o1tTiJoYiviq1d0b0YWIKFNwnGktvQgVHacLflmJS9kJYSktOgSV9UdYOjyR/sRKyuk074onNnE3f8yAc3/S+H7tEFkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohX9ddmt; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28b77ca8807so6907682a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705515118; x=1706119918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=78wGbyaR1N/RpeDHrml7Zj+rHmeYYvmV/w0ACPzkZ2Q=;
        b=ohX9ddmtZW3Y3Ie40+gMjO8zAmzNWAs0SCK9oLlqwHv4XO5oR+wDVWYtH4Wa+CD6J6
         tIBXt5+pa7oHS/QP64hbeuH/bDBGC/4UjGGaroU6eAbV9KNP/LzmVZGmmFDW9W/F9SKS
         OIYz4hTAVHKtzv+iSYrOkW21BOw0EgDvfVGgIJu198YH6k6I9TFKw3mP/Zl+Dz/Q57cJ
         UIauuEPhCz8HybCpPPADjTa4Wd2dRe9JDjHpdFn6uAl5QzVZZawwZzlKgDX/Ca5P/GR5
         InBUCmh6LzRKfNA/6pfheSDzUIS3d7YP6L7UFVCxhk/q9eqwbPIasFtavn2OPds/4J3J
         z3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705515118; x=1706119918;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78wGbyaR1N/RpeDHrml7Zj+rHmeYYvmV/w0ACPzkZ2Q=;
        b=KuyxKSnQ/LIRCmBwn7Ix8lFxP0z1jxN2wOARhtSj2h/55Bn2/P4v2mmZMDBD2N7HtJ
         KSLdouo1qp6ouv5PzBoWQzOLPzIJ/NCBCeFmAcGsaw1zQR3gGjEuGXpWE5tHW3cSnCTj
         qzHIX1s4d3MIPPc0n2x3UjAAN3CaNJBT8Fa3VFdVMbOYxgIcEHtK949m5y19M4MctAX0
         4Pc/iUm18Q3UEWVFyxdDdsS+zHMe97Q4V3jzfezAuqnIuuLP/GCvD6dzEp1nezIA6G08
         k1GTslOZf5tZTajRtp24iNC+zf9sRuIrmXXlCnM8z3ow83i6fPrFKi+VorUDDIDZcnTG
         EwdA==
X-Gm-Message-State: AOJu0Yww+osdwpXC9UvacR+46IG5eDqt4YVgOJ+E5cLqlPSV8P3kQH8g
	0ofUoYCzMvWye88fOvpK7BWU9O/u21a+qwCus7A0gQ==
X-Google-Smtp-Source: AGHT+IEqlpk5VBwIaxFJ3ed3SctyHMNGEmAma0Nj0WOvArfTlAIrR/Z8ubBEgvCHIcFZ3dr6Jg5yS8q7Aksd9jY=
X-Received: from tj-virt.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5683])
 (user=tjmercier job=sendgmr) by 2002:a17:90b:51c7:b0:28d:6729:c29a with SMTP
 id sf7-20020a17090b51c700b0028d6729c29amr615328pjb.2.1705515117716; Wed, 17
 Jan 2024 10:11:57 -0800 (PST)
Date: Wed, 17 Jan 2024 18:11:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Message-ID: <20240117181141.286383-1-tjmercier@google.com>
Subject: [PATCH] dma-buf: heaps: Don't track CMA dma-buf pages under RssFile
From: "T.J. Mercier" <tjmercier@google.com>
To: tjmercier@google.com, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Sandeep Patil <sspatil@android.com>, 
	Laura Abbott <labbott@redhat.com>
Cc: android-mm@google.com, minchan@google.com, daniel@ffwll.ch, 
	John Stultz <john.stultz@linaro.org>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

DMA buffers allocated from the CMA dma-buf heap get counted under
RssFile for processes that map them and trigger page faults. In
addition to the incorrect accounting reported to userspace, reclaim
behavior was influenced by the MM_FILEPAGES counter until linux 6.8, but
this memory is not reclaimable. [1] Change the CMA dma-buf heap to set
VM_PFNMAP on the VMA so MM does not poke at the memory managed by this
dma-buf heap, and use vmf_insert_pfn to correct the RSS accounting.

The system dma-buf heap does not suffer from this issue since
remap_pfn_range is used during the mmap of the buffer, which also sets
VM_PFNMAP on the VMA.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/mm/vmscan.c?id=fb46e22a9e3863e08aef8815df9f17d0f4b9aede

Fixes: b61614ec318a ("dma-buf: heaps: Add CMA heap to dmabuf heaps")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/heaps/cma_heap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
index ee899f8e6721..4a63567e93ba 100644
--- a/drivers/dma-buf/heaps/cma_heap.c
+++ b/drivers/dma-buf/heaps/cma_heap.c
@@ -168,10 +168,7 @@ static vm_fault_t cma_heap_vm_fault(struct vm_fault *vmf)
 	if (vmf->pgoff > buffer->pagecount)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = buffer->pages[vmf->pgoff];
-	get_page(vmf->page);
-
-	return 0;
+	return vmf_insert_pfn(vma, vmf->address, page_to_pfn(buffer->pages[vmf->pgoff]));
 }
 
 static const struct vm_operations_struct dma_heap_vm_ops = {
@@ -185,6 +182,8 @@ static int cma_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+
 	vma->vm_ops = &dma_heap_vm_ops;
 	vma->vm_private_data = buffer;
 
-- 
2.43.0.381.gb435a96ce8-goog


