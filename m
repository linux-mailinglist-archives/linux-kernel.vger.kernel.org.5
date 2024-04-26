Return-Path: <linux-kernel+bounces-160776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4492A8B42C3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7FD2824F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051263BBDC;
	Fri, 26 Apr 2024 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=elastic.org header.i=@elastic.org header.b="hmjzPuIS"
Received: from elastic.org (elastic.org [96.126.110.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6721101
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.126.110.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714174449; cv=none; b=Tydh/0Rq8eIwIKBU95JGc7f0q/Q7mtDC064SBxgfqZZG0HgrupxXr97wUbBSwx6qUD3d2Vp+tpF2NYosWkp1IejNrsiXf46nYCKUzvKV+Cct2yvRpcMdNljhakuqaGuWTnTPkXu/YKPVZVplXDkHPuGiRRdSmchRVgcOCeZTdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714174449; c=relaxed/simple;
	bh=rVRubp/8Rpau/MrUBO8BqCrbU17HV86vZzNJm5cnZak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IkF9Ubq/3kawJc8aCGsAMmoVywTM19VP5wDKdJdv7vW+9dF8GS6jq988TtnXGZtKrqmItAt+JwM9///cMbS7I3G/bxBeCdXUpsiBFojd916SxTMCKmItnqqyd+Ep+Jniu8TUVsTrV5wosLoThi3PSOS6nZnCtxSKN8for1IWScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elastic.org; spf=pass smtp.mailfrom=elastic.org; dkim=pass (2048-bit key) header.d=elastic.org header.i=@elastic.org header.b=hmjzPuIS; arc=none smtp.client-ip=96.126.110.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=elastic.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elastic.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=elastic.org
	; s=default2; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A45bIcCWCckLUxd7Oa2DPmgXto+M5gba9+jddnb/u8o=; b=hmjzPuIStzI/O9TH7X2whYLRJ/
	qItbw/P3UeGpO+4COJn0Qpw2XUlkKsHzUFb/XhxxroFAz0QkJQXW75Grte1kyCFvuJZPZa1XIvZpx
	lequOxxwGwSl4hrcrTw2z54KEm5rpvI0bM3U4k+25ZTv5jCRwmw9G6vsX7o7WBPjLS4olWoVAJcDR
	/Fs5EVHAzSn32J0uaEFL/2xpmEnu1bvOO2jsZf3iL9ehEshKc5BCjHH5Q0ycgnnLxr5TOE90JvcrB
	xUcJ7fB93AIxqtAqBrsfBezj+w8DjZmKC49zO9cjsw3Vqga+FC2RWdHC48JK4LQWF0idnhFNFD+Pi
	a31Sq32Q==;
Received: from vpn-home.elastic.org ([10.0.0.2] helo=elastic.org)
	by elastic.org with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <fche@elastic.org>)
	id 1s0U4Z-0000000049Z-3qJV;
	Fri, 26 Apr 2024 22:29:39 +0000
Received: from very.elastic.org ([192.168.1.1])
	by elastic.org with esmtp (Exim 4.97.1)
	(envelope-from <fche@elastic.org>)
	id 1s0U4Z-00000000OEO-2TCY;
	Fri, 26 Apr 2024 18:29:39 -0400
Received: from fche by very.elastic.org with local (Exim 4.97.1)
	(envelope-from <fche@very.elastic.org>)
	id 1s0U4Z-000000030Ug-2CkJ;
	Fri, 26 Apr 2024 18:29:39 -0400
Date: Fri, 26 Apr 2024 18:29:39 -0400
From: "Frank Ch. Eigler" <fche@elastic.org>
To: systemtap@sourceware.org
Cc: linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap release 5.1
Message-ID: <Ziwq0ym38MBN1iOD@elastic.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Sender-Verification: ""


The SystemTap team announces release 5.1

  An experimental "--build-as=USER" flag to reduce privilege during
  script compilation.  Dynamic namespace switching for processes
  targeted via "-x PID", for probing containerized processes.  New
  probe points for userland hardware breakpoints/watchpoints.  Support
  for --remote=bpf operation.  Improved message transport robustness.

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-5.1 (commit 3a0c9c15163)

  There have been over 110 commits since the last release.
  There have been over 40 bugs fixed / features added since the last release.

= SystemTap frontend (stap) changes

- An experimental "--build-as=USER" flag to reduce privilege during
  script compilation, which is a security improvement effort.

- New probe-points for userland hardware breakpoints/watchpoints
  targeting processes (PR31180):
    probe process.data(ADDRESS).write
    probe process.data(ADDRESS).rw
    probe process.data(ADDRESS).length(LEN).write
    probe process.data(ADDRESS).length(LEN).rw
                
- Support for stap --remote=bpf.

- Improved searching heuristics for probing symbol names with/without
  symbol-version suffixes and with/without weak names.

- Made long-running debuginfod downloads more cleanly interruptible.

- Improved stap-prep heuristics for finding debuginfo for "-rt"
  (real-time) kernels.

= SystemTap backend changes

- Dynamic namespace switching for processes targeted via "-x PID",
  allowing processes running within containers to be probed.

- Improved message transport robustness for heavy traffic (individual
  messages spanning pages) and for short runs (avoiding loss of
  last-gasp messages).

- Added MTAG macro on several internal memory allocation routines
  to improve leak warnings.  Corrected a bunch of leaks.

- "stap -t" now reports module initialization timings too.

- Ported runtime for GCC14 compatibility, with its more recent C
  dialect warnings.

- Support for DW_OP_bra in DWARF location lists, which makes a few
  more $context variables accessible to systemtap.

= SystemTap tapset changes

- Portability fixes for more recent kernels, as always.

- set_kernel_string* tapset functions improved range checking.

- print_ubacktrace_fileline() works with PIE binaries.

- Many portability improvements and some fixes in the testsuite.

- Enhancements for the tcp, nfs, memory tapsets.

= SystemTap sample scripts

* All 190+ examples can be found at https://sourceware.org/systemtap/examples/

= Examples of tested kernel versions

  3.10.0 (RHEL7)
  4.18.0 (RHEL8 + CentOS Stream 8 x86_64, aarch64, ppc64le, s390x)
  5.14.0 (RHEL9 + CentOS Stream 9 x86_64, aarch64, ppc64le, s390x)
  6.4.15 (Fedora 38 x86_64)
  6.8.7 (Fedora 39 x86_64)
  6.9.0-rc (Fedora rawhide x86_64)
  
= Contributors for this release

Aaron Merey, Carl Shapiro*, Di Chen, Frank Ch. Eigler, Martin Cermak,
Sergei Trofimovich, Tim Haines*, Victor Kamensky, William Cohen,
Xinhua Li*, Yichun Zhang (agentzh)

Special thanks to new contributors, marked with '*' above.

= Bugs fixed for this release <https://sourceware.org/PR#####>

31020  Use of symlinks in probe process(PATH).* would confuse task finder when matching procname
31014  Uprobes registered in task finder would block the target processes for long time
31051  Error handling is incomplete in the early uprobe registration code
31052  enabling -DDEBUG_MEMALLOC_MIGHT_SLEEP results in a lot of kernel errors
31053  The stap runtime's allocator might sleep in atomic contexts
31054  non-system-wide perf event probes should not use work queues for registration
31024  uprobes might work on the fake proxy inodes instead of the real inodes when overlay fs is used
31074  On aarch64 the systemtap.base/set_kernel.stp triggers "Unable to handle kernel paging request"
30999  _kretprobe_data needs to be adjusted to support changes in the kernel's struct kretprobe_instance
18320  ring_buffer.exp error: implicit declaration of function '__get_cpu_var'
27803  doc/SystemTap_Tapset_Reference/tapsets.pdf is removed during cleaning but not rebuilt
31039  implicit declaration of function ‘stap_task_finder_complete’
31176  Spin lock deadlocks in memory pool allocations for mixed NMI and non-NMI contexts
31180  Feature request: new probe process.data(ADDR).* probe-points
31060  Early uprobe registration and task-finder target executable path resolving should switch mount namespace to the target process's
31215  @__compat_task misbehaves on RHEL9 x86_64
31235  systemtap ../configure --with-dyninst=<path> doesn't propagate <path>
31242  Support namespaced include directories in Dyninst
31280  add configury option to disable -Werror
26843  print_ubacktrace_fileline() fails with PIE binaries
31288  5.0: build fails with gcc 14x
31309  Recent PIE binary support cause fileline-profile.stp example to crash the machine
29997  search elf symbol table for aliases (fopen -> _IO_new_fopen)
31373  Allow systemtap to work on kernels without strlcpy (removed in the linux-6.8.0-rc3 kernels)
18851  new --interactive mode
19360  Verify that examples and tapsets with return probes use @entry for function arguments
31274  Unsatisfied references to _stp_module_0_debug_line_str
26811  adapt to kernel 5.10 set_fs() removal
31404  Systemtap unable to find kernel.trace("*") probe points on Fedora rawhide Linux 6.8 kernels
31368  make debuginfod downloads interruptible
31117  transport failures
30716  On x86_64 get objtool warnings: call to __get_user_nocheck_1() with UACCESS enabled
31490  add some tcp.stp tapset extensions
31491  support --remote=bpf
31495  stap-prep support for kernel-rt
31472  systemtap.base/tracepoints.stp causes reboot with RHEL9 linux 5.14.0-428.el9.x86_64
31519  sys/sdt.h causes compiler warnings when compiling with C++
31525  some smp_processor_id warnings during make installcheck
31500  stapio exited with irqs disabled
31616  Fix git_pretty_rev error,git_build checks in git_version.sh
31496  support DW_OP_bra (conditional branches) in dwarf location lists
31597  Systemtap not extracting all the data sent to the print data in the buffers before shutdown

