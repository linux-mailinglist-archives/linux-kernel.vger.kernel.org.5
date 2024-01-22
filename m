Return-Path: <linux-kernel+bounces-32248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A9283590F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAE2B21741
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28580523B;
	Mon, 22 Jan 2024 01:01:07 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97A136A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885266; cv=none; b=TUTrLFYTsIWGpZl9IAO4Er5pPAUsKSVIy5dTOjUMGiD3wyqAimoXcPDZxuK5lOCZSZIXxIXS9YaJKmCz2rxlyQ3Go6e2holGuGWVfOJQK6sX3CCkXkDAzt2Netj8CrGs5AnXa/MFK067Q+ucD0xD34e6rdJGmAjfJddRBlSp/Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885266; c=relaxed/simple;
	bh=o7dB2cnQ4DdAIbh4UuP8+5q3qGaOJJ7booLY7nqK98M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ivfRvRj28WSDPcp/2ZlNOU8Vj23nFSXuUEcvSZg3s+unQZbfNJWYm/2rfwbDhTsoQPiOIfbrpgIo231uMN/H1kzCS8ywjN4+xGTfnCY1vN/Tr1lBjKpso2CD6+E/IIc8CY53buRLw5vzCKxMDoQi13CcdkU0VC5wTET+opu8onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7f-65adbe43fac1
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
Subject: [PATCH v7 4/8] x86/tlb, mm/rmap: Separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Mon, 22 Jan 2024 10:00:36 +0900
Message-Id: <20240122010040.74346-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
References: <20240122010040.74346-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnka7zvrWpBtsnaljMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK+PonXtsBXM4K87/msrUwHiJvYuRg0NCwERiws+yLkZOMPPa0+WMIDabgLrE
	jRs/mUFsEQEziYOtf4DKuTiYBT4ySaz+3sECkhAWSJU49eo7WAOLgKrE1nMPwBp4BUwlli1+
	yggxVF5i9YYDYHFOoEFTfnUxgdhCQDVzP+xkBBkqIdDMLvHz7lJWiAZJiYMrbrBMYORdwMiw
	ilEoM68sNzEzx0QvozIvs0IvOT93EyMwHpbV/onewfjpQvAhRgEORiUeXgf2talCrIllxZW5
	hxglOJiVRHj5VVelCvGmJFZWpRblxxeV5qQWH2KU5mBREuc1+laeIiSQnliSmp2aWpBaBJNl
	4uCUamDsXX6r+OLRd4dfr/vpuvrC4/vaq8wdzyqrcN7883LRhBntXtPMMtsbtsjd2vb2qYBQ
	BOuh3yZcD5z6blQF3XNKlRA65Sp2OOPWwe+GV/1z/R65/yysrbw0gaV57XrGxlTfZ+rz86S/
	Khur/TEIqL1bMTHm2IZz7Mdts+LY595N197J+T30hMdfJZbijERDLeai4kQAW6vnxIMCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwaaJshZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgyjt65x1Ywh7Pi/K+pTA2Ml9i7GDk5JARMJK49Xc4IYrMJ
	qEvcuPGTGcQWETCTONj6B6iGi4NZ4COTxOrvHSwgCWGBVIlTr76DNbAIqEpsPfcArIFXwFRi
	2eKnjBBD5SVWbzgAFucEGjTlVxcTiC0EVDP3w07GCYxcCxgZVjGKZOaV5SZm5pjqFWdnVOZl
	Vugl5+duYgSG97LaPxN3MH657H6IUYCDUYmH14F9baoQa2JZcWXuIUYJDmYlEV5+1VWpQrwp
	iZVVqUX58UWlOanFhxilOViUxHm9wlMThATSE0tSs1NTC1KLYLJMHJxSDYwlu0V7RCOeRefs
	dO2/Kfs9avae3+sdFe8I7H7rq3adq4XhBoO2X8KkCa5mT+eEHr19tSLW8eyJNRn9d+UnsWh5
	/fE16lfYLNfHI/ZHi/+30CqhO1c3crmc3FS6PsSS32y6+7UFl7jTX7hvvjNP5Vq8WdGl0pWS
	oq4PAu3VGs2m/DBev+ggV5USS3FGoqEWc1FxIgBG/k1hawIAAA==
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


