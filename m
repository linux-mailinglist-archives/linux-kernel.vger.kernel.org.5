Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611827652EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbjG0Luo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjG0Lum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:50:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD974F0;
        Thu, 27 Jul 2023 04:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 334C661E0C;
        Thu, 27 Jul 2023 11:50:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348BFC433C7;
        Thu, 27 Jul 2023 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690458639;
        bh=8Z3xL7FuQ+Z8bk40zZw28Dfgj1A9m6znAkOj4q7/dr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b2P7TMH2z0zzbvEBF6qfTELADPV3MmiWlScD9IxZntUWmC+JTvbaXeAfykmn6XjR0
         XV8YdUA05eHZLHHmXl6TvV2mvPi0DeC4oXLyQ8teNNjYZNs7KfO3VqwxFiwp6F5m/t
         X6HElAnuTIvriJxJKZJW1iCgDgVvY676Rez7XW0XlT6Ng8mjMp/hiG3K6jY2LOcSze
         RUIxT+qQyzhVcHdnmKvwe7J5GqgyHWicTbyJiCTiwDKUwR9x66kJpkKQ0VrfhYoFNX
         4JjnUl8EPD/ZedS7gCylK6be/Y/CtPpy4bRQs8kLpel4BSihXs3hEv6puFJdwYp4Bg
         RR+0EjztQbsow==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B199E40516; Thu, 27 Jul 2023 08:50:36 -0300 (-03)
Date:   Thu, 27 Jul 2023 08:50:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] perf scripts python: Add command execution for
 perf gecko script
Message-ID: <ZMJaDGhSnhIlK3Nd@kernel.org>
References: <cover.1689961706.git.anupnewsmail@gmail.com>
 <cbf03cda175ea3dd2c6cd87bd3f12d803446cb95.1689961706.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbf03cda175ea3dd2c6cd87bd3f12d803446cb95.1689961706.git.anupnewsmail@gmail.com>
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

Em Fri, Jul 21, 2023 at 11:27:46PM +0530, Anup Sharma escreveu:
> This will enable the execution of perf-gecko.py script
> using record and report commands in perf script.
> And this will be also reflected at "perf script -l" command.
> 
> For Example:
>     perf script record perf-gecko
>     perf script report perf-gecko

But this isn't working:

[root@five ~]# perf script gecko
usage: gecko.py [-h] [--user-color USER_COLOR] [--kernel-color KERNEL_COLOR]
gecko.py: error: unrecognized arguments: -i -
[root@five ~]#

See below how this pipes the 'record' script with its 'report'
counterpart.

[root@five ~]# strace -s200 -e execve perf script gecko
execve("/root/bin/perf", ["perf", "script", "gecko"], 0x7ffd0b021c18 /* 23 vars */) = 0
execve("/bin/sh", ["/bin/sh", "/var/home/acme/libexec/perf-core/scripts/python/bin/gecko-report", "-i", "-"], 0x24a5c20 /* 26 vars */) = 0
usage: gecko.py [-h] [--user-color USER_COLOR] [--kernel-color KERNEL_COLOR]
gecko.py: error: unrecognized arguments: -i -
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=3275075, si_uid=0, si_status=2, si_utime=3 /* 0.03 s */, si_stime=0} ---
+++ exited with 2 +++
[root@five ~]#
[root@five ~]# perf record -F 99 -a -g -- sleep 5 -o - | perf script gecko
usage: gecko.py [-h] [--user-color USER_COLOR] [--kernel-color KERNEL_COLOR]
gecko.py: error: unrecognized arguments: -i -
[root@five ~]#

See it being used another script:

[root@five ~]# perf script -l
List of available trace scripts:
  failed-syscalls [comm]               system-wide failed syscalls
  rw-by-file <comm>                    r/w activity for a program, by file
  rw-by-pid                            system-wide r/w activity
  rwtop [interval]                     system-wide r/w top
  wakeup-latency                       system-wide min/max/avg wakeup latency
  compaction-times [-h] [-u] [-p|-pv] [-t | [-m] [-fs] [-ms]] [pid|pid-range|comm-regex] display time taken by mm compaction
  event_analyzing_sample               analyze all perf samples
  export-to-postgresql [database name] [columns] [calls] export perf data to a postgresql database
  export-to-sqlite [database name] [columns] [calls] export perf data to a sqlite3 database
  failed-syscalls-by-pid [comm]        system-wide failed syscalls, by pid
  flamegraph                           create flame graphs
  futex-contention                     futext contention measurement
  gecko                                create firefox gecko profile json format from perf.data
  intel-pt-events                      print Intel PT Events including Power Events and PTWRITE
  mem-phys-addr                        resolve physical address samples
  net_dropmonitor                      display a table of dropped frames
  netdev-times [tx] [rx] [dev=] [debug] display a process of packet and processing time
  powerpc-hcalls
  sched-migration                      sched migration overview
  sctop [comm] [interval]              syscall top
  stackcollapse                        produce callgraphs in short form for scripting use
  syscall-counts-by-pid [comm]         system-wide syscall counts, by pid
  syscall-counts [comm]                system-wide syscall counts
  task-analyzer                        analyze timings of tasks
[root@five ~]#

[root@five ~]# perf script futex-contention
Press control+C to stop and show the summary
^CSocket Thread[195353] lock 7f294b100018 contended 387 times, 579 avg ns [max: 32060 ns, min 390 ns]
WebrtcC~read #1[2866067] lock 7f294b100018 contended 390 times, 506 avg ns [max: 19130 ns, min 330 ns]
Socket Thread[12316] lock 7efd9479b8a0 contended 2 times, 785 avg ns [max: 910 ns, min 660 ns]
IPDL Background[12109] lock 7f7792b00018 contended 8 times, 6108 avg ns [max: 9060 ns, min 550 ns]
WebrtcWorker #3[2866076] lock 7f2922c074cc contended 5 times, 79002 avg ns [max: 133610 ns, min 22810 ns]
WebrtcWorker #4[2866078] lock 7f2922c07480 contended 19 times, 19540 avg ns [max: 57740 ns, min 4490 ns]
firefox[12080] lock 7f7792b00e18 contended 15 times, 86585 avg ns [max: 141290 ns, min 510 ns]
AudioIP~ent RPC[201969] lock 7f294b100018 contended 8 times, 1764 avg ns [max: 2440 ns, min 510 ns]
<SNIP>
TaskCon~ller #6[195531] lock 7f294b100dd8 contended 1 times, 10300 avg ns [max: 10300 ns, min 10300 ns]
Isolated Web Co[16799] lock 7ffb1d100018 contended 2 times, 7270 avg ns [max: 12450 ns, min 2090 ns]
[root@five ~]#

It will:

3275194 pts/2    S+     0:00 strace -s200 -e execve perf script futex-contention
3275197 pts/2    S+     0:00 /bin/sh /var/home/acme/libexec/perf-core/scripts/python/bin/futex-contention-report -i -
3275198 pts/2    S+     0:00 /bin/sh /var/home/acme/libexec/perf-core/scripts/python/bin/futex-contention-record -a -q -o -
3275199 pts/2    Sl+    0:00 perf record -e syscalls:sys_enter_futex -e syscalls:sys_exit_futex -a -q -o -
3275200 pts/2    S+     0:02 perf script -i - -s /var/home/acme/libexec/perf-core/scripts/python/futex-contention.py


Create a pipe, run
/var/home/acme/libexec/perf-core/scripts/python/bin/futex-contention-record
and pipe it into /var/home/acme/libexec/perf-core/scripts/python/bin/futex-contention-report

I also renamed perf-gecko to just gecko, no need to have the 'perf-'
prefix.

Try this other script, that updates the screen periodically:

[root@five ~]# perf script rwtop
read counts by pid:

   pid                  comm      # reads   bytes_req  bytes_read
------  --------------------   ----------  ----------  ----------
3275423  perf                      341653    16403072    16403816
3275448  Web Content                  615     2503477     1419444
3275431  DOMCacheThread               318     1234020     1232492
3275466  StreamTrans #1               141     1140597      518820
 12189  Cache2 I/O                    193      389798      376046
 12313  QuotaManager IO                81      126252      121668
3275432  StreamTrans #2                10       92305       92289
  9317  fuse-overlayfs               1078  1134780416       56796
3275414  StreamT~s #6488                5       45076       45068
3275446  IndexedDB #5496               25       33892       32364
3275461  pkla-check-auth               40       67235       28513
  1138  systemd-oomd                   40      106560       10520
  1170  polkitd                        51      110776        6951
  2227  pipewire                      370        2960        2960
  3137  gnome-terminal-                15       81104        2869
 12441  MemoryPoller                    3        3072        1559
  2425  pipewire-pulse                185        1480        1480
  2418  pipewire-pulse                185        1480        1480
 12751  threaded-ml                   563        5630         939
  2275  gnome-shell                    36      295488         888

write counts by pid:

   pid                  comm    # writes  bytes_written
------  --------------------  ----------  -------------
3275424  perf                        2440       68339552
 12518  mozStorage #4                 15         229545
 12521  LS Thread                    233         118752
 12189  Cache2 I/O                    11          21760
3275431  DOMCacheThread                4           4153
  2425  pipewire-pulse               370           2960
  2227  pipewire                     185           1480
 12751  threaded-ml                 1124           1124
 12080  firefox                      367            371
  1211  gdbus                         36            288
  1705  gdbus                         30            240
195348  Isolated Web Co              235            235
  1139  systemd-resolve                7            223
  2207  gnome-shell                   26            208
  1545  gdbus                         24            192
201970  AudioIPC0                    185            185
2866066  GraphRunner                 176            176
  1533  geoclue                       16            128
565667  gvfsd-dnssd                   16            128
3275460  pcscd                        15            120
[root@five ~]#

I put what I have on this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

Later I'll try and work on have this working if you don't beat me to it
:-)

- Arnaldo

 
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  tools/perf/scripts/python/bin/perf-gecko-record | 2 ++
>  tools/perf/scripts/python/bin/perf-gecko-report | 3 +++
>  2 files changed, 5 insertions(+)
>  create mode 100644 tools/perf/scripts/python/bin/perf-gecko-record
>  create mode 100644 tools/perf/scripts/python/bin/perf-gecko-report
> 
> diff --git a/tools/perf/scripts/python/bin/perf-gecko-record b/tools/perf/scripts/python/bin/perf-gecko-record
> new file mode 100644
> index 000000000000..7df5a19c0163
> --- /dev/null
> +++ b/tools/perf/scripts/python/bin/perf-gecko-record
> @@ -0,0 +1,2 @@
> +#!/bin/bash
> +perf record -g "$@"
> diff --git a/tools/perf/scripts/python/bin/perf-gecko-report b/tools/perf/scripts/python/bin/perf-gecko-report
> new file mode 100644
> index 000000000000..6781313dc862
> --- /dev/null
> +++ b/tools/perf/scripts/python/bin/perf-gecko-report
> @@ -0,0 +1,3 @@
> +#!/bin/bash
> +# description: create firefox gecko profile json format from perf.data
> +perf script -s "$PERF_EXEC_PATH"/scripts/python/perf-gecko.py -- "$@"
> -- 
> 2.34.1
> 

-- 

- Arnaldo
