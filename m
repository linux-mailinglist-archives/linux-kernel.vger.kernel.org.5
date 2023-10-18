Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8117CDFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbjJROev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346148AbjJROeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:34:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6C449D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 07:32:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC7DC433C8;
        Wed, 18 Oct 2023 14:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697639548;
        bh=4FEwqJ929JAqfUaP3HMuPeYHbZMSPU9FcgWhb7gRou8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c4QJtwVf7GipsAh6O4D12K+Dz/6Tvr//wwczIEzjDOtYEymAH4NVxJtrNNqOeh4U/
         bNliXOKKZm3AQaC7LBWPQenl7k9FYu0JQ5Pjxf4EkQ+ndennpK16xxWvV2EZeVYnqt
         osqN9ONbzqnw/VCNaDwCf2mAfEnasJTBOCKaU5+vLt3eGydYYbuZYu9BOb+zjW5mN1
         uhI1AqRCKoE+ku2x8LZObRZ+Dyw3iQoV1U9CR0Ex5JUZolBq6tz4JLhJphSEvZIG9A
         qwYf60lUmVls8oLFaetkwxvh1fuwnElxUO99BtxePZfCXjnEo1R7JDvMVT53bXNoQx
         AD3wk5riYs1Kg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 130A640016; Wed, 18 Oct 2023 11:32:25 -0300 (-03)
Date:   Wed, 18 Oct 2023 11:32:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iii@linux.ibm.com, irogers@google.com, svens@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] perf test: test case 111 fails on s390
Message-ID: <ZS/seVMNrV6j6z1J@kernel.org>
References: <20231018064441.2751317-1-tmricht@linux.ibm.com>
 <ZS/mKa1Sk4hhJ/zY@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS/mKa1Sk4hhJ/zY@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 18, 2023 at 11:05:29AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Oct 18, 2023 at 08:44:41AM +0200, Thomas Richter escreveu:
> > Perf test case 111 Check open filename arg using perf trace + vfs_getname
> > fails on s390. This is caused by a failing function
> > bpf_probe_read() in file util/bpf_skel/augmented_raw_syscalls.bpf.c.
> 
> 
> Please change the patch subject to describe what is being really fixed
> instead of the test that spotted the problem, i.e. something like:
> 
> perf trace: Use the right bpf_probe_read(_str) variant for reading user data
> 
> But then shouldn't all those use bpf_probe_read_user(_str)?
> 
> As it is reading arguments to the syscall, that are coming from
> userspace, i.e. both open/openat/etc path/filename, clock_nanosleep rqtp
> args (and connect sockaddr, etc) comes from userspace.

So, with your patch, on x86_64, I get:

^C[root@five ~]# perf trace -e connect*
     0.000 ( 0.021 ms): DNS Res~ver #1/8756 connect(fd: 229, uservaddr: { .family: UNSPEC }, addrlen: 42)         = 0
     0.544 ( 0.011 ms): DNS Res~ver #1/8756 connect(fd: 229, uservaddr: { .family: UNSPEC }, addrlen: 16)         = 0
     0.569 ( 0.009 ms): DNS Res~ver #1/8756 connect(fd: 229, uservaddr: { .family: UNSPEC }, addrlen: 28)         = -1 ENETUNREACH (Network is unreachable)

I.e. it loads the resulting BPF bytecode but doesn't manage to copy the
sockaddr in userspace pointed by connect's uservaddr argument.

We need to use bpf_probe_read_kernel() for the tracepoint payload, in
the raw_syscalls/sys_enter and raw_syscalls/sys_exit handlers, as that
is kernel memory, but in the syscall specific BPF programs we need to
use bpf_probe_read_user() to get things like sockaddr, etc, i.e.
userspace contents.

With the patch below:

[root@five ~]# perf trace -e connect*
     0.000 ( 0.128 ms): pool/2690 connect(fd: 7, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) = 0
   304.127 ( 0.018 ms): DNS Resolver #/6524 connect(fd: 556, uservaddr: { .family: LOCAL, path: /run/systemd/resolve/io.systemd.Resolve }, addrlen: 42) = 0
   304.554 ( 0.016 ms): systemd-resolv/1167 connect(fd: 24, uservaddr: { .family: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) = 0
   304.650 ( 0.009 ms): systemd-resolv/1167 connect(fd: 25, uservaddr: { .family: INET, port: 53, addr: 192.168.86.1 }, addrlen: 16) = 0
   318.952 ( 0.009 ms): DNS Resolver #/6524 connect(fd: 556, uservaddr: { .family: INET, port: 0, addr: 216.239.38.177 }, addrlen: 16) = 0
   318.965 ( 0.003 ms): DNS Resolver #/6524 connect(fd: 556, uservaddr: { .family: UNSPEC }, addrlen: 16)         = 0
   318.970 ( 0.004 ms): DNS Resolver #/6524 connect(fd: 556, uservaddr: { .family: INET, port: 0, addr: 216.239.34.177 }, addrlen: 16) = 0
   318.977 ( 0.002 ms): DNS Resolver #/6524 connect(fd: 556, uservaddr: { .family: UNSPEC }, addrlen: 16)         = 0

You can test before/after with:

 # perf trace -e connect*,clo*sleep

To see clock_nanosleep rqtp args as well:

Before:

   999.107 (         ): gnome-terminal/3285 clock_nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 0 }, rmtp: 0x7ffdd373adb0) ...
  1000.228 (         ): pool-gsd-smart/3140 clock_nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 0 }, rmtp: 0x7f85b61fec90) ...
  1030.375 (         ): gnome-terminal/3285 clock_nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 0 }, rmtp: 0x7ffdd373adb0) ...
  1061.694 (         ): gnome-terminal/3285 clock_nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 0 }, rmtp: 0x7ffdd373adb0) ...


after:

  1000.198 (1000.035 ms): pool-gsd-smart/3140 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f85b61fec90) = 0
  2000.302 (1000.036 ms): pool-gsd-smart/3140 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f85b61fec90) = 0
  3000.410 (1000.037 ms): pool-gsd-smart/3140 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f85b61fec90) = 0
  4000.518 (1000.035 ms): pool-gsd-smart/3140 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 0 }, rmtp: 0x7f85b61fec90

[root@five ~]# perf trace -e *sleep sleep 1.234567890
     0.000 (1234.630 ms): sleep/64495 clock_nanosleep(rqtp: { .tv_sec: 1, .tv_nsec: 234567890 }, rmtp: 0x7ffdf49af4a0) = 0
[root@five ~]#

- Arnaldo

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index cc22bccfc178229a..52c270330ae0d2f3 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -203,7 +203,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	_Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
-	bpf_probe_read_kernel(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -221,7 +221,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	socklen &= sizeof(augmented_args->saddr) - 1;
 
-	bpf_probe_read_kernel(&augmented_args->saddr, socklen, sockaddr_arg);
+	bpf_probe_read_user(&augmented_args->saddr, socklen, sockaddr_arg);
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
@@ -311,7 +311,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
         if (augmented_args == NULL)
 		goto failure;
 
-	if (bpf_probe_read_kernel(&augmented_args->__data, sizeof(*attr), attr) < 0)
+	if (bpf_probe_read_user(&augmented_args->__data, sizeof(*attr), attr) < 0)
 		goto failure;
 
 	attr_read = (const struct perf_event_attr_size *)augmented_args->__data;
@@ -325,7 +325,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
                 goto failure;
 
 	// Now that we read attr->size and tested it against the size limits, read it completely
-	if (bpf_probe_read_kernel(&augmented_args->__data, size, attr) < 0)
+	if (bpf_probe_read_user(&augmented_args->__data, size, attr) < 0)
 		goto failure;
 
 	return augmented__output(args, augmented_args, len + size);
@@ -347,7 +347,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	if (size > sizeof(augmented_args->__data))
                 goto failure;
 
-	bpf_probe_read_kernel(&augmented_args->__data, size, rqtp_arg);
+	bpf_probe_read_user(&augmented_args->__data, size, rqtp_arg);
 
 	return augmented__output(args, augmented_args, len + size);
 failure:
