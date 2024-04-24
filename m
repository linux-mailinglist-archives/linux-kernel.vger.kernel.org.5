Return-Path: <linux-kernel+bounces-156072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB98AFD8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89127281C4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7647C8BF8;
	Wed, 24 Apr 2024 01:03:33 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272A79CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 01:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920613; cv=none; b=pZhgkiHLjA/NfcVWPTlian6TLkIrwlfLRmRLRJri1Zq23J5nTltdkx2KTRsU4OkcDZDHYUHlM/73B/hOYkv192Zi85xCP6MjeIm4pB3WaPFaNjhZhkukY2GEqK8oUz4iZLnLHNp2QumBDbzX59NZdK4xYHRzDAT+ZK0BK3I1qTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920613; c=relaxed/simple;
	bh=lfMtsG0fjJ1aRZgDpYEgNCvgtXQ/a527BFAbUyw3jEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TbLmyNPzIENGNLL+2KBNYxVjOWqgfveKVO00gmjnsV3bWnf+Rt5+2xwPb07xC+zPh4f6NAfPspINRXlNy+OnHhdLqB/zu9wFFEMAI0VD7qKbmArZZO/UELIW/ocQQCt5hK/072FLySXmqEa7k6FyFgk7qR609xpTQKNoiIKrBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-14-66285a5c905c
From: Byungchul Park <byungchul@sk.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jbohac@suse.cz,
	dyoung@redhat.com
Cc: kernel_team@skhynix.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/e820: apply 'mem=' boot command while reserving memory using boot_params
Date: Wed, 24 Apr 2024 10:03:13 +0900
Message-Id: <20240424010313.25264-1-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240423102320.GA47818@system.software.com>
References: <20240423102320.GA47818@system.software.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsXC9ZZnkW5MlEaawZzjPBafN/xjs3ixoZ3R
	omFiA4vFtI3iFjcObmazuLxrDpvFpQMLmCw2b5rKbPFjw2NWB06P7619LB6bVnWyebw7d47d
	Y97JQI/3+66yeZxZcITd4/MmOY8TLV9YAziiuGxSUnMyy1KL9O0SuDI6bh1kLlggXLHg1Au2
	Bsbr/F2MHBwSAiYS017qdTFygpkHTjWzgthsAuoSN278ZO5i5OIQEVjMKHHi3TuwBLOAtcSd
	w10sILawQILEmt53TCA2i4CqxMsZU8FsXgFTiZtL/zNCDJWXWL3hADPILk4BS4lbV5VAwkIC
	FhLfZu1kB5kvITCHTeLOhZ1sEPWSEgdX3GCZwMi7gJFhFaNQZl5ZbmJmjoleRmVeZoVecn7u
	JkZg6C2r/RO9g/HTheBDjAIcjEo8vBUuGmlCrIllxZW5hxglOJiVRHh//VFJE+JNSaysSi3K
	jy8qzUktPsQozcGiJM5r9K08RUggPbEkNTs1tSC1CCbLxMEp1cAo2qj/ftvL3w+rcz/3lO+Q
	15vz9NH1nA2qCTd+KYvfyJa13rBKbNrBlVvEcpKLGzvtG3ZcYJrgWvqrru2pa52zz0nr/g8+
	8UKvxPYuXeMz68epRKFXy5Z7fZ/yh4vfcVHIbJuU7x9lPixK3rVHbtKCNTfmbvaqYNXcamR4
	T3DOxJ0e7JJTU14zKbEUZyQaajEXFScCAN8UJuY5AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42Lh8rNu1o2O0kgzuLTYxuLzhn9sFi82tDNa
	NExsYLGYtlHc4sbBzWwWh+eeZLW4vGsOm8WlAwuYLDZvmsps8WPDY1YHLo/vrX0sHptWdbJ5
	vDt3jt1j3slAj/f7rrJ5LH7xgcnjzIIj7B6fN8l5nGj5whrAGcVlk5Kak1mWWqRvl8CV0XHr
	IHPBAuGKBadesDUwXufvYuTkkBAwkThwqpkVxGYTUJe4ceMncxcjF4eIwGJGiRPv3oElmAWs
	Je4c7mIBsYUFEiTW9L5jArFZBFQlXs6YCmbzCphK3Fz6nxFiqLzE6g0HgAZxcHAKWErcuqoE
	EhYSsJD4Nmsn+wRGrgWMDKsYRTLzynITM3NM9YqzMyrzMiv0kvNzNzECQ2lZ7Z+JOxi/XHY/
	xCjAwajEw1vhopEmxJpYVlyZe4hRgoNZSYT31x+VNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
	XuGpCUIC6YklqdmpqQWpRTBZJg5OqQZGNjuemazi09XluU43tX/d+e/SxIuKKj79cbWfp/N3
	xGomH9F6+XLlIa78AHWTyD81ZnPr6x82fdi3pCE9S7xXQoY3/Y2LrZL+LNvOR5sPOdT+nWr0
	szPYa574p01Pv1RdqrGSPHT9+7+5t9YkrYiIm1JTbZ7I+VFLl/1Lfl3fmTi579kRUrZKLMUZ
	iYZazEXFiQAdlHW6IQIAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

I might miss something.  Please lemme know if I go wrong.  Thanks.

	Byungchul

Changes from v1
	1. before - handle boot_mem_limit assuming the default is U64_MAX.
	   after  - handle boot_mem_limit assuming the default is 0.

--->8---
From e8bf247d6024b35af5300914dcff9135df9c1d66 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul@sk.com>
Date: Wed, 24 Apr 2024 09:55:25 +0900
Subject: [PATCH v2] x86/e820: apply 'mem=' boot command while reserving memory using boot_params

When a user specifies 'mem=' boot command, it's expected to limit the
maximum address of usable memory for the kernel no matter what the
memory map source is.  However, 'mem=' boot command doesn't work since
it doesn't respect it when reserving memory using boot_params.

Applied the restriction when reserving memory using boot_params.  While
at it, renamed mem_size to a more specific name, boot_mem_limit.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/x86/kernel/e820.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 6f1b379e3b38..e3f716128caf 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -880,11 +880,11 @@ static void __init early_panic(char *msg)
 
 static int userdef __initdata;
 
+static u64 boot_mem_limit;
+
 /* The "mem=nopentium" boot option disables 4MB page tables on 32-bit kernels: */
 static int __init parse_memopt(char *p)
 {
-	u64 mem_size;
-
 	if (!p)
 		return -EINVAL;
 
@@ -899,16 +899,16 @@ static int __init parse_memopt(char *p)
 	}
 
 	userdef = 1;
-	mem_size = memparse(p, &p);
+	boot_mem_limit = memparse(p, &p);
 
 	/* Don't remove all memory when getting "mem={invalid}" parameter: */
-	if (mem_size == 0)
+	if (boot_mem_limit == 0)
 		return -EINVAL;
 
-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
+	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit, E820_TYPE_RAM, 1);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-	max_mem_size = mem_size;
+	max_mem_size = boot_mem_limit;
 #endif
 
 	return 0;
@@ -1036,6 +1036,9 @@ void __init e820__reserve_setup_data(void)
 		early_memunmap(data, len);
 	}
 
+	if (boot_mem_limit)
+		e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit,
+				E820_TYPE_RESERVED_KERN, 1);
 	e820__update_table(e820_table);
 
 	pr_info("extended physical RAM map:\n");
-- 
2.17.1


