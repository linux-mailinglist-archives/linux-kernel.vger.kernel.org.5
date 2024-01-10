Return-Path: <linux-kernel+bounces-22790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A7E82A2E4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9CB28281F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12B4F1EF;
	Wed, 10 Jan 2024 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YjtzUWxR"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F227D4E1C6;
	Wed, 10 Jan 2024 20:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1704920027;
	bh=rBlGuLxYhPO4Q5+DuTMP3udTcgw/RgKOGGYRl4n1514=;
	h=Date:To:From:Subject:From;
	b=YjtzUWxRRez+XoxmspiC3XRAaDzLmC/z22Ev4zgL2hJzydWRpAnPOyPE9l6K3jKk3
	 7LUeEpSUKCLv+7I/NCHET8BkXn63497FAFjJHLjD7guQXBFqwiwEnZBbrbez6Rs/OF
	 +3E3O44ilNeox6QUTv8BM9h3EujC3ysEAo/Jj1k6cLkJT0aob7vKDzSBi/ZoQD8gEF
	 mpzEg/fnx7Sxk4S5cpvlS9e+5JYQdqlatzzG7AxU/vHyfIoQ9xtTEJAo8ceo2kkavJ
	 2cipI7vblDq2bsGD5DB4tDPYrl9bReryYFTadtTMJA4qCjM++0cECelgFm+bPcqDAJ
	 AhjYFHcARmMnw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4T9Klb5fFTzKc8;
	Wed, 10 Jan 2024 15:53:47 -0500 (EST)
Message-ID: <3c38a8f7-8323-46b2-a29a-2ca06bc60448@efficios.com>
Date: Wed, 10 Jan 2024 15:53:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: lttng-dev <lttng-dev@lists.lttng.org>,
 Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
 linux-trace-users <linux-trace-users@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.15 and 2.13.11 (Linux kernel tracer)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New and noteworthy in these releases:

Newer Linux kernels (v6.6 and v6.7) are now supported by LTTng modules
2.13.11. If you need support for recent kernels (v5.18+), you will
need to upgrade to a recent LTTng-modules 2.13.x.

The "prio" context has been fixed in 2.13.11 to eliminate a crash
triggered by calling a NULL pointer address when using the "prio"
context (lttng add-context -k -t prio). This issue was introduced
when refactoring the prio context code during the 2.13 development.
The missing initialization was re-introduced, and the use of the kernel
"task_prio()" symbol was entirely replaced by inlining a copy of this
trivial function into lttng-modules instead.

The "built-in.sh" script which can be used to add a link to lttng-modules
within a kernel source tree to built LTTng into a Linux kernel image
has been updated to adapt to changes introduced in Linux v6.1.

A work-around to ensure that LTTng-modules works fine on CPUs and kernels
with IBT support enabled has been integrated:

     When the Intel IBT feature is enabled, a CPU supporting this feature
     validates that all indirect jumps/calls land on an ENDBR64 instruction.
     
     The kernel seals functions which are not meant to be called indirectly,
     which means that calling functions indirectly from their address fetched
     using kallsyms or kprobes trigger a crash.
     
     Use the MSR_IA32_S_CET CET_ENDBR_EN MSR bit to temporarily disable ENDBR
     validation around indirect calls to kernel functions. Considering that
     the main purpose of this feature is to prevent ROP-style attacks,
     disabling the ENDBR validation temporarily around the call from a kernel
     module does not affect the ROP protection.


Both 2.13.11 and 2.12.15:

- Fix an issue with importing VFS namespace for Android kernels.

- Fix build for RHEL 8.8 with linux 4.18.0-477.10.1+

- Fix a hardening OOPS during validation of immediate strings in the bytecode
   validator when CONFIG_UBSAN_BOUNDS and/or CONFIG_FORTIFY_SOURCE are
   configured. It boils down to changing 0-len arrays to flexible arrays
   to let the toolchain know about our intent.

- Add Ubuntu Kinetic kernel ranges for jbd2 instrumentation.

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

Detailed change logs:

2024-01-10 (National Houseplant Appreciation Day) LTTng modules 2.13.11
         * Fix: Include linux/sched/rt.h for kernels v3.9 to v3.14
         * Fix: Disable IBT around indirect function calls
         * Inline implementation of task_prio()
         * Fix: prio context NULL pointer exception
         * Fix: MODULE_IMPORT_NS is introduced in kernel 5.4
         * Android: Import VFS namespace for android common kernel
         * Fix: get_file_rcu is missing in kernels < 4.1
         * fix: lookup_fd_rcu replaced by lookup_fdget_rcu in linux 6.7.0-rc1
         * fix: mm, vmscan signatures changed in linux 6.7.0-rc1
         * fix: phys_proc_id and cpu_core_id moved in linux 6.7.0-rc1
         * Fix build for RHEL 8.8 with linux 4.18.0-477.10.1+
         * Fix: bytecode validator: oops during validation of immediate string
         * fix: lttng-probe-kvm-x86-mmu build with linux 6.6
         * fix: built-in lttng with kernel >= v6.1
         * fix: ubuntu kinetic kernel range for jdb2

2024-01-10 (National Houseplant Appreciation Day) 2.12.15
         * Fix: MODULE_IMPORT_NS is introduced in kernel 5.4
         * Android: Import VFS namespace for android common kernel
         * Fix build for RHEL 8.8 with linux 4.18.0-477.10.1+
         * Fix: bytecode validator: oops during validation of immediate string
         * fix: ubuntu kinetic kernel range for jdb2

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

