Return-Path: <linux-kernel+bounces-17970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A095825622
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5145B28186E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1499E2E3EC;
	Fri,  5 Jan 2024 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD1Qnp4N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519F28DDA;
	Fri,  5 Jan 2024 14:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A3EC433C7;
	Fri,  5 Jan 2024 14:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704466442;
	bh=95qXFFP9Z5S46JCVPreyYstM32/OG91QTjBJRm3RrYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DD1Qnp4NJT43hzECLzDkNWXGNix+MrtFJjFc0Zd2H4qjp/0yRe0xZZ2uQSakNz8QG
	 P6jj5ft17QlUIyKKSYjcAOElPE34EbPqH2I7R37wRxxtNEUTkAQxTIiDWEjHK5sWQh
	 xOzw2qVfNwO/6xzcrhgCE6DbQUJaskfRFTC35mvW8lVr+DgY7iGn5nOeKxBH8VFIEB
	 taFP/WGtLbY3wzL7/VD9GrV/Jh/7xRsQ4YA4KcBsJxF25cZSsAexTfNYeLm6t+oSSL
	 LYTg5R+ccWTXvAE26+N0ntlaZd7u16w2HSkd3fLmFjc5aUrUROCbCMjZVU20XiGHgS
	 whoIZ2v9FZtiw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 57BA8403EF; Fri,  5 Jan 2024 11:53:57 -0300 (-03)
Date: Fri, 5 Jan 2024 11:53:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] lib subcmd: Fix memory leak in uniq
Message-ID: <ZZgYBRxSMw_T5EE1@kernel.org>
References: <20231208000515.1693746-1-irogers@google.com>
 <CAP-5=fVQfqS6gu9Ua3Exijc_ZaBzrt2=1PMopgdoyC_6R_cnaQ@mail.gmail.com>
 <ZZcdDyyADG8dP8LM@kernel.org>
 <CAP-5=fVfCnPG0O51rRXVqkGRU4eW7n0B1YGr9pL8CbwxG+V8jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVfCnPG0O51rRXVqkGRU4eW7n0B1YGr9pL8CbwxG+V8jQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Jan 04, 2024 at 03:29:34PM -0800, Ian Rogers escreveu:
> On Thu, Jan 4, 2024 at 1:03 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Tue, Jan 02, 2024 at 11:30:39AM -0800, Ian Rogers escreveu:
> > > On Thu, Dec 7, 2023 at 4:05 PM Ian Rogers <irogers@google.com> wrote:
> > > > uniq will write one command name over another causing the overwritten
> > > > string to be leaked. Fix by doing a pass that removes duplicates and a
> > > > second that removes the holes.

> > I applied the first one, the fix for uniq(), but somehow the second
> > didn't work for me as in your examples, nor the third, the output is the
> > same as before.
 
> I tried to repro the failure with a rebase but couldn't. I suspected
> libsubcmd wasn't being rebuilt or something like that. I suspect now
> that you have ~/.perfconfig with help.autocorrect set, which means the
> output will vary as it will automatically try to run the autocorrected
> command. Could you check for me?

[acme@quaco perf-tools-next]$ perf reccord
Failed to run command 'reccord': No such file or directory
[acme@quaco perf-tools-next]$ perf -v
perf version 6.7.rc6.gcd1e3ef8bfe8
[acme@quaco perf-tools-next]$ git log --oneline -5
cd1e3ef8bfe8f827 (HEAD -> perf-tools-next) perf help: Lower levenshtein penality for deleting character
c5c7365af812728e perf: Suggest inbuilt commands for unknown command
b6d8b858dbbbd832 (perf-tools-next.korg/tmp.perf-tools-next, perf-tools-next.korg/perf-tools-next, number/perf-tools-next, five/perf-tools-next, acme.korg/tmp.perf-tools-next, acme.korg/perf-tools-next) perf test: test case 'Setup struct perf_event_attr' fails on s390 on z/vm
1e24ce402c97dc3c (perf-tools-next/tmp.perf-tools-next, acme/tmp.perf-tools-next) perf db-export: Fix missing reference count get in call_path_from_sample()
bb177a85e82b37d3 perf tests: Add perf script test
[acme@quaco perf-tools-next]$ perf reccord
Failed to run command 'reccord': No such file or directory
[acme@quaco perf-tools-next]$ cat ~/.perfconfig
[acme@quaco perf-tools-next]$ sudo cat /etc/perfconfig
[sudo] password for acme:
cat: /etc/perfconfig: No such file or directory
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$ sudo su -
[root@quaco ~]# perf -v
perf version 6.7.rc6.gcd1e3ef8bfe8
[root@quaco ~]# perf reccord
Failed to run command 'reccord': No such file or directory
[root@quaco ~]# cat ~/.perfconfig
[root@quaco ~]# perf trace -e open*,access* perf reccord
     0.000 ( 0.006 ms): perf/10791 access(filename: "/etc/ld.so.preload", mode: R)                       = -1 ENOENT (No such file or directory)
     0.012 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.035 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libunwind-x86_64.so.8", flags: RDONLY|CLOEXEC) = 3
     0.084 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libunwind.so.8", flags: RDONLY|CLOEXEC) = 3
     0.128 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/liblzma.so.5", flags: RDONLY|CLOEXEC) = 3
     0.170 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libm.so.6", flags: RDONLY|CLOEXEC) = 3
     0.221 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libopencsd_c_api.so.1", flags: RDONLY|CLOEXEC) = 3
     0.264 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libz.so.1", flags: RDONLY|CLOEXEC) = 3
     0.305 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libelf.so.1", flags: RDONLY|CLOEXEC) = 3
     0.348 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libdebuginfod.so.1", flags: RDONLY|CLOEXEC) = 3
     0.386 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libdw.so.1", flags: RDONLY|CLOEXEC) = 3
     0.428 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libcrypto.so.3", flags: RDONLY|CLOEXEC) = 3
     0.480 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libslang.so.2", flags: RDONLY|CLOEXEC) = 3
     0.526 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libperl.so.5.36", flags: RDONLY|CLOEXEC) = 3
     0.575 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.628 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libpython3.11.so.1.0", flags: RDONLY|CLOEXEC) = 3
     0.675 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libstdc++.so.6", flags: RDONLY|CLOEXEC) = 3
     0.729 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libzstd.so.1", flags: RDONLY|CLOEXEC) = 3
     0.772 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libcap.so.2", flags: RDONLY|CLOEXEC) = 3
     0.811 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libnuma.so.1", flags: RDONLY|CLOEXEC) = 3
     0.849 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libbabeltrace-ctf.so.1", flags: RDONLY|CLOEXEC) = 3
     0.895 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libpfm.so.4", flags: RDONLY|CLOEXEC) = 3
     0.940 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libtraceevent.so.1", flags: RDONLY|CLOEXEC) = 3
     0.976 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libgcc_s.so.1", flags: RDONLY|CLOEXEC) = 3
     1.023 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libopencsd.so.1", flags: RDONLY|CLOEXEC) = 3
     1.071 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libcurl.so.4", flags: RDONLY|CLOEXEC) = 3
     1.116 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libbz2.so.1", flags: RDONLY|CLOEXEC) = 3
     1.157 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libcrypt.so.2", flags: RDONLY|CLOEXEC) = 3
     1.216 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libbabeltrace.so.1", flags: RDONLY|CLOEXEC) = 3
     1.260 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libpopt.so.0", flags: RDONLY|CLOEXEC) = 3
     1.299 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libuuid.so.1", flags: RDONLY|CLOEXEC) = 3
     1.341 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libgmodule-2.0.so.0", flags: RDONLY|CLOEXEC) = 3
     1.382 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libglib-2.0.so.0", flags: RDONLY|CLOEXEC) = 3
     1.438 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libnghttp2.so.14", flags: RDONLY|CLOEXEC) = 3
     1.478 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libidn2.so.0", flags: RDONLY|CLOEXEC) = 3
     1.525 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libssh.so.4", flags: RDONLY|CLOEXEC) = 3
     1.576 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libpsl.so.5", flags: RDONLY|CLOEXEC) = 3
     1.621 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libssl.so.3", flags: RDONLY|CLOEXEC) = 3
     1.663 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libgssapi_krb5.so.2", flags: RDONLY|CLOEXEC) = 3
     1.707 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libldap.so.2", flags: RDONLY|CLOEXEC) = 3
     1.755 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/liblber.so.2", flags: RDONLY|CLOEXEC) = 3
     1.795 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libbrotlidec.so.1", flags: RDONLY|CLOEXEC) = 3
     1.852 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libpcre2-8.so.0", flags: RDONLY|CLOEXEC) = 3
     1.899 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libunistring.so.2", flags: RDONLY|CLOEXEC) = 3
     1.948 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libkrb5.so.3", flags: RDONLY|CLOEXEC) = 3
     1.997 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libk5crypto.so.3", flags: RDONLY|CLOEXEC) = 3
     2.040 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libcom_err.so.2", flags: RDONLY|CLOEXEC) = 3
     2.089 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libkrb5support.so.0", flags: RDONLY|CLOEXEC) = 3
     2.132 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libkeyutils.so.1", flags: RDONLY|CLOEXEC) = 3
     2.175 ( 0.004 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libresolv.so.2", flags: RDONLY|CLOEXEC) = 3
     2.237 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libevent-2.1.so.7", flags: RDONLY|CLOEXEC) = 3
     2.288 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libsasl2.so.3", flags: RDONLY|CLOEXEC) = 3
     2.337 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libbrotlicommon.so.1", flags: RDONLY|CLOEXEC) = 3
     2.399 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/lib64/libselinux.so.1", flags: RDONLY|CLOEXEC) = 3
     9.457 ( 0.006 ms): perf/10791 access(filename: "/etc/selinux/config")                               = 0
     9.719 ( 0.014 ms): perf/10791 openat(dfd: CWD, filename: "/proc/self/status")                       = 3
     9.759 ( 0.007 ms): perf/10791 openat(dfd: CWD, filename: "/sys/devices/system/node", flags: RDONLY|CLOEXEC|DIRECTORY|NONBLOCK) = 3
     9.786 ( 0.006 ms): perf/10791 openat(dfd: CWD, filename: "/sys/devices/system/node/node0/meminfo")  = 4
     9.825 ( 0.006 ms): perf/10791 openat(dfd: CWD, filename: "/sys/devices/system/cpu/possible", flags: RDONLY|CLOEXEC) = 3
     9.837 ( 0.005 ms): perf/10791 openat(dfd: CWD, filename: "/proc/self/status")                       = 3
     9.962 ( 0.005 ms): perf/10791 access(filename: "/home/acme/etc/perfconfig", mode: R)                = -1 ENOENT (No such file or directory)
Failed to run command 'reccord': No such file or directory
[root@quaco ~]#
[root@quaco ~]# perf -vv
perf version 6.7.rc6.gcd1e3ef8bfe8
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
[root@quaco ~]#

