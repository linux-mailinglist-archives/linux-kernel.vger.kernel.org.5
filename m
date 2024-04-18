Return-Path: <linux-kernel+bounces-149908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364D8A97C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DEBB21FC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CE715E1E4;
	Thu, 18 Apr 2024 10:50:09 +0000 (UTC)
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFF115D5C1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437409; cv=none; b=AkMU/iEBKlmNClB8CHLd1a/lslmxMYs3eH0vZEV8ilXVXxwJwrtFfAfasDkYYG6j2Hjws6sGOApAMtOsCtwsf0lUk84uAg7LJM6KVIE27/7EVWODDgFPQUwAHKATq484XLLZGOFWNBSUcTuLiDDLEKtvQPY1yE/OClzjFdyXviA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437409; c=relaxed/simple;
	bh=AG8TyXJaQL3/lvYQvQsLtrYzfqub/rhZXTldlGAvJIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j5x2x3tHZybwv3ITIXtS/nEQ/nxJ1KC3U1V00x6EtSNPhFk0fOWDbKEFry6GQ4Vj8R/DOV9Ozx8+LhUlQKcxfCuSStwrwfjKC2JH7+QO06NOkGnAFsmrUE2YjDDauz1T7Yk9Sz+lAQ7e4vFX9kBEot29U1YVBJnM86kF6zjjpRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.128])
	by sina.com (10.75.12.45) with ESMTP
	id 6620FAD100009CB9; Thu, 18 Apr 2024 18:49:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 69856531457805
X-SMAIL-UIID: F42076E6E42B471386F28FD80FF96B6D-20240418-184955-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
Date: Thu, 18 Apr 2024 18:49:52 +0800
Message-Id: <20240418104952.2615-1-hdanton@sina.com>
In-Reply-To: <000000000000b3c7fa061652665f@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 17 Apr 2024 15:30:26 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f89857180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  9ed46da14b9b

--- x/mm/hugetlb.c
+++ y/mm/hugetlb.c
@@ -6251,6 +6251,12 @@ static vm_fault_t hugetlb_no_page(struct
 							VM_UFFD_MISSING);
 		}
 
+		if (!(vma->vm_flags & VM_MAYSHARE)) {
+			ret = vmf_anon_prepare(vmf);
+			if (unlikely(ret))
+				goto out;
+		}
+
 		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
 		if (IS_ERR(folio)) {
 			/*
@@ -6290,15 +6296,12 @@ static vm_fault_t hugetlb_no_page(struct
 				restore_reserve_on_error(h, vma, vmf->address,
 							folio);
 				folio_put(folio);
+				ret = VM_FAULT_SIGBUS;
 				goto out;
 			}
 			new_pagecache_folio = true;
 		} else {
 			folio_lock(folio);
-
-			ret = vmf_anon_prepare(vmf);
-			if (unlikely(ret))
-				goto backout_unlocked;
 			anon_rmap = 1;
 		}
 	} else {
--- x/kernel/softirq.c
+++ y/kernel/softirq.c
@@ -564,7 +564,7 @@ restart:
 	}
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	    __this_cpu_read(ksoftirqd) == current && in_task())
 		rcu_softirq_qs();
 
 	local_irq_disable();
--

