Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256F077E763
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 19:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345148AbjHPRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345222AbjHPRPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 13:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536F426BB;
        Wed, 16 Aug 2023 10:14:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC40966DAF;
        Wed, 16 Aug 2023 17:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A795C433C8;
        Wed, 16 Aug 2023 17:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692206094;
        bh=mNHi7yo/+F6lGkVdNtLVdja/1jJL9G+ynGHwfd2qMK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=um4URlNIvs/ma837FQM0/oM7565LaRn0CCV2jg+cgnqYCKvLl0D+RthfqSMrZNmPV
         aAL0gB0DS2W+gr+kUMbugboESvOtGdrfyF5QE4RoAeV3sCsFoqD6v+8PO0EWLIIVaK
         SVKRHlzT9wAVOUTk736iMjpSrylP1C5AKIoT88limlXPgqP0RFOi1HyFc6u7hrSITk
         GWXI5Wma5FCF22Mv+4op48TERjKF6Jz4Qh1tEimEJcSzl+zHBs20uAwxtPdZ0vL97p
         4kaJSZ2H4Ho3ciqljwMF5wDfz2ElckiiS4LTLuA+U31WyxCi1aHUjRxao78MT+DyQN
         qGI5J8uU04sAQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 67046404DF; Wed, 16 Aug 2023 14:14:51 -0300 (-03)
Date:   Wed, 16 Aug 2023 14:14:51 -0300
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
Message-ID: <ZN0EC+26K0K9DlWb@kernel.org>
References: <20230810184853.2860737-1-irogers@google.com>
 <20230810184853.2860737-3-irogers@google.com>
 <ZNuK1TFwdjyezV3I@kernel.org>
 <CAP-5=fURf+vv3TA4cRx1MiV3DDp=3wo0g5dBYH43DKtPhNZQsQ@mail.gmail.com>
 <ZNzK70eH3ISoL8r0@kernel.org>
 <ZNzNh9Myua1xjNuL@kernel.org>
 <ZNz0bmclvZPg5Y/X@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNz0bmclvZPg5Y/X@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 16, 2023 at 01:08:14PM -0300, Arnaldo Carvalho de Melo escreveu:
> [acme@five ~]$ getcap ~/bin/perf
> /var/home/acme/bin/perf cap_perfmon,cap_bpf=ep
> [acme@five ~]$ cat /proc/sys/kernel/unprivileged_bpf_disabled
> 2
> [acme@five ~]$ cat /proc/sys/kernel/perf_event_paranoid
> -1

This last one can remain at 2:

[acme@five ~]$ cat /proc/sys/kernel/perf_event_paranoid
2
[acme@five ~]$ perf trace -e bpf*,perf*,openat,connect* --max-events=10
     0.000 ( 0.031 ms): systemd-oomd/1151 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC)    = 11
    25.532 (         ): gnome-terminal/3223 openat(dfd: CWD, filename: "/proc/1244100/cmdline")                ...
   249.996 ( 0.031 ms): systemd-oomd/1151 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC)    = 11
   423.853 ( 0.036 ms): pool/2490 connect(fd: 7, uservaddr: { .family: LOCAL, path: /var/run/.heim_org.h5l.kcm-socket }, addrlen: 110) = 0
   423.929 ( 0.021 ms): sssd_kcm/2514 openat(dfd: CWD, filename: "/proc/2486/cmdline")                      = 16
   499.988 ( 0.030 ms): systemd-oomd/1151 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC)    = 11
   749.981 ( 0.032 ms): systemd-oomd/1151 openat(dfd: CWD, filename: "/proc/meminfo", flags: RDONLY|CLOEXEC)    = 11
   775.441 (         ): gnome-terminal/3223 openat(dfd: CWD, filename: "/proc/1244100/cmdline")                ...
   999.988 ( 0.044 ms): systemd-oomd/1151 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/memory.pressure", flags: RDONLY|CLOEXEC) = 11
  1000.091 ( 0.010 ms): systemd-oomd/1151 openat(dfd: CWD, filename: "/sys/fs/cgroup/user.slice/user-1001.slice/user@1001.service/memory.current", flags: RDONLY|CLOEXEC) = 11
[acme@five ~]$
