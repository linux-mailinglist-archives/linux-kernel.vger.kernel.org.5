Return-Path: <linux-kernel+bounces-123808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E829E890E59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24D7E1C23C75
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5CB57874;
	Thu, 28 Mar 2024 23:13:22 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EBE171AB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711667601; cv=none; b=AaT9izK4weZdXx7COPXePpwU38no88dJJf/gD2myrKul3oQ1EIvonsB+BgJm97tExlKyMKZVbQqsqLr3q/rP0desDAs/IWvZq+fzeyi51j52i+HuYKcxxrLPNY6ZDEv9yn3bas3JGnIs6JJ8/vclkulOPiobzIybI+kH5m5UXOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711667601; c=relaxed/simple;
	bh=IHJcLm3oNfQxjGQAifqBLrvI1ODFdqL/UXNWzIpk5Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u0NJfVidzcH/IXVPp+sbFVdGT32SQ8WdIZeqZuJseKisjr3ocuDxEQqBhbiJu7jnvjSop/Snd/Ov5HZSmWl91HxJtUvcV6HMiGJKoDvidqs5r31NurBBiHJZ/wJzAOoLaY5W3cn5tK3LyjyuETNekKYHL2c9bn6LaMq0ypbdkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.240])
	by sina.com (10.75.12.45) with ESMTP
	id 6605F84300005A3F; Thu, 29 Mar 2024 07:07:50 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 26469631457776
X-SMAIL-UIID: 9F53B0D3199D457282B4296FDB24A34C-20240329-070750-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1fa663a2100308ab6eab@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] possible deadlock in kvfree_call_rcu
Date: Fri, 29 Mar 2024 07:07:38 +0800
Message-Id: <20240328230738.2910-1-hdanton@sina.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

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

