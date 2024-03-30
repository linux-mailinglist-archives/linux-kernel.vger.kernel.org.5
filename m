Return-Path: <linux-kernel+bounces-125908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C839A892E19
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F37F28259B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769545974;
	Sat, 30 Mar 2024 23:42:45 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C7A2E3E8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711842165; cv=none; b=a0aFpyuINsvc2+3sz8d3pSzaGca9anXaM9CaAhr5uWcQMfCTQcbX85T7iM/9TxSDijsSnFOOyVP3nSKMaEGT52bZeG+aH2j9S3tCjjr5nR+1O1kqne51anYdhCyJ0SOeczluC/hxG94i0SJzJ7qe9O4UyjZF7/0GVHNM+hnAEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711842165; c=relaxed/simple;
	bh=LkcPu3aiN8+Pp7SgssHAmiDSJJkhOmSWWOszD6D8tLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jNcn5ynCPPk3y55UtdcRBz2O5cKLTox/Sr4c3yZbZYIH0+0ckbnDKQh06IB6pfm3nf7HfrYLPHgTIg4HDy93nxW1U/6fsO0ro9AqUTZsBkoIowjKuKys8cKDUgMxKdNt/su+rJYqFUYBIhLdmgyVhIGgZcaXSco2Kq6TB9Ev98c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.152])
	by sina.com (172.16.235.24) with ESMTP
	id 6608A36300007CAB; Sat, 31 Mar 2024 07:42:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 14092045089264
X-SMAIL-UIID: 77F8267D54D24F6CBA4FD1B63BC82AA7-20240331-074230-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Date: Sun, 31 Mar 2024 07:42:17 +0800
Message-Id: <20240330234217.3169-1-hdanton@sina.com>
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
--

