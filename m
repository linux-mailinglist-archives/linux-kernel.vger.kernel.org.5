Return-Path: <linux-kernel+bounces-128759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4CC895F61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74593284AE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB8215E817;
	Tue,  2 Apr 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPubb/CO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876F65BAD7;
	Tue,  2 Apr 2024 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095892; cv=none; b=nVv32482NYpRvAMXlWbCm8d8MZtlg1QUj+MXDfNPPB4L2xzfOO+DcBYLdIl8AsQDmSNS4/amYfzwOrFlI0C0H/dQM8woFpzQjtKe1U3orEWUvXPkQj01QW6/RhRDPF1nwCVaAZU+GDQZO75uMq/SQVdNE5CMMA6eTQqgh1Ta6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095892; c=relaxed/simple;
	bh=eouHbxMsv+t7Me0mP2Z17ab6jahoEK8QcwBdSL2exD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi3kLPCTsybELgkRM+FuqL7AGydqA3AXYo9JDrLvybZKxqiZF6Vqv6MGe+QjrP6f28s1gOR4kRD6fuONbTQVcVcWSPR0VoFiAYctDnSna8DCqceGO9EluB1QT+zS5grrz7/lSc/wcpX15yIR8N96lCTDH/H2cK4mTMAXC1exmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPubb/CO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94CDC433C7;
	Tue,  2 Apr 2024 22:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712095891;
	bh=eouHbxMsv+t7Me0mP2Z17ab6jahoEK8QcwBdSL2exD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sPubb/CO6srt+cuZXB4LyXVhsiPKVfs3CYdtlBemFrNcYUQdbAqwPmgRq2wFSHa3x
	 NNanvVMLe6h8z63Ob1KKwtCMIOHVu8NJp/aNwKlomJPWed0si2LfkDH1ql8Ck1+hO0
	 510Y67Zh3fsT8MWjM+Dl8ni3ndqkTIForsyFMD5bIiiVtUsHogBIsGFNjRJtUdmdRC
	 fAe+FciWVOdOg2cycnqOTcRxncdGBflGsg5Fc9oaKDTEPvbvHU3al3fekh774Zb21T
	 AJkCdzhQw4XddrBcY+Afu9iQb5rxJR9z41USIPiwy3Pr1TfcCzcWQEsvRKaVcQMFmZ
	 OUXcbSd13K2Rw==
Date: Tue, 2 Apr 2024 19:11:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 3/5] perf annotate: Split out util/disasm.c
Message-ID: <ZgyCkETBtsTX3tA8@x1>
References: <20240329215812.537846-1-namhyung@kernel.org>
 <20240329215812.537846-4-namhyung@kernel.org>
 <ZgyBwTWv8OZlbl9m@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgyBwTWv8OZlbl9m@x1>

On Tue, Apr 02, 2024 at 07:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Mar 29, 2024 at 02:58:10PM -0700, Namhyung Kim wrote:
> > The util/annotate.c code has both disassembly and sample annotation
> > related codes.  Factor out the disasm part so that it can be handled
> > more easily.
> > 
> > No functional changes intended.
> > 
> 
> Unsure if here, will check and fix later, detected with: 
> 
>   make -C tools/perf build-test'

did it, added the missing env.h header to disasm.c
 
> - Arnaldo
> 
> cd . && make BUILD_NONDISTRO=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.8dFJIAFkfV DESTDIR=/tmp/tmp.Wm6UA35mIC
>   BUILD:   Doing 'make -j28' parallel build
>   HOSTCC  /tmp/tmp.8dFJIAFkfV/fixdep.o
>   HOSTLD  /tmp/tmp.8dFJIAFkfV/fixdep-in.o
>   LINK    /tmp/tmp.8dFJIAFkfV/fixdep
> Warning: Kernel ABI header differences:
>   diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h
>   diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>   diff -u tools/include/linux/bits.h include/linux/bits.h
>   diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
>   diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
>   diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>   diff -u tools/arch/x86/include/uapi/asm/kvm.h arch/x86/include/uapi/asm/kvm.h
>   diff -u tools/arch/powerpc/include/uapi/asm/kvm.h arch/powerpc/include/uapi/asm/kvm.h
>   diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
>   diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
>   diff -u tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h
>   diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h include/uapi/linux/vhost.h
>   diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h
> Makefile.config:1147: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> 
>   GEN     /tmp/tmp.8dFJIAFkfV/common-cmds.h
>   CC      /tmp/tmp.8dFJIAFkfV/dlfilters/dlfilter-test-api-v0.o
>   CC      /tmp/tmp.8dFJIAFkfV/dlfilters/dlfilter-test-api-v2.o
>   CC      /tmp/tmp.8dFJIAFkfV/dlfilters/dlfilter-show-cycles.o
>   LINK    /tmp/tmp.8dFJIAFkfV/dlfilters/dlfilter-test-api-v0.so
>   LINK    /tmp/tmp.8dFJIAFkfV/dlfilters/dlfilter-test-api-v2.so
>   GEN     /tmp/tmp.8dFJIAFkfV/arch/arm64/include/generated/asm/sysreg-defs.h
>   LINK    /tmp/tmp.8dFJIAFkfV/dlfilters/dlfilter-show-cycles.so
>   PERF_VERSION = 6.8.g4619ca4cfefa
>   GEN     perf-iostat
>   GEN     perf-archive
>   INSTALL /tmp/tmp.8dFJIAFkfV/libsubcmd/include/subcmd/help.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libsubcmd/include/subcmd/pager.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libsubcmd/include/subcmd/exec-cmd.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libsubcmd/include/subcmd/run-command.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libsubcmd/include/subcmd/parse-options.h
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/exec-cmd.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/help.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/pager.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/parse-options.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/run-command.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/sigchain.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsubcmd/subcmd-config.o
>   INSTALL libsubcmd_headers
>   MKDIR   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf
>   MKDIR   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/
>   MKDIR   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/hashmap.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_internal.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/relo_core.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/bpf_perf.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/core.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/cpumap.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/threadmap.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libsymbol/include/symbol/kallsyms.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/evlist.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libapi/include/api/cpu.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/evsel.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/event.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libapi/include/api/debug.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/core.o
>   CC      /tmp/tmp.8dFJIAFkfV/libsymbol/kallsyms.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/perf/mmap.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/cpumap.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/cpumap.h
>   INSTALL libsymbol_headers
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/evlist.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/threadmap.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/evsel.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libapi/include/api/io.h
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/cpu.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libapi/fd/
>   INSTALL /tmp/tmp.8dFJIAFkfV/libapi/include/api/fd/array.h
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libapi/fs/
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/debug.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/lib.h
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/fd/array.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libapi/include/api/fs/fs.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/mmap.h
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/fs/fs.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/rc_check.h
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libapi/fs/
>   GEN     /tmp/tmp.8dFJIAFkfV/libbpf/bpf_helper_defs.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libapi/include/api/fs/tracing_path.h
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/fs/cgroup.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/threadmap.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/bpf.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/libbpf.h
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/fs/tracing_path.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libperf/include/internal/xyarray.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/evsel.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/btf.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/evlist.o
>   INSTALL libapi_headers
>   CC      /tmp/tmp.8dFJIAFkfV/libapi/str_error_r.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/libbpf_common.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/mmap.o
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/zalloc.o
>   GEN     /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/bpf_helper_defs.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/libbpf_legacy.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/xyarray.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/btf.h
>   INSTALL libperf_headers
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_common.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_legacy.h
>   CC      /tmp/tmp.8dFJIAFkfV/libperf/lib.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/bpf_helpers.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helpers.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/bpf_tracing.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_tracing.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_endian.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/bpf_endian.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_core_read.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/bpf_core_read.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/skel_internal.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/skel_internal.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/libbpf_version.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/usdt.bpf.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/libbpf_version.h
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/usdt.bpf.h
>   LD      /tmp/tmp.8dFJIAFkfV/libapi/fd/libapi-in.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/libbpf/include/bpf/bpf_helper_defs.h
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/
>   INSTALL libbpf_headers
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/
>   LD      /tmp/tmp.8dFJIAFkfV/libsymbol/libsymbol-in.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/libbpf.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/bpf.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/netlink.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/nlattr.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/btf.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/libbpf_errno.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/str_error.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/libbpf_probes.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/hashmap.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/strset.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/linker.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/relo_core.o
>   AR      /tmp/tmp.8dFJIAFkfV/libsymbol/libsymbol.a
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/usdt.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/zip.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf.o
>   LD      /tmp/tmp.8dFJIAFkfV/libapi/fs/libapi-in.o
>   LD      /tmp/tmp.8dFJIAFkfV/libapi/libapi-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/elf.o
>   INSTALL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/include/bpf/bpf_helper_defs.h
>   INSTALL libbpf_headers
>   CC      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/features.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/nlattr.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf.o
>   AR      /tmp/tmp.8dFJIAFkfV/libapi/libapi.a
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_errno.o
>   LD      /tmp/tmp.8dFJIAFkfV/libperf/libperf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/str_error.o
>   AR      /tmp/tmp.8dFJIAFkfV/libperf/libperf.a
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/netlink.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/bpf_prog_linfo.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf_probes.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/hashmap.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/btf_dump.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/ringbuf.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/strset.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/linker.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/gen_loader.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/relo_core.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/usdt.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/zip.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/elf.o
>   LD      /tmp/tmp.8dFJIAFkfV/libsubcmd/libsubcmd-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/features.o
>   AR      /tmp/tmp.8dFJIAFkfV/libsubcmd/libsubcmd.a
>   GEN     /tmp/tmp.8dFJIAFkfV/python/perf.cpython-312-x86_64-linux-gnu.so
>   LD      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/staticobjs/libbpf-in.o
>   LD      /tmp/tmp.8dFJIAFkfV/libbpf/staticobjs/libbpf-in.o
>   LINK    /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/libbpf/libbpf.a
>   LINK    /tmp/tmp.8dFJIAFkfV/libbpf/libbpf.a
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/main.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/common.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/json_writer.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/gen.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/btf.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/xlated_dumper.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/btf_dumper.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/disasm.o
>   LINK    /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bootstrap/bpftool
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bperf_leader.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bperf_follower.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/func_latency.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/off_cpu.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/lock_contention.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/kwork_trace.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/sample_filter.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/kwork_top.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/bench_uprobe.bpf.o
>   CLANG   /tmp/tmp.8dFJIAFkfV/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/bperf_leader.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/bench_uprobe.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/bperf_follower.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/sample_filter.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/augmented_raw_syscalls.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/bpf_prog_profiler.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/func_latency.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/bperf_cgroup.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/off_cpu.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/kwork_trace.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/kwork_top.skel.h
>   GENSKEL /tmp/tmp.8dFJIAFkfV/util/bpf_skel/lock_contention.skel.h
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-bench.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-annotate.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-config.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-diff.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-evlist.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-ftrace.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-help.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-buildid-list.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-buildid-cache.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-kallsyms.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-list.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-record.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/pmu-events/
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-report.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-stat.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-top.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-script.o
>   TEST    /tmp/tmp.8dFJIAFkfV/pmu-events/metric_test.log
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-kvm.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-inject.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-mem.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-data.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-version.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-c2c.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-daemon.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-kmem.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-kwork.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-lock.o
>   GEN     /tmp/tmp.8dFJIAFkfV/pmu-events/pmu-events.c
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-sched.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-timechart.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-trace.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/clone.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/bench/
>   CC      /tmp/tmp.8dFJIAFkfV/bench/sched-messaging.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/tests/
>   MKDIR   /tmp/tmp.8dFJIAFkfV/bench/
>   CC      /tmp/tmp.8dFJIAFkfV/tests/builtin-test.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/fcntl.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/sched-pipe.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/sched-seccomp-notify.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/syscall.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/tests/
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/flock.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/tests-scripts.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/parse-events.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/dso-data.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/attr.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/fs_at_flags.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/mem-functions.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/fsmount.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/vmlinux-kallsyms.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/openat-syscall.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/fspick.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/futex-hash.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/ioctl.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/common.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/kcmp.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/arm64-frame-pointer-unwind-support.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/
>   CC      /tmp/tmp.8dFJIAFkfV/util/addr_location.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/setup.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/scripts/perl/Perf-Trace-Util/
>   CC      /tmp/tmp.8dFJIAFkfV/scripts/perl/Perf-Trace-Util/Context.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/mount_flags.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/helpline.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/arch/x86/util/
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/header.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/arch/x86/util/
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/tsc.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/pmu.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/arch/x86/tests/
>   CC      /tmp/tmp.8dFJIAFkfV/tests/openat-syscall-all-cpus.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/regs_load.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/arch/x86/tests/
>   CC      /tmp/tmp.8dFJIAFkfV/bench/futex-wake.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/dwarf-unwind.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/futex-wake-parallel.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/annotate.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/block-info.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/move_mount.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/progress.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/openat-syscall-tp-fields.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/util.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/hist.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/stdio/
>   CC      /tmp/tmp.8dFJIAFkfV/ui/stdio/hist.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/pkey_alloc.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/mmap-basic.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/arch-tests.o
>   CC      /tmp/tmp.8dFJIAFkfV/builtin-probe.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/futex-requeue.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browser.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/kvm-stat.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/sample-parsing.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/arch_prctl.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/scripts/python/Perf-Trace-Util/
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/prctl.o
>   CC      /tmp/tmp.8dFJIAFkfV/scripts/python/Perf-Trace-Util/Context.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/block-range.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/perf_regs.o
>   CC      /tmp/tmp.8dFJIAFkfV/perf.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/renameat.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/build-id.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/perf-record.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/hybrid.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/sockaddr.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/socket.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/intel-pt-test.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/futex-lock-pi.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/browsers/
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browsers/annotate.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/topdown.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/statx.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/bp-modify.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/sync_file_range.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/evsel-roundtrip-name.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/epoll-wait.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/machine.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/browsers/
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/timespec.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browsers/hists.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/tui/
>   CC      /tmp/tmp.8dFJIAFkfV/ui/tui/setup.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/event.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/evsel-tp-sched.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/epoll-ctl.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/cacheline.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browsers/map.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/amd-ibs-via-core-pmu.o
>   LD      /tmp/tmp.8dFJIAFkfV/scripts/python/Perf-Trace-Util/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/evlist.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/config.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/copyfile.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/trace/beauty/tracepoints/
>   CC      /tmp/tmp.8dFJIAFkfV/util/ctype.o
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/tracepoints/x86_irq_vectors.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/fdarray.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/mem-events.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/pmu.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/ui/tui/
>   CC      /tmp/tmp.8dFJIAFkfV/ui/tui/util.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/tui/helpline.o
>   MKDIR   /tmp/tmp.8dFJIAFkfV/trace/beauty/tracepoints/
>   CC      /tmp/tmp.8dFJIAFkfV/trace/beauty/tracepoints/x86_msr.o
>   LD      /tmp/tmp.8dFJIAFkfV/arch/x86/tests/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/evsel.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browsers/scripts.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/tui/progress.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/pmu-events.o
>   LD      /tmp/tmp.8dFJIAFkfV/scripts/perl/Perf-Trace-Util/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/hists_common.o
>   LD      /tmp/tmp.8dFJIAFkfV/scripts/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/hists_link.o
>   LD      /tmp/tmp.8dFJIAFkfV/trace/beauty/tracepoints/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/iostat.o
>   LD      /tmp/tmp.8dFJIAFkfV/trace/beauty/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/synthesize.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browsers/header.o
>   CC      /tmp/tmp.8dFJIAFkfV/ui/browsers/res_sample.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/db-export.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/hists_filter.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/env.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/disasm.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/hists_output.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/kallsyms-parse.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/env.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/dwarf-regs.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/find-bit-bench.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/hists_cumulate.o
>   LD      /tmp/tmp.8dFJIAFkfV/ui/tui/perf-in.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/unwind-libunwind.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/event.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/evlist.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/auxtrace.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/sideband_evlist.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/python-use.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/evsel.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/archinsn.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/intel-pt.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/inject-buildid.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/evlist-open-close.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/bp_signal.o
>   CC      /tmp/tmp.8dFJIAFkfV/arch/x86/util/intel-bts.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/bp_signal_overflow.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/breakpoint.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/bp_account.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/evsel_fprintf.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/wp.o
>   CC      /tmp/tmp.8dFJIAFkfV/util/perf_event_attr_fprintf.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/pmu-scan.o
> util/disasm.c: In function ‘symbol__disassemble_bpf’:
> util/disasm.c:1202:9: error: implicit declaration of function ‘perf_exe’ [-Werror=implicit-function-declaration]
>  1202 |         perf_exe(tpath, sizeof(tpath));
>       |         ^~~~~~~~
> util/disasm.c:1222:21: error: implicit declaration of function ‘perf_env__find_bpf_prog_info’ [-Werror=implicit-function-declaration]
>  1222 |         info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/disasm.c:1222:19: error: assignment to ‘struct bpf_prog_info_node *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
>  1222 |         info_node = perf_env__find_bpf_prog_info(dso->bpf_prog.env,
>       |                   ^
> util/disasm.c:1228:32: error: invalid use of undefined type ‘struct bpf_prog_info_node’
>  1228 |         info_linear = info_node->info_linear;
>       |                                ^~
> util/disasm.c:1231:54: error: invalid use of undefined type ‘struct perf_bpil’
>  1231 |         info.buffer = (void *)(uintptr_t)(info_linear->info.jited_prog_insns);
>       |                                                      ^~
> util/disasm.c:1232:41: error: invalid use of undefined type ‘struct perf_bpil’
>  1232 |         info.buffer_length = info_linear->info.jited_prog_len;
>       |                                         ^~
> util/disasm.c:1234:24: error: invalid use of undefined type ‘struct perf_bpil’
>  1234 |         if (info_linear->info.nr_line_info)
>       |                        ^~
> util/disasm.c:1235:62: error: invalid use of undefined type ‘struct perf_bpil’
>  1235 |                 prog_linfo = bpf_prog_linfo__new(&info_linear->info);
>       |                                                              ^~
> util/disasm.c:1237:24: error: invalid use of undefined type ‘struct perf_bpil’
>  1237 |         if (info_linear->info.btf_id) {
>       |                        ^~
> util/disasm.c:1240:24: error: implicit declaration of function ‘perf_env__find_btf’ [-Werror=implicit-function-declaration]
>  1240 |                 node = perf_env__find_btf(dso->bpf_prog.env,
>       |                        ^~~~~~~~~~~~~~~~~~
> util/disasm.c:1241:54: error: invalid use of undefined type ‘struct perf_bpil’
>  1241 |                                           info_linear->info.btf_id);
>       |                                                      ^~
> util/disasm.c:1243:53: error: invalid use of undefined type ‘struct btf_node’
>  1243 |                         btf = btf__new((__u8 *)(node->data),
>       |                                                     ^~
> util/disasm.c:1244:44: error: invalid use of undefined type ‘struct btf_node’
>  1244 |                                        node->data_size);
>       |                                            ^~
> util/disasm.c:1268:60: error: invalid use of undefined type ‘struct perf_bpil’
>  1268 |                 addr = pc + ((u64 *)(uintptr_t)(info_linear->info.jited_ksyms))[sub_id];
>       |                                                            ^~
> cc1: all warnings being treated as errors
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/tmp.8dFJIAFkfV/util/disasm.o] Error 1
>   CC      /tmp/tmp.8dFJIAFkfV/tests/task-exit.o
> make[6]: *** Waiting for unfinished jobs....
>   CC      /tmp/tmp.8dFJIAFkfV/tests/sw-clock.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/mmap-thread-lookup.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/uprobe.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/mem-memcpy-x86-64-asm.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/thread-maps-share.o
>   CC      /tmp/tmp.8dFJIAFkfV/bench/mem-memset-x86-64-asm.o
>   CC      /tmp/tmp.8dFJIAFkfV/tests/switch-tracking.o
> 

