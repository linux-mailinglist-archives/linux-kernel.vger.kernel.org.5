Return-Path: <linux-kernel+bounces-25715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA582D4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769F31C2118C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339C379C7;
	Mon, 15 Jan 2024 08:20:12 +0000 (UTC)
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182A063BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-7a-65a4eab45555
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
Subject: [PATCH v6 2/7] arm64: tlbflush: Add APIs manipulating tlb batch's arch data
Date: Mon, 15 Jan 2024 17:19:48 +0900
Message-Id: <20240115081953.2521-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240115081953.2521-1-byungchul@sk.com>
References: <20240115081953.2521-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsXC9ZZnke6WV0tSDR4tELWYs34Nm8XnDf/Y
	LF5saGe0+Lr+F7PF0099LBaXd81hs7i35j+rxflda1ktdizdx2Rx6cACJovrux4yWhzvPcBk
	Mf/eZzaLzZumMlscnzKV0eL3D6COk7MmszgIenxv7WPx2DnrLrvHgk2lHptXaHks3vOSyWPT
	qk42j02fJrF7vDt3jt3jxIzfLB7zTgZ6vN93lc1j6y87j8ap19g8Pm+S83g3/y1bAH8Ul01K
	ak5mWWqRvl0CV8aevofsBbO5Kja9b2drYNzL0cXIySEhYCLx5+sEFhj75OkWZhCbTUBd4saN
	n2C2iICZxMHWP+xdjFwczAIfmSRWf+8AauDgEBYIkTi2WQakhkVAVeLX5nZGEJsXaM62nu/M
	EDPlJVZvOABmcwqYSrz7eJwdxBYCqmm5u44VZKaEQDu7xIfZh1khGiQlDq64wTKBkXcBI8Mq
	RqHMvLLcxMwcE72MyrzMCr3k/NxNjMB4WFb7J3oH46cLwYcYBTgYlXh4f/xdnCrEmlhWXJl7
	iFGCg1lJhLf6zpJUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxG38pThATSE0tSs1NTC1KLYLJM
	HJxSDYyeJU89j3v1/La5sGbRvAUqB1wEc2aphZgc+bJ6vneVnq7Fjf08s4oiunM4vTco6UnP
	4Pa2en18wqR679BEvR9ZTay9fMn6KtP8ff/w8hWUqdxQs95W6xPRyW+3JOPdN2G5qzMrBB1D
	rzltr15xZc5NLRM3pZfrThcYTz37tnvirp+ftPdwrFFiKc5INNRiLipOBACmt96qgwIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsXC5WfdrLvl1ZJUgyXv2SzmrF/DZvF5wz82
	ixcb2hktvq7/xWzx9FMfi8XhuSdZLS7vmsNmcW/Nf1aL87vWslrsWLqPyeLSgQVMFtd3PWS0
	ON57gMli/r3PbBabN01ltjg+ZSqjxe8fQB0nZ01mcRDy+N7ax+Kxc9Zddo8Fm0o9Nq/Q8li8
	5yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPOadDPR4v+8qm8fiFx+YPLb+svNonHqNzePzJjmP
	d/PfsgUIRHHZpKTmZJalFunbJXBl7Ol7yF4wm6ti0/t2tgbGvRxdjJwcEgImEidPtzCD2GwC
	6hI3bvwEs0UEzCQOtv5h72Lk4mAW+Mgksfp7B0sXIweHsECIxLHNMiA1LAKqEr82tzOC2LxA
	c7b1fGeGmCkvsXrDATCbU8BU4t3H4+wgthBQTcvddawTGLkWMDKsYhTJzCvLTczMMdUrzs6o
	zMus0EvOz93ECAzuZbV/Ju5g/HLZ/RCjAAejEg/vj7+LU4VYE8uKK3MPMUpwMCuJ8FbfWZIq
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwFj5aoFW5esc
	p8jDSq8/e2hqtpsb33t5OrMqRbH7jOyq7KrUvI3dHUXCDGbrxK493BEyV+31+r9PnnrFbtqm
	8vy9wEtFk49lh7YY3D/cwmyzpcJqW7DV6YL3DqrOnJsThROWbFuyaX5VlIHa9dzNPy7VKmk3
	qRTUzK1xP554/fWf+iVHym57bFZiKc5INNRiLipOBACps5EaagIAAA==
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


