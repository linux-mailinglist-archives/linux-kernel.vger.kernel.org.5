Return-Path: <linux-kernel+bounces-149305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 595E08A8F36
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF281C20805
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63448563B;
	Wed, 17 Apr 2024 23:13:19 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4097464
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713395599; cv=none; b=Zpqh2lIQA3rGwdAkMnsT5LMF+AqN3EHIOCShh3CfiOCEwCKPqNo0ewt1sTkZJ8kT8sAZ8qv7DiVlEU3gxB7zh+0OKWItgK+w99YWk8sJSVw/DtB0tx+uTdYelNqEdKtiI2obrBwJeFohHdZ7K59ihACCvi04V0k6buT4sq6wahM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713395599; c=relaxed/simple;
	bh=U/9iJ+V98Z0cSijfyCqxAG8uxrReMVpqrA7X/2zQ044=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3oLccQSuK8YTSlp5A7dJk4VoTJot3aZyry1pOaelKHI1+Lo27bYcuNTrEBd6zS56RMPIyJgGik61FsSj6Y2pYf+UrEtllx3/DDAjM4n24hi8eysDjQ86vA7jjX5rs+sUoY3hOuaWAkVKBsDHJcjh7B8W0+C1UrPD/hXicXqALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.128])
	by sina.com (172.16.235.24) with ESMTP
	id 6620577D00007871; Wed, 18 Apr 2024 07:13:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 41170245089450
X-SMAIL-UIID: 2A50340C585F4132AF716A5FD76BA72E-20240418-071304-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
Date: Thu, 18 Apr 2024 07:13:00 +0800
Message-Id: <20240417231300.2556-1-hdanton@sina.com>
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
--

