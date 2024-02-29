Return-Path: <linux-kernel+bounces-87261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DB86D1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D89282E96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9F17A139;
	Thu, 29 Feb 2024 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BnjFld5T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F7757FA
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230512; cv=none; b=NXl+twHom84Jswng9CfE2BN/pfqKR0pK4gWraQzDH6LPjpzNIEFra6LhnwJYmztmZ6X/xiScZtjUwXgjtGnvLPSTXcUktHugHYD8pdoqeY+BkC858YvcgHcJn+t58N3SLupQB53gnZXeCLx6U510spDwEbJuLH8wd3YbWiI8XuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230512; c=relaxed/simple;
	bh=gb12E201EnqWyZ2J5X+rESqIdgjq4jZAOdzaAW8wFHc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=eL7XhXdMEiHrgdzkUpH6XctwkQzYj1/fYfN90CsKCwB83g4km90yvHHfckXa22AB0im2SzNnLLqGfywyK8uxA5P30+LjsAvYV23IpQs6VGbjnqWK4RlJWj9dFOwUJYr8mVWhYw1NUEv3f4U5HcGKFvLs7QwZEe8qjxn5hvGZdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BnjFld5T; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709230510; x=1740766510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gb12E201EnqWyZ2J5X+rESqIdgjq4jZAOdzaAW8wFHc=;
  b=BnjFld5TZ2GPOv+W6Yij4PTnQeG9QgECLsGLsW2K4QiT4nNsT9cY9QzA
   BOId3xH5nhTmlnXfs3n4qIUn+/YKrcMjL+Yd5uxDsHQB9ZA9BsRjwoU1c
   w7lriEjU+TRB6SNQxxOS0Z313GiAxXNx3THuHqZuvpYq0VwHl46UcGKTP
   CZPbDhtiQ/r56EYuFBsWqJ2ECJcPndyPuqNi6PL13OVXbxrUcg+8CerX9
   uPHDr10YqKn+Ab/B9+nz9bE5R0WqANVYXttau+brQB5Zmp9XMQ/D06wr6
   j9sAIZjgRBB5UH4akbutTjeRTcIPGEvrCLFvUTmEtu1vqV7hPY8Q2BTwZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="4301894"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="4301894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="38926209"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 29 Feb 2024 10:15:06 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfkvo-000DBF-0e;
	Thu, 29 Feb 2024 18:14:59 +0000
Date: Fri, 1 Mar 2024 02:14:41 +0800
From: kernel test robot <lkp@intel.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: ERROR: modpost: vmlinux: local symbol 'timecounter_cyc2time' was
 exported
Message-ID: <202403010251.kXYTqUlo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   805d849d7c3cc1f38efefd48b2480d62b7b5dcb7
commit: 6d62b1c46b1e6e1686a0cf6617c96c80d4ab5cd5 modpost: check static EXPORT_SYMBOL* by modpost again
date:   8 months ago
config: riscv-randconfig-r024-20230108 (https://download.01.org/0day-ci/archive/20240301/202403010251.kXYTqUlo-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240301/202403010251.kXYTqUlo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403010251.kXYTqUlo-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: vmlinux: local symbol 'ns_to_kernel_old_timeval' was exported
ERROR: modpost: vmlinux: local symbol 'set_normalized_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'ns_to_timespec64' was exported
ERROR: modpost: vmlinux: local symbol '__msecs_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol '__usecs_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'timespec64_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_to_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_to_clock_t' was exported
ERROR: modpost: vmlinux: local symbol 'clock_t_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_64_to_clock_t' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies64_to_nsecs' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies64_to_msecs' was exported
ERROR: modpost: vmlinux: local symbol 'nsecs_to_jiffies64' was exported
ERROR: modpost: vmlinux: local symbol 'nsecs_to_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'get_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'put_timespec64' was exported
ERROR: modpost: vmlinux: local symbol 'get_old_timespec32' was exported
ERROR: modpost: vmlinux: local symbol 'put_old_timespec32' was exported
ERROR: modpost: vmlinux: local symbol 'get_itimerspec64' was exported
ERROR: modpost: vmlinux: local symbol 'put_itimerspec64' was exported
ERROR: modpost: vmlinux: local symbol 'get_old_itimerspec32' was exported
ERROR: modpost: vmlinux: local symbol 'put_old_itimerspec32' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies_64' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies_relative' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies_relative' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies_up' was exported
ERROR: modpost: vmlinux: local symbol '__round_jiffies_up_relative' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies_up' was exported
ERROR: modpost: vmlinux: local symbol 'round_jiffies_up_relative' was exported
ERROR: modpost: vmlinux: local symbol 'init_timer_key' was exported
ERROR: modpost: vmlinux: local symbol 'mod_timer_pending' was exported
ERROR: modpost: vmlinux: local symbol 'mod_timer' was exported
ERROR: modpost: vmlinux: local symbol 'timer_reduce' was exported
ERROR: modpost: vmlinux: local symbol 'add_timer' was exported
ERROR: modpost: vmlinux: local symbol 'add_timer_on' was exported
ERROR: modpost: vmlinux: local symbol 'timer_delete' was exported
ERROR: modpost: vmlinux: local symbol 'timer_shutdown' was exported
ERROR: modpost: vmlinux: local symbol 'try_to_del_timer_sync' was exported
ERROR: modpost: vmlinux: local symbol 'timer_delete_sync' was exported
ERROR: modpost: vmlinux: local symbol 'timer_shutdown_sync' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_killable' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_uninterruptible' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_timeout_idle' was exported
ERROR: modpost: vmlinux: local symbol 'msleep' was exported
ERROR: modpost: vmlinux: local symbol 'msleep_interruptible' was exported
ERROR: modpost: vmlinux: local symbol 'usleep_range_state' was exported
ERROR: modpost: vmlinux: local symbol '__ktime_divns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_add_safe' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_resolution' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_forward' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_start_range_ns' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_try_to_cancel' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_cancel' was exported
ERROR: modpost: vmlinux: local symbol '__hrtimer_get_remaining' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_init' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_active' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_sleeper_start_expires' was exported
ERROR: modpost: vmlinux: local symbol 'hrtimer_init_sleeper' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_hrtimeout_range_clock' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_hrtimeout_range' was exported
ERROR: modpost: vmlinux: local symbol 'schedule_hrtimeout' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_mono_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_raw_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_boot_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_tai_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_real_fast_ns' was exported
ERROR: modpost: vmlinux: local symbol 'pvclock_gtod_register_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'pvclock_gtod_unregister_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_real_ts64' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_resolution_ns' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_with_offset' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_coarse_with_offset' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_mono_to_any' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_raw' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_ts64' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_seconds' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_real_seconds' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_snapshot' was exported
ERROR: modpost: vmlinux: local symbol 'get_device_system_crosststamp' was exported
ERROR: modpost: vmlinux: local symbol 'do_settimeofday64' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_raw_ts64' was exported
ERROR: modpost: vmlinux: local symbol 'getboottime64' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_coarse_real_ts64' was exported
ERROR: modpost: vmlinux: local symbol 'ktime_get_coarse_ts64' was exported
ERROR: modpost: vmlinux: local symbol 'random_get_entropy_fallback' was exported
ERROR: modpost: vmlinux: local symbol 'clocks_calc_mult_shift' was exported
ERROR: modpost: vmlinux: local symbol '__clocksource_update_freq_scale' was exported
ERROR: modpost: vmlinux: local symbol '__clocksource_register_scale' was exported
ERROR: modpost: vmlinux: local symbol 'clocksource_change_rating' was exported
ERROR: modpost: vmlinux: local symbol 'clocksource_unregister' was exported
ERROR: modpost: vmlinux: local symbol 'get_jiffies_64' was exported
ERROR: modpost: vmlinux: local symbol 'jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'time64_to_tm' was exported
ERROR: modpost: vmlinux: local symbol 'timecounter_init' was exported
ERROR: modpost: vmlinux: local symbol 'timecounter_read' was exported
>> ERROR: modpost: vmlinux: local symbol 'timecounter_cyc2time' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_expires_remaining' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_init' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_start' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_start_relative' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_restart' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_try_to_cancel' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_cancel' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_forward' was exported
>> ERROR: modpost: vmlinux: local symbol 'alarm_forward_now' was exported
>> ERROR: modpost: vmlinux: local symbol 'posix_clock_register' was exported
>> ERROR: modpost: vmlinux: local symbol 'posix_clock_unregister' was exported
>> ERROR: modpost: vmlinux: local symbol 'clockevent_delta2ns' was exported
>> ERROR: modpost: vmlinux: local symbol 'clockevents_unbind_device' was exported
ERROR: modpost: vmlinux: local symbol 'clockevents_register_device' was exported
ERROR: modpost: vmlinux: local symbol 'clockevents_config_and_register' was exported
ERROR: modpost: vmlinux: local symbol 'tick_broadcast_oneshot_control' was exported
ERROR: modpost: vmlinux: local symbol 'get_cpu_idle_time_us' was exported
ERROR: modpost: vmlinux: local symbol 'get_cpu_iowait_time_us' was exported
ERROR: modpost: vmlinux: local symbol 'smp_call_function_single' was exported
ERROR: modpost: vmlinux: local symbol 'smp_call_function_single_async' was exported
ERROR: modpost: vmlinux: local symbol 'on_each_cpu_cond_mask' was exported
ERROR: modpost: vmlinux: local symbol 'smp_call_on_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'sprint_symbol' was exported
ERROR: modpost: vmlinux: local symbol 'sprint_symbol_build_id' was exported
ERROR: modpost: vmlinux: local symbol 'sprint_symbol_no_offset' was exported
ERROR: modpost: vmlinux: local symbol 'audit_enabled' was exported
ERROR: modpost: vmlinux: local symbol 'audit_log_task_context' was exported
ERROR: modpost: vmlinux: local symbol 'audit_log_task_info' was exported
ERROR: modpost: vmlinux: local symbol 'audit_log_start' was exported
ERROR: modpost: vmlinux: local symbol 'audit_log_end' was exported
ERROR: modpost: vmlinux: local symbol 'audit_log_format' was exported
ERROR: modpost: vmlinux: local symbol 'audit_log' was exported
ERROR: modpost: vmlinux: local symbol '__audit_inode_child' was exported
ERROR: modpost: vmlinux: local symbol '__audit_log_nfcfg' was exported
ERROR: modpost: vmlinux: local symbol 'kgdb_connected' was exported
ERROR: modpost: vmlinux: local symbol 'kgdb_active' was exported
ERROR: modpost: vmlinux: local symbol 'kgdb_register_io_module' was exported
ERROR: modpost: vmlinux: local symbol 'kgdb_unregister_io_module' was exported
ERROR: modpost: vmlinux: local symbol 'kgdb_breakpoint' was exported
ERROR: modpost: vmlinux: local symbol 'reset_hung_task_detector' was exported
ERROR: modpost: vmlinux: local symbol 'tracepoint_srcu' was exported
ERROR: modpost: vmlinux: local symbol 'tracepoint_probe_register_prio_may_exist' was exported
ERROR: modpost: vmlinux: local symbol 'tracepoint_probe_register_prio' was exported
ERROR: modpost: vmlinux: local symbol 'tracepoint_probe_register' was exported
ERROR: modpost: vmlinux: local symbol 'tracepoint_probe_unregister' was exported
ERROR: modpost: vmlinux: local symbol 'register_tracepoint_module_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'unregister_tracepoint_module_notifier' was exported
ERROR: modpost: vmlinux: local symbol 'for_each_kernel_tracepoint' was exported
ERROR: modpost: vmlinux: local symbol 'trace_clock_local' was exported
ERROR: modpost: vmlinux: local symbol 'trace_clock' was exported
ERROR: modpost: vmlinux: local symbol 'trace_clock_jiffies' was exported
ERROR: modpost: vmlinux: local symbol 'trace_clock_global' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_event_length' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_event_data' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_time_stamp' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_normalize_time_stamp' was exported
ERROR: modpost: vmlinux: local symbol '__ring_buffer_alloc' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_free' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_resize' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_change_overwrite' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_unlock_commit' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_lock_reserve' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_discard_commit' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_write' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_record_disable' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_record_enable' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_record_off' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_record_on' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_record_disable_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_record_enable_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_oldest_event_ts' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_bytes_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_entries_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_overrun_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_commit_overrun_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_dropped_events_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_read_events_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_entries' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_overruns' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_iter_reset' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_iter_empty' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_peek' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_iter_peek' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_iter_dropped' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_consume' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_read_prepare' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_read_prepare_sync' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_read_start' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_read_finish' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_iter_advance' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_size' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_reset_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_reset' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_empty' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_empty_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_swap_cpu' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_alloc_read_page' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_free_read_page' was exported
ERROR: modpost: vmlinux: local symbol 'ring_buffer_read_page' was exported
ERROR: modpost: vmlinux: local symbol 'register_ftrace_export' was exported
ERROR: modpost: vmlinux: local symbol 'unregister_ftrace_export' was exported
ERROR: modpost: vmlinux: local symbol 'trace_array_put' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_on' was exported
ERROR: modpost: vmlinux: local symbol '__trace_array_puts' was exported
ERROR: modpost: vmlinux: local symbol '__trace_puts' was exported
ERROR: modpost: vmlinux: local symbol '__trace_bputs' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_snapshot' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_snapshot_cond' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_cond_snapshot_data' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_alloc_snapshot' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_snapshot_alloc' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_snapshot_cond_enable' was exported
ERROR: modpost: vmlinux: local symbol 'tracing_snapshot_cond_disable' was exported

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

