Return-Path: <linux-kernel+bounces-144950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE8B8A4D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B2A284F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500415D464;
	Mon, 15 Apr 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="IodxvANz"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0360A5CDC9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178660; cv=none; b=nnZuoY49CpYumN8RzVDS0AdftTwcBGYLoPaVipKvdsVZqs1KPAM8HtuHqyhVQQ4hxZ/fasD0v8GewY5UaeouWVNjY0rMpnLGZn8GuKtgNr7MTFQRdN+xGa1qPGBfMBquC4IPzZZcrgsr2/rdp8dpcKS5GBiOt597Tk7elw4vpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178660; c=relaxed/simple;
	bh=KdKDpuaMb+Vr2Yb0WzKYjdetf4Bxfr/nSj7v7JRNGco=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUR1ZJnuEMKQlIChIuqmgTxVXf+uY9zV2rOVB9lLZP4I0/Fo3ln6qybfwmrwUnNoMNnVVl46XpEwoKfk4itk7hzEm0e/6MCFMQpzSX7lTypb6A+1aYLcF3Co6QlHLZTqjpgF5g4sy7rey+naQn7YCaaTTLMEv/aMUvHjihCXexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=IodxvANz; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1713178613; x=1713783413; i=efault@gmx.de;
	bh=fYEu0PXDe5iCtvbb4lMZN3Ff71BZAUMJCkMfWzxIDIs=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=IodxvANzSTKRjvmAn721Fb0t8ViHTNE92ti1zBMrtclVpUrDuDGZWMeknARbL/9a
	 xzhPfk3YHt9DAOFY7irIQu7bo33u6v31+08FGh5XftUzPQwPamd5btVK3rD0wGwSF
	 o+8gDebF9pChsbUwxYi+bnn1zYXWx0bEB+7cey2m91YBychJ4FS4EWYMOjjkSmjwb
	 0HysMXoS3o8+mUT+Y/QQvTnJjRBQETquBJqaaeO9b9tSnPLLyzpnFXvE5CjHy/2+N
	 JozdfWkDlPh9ghPDuxfjWerMT7JIApBCiHv+YzcqbGx+BA42oD+QwlwUsE16GhaUs
	 45gBgjruOEW36ayfhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.137]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWics-1sGFVF2zu4-00X3iG; Mon, 15
 Apr 2024 12:56:53 +0200
Message-ID: <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
From: Mike Galbraith <efault@gmx.de>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, mingo@redhat.com, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com,  linux-kernel@vger.kernel.org
Cc: wuyun.abel@bytedance.com, tglx@linutronix.de
Date: Mon, 15 Apr 2024 12:56:52 +0200
In-Reply-To: <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
References: <20240405102754.435410987@infradead.org>
	 <20240405110010.631664251@infradead.org>
	 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bUY7vz16zrz0qxVNDPbS1rWcjzkVmnlivroRSE56lICpXOEdszA
 IRSBJc86Ka9VJjhiTLaBJy2V+wu1fmfZdony6x2GvZ257gaIOd+aJYLw1QLpeU8BHjkAkQx
 x+MCnRnOaOLSw9L1BaEofRKJa3NAJVEvRkSj7xCAmlO11zl5Mz4aZhRtXiP8/4NKJubueCc
 zkUFx5xZKdWWA/4TM/vhA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SUONdpeXI5g=;fuDCqNOUpeCgk5dUwXG3KRDWhTw
 ewDgVlRiLpUL7H5+9xTH588akL3bUT1lAF4IwSvY9v2zq+unjxNbOrVk6VOWR7NHwObCL8sFw
 gWTIEg3561Z/QsdDYikX9UgHYzcSLpx8nP3ZdRZp8GRiT5t/Ry/UcNJKFRj2WQjMEk4++HCyj
 2e/tiwgoTeoOHEWOr9sO1j8J6sPEEgRYsCb0TSMfXq5s8f7Id50M8bh2k0NYUffaKt63Gq36a
 1XTPbhLxJmmSr3DgrrrONQcHZMnPBgUpKgMHC2kaH+wXZdh/UQi6Pqh1uIChAXmhjj3ZPq5fP
 8BvkYrrPpaMvGyODKBUg/z/xORO1xvf4huzl/YBUHIsOfO4MafCNlY8iHhNQ8hgC60mArFdjT
 Z1sxN+MRRdFcuXXIpakhmSIr9TzHmmLpc5WSlF8g9gm9Ss/+dlzqZs9XaAjQFIrElLwPpCthz
 thOje2uNCRD/g5yDI0xvV49qYvF4fXR399N7vsBjQOrM6HIHUZ7UkbxdmVkXa/dQ/WPCYZEIz
 +bUdFpxPkCrekpOx2ALqUnQaL9P/S380lrQD2e3D3Cz5ZFuOUaUrYNDKZevCwK7Shwd+Q6ijl
 C6KBvIp9Rbp4BuJ3/UvDA203KCsrgKOZrijDDAm0Jjd3Bu0L5uPjai4uh/JnVqqO/sWS0zmRL
 lK9gpAqQy2CdPtegKAZ1VGf3XnpuKGPe84UeJBFdSSb4awrANRNupDSuyjcCDs/2BiVGknlrK
 ECd9OYNcxneVrmB0p4hAiLC5MfwcnjOexIHpnveHiKNoAFMr2C2PPy1p6PZ8lUV+9xi6yaJPQ
 y2GfjRIB2/Bp7XNfhhf/L1HTso2f50wtXzWE5H/ez14Z8=

On Fri, 2024-04-12 at 16:12 +0530, K Prateek Nayak wrote:
>
> I ran into a few issues when testing the series on top of tip:sched/core
> at commit 4475cd8bfd9b ("sched/balancing: Simplify the sg_status bitmask
> and use separate ->overloaded and ->overutilized flags"). All of these
> splats surfaced when running unixbench with Delayed Dequeue (echoing
> NO_DELAY_DEQUEUE to /sys/kernel/debug/sched/features seems to make the
> system stable when running Unixbench spawn)
>
> Unixbench (https://github.com/kdlucas/byte-unixbench.git) command:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0./Run spawn -c 512

That plus a hackbench loop works a treat.

>
> Splats appear soon into the run. Following are the splats and their
> corresponding code blocks from my 3rd Generation EPYC system
> (2 x 64C/128T):

Seems a big box is not required. With a low fat sched config (no group
sched), starting ./Run spawn -c 16 (cpus*2) along with a hackbench loop
reliably blows my old i7-4790 box out of the water nearly instantly.

    DUMPFILE: vmcore
        CPUS: 8
        DATE: Mon Apr 15 07:20:29 CEST 2024
      UPTIME: 00:07:23
LOAD AVERAGE: 1632.20, 684.99, 291.84
       TASKS: 1401
    NODENAME: homer
     RELEASE: 6.9.0.g0bbac3f-master
     VERSION: #7 SMP Mon Apr 15 06:40:05 CEST 2024
     MACHINE: x86_64  (3591 Mhz)
      MEMORY: 16 GB
       PANIC: "Oops: 0000 [#1] SMP NOPTI" (check log for details)
         PID: 22664
     COMMAND: "hackbench"
        TASK: ffff888100acbf00  [THREAD_INFO: ffff888100acbf00]
         CPU: 5
       STATE: TASK_WAKING (PANIC)

crash> bt -sx
PID: 22664    TASK: ffff888100acbf00  CPU: 5    COMMAND: "hackbench"
 #0 [ffff88817cc17920] machine_kexec+0x156 at ffffffff810642d6
 #1 [ffff88817cc17970] __crash_kexec+0xd7 at ffffffff81153147
 #2 [ffff88817cc17a28] crash_kexec+0x23 at ffffffff811535f3
 #3 [ffff88817cc17a38] oops_end+0xbe at ffffffff810329be
 #4 [ffff88817cc17a58] page_fault_oops+0x81 at ffffffff81071951
 #5 [ffff88817cc17ab8] exc_page_fault+0x62 at ffffffff8194f6f2
 #6 [ffff88817cc17ae0] asm_exc_page_fault+0x22 at ffffffff81a00ba2
    [exception RIP: pick_task_fair+71]
    RIP: ffffffff810d5b57  RSP: ffff88817cc17b90  RFLAGS: 00010046
    RAX: 0000000000000000  RBX: ffff88840ed70ec0  RCX: 00000001d7ec138c
    RDX: ffffffffe7a7f400  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffff88840ed70ec0   R8: 0000000000000c00   R9: 000000675402f79e
    R10: ffff88817cc17b30  R11: 00000000000000bb  R12: ffff88840ed70f40
    R13: ffffffff81f64f16  R14: ffff888100acc560  R15: ffff888100acbf00
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff88817cc17bb0] pick_next_task_fair+0x42 at ffffffff810d92c2
 #8 [ffff88817cc17be0] __schedule+0x10d at ffffffff8195936d
 #9 [ffff88817cc17c50] schedule+0x1c at ffffffff81959ddc
#10 [ffff88817cc17c60] schedule_timeout+0x18c at ffffffff8195fc4c
#11 [ffff88817cc17cc8] unix_stream_read_generic+0x2b7 at ffffffff81869917
#12 [ffff88817cc17da8] unix_stream_recvmsg+0x68 at ffffffff8186a2d8
#13 [ffff88817cc17de0] sock_read_iter+0x159 at ffffffff8170bd69
#14 [ffff88817cc17e70] vfs_read+0x2ce at ffffffff812f195e
#15 [ffff88817cc17ef8] ksys_read+0x40 at ffffffff812f21d0
#16 [ffff88817cc17f30] do_syscall_64+0x57 at ffffffff8194b947
#17 [ffff88817cc17f50] entry_SYSCALL_64_after_hwframe+0x76 at ffffffff81a0=
012b
    RIP: 00007f625660871e  RSP: 00007ffc75d48188  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 00007ffc75d48200  RCX: 00007f625660871e
    RDX: 0000000000000064  RSI: 00007ffc75d48190  RDI: 0000000000000007
    RBP: 00007ffc75d48260   R8: 00007ffc75d48140   R9: 00007f6256612010
    R10: 00007f62565f5070  R11: 0000000000000246  R12: 0000000000000064
    R13: 0000000000000000  R14: 0000000000000064  R15: 0000000000000000
    ORIG_RAX: 0000000000000000  CS: 0033  SS: 002b
crash> dis pick_task_fair+71
0xffffffff810d5b57 <pick_task_fair+71>:	cmpb   $0x0,0x4c(%rax)
crash> gdb list *pick_task_fair+71
0xffffffff810d5b57 is in pick_task_fair (kernel/sched/fair.c:5498).
5493			SCHED_WARN_ON(cfs_rq->next->sched_delayed);
5494			return cfs_rq->next;
5495		}
5496
5497		struct sched_entity *se =3D pick_eevdf(cfs_rq);
5498		if (se->sched_delayed) {
5499			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
5500			SCHED_WARN_ON(se->sched_delayed);
5501			SCHED_WARN_ON(se->on_rq);
5502			if (sched_feat(DELAY_ZERO) && se->vlag > 0)
crash> struct -ox sched_entity
struct sched_entity {
    [0x0] struct load_weight load;
   [0x10] struct rb_node run_node;
   [0x28] u64 deadline;
   [0x30] u64 min_vruntime;
   [0x38] struct list_head group_node;
   [0x48] unsigned int on_rq;
   [0x4c] unsigned char sched_delayed;
   [0x4d] unsigned char custom_slice;
   [0x50] u64 exec_start;
   [0x58] u64 sum_exec_runtime;
   [0x60] u64 prev_sum_exec_runtime;
   [0x68] u64 vruntime;
   [0x70] s64 vlag;
   [0x78] u64 slice;
   [0x80] u64 nr_migrations;
   [0xc0] struct sched_avg avg;
}
SIZE: 0x100
crash>


