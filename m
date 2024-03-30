Return-Path: <linux-kernel+bounces-125550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD847892813
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 01:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7011C212B6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 00:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975564F;
	Sat, 30 Mar 2024 00:28:27 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66564181
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 00:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711758506; cv=none; b=ZmvTXnbUVW8T1+K/wwAtRrZ0xldh9knAyVlFNNAuONl6OBlENJFIk4fOcDQ9hW/aRSSeWKLpPmz1w6QxSXo5Ueg6vrmWVBQ+nZH2NlAa20V+ZrYkPIvh6gq9sJOvsoEzHCQrMvaf2m4/DBaFYjmyK9bLeYNRJoKwWO9wL+eEDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711758506; c=relaxed/simple;
	bh=ChKy3mAhdTmBWc2KahAhaGBKwWG+SUe+Bkx0ut5e3yI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pozQmA6nnH5FTkENolgxh8YIMo4DruFXUyBWFDJ0hbLamxaQe5h51D90pwQvem5K78iImlagSQAZTp91vikOCVc/shgLHvIFGgEsU7aCBYYkypSzQ1W1oXMSxJN2Ay9WY446I5DSHZWsamQe7vrQJm7suSVJ6zgoyJhHXSQ1ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.4])
	by sina.com (172.16.235.25) with ESMTP
	id 66075C7C0000023E; Sat, 30 Mar 2024 08:27:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 94883934210299
X-SMAIL-UIID: 645845FF51BA489B8BC8443E843AA375-20240330-082742-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Date: Sat, 30 Mar 2024 08:27:32 +0800
Message-Id: <20240330002732.3029-1-hdanton@sina.com>
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
@@ -5149,6 +5149,8 @@ static void __init rcu_dump_rcu_node_tre
 
 struct workqueue_struct *rcu_gp_wq;
 
+static DEFINE_PER_CPU(struct lock_class_key, krc_lock_key);
+
 static void __init kfree_rcu_batch_init(void)
 {
 	int cpu;
@@ -5169,6 +5171,11 @@ static void __init kfree_rcu_batch_init(
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
+		struct lock_class_key *key = per_cpu_ptr(&krc_lock_key, cpu);
+		char name[32] = {0};
+
+		sprintf(name, "krc%d", cpu);
+		lockdep_set_class_and_name(&krcp->lock, key, name);
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
--

