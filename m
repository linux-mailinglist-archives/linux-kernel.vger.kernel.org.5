Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0877FD84
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbjHQSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353919AbjHQSKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EEB273C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B662D64473
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1318C433C8;
        Thu, 17 Aug 2023 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692295844;
        bh=DUyxhTKHM/J6lYxqZJHkYQUvL1uVGIGSd01KS6khEV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2nrPfiIVJOK7wd8qwZblf1yVxWwg4/wJ61ek2LSZhVcI2UgoBU9nkZGcGRNo4YiB
         GP2MWPLJNePZTuhmhCb4AVxQ/p3mZpzyH3vHwqo73zzPYBI2SdTU0pO5Zo39Ap2onn
         9AfaYhNDIUyqueOMdrh/Tt2kLpPpPB5IOGfD+dhtLtEQPmM9W4nsUrAGt/ShkQZL5g
         klUMN/3ExHl3mzaMpkKs+wIcoNMTQ9H14wLJTNL96Uffp30X0BVqogQDgxkWTOm4yI
         TM23FZRwvMOAGU8Np/Xua7DpDS0jovPie9TVMXGUY39JACNvWVlCSBO/KPexWAfhgj
         9uRoAFwtOzlBg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3245C404DF; Thu, 17 Aug 2023 15:10:41 -0300 (-03)
Date:   Thu, 17 Aug 2023 15:10:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumping a struct to a buffer in an strace like style using BTF
Message-ID: <ZN5ioUt7yxnctBnW@kernel.org>
References: <ZN1pveIr5W1ulPHh@kernel.org>
 <372712cd-d825-e5f2-bd02-b2210c6ecf61@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <372712cd-d825-e5f2-bd02-b2210c6ecf61@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 17, 2023 at 09:57:31AM +0100, Alan Maguire escreveu:
> hi Arnaldo
> 
> On 17/08/2023 01:28, Arnaldo Carvalho de Melo wrote:
> > Hi Alan,
> > 
> > 	Something I planned to do since forever is to get the contents
> > of syscall args and print in 'perf trace' using BTF, right now we have
> > things like:
> > 
> > [root@quaco ~]# perf trace -e connect* ssh localhost
> >      0.000 ( 0.342 ms): ssh/438068 connect(fd: 3, uservaddr: { .family: INET, port: 22, addr: 127.0.0.1 }, addrlen: 16) = 0
> > root@localhost's password:
> > 
> > in perf-tools-next when building with BUILD_BPF_SKEL=1 that will hook
> > into that specific syscall and collect the uservaddr sockaddr struct and
> > then pretty print it.
> > 
> > That is done manually (the last leg) in
> > tools/perf/trace/beauty/sockaddr.c:
> > 
> >   syscall_arg__scnprintf_augmented_sockaddr
> >      af_scnprintfs[family](syscall pointer contents collected via BPF)
> > 
> > which leads to struct sockaddr_in or sockaddr_in6 specific pretty
> > printers, I wanted to do what these two struct specific pretty printers
> > do but using BTF.
> > 
> > I guess this is already available, but from a _really_ quick look at
> > libbpf I couldn't find it, ideas?
> > 
> 
> This would be great! If you take a look in btf_dump.c, there's
> 
> int btf_dump__dump_type_data(struct btf_dump *d, __u32 id,
>                              const void *data, size_t data_sz,
>                              const struct btf_dump_type_data_opts *opts)
> 
> This will dump a typed representation of the data, presuming it is of
> the BTF type specified by id. You get output like
> 
> (struct net){
>   .passive = (refcount_t){
>    .refs = (atomic_t){
>    .counter = (int)2,                                       },
> ...
> 
> You need to call
> 
> struct btf_dump *btf_dump__new(const struct btf *btf,
>                                btf_dump_printf_fn_t printf_fn,
>                                void *ctx,
>                                const struct btf_dump_opts *opts)
> 
> 
> ...first to get a struct btf_dump *; as you can see above you supply
> your own print function. There are options to control indentation (tab
> versus spaces), compactness, etc. If there's something else you need
> from the perf side let me know and we can try and add it to libbpf.
> 
> I coded up a proof-of-concept example using this stuff to dump kernel
> function arguments; it's called ksnoop and is in bcc:
> 
> https://github.com/iovisor/bcc/blob/master/libbpf-tools/ksnoop.bpf.c
> https://github.com/iovisor/bcc/blob/master/libbpf-tools/ksnoop.c
> 
> ...so that will probably help with the details. You probably want a
> similar approach; something like
> 
> - foreach syscall
> 	- populate BPF map with vmlinux BTF ids of args/return types,
> 	  and associated sizes of data to store + whether it is a
> 	  pointer (since in that case we need to copy memory at pointer
> 	  address)

Right, I think I tried this approach at some point, using the type info
in the tracefs events format file, but had problems with the verifier. 

The way it works now is that you craft one BPF prog per syscall
signature, make it work, then 'perf trace' will look at all the other
signatures, using the tracefs tracepoint type info (should move to BTF)
and if they match, reuse that BPF prog:

[root@quaco ~]# perf trace -v --max-events=1 |& grep Reus
Reusing "open" BPF sys_enter augmenter for "stat"
Reusing "open" BPF sys_enter augmenter for "lstat"
Reusing "open" BPF sys_enter augmenter for "access"
Reusing "connect" BPF sys_enter augmenter for "accept"
Reusing "sendto" BPF sys_enter augmenter for "recvfrom"
Reusing "connect" BPF sys_enter augmenter for "bind"
Reusing "connect" BPF sys_enter augmenter for "getsockname"
Reusing "connect" BPF sys_enter augmenter for "getpeername"
Reusing "open" BPF sys_enter augmenter for "execve"
Reusing "open" BPF sys_enter augmenter for "truncate"
Reusing "open" BPF sys_enter augmenter for "chdir"
Reusing "open" BPF sys_enter augmenter for "mkdir"
Reusing "open" BPF sys_enter augmenter for "rmdir"
Reusing "open" BPF sys_enter augmenter for "creat"
Reusing "open" BPF sys_enter augmenter for "link"
Reusing "open" BPF sys_enter augmenter for "unlink"
Reusing "open" BPF sys_enter augmenter for "symlink"
Reusing "open" BPF sys_enter augmenter for "readlink"
Reusing "open" BPF sys_enter augmenter for "chmod"
Reusing "open" BPF sys_enter augmenter for "chown"
Reusing "open" BPF sys_enter augmenter for "lchown"
Reusing "open" BPF sys_enter augmenter for "mknod"
Reusing "open" BPF sys_enter augmenter for "statfs"
Reusing "open" BPF sys_enter augmenter for "pivot_root"
Reusing "open" BPF sys_enter augmenter for "chroot"
Reusing "open" BPF sys_enter augmenter for "acct"
Reusing "open" BPF sys_enter augmenter for "swapon"
Reusing "open" BPF sys_enter augmenter for "swapoff"
Reusing "open" BPF sys_enter augmenter for "delete_module"
Reusing "open" BPF sys_enter augmenter for "setxattr"
Reusing "open" BPF sys_enter augmenter for "lsetxattr"
Reusing "openat" BPF sys_enter augmenter for "fsetxattr"
Reusing "open" BPF sys_enter augmenter for "getxattr"
Reusing "open" BPF sys_enter augmenter for "lgetxattr"
Reusing "openat" BPF sys_enter augmenter for "fgetxattr"
Reusing "open" BPF sys_enter augmenter for "listxattr"
Reusing "open" BPF sys_enter augmenter for "llistxattr"
Reusing "open" BPF sys_enter augmenter for "removexattr"
Reusing "open" BPF sys_enter augmenter for "lremovexattr"
Reusing "fsetxattr" BPF sys_enter augmenter for "fremovexattr"
Reusing "open" BPF sys_enter augmenter for "mq_open"
Reusing "open" BPF sys_enter augmenter for "mq_unlink"
Reusing "fsetxattr" BPF sys_enter augmenter for "add_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "request_key"
Reusing "fremovexattr" BPF sys_enter augmenter for "inotify_add_watch"
Reusing "fremovexattr" BPF sys_enter augmenter for "mkdirat"
Reusing "fremovexattr" BPF sys_enter augmenter for "mknodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchownat"
Reusing "fremovexattr" BPF sys_enter augmenter for "futimesat"
Reusing "fremovexattr" BPF sys_enter augmenter for "newfstatat"
Reusing "fremovexattr" BPF sys_enter augmenter for "unlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "linkat"
Reusing "open" BPF sys_enter augmenter for "symlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "readlinkat"
Reusing "fremovexattr" BPF sys_enter augmenter for "fchmodat"
Reusing "fremovexattr" BPF sys_enter augmenter for "faccessat"
Reusing "fremovexattr" BPF sys_enter augmenter for "utimensat"
Reusing "connect" BPF sys_enter augmenter for "accept4"
Reusing "fremovexattr" BPF sys_enter augmenter for "name_to_handle_at"
Reusing "fremovexattr" BPF sys_enter augmenter for "renameat2"
Reusing "open" BPF sys_enter augmenter for "memfd_create"
Reusing "fremovexattr" BPF sys_enter augmenter for "execveat"
Reusing "fremovexattr" BPF sys_enter augmenter for "statx"
[root@quaco ~]#

[root@quaco ~]# perf trace -e access*,clock_nano*,connect*,perf_event* -a --max-events=40 perf stat -e dummy sleep 1
     0.000 ( 0.007 ms): perf/470570 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
     9.319 ( 0.008 ms): perf/470570 access(filename: "/etc/selinux/config")                               = 0
     9.826 ( 0.007 ms): perf/470570 access(filename: "/home/acme/etc/perfconfig", mode: R)                = -1 ENOENT (No such file or directory)
    10.213 ( 0.019 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/software/cpus", mode: R) = -1 ENOENT (No such file or directory)
    10.786 ( 0.006 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/power/cpus", mode: R) = -1 ENOENT (No such file or directory)
    10.794 ( 0.004 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uprobe/cpus", mode: R) = -1 ENOENT (No such file or directory)
    10.800 ( 0.004 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_imc/cpus", mode: R) = -1 ENOENT (No such file or directory)
    16.520 ( 0.008 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/cstate_core/cpus", mode: R) = -1 ENOENT (No such file or directory)
    17.072 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_2/cpus", mode: R) = -1 ENOENT (No such file or directory)
    17.645 ( 0.008 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/breakpoint/cpus", mode: R) = -1 ENOENT (No such file or directory)
    18.058 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_0/cpus", mode: R) = -1 ENOENT (No such file or directory)
    18.626 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/tracepoint/cpus", mode: R) = -1 ENOENT (No such file or directory)
    19.040 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/cstate_pkg/cpus", mode: R) = -1 ENOENT (No such file or directory)
    19.673 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_arb/cpus", mode: R) = -1 ENOENT (No such file or directory)
    20.187 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/kprobe/cpus", mode: R) = -1 ENOENT (No such file or directory)
    20.636 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/i915/cpus", mode: R)  = -1 ENOENT (No such file or directory)
    21.497 ( 0.008 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/msr/cpus", mode: R)   = -1 ENOENT (No such file or directory)
    22.060 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_3/cpus", mode: R) = -1 ENOENT (No such file or directory)
    22.620 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/intel_pt/cpus", mode: R) = -1 ENOENT (No such file or directory)
    23.318 ( 0.007 ms): perf/470570 access(filename: "/sys/bus/event_source/devices/uncore_cbox_1/cpus", mode: R) = -1 ENOENT (No such file or directory)
    24.483 (13.009 ms): perf/470570 perf_event_open(attr_uptr: { type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x9 (PERF_COUNT_SW_DUMMY), sample_type: IDENTIFIER, read_format: TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING, disabled: 1, inherit: 1, enable_on_exec: 1, exclude_guest: 1 }, pid: 470571 (perf), cpu: -1, group_fd: -1, flags: FD_CLOEXEC) = 3
    38.183 ( 0.005 ms): sleep/470571 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
         ? (         ): pool-gsd-smart/3641  ... [continued]: clock_nanosleep())                                  = 0
    38.717 (         ): sleep/470571 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7ffd966420b0) ...
    38.717 (1000.132 ms): sleep/470571  ... [continued]: clock_nanosleep())                                  = 0

 Performance counter stats for 'sleep 1':

                 0      dummy                                                                 

       1.001968793 seconds time elapsed

       0.000853000 seconds user
       0.000795000 seconds sys


[root@quaco ~]#

As in some cases BTF nor the tracefs format file can help, as in write,
that has "const char *" as the type for its "buf" arg, that has the size
as the third argument, so we need to craft the BPF program for it.

I'll try first to work on the userspace use of BTF to pretty print the
payload collected.

> Then the bpf program can use that info to copy the right amount of
> memory to the associated buffer and dump it to userspace for display.
> 
> This would allow you to have a generic augmented raw syscall BPF
> program; it would just need a way to look up the appropriate map entry
> describing its arguments etc. ksnoop does this by storing the map
> entries by function address, and in kprobe context it then looks up the
> instruction pointer to get the right map entry.
> 
> There's more info at
> 
> https://blogs.oracle.com/linux/post/kernel-data-centric-tracing

All cool stuff! I'll try and use it in 'perf trace'.

ksnoop is really great, made me remind of something I did a long time
ago, before BPF/BTF/kprobes (and then using kprobes), that produced
this:

http://vger.kernel.org/~acme/ostra/callgraphs/sock/0xf61bf500/

Not centered on collecting function arguments and pretty printing them,
but on integer types in a particular class that one wanted to see how
evolved over its lifetime.

- Arnaldo
