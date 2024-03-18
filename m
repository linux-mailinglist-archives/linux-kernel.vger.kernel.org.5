Return-Path: <linux-kernel+bounces-106186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B30587EA77
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA26F283505
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00D64CB24;
	Mon, 18 Mar 2024 13:58:27 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE0E4D9E0
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770307; cv=none; b=Cwb+cEk9HsO8FqgEb+CM/6hDgW4YKcasT9LLFaWxPZ/mLO//8tzInGfBnPNPwou/mae6BRwmpEYx/RyHoVkzdL3Em6G9xdUmu83A+s7WBIJE5EbscalfaWq0aew1z/HqXz7w5DIfp9HSx4XjqSQbNaKZc/+UL+4JkEvmTwVYXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770307; c=relaxed/simple;
	bh=A6bxn+il7rCcUtdKGlKK9hwfufPW7m1ZPMz065kMN6g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UgV6hFZD7C9TofTiyWUhl3drhJ7hVWFsxTElVwslkGN0VNBULXXZDPdjgRuLJeLjv6/uN0EyloJrj4Xx1IZ5YIBwknKG1qsiTydmBAerVdpqwFSchwrFxf+KXXlxLmSI2HjpEjBcT36QHyKDq+lk/RxPS26wImzme9Y62lSCOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TyxJl2ylXz4f3jkq
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:58:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3EB421A0172
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:58:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RF4SPhllRNcHQ--.5764S4;
	Mon, 18 Mar 2024 21:58:19 +0800 (CST)
From: thunder.leizhen@huaweicloud.com
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mm/mm_init.c: eliminate a local variable in mem_debugging_and_hardening_init()
Date: Mon, 18 Mar 2024 21:57:14 +0800
Message-Id: <20240318135715.312-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RF4SPhllRNcHQ--.5764S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWrXrykXFy8Xw1DJryxZrb_yoW8CFWxpF
	Z8Jw1IyrZ5ArZak3y2yryDWry7JayfGFW7Jry3Xa43Xw1xC3yrKFs7Kw15ZFyvvrWkXa1a
	qa93Kr9rZ3W5ta7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j9aPUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/

From: Zhen Lei <thunder.leizhen@huawei.com>

The local variable 'page_poisoning_requested' is assigned true at only
one point. It can be eliminated by moving the code that depends on it
to the location where it is assigned true. This also make the moved
code to be compiled only if CONFIG_PAGE_POISONING is set.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/mm_init.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 549e76af8f82a8e..3eb217130bcb2b5 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2614,7 +2614,6 @@ DEFINE_STATIC_KEY_MAYBE(CONFIG_DEBUG_VM, check_pages_enabled);
  */
 static void __init mem_debugging_and_hardening_init(void)
 {
-	bool page_poisoning_requested = false;
 	bool want_check_pages = false;
 
 #ifdef CONFIG_PAGE_POISONING
@@ -2626,18 +2625,16 @@ static void __init mem_debugging_and_hardening_init(void)
 	     (!IS_ENABLED(CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC) &&
 	      debug_pagealloc_enabled())) {
 		static_branch_enable(&_page_poisoning_enabled);
-		page_poisoning_requested = true;
 		want_check_pages = true;
-	}
-#endif
 
-	if ((_init_on_alloc_enabled_early || _init_on_free_enabled_early) &&
-	    page_poisoning_requested) {
-		pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
-			"will take precedence over init_on_alloc and init_on_free\n");
-		_init_on_alloc_enabled_early = false;
-		_init_on_free_enabled_early = false;
+		if (_init_on_alloc_enabled_early || _init_on_free_enabled_early) {
+			pr_info("mem auto-init: CONFIG_PAGE_POISONING is on, "
+				"will take precedence over init_on_alloc and init_on_free\n");
+			_init_on_alloc_enabled_early = false;
+			_init_on_free_enabled_early = false;
+		}
 	}
+#endif
 
 	if (_init_on_alloc_enabled_early) {
 		want_check_pages = true;
-- 
2.34.1


