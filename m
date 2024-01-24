Return-Path: <linux-kernel+bounces-36286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB38A839E64
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7742C283EBC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5DE17D2;
	Wed, 24 Jan 2024 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b="E+bBTdOb"
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D9A20F4;
	Wed, 24 Jan 2024 01:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706060666; cv=none; b=Wls92tfZ9FL63KFaeNNCy2iq0dAOFDW5J81wSq1ZW7tGPinyNteAhP7X0jLbWo3yHwSVgo3F4zKS/yffgzizrfUNHc5vR4MxDeHuEKrE9gMG4Wlij/gLZslVQ7pt2JquQjYjx80ImqMwp4ExdYxe1Z8ApvCNGxmcG8IR9g9+Ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706060666; c=relaxed/simple;
	bh=t1kuy7jzuyGVsEMIivKdEr1GrnpSTkE1vbZObwWuBmA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Ja9KpygBW8AquM/rMW9c7sI8CvyVho/PiToT1IyWLppRz5M5zgjRU0a11ntk2OPctOBKKATGxHMgkdjbSvGIbF1JX55jYaNGeXQwJDmbMdk08DeCwoSoNstmIixDIp1jz337yF0++9FQA0qNkreZ88DjyG2IG7FfKFRPY45QFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn; spf=pass smtp.mailfrom=buaa.edu.cn; dkim=pass (1024-bit key) header.d=buaa.edu.cn header.i=@buaa.edu.cn header.b=E+bBTdOb; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buaa.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buaa.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=buaa.edu.cn; s=buaa; h=Received:Message-ID:Date:MIME-Version:
	User-Agent:To:Cc:From:Subject:Content-Type:
	Content-Transfer-Encoding; bh=HTlHWkFqNzrWB6UEbwT6IpKGC+SqXWzHxY
	zJA+j6t0A=; b=E+bBTdObrImXR2mHzgtmetFl40fE0LlmHkUdAHG+dsvYzONyqv
	pe9u+wIZ8w7UnI3bnqXy46K1+lSyxfiCjbPCJqcGuriWbJqvyNezlWcIALNwAx57
	tUp1jJx7QKUyD+Q5Y4D/YzYGQBJo3V2C6dLehF8S19IN7DM/Mh3465DLw=
Received: from [10.128.52.159] (unknown [10.128.52.159])
	by coremail-app1 (Coremail) with SMTP id OCz+CgAXSFpga7BlqwA0AQ--.3661S2;
	Wed, 24 Jan 2024 09:44:00 +0800 (CST)
Message-ID: <2070c707-4fd0-4ca5-b643-5317fa61edc2@buaa.edu.cn>
Date: Wed, 24 Jan 2024 09:44:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com
From: Yuxuan Hu <yuxuanhu@buaa.edu.cn>
Subject: Possible Use-After-Free in bt_accept_poll
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:OCz+CgAXSFpga7BlqwA0AQ--.3661S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFy5JFy5uw45JrWfAF15CFg_yoW7tw15pr
	98Gas3Gw4kWrykAr4UJw18WryUCr4qv3ZrCr97Kr13Aa43Ga1UJr1jkFyjgr17CrZ8Ar17
	K3WkG3yakwn3Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8E
	rcxFaVAv8VWrXryUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUqZqWUUUUU
X-CM-SenderInfo: ysqtljawssquxxddhvlgxou0/

Hello,

I am writing to report a potential use-after-free that our fuzzing tool 
found in the 'bt_accept_poll' function. The bug was encountered while 
testing kernel 6.7-rc2 during a Bluetooth pairing procedure. Due to the 
non-determinism of concurrent execution, this bug cannot be stably 
reproduced in my testing.

Through disassembly, we have pinpointed the code at 
'bt_sock_poll+0x233', which corresponds to the inline function 
'bt_accept_poll', specifically at the line:

···
File: net/bluetooth/af_bluetooth.c
Line: 492
list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q)
···

Based on the allocate and free tasks reported by KASAN, we suspect that 
the use-after-free issue originates from the 'parent' variable in the 
'bt_accept_poll' function, which corresponds to the 'sk' from 
'bt_sock_poll' that is passed into it.

The 'bt_accept_poll' function is called from 'bt_sock_poll' as follows:

···
File: net/bluetooth/af_bluetooth.c
Line: 506
     struct sock *sk = sock->sk;
     __poll_t mask = 0;

     poll_wait(file, sk_sleep(sk), wait);

     if (sk->sk_state == BT_LISTEN)
         return bt_accept_poll(sk);
···

This suggests that at the time of evaluating 'if (sk->sk_state == 
BT_LISTEN)', 'sk' is likely not NULL, and its 'sk_state' is 'BT_LISTEN'. 
However, by the time the execution reaches the section of code in 
'bt_accept_poll' mentioned above, 'sk' seems to have been freed. This 
appears to be a very subtle timing issue, which may explain the 
difficulty we have had in reproducing the bug.

KASAN report：
==================================================================
BUG: KASAN: slab-use-after-free in bt_sock_poll+0x233/0x9d0 [bluetooth]
Read of size 8 at addr ffff888005f142f8 by task bluetoothd/521

CPU: 0 PID: 521 Comm: bluetoothd Tainted: G           O 6.7.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
  <TASK>
  dump_stack_lvl+0xbf/0xf0
  print_address_description+0x7f/0x3d0
  print_report+0x11d/0x250
  ? __virt_addr_valid+0xc5/0xf0
  ? bt_sock_poll+0x233/0x9d0 [bluetooth]
  kasan_report+0x137/0x170
  ? bt_sock_poll+0x233/0x9d0 [bluetooth]
  bt_sock_poll+0x233/0x9d0 [bluetooth]
  sock_poll+0x2a0/0x350
  do_sys_poll+0x926/0x11a0
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  ? __ia32_compat_sys_ppoll_time64+0x290/0x290
  __se_sys_poll+0x15d/0x340
  ? fpregs_assert_state_consistent+0x24/0xa0
  do_syscall_64+0x32/0xa0
  entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6c44c1f933
Code: 49 8b 45 10 5d 41 5c 41 5d 41 5e c3 66 2e 0f 1f 84 00 00 00 00 00 
90 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 07 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
RSP: 002b:00007ffe74204ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00007f6c44ee1410 RCX: 00007f6c44c1f933
RDX: 00000000ffffffff RSI: 000000000000000f RDI: 00005614a8807720
RBP: 00005614a8807720 R08: 0000000000000010 R09: 0000000000000002
R10: 000000000000000f R11: 0000000000000246 R12: 000000000000000f
R13: 00007ffe74204af4 R14: 00000000ffffffff R15: 00005614a87f8bd0
  </TASK>

Allocated by task 671:
  kasan_set_track+0x4c/0x70
  __kasan_kmalloc+0x82/0x90
  __kmalloc+0xac/0x1d0
  sk_prot_alloc+0xdd/0x1a0
  sk_alloc+0x2c/0x4f0
  bt_sock_alloc+0x43/0x440 [bluetooth]
  l2cap_sock_alloc+0x3f/0x160 [bluetooth]
  l2cap_sock_new_connection_cb+0x12f/0x240 [bluetooth]
  l2cap_connect+0x7f1/0x1490 [bluetooth]
  l2cap_bredr_sig_cmd+0x45c/0x71c0 [bluetooth]
  l2cap_recv_frame+0xd46/0x1610 [bluetooth]
  l2cap_recv_acldata+0x2c5/0xd00 [bluetooth]
  hci_rx_work+0x67b/0xd00 [bluetooth]
  process_one_work+0x4f0/0xab0
  worker_thread+0x8af/0xee0
  kthread+0x275/0x300
  ret_from_fork+0x30/0x60
  ret_from_fork_asm+0x11/0x20

Freed by task 670:
  kasan_set_track+0x4c/0x70
  kasan_save_free_info+0x24/0x40
  ____kasan_slab_free+0x118/0x190
  slab_free_freelist_hook+0xd1/0x160
  __kmem_cache_free+0xa3/0x170
  __sk_destruct+0x317/0x400
  sock_put+0x81/0xd0 [bluetooth]
  l2cap_sock_kill+0xf6/0x110 [bluetooth]
  l2cap_sock_close_cb+0x66/0x80 [bluetooth]
  l2cap_conn_del+0x345/0x640 [bluetooth]
  l2cap_connect_cfm+0xdb/0x1060 [bluetooth]
  hci_connect_cfm+0x100/0x1c0 [bluetooth]
  hci_conn_failed+0x1c8/0x280 [bluetooth]
  hci_abort_conn_sync+0x7d9/0xaf0 [bluetooth]
  hci_disconnect_all_sync+0x152/0x1b0 [bluetooth]
  hci_set_powered_sync+0x499/0x6c0 [bluetooth]
  hci_cmd_sync_work+0x1f7/0x2b0 [bluetooth]
  process_one_work+0x4f0/0xab0
  worker_thread+0x8af/0xee0
  kthread+0x275/0x300
  ret_from_fork+0x30/0x60
  ret_from_fork_asm+0x11/0x20

Last potentially related work creation:
  kasan_save_stack+0x3b/0x60
  kasan_record_aux_stack_noalloc+0x96/0xa0
  __call_rcu_common+0x75/0xb40
  addrconf_ifdown+0x147a/0x1680
  addrconf_notify+0x161/0x1900
  notifier_call_chain+0xcd/0x1e0
  unregister_netdevice_many_notify+0xaa1/0x1230
  sit_exit_batch_net+0x53c/0x570
  cleanup_net+0x51f/0x970
  process_one_work+0x4f0/0xab0
  worker_thread+0x8af/0xee0
  kthread+0x275/0x300
  ret_from_fork+0x30/0x60
  ret_from_fork_asm+0x11/0x20


