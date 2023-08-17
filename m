Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0577F82C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351617AbjHQN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351615AbjHQN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 09:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1882724
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 06:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C4A6171D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 13:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDEFC433C8;
        Thu, 17 Aug 2023 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692280648;
        bh=nSes0Dxev2jKmjVyiJqfqnryQSbSiuaD2CDjuZi1QKQ=;
        h=Date:From:To:Cc:Subject:From;
        b=WmJSgkbiQXvd9l0Soa43CJ92DPn+GulYQk2jNBxYs/fRBSSt6ckWGx8Jr16cDaG11
         43JI3LoMStQUk3ShtbOAJPADgI7nLt6fH3G+lHnpx34ZacZbL6bevzLbY3QqtIauhD
         OW6NNPQzC4t4MavlJHVeN0ysR7INo4uJJyXqFhvVnvm8eQmtkV7Oq+MgqWYn7Alms+
         1Tez08RDkCTz8KL4dfwi9JqeeFkmMGajy7XqZU5x6C7FgFpB/NeLhA2w/GFlARTyHT
         aCw1GZZcMKcBEBBDOXS2frdRHTcN7J/CFC7IDTLNhtIO0740TAN4GlB+XDaMKdvwEe
         ca+uPTNJus89A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FA28404DF; Thu, 17 Aug 2023 10:57:25 -0300 (-03)
Date:   Thu, 17 Aug 2023 10:57:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RFE: perf lock contention --bpf on an RT kernel
Message-ID: <ZN4nRfquIsQLx1lV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung, I noticed this when trying to use the BPF mode of perf lock
contention on an RT kernel:

[root@nine perf-tools-next]# perf lock contention -ba
libbpf: prog 'contention_begin': BPF program load failed: Invalid argument
libbpf: prog 'contention_begin': -- BEGIN PROG LOAD LOG --
R1 type=ctx expected=fp
0: R1=ctx(off=0,imm=0) R10=fp0
; int contention_begin(u64 *ctx)
0: (bf) r7 = r1                       ; R1=ctx(off=0,imm=0) R7_w=ctx(off=0,imm=0)
; if (!enabled || !can_record(ctx))
1: (18) r1 = 0xffffc077c0322000       ; R1_w=map_value(off=0,ks=4,vs=60,imm=0)
3: (61) r1 = *(u32 *)(r1 +0)          ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (!enabled || !can_record(ctx))
4: (15) if r1 == 0x0 goto pc+209      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (has_cpu) {
5: (18) r1 = 0xffffc077c0322028       ; R1_w=map_value(off=40,ks=4,vs=60,imm=0)
7: (61) r1 = *(u32 *)(r1 +0)          ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (has_cpu) {
8: (15) if r1 == 0x0 goto pc+8        ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; __u32 cpu = bpf_get_smp_processor_id();
9: (85) call bpf_get_smp_processor_id#8       ; R0=scalar()
; __u32 cpu = bpf_get_smp_processor_id();
10: (63) *(u32 *)(r10 -32) = r0       ; R0=scalar() R10=fp0 fp-32=????mmmm
11: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; __u32 cpu = bpf_get_smp_processor_id();
12: (07) r2 += -32                    ; R2_w=fp-32
; ok = bpf_map_lookup_elem(&cpu_filter, &cpu);
13: (18) r1 = 0xffff9f260667b800      ; R1_w=map_ptr(off=0,ks=4,vs=1,imm=0)
15: (85) call bpf_map_lookup_elem#1   ; R0_w=map_value_or_null(id=1,off=0,ks=4,vs=1,imm=0)
16: (15) if r0 == 0x0 goto pc+197     ; R0_w=map_value(off=0,ks=4,vs=1,imm=0)
; if (has_task) {
17: (18) r1 = 0xffffc077c032202c      ; R1_w=map_value(off=44,ks=4,vs=60,imm=0)
19: (61) r1 = *(u32 *)(r1 +0)         ; R1=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (has_task) {
20: (15) if r1 == 0x0 goto pc+8       ; R1=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; __u32 pid = bpf_get_current_pid_tgid();
21: (85) call bpf_get_current_pid_tgid#14     ; R0_w=scalar()
; __u32 pid = bpf_get_current_pid_tgid();
22: (63) *(u32 *)(r10 -32) = r0       ; R0_w=scalar() R10=fp0 fp-32=????mmmm
23: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; __u32 pid = bpf_get_current_pid_tgid();
24: (07) r2 += -32                    ; R2_w=fp-32
; ok = bpf_map_lookup_elem(&task_filter, &pid);
25: (18) r1 = 0xffff9f260667b400      ; R1_w=map_ptr(off=0,ks=4,vs=1,imm=0)
27: (85) call bpf_map_lookup_elem#1   ; R0_w=map_value_or_null(id=2,off=0,ks=4,vs=1,imm=0)
28: (15) if r0 == 0x0 goto pc+185     ; R0_w=map_value(off=0,ks=4,vs=1,imm=0)
; if (has_type) {
29: (18) r1 = 0xffffc077c0322030      ; R1_w=map_value(off=48,ks=4,vs=60,imm=0)
31: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (has_type) {
32: (15) if r1 == 0x0 goto pc+8       ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; __u32 flags = (__u32)ctx[1];
33: (79) r1 = *(u64 *)(r7 +8)         ; R1_w=scalar() R7=ctx(off=0,imm=0)
; __u32 flags = (__u32)ctx[1];
34: (63) *(u32 *)(r10 -32) = r1       ; R1_w=scalar() R10=fp0 fp-32=????mmmm
35: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; __u32 flags = (__u32)ctx[1];
36: (07) r2 += -32                    ; R2_w=fp-32
; ok = bpf_map_lookup_elem(&type_filter, &flags);
37: (18) r1 = 0xffff9f260667b000      ; R1_w=map_ptr(off=0,ks=4,vs=1,imm=0)
39: (85) call bpf_map_lookup_elem#1   ; R0=map_value_or_null(id=3,off=0,ks=4,vs=1,imm=0)
40: (15) if r0 == 0x0 goto pc+173     ; R0=map_value(off=0,ks=4,vs=1,imm=0)
; if (has_addr) {
41: (18) r1 = 0xffffc077c0322034      ; R1_w=map_value(off=52,ks=4,vs=60,imm=0)
43: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (has_addr) {
44: (15) if r1 == 0x0 goto pc+8       ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; __u64 addr = ctx[0];
45: (79) r1 = *(u64 *)(r7 +0)         ; R1_w=scalar() R7=ctx(off=0,imm=0)
; __u64 addr = ctx[0];
46: (7b) *(u64 *)(r10 -32) = r1       ; R1_w=scalar() R10=fp0 fp-32_w=mmmmmmmm
47: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; __u64 addr = ctx[0];
48: (07) r2 += -32                    ; R2_w=fp-32
; ok = bpf_map_lookup_elem(&addr_filter, &addr);
49: (18) r1 = 0xffff9f260667f400      ; R1_w=map_ptr(off=0,ks=8,vs=1,imm=0)
51: (85) call bpf_map_lookup_elem#1   ; R0=map_value_or_null(id=4,off=0,ks=8,vs=1,imm=0)
; if (!enabled || !can_record(ctx))
52: (15) if r0 == 0x0 goto pc+161     ; R0=map_value(off=0,ks=8,vs=1,imm=0)
; pid = bpf_get_current_pid_tgid();
53: (85) call bpf_get_current_pid_tgid#14     ; R0_w=scalar()
; pid = bpf_get_current_pid_tgid();
54: (63) *(u32 *)(r10 -8) = r0        ; R0_w=scalar() R10=fp0 fp-8=????mmmm
55: (bf) r2 = r10                     ; R2_w=fp0 R10=fp0
; pid = bpf_get_current_pid_tgid();
56: (07) r2 += -8                     ; R2_w=fp-8
; pelem = bpf_map_lookup_elem(&tstamp, &pid);
57: (18) r1 = 0xffff9f260667a800      ; R1_w=map_ptr(off=0,ks=4,vs=24,imm=0)
59: (85) call bpf_map_lookup_elem#1   ; R0_w=map_value_or_null(id=5,off=0,ks=4,vs=24,imm=0)
60: (bf) r6 = r0                      ; R0=map_value_or_null(id=5,off=0,ks=4,vs=24,imm=0) R6=map_value_or_null(id=5,off=0,ks=4,vs=24,imm=0)
; if (pelem && pelem->lock)
61: (15) if r6 == 0x0 goto pc+32      ; R6=map_value(off=0,ks=4,vs=24,imm=0)
; if (pelem && pelem->lock)
62: (79) r1 = *(u64 *)(r6 +8)         ; R1_w=scalar() R6=map_value(off=0,ks=4,vs=24,imm=0)
; if (pelem && pelem->lock)
63: (15) if r1 == 0x0 goto pc+1 65: R0=map_value(off=0,ks=4,vs=24,imm=0) R1_w=0 R6=map_value(off=0,ks=4,vs=24,imm=0) R7=ctx(off=0,imm=0) R10=fp0 fp-8=????mmmm fp-32=mmmmmmmm
; pelem->timestamp = bpf_ktime_get_ns();
65: (85) call bpf_ktime_get_ns#5      ; R0_w=scalar()
; pelem->timestamp = bpf_ktime_get_ns();
66: (7b) *(u64 *)(r6 +0) = r0         ; R0_w=scalar() R6=map_value(off=0,ks=4,vs=24,imm=0)
; pelem->lock = (__u64)ctx[0];
67: (79) r3 = *(u64 *)(r7 +0)         ; R3_w=scalar() R7=ctx(off=0,imm=0)
; pelem->lock = (__u64)ctx[0];
68: (7b) *(u64 *)(r6 +8) = r3         ; R3_w=scalar() R6=map_value(off=0,ks=4,vs=24,imm=0)
; pelem->flags = (__u32)ctx[1];
69: (79) r1 = *(u64 *)(r7 +8)         ; R1_w=scalar() R7=ctx(off=0,imm=0)
; pelem->flags = (__u32)ctx[1];
70: (63) *(u32 *)(r6 +16) = r1        ; R1_w=scalar() R6=map_value(off=0,ks=4,vs=24,imm=0)
; if (needs_callstack) {
71: (18) r2 = 0xffffc077c0322008      ; R2_w=map_value(off=8,ks=4,vs=60,imm=0)
73: (61) r2 = *(u32 *)(r2 +0)         ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (needs_callstack) {
74: (15) if r2 == 0x0 goto pc+43 118: R0=scalar() R1=scalar() R2=0 R3=scalar() R6=map_value(off=0,ks=4,vs=24,imm=0) R7=ctx(off=0,imm=0) R10=fp0 fp-8=????mmmm fp-32=mmmmmmmm
; } else if (aggr_mode == LOCK_AGGR_TASK) {
118: (18) r2 = 0xffffc077c0322014     ; R2_w=map_value(off=20,ks=4,vs=60,imm=0)
120: (61) r2 = *(u32 *)(r2 +0)        ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; } else if (aggr_mode == LOCK_AGGR_TASK) {
121: (55) if r2 != 0x1 goto pc+92     ; R2_w=1
; if (lock_owner) {
122: (18) r2 = 0xffffc077c0322018     ; R2_w=map_value(off=24,ks=4,vs=60,imm=0)
124: (61) r2 = *(u32 *)(r2 +0)        ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (lock_owner) {
125: (15) if r2 == 0x0 goto pc+34     ; R2=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
; if (flags & LCB_F_MUTEX) {
126: (bf) r2 = r1                     ; R1=scalar(id=6) R2_w=scalar(id=6)
127: (57) r2 &= 32                    ; R2_w=scalar(umax=32,var_off=(0x0; 0x20))
; if (flags & LCB_F_MUTEX) {
128: (15) if r2 == 0x0 goto pc+2      ; R2_w=scalar(umax=32,var_off=(0x0; 0x20))
129: <invalid CO-RE relocation>
failed to resolve CO-RE relocation <byte_off> [47] struct mutex.owner.counter (0:0:0 @ offset 0)
processed 95 insns (limit 1000000) max_states_per_insn 0 total_states 10 peak_states 10 mark_read 4
-- END PROG LOAD LOG --
libbpf: prog 'contention_begin': failed to load: -22
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -22
Failed to load lock-contention BPF skeleton
lock contention BPF setup failed
[root@nine perf-tools-next]# uname -r
5.14.0-284.18.1.rt14.303.el9_2.x86_64
[root@nine perf-tools-next]# pahole mutex
struct mutex {
	struct rt_mutex_base       rtmutex;              /*     0    32 */

	/* size: 32, cachelines: 1, members: 1 */
	/* last cacheline: 32 bytes */
};
[root@nine perf-tools-next]# pahole -E mutex
struct mutex {
	struct rt_mutex_base {
		/* typedef raw_spinlock_t */ struct raw_spinlock {
			/* typedef arch_spinlock_t */ struct qspinlock {
				union {
					/* typedef atomic_t */ struct {
						int            counter;                  /*     0     4 */
					} val; /*     0     4 */
					struct {
						/* typedef u8 -> __u8 */ unsigned char  locked; /*     0     1 */
						/* typedef u8 -> __u8 */ unsigned char  pending; /*     1     1 */
					};                                               /*     0     2 */
					struct {
						/* typedef u16 -> __u16 */ short unsigned int locked_pending; /*     0     2 */
						/* typedef u16 -> __u16 */ short unsigned int tail; /*     2     2 */
					};                                               /*     0     4 */
				};                                                       /*     0     4 */
			} raw_lock; /*     0     4 */
		} wait_lock; /*     0     4 */

		/* XXX 4 bytes hole, try to pack */

		struct rb_root_cached {
			struct rb_root {
				struct rb_node * rb_node;                                /*     8     8 */
			}rb_root; /*     8     8 */
			struct rb_node * rb_leftmost;                                    /*    16     8 */
		}waiters; /*     8    16 */
		struct task_struct * owner;                                              /*    24     8 */
	}rtmutex; /*     0    32 */

	/* size: 32, cachelines: 1, members: 1 */
	/* last cacheline: 32 bytes */
};
[root@nine perf-tools-next]# uname -r
5.14.0-284.18.1.rt14.303.el9_2.x86_64
[root@nine perf-tools-next]#

So we need some extra logic to get at the mutex owner...

[root@nine perf-tools-next]# ls -la /sys/kernel/debug/tracing/events/lock/
contention_begin/ contention_end/   enable            filter
[root@nine perf-tools-next]# ls -la /sys/kernel/debug/tracing/events/lock/
total 0
drwxr-xr-x.   4 root root 0 Aug 17 08:44 .
drwxr-xr-x. 114 root root 0 Aug 17 08:45 ..
drwxr-xr-x.   2 root root 0 Aug 17 08:44 contention_begin
drwxr-xr-x.   2 root root 0 Aug 17 08:44 contention_end
-rw-r-----.   1 root root 0 Aug 17 08:44 enable
-rw-r-----.   1 root root 0 Aug 17 08:44 filter
[root@nine perf-tools-next]#

I tried up to now the following patch, it loads, but produces no output
:-\

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 8d3cfbb3cc65..8b65391401a5 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -100,6 +100,18 @@ struct rw_semaphore___new {
 	atomic_long_t owner;
 } __attribute__((preserve_access_index));
 
+struct rw_semaphore___rt {
+	struct rwbase_rt { 
+		struct rt_mutex_base { 
+			struct task_struct *owner;
+		} rtmutex;
+	} rwbase;
+} __attribute__((preserve_access_index));
+
+struct mutex___rt {
+	struct rt_mutex_base rtmutex;
+} __attribute__((preserve_access_index));
+
 struct mm_struct___old {
 	struct rw_semaphore mmap_sem;
 } __attribute__((preserve_access_index));
@@ -202,8 +214,19 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
 	__u64 owner = 0;
 
 	if (flags & LCB_F_MUTEX) {
+#if __has_builtin(__builtin_preserve_type_info) && __clang_major__ >= 15
+		if (bpf_core_type_matches(struct mutex___rt)) {
+			struct mutex___rt *mutex = (void *)lock;
+			owner = (unsigned long)BPF_CORE_READ(mutex, rtmutex.owner);
+		} else if (bpf_core_type_matches(struct mutex)) {
+			struct mutex *mutex = (void *)lock;
+			owner = BPF_CORE_READ(mutex, owner.counter);
+		}
+#else
+		/* assume non-RT struct */
 		struct mutex *mutex = (void *)lock;
 		owner = BPF_CORE_READ(mutex, owner.counter);
+#endif
 	} else if (flags == LCB_F_READ || flags == LCB_F_WRITE) {
 	/*
 	 * Support for the BPF_TYPE_MATCHES argument to the
@@ -218,6 +241,9 @@ static inline struct task_struct *get_lock_owner(__u64 lock, __u32 flags)
 		} else if (bpf_core_type_matches(struct rw_semaphore___new)) {
 			struct rw_semaphore___new *rwsem = (void *)lock;
 			owner = BPF_CORE_READ(rwsem, owner.counter);
+		} else if (bpf_core_type_matches(struct rw_semaphore___rt)) {
+			struct rw_semaphore___rt *rwsem = (void *)lock;
+			owner = (unsigned long)BPF_CORE_READ(rwsem, rwbase.rtmutex.owner);
 		}
 #else
 		/* assume new struct */
