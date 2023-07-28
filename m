Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2147670E1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbjG1PqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjG1PqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:46:10 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D03649C4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:45:53 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so352391cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690559152; x=1691163952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z1/2YJsBGlL/vjVmvrWTZzbzmeM1zUvfRk85MJxJDc=;
        b=KB5526ympzQ0XdNc1dyPDFpXfVxWaTK13HZz/RrmoHdvONdZXAcOwIvZ8ID+SOTshW
         NGiqRIwEqtLdvLm8ByrQwvX1DpC8LX8zvQVM8EBUv5T7dS1OlNosQnkK5zv4nJS2+UZV
         QYvmHi4lMgluAxJQGq2EAre6Asppp+XXYC4+nfzaL8FH6IQ8VWmc+X4WhXaedtLQlivh
         5ycjM4/eCWv9chNdC9ehkslJ1F0h78FGmcgprCBHaxWTpUG4gPBYFQVLJses2FSAYjZY
         0EIQ3svbKBORAmA4GQ1rWYpybfct+j2z/4EYwfyrFCu27D2fU6K2wJ9oKleArUBRzU7x
         7mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690559152; x=1691163952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z1/2YJsBGlL/vjVmvrWTZzbzmeM1zUvfRk85MJxJDc=;
        b=F6IF1bzv6EgaFY4YL5BBfXT4GZIDuD07EJ+1DOr2/qqgaFSwdRbiBzMZsqA81PTCi2
         eA7XAoMwlq4FuK0utUXqpZGojX/0eE7osuIcUmzIIUgfCN4nOCrOQCvdmCF880IWm0M/
         d15wPPsdGHuVSRE8QorhR8jqsGh6tkHmt0/ERFyfWl/p+YqLy7HmbrPUrSe8X+Wt8JcO
         GbMfL1YxrBqLHS5CtGgmlDIsgng1/Sy75JUWhAC1IWUNZwOgCYDyggYxEm5nBBJoUuV8
         5JVDjirfrwfFLfwICZtZMau7Db1y2nhDhhmOeaeafzpCND6qAW0Cez58RLJouccUztO+
         1vwg==
X-Gm-Message-State: ABy/qLbsTCI3sNhVr6cY1so72BEtC+iQujXolX5LtqSgkyykk4XD7t32
        G260rqfo1z8YSYW+kVUg3UhnQFS3goB2ZbVEtb+DcQ==
X-Google-Smtp-Source: APBJJlHaCHyFjdctpHtSANJgw9bDeHBvK8vinBiOQ1lCAJw6Cku89st2XDTkdyJwdmLkNBrOKnaDSLKyg8MfKpedzyI=
X-Received: by 2002:ac8:5f92:0:b0:3ef:5f97:258f with SMTP id
 j18-20020ac85f92000000b003ef5f97258fmr318418qta.16.1690559151845; Fri, 28 Jul
 2023 08:45:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230728001212.457900-1-irogers@google.com> <ZMPQze90mGEdYFtr@kernel.org>
In-Reply-To: <ZMPQze90mGEdYFtr@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 08:45:40 -0700
Message-ID: <CAP-5=fXxGimJRXKf7bcaPqfjxxGcn1k3CspY_iSjQnpAKs3uFQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Remove BPF arrays from perf event parsing
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 7:29=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jul 27, 2023 at 05:12:09PM -0700, Ian Rogers escreveu:
> > Event parsing was recently refactored:
> > https://lore.kernel.org/all/20230502223851.2234828-1-irogers@google.com=
/
> >
> > During these changes I wanted to get coverage of all parts of the
> > parse-events.y and found that I couldn't test the array code.
> >
> > The first patch fixes a BPF testing issue.
> > The 2nd and 3rd patch remove the BPF array event parsing code so that
> > it isn't adding complexity to event parsing.
>
> Thanks, applied and tested that 'perf trace' using the old BPF perf
> integration continues to work modulo the sockaddr collectors, but that
> is a problem with a newer kernel BPF verifier or clang, will
> investigate.
>
> With those commented out:
>
> diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/per=
f/examples/bpf/augmented_raw_syscalls.c
> index 9a03189d33d3816a..97871e2bd3a47bdf 100644
> --- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
> +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
> @@ -176,6 +176,7 @@ int syscall_unaugmented(struct syscall_enter_args *ar=
gs)
>         return 1;
>  }
>
> +#if 0
>  /*
>   * These will be tail_called from SEC("raw_syscalls:sys_enter"), so will=
 find in
>   * augmented_args_tmp what was read by that raw_syscalls:sys_enter and g=
o
> @@ -219,6 +220,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
>
>         return augmented__output(args, augmented_args, len + socklen);
>  }
> +#endif
>
>  SEC("!syscalls:sys_enter_open")
>  int sys_enter_open(struct syscall_enter_args *args)
>
>
>
>
>   # perf trace -e /home/acme/git/perf-tools-next/tools/perf/examples/bpf/=
augmented_raw_syscalls.c,open*
>      0.000 systemd-oomd/952 openat(dfd: CWD, filename: "/proc/meminfo", f=
lags: RDONLY|CLOEXEC) =3D 12
>     95.302 thermald/1231 openat(dfd: CWD, filename: "/sys/class/powercap/=
intel-rapl/intel-rapl:0/intel-rapl:0:2/energy_uj") =3D 13
>     95.586 thermald/1231 openat(dfd: CWD, filename: "/sys/class/powercap/=
intel-rapl/intel-rapl:0/energy_uj") =3D 13
>     95.857 thermald/1231 openat(dfd: CWD, filename: "/sys/class/thermal/t=
hermal_zone2/temp") =3D 13
>    250.064 systemd-oomd/952 openat(dfd: CWD, filename: "/proc/meminfo", f=
lags: RDONLY|CLOEXEC) =3D 12
>    500.054 systemd-oomd/952 openat(dfd: CWD, filename: "/proc/meminfo", f=
lags: RDONLY|CLOEXEC) =3D 12
>    500.472 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/session.slice/memory.pressure", =
flags: RDONLY|CLOEXEC) =3D 12
>    500.669 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/session.slice/memory.current", f=
lags: RDONLY|CLOEXEC) =3D 12
>    500.777 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/session.slice/memory.min", flags=
: RDONLY|CLOEXEC) =3D 12
>    500.873 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/session.slice/memory.low", flags=
: RDONLY|CLOEXEC) =3D 12
>    500.968 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/session.slice/memory.swap.curren=
t", flags: RDONLY|CLOEXEC) =3D 12
>    501.062 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/session.slice/memory.stat", flag=
s: RDONLY|CLOEXEC) =3D 12
>    501.435 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/memory.pressure", flag=
s: RDONLY|CLOEXEC) =3D 12
>    501.585 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/memory.current", flags=
: RDONLY|CLOEXEC) =3D 12
>    501.676 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/memory.min", flags: RD=
ONLY|CLOEXEC) =3D 12
>    501.761 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/memory.low", flags: RD=
ONLY|CLOEXEC) =3D 12
>    501.845 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/memory.swap.current", =
flags: RDONLY|CLOEXEC) =3D 12
>    501.929 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/memory.stat", flags: R=
DONLY|CLOEXEC) =3D 12
>    502.118 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x=
2dmanager.slice/memory.pressure", flags: RDONLY|CLOEXEC) =3D 12
>    502.272 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x=
2dmanager.slice/memory.current", flags: RDONLY|CLOEXEC) =3D 12
>    502.367 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x=
2dmanager.slice/memory.min", flags: RDONLY|CLOEXEC) =3D 12
>    502.454 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x=
2dmanager.slice/memory.low", flags: RDONLY|CLOEXEC) =3D 12
>    502.542 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x=
2dmanager.slice/memory.swap.current", flags: RDONLY|CLOEXEC) =3D 12
>    502.628 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-gnome\x2dsession\x=
2dmanager.slice/memory.stat", flags: RDONLY|CLOEXEC) =3D 12
>    502.796 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal=
.slice/memory.pressure", flags: RDONLY|CLOEXEC) =3D 12
>    502.928 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal=
.slice/memory.current", flags: RDONLY|CLOEXEC) =3D 12
>    503.037 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal=
.slice/memory.min", flags: RDONLY|CLOEXEC) =3D 12
>    503.162 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal=
.slice/memory.low", flags: RDONLY|CLOEXEC) =3D 12
>    503.255 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal=
.slice/memory.swap.current", flags: RDONLY|CLOEXEC) =3D 12
>    503.341 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal=
.slice/memory.stat", flags: RDONLY|CLOEXEC) =3D 12
>    503.495 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/sy=
stem.slice/memory.pressure", flags: RDONLY|CLOEXEC) =3D 12
>    503.620 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/sy=
stem.slice/memory.current", flags: RDONLY|CLOEXEC) =3D 12
>    503.703 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/sy=
stem.slice/memory.min", flags: RDONLY|CLOEXEC) =3D 12
>    503.782 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/sy=
stem.slice/memory.low", flags: RDONLY|CLOEXEC) =3D 12
>    503.861 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/sy=
stem.slice/memory.swap.current", flags: RDONLY|CLOEXEC) =3D 12
>    503.939 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/sy=
stem.slice/memory.stat", flags: RDONLY|CLOEXEC) =3D 12
>    504.079 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1001.slice/user@1001.service/app.slice/memory.pressure", flag=
s: RDONLY|CLOEXEC) =3D 12
>    504.240 systemd-oomd/952 openat(dfd: CWD, filename: "/sys/fs/cgroup/us=
er.slice/user-1001.slice/user@1001.service/app.slice/memory.current", flags=
: RDONLY|CLOEXEC) =3D 12
> ^C

Thanks Arnaldo, it could also be that we need the code and it is my
user error which hasn't found a way of testing it. If the original
Huawei authors could let us know?

I suspect with this code gone, there is more bpf-loader map related
code that can also go as there is no way to use it. I wonder if a
better longer-term strategy is to remove BPF events entirely. My
thoughts on this are:
1) the code had bitrotten a few releases ago, I updated it but the
fact it rotted means I suspect nobody uses it.
2) the map code removed here I think is just redundant and it adds
complexity, so removing it is value add - unless I'm mistaken :-)
Removing more is more value add.
3) the clang/llvm dependencies are problematic in the build, removing
these would I think be a good value add
4) in the event parsing the BPF events have paths with '/' as the path
separator. This matches the modifier separator used by events and so I
think this leads to complexity.
5) the behavior achieved by BPF events can now be achieved with BPF
filters, which are more user friendly:
https://lore.kernel.org/all/20230314234237.3008956-1-namhyung@kernel.org/

There is a dependency with perf trace, but I think perf trace should
use BPF skeletons for augmented syscalls rather than a BPF event.
Using a BPF event in the perf trace feels kind of hacky and I suspect
perf trace users don't know they need to add the event to make
augmentation work.

Thanks,
Ian

> - Arnaldo
>
> > Ian Rogers (3):
> >   perf parse-event: Avoid BPF test segv
> >   perf tools: Revert enable indices setting syntax for BPF map
> >   perf parse-events: Remove array remnants
> >
> >  tools/perf/util/bpf-loader.c   | 101 ---------------------------
> >  tools/perf/util/parse-events.c |  18 +----
> >  tools/perf/util/parse-events.h |  10 ---
> >  tools/perf/util/parse-events.l |  11 ---
> >  tools/perf/util/parse-events.y | 122 ---------------------------------
> >  5 files changed, 2 insertions(+), 260 deletions(-)
> >
> > --
> > 2.41.0.487.g6d72f3e995-goog
> >
>
> --
>
> - Arnaldo
