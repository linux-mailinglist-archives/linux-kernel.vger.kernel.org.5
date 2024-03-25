Return-Path: <linux-kernel+bounces-118137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781E688B46F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074D23080F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377C7F7E8;
	Mon, 25 Mar 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3aIKRS+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B136CDD6;
	Mon, 25 Mar 2024 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711406780; cv=none; b=KUZPZdiWRs1dBpQgiL9D6g0xR9a6KXa4PyicYODT/rXXErAvOq3eP23ENa2WMuPUwVh8F6FcFUDoiisfjcnsJHI9L96TbxrevelZ25bnECMkkOocHR7avu3ZylPylAbC7x7E/NVh8q/1P3W/EjZn2QA2XhA2qmW5Qe8ilmVlJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711406780; c=relaxed/simple;
	bh=La9khacnWr/Bceb06zhyVqOkAfnfmZtxX35t4Y7emCQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VPX1pPsSF5WUHMbbQAwKQdQLLba6yfCwiODvm8HkAA17YgAN4/m4OUcXMZfjv1fwfG3UanfEK/q7Nj1jiwR/oWxMJSOA2knmwyA5Xa7l9jeIE9wJHP2OuEcLulBdAokj3T9EanPSMneRMuAnV048Ls6Eb+DZ/BCWLvFtiam38J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3aIKRS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9155DC433F1;
	Mon, 25 Mar 2024 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711406779;
	bh=La9khacnWr/Bceb06zhyVqOkAfnfmZtxX35t4Y7emCQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=g3aIKRS+dx0sSqqAz++NgLaFZNIcUT0+EskUgjxzrykHVKcg0SuTUYr6f7nwy35UE
	 cNN0MOMgUNk/55p28G7e++rkvX1IXVhNlMlhjUD4xT5PLzSBbuP8K5+iku6uhTJegb
	 whSaERSsJc3Ud+ION0fIsNahXQJaKFfmgXvIi3bQdZmYtp9Ptgk+F6WPFtLFFeBouB
	 hQAGCOwIXSKWnmmZaj22nhFZ1gZJpMxwwDNrpxkfLCM5uboo9VRsxJvKOdVlfOk4ug
	 zSFa6VrmeyPqyGnJySFZQ9EQrl7Sdy6rxaFBAXuCMt0B9ogzVaetqvnNPOTj8L018P
	 sHddd/3iGSv9g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Mar 2024 00:46:14 +0200
Message-Id: <D0372IKSFG0T.B9NV4SYAWPJ2@kernel.org>
Cc: <bpf@vger.kernel.org>, <linux-modules@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 0/4] Make bpf_jit and kprobes work with
 CONFIG_MODULES=n
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Calvin Owens" <jcalvinowens@gmail.com>, "Luis Chamberlain"
 <mcgrof@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Alexei
 Starovoitov" <ast@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Naveen N
 Rao" <naveen.n.rao@linux.ibm.com>, "Anil S Keshavamurthy"
 <anil.s.keshavamurthy@intel.com>, "David S Miller" <davem@davemloft.net>,
 "Thomas Gleixner" <tglx@linutronix.de>
X-Mailer: aerc 0.17.0
References: <cover.1709676663.git.jcalvinowens@gmail.com>
In-Reply-To: <cover.1709676663.git.jcalvinowens@gmail.com>

On Wed Mar 6, 2024 at 10:05 PM EET, Calvin Owens wrote:
> Hello all,
>
> This patchset makes it possible to use bpftrace with kprobes on kernels
> built without loadable module support.
>
> On a Raspberry Pi 4b, this saves about 700KB of memory where BPF is
> needed but loadable module support is not. These two kernels had
> identical configurations, except CONFIG_MODULE was off in the second:
>
>    - Linux version 6.8.0-rc7
>    - Memory: 3330672K/4050944K available (16576K kernel code, 2390K rwdat=
a,
>    - 12364K rodata, 5632K init, 675K bss, 195984K reserved, 524288K cma-r=
eserved)
>    + Linux version 6.8.0-rc7-00003-g2af01251ca21
>    + Memory: 3331400K/4050944K available (16512K kernel code, 2384K rwdat=
a,
>    + 11728K rodata, 5632K init, 673K bss, 195256K reserved, 524288K cma-r=
eserved)
>
> I don't intend to present an exhaustive list of !MODULES usecases, since
> I'm sure there are many I'm not aware of. Performance is a common one,
> the primary justification being that static text is mapped on hugepages
> and module text is not. Security is another, since rootkits are much
> harder to implement without modules.
>
> The first patch is the interesting one: it moves module_alloc() into its
> own file with its own Kconfig option, so it can be utilized even when
> loadable module support is disabled. I got the idea from an unmerged
> patch from a few years ago I found on lkml (see [1/4] for details). I
> think this also has value in its own right, since I suspect there are
> potential users beyond bpf, hopefully we will hear from some.
>
> Patches 2-3 are proofs of concept to demonstrate the first patch is
> sufficient to achieve my goal (full ebpf functionality without modules).
>
> Patch 4 adds a new "-n" argument to vmtest.sh to run the BPF selftests
> without modules, so the prior three patches can be rigorously tested.
>
> If something like the first patch were to eventually be merged, the rest
> could go through the normal bpf-next process as I clean them up: I've
> only based them on Linus' tree and combined them into a series here to
> introduce the idea.
>
> If you prefer to fetch the patches via git:
>
>   [1/4] https://github.com/jcalvinowens/linux.git work/module-alloc
>  +[2/4]+[3/4] https://github.com/jcalvinowens/linux.git work/nomodule-bpf
>  +[4/4] https://github.com/jcalvinowens/linux.git testing/nomodule-bpf-ci
>
> In addition to the automated BPF selftests, I've lightly tested this on
> my laptop (x86_64), a Raspberry Pi 4b (arm64), and a Raspberry Pi Zero W
> (arm). The other architectures have only been compile tested.
>
> I didn't want to spam all the arch maintainers with what I expect will
> be a discussion mostly about modules and bpf, so I've left them off this
> first submission. I will be sure to add them on future submissions of
> the first patch. Of course, feedback on the arch bits is welcome here.
>
> In addition to feedback on the patches themselves, I'm interested in
> hearing from anybody else who might find this functionality useful.
>
> Thanks,
> Calvin
>
>
> Calvin Owens (4):
>   module: mm: Make module_alloc() generally available
>   bpf: Allow BPF_JIT with CONFIG_MODULES=3Dn
>   kprobes: Allow kprobes with CONFIG_MODULES=3Dn
>   selftests/bpf: Support testing the !MODULES case
>
>  arch/Kconfig                                  |   4 +-
>  arch/arm/kernel/module.c                      |  35 -----
>  arch/arm/mm/Makefile                          |   2 +
>  arch/arm/mm/module_alloc.c                    |  40 ++++++
>  arch/arm64/kernel/module.c                    | 127 -----------------
>  arch/arm64/mm/Makefile                        |   1 +
>  arch/arm64/mm/module_alloc.c                  | 130 ++++++++++++++++++
>  arch/loongarch/kernel/module.c                |   6 -
>  arch/loongarch/mm/Makefile                    |   2 +
>  arch/loongarch/mm/module_alloc.c              |  10 ++
>  arch/mips/kernel/module.c                     |  10 --
>  arch/mips/mm/Makefile                         |   2 +
>  arch/mips/mm/module_alloc.c                   |  13 ++
>  arch/nios2/kernel/module.c                    |  20 ---
>  arch/nios2/mm/Makefile                        |   2 +
>  arch/nios2/mm/module_alloc.c                  |  22 +++
>  arch/parisc/kernel/module.c                   |  12 --
>  arch/parisc/mm/Makefile                       |   1 +
>  arch/parisc/mm/module_alloc.c                 |  15 ++
>  arch/powerpc/kernel/module.c                  |  36 -----
>  arch/powerpc/mm/Makefile                      |   1 +
>  arch/powerpc/mm/module_alloc.c                |  41 ++++++
>  arch/riscv/kernel/module.c                    |  11 --
>  arch/riscv/mm/Makefile                        |   1 +
>  arch/riscv/mm/module_alloc.c                  |  17 +++
>  arch/s390/kernel/module.c                     |  37 -----
>  arch/s390/mm/Makefile                         |   1 +
>  arch/s390/mm/module_alloc.c                   |  42 ++++++
>  arch/sparc/kernel/module.c                    |  31 -----
>  arch/sparc/mm/Makefile                        |   2 +
>  arch/sparc/mm/module_alloc.c                  |  31 +++++
>  arch/x86/kernel/ftrace.c                      |   2 +-
>  arch/x86/kernel/module.c                      |  56 --------
>  arch/x86/mm/Makefile                          |   2 +
>  arch/x86/mm/module_alloc.c                    |  59 ++++++++
>  fs/proc/kcore.c                               |   2 +-
>  include/trace/events/bpf_testmod.h            |   1 +
>  kernel/bpf/Kconfig                            |  11 +-
>  kernel/bpf/Makefile                           |   2 +
>  kernel/bpf/bpf_struct_ops.c                   |  28 +++-
>  kernel/bpf/bpf_testmod/Makefile               |   1 +
>  kernel/bpf/bpf_testmod/bpf_testmod.c          |   1 +
>  kernel/bpf/bpf_testmod/bpf_testmod.h          |   1 +
>  kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h    |   1 +
>  kernel/kprobes.c                              |  22 +++
>  kernel/module/Kconfig                         |   1 +
>  kernel/module/main.c                          |  17 ---
>  kernel/trace/trace_kprobe.c                   |  11 ++
>  mm/Kconfig                                    |   3 +
>  mm/Makefile                                   |   1 +
>  mm/module_alloc.c                             |  21 +++
>  mm/vmalloc.c                                  |   2 +-
>  net/bpf/test_run.c                            |   2 +
>  tools/testing/selftests/bpf/Makefile          |  28 ++--
>  .../selftests/bpf/bpf_testmod/Makefile        |   2 +-
>  .../bpf/bpf_testmod/bpf_testmod-events.h      |   6 +
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   4 +
>  .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   2 +
>  tools/testing/selftests/bpf/config            |   5 -
>  tools/testing/selftests/bpf/config.mods       |   5 +
>  tools/testing/selftests/bpf/config.nomods     |   1 +
>  .../selftests/bpf/progs/btf_type_tag_percpu.c |   2 +
>  .../selftests/bpf/progs/btf_type_tag_user.c   |   2 +
>  tools/testing/selftests/bpf/progs/core_kern.c |   2 +
>  .../selftests/bpf/progs/iters_testmod_seq.c   |   2 +
>  .../bpf/progs/test_core_reloc_module.c        |   2 +
>  .../selftests/bpf/progs/test_ldsx_insn.c      |   2 +
>  .../selftests/bpf/progs/test_module_attach.c  |   3 +
>  .../selftests/bpf/progs/tracing_struct.c      |   2 +
>  tools/testing/selftests/bpf/testing_helpers.c |  14 ++
>  tools/testing/selftests/bpf/vmtest.sh         |  24 +++-
>  71 files changed, 636 insertions(+), 424 deletions(-)
>  create mode 100644 arch/arm/mm/module_alloc.c
>  create mode 100644 arch/arm64/mm/module_alloc.c
>  create mode 100644 arch/loongarch/mm/module_alloc.c
>  create mode 100644 arch/mips/mm/module_alloc.c
>  create mode 100644 arch/nios2/mm/module_alloc.c
>  create mode 100644 arch/parisc/mm/module_alloc.c
>  create mode 100644 arch/powerpc/mm/module_alloc.c
>  create mode 100644 arch/riscv/mm/module_alloc.c
>  create mode 100644 arch/s390/mm/module_alloc.c
>  create mode 100644 arch/sparc/mm/module_alloc.c
>  create mode 100644 arch/x86/mm/module_alloc.c
>  create mode 120000 include/trace/events/bpf_testmod.h
>  create mode 100644 kernel/bpf/bpf_testmod/Makefile
>  create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod.c
>  create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod.h
>  create mode 120000 kernel/bpf/bpf_testmod/bpf_testmod_kfunc.h
>  create mode 100644 mm/module_alloc.c
>  create mode 100644 tools/testing/selftests/bpf/config.mods
>  create mode 100644 tools/testing/selftests/bpf/config.nomods

I think with eBPF focus in the patch set should be only on arch's
that you use regulary, i.e. repeating same mistake I did couple of
years ago:

https://lore.kernel.org/all/20220608000014.3054333-1-jarkko@profian.com/

I don't see my patch set conflict with this work, and it adds needed
shenanigans to realize eBPF patches. I refined the shenanigans to match
Masami's suggestions:

https://lore.kernel.org/all/20240325215502.660-1-jarkko@kernel.org/

And it this requires properly working kprobes anyway.

BR, Jarkko

