Return-Path: <linux-kernel+bounces-155469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48978AEAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF34FB20E85
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D6513BC12;
	Tue, 23 Apr 2024 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EBqF+kc4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A07F499
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885844; cv=none; b=TY9oia01IlHPThB15Nor2erpmIhfzHuIQC6juIZ4kio5G0gKQPVwlLUgRILi3ujmr9VLZRAs1BmcP993esp15lGmqG3sM+V48IXkJtxrLlhEGPkdRG0JmNXwJ0sAxTYgjjorCnXNkwkt0lQlkefpzPiXNlhapbVvsX2tDQa0j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885844; c=relaxed/simple;
	bh=/YS1aQiZhFoK5hVL5dNHY0TqYGPZsc9KXWaLUnNbAns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abMMMYl8TnOu32bAiH84e6pSapyXuy/vjqOTSCbb9080fVPY3uwX0eYCppSeALSTuETjYonDaHej5ZnnSN7AJFh6YB8dY4/wzlOECXdT7UvOgV+X2kHbuVQlq6shX133W1M/xLWAwgV4FvDJ6S8HdkBwlm+1MftH08W8kI9Ui58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EBqF+kc4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NCtuQc007734;
	Tue, 23 Apr 2024 15:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=btCOHGVbX3WpwO47LEFHurN/5CoSIX5DW14sPl24u1o=;
 b=EBqF+kc4jBBR9wBiN7Q5GAQtaGHUCU9oZHOoULxvs6IRlTaBVOTo24n2TE3wIrjZ6fkH
 YE6kvs+RHkr2HdBPi2GxZX/iu8r32hNHr17qwdCHDw8uxNRVsCMfUwnfrVf+FCpBDui3
 X6G9wpzgzR/4uZ1Kyh46JEe6t2xxYc7r+YP6l/1MHjlnehZBYcfwNqFQYJEMCLCnRx+0
 8OCSRPUw1BMopMBlYO59kyYoAMfVuf3bpM0HkdvbtMYi4YKXfP5raAWx1vOfNJT5XsWk
 zhYsGpcCMX1PdS8MPE0I7jgbUBycZvIMqErZs7BAKz74AKv/69JqWILoH+gFRD4NY+e4 Ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpb8drm30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 15:22:24 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NFJHek028705;
	Tue, 23 Apr 2024 15:22:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpb8drm2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 15:22:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43NClW8O005373;
	Tue, 23 Apr 2024 15:22:22 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cd2pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 15:22:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43NFMJKb16253528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 15:22:21 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC97C58070;
	Tue, 23 Apr 2024 15:22:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB2A5805D;
	Tue, 23 Apr 2024 15:22:00 +0000 (GMT)
Received: from [9.79.187.53] (unknown [9.79.187.53])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Apr 2024 15:22:00 +0000 (GMT)
Message-ID: <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
Date: Tue, 23 Apr 2024 20:51:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
To: Ankur Arora <ankur.a.arora@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
        mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
        jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
        mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
        glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
        mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gFkARTGPgLC2dIjPeP873b21zEnOLzYb
X-Proofpoint-GUID: FZ6yZk0J3yfNAXKpXCWU5yHkJBeh8e47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 mlxlogscore=591 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404230036



On 2/13/24 11:25 AM, Ankur Arora wrote:
> Hi,
> 
> This series adds a new scheduling model PREEMPT_AUTO, which like
> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
> on explicit preemption points for the voluntary models.
> 
> The series is based on Thomas' original proposal which he outlined
> in [1], [2] and in his PoC [3].
> 
> An earlier RFC version is at [4].
> 

Hi Ankur/Thomas. 

Thank you for this series and previous ones. 
These are very interesting patch series and the even more interesting 
discussions. I have been trying go through to get different bits of it. 


Tried this patch on PowerPC by defining LAZY similar to x86. The change is below. 
Kept it at PREEMPT=none for PREEMPT_AUTO. 

Running into soft lockup on large systems (40Cores, SMT8) and seeing close to 100%
regression on small system ( 12 Cores, SMT8). More details are after the patch. 

Are these the only arch bits that need to be defined? am I missing something very 
basic here? will try to debug this further. Any inputs?

---
 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/include/asm/thread_info.h | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..11e7008f5dd3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -268,6 +268,7 @@ config PPC
 	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_AUTO
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 15c5691dd218..c28780443b3b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -117,11 +117,13 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
+#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
+#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_32BIT		(1<<TIF_32BIT)
@@ -144,7 +146,7 @@ void arch_setup_new_exec(void);
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
 				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
-				 _TIF_NOTIFY_SIGNAL)
+				 _TIF_NOTIFY_SIGNAL | _TIF_NEED_RESCHED_LAZY)
 #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
 
 /* Bits in local_flags */

---------------- Smaller system ---------------------------------

NUMA:                     
  NUMA node(s):           5
  NUMA node2 CPU(s):      0-7
  NUMA node3 CPU(s):      8-31
  NUMA node5 CPU(s):      32-39
  NUMA node6 CPU(s):      40-47
  NUMA node7 CPU(s):      48-95

Hackbench 			6.9		+preempt_auto (=none)
(10 iterations, 10000 loops)

Process 10 groups          :       3.00,       3.07(  -2.33)
Process 20 groups          :       5.47,       5.81(  -6.22)
Process 30 groups          :       7.78,       8.52(  -9.51)
Process 40 groups          :      10.16,      11.28( -11.02)
Process 50 groups          :      12.37,      13.90( -12.37)
Process 60 groups          :      14.58,      16.68( -14.40)
Thread  10 groups          :       3.24,       3.28(  -1.23)
Thread  20 groups          :       5.93,       6.16(  -3.88)
Process(Pipe) 10 groups    :       1.94,       2.96( -52.58)
Process(Pipe) 20 groups    :       2.91,       5.44( -86.94)
Process(Pipe) 30 groups    :       4.23,       7.83( -85.11)
Process(Pipe) 40 groups    :       5.35,      10.61( -98.32)
Process(Pipe) 50 groups    :       6.64,      13.18( -98.49)
Process(Pipe) 60 groups    :       7.88,      16.69(-111.80)
Thread(Pipe)  10 groups    :       1.92,       3.02( -57.29)
Thread(Pipe)  20 groups    :       3.25,       5.36( -64.92)

------------------- Large systems -------------------------

NUMA:                     
  NUMA node(s):           4
  NUMA node2 CPU(s):      0-31
  NUMA node3 CPU(s):      32-127
  NUMA node6 CPU(s):      128-223
  NUMA node7 CPU(s):      224-319


watchdog: BUG: soft lockup - CPU#278 stuck for 26s! [hackbench:7137]
Modules linked in: bonding tls rfkill nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink pseries_rng vmx_crypto drm drm_panel_orientation_quirks xfs libcrc32c sd_mod t10_pi sg ibmvscsi ibmveth scsi_transport_srp pseries_wdt dm_mirror dm_region_hash dm_log dm_mod fuse
CPU: 278 PID: 7137 Comm: hackbench Kdump: loaded Tainted: G             L     6.9.0-rc1+ #42
Hardware name: IBM,9043-MRX POWER10 (raw) 0x800200 0xf000006 of:IBM,FW1050.00 (NM1050_052) hv:phyp pSeries
NIP:  c000000000037fbc LR: c000000000038324 CTR: c0000000001a8548
REGS: c0000003de72fbb8 TRAP: 0900   Tainted: G             L      (6.9.0-rc1+)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28002222  XER: 20040000
CFAR: 0000000000000000 IRQMASK: 0
GPR00: c000000000038324 c0000003de72fb90 c000000001973e00 c0000003de72fb88
GPR04: 0000000000240080 0000000000000007 0010000000000000 c000000002220090
GPR08: 4000000000000002 0000000000000049 c0000003f1dcff00 0000000000002000
GPR12: c0000000001a8548 c000001fff72d080 0000000000000000 0000000000000000
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000002002000
GPR24: 0000000000000001 0000000000000000 0000000002802000 0000000000000002
GPR28: 0000000000000003 fcffffffffffffff fcffffffffffffff c0000003f1dcff00
NIP [c000000000037fbc] __replay_soft_interrupts+0x3c/0x154
LR [c000000000038324] arch_local_irq_restore.part.0+0x1cc/0x214
Call Trace:
[c0000003de72fb90] [c000000000038020] __replay_soft_interrupts+0xa0/0x154 (unreliable)
[c0000003de72fd40] [c000000000038324] arch_local_irq_restore.part.0+0x1cc/0x214
[c0000003de72fd90] [c000000000030268] interrupt_exit_user_prepare_main+0x19c/0x274
[c0000003de72fe00] [c0000000000304e0] syscall_exit_prepare+0x1a0/0x1c8
[c0000003de72fe50] [c00000000000cee8] system_call_vectored_common+0x168/0x2ec


+mpe, nick

