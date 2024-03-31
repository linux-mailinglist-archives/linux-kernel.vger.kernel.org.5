Return-Path: <linux-kernel+bounces-125966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C23892EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 08:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B6E1F21727
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 06:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22C679DC;
	Sun, 31 Mar 2024 06:20:56 +0000 (UTC)
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539246FCC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711866056; cv=none; b=ovmur2pM/PDcjoJNk+E6QHsmmU0MIrZNK3IB/dnSohhwxIVFW3kri21vCq246QXXrVcQsNU1NA/5r8360sFIOgBvJiwjMM6CR952C8SKYhoxK7lhjmy+mxC4FXmHBsgPBSJ5Z1/XfQXvET+il0t3cbWJQZYqTfQQEsXhNQxTAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711866056; c=relaxed/simple;
	bh=VqKv1cUOhZbzr+oAZDwA1oezSwzFV6yXqtR6U/dea/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmnoTXVG4a1wl6I0GQLg6I16mGe8MS5acD63myPVxUDBd4P9KqnJRA+vFGkLaklByBn+F8q4eXbSq9dCuhdU7Hfg4lDqRKwfCJP0pSBHuGTXL3NQ7FGn1aJhGmFCd8l7L9NAFWV2KSpop9gNCbyg/dpHmCT+HqftU+u2m/fTk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.152])
	by sina.com (172.16.235.25) with ESMTP
	id 6609009800003D91; Sun, 31 Mar 2024 14:20:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 44924034210201
X-SMAIL-UIID: 6924078F414540C5A10A825D4304B6C9-20240331-142010-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Date: Sun, 31 Mar 2024 14:19:58 +0800
Message-Id: <20240331061958.3340-1-hdanton@sina.com>
In-Reply-To: <000000000000716bb60614acbf37@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Mar 2024 16:27:19 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ca53c9180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/kernel/rcu/tree.c
+++ y/kernel/rcu/tree.c
@@ -2957,7 +2957,8 @@ krc_this_cpu_lock(unsigned long *flags)
 
 	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
 	krcp = this_cpu_ptr(&krc);
-	raw_spin_lock(&krcp->lock);
+	while (!raw_spin_trylock(&krcp->lock))
+		;
 
 	return krcp;
 }
--- x/kernel/bpf/lpm_trie.c
+++ y/kernel/bpf/lpm_trie.c
@@ -382,9 +382,10 @@ static long trie_update_elem(struct bpf_
 			trie->n_entries--;
 
 		rcu_assign_pointer(*slot, new_node);
-		kfree_rcu(node, rcu);
 
-		goto out;
+		spin_unlock_irqrestore(&trie->lock, irq_flags);
+		kfree_rcu(node, rcu);
+		return 0;
 	}
 
 	/* If the new node matches the prefix completely, it must be inserted
--

