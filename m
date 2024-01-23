Return-Path: <linux-kernel+bounces-36201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F077839D72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BFC285E94
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0564754FBF;
	Tue, 23 Jan 2024 23:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="IOXX0aNp"
Received: from qs51p00im-qukt01071502.me.com (qs51p00im-qukt01071502.me.com [17.57.155.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE354735
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706054292; cv=none; b=ctu0Ti6ulVMPXX6R+oU4V5N1iOSG4FdA7VzXvD1C/F5uJ2L7ICwUJnLcpzS/p8zlhthKOxrgISfEpUBHxuF3Fe8jwq8wMW1nK3IwMqtqe/Tz/BKtp4NjLxUhL6GoGWtUN2zwxW3aYWQcnwx9tH7GefcWdAz16DCqRdSJLVCYIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706054292; c=relaxed/simple;
	bh=H38jex1aYmsUtIQlYpPTgAWpIXMstmnJyhH22qDz+w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FedUlvalu4T47SQ5Wf6ItgxLAR1YswttXdY8+3izlEnQYVaK6kemswpiqI7GyGQCTBAZ04s+PNXd5Fqe/qgJsNf41TTmBRhPDlwoI6d9iyH+SLG2g5XK8Mv46+UIM6SdAFfPzHDC8eXnrcEMytDMhkEdvbHb6BAz5EJpwEZFA6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=IOXX0aNp; arc=none smtp.client-ip=17.57.155.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1706054288; bh=KiivmQDLpUlMRkgdQE/5WmnZhu/bC1C8Ppx+owcGl3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=IOXX0aNppLkMmTPwb79TV1Y7h2vy/Iw80gRNMPTri1sKf+h4XaLweuZbxFQxg+Ism
	 w+dOtN9ngO1Hx15kUoDJYhjLmV0qhi+pWNGc9Vp2zhl38BIetslCQ1M4nWDWSQRDcu
	 aRbteMoD4smSZ1fmFXH2X87j06Z65gKNwqrE06qngSFkk+PgyMVebFgA0kJQi7jXCt
	 EI/xdToZ0Zf2AeEybE/4f47Dx3f1JZyRfM136vazG2PavY3h9DlVg+Pvchz9uPJkVf
	 Iu02zYW9pfYLuVsgRJMkqm5XloCWz65X09tnAADClr3U125GMLPRBK+KKa63mZxza5
	 199qgdbKftIEQ==
Received: from hitch.danm.net (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071502.me.com (Postfix) with ESMTPSA id EE496668075E;
	Tue, 23 Jan 2024 23:58:06 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: song@kernel.org
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	yukuai1@huaweicloud.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Tue, 23 Jan 2024 16:58:03 -0700
Message-ID: <20240123235803.8298-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
References: <CAPhsuW7KMLHHrcyZhKS_m_fwWSKM66VFXaLj9fmY+ab5Mu3pvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 1UPHBIEDOdXBBvZakdHiGn_raxQVb0jA
X-Proofpoint-GUID: 1UPHBIEDOdXBBvZakdHiGn_raxQVb0jA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_13,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2401230179

> This appears the md thread hit some infinite loop, so I would like to
> know what it is doing. We can probably get the information with the
> perf tool, something like:
>
> perf record -a
> perf report

Here you go!

# Total Lost Samples: 0
#
# Samples: 78K of event 'cycles'
# Event count (approx.): 83127675745
#
# Overhead  Command          Shared Object                   Symbol
# ........  ...............  ..............................  ...................................................
#
    49.31%  md0_raid5        [kernel.kallsyms]               [k] handle_stripe
    18.63%  md0_raid5        [kernel.kallsyms]               [k] ops_run_io
     6.07%  md0_raid5        [kernel.kallsyms]               [k] handle_active_stripes.isra.0
     5.50%  md0_raid5        [kernel.kallsyms]               [k] do_release_stripe
     3.09%  md0_raid5        [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
     2.48%  md0_raid5        [kernel.kallsyms]               [k] r5l_write_stripe
     1.89%  md0_raid5        [kernel.kallsyms]               [k] md_wakeup_thread
     1.45%  ksmd             [kernel.kallsyms]               [k] ksm_scan_thread
     1.37%  md0_raid5        [kernel.kallsyms]               [k] stripe_is_lowprio
     0.87%  ksmd             [kernel.kallsyms]               [k] memcmp
     0.68%  ksmd             [kernel.kallsyms]               [k] xxh64
     0.56%  md0_raid5        [kernel.kallsyms]               [k] __wake_up_common
     0.52%  md0_raid5        [kernel.kallsyms]               [k] __wake_up
     0.46%  ksmd             [kernel.kallsyms]               [k] mtree_load
     0.44%  ksmd             [kernel.kallsyms]               [k] try_grab_page
     0.40%  ksmd             [kernel.kallsyms]               [k] follow_p4d_mask.constprop.0
     0.39%  md0_raid5        [kernel.kallsyms]               [k] r5l_log_disk_error
     0.37%  md0_raid5        [kernel.kallsyms]               [k] _raw_spin_lock_irq
     0.33%  md0_raid5        [kernel.kallsyms]               [k] release_stripe_list
     0.31%  md0_raid5        [kernel.kallsyms]               [k] release_inactive_stripe_list
     0.31%  ksmd             [kernel.kallsyms]               [k] get_ksm_page
     0.30%  md0_raid5        [kernel.kallsyms]               [k] __cond_resched
     0.28%  md0_raid5        [kernel.kallsyms]               [k] mutex_unlock
     0.28%  ksmd             [kernel.kallsyms]               [k] _raw_spin_lock
     0.27%  swapper          [kernel.kallsyms]               [k] intel_idle
     0.26%  md0_raid5        [kernel.kallsyms]               [k] mutex_lock
     0.24%  md0_raid5        [kernel.kallsyms]               [k] rcu_all_qs
     0.22%  md0_raid5        [kernel.kallsyms]               [k] r5c_is_writeback
     0.20%  md0_raid5        [kernel.kallsyms]               [k] __lock_text_start
     0.18%  ksmd             [kernel.kallsyms]               [k] up_read
     0.18%  ksmd             [kernel.kallsyms]               [k] down_read
     0.17%  md0_raid5        [kernel.kallsyms]               [k] raid5d
     0.15%  ksmd             [kernel.kallsyms]               [k] follow_trans_huge_pmd
     0.13%  kworker/u16:3-e  [kernel.kallsyms]               [k] ioread32
     0.13%  kworker/u16:1-e  [kernel.kallsyms]               [k] ioread32
     0.12%  ksmd             [kernel.kallsyms]               [k] follow_page_pte
     0.11%  md0_raid5        [kernel.kallsyms]               [k] r5l_flush_stripe_to_raid
     0.11%  ksmd             [kernel.kallsyms]               [k] follow_page
     0.11%  ksmd             [kernel.kallsyms]               [k] memcmp_pages
     0.10%  swapper          [kernel.kallsyms]               [k] poll_idle
     0.08%  ksmd             [kernel.kallsyms]               [k] mtree_range_walk
     0.07%  ksmd             [kernel.kallsyms]               [k] __cond_resched
     0.07%  ksmd             [kernel.kallsyms]               [k] rcu_all_qs
     0.06%  ksmd             [kernel.kallsyms]               [k] __pte_offset_map_lock
     0.04%  ksmd             [kernel.kallsyms]               [k] __pte_offset_map
     0.03%  md0_raid5        [kernel.kallsyms]               [k] llist_reverse_order
     0.03%  md0_raid5        [kernel.kallsyms]               [k] r5l_write_stripe_run
     0.02%  swapper          [kernel.kallsyms]               [k] menu_select
     0.02%  ksmd             [kernel.kallsyms]               [k] rb_insert_color
     0.02%  ksmd             [kernel.kallsyms]               [k] vm_normal_page
     0.02%  swapper          [kernel.kallsyms]               [k] cpuidle_enter_state
     0.01%  md0_raid5        [kernel.kallsyms]               [k] r5l_submit_current_io
     0.01%  ksmd             [kernel.kallsyms]               [k] vma_is_secretmem
     0.01%  swapper          [kernel.kallsyms]               [k] alx_mask_msix
     0.01%  ksmd             [kernel.kallsyms]               [k] remove_rmap_item_from_tree
     0.01%  swapper          [kernel.kallsyms]               [k] lapic_next_deadline
     0.01%  swapper          [kernel.kallsyms]               [k] read_tsc
     0.01%  ksmd             [kernel.kallsyms]               [k] mas_walk
     0.01%  swapper          [kernel.kallsyms]               [k] do_idle
     0.01%  md0_raid5        [kernel.kallsyms]               [k] perf_adjust_freq_unthr_context
     0.01%  md0_raid5        [kernel.kallsyms]               [k] lapic_next_deadline
     0.01%  swapper          [kernel.kallsyms]               [k] perf_adjust_freq_unthr_context
     0.01%  swapper          [kernel.kallsyms]               [k] __switch_to_asm
     0.01%  swapper          [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
     0.01%  swapper          [kernel.kallsyms]               [k] native_irq_return_iret
     0.01%  swapper          [kernel.kallsyms]               [k] arch_scale_freq_tick
     0.01%  kworker/u16:3-e  [kernel.kallsyms]               [k] lapic_next_deadline
     0.00%  swapper          [kernel.kallsyms]               [k] __hrtimer_next_event_base
     0.00%  ksmd             [kernel.kallsyms]               [k] calc_checksum
     0.00%  swapper          [kernel.kallsyms]               [k] psi_group_change
     0.00%  swapper          [kernel.kallsyms]               [k] timerqueue_add
     0.00%  ksmd             [kernel.kallsyms]               [k] mas_find
     0.00%  swapper          [kernel.kallsyms]               [k] __schedule
     0.00%  swapper          [kernel.kallsyms]               [k] ioread32
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] _aesni_enc4
     0.00%  swapper          [kernel.kallsyms]               [k] rb_next
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] lapic_next_deadline
     0.00%  swapper          [kernel.kallsyms]               [k] ktime_get
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] psi_group_change
     0.00%  Qt bearer threa  [kernel.kallsyms]               [k] alx_update_hw_stats
     0.00%  swapper          [kernel.kallsyms]               [k] cpuidle_enter
     0.00%  swapper          [kernel.kallsyms]               [k] update_sd_lb_stats.constprop.0
     0.00%  swapper          [kernel.kallsyms]               [k] ct_kernel_exit_state
     0.00%  swapper          [kernel.kallsyms]               [k] nr_iowait_cpu
     0.00%  swapper          [kernel.kallsyms]               [k] sched_clock_noinstr
     0.00%  swapper          [kernel.kallsyms]               [k] psi_flags_change
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_stop_idle
     0.00%  swapper          [kernel.kallsyms]               [k] __run_timers.part.0
     0.00%  swapper          [kernel.kallsyms]               [k] native_apic_msr_eoi
     0.00%  swapper          [kernel.kallsyms]               [k] __update_load_avg_se
     0.00%  md0_raid5        [kernel.kallsyms]               [k] __intel_pmu_enable_all.isra.0
     0.00%  md0_raid5        [kernel.kallsyms]               [k] update_vsyscall
     0.00%  md0_raid5        [kernel.kallsyms]               [k] arch_scale_freq_tick
     0.00%  md0_raid5        [kernel.kallsyms]               [k] read_tsc
     0.00%  md0_raid5        [kernel.kallsyms]               [k] x86_pmu_disable
     0.00%  md0_raid5        [kernel.kallsyms]               [k] __update_load_avg_cfs_rq
     0.00%  swapper          [kernel.kallsyms]               [k] rcu_sched_clock_irq
     0.00%  perf             [kernel.kallsyms]               [k] rep_movs_alternative
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_active
     0.00%  swapper          [kernel.kallsyms]               [k] newidle_balance.isra.0
     0.00%  swapper          [kernel.kallsyms]               [k] _raw_spin_lock_irq
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] aesni_xts_encrypt
     0.00%  swapper          [kernel.kallsyms]               [k] enqueue_task_fair
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_idle_stop_tick
     0.00%  swapper          [kernel.kallsyms]               [k] leave_mm
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] sched_clock_noinstr
     0.00%  plasmashell      [kernel.kallsyms]               [k] ext4fs_dirhash
     0.00%  kwin_x11         [kernel.kallsyms]               [k] ioread32
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] ioread32
     0.00%  swapper          [kernel.kallsyms]               [k] memchr_inv
     0.00%  swapper          [kernel.kallsyms]               [k] pick_next_task_fair
     0.00%  swapper          [kernel.kallsyms]               [k] tick_sched_do_timer
     0.00%  swapper          [kernel.kallsyms]               [k] ktime_get_update_offsets_now
     0.00%  swapper          [kernel.kallsyms]               [k] __update_load_avg_cfs_rq
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] psi_group_change
     0.00%  swapper          [kernel.kallsyms]               [k] ct_kernel_exit.constprop.0
     0.00%  ksmd             [kernel.kallsyms]               [k] psi_task_switch
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_next_event
     0.00%  swapper          [kernel.kallsyms]               [k] clockevents_program_event
     0.00%  swapper          [kernel.kallsyms]               [k] __sysvec_apic_timer_interrupt
     0.00%  swapper          [kernel.kallsyms]               [k] enqueue_entity
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] schedule
     0.00%  swapper          [kernel.kallsyms]               [k] get_cpu_device
     0.00%  swapper          [kernel.kallsyms]               [k] scheduler_tick
     0.00%  swapper          [kernel.kallsyms]               [k] tick_check_oneshot_broadcast_this_cpu
     0.00%  swapper          [kernel.kallsyms]               [k] switch_mm_irqs_off
     0.00%  swapper          [kernel.kallsyms]               [k] calc_load_nohz_stop
     0.00%  swapper          [kernel.kallsyms]               [k] _raw_spin_lock
     0.00%  swapper          [kernel.kallsyms]               [k] nohz_run_idle_balance
     0.00%  swapper          [kernel.kallsyms]               [k] rcu_note_context_switch
     0.00%  swapper          [kernel.kallsyms]               [k] run_timer_softirq
     0.00%  swapper          [kernel.kallsyms]               [k] kthread_is_per_cpu
     0.00%  swapper          [kernel.kallsyms]               [k] x86_pmu_disable
     0.00%  ksoftirqd/4      [kernel.kallsyms]               [k] rcu_cblist_dequeue
     0.00%  init             init                            [.] 0x0000000000008874
     0.00%  swapper          [kernel.kallsyms]               [k] ct_kernel_enter.constprop.0
     0.00%  swapper          [kernel.kallsyms]               [k] update_rq_clock.part.0
     0.00%  swapper          [kernel.kallsyms]               [k] __dequeue_entity
     0.00%  swapper          [kernel.kallsyms]               [k] ttwu_queue_wakelist
     0.00%  swapper          [kernel.kallsyms]               [k] __hrtimer_run_queues
     0.00%  swapper          [kernel.kallsyms]               [k] select_task_rq_fair
     0.00%  md0_raid5        [kernel.kallsyms]               [k] update_wall_time
     0.00%  md0_raid5        [kernel.kallsyms]               [k] ntp_tick_length
     0.00%  md0_raid5        [kernel.kallsyms]               [k] trigger_load_balance
     0.00%  md0_raid5        [kernel.kallsyms]               [k] acct_account_cputime
     0.00%  md0_raid5        [kernel.kallsyms]               [k] ktime_get
     0.00%  md0_raid5        [kernel.kallsyms]               [k] timerqueue_add
     0.00%  md0_raid5        [kernel.kallsyms]               [k] _raw_spin_lock
     0.00%  md0_raid5        [kernel.kallsyms]               [k] tick_do_update_jiffies64
     0.00%  md0_raid5        [kernel.kallsyms]               [k] native_irq_return_iret
     0.00%  md0_raid5        [kernel.kallsyms]               [k] ktime_get_update_offsets_now
     0.00%  swapper          [kernel.kallsyms]               [k] asm_sysvec_apic_timer_interrupt
     0.00%  swapper          [kernel.kallsyms]               [k] update_blocked_averages
     0.00%  md0_raid5        [kernel.kallsyms]               [k] error_entry
     0.00%  md0_raid5        [kernel.kallsyms]               [k] rcu_sched_clock_irq
     0.00%  md0_raid5        [kernel.kallsyms]               [k] native_apic_msr_eoi
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_highres_handler
     0.00%  md0_raid5        [kernel.kallsyms]               [k] irq_work_tick
     0.00%  ksmd             [kernel.kallsyms]               [k] __mod_timer
     0.00%  ksmd             [kernel.kallsyms]               [k] __hrtimer_run_queues
     0.00%  kwin_x11         [kernel.kallsyms]               [k] do_vfs_ioctl
     0.00%  swapper          [kernel.kallsyms]               [k] run_posix_cpu_timers
     0.00%  swapper          [kernel.kallsyms]               [k] __rdgsbase_inactive
     0.00%  ksmd             [kernel.kallsyms]               [k] hrtimer_interrupt
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] nvkm_object_search
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] hrtimer_start_range_ns
     0.00%  swapper          [kernel.kallsyms]               [k] __wrgsbase_inactive
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] clockevents_program_event
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] wq_worker_running
     0.00%  QSGRenderThread  [kernel.kallsyms]               [k] ioread32
     0.00%  swapper          [kernel.kallsyms]               [k] ct_nmi_exit
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] __hrtimer_init
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] __schedule
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] sched_clock_noinstr
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] calc_global_load_tick
     0.00%  swapper          [kernel.kallsyms]               [k] load_balance
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_start_range_ns
     0.00%  swapper          [kernel.kallsyms]               [k] irqentry_exit
     0.00%  ksmd             [kernel.kallsyms]               [k] psi_group_change
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_interrupt
     0.00%  swapper          [kernel.kallsyms]               [k] rebalance_domains
     0.00%  plasmashell      libKF5Plasma.so.5.113.0         [.] Plasma::Containment::metaObject
     0.00%  plasmashell      [kernel.kallsyms]               [k] rb_insert_color
     0.00%  swapper          [kernel.kallsyms]               [k] cpuidle_reflect
     0.00%  swapper          [kernel.kallsyms]               [k] update_cfs_group
     0.00%  dmeventd         [kernel.kallsyms]               [k] update_curr
     0.00%  plasmashell      libc.so.6                       [.] __poll
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] queued_spin_lock_slowpath
     0.00%  swapper          [kernel.kallsyms]               [k] quiet_vmstat
     0.00%  plasmashell      [kernel.kallsyms]               [k] call_filldir
     0.00%  gpm              gpm                             [.] 0x0000000000010470
     0.00%  gpm              [kernel.kallsyms]               [k] getname_flags
     0.00%  QSGRenderThread  libQt5Quick.so.5.15.11          [.] 0x0000000000199010
     0.00%  QSGRenderThread  libqxcb-glx-integration.so      [.] QXcbWindow::needsSync@plt
     0.00%  synergys         [kernel.kallsyms]               [k] do_sys_poll
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] readdir64@plt
     0.00%  swapper          [kernel.kallsyms]               [k] ct_nmi_enter
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] 0x00000000002dc2b5
     0.00%  perf             [kernel.kallsyms]               [k] ext4_journal_check_start
     0.00%  swapper          [kernel.kallsyms]               [k] timerqueue_del
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
     0.00%  swapper          [kernel.kallsyms]               [k] call_cpuidle
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] percpu_counter_add_batch
     0.00%  swapper          [kernel.kallsyms]               [k] tsc_verify_tsc_adjust
     0.00%  ksmd             [kernel.kallsyms]               [k] schedule_timeout
     0.00%  konsole          libQt5XcbQpa.so.5.15.11         [.] QKeyEvent::modifiers@plt
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] QString::fromLocal8Bit_helper
     0.00%  kwin_x11         libkwin.so.5.27.10              [.] KWin::Application::dispatchEvent
     0.00%  swapper          [kernel.kallsyms]               [k] sysvec_apic_timer_interrupt
     0.00%  migration/2      [kernel.kallsyms]               [k] update_sd_lb_stats.constprop.0
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] QArrayData::allocate
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] hrtimer_active
     0.00%  plasmashell      [kernel.kallsyms]               [k] __get_user_1
     0.00%  synergys         [kernel.kallsyms]               [k] avg_vruntime
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] 0x00000000001cdca2
     0.00%  ksmd             [kernel.kallsyms]               [k] hrtimer_active
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] __switch_to
     0.00%  ksmd             [kernel.kallsyms]               [k] nohz_balance_exit_idle.part.0
     0.00%  konsole          libharfbuzz.so.0.60830.0        [.] 0x00000000000a9aa0
     0.00%  swapper          [kernel.kallsyms]               [k] rb_erase
     0.00%  swapper          [kernel.kallsyms]               [k] activate_task
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] 0x00000000001d72f3
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_idle_retain_tick
     0.00%  konsole          libxcb.so.1.1.0                 [.] xcb_send_request64
     0.00%  swapper          [unknown]                       [.] 0000000000000000
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_update_next_event
     0.00%  kworker/7:0-eve  [kernel.kallsyms]               [k] collect_percpu_times
     0.00%  plasmashell      libQt5Qml.so.5.15.11            [.] QQmlJavaScriptExpression::clearActiveGuards
     0.00%  perf             [kernel.kallsyms]               [k] __block_commit_write
     0.00%  swapper          [kernel.kallsyms]               [k] __intel_pmu_enable_all.isra.0
     0.00%  perf             [kernel.kallsyms]               [k] affine_move_task
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_get_sleep_length
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] mpage_release_unused_pages
     0.00%  plasmashell      libQt5Qml.so.5.15.11            [.] QQmlData::isSignalConnected
     0.00%  perf             [kernel.kallsyms]               [k] mt_find
     0.00%  xembedsniproxy   [kernel.kallsyms]               [k] update_sd_lb_stats.constprop.0
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] 0x0000000000202d04
     0.00%  migration/3      [kernel.kallsyms]               [k] psi_group_change
     0.00%  swapper          [kernel.kallsyms]               [k] tick_program_event
     0.00%  swapper          [kernel.kallsyms]               [k] cpuidle_get_cpu_driver
     0.00%  swapper          [kernel.kallsyms]               [k] account_process_tick
     0.00%  Qt bearer threa  libc.so.6                       [.] 0x0000000000093948
     0.00%  swapper          [kernel.kallsyms]               [k] __flush_smp_call_function_queue
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] xts_crypt
     0.00%  swapper          [kernel.kallsyms]               [k] kmem_cache_free
     0.00%  synergys         [kernel.kallsyms]               [k] psi_group_change
     0.00%  avahi-daemon     libavahi-common.so.3.5.4        [.] avahi_unescape_label
     0.00%  migration/0      [kernel.kallsyms]               [k] __update_load_avg_se
     0.00%  swapper          [kernel.kallsyms]               [k] ct_idle_exit
     0.00%  swapper          [kernel.kallsyms]               [k] cpuidle_not_available
     0.00%  swapper          [kernel.kallsyms]               [k] error_entry
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_idle_got_tick
     0.00%  X                Xorg                            [.] 0x0000000000094069
     0.00%  swapper          [kernel.kallsyms]               [k] try_to_wake_up
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] 0x0000000000202db6
     0.00%  swapper          [kernel.kallsyms]               [k] idle_cpu
     0.00%  kwin_x11         nouveau_dri.so                  [.] 0x00000000001342e0
     0.00%  swapper          [kernel.kallsyms]               [k] irq_work_needs_cpu
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] _raw_read_lock_irqsave
     0.00%  swapper          [kernel.kallsyms]               [k] nvkm_pci_wr32
     0.00%  kwin_x11         libkwineffects.so.5.27.10       [.] KWin::WindowPaintData::brightness
     0.00%  plasmashell      libQt5Quick.so.5.15.11          [.] QTextLayout::beginLayout@plt
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] unix_destruct_scm
     0.00%  X                [kernel.kallsyms]               [k] ___slab_alloc.isra.0
     0.00%  kwin_x11         nouveau_dri.so                  [.] 0x0000000000070093
     0.00%  swapper          [kernel.kallsyms]               [k] psi_task_change
     0.00%  X                Xorg                            [.] XkbComputeDerivedState
     0.00%  swapper          [kernel.kallsyms]               [k] rb_insert_color
     0.00%  synergys         [kernel.kallsyms]               [k] newidle_balance.isra.0
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] __copy_msghdr
     0.00%  swapper          [kernel.kallsyms]               [k] __softirqentry_text_start
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] ext4_reserve_inode_write
     0.00%  konsole          libc.so.6                       [.] 0x0000000000092244
     0.00%  kwin_x11         libQt5Gui.so.5.15.11            [.] QRegion::~QRegion
     0.00%  perf             [kernel.kallsyms]               [k] __rmqueue_pcplist
     0.00%  konsole          libQt5Core.so.5.15.11           [.] 0x00000000002db957
     0.00%  ksmd             [kernel.kallsyms]               [k] mas_next_slot
     0.00%  kwin_x11         libQt5Core.so.5.15.11           [.] QtPrivate::qustrchr
     0.00%  swapper          [kernel.kallsyms]               [k] update_load_avg
     0.00%  swapper          [kernel.kallsyms]               [k] perf_pmu_nop_void
     0.00%  plasmashell      libc.so.6                       [.] 0x00000000000920bf
     0.00%  synergys         [kernel.kallsyms]               [k] sock_poll
     0.00%  QSGRenderThread  nouveau_dri.so                  [.] 0x00000000007474d0
     0.00%  kwin_x11         [kernel.kallsyms]               [k] nvkm_vmm_get_locked
     0.00%  swapper          [kernel.kallsyms]               [k] __msecs_to_jiffies
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] task_h_load
     0.00%  synergys         [kernel.kallsyms]               [k] __fget_light
     0.00%  swapper          [kernel.kallsyms]               [k] irq_work_tick
     0.00%  swapper          [kernel.kallsyms]               [k] irqentry_enter
     0.00%  kwin_x11         nouveau_dri.so                  [.] 0x0000000000745aa0
     0.00%  X                [kernel.kallsyms]               [k] do_iter_write
     0.00%  plasmashell      libQt5XcbQpa.so.5.15.11         [.] QXcbConnection::handleXcbEvent
     0.00%  QSGRenderThread  [kernel.kallsyms]               [k] nvkm_vmm_get_locked
     0.00%  QSGRenderThread  libQt5Quick.so.5.15.11          [.] QSGRenderContext::endSync
     0.00%  swapper          [kernel.kallsyms]               [k] arch_cpu_idle_enter
     0.00%  X                [kernel.kallsyms]               [k] drain_obj_stock
     0.00%  swapper          [kernel.kallsyms]               [k] calc_global_load_tick
     0.00%  Qt bearer threa  [kernel.kallsyms]               [k] macvlan_fill_info
     0.00%  X                libdrm_nouveau.so.2.0.0         [.] 0x0000000000004ee2
     0.00%  synergys         libc.so.6                       [.] __poll
     0.00%  swapper          [kernel.kallsyms]               [k] cpuidle_governor_latency_req
     0.00%  swapper          [kernel.kallsyms]               [k] _nohz_idle_balance.isra.0
     0.00%  X                Xorg                            [.] 0x000000000008207c
     0.00%  plasmashell      libglib-2.0.so.0.7800.3         [.] 0x0000000000059794
     0.00%  swapper          [kernel.kallsyms]               [k] irq_exit_rcu
     0.00%  X                [kernel.kallsyms]               [k] timestamp_truncate
     0.00%  plasmashell      libglib-2.0.so.0.7800.3         [.] 0x00000000000567c4
     0.00%  QSGRenderThread  nouveau_dri.so                  [.] 0x000000000024295e
     0.00%  X                [kernel.kallsyms]               [k] save_fpregs_to_fpstate
     0.00%  perf             [kernel.kallsyms]               [k] lru_add_fn
     0.00%  swapper          [kernel.kallsyms]               [k] rcu_preempt_deferred_qs
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_get_next_event
     0.00%  plasmashell      libc.so.6                       [.] 0x0000000000140199
     0.00%  X                [kernel.kallsyms]               [k] dequeue_task_fair
     0.00%  swapper          [kernel.kallsyms]               [k] __lock_text_start
     0.00%  swapper          [kernel.kallsyms]               [k] __remove_hrtimer
     0.00%  swapper          [kernel.kallsyms]               [k] rcu_needs_cpu
     0.00%  swapper          [kernel.kallsyms]               [k] alx_poll
     0.00%  swapper          [kernel.kallsyms]               [k] rcu_segcblist_ready_cbs
     0.00%  swapper          [kernel.kallsyms]               [k] task_tick_idle
     0.00%  swapper          [kernel.kallsyms]               [k] cr4_update_irqsoff
     0.00%  plasmashell      libQt5Quick.so.5.15.11          [.] 0x000000000020564d
     0.00%  swapper          [kernel.kallsyms]               [k] cpu_latency_qos_limit
     0.00%  swapper          [kernel.kallsyms]               [k] get_next_timer_interrupt
     0.00%  InputThread      [kernel.kallsyms]               [k] __get_user_8
     0.00%  xembedsniproxy   libQt5XcbQpa.so.5.15.11         [.] QXcbConnection::processXcbEvents
     0.00%  kwin_x11         libxkbcommon.so.0.0.0           [.] xkb_state_key_get_level
     0.00%  sudo             libc.so.6                       [.] read
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] filemap_get_folios_tag
     0.00%  InputThread      [kernel.kallsyms]               [k] ep_item_poll.isra.0
     0.00%  swapper          [kernel.kallsyms]               [k] can_stop_idle_tick
     0.00%  swapper          [kernel.kallsyms]               [k] __pick_eevdf
     0.00%  perf             [kernel.kallsyms]               [k] __fget_light
     0.00%  InputThread      [kernel.kallsyms]               [k] _copy_from_iter
     0.00%  InputThread      [kernel.kallsyms]               [k] ep_done_scan
     0.00%  swapper          [kernel.kallsyms]               [k] netlink_broadcast_filtered
     0.00%  upsd             [kernel.kallsyms]               [k] __cgroup_account_cputime
     0.00%  kworker/7:0-eve  [kernel.kallsyms]               [k] __cond_resched
     0.00%  X                [kernel.kallsyms]               [k] ww_mutex_lock_interruptible
     0.00%  swapper          [kernel.kallsyms]               [k] attach_entity_load_avg
     0.00%  plasmashell      libKF5Archive.so.5.113.0        [.] 0x000000000000ea00
     0.00%  QSGRenderThread  nouveau_dri.so                  [.] 0x000000000037f463
     0.00%  jbd2/dm-2-8      [kernel.kallsyms]               [k] _aesni_enc4
     0.00%  kwin_x11         [kernel.kallsyms]               [k] obj_cgroup_charge
     0.00%  X                nouveau_dri.so                  [.] 0x0000000000125020
     0.00%  perf             [kernel.kallsyms]               [k] fault_in_readable
     0.00%  perf             [kernel.kallsyms]               [k] should_failslab
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] xhci_ring_ep_doorbell
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] put_cpu_partial
     0.00%  swapper          [kernel.kallsyms]               [k] ___slab_alloc.isra.0
     0.00%  kwin_x11         [kernel.kallsyms]               [k] evict
     0.00%  swapper          [kernel.kallsyms]               [k] sched_clock
     0.00%  crond            libc.so.6                       [.] 0x00000000000b1330
     0.00%  swapper          [kernel.kallsyms]               [k] update_dl_rq_load_avg
     0.00%  X                libdrm_nouveau.so.2.0.0         [.] nouveau_bo_ref
     0.00%  perf             perf                            [.] 0x000000000007e2a6
     0.00%  konsole          [kernel.kallsyms]               [k] n_tty_read
     0.00%  synergys         [kernel.kallsyms]               [k] __schedule
     0.00%  swapper          [kernel.kallsyms]               [k] calc_load_nohz_start
     0.00%  swapper          [kernel.kallsyms]               [k] tick_irq_enter
     0.00%  swapper          [kernel.kallsyms]               [k] skb_release_head_state
     0.00%  swapper          [kernel.kallsyms]               [k] task_tick_mm_cid
     0.00%  swapper          [kernel.kallsyms]               [k] nohz_csd_func
     0.00%  swapper          [kernel.kallsyms]               [k] update_process_times
     0.00%  perf             [kernel.kallsyms]               [k] xas_load
     0.00%  swapper          [kernel.kallsyms]               [k] update_rt_rq_load_avg
     0.00%  synergys         [kernel.kallsyms]               [k] entry_SYSRETQ_unsafe_stack
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] 0x00000000002b9526
     0.00%  plasmashell      libc.so.6                       [.] _pthread_cleanup_push
     0.00%  plasmashell      libglib-2.0.so.0.7800.3         [.] g_mutex_lock
     0.00%  synergys         synergys                        [.] 0x000000000004dd9b
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] update_cfs_group
     0.00%  swapper          [kernel.kallsyms]               [k] sched_clock_cpu
     0.00%  kglobalaccel5    libxcb-keysyms.so.1.0.0         [.] xcb_key_symbols_get_keysym
     0.00%  synergys         [kernel.kallsyms]               [k] pipe_poll
     0.00%  swapper          [kernel.kallsyms]               [k] record_times
     0.00%  swapper          [kernel.kallsyms]               [k] cpu_startup_entry
     0.00%  plasmashell      libQt5Qml.so.5.15.11            [.] QV4::QObjectWrapper::findProperty
     0.00%  swapper          [kernel.kallsyms]               [k] finish_task_switch.isra.0
     0.00%  kwin_x11         libQt5Core.so.5.15.11           [.] qstrcmp
     0.00%  synergys         [kernel.kallsyms]               [k] dequeue_entity
     0.00%  QXcbEventQueue   libxcb.so.1.1.0                 [.] 0x000000000000f56e
     0.00%  kglobalaccel5    libc.so.6                       [.] pthread_getspecific
     0.00%  swapper          [kernel.kallsyms]               [k] ttwu_do_activate.isra.0
     0.00%  synergys         libxcb.so.1.1.0                 [.] xcb_poll_for_event
     0.00%  synergys         [kernel.kallsyms]               [k] unix_poll
     0.00%  konqueror        libQt5WebEngineCore.so.5.15.11  [.] 0x0000000002ba3914
     0.00%  rcu_sched        [kernel.kallsyms]               [k] rcu_all_qs
     0.00%  QSGRenderThread  [kernel.kallsyms]               [k] mutex_spin_on_owner
     0.00%  konqueror        libQt5WebEngineCore.so.5.15.11  [.] 0x0000000002b56bc8
     0.00%  synergys         [kernel.kallsyms]               [k] update_cfs_group
     0.00%  QSGRenderThread  [kernel.kallsyms]               [k] syscall_return_via_sysret
     0.00%  synergys         synergys                        [.] pthread_mutex_lock@plt
     0.00%  synergys         [kernel.kallsyms]               [k] __switch_to
     0.00%  at-spi2-registr  libglib-2.0.so.0.7800.3         [.] 0x0000000000056e64
     0.00%  perf             [kernel.kallsyms]               [k] __get_file_rcu
     0.00%  synergys         [kernel.kallsyms]               [k] __switch_to_asm
     0.00%  swapper          [kernel.kallsyms]               [k] local_clock_noinstr
     0.00%  perf             [kernel.kallsyms]               [k] __filemap_add_folio
     0.00%  swapper          [kernel.kallsyms]               [k] trigger_load_balance
     0.00%  swapper          [kernel.kallsyms]               [k] xhci_ring_ep_doorbell
     0.00%  synergys         [kernel.kallsyms]               [k] __rseq_handle_notify_resume
     0.00%  swapper          [kernel.kallsyms]               [k] intel_pmu_disable_all
     0.00%  kwin_x11         kwin_x11                        [.] 0x000000000008ee30
     0.00%  swapper          [kernel.kallsyms]               [k] sched_idle_set_state
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_next_event_without
     0.00%  upsmon           [kernel.kallsyms]               [k] __ip_finish_output
     0.00%  plasmashell      libQt5Core.so.5.15.11           [.] QVariant::clear
     0.00%  perf             [kernel.kallsyms]               [k] create_empty_buffers
     0.00%  perf             [kernel.kallsyms]               [k] memset_orig
     0.00%  synergys         libc.so.6                       [.] recvmsg
     0.00%  baloorunner      libQt5XcbQpa.so.5.15.11         [.] 0x0000000000065c0d
     0.00%  konsole          libc.so.6                       [.] 0x000000000013d502
     0.00%  swapper          [kernel.kallsyms]               [k] update_curr
     0.00%  QSGRenderThread  nouveau_dri.so                  [.] 0x00000000002428dc
     0.00%  synergys         [kernel.kallsyms]               [k] save_fpregs_to_fpstate
     0.00%  synergys         [kernel.kallsyms]               [k] __update_load_avg_se
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] mem_cgroup_css_rstat_flush
     0.00%  swapper          [kernel.kallsyms]               [k] ___bpf_prog_run
     0.00%  kwin_x11         libQt5Core.so.5.15.11           [.] QArrayData::deallocate
     0.00%  konqueror        libQt5Core.so.5.15.11           [.] qstrcmp
     0.00%  X                libglamoregl.so                 [.] 0x000000000000c6de
     0.00%  synergys         [kernel.kallsyms]               [k] exit_to_user_mode_prepare
     0.00%  X                [kernel.kallsyms]               [k] __kmem_cache_alloc_node
     0.00%  synergys         libc.so.6                       [.] pthread_mutex_lock
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_idle_enter
     0.00%  swapper          [kernel.kallsyms]               [k] tick_check_broadcast_expired
     0.00%  perf             [kernel.kallsyms]               [k] __fdget_pos
     0.00%  konqueror        libQt5WebEngineCore.so.5.15.11  [.] 0x0000000002b6092c
     0.00%  ksoftirqd/5      [kernel.kallsyms]               [k] load_balance
     0.00%  kglobalaccel5    ld-linux-x86-64.so.2            [.] __tls_get_addr
     0.00%  swapper          [kernel.kallsyms]               [k] perf_swevent_stop
     0.00%  Qt bearer threa  [kernel.kallsyms]               [k] inet6_fill_ifla6_attrs
     0.00%  perf             [kernel.kallsyms]               [k] copy_page_from_iter_atomic
     0.00%  swapper          [kernel.kallsyms]               [k] __call_rcu_common.constprop.0
     0.00%  swapper          [kernel.kallsyms]               [k] psi_task_switch
     0.00%  swapper          [kernel.kallsyms]               [k] menu_reflect
     0.00%  synergys         [kernel.kallsyms]               [k] __update_load_avg_cfs_rq
     0.00%  :-1              [kernel.kallsyms]               [k] proc_invalidate_siblings_dcache
     0.00%  rcu_sched        [kernel.kallsyms]               [k] dequeue_task_fair
     0.00%  swapper          [kernel.kallsyms]               [k] check_tsc_unstable
     0.00%  konsole          libQt5Core.so.5.15.11           [.] QAbstractEventDispatcherPrivate::releaseTimerId
     0.00%  konqueror        libQt5WebEngineCore.so.5.15.11  [.] 0x0000000002b836e2
     0.00%  kclockd          [kernel.kallsyms]               [k] __get_user_8
     0.00%  usbhid-ups       libc.so.6                       [.] ioctl
     0.00%  swapper          [kernel.kallsyms]               [k] perf_event_task_tick
     0.00%  swapper          [kernel.kallsyms]               [k] tun_net_xmit
     0.00%  rcu_sched        [kernel.kallsyms]               [k] enqueue_timer
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_idle_exit
     0.00%  swapper          [kernel.kallsyms]               [k] set_next_entity
     0.00%  synergys         [kernel.kallsyms]               [k] syscall_enter_from_user_mode
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_irq_exit
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] proc_do_submiturb
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] usbdev_poll
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] enqueue_to_backlog
     0.00%  ksoftirqd/5      [kernel.kallsyms]               [k] update_sd_lb_stats.constprop.0
     0.00%  kwin_x11         libkwin.so.5.27.10              [.] KWin::RenderLoopPrivate::scheduleRepaint
     0.00%  :-1              [kernel.kallsyms]               [k] wake_up_bit
     0.00%  synergys         [kernel.kallsyms]               [k] update_load_avg
     0.00%  QXcbEventQueue   libQt5Core.so.5.15.11           [.] QMutex::lock
     0.00%  synergys         [unknown]                       [.] 0000000000000000
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] record_times
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] drain_obj_stock
     0.00%  konqueror        [kernel.kallsyms]               [k] refill_stock
     0.00%  konqueror        libQt5WebEngineCore.so.5.15.11  [.] 0x0000000002bc6fff
     0.00%  perf             [kernel.kallsyms]               [k] _raw_write_lock
     0.00%  synergys         libX11.so.6.4.0                 [.] XPending
     0.00%  synergys         libc.so.6                       [.] pthread_mutex_unlock
     0.00%  synergys         synergys                        [.] poll@plt
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] schedule_hrtimeout_range_clock
     0.00%  synergys         synergys                        [.] pthread_mutex_unlock@plt
     0.00%  swapper          [kernel.kallsyms]               [k] schedule_idle
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] wq_worker_running
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __switch_to_asm
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] mem_cgroup_css_rstat_flush
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x00000000000440b0
     0.00%  synergys         [kernel.kallsyms]               [k] unix_stream_read_generic
     0.00%  usbhid-ups       libusb-1.0.so.0.3.0             [.] 0x0000000000011979
     0.00%  avahi-daemon     libavahi-core.so.7.1.0          [.] avahi_dns_packet_check_valid
     0.00%  X                Xorg                            [.] 0x00000000000d094e
     0.00%  synergys         libxcb.so.1.1.0                 [.] 0x000000000000f56c
     0.00%  swapper          [kernel.kallsyms]               [k] wakeup_preempt
     0.00%  swapper          [kernel.kallsyms]               [k] avg_vruntime
     0.00%  swapper          [kernel.kallsyms]               [k] put_prev_task_idle
     0.00%  swapper          [kernel.kallsyms]               [k] _find_next_bit
     0.00%  plasmashell      libc.so.6                       [.] malloc
     0.00%  Qt bearer threa  [kernel.kallsyms]               [k] kmem_cache_alloc_node
     0.00%  QXcbEventQueue   libQt5Core.so.5.15.11           [.] QThread::eventDispatcher
     0.00%  Qt bearer threa  [kernel.kallsyms]               [k] do_syscall_64
     0.00%  perf             [kernel.kallsyms]               [k] perf_poll
     0.00%  X                libEGL_mesa.so.0.0.0            [.] 0x0000000000018a27
     0.00%  synergys         [kernel.kallsyms]               [k] pick_next_task_fair
     0.00%  swapper          [kernel.kallsyms]               [k] enqueue_hrtimer
     0.00%  rcu_sched        [kernel.kallsyms]               [k] psi_group_change
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] vmstat_shepherd
     0.00%  perf             perf                            [.] 0x0000000000101078
     0.00%  perf             [kernel.kallsyms]               [k] lock_vma_under_rcu
     0.00%  swapper          [kernel.kallsyms]               [k] tcp_orphan_count_sum
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] _raw_spin_lock_irq
     0.00%  synergys         [kernel.kallsyms]               [k] sched_clock_noinstr
     0.00%  swapper          [kernel.kallsyms]               [k] __rb_insert_augmented
     0.00%  swapper          [kernel.kallsyms]               [k] cpuidle_select
     0.00%  QSGRenderThread  libQt5Quick.so.5.15.11          [.] QSGBatchRenderer::Renderer::buildRenderLists
     0.00%  QSGRenderThread  libQt5Quick.so.5.15.11          [.] QSGBatchRenderer::Renderer::nodeChanged
     0.00%  kwin_x11         libKF5JobWidgets.so.5.113.0     [.] 0x000000000000fa50
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] __cgroup_account_cputime
     0.00%  usbhid-ups       libc.so.6                       [.] 0x000000000013e8b0
     0.00%  konqueror        libQt5Core.so.5.15.11           [.] clock_gettime@plt
     0.00%  swapper          [kernel.kallsyms]               [k] mm_cid_get
     0.00%  gmain            [kernel.kallsyms]               [k] inode_permission
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_try_to_cancel.part.0
     0.00%  rcu_sched        [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
     0.00%  usbhid-ups       libc.so.6                       [.] 0x000000000007ad00
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] kvfree_rcu_bulk
     0.00%  synergys         [kernel.kallsyms]               [k] sockfd_lookup_light
     0.00%  synergys         libc.so.6                       [.] 0x000000000008ac00
     0.00%  swapper          [kernel.kallsyms]               [k] timerqueue_iterate_next
     0.00%  synergys         [kernel.kallsyms]               [k] __get_user_8
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] memchr_inv
     0.00%  swapper          [kernel.kallsyms]               [k] wb_timer_fn
     0.00%  perf             perf                            [.] 0x0000000000104467
     0.00%  swapper          [kernel.kallsyms]               [k] ct_idle_enter
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x0000000000043e60
     0.00%  usbhid-ups       libc.so.6                       [.] 0x00000000000826a3
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] __mod_memcg_lruvec_state
     0.00%  synergys         synergys                        [.] 0x0000000000026260
     0.00%  ksoftirqd/5      [kernel.kallsyms]               [k] kthread_should_stop
     0.00%  synergys         synergys                        [.] 0x0000000000025047
     0.00%  usbhid-ups       libc.so.6                       [.] pthread_mutex_trylock
     0.00%  synergys         libxcb.so.1.1.0                 [.] 0x0000000000010030
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] psi_avgs_work
     0.00%  synergys         [kernel.kallsyms]               [k] ____sys_recvmsg
     0.00%  kwin_x11         libglib-2.0.so.0.7800.3         [.] g_mutex_lock
     0.00%  synergys         [kernel.kallsyms]               [k] _copy_from_user
     0.00%  rcu_sched        [kernel.kallsyms]               [k] update_min_vruntime
     0.00%  kwin_x11         libQt5Gui.so.5.15.11            [.] QImageData::~QImageData
     0.00%  rcu_sched        [kernel.kallsyms]               [k] rcu_gp_kthread
     0.00%  synergys         synergys                        [.] 0x0000000000025040
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] memcpy_orig
     0.00%  synergys         [kernel.kallsyms]               [k] timerqueue_add
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_tick_stopped
     0.00%  swapper          [kernel.kallsyms]               [k] __put_task_struct
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] kfree
     0.00%  dmeventd         [kernel.kallsyms]               [k] finish_task_switch.isra.0
     0.00%  perf             [kernel.kallsyms]               [k] __rdgsbase_inactive
     0.00%  swapper          [kernel.kallsyms]               [k] irq_chip_ack_parent
     0.00%  swapper          [kernel.kallsyms]               [k] irq_enter_rcu
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] __fget_light
     0.00%  usbhid-ups       usbhid-ups                      [.] 0x000000000001e143
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __mod_timer
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x0000000000031dab
     0.00%  ksoftirqd/5      [kernel.kallsyms]               [k] __softirqentry_text_start
     0.00%  synergys         [kernel.kallsyms]               [k] ___sys_recvmsg
     0.00%  swapper          [kernel.kallsyms]               [k] error_return
     0.00%  swapper          [kernel.kallsyms]               [k] run_rebalance_domains
     0.00%  rcu_sched        [kernel.kallsyms]               [k] check_cfs_rq_runtime
     0.00%  perf             [kernel.kallsyms]               [k] do_sys_poll
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __update_load_avg_se
     0.00%  ThreadPoolForeg  libQt5WebEngineCore.so.5.15.11  [.] 0x0000000002b8cf74
     0.00%  rcu_sched        [kernel.kallsyms]               [k] rcu_implicit_dynticks_qs
     0.00%  swapper          [kernel.kallsyms]               [k] atomic_notifier_call_chain
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x00000000000476cb
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x0000000000031cd0
     0.00%  swapper          [kernel.kallsyms]               [k] llist_reverse_order
     0.00%  rcu_sched        [kernel.kallsyms]               [k] finish_task_switch.isra.0
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x00000000000441d0
     0.00%  upsmon           [kernel.kallsyms]               [k] __schedule
     0.00%  upsmon           [kernel.kallsyms]               [k] check_stack_object
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] usbdev_ioctl
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_run_queues
     0.00%  swapper          [kernel.kallsyms]               [k] i_callback
     0.00%  swapper          [kernel.kallsyms]               [k] wake_up_process
     0.00%  synergys         [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
     0.00%  X                [kernel.kallsyms]               [k] rcu_note_context_switch
     0.00%  kwin_x11         [kernel.kallsyms]               [k] __get_task_ioprio
     0.00%  kwin_x11         libkwin.so.5.27.10              [.] KWin::Workspace::findClient
     0.00%  X                [kernel.kallsyms]               [k] update_min_vruntime
     0.00%  X                libGLdispatch.so.0.0.0          [.] 0x000000000004918b
     0.00%  synergys         libX11.so.6.4.0                 [.] 0x0000000000031da8
     0.00%  konqueror        [kernel.kallsyms]               [k] unix_poll
     0.00%  konqueror        libKF5WidgetsAddons.so.5.113.0  [.] 0x0000000000075fb0
     0.00%  rcu_sched        [kernel.kallsyms]               [k] psi_task_switch
     0.00%  swapper          [kernel.kallsyms]               [k] __mod_memcg_lruvec_state
     0.00%  swapper          [kernel.kallsyms]               [k] get_nohz_timer_target
     0.00%  rcu_sched        [kernel.kallsyms]               [k] avg_vruntime
     0.00%  X                libEGL_mesa.so.0.0.0            [.] 0x0000000000018a20
     0.00%  X                [kernel.kallsyms]               [k] drm_file_get_master
     0.00%  swapper          [kernel.kallsyms]               [k] timer_clear_idle
     0.00%  ksoftirqd/5      [kernel.kallsyms]               [k] __switch_to_asm
     0.00%  kwin_x11         libQt5Core.so.5.15.11           [.] malloc@plt
     0.00%  swapper          [kernel.kallsyms]               [k] evdev_pass_values.part.0
     0.00%  synergys         libX11.so.6.4.0                 [.] xcb_connection_has_error@plt
     0.00%  swapper          [kernel.kallsyms]               [k] need_update
     0.00%  synergys         [kernel.kallsyms]               [k] __cgroup_account_cputime
     0.00%  synergys         [kernel.kallsyms]               [k] remove_wait_queue
     0.00%  swapper          [kernel.kallsyms]               [k] first_online_pgdat
     0.00%  swapper          [kernel.kallsyms]               [k] raw_spin_rq_lock_nested
     0.00%  perf             [kernel.kallsyms]               [k] remote_function
     0.00%  kwin_x11         [kernel.kallsyms]               [k] __get_file_rcu
     0.00%  :-1              [kernel.kallsyms]               [k] evict
     0.00%  X                [kernel.kallsyms]               [k] sock_poll
     0.00%  swapper          [kernel.kallsyms]               [k] arch_cpu_idle_exit
     0.00%  synergys         [kernel.kallsyms]               [k] enter_lazy_tlb
     0.00%  rcu_sched        [kernel.kallsyms]               [k] rcu_gp_cleanup
     0.00%  synergys         [kernel.kallsyms]               [k] __entry_text_start
     0.00%  swapper          [kernel.kallsyms]               [k] irq_work_run_list
     0.00%  swapper          [kernel.kallsyms]               [k] place_entity
     0.00%  perf             [kernel.kallsyms]               [k] xas_start
     0.00%  synergys         [kernel.kallsyms]               [k] copy_msghdr_from_user
     0.00%  synergys         [kernel.kallsyms]               [k] syscall_return_via_sysret
     0.00%  synergys         [kernel.kallsyms]               [k] schedule_hrtimeout_range_clock
     0.00%  synergys         [kernel.kallsyms]               [k] set_normalized_timespec64
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] desc_read
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] update_min_vruntime
     0.00%  synergys         [kernel.kallsyms]               [k] update_min_vruntime
     0.00%  :-1              [kernel.kallsyms]               [k] ___d_drop
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] strscpy
     0.00%  swapper          [kernel.kallsyms]               [k] __wake_up_common
     0.00%  swapper          [kernel.kallsyms]               [k] ep_poll_callback
     0.00%  rcu_sched        [kernel.kallsyms]               [k] update_curr
     0.00%  rcu_sched        [kernel.kallsyms]               [k] pick_next_task_idle
     0.00%  rcu_sched        [kernel.kallsyms]               [k] cpuacct_charge
     0.00%  InputThread      libinput_drv.so                 [.] 0x0000000000008e92
     0.00%  swapper          [kernel.kallsyms]               [k] __smp_call_single_queue
     0.00%  swapper          [kernel.kallsyms]               [k] reweight_entity
     0.00%  rcu_sched        [kernel.kallsyms]               [k] lock_timer_base
     0.00%  synergys         [kernel.kallsyms]               [k] put_prev_task_fair
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] dequeue_entity
     0.00%  konsole          libQt5Core.so.5.15.11           [.] 0x00000000002d4f40
     0.00%  kworker/2:1-mm_  [kernel.kallsyms]               [k] collect_percpu_times
     0.00%  synergys         libxcb.so.1.1.0                 [.] 0x000000000001004b
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_forward
     0.00%  upsmon           libc.so.6                       [.] strlen@plt
     0.00%  konqueror        libQt5Widgets.so.5.15.11        [.] QApplication::notify
     0.00%  swapper          [kernel.kallsyms]               [k] queued_spin_lock_slowpath
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] extract_entropy.constprop.0
     0.00%  swapper          [kernel.kallsyms]               [k] skb_network_protocol
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] _prb_read_valid
     0.00%  swapper          [kernel.kallsyms]               [k] enter_lazy_tlb
     0.00%  synergys         [kernel.kallsyms]               [k] dequeue_task_fair
     0.00%  synergys         [kernel.kallsyms]               [k] psi_task_switch
     0.00%  swapper          [kernel.kallsyms]               [k] flush_smp_call_function_queue
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] crypt_page_alloc
     0.00%  kworker/u16:3-e  [kernel.kallsyms]               [k] vsnprintf
     0.00%  kwin_x11         libkwin.so.5.27.10              [.] KWin::X11Window::windowEvent
     0.00%  swapper          [kernel.kallsyms]               [k] nsecs_to_jiffies
     0.00%  synergys         [kernel.kallsyms]               [k] schedule
     0.00%  rcu_sched        [kernel.kallsyms]               [k] dequeue_entity
     0.00%  synergys         [kernel.kallsyms]               [k] get_nohz_timer_target
     0.00%  synergys         [kernel.kallsyms]               [k] record_times
     0.00%  synergys         synergys                        [.] 0x000000000004dd96
     0.00%  synergys         [kernel.kallsyms]               [k] __x64_sys_poll
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __switch_to
     0.00%  kworker/u16:1-e  [kernel.kallsyms]               [k] cgroup_rstat_flush_locked
     0.00%  swapper          [kernel.kallsyms]               [k] nohz_balance_enter_idle
     0.00%  swapper          [kernel.kallsyms]               [k] __switch_to
     0.00%  avahi-daemon     [kernel.kallsyms]               [k] free_unref_page_commit
     0.00%  swapper          [kernel.kallsyms]               [k] account_idle_ticks
     0.00%  swapper          [kernel.kallsyms]               [k] perf_swevent_start
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] __rdgsbase_inactive
     0.00%  rcu_sched        [kernel.kallsyms]               [k] detach_if_pending
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] mutex_lock
     0.00%  perf             [kernel.kallsyms]               [k] fput
     0.00%  upsmon           [kernel.kallsyms]               [k] eth_type_trans
     0.00%  synergys         libX11.so.6.4.0                 [.] pthread_mutex_lock@plt
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] enqueue_timer
     0.00%  kwin_x11         KF5WindowSystemX11Plugin.so     [.] qstrcmp@plt
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] __kmem_cache_alloc_node
     0.00%  QXcbEventQueue   libc.so.6                       [.] malloc
     0.00%  kscreen_backend  libQt5XcbQpa.so.5.15.11         [.] xcb_flush@plt
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] __wake_up_common
     0.00%  avahi-daemon     [kernel.kallsyms]               [k] pipe_write
     0.00%  gmain            [kernel.kallsyms]               [k] restore_fpregs_from_fpstate
     0.00%  swapper          [kernel.kallsyms]               [k] pick_next_task_idle
     0.00%  swapper          [kernel.kallsyms]               [k] timekeeping_max_deferment
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __note_gp_changes
     0.00%  swapper          [kernel.kallsyms]               [k] ct_irq_exit
     0.00%  usbhid-ups       usbhid-ups                      [.] 0x000000000001d21b
     0.00%  gmain            libgio-2.0.so.0.7800.3          [.] g_list_free@plt
     0.00%  kworker/2:1-mm_  [kernel.kallsyms]               [k] refresh_cpu_vm_stats
     0.00%  swapper          [kernel.kallsyms]               [k] br_config_bpdu_generation
     0.00%  swapper          [kernel.kallsyms]               [k] process_timeout
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] psi_group_change
     0.00%  kwin_x11         libc.so.6                       [.] pthread_getspecific
     0.00%  swapper          [kernel.kallsyms]               [k] free_unref_page_prepare
     0.00%  X                libc.so.6                       [.] __errno_location
     0.00%  rcu_sched        [kernel.kallsyms]               [k] schedule
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] notifier_call_chain
     0.00%  dmeventd         [kernel.kallsyms]               [k] cpuacct_charge
     0.00%  synergys         [kernel.kallsyms]               [k] do_syscall_64
     0.00%  GUsbEventThread  libusb-1.0.so.0.3.0             [.] pthread_mutex_unlock@plt
     0.00%  swapper          [kernel.kallsyms]               [k] list_add_leaf_cfs_rq
     0.00%  synergys         [kernel.kallsyms]               [k] finish_task_switch.isra.0
     0.00%  synergys         libX11.so.6.4.0                 [.] _XSend@plt
     0.00%  synergys         [kernel.kallsyms]               [k] sched_clock_cpu
     0.00%  swapper          [kernel.kallsyms]               [k] find_busiest_group
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] worker_thread
     0.00%  synergys         synergys                        [.] 0x00000000000356fd
     0.00%  ksoftirqd/7      [kernel.kallsyms]               [k] update_sd_lb_stats.constprop.0
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] _raw_spin_lock_irqsave
     0.00%  swapper          [kernel.kallsyms]               [k] __slab_free.isra.0
     0.00%  X                [kernel.kallsyms]               [k] switch_fpu_return
     0.00%  swapper          [kernel.kallsyms]               [k] hrtimer_reprogram
     0.00%  QXcbEventQueue   [kernel.kallsyms]               [k] __schedule
     0.00%  QXcbEventQueue   libxcb.so.1.1.0                 [.] pthread_mutex_lock@plt
     0.00%  swapper          [kernel.kallsyms]               [k] ipt_do_table
     0.00%  synergys         [kernel.kallsyms]               [k] __hrtimer_init
     0.00%  kworker/dying    [kernel.kallsyms]               [k] queued_spin_lock_slowpath
     0.00%  ksoftirqd/5      [kernel.kallsyms]               [k] smpboot_thread_fn
     0.00%  avahi-daemon     [kernel.kallsyms]               [k] __get_user_8
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] enqueue_timer
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] collect_percpu_times
     0.00%  synergys         libc.so.6                       [.] 0x00000000000826cd
     0.00%  swapper          [kernel.kallsyms]               [k] macvlan_forward_source
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] get_pfnblock_flags_mask
     0.00%  swapper          [kernel.kallsyms]               [k] raise_softirq
     0.00%  rcu_sched        [kernel.kallsyms]               [k] rcu_gp_init
     0.00%  kworker/0:2-eve  [kernel.kallsyms]               [k] lock_timer_base
     0.00%  perf             [kernel.kallsyms]               [k] event_function_call
     0.00%  synergys         [kernel.kallsyms]               [k] update_curr
     0.00%  swapper          [kernel.kallsyms]               [k] ip_route_input_slow
     0.00%  swapper          [kernel.kallsyms]               [k] sched_clock_tick
     0.00%  swapper          [kernel.kallsyms]               [k] __nf_conntrack_find_get.isra.0
     0.00%  perf             [kernel.kallsyms]               [k] __intel_pmu_enable_all.isra.0
     0.00%  gmain            libc.so.6                       [.] clock_gettime
     0.00%  kworker/5:2-eve  [kernel.kallsyms]               [k] psi_task_switch
     0.00%  swapper          [kernel.kallsyms]               [k] input_event_dispose
     0.00%  swapper          [kernel.kallsyms]               [k] __next_timer_interrupt
     0.00%  swapper          [kernel.kallsyms]               [k] ct_irq_enter
     0.00%  kwin_x11         libc.so.6                       [.] 0x0000000000082620
     0.00%  dmeventd         libc.so.6                       [.] 0x0000000000087dfd
     0.00%  perf             [kernel.kallsyms]               [k] perf_ctx_enable.constprop.0
     0.00%  kworker/4:2-eve  [kernel.kallsyms]               [k] fold_diff
     0.00%  rcu_sched        [kernel.kallsyms]               [k] put_prev_task_fair
     0.00%  swapper          [kernel.kallsyms]               [k] tick_nohz_get_next_hrtimer
     0.00%  usbhid-ups       [kernel.kallsyms]               [k] unix_poll
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __schedule
     0.00%  rcu_sched        [kernel.kallsyms]               [k] update_rq_clock.part.0
     0.00%  swapper          [kernel.kallsyms]               [k] put_cpu_partial
     0.00%  perf             [kernel.kallsyms]               [k] nmi_restore
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __timer_delete_sync
     0.00%  kworker/3:2-mm_  [kernel.kallsyms]               [k] lru_add_drain_per_cpu
     0.00%  swapper          [kernel.kallsyms]               [k] local_touch_nmi
     0.00%  swapper          [kernel.kallsyms]               [k] rcu_cblist_dequeue
     0.00%  swapper          [kernel.kallsyms]               [k] notifier_call_chain
     0.00%  swapper          [kernel.kallsyms]               [k] update_rq_clock
     0.00%  rcu_sched        [kernel.kallsyms]               [k] force_qs_rnp
     0.00%  swapper          [kernel.kallsyms]               [k] __mod_timer
     0.00%  swapper          [kernel.kallsyms]               [k] update_group_capacity
     0.00%  rcu_sched        [kernel.kallsyms]               [k] __lock_text_start
     0.00%  rcu_sched        [kernel.kallsyms]               [k] newidle_balance.isra.0
     0.00%  rcu_sched        [kernel.kallsyms]               [k] _raw_spin_lock
     0.00%  rcu_sched        [kernel.kallsyms]               [k] schedule_timeout
     0.00%  swapper          [kernel.kallsyms]               [k] __enqueue_entity
     0.00%  swapper          [kernel.kallsyms]               [k] put_ucounts
     0.00%  perf             [kernel.kallsyms]               [k] native_apic_msr_write

