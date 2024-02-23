Return-Path: <linux-kernel+bounces-79097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3B8861D88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832E8289412
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F249B146E98;
	Fri, 23 Feb 2024 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="YS1wGRy8"
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968DA143C45
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719745; cv=none; b=KPV9Z3S55m0nqBUxIBtbNc6uV3mufjEkbfhY/NiSnLhy4k2QniMzOL0YXxXlxWMH1OzkbiXLbzv2lBGX9RjgM8FxSf0P7Y3FALgkqtsFPnvsoiNUQ2Q5ASNEm/lXJxpRxyRgJ/HhOLPWlp57e1+bHpWMKzLYBISDXVK0+5hXGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719745; c=relaxed/simple;
	bh=i4bjYjnFuN3uQJWtwzufy5HHsEsupjuk8beollEohDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doEIn3gKDljILhCMelpH/0dBA9JW4lS1fqLhCp5Xia9s3VzVP+hbEvGocEcFPX9hKU8sYFru3o6NQPar9DX9HJb4dvw57SKTSNzdng+2PE77aGQ4fP3qj56nyYtzIwusqiy1mXz0wwcZjySgN+insebI6v6p+tZRHDiMLcSdNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=YS1wGRy8; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1708719743; bh=q5WIEnTvGFLIOGqtmBakZKNfAn/EMCpeNpBFapy+o7U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=YS1wGRy81mEiDAOAvpuqOPivkFU2DP7gE77zLdCrFTZUWLX7u4KVBiuMRiimCFwTl
	 FnIhgDBd5enEKK8+EWT/Y+VqLjHCkj7EPsbkBdpDU/byBqv5xfUXeQWmRjvlTBEsBb
	 Kj9SpwX5Pb56uWZCHLRshduhjaBR9rZ7cNaBPiCLCMN9liUPy1qunaI8kPyPJZnmsZ
	 QXssQ3jCvmI90h2fS8x1SCKuSCV7v81PtgXSsi+K5lFwc3S1BDCFgcqiGMB0MpFu0L
	 Pryu09QhFenkV4ib8eNdjAT+x3nm3p1KWnqyND5Ybt/u4goyJt/h96qsEGp3+KksUG
	 VJQon+czEvNXw==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id F01309602C0;
	Fri, 23 Feb 2024 20:22:21 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: junxiao.bi@oracle.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Fri, 23 Feb 2024 13:22:20 -0700
Message-ID: <20240223202220.11776-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f6640cc8-2b66-44e7-b2f7-8ba17bde2281@oracle.com>
References: <f6640cc8-2b66-44e7-b2f7-8ba17bde2281@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: O2jvMMKCNJFXZjd4HEXFoLAnQcixREe8
X-Proofpoint-ORIG-GUID: O2jvMMKCNJFXZjd4HEXFoLAnQcixREe8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 clxscore=1030 malwarescore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2402230151

> Before we know how to share vmcore, can you run below cmds from crash first:
>
> 1. ps -m | grep UN
>
> 2. foreach UN bt
>
> 3. ps -m | grep md
>
> 4. bt each md process

Sure, here you go!

----

root@localhost:/var/crash/127.0.0.1-2024-02-23-01:34:56# crash /home/test/src/linux/vmlinux vmcore

crash 8.0.4-2.fc39
Copyright (C) 2002-2022  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005, 2011, 2020-2022  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
Copyright (C) 2015, 2021  VMware, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.
 
GNU gdb (GDB) 10.2
Copyright (C) 2021 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-linux-gnu".
Type "show configuration" for configuration details.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...

WARNING: ORC unwinder: module orc_entry structures have changed
WARNING: cannot determine how modules are linked
WARNING: no kernel module access

      KERNEL: /home/test/src/linux/vmlinux 
    DUMPFILE: vmcore
        CPUS: 8
        DATE: Fri Feb 23 01:34:54 UTC 2024
      UPTIME: 00:41:00
LOAD AVERAGE: 6.00, 5.90, 4.80
       TASKS: 309
    NODENAME: localhost.localdomain
     RELEASE: 6.8.0-rc5
     VERSION: #1 SMP Fri Feb 23 00:22:23 UTC 2024
     MACHINE: x86_64  (2999 Mhz)
      MEMORY: 8 GB
       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
         PID: 1977
     COMMAND: "bash"
        TASK: ffff888105325880  [THREAD_INFO: ffff888105325880]
         CPU: 5
       STATE: TASK_RUNNING (PANIC)

crash> ps -m | grep UN
[0 00:15:50.424] [UN]  PID: 957      TASK: ffff88810baa0ec0  CPU: 1    COMMAND: "jbd2/dm-3-8"
[0 00:15:56.151] [UN]  PID: 1835     TASK: ffff888108a28ec0  CPU: 2    COMMAND: "dd"
[0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
[0 00:15:56.185] [UN]  PID: 1914     TASK: ffff8881015e6740  CPU: 1    COMMAND: "kworker/1:2"
[0 00:15:56.255] [UN]  PID: 403      TASK: ffff888101351d80  CPU: 7    COMMAND: "kworker/u21:1"
crash> foreach UN bt
PID: 403      TASK: ffff888101351d80  CPU: 7    COMMAND: "kworker/u21:1"
 #0 [ffffc90000863840] __schedule at ffffffff81ac18ac
 #1 [ffffc900008638a0] schedule at ffffffff81ac1d82
 #2 [ffffc900008638b8] io_schedule at ffffffff81ac1e4d
 #3 [ffffc900008638c8] wait_for_in_progress at ffffffff81806224
 #4 [ffffc90000863910] do_origin at ffffffff81807265
 #5 [ffffc90000863948] __map_bio at ffffffff817ede6a
 #6 [ffffc90000863978] dm_submit_bio at ffffffff817ee31e
 #7 [ffffc900008639f0] __submit_bio at ffffffff81515ec1
 #8 [ffffc90000863a08] submit_bio_noacct_nocheck at ffffffff815162a7
 #9 [ffffc90000863a60] ext4_io_submit at ffffffff813b506b
#10 [ffffc90000863a70] ext4_do_writepages at ffffffff81399ed6
#11 [ffffc90000863b20] ext4_writepages at ffffffff8139a85d
#12 [ffffc90000863bb8] do_writepages at ffffffff81258c30
#13 [ffffc90000863c18] __writeback_single_inode at ffffffff8132348a
#14 [ffffc90000863c48] writeback_sb_inodes at ffffffff81323b62
#15 [ffffc90000863d18] __writeback_inodes_wb at ffffffff81323e17
#16 [ffffc90000863d58] wb_writeback at ffffffff8132400a
#17 [ffffc90000863dc0] wb_workfn at ffffffff8132503c
#18 [ffffc90000863e68] process_one_work at ffffffff81147b69
#19 [ffffc90000863ea8] worker_thread at ffffffff81148554
#20 [ffffc90000863ef8] kthread at ffffffff8114f8ee
#21 [ffffc90000863f30] ret_from_fork at ffffffff8108bb98
#22 [ffffc90000863f50] ret_from_fork_asm at ffffffff81000da1

PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
 #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
 #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
 #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
 #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
 #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
 #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
 #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
 #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
 #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1

PID: 957      TASK: ffff88810baa0ec0  CPU: 1    COMMAND: "jbd2/dm-3-8"
 #0 [ffffc90001d47b10] __schedule at ffffffff81ac18ac
 #1 [ffffc90001d47b70] schedule at ffffffff81ac1d82
 #2 [ffffc90001d47b88] io_schedule at ffffffff81ac1e4d
 #3 [ffffc90001d47b98] wait_for_in_progress at ffffffff81806224
 #4 [ffffc90001d47be0] do_origin at ffffffff81807265
 #5 [ffffc90001d47c18] __map_bio at ffffffff817ede6a
 #6 [ffffc90001d47c48] dm_submit_bio at ffffffff817ee31e
 #7 [ffffc90001d47cc0] __submit_bio at ffffffff81515ec1
 #8 [ffffc90001d47cd8] submit_bio_noacct_nocheck at ffffffff815162a7
 #9 [ffffc90001d47d30] jbd2_journal_commit_transaction at ffffffff813d246c
#10 [ffffc90001d47e90] kjournald2 at ffffffff813d65cb
#11 [ffffc90001d47ef8] kthread at ffffffff8114f8ee
#12 [ffffc90001d47f30] ret_from_fork at ffffffff8108bb98
#13 [ffffc90001d47f50] ret_from_fork_asm at ffffffff81000da1

PID: 1835     TASK: ffff888108a28ec0  CPU: 2    COMMAND: "dd"
 #0 [ffffc90000c2fb30] __schedule at ffffffff81ac18ac
 #1 [ffffc90000c2fb90] schedule at ffffffff81ac1d82
 #2 [ffffc90000c2fba8] io_schedule at ffffffff81ac1e4d
 #3 [ffffc90000c2fbb8] bit_wait_io at ffffffff81ac2418
 #4 [ffffc90000c2fbc8] __wait_on_bit at ffffffff81ac214a
 #5 [ffffc90000c2fc10] out_of_line_wait_on_bit at ffffffff81ac22cc
 #6 [ffffc90000c2fc60] do_get_write_access at ffffffff813d0bc3
 #7 [ffffc90000c2fcb0] jbd2_journal_get_write_access at ffffffff813d0dc4
 #8 [ffffc90000c2fcd8] __ext4_journal_get_write_access at ffffffff8137c2c9
 #9 [ffffc90000c2fd18] ext4_reserve_inode_write at ffffffff813997f8
#10 [ffffc90000c2fd40] __ext4_mark_inode_dirty at ffffffff81399a38
#11 [ffffc90000c2fdc0] ext4_dirty_inode at ffffffff8139cf52
#12 [ffffc90000c2fdd8] __mark_inode_dirty at ffffffff81323284
#13 [ffffc90000c2fe10] generic_update_time at ffffffff8130de25
#14 [ffffc90000c2fe28] file_modified at ffffffff8130e23c
#15 [ffffc90000c2fe50] ext4_buffered_write_iter at ffffffff81388b6f
#16 [ffffc90000c2fe78] vfs_write at ffffffff812ee149
#17 [ffffc90000c2ff08] ksys_write at ffffffff812ee47e
#18 [ffffc90000c2ff40] do_syscall_64 at ffffffff81ab418e
#19 [ffffc90000c2ff50] entry_SYSCALL_64_after_hwframe at ffffffff81c0006a
    RIP: 00007f14bdcacc74  RSP: 00007ffcee806498  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f14bdcacc74
    RDX: 0000000000100000  RSI: 00007f14bdaa0000  RDI: 0000000000000001
    RBP: 00007ffcee8064c0   R8: 0000000000000001   R9: 00007ffcee8a8080
    R10: 0000000000000017  R11: 0000000000000202  R12: 0000000000100000
    R13: 00007f14bdaa0000  R14: 0000000000000000  R15: 0000000000100000
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

PID: 1914     TASK: ffff8881015e6740  CPU: 1    COMMAND: "kworker/1:2"
 #0 [ffffc90000d5fa58] __schedule at ffffffff81ac18ac
 #1 [ffffc90000d5fab8] schedule at ffffffff81ac1d82
 #2 [ffffc90000d5fad0] schedule_timeout at ffffffff81ac64e9
 #3 [ffffc90000d5fb18] io_schedule_timeout at ffffffff81ac15e7
 #4 [ffffc90000d5fb30] __wait_for_common at ffffffff81ac2723
 #5 [ffffc90000d5fb98] sync_io at ffffffff817f695d
 #6 [ffffc90000d5fc00] dm_io at ffffffff817f6b22
 #7 [ffffc90000d5fc80] chunk_io at ffffffff81808950
 #8 [ffffc90000d5fd38] persistent_commit_exception at ffffffff81808caa
 #9 [ffffc90000d5fd50] copy_callback at ffffffff8180601a
#10 [ffffc90000d5fd80] run_complete_job at ffffffff817f78ff
#11 [ffffc90000d5fdc8] process_jobs at ffffffff817f7c5e
#12 [ffffc90000d5fe10] do_work at ffffffff817f7eb7
#13 [ffffc90000d5fe68] process_one_work at ffffffff81147b69
#14 [ffffc90000d5fea8] worker_thread at ffffffff81148554
#15 [ffffc90000d5fef8] kthread at ffffffff8114f8ee
#16 [ffffc90000d5ff30] ret_from_fork at ffffffff8108bb98
#17 [ffffc90000d5ff50] ret_from_fork_asm at ffffffff81000da1
crash> ps -m | grep md
[0 00:00:00.129] [IN]  PID: 965      TASK: ffff88810b8de740  CPU: 4    COMMAND: "systemd-oomd"
[0 00:00:01.187] [RU]  PID: 875      TASK: ffff888108bee740  CPU: 3    COMMAND: "md0_raid5"
[0 00:00:07.128] [IN]  PID: 707      TASK: ffff88810cc31d80  CPU: 1    COMMAND: "systemd-journal"
[0 00:00:07.524] [IN]  PID: 1007     TASK: ffff88810b8dc9c0  CPU: 4    COMMAND: "systemd-logind"
[0 00:00:07.524] [IN]  PID: 1981     TASK: ffff88810521bb00  CPU: 5    COMMAND: "systemd-hostnam"
[0 00:00:07.524] [IN]  PID: 1        TASK: ffff888100158000  CPU: 0    COMMAND: "systemd"
[0 00:00:07.824] [IN]  PID: 1971     TASK: ffff88810521ac40  CPU: 2    COMMAND: "systemd-userwor"
[0 00:00:07.825] [IN]  PID: 1006     TASK: ffff8881045a0ec0  CPU: 4    COMMAND: "systemd-homed"
[0 00:00:07.830] [IN]  PID: 1970     TASK: ffff888105218000  CPU: 1    COMMAND: "systemd-userwor"
[0 00:00:10.916] [IN]  PID: 1972     TASK: ffff888105218ec0  CPU: 1    COMMAND: "systemd-userwor"
[0 00:00:36.004] [IN]  PID: 971      TASK: ffff8881089c2c40  CPU: 0    COMMAND: "systemd-userdbd"
[0 00:10:56.905] [IN]  PID: 966      TASK: ffff888105546740  CPU: 4    COMMAND: "systemd-resolve"
[0 00:15:56.187] [UN]  PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
[0 00:34:52.328] [IN]  PID: 1669     TASK: ffff88810521c9c0  CPU: 2    COMMAND: "systemd"
[0 00:39:21.349] [IN]  PID: 739      TASK: ffff8881089c5880  CPU: 3    COMMAND: "systemd-udevd"
[0 00:40:59.426] [ID]  PID: 74       TASK: ffff888100a68000  CPU: 6    COMMAND: "kworker/R-md"
[0 00:40:59.427] [ID]  PID: 75       TASK: ffff888100a68ec0  CPU: 7    COMMAND: "kworker/R-md_bi"
[0 00:40:59.556] [IN]  PID: 66       TASK: ffff8881003e8000  CPU: 4    COMMAND: "ksmd"
crash> bt 875
PID: 875      TASK: ffff888108bee740  CPU: 3    COMMAND: "md0_raid5"
 #0 [fffffe00000bee60] crash_nmi_callback at ffffffff810a351e
 #1 [fffffe00000bee68] nmi_handle at ffffffff81085acb
 #2 [fffffe00000beea8] default_do_nmi at ffffffff81ab59d2
 #3 [fffffe00000beed0] exc_nmi at ffffffff81ab5c9c
 #4 [fffffe00000beef0] end_repeat_nmi at ffffffff81c010f7
    [exception RIP: ops_run_io+224]
    RIP: ffffffff817c4740  RSP: ffffc90000b3fb58  RFLAGS: 00000206
    RAX: 0000000000000220  RBX: 0000000000000003  RCX: ffff88810cee7098
    RDX: ffff88812495a3d0  RSI: 0000000000000000  RDI: ffff88810cee7000
    RBP: ffff888103884000   R8: 0000000000000000   R9: ffff888103884000
    R10: 0000000000000000  R11: 0000000000000000  R12: 0000000000000000
    R13: 0000000000000003  R14: ffff88812495a1b0  R15: ffffc90000b3fc00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffffc90000b3fb58] ops_run_io at ffffffff817c4740
 #6 [ffffc90000b3fc40] handle_stripe at ffffffff817cd85d
 #7 [ffffc90000b3fd40] handle_active_stripes at ffffffff817ce82c
 #8 [ffffc90000b3fdd0] raid5d at ffffffff817cee88
 #9 [ffffc90000b3fe98] md_thread at ffffffff817db1ef
#10 [ffffc90000b3fef8] kthread at ffffffff8114f8ee
#11 [ffffc90000b3ff30] ret_from_fork at ffffffff8108bb98
#12 [ffffc90000b3ff50] ret_from_fork_asm at ffffffff81000da1
crash> bt 876
PID: 876      TASK: ffff888108bebb00  CPU: 3    COMMAND: "md0_reclaim"
 #0 [ffffc900008c3d10] __schedule at ffffffff81ac18ac
 #1 [ffffc900008c3d70] schedule at ffffffff81ac1d82
 #2 [ffffc900008c3d88] md_super_wait at ffffffff817df27a
 #3 [ffffc900008c3dd0] md_update_sb at ffffffff817df609
 #4 [ffffc900008c3e20] r5l_do_reclaim at ffffffff817d1cf4
 #5 [ffffc900008c3e98] md_thread at ffffffff817db1ef
 #6 [ffffc900008c3ef8] kthread at ffffffff8114f8ee
 #7 [ffffc900008c3f30] ret_from_fork at ffffffff8108bb98
 #8 [ffffc900008c3f50] ret_from_fork_asm at ffffffff81000da1
crash> bt 74
PID: 74       TASK: ffff888100a68000  CPU: 6    COMMAND: "kworker/R-md"
 #0 [ffffc900002afdf8] __schedule at ffffffff81ac18ac
 #1 [ffffc900002afe58] schedule at ffffffff81ac1d82
 #2 [ffffc900002afe70] rescuer_thread at ffffffff81148138
 #3 [ffffc900002afef8] kthread at ffffffff8114f8ee
 #4 [ffffc900002aff30] ret_from_fork at ffffffff8108bb98
 #5 [ffffc900002aff50] ret_from_fork_asm at ffffffff81000da1
crash> bt 75
PID: 75       TASK: ffff888100a68ec0  CPU: 7    COMMAND: "kworker/R-md_bi"
 #0 [ffffc900002b7df8] __schedule at ffffffff81ac18ac
 #1 [ffffc900002b7e58] schedule at ffffffff81ac1d82
 #2 [ffffc900002b7e70] rescuer_thread at ffffffff81148138
 #3 [ffffc900002b7ef8] kthread at ffffffff8114f8ee
 #4 [ffffc900002b7f30] ret_from_fork at ffffffff8108bb98
 #5 [ffffc900002b7f50] ret_from_fork_asm at ffffffff81000da1
crash> 

