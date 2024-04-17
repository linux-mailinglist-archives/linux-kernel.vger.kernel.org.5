Return-Path: <linux-kernel+bounces-148057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DA8A7D23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F1E283167
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD597BAEE;
	Wed, 17 Apr 2024 07:34:25 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14576F060
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339264; cv=none; b=PPzfIiNWILhwbOADRDREjXoi0SBzK5Hu1Wt+hGNeMjisNeNkDZiZ7WaEAqgv5HToNaDNKWCIEFes1I/HQf/nPfheK4kxRW0lUEr5Ek0I/fWJizEdYTvbsiuFQlWTfIwgQ2qexJ9StygKksX1WAItDBy1LFhOnr6zoKjhlSGszm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339264; c=relaxed/simple;
	bh=GKKQ0ELyqnwZB6LDFYITg0PJaCDG9V1PU31qvzMDlro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jk2dxBk4+Dimzy6vgPiXdLZQMjN4FbF1rP8gOMcxMHq4qF4MZ1yJNRz1NU/+PjFBpwctWlxfU5Ghv00mah8eOROUAXLVQ/kYokno6vqEcqKz7ZYsKjHyVTy42QT7rTlHXqDgpNGKsw8bTLZqR+c+4c5099ZW/CHiZDF3dAm5NCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-a2-661f77e25f54
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	vernhao@tencent.com,
	mgorman@techsingularity.net,
	hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	peterz@infradead.org,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	rjgolo@gmail.com
Subject: [PATCH v9 4/8] x86/tlb, mm/rmap: separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Wed, 17 Apr 2024 16:18:43 +0900
Message-Id: <20240417071847.29584-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240417071847.29584-1-byungchul@sk.com>
References: <20240417071847.29584-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXC9ZZnke6jcvk0g9afshZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLyrjlsFvfW/Ge1OL9rLavFjqX7mCwuHVjAZHG89wCTxfx7n9ks
	Nm+aymxxfMpURovfP4CKT86azOIg4PG9tY/FY+esu+weCzaVemxeoeWxeM9LJo9NqzrZPDZ9
	msTu8e7cOXaPEzN+s3jMOxno8X7fVTaPrb/sPBqnXmPz+LxJLoAvissmJTUnsyy1SN8ugStj
	9+ZVbAXHOSp+HnvM0sDYyt7FyMkhIWAi0f9lBSOM/WbGFBYQm01AXeLGjZ/MILaIgJnEwdY/
	YPXMAneZJA70s4HYwgKpEgsO7AWzWQRUJSbf/wA2h1fAVGJz+zFWiJnyEqs3HACbwwk0Z3Pz
	GrB6IaCa7yc+AtlcQDXv2SROL/7CBNEgKXFwxQ2WCYy8CxgZVjEKZeaV5SZm5pjoZVTmZVbo
	JefnbmIEhv6y2j/ROxg/XQg+xCjAwajEw2sQJZcmxJpYVlyZe4hRgoNZSYS3RVg2TYg3JbGy
	KrUoP76oNCe1+BCjNAeLkjiv0bfyFCGB9MSS1OzU1ILUIpgsEwenVAOjlfr/49s3v/36ubL7
	39fsPw9u9Cx7LPDjwGqfjy4svKrf7eN+qyS5ND+ck/f05wsvrdm/zu18N2fJsbiMvxOEznQe
	ebxm0sTvQtlfT6yw2Fojyv5rsqmKi2T1Z82qWWU6NzsjPu991t02P8OoO55VLeilr2/u/Nsz
	Tr4ym7quJijnmOz7ljez05VYijMSDbWYi4oTAeUAXwt5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsXC5WfdrPuoXD7N4NAxYYs569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfHeA0wW
	8+99ZrPYvGkqs8XxKVMZLX7/ACo+OWsyi4Ogx/fWPhaPnbPusnss2FTqsXmFlsfiPS+ZPDat
	6mTz2PRpErvHu3Pn2D1OzPjN4jHvZKDH+31X2TwWv/jA5LH1l51H49RrbB6fN8kF8Edx2aSk
	5mSWpRbp2yVwZezevIqt4DhHxc9jj1kaGFvZuxg5OSQETCTezJjCAmKzCahL3LjxkxnEFhEw
	kzjY+geshlngLpPEgX42EFtYIFViwYG9YDaLgKrE5PsfGEFsXgFTic3tx1ghZspLrN5wAGwO
	J9Cczc1rwOqFgGq+n/jINoGRawEjwypGkcy8stzEzBxTveLsjMq8zAq95PzcTYzAQF5W+2fi
	DsYvl90PMQpwMCrx8BpEyaUJsSaWFVfmHmKU4GBWEuFtEZZNE+JNSaysSi3Kjy8qzUktPsQo
	zcGiJM7rFZ6aICSQnliSmp2aWpBaBJNl4uCUamCc/Fhtrcm3f1vZVc2/T4xN/ttwco908O3X
	s/MKlm6oWFa/8kS056Tj8ywMnaMWKXediak8u3exUapJaar24dWf32VsdZbxtOH/OkGhLfGG
	ycEtXxsCnk15tkLc7Xhm+vdt352+b3iy+ojohJj4n8XZ2TumvXqQdzvrd+GsP5Utlb7SXwME
	vCtjlViKMxINtZiLihMBeTy0bGACAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to avoid
redundant tlb flushes by manipulating tlb batch's arch data.  To achieve
that, it's needed to separate the part clearing the tlb batch's arch
data out of arch_tlbbatch_flush().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/mm/tlb.c | 2 --
 mm/rmap.c         | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..24bce69222cd 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1265,8 +1265,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index 2542bfe1a947..d8671d0dc416 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -673,6 +673,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


