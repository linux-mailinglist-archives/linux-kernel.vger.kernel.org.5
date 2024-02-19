Return-Path: <linux-kernel+bounces-70752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3152859BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3D8B21F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E920B28;
	Mon, 19 Feb 2024 06:04:34 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB703FE1
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322674; cv=none; b=A9tL2uNCt37CMYdFrAextFqtGDGhkTzXPwYJb8awwuYKMWAWRCrvlDzQqxR288tXTxRYaLp/Q4cSc8kggQEmYrxaTE6Ad+6jL2Uf/B5W8WNq96ttHRFOD2+YDB6+3BIlzfW+avxd3RdJFRVEoxWn07F5rlTb672tVsslP7RW9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322674; c=relaxed/simple;
	bh=o7dB2cnQ4DdAIbh4UuP8+5q3qGaOJJ7booLY7nqK98M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=IF2pEtPazno12pGaN/vc6/89hZbKBV0HfzcIyi4N5wx4BjVATcx34zfLQwnwmkt6Qc4JQO8IRaoDskdT35cPCYkr5taAL+VVYP5xn2Z2LAIvRV7T+GduWrA+LP9qW+DtSXWdendGJus2qJm2yJ1jKdQWM0K7Da+J3yW6dhtJtMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d6dff70000001748-cc-65d2ef61944a
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: kernel_team@skhynix.com,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	namit@vmware.com,
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
Subject: [PATCH v8 4/8] x86/tlb, mm/rmap: Separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Mon, 19 Feb 2024 15:04:03 +0900
Message-Id: <20240219060407.25254-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240219060407.25254-1-byungchul@sk.com>
References: <20240219060407.25254-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnkW7i+0upBhdXGlrMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+PonXtsBXM4K87/msrUwHiJvYuRk0NCwETi7IsPrDD2u5sXmUBsNgF1iRs3
	fjKD2CICZhIHW/8A1XNxMAt8ZJJY/b2DBSQhLJAqseTLQcYuRg4OFgFVie6jASBhXgFTiWsL
	/jJCzJSXWL3hADNICSfQnN0HhUDCQkAlJ65OZgIZKSHQzi6xev9DNoh6SYmDK26wTGDkXcDI
	sIpRKDOvLDcxM8dEL6MyL7NCLzk/dxMjMBqW1f6J3sH46ULwIUYBDkYlHt4MkUupQqyJZcWV
	uYcYJTiYlUR43ZsupArxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgST
	ZeLglGpg7JtfuuGLz+brTy4ZvSh3zA1hVL986oZJ59GJe7/9MdatcWnZMNF2I6/nRf98lu9S
	zscKu07WCGs876q67+m/V6J8qfWZNV5577uecKyZoSJwNNns8NVH9zdmKu/lPhlT+uf2ieye
	lGtWaaHBndzCBzvOTZs1x32l1urVM40OR3/vUVvXoVBTqcRSnJFoqMVcVJwIACyHJuuCAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC5WfdrJv4/lKqwZnVGhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyjt65x1Ywh7Pi/K+pTA2Ml9i7GDk5JARMJN7dvMgEYrMJ
	qEvcuPGTGcQWETCTONj6B6iGi4NZ4COTxOrvHSwgCWGBVIklXw4ydjFycLAIqEp0Hw0ACfMK
	mEpcW/CXEWKmvMTqDQeYQUo4gebsPigEEhYCKjlxdTLTBEauBYwMqxhFMvPKchMzc0z1irMz
	KvMyK/SS83M3MQJDe1ntn4k7GL9cdj/EKMDBqMTDmyFyKVWINbGsuDL3EKMEB7OSCK9704VU
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxe4akJQgLpiSWp2ampBalFMFkmDk6pBsamzamHwoue
	9HD822LlxrN/Z4ZrsL3Y5t3pB2qLz2j/+F7t9vWkqnDkyweCp+Zc+u/TwOSztuTpkvsH7R/s
	qp94Y/+RJ0tLj31mOv0u5eQ9zbm9z/M5AkR5NV8W9s6Zvo5FIv7v9RxOyVV74zg4bDjsEhkm
	f4icdm7WlZfe4mdsb3q8Njv0ny9TiaU4I9FQi7moOBEAFcVlHGkCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to avoid
redundant TLB flushes by manipulating tlb batch's arch data after
arch_tlbbatch_flush(). However, we cannot because the data is getting
cleared inside arch_tlbbatch_flush(). So separated the part clearing the
tlb batch's arch data out of arch_tlbbatch_flush().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/mm/tlb.c | 2 --
 mm/rmap.c         | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 453ea95b667d..941f41df02f3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1268,8 +1268,6 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 		local_irq_enable();
 	}
 
-	cpumask_clear(&batch->cpumask);
-
 	put_flush_tlb_info();
 	put_cpu();
 }
diff --git a/mm/rmap.c b/mm/rmap.c
index da36f23ff7b0..b484d659d0c1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -643,6 +643,7 @@ void try_to_unmap_flush(void)
 		return;
 
 	arch_tlbbatch_flush(&tlb_ubc->arch);
+	arch_tlbbatch_clear(&tlb_ubc->arch);
 	tlb_ubc->flush_required = false;
 	tlb_ubc->writable = false;
 }
-- 
2.17.1


