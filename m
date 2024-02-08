Return-Path: <linux-kernel+bounces-57517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF3184DA0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7F0288166
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A6669D13;
	Thu,  8 Feb 2024 06:26:29 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CB367E78
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707373589; cv=none; b=DytJG99ZsCXCwph6eafBuYKNHJVIBpQRoJhtq2556wCVymYics5yAo0K3LNPJOF9VCHWQDtU8iECx6OnuMkkqIR1Hc4KWp1y9dBeP0rgNDEwMBc7fJnyzxNHAYm1n47y8UhuM284m2B7RpNh8UHRU9n+FUzbm2BYjM2DnCtV5jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707373589; c=relaxed/simple;
	bh=o7dB2cnQ4DdAIbh4UuP8+5q3qGaOJJ7booLY7nqK98M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CME3MiiG7BIsUyFB6tqzAYUNBcEP3KDBq61nkpk0KJSibbuejffSi8+3BafiWmbNXm441YC2pGa3XpmhCr7cTUqmLG1VYdQzQA9HK/es8mP914/paVMEwly7Yl7kdsNrIYdZ6+lUY26Nd35BOSoOlazduhZpn5tZx7HrTJLWgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-81-65c4740bb40b
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
Subject: [RESEND PATCH v7 4/8] x86/tlb, mm/rmap: Separate arch_tlbbatch_clear() out of arch_tlbbatch_flush()
Date: Thu,  8 Feb 2024 15:26:04 +0900
Message-Id: <20240208062608.44351-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208062608.44351-1-byungchul@sk.com>
References: <20240208062608.44351-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsXC9ZZnkS53yZFUg6sTRCzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XlXXPYLO6t+c9qcX7XWlaLHUv3MVlcOrCAyeL6roeMFsd7DzBZ
	zL/3mc1i86apzBbHp0xltPj9A6jj5KzJLA6CHt9b+1g8ds66y+6xYFOpx+YVWh6L97xk8ti0
	qpPNY9OnSewe786dY/c4MeM3i8e8k4Ee7/ddZfPY+svOo3HqNTaPz5vkPN7Nf8sWwB/FZZOS
	mpNZllqkb5fAlXH0zj22gjmcFed/TWVqYLzE3sXIySEhYCJx+tMfJhj7V/cfRhCbTUBd4saN
	n8wgtoiAmcTB1j9A9VwczAIfmSRWf+9gAUkIC+RI3GxfzQZiswioSsy8/wVsEK+AqUTr4llQ
	C+QlVm84ADaIE2jQzm2nWEFsIaCaF7Mns4EMlRBoZpc43/2AFaJBUuLgihssExh5FzAyrGIU
	yswry03MzDHRy6jMy6zQS87P3cQIjIhltX+idzB+uhB8iFGAg1GJh/dE+eFUIdbEsuLK3EOM
	EhzMSiK8ZjsOpArxpiRWVqUW5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLg
	lGpgrBbt0RY0jZkcrlj/5bQdd4ZCSlPp27eLvBNfZcySEfFXjprSckDqmj13kNHrNZN28/m1
	rY8wb/36tfgux8cff+ax7LAXLqt6tFBGrTlFQW311FdR5eYKV6Ynpe273VAZ5NL7WvrOyf6U
	Wyzf/Uw0xHavtjhb9fnhM9UqSd2bL6QvBXTv1lurxFKckWioxVxUnAgAhBx77oQCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsXC5WfdrMtdciTVYOs8Dos569ewWXze8I/N
	4sWGdkaLr+t/MVs8/dTHYnF47klWi8u75rBZ3Fvzn9Xi/K61rBY7lu5jsrh0YAGTxfVdDxkt
	jvceYLKYf+8zm8XmTVOZLY5Pmcpo8fsHUMfJWZNZHIQ8vrf2sXjsnHWX3WPBplKPzSu0PBbv
	ecnksWlVJ5vHpk+T2D3enTvH7nFixm8Wj3knAz3e77vK5rH4xQcmj62/7Dwap15j8/i8Sc7j
	3fy3bAECUVw2Kak5mWWpRfp2CVwZR+/cYyuYw1lx/tdUpgbGS+xdjJwcEgImEr+6/zCC2GwC
	6hI3bvxkBrFFBMwkDrb+Aarh4mAW+Mgksfp7BwtIQlggR+Jm+2o2EJtFQFVi5v0vTCA2r4Cp
	ROviWVBD5SVWbzgANogTaNDObadYQWwhoJoXsyezTWDkWsDIsIpRJDOvLDcxM8dUrzg7ozIv
	s0IvOT93EyMwvJfV/pm4g/HLZfdDjAIcjEo8vCfKD6cKsSaWFVfmHmKU4GBWEuE123EgVYg3
	JbGyKrUoP76oNCe1+BCjNAeLkjivV3hqgpBAemJJanZqakFqEUyWiYNTqoFRTPr95sd1S8w9
	LZq/r75bdG7CWt+PyyTdnzM9n83+wamJT/v/NuMazwTNLbtd1wp22HY/fvghbF7crN8mU+9m
	Oq99Lzvv1Lo97Iea9mW8TUnIKVAN276tXve9odtFlun84o9f/smb82Vl6leeQrenDzqXeW0x
	r1kxO6y9fY1QpDXPdb0m2zdMSizFGYmGWsxFxYkAJNj2imsCAAA=
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


