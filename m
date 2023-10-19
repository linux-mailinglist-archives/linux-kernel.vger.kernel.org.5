Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2B7D029C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 21:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346282AbjJSTfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 15:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjJSTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 15:35:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7824DE8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:34:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFCBC433C7;
        Thu, 19 Oct 2023 19:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697744099;
        bh=y0Oo/V8pFGO99f5tyMwTJJOuq+D/cyDMJbhKLfmUT9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U71qwD41v+d3QbOh2thoWU9GVnnqqScVP7tb0JvXuxyyAiB1Tj28QiRqInINGE7ZE
         VuoD0XKC/M0xwah3mmc5GL+1GlNDnd2R0kkQ0oOLMup7FfWt2zelNxbJhHZcYaa6Gj
         t6tbK4k5sO5dwT31UPnO6HFxE61WWUWf85VDdDmlvATiw9FebVdigNkxtbWvL3LATh
         10yoef3KI3XVagbl16XincJumt/pD0FaE7uq9tU6eFgvP7w1gskelQcrOgkutfKrCw
         xspYi1Itb5mVe/FWXG0B+EvXz4ILcPwFwRLWaG1XNSZYtBe98NTCkfJVE0o8pC8XS5
         puOidhPyt7hZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B8A1440016; Thu, 19 Oct 2023 16:34:55 -0300 (-03)
Date:   Thu, 19 Oct 2023 16:34:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iii@linux.ibm.com, irogers@google.com, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf trace: Use the right bpf_probe_read(_str) variant
 for reading user data
Message-ID: <ZTGE3zpd3yC2yqxo@kernel.org>
References: <20231019082642.3286650-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019082642.3286650-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 19, 2023 at 10:26:42AM +0200, Thomas Richter escreveu:
> Perf test case 111 Check open filename arg using perf trace + vfs_getname
> fails on s390. This is caused by a failing function
> bpf_probe_read() in file util/bpf_skel/augmented_raw_syscalls.bpf.c.
> 
> The root cause is the lookup by address. Function bpf_probe_read()
> is used. This function works only for architectures
> with ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
> 
> On s390 is not possible to determine from the address to which
> address space the address belongs to (user or kernel space).
> 
> Replace bpf_probe_read() by bpf_probe_read_kernel()
> and bpf_probe_read_str() by bpf_probe_read_user_str() to
> explicity specify the address space the address refers to.

Thanks,
 
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo

> Output before:
>  # ./perf trace -eopen,openat -- touch /tmp/111
>  libbpf: prog 'sys_enter': BPF program load failed: Invalid argument
>  libbpf: prog 'sys_enter': -- BEGIN PROG LOAD LOG --
>  reg type unsupported for arg#0 function sys_enter#75
>  0: R1=ctx(off=0,imm=0) R10=fp0
>  ; int sys_enter(struct syscall_enter_args *args)
>  0: (bf) r6 = r1           ; R1=ctx(off=0,imm=0) R6_w=ctx(off=0,imm=0)
>  ; return bpf_get_current_pid_tgid();
>  1: (85) call bpf_get_current_pid_tgid#14      ; R0_w=scalar()
>  2: (63) *(u32 *)(r10 -8) = r0 ; R0_w=scalar() R10=fp0 fp-8=????mmmm
>  3: (bf) r2 = r10              ; R2_w=fp0 R10=fp0
>  ;
>  .....
>  lines deleted here
>  .....
>  23: (bf) r3 = r6              ; R3_w=ctx(off=0,imm=0) R6=ctx(off=0,imm=0)
>  24: (85) call bpf_probe_read#4
>  unknown func bpf_probe_read#4
>  processed 23 insns (limit 1000000) max_states_per_insn 0 \
> 	 total_states 2 peak_states 2 mark_read 2
>  -- END PROG LOAD LOG --
>  libbpf: prog 'sys_enter': failed to load: -22
>  libbpf: failed to load object 'augmented_raw_syscalls_bpf'
>  libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -22
>  ....
> 
> Output after:
>  # ./perf test -Fv 111
>  111: Check open filename arg using perf trace + vfs_getname          :
>  --- start ---
>      1.085 ( 0.011 ms): touch/320753 openat(dfd: CWD, filename: \
> 	"/tmp/temporary_file.SWH85", \
> 	flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
>  ---- end ----
>  Check open filename arg using perf trace + vfs_getname: Ok
>  #
> 
> Test with the sleep command shows:
> Output before:
>  # ./perf trace -e *sleep sleep 1.234567890
>      0.000 (1234.681 ms): sleep/63114 clock_nanosleep(rqtp: \
>          { .tv_sec: 0, .tv_nsec: 0 }, rmtp: 0x3ffe0979720) = 0
>  #
> 
> Output after:
>  # ./perf trace -e *sleep sleep 1.234567890
>      0.000 (1234.686 ms): sleep/64277 clock_nanosleep(rqtp: \
>          { .tv_sec: 1, .tv_nsec: 234567890 }, rmtp: 0x3fff3df9ea0) = 0
>  #
> 
> Fixes: 14e4b9f4289a ("perf trace: Raw augmented syscalls fix libbpf 1.0+ compatibility")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Co-developed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> ---
>  .../util/bpf_skel/augmented_raw_syscalls.bpf.c   | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> index 939ec769bf4a..52c270330ae0 100644
> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> @@ -153,7 +153,7 @@ static inline
>  unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
>  {
>  	unsigned int augmented_len = sizeof(*augmented_arg);
> -	int string_len = bpf_probe_read_str(&augmented_arg->value, arg_len, arg);
> +	int string_len = bpf_probe_read_user_str(&augmented_arg->value, arg_len, arg);
>  
>  	augmented_arg->size = augmented_arg->err = 0;
>  	/*
> @@ -203,7 +203,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
>  	_Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
>  	socklen &= sizeof(augmented_args->saddr) - 1;
>  
> -	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
> +	bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg);
>  
>  	return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -221,7 +221,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
>  
>  	socklen &= sizeof(augmented_args->saddr) - 1;
>  
> -	bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
> +	bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg);
>  
>  	return augmented__output(args, augmented_args, len + socklen);
>  }
> @@ -311,7 +311,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>          if (augmented_args == NULL)
>  		goto failure;
>  
> -	if (bpf_probe_read(&augmented_args->__data, sizeof(*attr), attr) < 0)
> +	if (bpf_probe_read_user(&augmented_args->__data, sizeof(*attr), attr) < 0)
>  		goto failure;
>  
>  	attr_read = (const struct perf_event_attr_size *)augmented_args->__data;
> @@ -325,7 +325,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
>                  goto failure;
>  
>  	// Now that we read attr->size and tested it against the size limits, read it completely
> -	if (bpf_probe_read(&augmented_args->__data, size, attr) < 0)
> +	if (bpf_probe_read_user(&augmented_args->__data, size, attr) < 0)
>  		goto failure;
>  
>  	return augmented__output(args, augmented_args, len + size);
> @@ -347,7 +347,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
>  	if (size > sizeof(augmented_args->__data))
>                  goto failure;
>  
> -	bpf_probe_read(&augmented_args->__data, size, rqtp_arg);
> +	bpf_probe_read_user(&augmented_args->__data, size, rqtp_arg);
>  
>  	return augmented__output(args, augmented_args, len + size);
>  failure:
> @@ -385,7 +385,7 @@ int sys_enter(struct syscall_enter_args *args)
>  	if (augmented_args == NULL)
>  		return 1;
>  
> -	bpf_probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
> +	bpf_probe_read_kernel(&augmented_args->args, sizeof(augmented_args->args), args);
>  
>  	/*
>  	 * Jump to syscall specific augmenter, even if the default one,
> @@ -406,7 +406,7 @@ int sys_exit(struct syscall_exit_args *args)
>  	if (pid_filter__has(&pids_filtered, getpid()))
>  		return 0;
>  
> -	bpf_probe_read(&exit_args, sizeof(exit_args), args);
> +	bpf_probe_read_kernel(&exit_args, sizeof(exit_args), args);
>  	/*
>  	 * Jump to syscall specific return augmenter, even if the default one,
>  	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
> -- 
> 2.41.0
> 

-- 

- Arnaldo
