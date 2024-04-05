Return-Path: <linux-kernel+bounces-132490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F698995CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCF3B23B2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773F82561B;
	Fri,  5 Apr 2024 06:47:26 +0000 (UTC)
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1121.securemx.jp [210.130.202.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB981D556;
	Fri,  5 Apr 2024 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299645; cv=none; b=M95a2rcJhGMehEVPYOwJCHL6Xo9cqqBo1wDTpOYDfec9HFhrIfirmyuOf2ouhaPijn2SyAAV4YP2WMsT0jHL2Fxh6Uvk3xXqCDeexMk+MakNMnvwtyVETSHxK6EgrrNfYV+8hHhuMAb4ZUiuxjM6AB+MAQz2BkTWXv1lOIx9OX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299645; c=relaxed/simple;
	bh=dJUTKxD4XBA6+hIRAinaK6cEmG7qw63qofZNFG7MDxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fl0/XVUnTyopNqUAxEdTJtrZnjTxPOl6JFJXDm4rdYzm+gej5QlrGiBGDBMhVZavTNx3sFUbgL3HDHF84gYavdkNMKVSEtbIcHyq4+2naPf/Es5KMHN4FuwwqNMA7ILjDaGyo5iztoccZbeq89FYRWf6NQT1Cj6uY/40Lq9VkgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com; spf=pass smtp.mailfrom=kioxia.com; arc=none smtp.client-ip=210.130.202.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kioxia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kioxia.com
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1121) id 4355K5I21310389; Fri, 5 Apr 2024 14:20:06 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4355I7mJ2067497; Fri, 5 Apr 2024 14:18:07 +0900
X-Iguazu-Qid: 2rWgdkpBO6OePkihnS
X-Iguazu-QSIG: v=2; s=0; t=1712294286; q=2rWgdkpBO6OePkihnS; m=H8i1jpPUTZXpV+y8ImFQuSpTNChbT1Oq2VpBd65iopU=
Received: from CNN1EMTA03.test.kioxia.com ([202.248.33.144])
	by relay.securemx.jp (mx-mr1120) id 4355I5fU1283493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 5 Apr 2024 14:18:05 +0900
Received: from Switcher-Post_Send (gateway [10.232.20.1])
	by CNN1EMTA03.test.kioxia.com (Postfix) with ESMTP id 2FB152F603;
	Fri,  5 Apr 2024 14:18:05 +0900 (JST)
Received: from CNN1ESTR04.kioxia.com (localhost [127.0.0.1])
	by Switcher-Post_Send (Postfix) with ESMTP id E01B01900001F6;
	Fri,  5 Apr 2024 14:05:31 +0900 (JST)
Received: from localhost [127.0.0.1] 
	 by CNN1ESTR04.kioxia.com with ESMTP id 0003QAAAAAA00F34;
	 Fri, 5 Apr 2024 14:05:31 +0900
Received: from CNN1EXMB03.r1.kioxia.com (CNN1EXMB03.r1.kioxia.com [10.232.20.152])
	by Switcher-Pre_Send (Postfix) with ESMTP id D468DA29C5E08;
	Fri,  5 Apr 2024 14:05:31 +0900 (JST)
Received: from CNN1EXMB03.r1.kioxia.com (10.232.20.152) by
 CNN1EXMB03.r1.kioxia.com (10.232.20.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Apr 2024 14:18:04 +0900
Received: from CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) by
 CNN1EXMB03.r1.kioxia.com ([10.13.100.22]) with mapi id 15.01.2507.035; Fri, 5
 Apr 2024 14:18:04 +0900
From: tada keisuke <keisuke1.tada@kioxia.com>
To: kernel test robot <oliver.sang@intel.com>
CC: "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com"
	<lkp@intel.com>,
        ohtake toshifumi <toshifumi.ootake@kioxia.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "song@kernel.org"
	<song@kernel.org>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/11] md: add atomic mode switching when removing disk
Thread-Topic: [PATCH 09/11] md: add atomic mode switching when removing disk
Thread-Index: AQHagv7ppOhMD1h+V0G2IfGpZUQoObFZG7ZQ
Date: Fri, 5 Apr 2024 05:18:04 +0000
Message-ID: <bdffa39d605c4340910640d10ac6a9b4@kioxia.com>
References: <e95e7cea71d1465496a9502b4de49e75@kioxia.com>
 <202403310746.6c8b0587-oliver.sang@intel.com>
In-Reply-To: <202403310746.6c8b0587-oliver.sang@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tm-as-product-ver: ISME-14.0.0.2080-9.0.1002-28298.001
x-tm-as-result: No-10--9.854900-8.000000
x-tmase-matchedrid: 13nEecSBt9GmagT1k9kBpu5i6weAmSDKQV99ahimM1VYC5LPd7Bvbaso
	qU8yj7u9HIMkasPj1EKWe6+6619iNKf0QmPqa4keZj7E6vHnuNZpkBMYDn8FeGnes/wd3/vhtMd
	GzZAls9Y07flFHfXJs1F+SzCZQid2dh9gYos97K2vv6qFlL+SGTVEnbrqmBw7r9t08Ze+Qb+9cy
	KhdlQvHTtvYiW4KdPqzHj1xOR70ZBSr2+67Jvlw2/6CCblACLhQR7lWMXPA1vWfdTIhX4P841EI
	8AWiw6UhJtbBPDn7JuOYTH9s0ioWFxxDx5qbkR9gxsfzkNRlfKx5amWK2anSPoLR4+zsDTtw1tM
	VU7ONTyP4W9NA3FMNEROBxJTpKtE+er4HxlNLTJiqx3X0AgSIg==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--9.854900-8.000000
x-tmase-version: ISME-14.0.0.2080-9.0.1002-28298.001
x-tm-snts-smtp: AA4D7E06A98E6AA4E04D8A32D99A7095106733D0D9011490F3E322652644B7292000:8
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CrossPremisesHeadersFilteredBySendConnector: CNN1EXMB03.r1.kioxia.com
X-OrganizationHeadersPreserved: CNN1EXMB03.r1.kioxia.com

> kern  :err   : [  118.926307] BUG: sleeping function called from invalid =
context at lib/percpu-refcount.c:331
> kern  :err   : [  118.935427] in_atomic(): 0, irqs_disabled(): 0, non_blo=
ck: 0, pid: 55, name: kworker/6:0
> kern  :err   : [  118.944338] preempt_count: 0, expected: 0
> kern  :err   : [  118.949122] RCU nest depth: 1, expected: 0
> kern  :warn  : [  118.954016] CPU: 6 PID: 55 Comm: kworker/6:0 Tainted: G=
 S
> 6.8.0-rc3-00236-gff944d1be0fa #1
> kern  :warn  : [  118.964389] Hardware name: Gigabyte Technology Co., Ltd=
 Z97X-UD5H/Z97X-UD5H, BIOS F9
> 04/21/2015
> kern  :warn  : [  118.973916] Workqueue: md_misc md_start_sync
> kern  :warn  : [  118.978937] Call Trace:
> kern  :warn  : [  118.982115]  <TASK>
> kern :warn : [  118.984943] dump_stack_lvl (lib/dump_stack.c:107 (discrim=
inator 1))
> kern :warn : [  118.989337] __might_resched (kernel/sched/core.c:10190)
> kern :warn : [  118.993989] ? _raw_spin_lock_irqsave (arch/x86/include/as=
m/atomic.h:115
> include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/ato=
mic-instrumented.h:1296
> include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/=
linux/spinlock_api_smp.h:111
> kernel/locking/spinlock.c:162)
> kern :warn : [  118.999243] ? preempt_notifier_dec (kernel/sched/core.c:1=
0144)
> kern :warn : [  119.004321] percpu_ref_switch_to_atomic_sync (include/lin=
ux/kernel.h:107 lib/percpu-refcount.c:331)
> kern :warn : [  119.010353] ? percpu_ref_reinit (lib/percpu-refcount.c:32=
9)
> kern :warn : [  119.015351] ? _raw_spin_lock_irqsave (arch/x86/include/as=
m/atomic.h:115
> include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/ato=
mic-instrumented.h:1296
> include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/=
linux/spinlock_api_smp.h:111
> kernel/locking/spinlock.c:162)
> kern :warn : [  119.020596] ? _raw_read_unlock_irqrestore (kernel/locking=
/spinlock.c:161)
> kern :warn : [  119.026282] ? finish_task_switch+0x158/0x730
> kern :warn : [  119.031969] ? __switch_to (arch/x86/include/asm/bitops.h:=
55
> include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_=
info.h:89
> arch/x86/include/asm/fpu/sched.h:66 arch/x86/kernel/process_64.c:626)
> kern :warn : [  119.036435] rdev_removeable (drivers/md/md.c:9282)
> kern :warn : [  119.041083] md_start_sync (drivers/md/md.c:9339 drivers/m=
d/md.c:9449)
> kern :warn : [  119.045462] ? mddev_unlock (drivers/md/md.c:9444)
> kern :warn : [  119.050021] ? _raw_spin_lock_irq (arch/x86/include/asm/at=
omic.h:115
> include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/ato=
mic-instrumented.h:1296
> include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/=
linux/spinlock_api_smp.h:120
> kernel/locking/spinlock.c:170)
> kern :warn : [  119.054928] ? _raw_spin_lock_bh (kernel/locking/spinlock.=
c:169)
> kern :warn : [  119.059739] process_one_work (kernel/workqueue.c:2638)
> kern :warn : [  119.064476] worker_thread (kernel/workqueue.c:2700 kernel=
/workqueue.c:2787)
> kern :warn : [  119.068943] ? process_one_work (kernel/workqueue.c:2733)
> kern :warn : [  119.073864] kthread (kernel/kthread.c:388)
> kern :warn : [  119.077815] ? kthread_complete_and_exit (kernel/kthread.c=
:341)
> kern :warn : [  119.083321] ret_from_fork (arch/x86/kernel/process.c:153)
> kern :warn : [  119.087627] ? kthread_complete_and_exit (kernel/kthread.c=
:341)
> kern :warn : [  119.093140] ret_from_fork_asm (arch/x86/entry/entry_64.S:=
250)
> kern  :warn  : [  119.097786]  </TASK>

Thanks for reporting.
I need to execute percpu_ref_switch_to_atomic_sync() when RCU is unlocked.
I will fix this problem and submit v2.

Thanks,
Keisuke


