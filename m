Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748A766F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237081AbjG1O3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237082AbjG1O3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:29:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37373C21;
        Fri, 28 Jul 2023 07:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAC562167;
        Fri, 28 Jul 2023 14:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1862C433C8;
        Fri, 28 Jul 2023 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690554576;
        bh=rl3ICyI1xb8NNYkUwggQGBZkbkR4Fw6St3ciX3au0Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clQ2nEznsKNV/N0TmTO8FkMUEae6XMBZM9RCvoH+GKRFp4Xjy4WiE0n2GDAjourB9
         v2NBSyFn5QCZ2XLYfolJCD/9hci42tVbye1rAn3W6ne79ZvxomoSHDjuXcdKM8But1
         C4bWT1N5sckW+LXAmAlixhmmmOuueWhBSycLaVsc8mIJDaba/XkPJNL7er51/41cGM
         Y+WyK8oQp7gB59Ylse/o97ZftI9IkyjP+COmJrtx0i2++CODJGjkXx3y6v5iqBkBBu
         mvAjsZ4HFVXqCwQHdMFz2ejRD3agLUBNS4YT8fGK8PPlpwF79G1ITGek4srCtZ0IiA
         U6XO9w/4Yxg5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6381540096; Fri, 28 Jul 2023 11:29:33 -0300 (-03)
Date:   Fri, 28 Jul 2023 11:29:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Subject: Re: [PATCH v1 0/3] Remove BPF arrays from perf event parsing
Message-ID: <ZMPQze90mGEdYFtr@kernel.org>
References: <20230728001212.457900-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728001212.457900-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 27, 2023 at 05:12:09PM -0700, Ian Rogers escreveu:
> Event parsing was recently refactored:
> https://lore.kernel.org/all/20230502223851.2234828-1-irogers@google.com/
> 
> During these changes I wanted to get coverage of all parts of the
> parse-events.y and found that I couldn't test the array code.
> 
> The first patch fixes a BPF testing issue.
> The 2nd and 3rd patch remove the BPF array event parsing code so that
> it isn't adding complexity to event parsing.

Thanks, applied and tested that 'perf trace' using the old BPF perf
integration continues to work modulo the sockaddr collectors, but that
is a problem with a newer kernel BPF verifier or clang, will
investigate.

With those commented out:

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 9a03189d33d3816a..97871e2bd3a47bdf 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -176,6 +176,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 	return 1;
 }
 
+#if 0
 /*
  * These will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
  * augmented_args_tmp what was read by that raw_syscalls:sys_enter and go
@@ -219,6 +220,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	return augmented__output(args, augmented_args, len + socklen);
 }
+#endif
 
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)




  # perf trace -e /home/acme/git/perf-tools-next/tools/perf/examples/bpf/augmented_raw_syscalls.c,open*
     0.000 systemd-oomd/952 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
    95.302 thermald/1231 openat(dfd: CWD, filename: "/sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:2/energy_uj") = 13
    95.586 thermald/1231 openat(dfd: CWD, filename: "/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj") = 13
    95.857 thermald/1231 openat(dfd: CWD, filename: "/sys/class/thermal/thermal_zone2/temp") = 13
   250.064 systemd-oomd/952 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
   500.054 systemd-oomd/952 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC) = 12
   500.472 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   500.669 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
   500.777 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/memory.min", flags: RDONLY|CLOEXEC) = 12
   500.873 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/memory.low", flags: RDONLY|CLOEXEC) = 12
   500.968 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/memory.swap.current", flags: RDONLY|CLOEXEC) = 12
   501.062 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/memory.stat", flags: RDONLY|CLOEXEC) = 12
   501.435 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   501.585 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
   501.676 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.min", flags: RDONLY|CLOEXEC) = 12
   501.761 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.low", flags: RDONLY|CLOEXEC) = 12
   501.845 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.swap.current", flags: RDONLY|CLOEXEC) = 12
   501.929 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/memory.stat", flags: RDONLY|CLOEXEC) = 12
   502.118 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x2dmanager.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   502.272 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x2dmanager.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
   502.367 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x2dmanager.slice/memory.min", flags: RDONLY|CLOEXEC) = 12
   502.454 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x2dmanager.slice/memory.low", flags: RDONLY|CLOEXEC) = 12
   502.542 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x2dmanager.slice/memory.swap.current", flags: RDONLY|CLOEXEC) = 12
   502.628 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x2dmanager.slice/memory.stat", flags: RDONLY|CLOEXEC) = 12
   502.796 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   502.928 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
   503.037 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/memory.min", flags: RDONLY|CLOEXEC) = 12
   503.162 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/memory.low", flags: RDONLY|CLOEXEC) = 12
   503.255 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/memory.swap.current", flags: RDONLY|CLOEXEC) = 12
   503.341 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/memory.stat", flags: RDONLY|CLOEXEC) = 12
   503.495 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/system.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   503.620 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/system.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
   503.703 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/system.slice/memory.min", flags: RDONLY|CLOEXEC) = 12
   503.782 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/system.slice/memory.low", flags: RDONLY|CLOEXEC) = 12
   503.861 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/system.slice/memory.swap.current", flags: RDONLY|CLOEXEC) = 12
   503.939 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/system.slice/memory.stat", flags: RDONLY|CLOEXEC) = 12
   504.079 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/app.slice/memory.pressure", flags: RDONLY|CLOEXEC) = 12
   504.240 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/app.slice/memory.current", flags: RDONLY|CLOEXEC) = 12
^C

- Arnaldo
 
> Ian Rogers (3):
>   perf parse-event: Avoid BPF test segv
>   perf tools: Revert enable indices setting syntax for BPF map
>   perf parse-events: Remove array remnants
> 
>  tools/perf/util/bpf-loader.c   | 101 ---------------------------
>  tools/perf/util/parse-events.c |  18 +----
>  tools/perf/util/parse-events.h |  10 ---
>  tools/perf/util/parse-events.l |  11 ---
>  tools/perf/util/parse-events.y | 122 ---------------------------------
>  5 files changed, 2 insertions(+), 260 deletions(-)
> 
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 

-- 

- Arnaldo
