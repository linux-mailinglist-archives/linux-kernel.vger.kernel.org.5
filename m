Return-Path: <linux-kernel+bounces-32244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6B383590B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463522823B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44348632;
	Mon, 22 Jan 2024 01:01:04 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49CC36C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885263; cv=none; b=AEBlefmUzey3nSH7E77YeN6jar0KRKqTRG1v+PO0JyNJQjVS5Re9On/q2gE6LwID8NehNoHUnVEHDxtUt+SPsLPpl7yBjlrtO4ftQMrQLi2eA2d0UsxmDnrDoXVrpJAjNOuuNPDXvjUq57ZoprDBsjfRIIK972XOPBcTNLt5mxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885263; c=relaxed/simple;
	bh=uWSWIWkD3opthclWyKeivuFFBZgLyDaadr0FCXFpy+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=csPI8cbfeMBmyUphKCrFRqrnGiG0Ipk5cjoQXTdwLC61o6ogjwwg1Hr69z71vHQx8nazEovWQ3C4Zwcly+vEYMXGS3UpZuXTK7v0TpdY/fExRy0vKY6X2Obn4rOAc3KfpnN6S6lwX92GyvwckPqYkERcomn+syPYQKzJYcD+0to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-73-65adbe43a43e
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
Subject: [PATCH v7 2/8] arm64: tlbflush: Add APIs manipulating tlb batch's arch data
Date: Mon, 22 Jan 2024 10:00:34 +0900
Message-Id: <20240122010040.74346-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240122010040.74346-1-byungchul@sk.com>
References: <20240122010040.74346-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPLMWRmVeSWpSXmKPExsXC9ZZnoa7zvrWpBot+KFjMWb+GzeLzhn9s
	Fi82tDNafF3/i9ni6ac+FovLu+awWdxb85/V4vyutawWO5buY7K4dGABk8X1XQ8ZLY73HmCy
	mH/vM5vF5k1TmS2OT5nKaPH7B1DHyVmTWRwEPb639rF47Jx1l91jwaZSj80rtDwW73nJ5LFp
	VSebx6ZPk9g93p07x+5xYsZvFo95JwM93u+7yuax9ZedR+PUa2wenzfJebyb/5YtgD+KyyYl
	NSezLLVI3y6BK2NP30P2gtlcFZvet7M1MO7l6GLk5JAQMJH4/3w2UxcjB5h9oSkYJMwmoC5x
	48ZPZhBbRMBM4mDrH/YuRi4OZoGPTBKrv3ewgNQLC4RIvPnoC1LDIqAqcW3zRlYQm1fAVKKp
	+wMLxHh5idUbDoDN4QSaM+VXFxOILQRUM/fDTkaQmRIC7ewSk8/PZ4RokJQ4uOIGywRG3gWM
	DKsYhTLzynITM3NM9DIq8zIr9JLzczcxAqNhWe2f6B2Mny4EH2IU4GBU4uF1YF+bKsSaWFZc
	mXuIUYKDWUmEl191VaoQb0piZVVqUX58UWlOavEhRmkOFiVxXqNv5SlCAumJJanZqakFqUUw
	WSYOTqkGRkP5TabCu9ym5C+P2iPAftegtfjbl8jiiJhDeZF60SxHv/c/DV7xW+BnZ0PtU/1o
	htLOvXyqUrl1d2w35GsINN601w7UmN8X5fyuXHLhB/t9S34XPqsoYf4+ccXZ5JMRL/TWv1/T
	/eDQ0xVib3/9dzTmUKjvDD+1/A9v44zeQNs5/6crVrRcUWIpzkg01GIuKk4EAN1FibeCAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsXC5WfdrOu8b22qwbvbIhZz1q9hs/i84R+b
	xYsN7YwWX9f/YrZ4+qmPxeLw3JOsFpd3zWGzuLfmP6vF+V1rWS12LN3HZHHpwAImi+u7HjJa
	HO89wGQx/95nNovNm6YyWxyfMpXR4vcPoI6TsyazOAh5fG/tY/HYOesuu8eCTaUem1doeSze
	85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHvNOBnq833eVzWPxiw9MHlt/2Xk0Tr3G5vF5k5zH
	u/lv2QIEorhsUlJzMstSi/TtErgy9vQ9ZC+YzVWx6X07WwPjXo4uRg4OCQETiQtNwV2MnBxs
	AuoSN278ZAaxRQTMJA62/mHvYuTiYBb4yCSx+nsHC0i9sECIxJuPviA1LAKqEtc2b2QFsXkF
	TCWauj+wgNgSAvISqzccAJvDCTRnyq8uJhBbCKhm7oedjBMYuRYwMqxiFMnMK8tNzMwx1SvO
	zqjMy6zQS87P3cQIDO1ltX8m7mD8ctn9EKMAB6MSD68D+9pUIdbEsuLK3EOMEhzMSiK8/Kqr
	UoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYnW+/+v/l
	VELxA0WXSX94RM0VWR/O01p7U5BHK3Nv956JuY017wXyv57qFsq7JaDwR2BWZYSrVOXN7WyT
	EpZ+VXqQv1hvjezfJQkMMUrC/Tv07/GLTz34fdMe//VH5TjcXybdbQlOF3UyrNERs5O8Zmt2
	82bz5IjK2Ya3VX/XbgiJ4r/XLJikxFKckWioxVxUnAgAreUf/GkCAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a preparation for migrc mechanism that requires to manipulate
tlb batch's arch data. Even though arm64 does nothing with it, arch
with CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH should provide the APIs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/include/asm/tlbflush.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bb2c2833a987..4f2094843e7a 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -328,6 +328,25 @@ static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	dsb(ish);
 }
 
+static inline void arch_tlbbatch_clear(struct arch_tlbflush_unmap_batch *batch)
+{
+	/* nothing to do */
+}
+
+static inline void arch_tlbbatch_fold(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+}
+
+static inline bool arch_tlbbatch_done(struct arch_tlbflush_unmap_batch *bdst,
+			       struct arch_tlbflush_unmap_batch *bsrc)
+{
+	/* nothing to do */
+
+	return false;
+}
+
 /*
  * This is meant to avoid soft lock-ups on large TLB flushing ranges and not
  * necessarily a performance improvement.
-- 
2.17.1


