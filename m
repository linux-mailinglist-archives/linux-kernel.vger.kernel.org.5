Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41877E23D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245281AbjHPNLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245393AbjHPNLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDC1BFB;
        Wed, 16 Aug 2023 06:11:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5328D61C4E;
        Wed, 16 Aug 2023 13:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C04BC433C9;
        Wed, 16 Aug 2023 13:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692191475;
        bh=zWuvXK7QMRZXyxcMioldJT+UNyw10JlwQNc8/I5Yezk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GTWI0SxKGp1wEgqfo7YBE5wtsKMlhEew8Ab06byaIFdkUrz50ik8wuvOe4ce2cHvg
         jwfFc0nHs36ks6Kv+rPzQ5qXPcm2pqp0WIUjd2yVM0PvfsaMnx+yjoHQNfLw9g5+Or
         xwLPPV+4eTmXDPIy9UWP3x/Px/GmK3VxuG9concy7gKpLchjOE85KsrrrbNj3TrbTZ
         74Alulf+4B6X7JC2m1k6nWK+Ae7nFFPADkX2Sak6GQ46OBd7NqADHdZzUjSnrpD/If
         Gqn5UL12zGEvZ3cz+19OWWnuSHYpTZmHVJ/6+itKxvJSkj/tBhv3SoroJ9StX5jJuN
         u0sluyTu4ywbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BA6CF404DF; Wed, 16 Aug 2023 10:11:11 -0300 (-03)
Date:   Wed, 16 Aug 2023 10:11:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        He Kuang <hekuang@huawei.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: [PATCH v1 2/4] perf trace: Migrate BPF augmentation to use a
 skeleton
Message-ID: <ZNzK70eH3ISoL8r0@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-3-irogers@google.com>
 <ZNuK1TFwdjyezV3I@kernel.org>
 <CAP-5=fURf+vv3TA4cRx1MiV3DDp=3wo0g5dBYH43DKtPhNZQsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fURf+vv3TA4cRx1MiV3DDp=3wo0g5dBYH43DKtPhNZQsQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 15, 2023 at 07:34:08AM -0700, Ian Rogers escreveu:
> On Tue, Aug 15, 2023, 7:25 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >                 bpf_object__for_each_program(prog, trace.skel->obj) {
> >                         if (prog != trace.skel->progs.sys_enter && prog !=
> > trace.skel->progs.sys_exit)
> >                                 bpf_program__set_autoattach(prog,
> > /*autoattach=*/false);
> >                 }
> >
> > So that we don't have to add new lines disabling attachment when adding
> > support for other pointer receiving syscalls.
 
> Makes sense. Thanks,

Just taking notes about things to work on top of what is in
tmp.perf-tools-next, that will move to perf-tools-next soon:

We need to make these libbpf error messages appear only in verbose mode,
and probably have a hint about unprivileged BPF, a quick attempt failed
after several attempts at getting privileges :-\

Probably attaching to tracepoints is off limits to !root even with
/proc/sys/kernel/unprivileged_bpf_disabled set to zero.

[acme@quaco perf-tools-next]$ perf trace ls
libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -1
Error:	No permissions to read /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

[acme@quaco perf-tools-next]$

[acme@quaco perf-tools-next]$ perf trace -e open* sleep 1
libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -1
Error:	No permissions to read /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

[acme@quaco perf-tools-next]$ sudo mount -o remount,mode=755 /sys/kernel/tracing/
[sudo] password for acme:
[acme@quaco perf-tools-next]$ perf trace -e open* sleep 1
libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -1
Error:	No permissions to read /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

[acme@quaco perf-tools-next]$ sudo mount -o remount,mode=755 /sys/kernel/debug
[acme@quaco perf-tools-next]$ perf trace -e open* sleep 1
libbpf: Failed to bump RLIMIT_MEMLOCK (err = -1), you might need to do it explicitly!
libbpf: Error in bpf_object__probe_loading():Operation not permitted(1). Couldn't load trivial BPF program. Make sure your kernel supports BPF (CONFIG_BPF_SYSCALL=y) and/or that RLIMIT_MEMLOCK is set to big enough value.
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -1
Error:	No permissions to read /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

[acme@quaco perf-tools-next]$ sudo sh -c "echo 0 > /proc/sys/kernel/unprivileged_bpf_disabled"
[acme@quaco perf-tools-next]$ perf trace -e open* sleep 1
libbpf: prog 'syscall_unaugmented': BPF program load failed: Operation not permitted
libbpf: prog 'syscall_unaugmented': failed to load: -1
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -1
Error:	No permissions to read /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

[acme@quaco perf-tools-next]$ cat /proc/sys/kernel/unprivileged_bpf_disabled
0
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$ cat /proc/sys/kernel/perf_event_paranoid
2
[acme@quaco perf-tools-next]$ sudo sh -c "echo -1 > /proc/sys/kernel/perf_event_paranoid"
[acme@quaco perf-tools-next]$ perf trace -e open* sleep 1
libbpf: prog 'syscall_unaugmented': BPF program load failed: Operation not permitted
libbpf: prog 'syscall_unaugmented': failed to load: -1
libbpf: failed to load object 'augmented_raw_syscalls_bpf'
libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -1
Error:	No permissions to read /sys/kernel/tracing//events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

[acme@quaco perf-tools-next]$

