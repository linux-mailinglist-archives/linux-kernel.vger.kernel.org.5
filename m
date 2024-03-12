Return-Path: <linux-kernel+bounces-99710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA21878C11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F12B21C72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463DAEC3;
	Tue, 12 Mar 2024 00:59:37 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FE0653
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710205176; cv=none; b=XaQLHhZz8WFTpKXE1k/whMCQ/vMmv9IJ0MJPJtNfQx73Ixgcyd0mEv+oblfIKipLzGfGqatySIieZnDZ8Xj5yTeIm44iyRbXBFbDaXML/8WMAlxr7vYBjxQaLbSsg1MXevwB8Fc0WHwtgZA20R5ZCrVOBth3Iu6yaaqrnV2SizY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710205176; c=relaxed/simple;
	bh=ehQzi0VDIe1b2WTUB/ybZzZ2wSe0Tj1feDXSIdWfEbo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TGzhJlQGd1LkalrTSWSOXQLsYnj2zZ8At9zUytzz0mya6Xc4xvXyrJivt+2kLZpsdUUx7He0tbq2rpb5bQbx25N6Pl2zsptcLeleV5ZDQCViMaEDSk6n7eXYCXizXC/SPTBQH8xsMZkJo/NTroWFZXovdCqe/hMOsa05ypIzmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.65])
	by mail-app2 (Coremail) with SMTP id by_KCgBHjI7cqO9l9WJWAA--.23030S2;
	Tue, 12 Mar 2024 08:59:20 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	jglisse@redhat.com,
	akpm@linux-foundation.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] lib/test_hmm.c: handle src_pfns and dst_pfns allocation failure
Date: Tue, 12 Mar 2024 08:59:05 +0800
Message-Id: <20240312005905.9939-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgBHjI7cqO9l9WJWAA--.23030S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xJw1fur17WFWkCw1kGrg_yoW8AF4rpF
	W8Ga4YyryUA34j9FyUXF10kr42kan8Aa1akrsFv3s3uFs8JFyxJ3yfAryrWF10v397AFs2
	vFW5ta4DXF1UJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUU
	U==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMSAWXvDBcFrQAGss
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kcalloc() in dmirror_device_evict_chunk() will return null if
the physical memory has run out. As a result, if src_pfns or dst_pfns
is dereferenced, the null pointer dereference bug will happen.

Moreover, the device is going away. If the kcalloc() fails, the pages
mapping a chunk could not be evicted. So add a __GFP_NOFAIL flag in
kcalloc().

Finally, as there is no need to have physically contiguous memory,
Switch kcalloc() to kvcalloc() in order to avoid failing allocations.

Fixes: b2ef9f5a5cb3 ("mm/hmm/test: add selftest driver for HMM")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 lib/test_hmm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 717dcb83012..b823ba7cb6a 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1226,8 +1226,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	unsigned long *src_pfns;
 	unsigned long *dst_pfns;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, start_pfn, npages);
 	for (i = 0; i < npages; i++) {
@@ -1250,8 +1250,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	}
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 }
 
 /* Removes free pages from the free list so they can't be re-allocated */
-- 
2.17.1


