Return-Path: <linux-kernel+bounces-100817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF319879D99
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CF5283042
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11D514374B;
	Tue, 12 Mar 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0k2xDwo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359613B2BF;
	Tue, 12 Mar 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279763; cv=none; b=iu7nZl9M2RO50W9/ombIRB+chMoU7AneFbpYaeMQ/F/EOXjqtUUFU5tROFpCQjSPyhufEO9E+sqVVakHXhTqiK8gWgROnkd0g0TDbfedQwlMMC7C0aUPvu0AAze2MLbit+WGVTTtxUjpldkbi6wfOoXCVBokEBQJqVfSrMb5AnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279763; c=relaxed/simple;
	bh=W3FSQZv89cusMUVW3ElHSNyEA18sloH+ZNmd7l2ek4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ661UC9522zhw1rV28SqkUerTNuA8VTJUbpMauBsPcZuPRrqBaxiCmt6bYwRrEM4+Eqcnt3ZjfDPSF9uJ1axnavj/QDHdSoXL9V2/cj1YWuLPBtiZly6R+mF6QYutJqOYstLZHK/y/nhjSbei9qVdU0gi2XJWeIWHezHxltb3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0k2xDwo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC695C433F1;
	Tue, 12 Mar 2024 21:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710279762;
	bh=W3FSQZv89cusMUVW3ElHSNyEA18sloH+ZNmd7l2ek4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0k2xDwolymaumbjRTiV58xRgX4XLltojrHqEZrvlWwXAMHGRVmP3IEM3+SsqgWgc
	 lXxgnVtINJC5uTFBwf8tBUDCLftr3SH/bNYay5OwncMKBhoo8HyBKXl2rQwm/2lMCX
	 iIpy3IsbD+Saz7WuHu4dzMHTBUExBfgP7IvPTsTJoWgkgfZEn1fOmdlOjfMI5IjIac
	 oEihZdonxJzRLz1wt9ZYG5HTChfYsXdy/5yoPfobZpG+esewEaKvXqOcFgVUzXeJWd
	 QJKP7Cbnyv8afeEcQaDSlxstskuNXemnDRWGa2GQqq8Lk4rzGIDF8fZN0+bE3jTIOa
	 maj7+y+Ubc13A==
Date: Tue, 12 Mar 2024 18:42:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfDMTlTH2SdwlB9M@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240312180814.3373778-1-bigeasy@linutronix.de>

On Tue, Mar 12, 2024 at 07:01:48PM +0100, Sebastian Andrzej Siewior wrote:
> Hi,
>=20
> Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> the signal gets delayed until event_sched_out() which then uses
> task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> signal is delivered with disabled preemption.
>=20
> While looking at this, I also stumbled upon __perf_pending_irq() which
> requires disabled interrupts but this is not the case on PREEMPT_RT.
>=20
> This series aim to address both issues while not introducing a new issue
> at the same time ;)
> Any testing is appreciated.
>=20
> v1=E2=80=A6v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigea=
sy@linutronix.de/
>     - Marco pointed me to the testsuite that showed two problems:
>       - Delayed task_work from NMI / missing events.
>         Fixed by triggering dummy irq_work to enforce an interrupt for
> 	the exit-to-userland path which checks task_work
>       - Increased ref-count on clean up/ during exec.
>         Mostly addressed by the former change. There is still a window
> 	if the NMI occurs during execve(). This is addressed by removing
> 	the task_work before free_event().
>       The testsuite (remove_on_exec) fails sometimes if the event/
>       SIGTRAP is sent before the sighandler is installed.

Survives:

[acme@nine perf_events]$ for x in {0..1000}; do (perf test sigtrap &); done

And:

[acme@nine perf_events]$ pwd
/home/acme/git/linux/tools/testing/selftests/perf_events
[acme@nine perf_events]$ for x in {0..100}; do (./remove_on_exec &); done

Nothing on dmesg.

But:

[acme@nine ~]$ pidof exec_child
24273 24271 24270 24269 24268 24267 24266 24265 24264 24263 24262 24261 242=
60 24259 24258 24257 24256 24255 24254 24253 24252 24251 24250 24249 24248 =
24247 24246 24245 24244 24243 24242 24241 24240 24239 24238 24237 24236 242=
33 24232 24231 24230 24229 24228 24227 24226 24225 24224 24223 24220 24219 =
24218 24217 24216 24215 24214 24213 24212 24211 24210 24209 24208 24207 242=
06 24204 24203 24202 24201 24200 24199 24198 24197 24196 24195 24194 24192 =
24191 24190 24189 24188 24187 24186 24185 24184 24183 24182 24181 24180 241=
79 24178 24177 24176 24175 24174 24173 24172 24171 24170 24169 24168 24167 =
24166 24165 24164 24163 24162 24161 24160 24159 24158 24157 24154 24153 241=
52 24151 24150 24149 24148 24147 24146 24145 24144 24143 24142 24141 24140 =
24139 24138 24137 24136 24135 24134 24133 24132 24131 24130 24129 24127 241=
26 24125 24124 24123 24122 24121 24120 24119 24118 24117 24115 24114 24113 =
24112 24111 24110 24109 24108 24107 24106 24105 24104 24103 24102 24101 241=
00 24099 24098 24097 24096 24095 24094 24093 24092 24091 24090 24089 24088 =
24087 24086 24085 24084 24083 24082 24081 24080 24076 24075 24074 24073 240=
72 24071 24070 24069 24068 24067 24066 24065 24064 24063 24062 24061 24060 =
24059 24058 24057 24056 24055 24054 24053 24052 24051 24049 24048 24047 240=
46 24045 24044 24043 24042 24041 24040 24039 24037 24036 24035 24034 24033 =
24032 24031 24030 24029 24028 24027 24026 24025 24024 24023 24022 24021 240=
20 24019 24018 24017 24016 24015 24014 24013 24012 24011 24010 24009 24008 =
24007 24006 24005 24004 24003 24002 23998 23997 23996 23995 23994 23993 239=
92 23991 23990 23989 23988 23986 23985 23984 23983 23982 23981 23980 23979 =
23978 23977 23976 23975 23974 23973 23972 23970 23969 23968 23967 23966 239=
65 23964 23963 23962 23961 23960 23958 23957 23956 23955 23954 23953 23952 =
23951 23950 23949 23948 23947 23946 23945 23944 23943 23942 23941 23940 239=
39 23938 23937 23936 23935 23934 23933 23932 23931 23930 23929 23928 23927 =
23926 23925 23924 23923 23919 23918 23917 23916 23915 23914 23913 23912 239=
11 23910 23909 23907 23906 23905 23904 23903 23902 23901 23900 23899 23898 =
23897 23896 23895 23894 23893 23891 23890 23889 23888 23887 23886 23885 238=
84 23883 23882 23881 23879 23878 23877 23876 23875 23874 23873 23872 23871 =
23870 23869 23867 23866 23865 23864 23863 23862 23858 23857 23856 23855 238=
54 23853 23852 23851 23850 23849 23848 23847 23846 23845 23844 23843 23842 =
23841 23840 23833 23832 23831 23830 23829 23828 23827 23826 23825 23824 238=
23 23820 23819 23818 23817 23816 23815 23814 23813 23812 23811 23810 23809 =
23808 23807 23806 23804 23803 23802 23801 23800 23799 23798 23797 23793 237=
92 23791 23787 23786 23774 23773 23772 23771 23770 23769 23768 23767 23756 =
23754 23751 23750 23749 23748 23747 23746 23743 23734 23733 23732 23731 237=
30 23729 23728 23727 23726 23725 23724 23723 23722 23719 23716 23715 23684 =
23668 23667 23666 23589 23574 23573 23526 23461 23396 23395 23375 23271 232=
70 23266 23242 23241 23231 23214 23213 23210 23197 23196 23182 23181 23129 =
23128 23046 22964
[acme@nine ~]$

[root@nine ~]# cat /proc/24263/stack
[<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
[<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
[root@nine ~]#

[root@nine ~]# for a in `pidof exec_child` ; do cat /proc/$a/stack ; done |=
 sort | uniq -c
      1 [<0>] asm_common_interrupt+0x22/0x40
    495 [<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
      2 [<0>] asm_sysvec_reschedule_ipi+0x16/0x20
    498 [<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
[root@nine ~]#

[acme@nine ~]$ ps ax|grep exec_child| wc -l
504
[acme@nine ~]$ ps ax|grep exec_child| tail
  24264 pts/0    R      0:04 exec_child
  24265 pts/0    R      0:04 exec_child
  24266 pts/0    R      0:04 exec_child
  24267 pts/0    R      0:04 exec_child
  24268 pts/0    R      0:04 exec_child
  24269 pts/0    R      0:04 exec_child
  24270 pts/0    R      0:04 exec_child
  24271 pts/0    R      0:04 exec_child
  24273 pts/0    R      0:04 exec_child
  26704 pts/1    S+     0:00 grep --color=3Dauto exec_child
[acme@nine ~]$

All in 'R' state.

[root@nine ~]# killall exec_child
exec_child: no process found
[root@nine ~]# ps ax | grep exec_child | head -5
  22964 pts/0    R      0:06 exec_child
  23046 pts/0    R      0:05 exec_child
  23128 pts/0    R      0:05 exec_child
  23129 pts/0    R      0:05 exec_child
  23181 pts/0    R      0:05 exec_child
[root@nine ~]# kill 22964 23046 23128 23129 23181
[root@nine ~]# ps ax | grep exec_child | head -5
  23182 pts/0    R      0:06 exec_child
  23196 pts/0    R      0:06 exec_child
  23197 pts/0    R      0:06 exec_child
  23210 pts/0    R      0:06 exec_child
  23213 pts/0    R      0:06 exec_child
[root@nine ~]#

[root@nine ~]# kill `pidof exec_child`
[root@nine ~]# ps ax | grep exec_child | head -5
  26806 pts/0    S+     0:00 grep --color=3Dauto exec_child
[root@nine ~]#

[acme@nine perf_events]$ ps ax|grep exec_child
  26816 pts/0    S+     0:00 grep --color=3Dauto exec_child
[acme@nine perf_events]$ ./remove_on_exec=20
TAP version 13
1..4
# Starting 4 tests from 1 test cases.
#  RUN           remove_on_exec.fork_only ...
#            OK  remove_on_exec.fork_only
ok 1 remove_on_exec.fork_only
#  RUN           remove_on_exec.fork_exec_then_enable ...
#            OK  remove_on_exec.fork_exec_then_enable
ok 2 remove_on_exec.fork_exec_then_enable
#  RUN           remove_on_exec.enable_then_fork_exec ...
*#            OK  remove_on_exec.enable_then_fork_exec
ok 3 remove_on_exec.enable_then_fork_exec
#  RUN           remove_on_exec.exec_stress ...
*************************#            OK  remove_on_exec.exec_stress
ok 4 remove_on_exec.exec_stress
# PASSED: 4 / 4 tests passed.
# Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
[acme@nine perf_events]$ ps ax|grep exec_child
  26858 pts/0    S+     0:00 grep --color=3Dauto exec_child
[acme@nine perf_events]$ ps ax|grep exec_child
  26860 pts/0    S+     0:00 grep --color=3Dauto exec_child
[acme@nine perf_events]$=20

[acme@nine perf_events]$ for x in {0..100}; do (./remove_on_exec &); done
<SNIP>

While it runs I can see:

[acme@nine ~]$ ps ax|grep exec_child
  28627 pts/0    R      0:00 exec_child
  28668 pts/0    R      0:00 exec_child
  28744 pts/0    R      0:00 exec_child
  28813 pts/0    R      0:00 exec_child
  28912 pts/0    R      0:00 exec_child
  29666 pts/1    S+     0:00 grep --color=3Dauto exec_child
[acme@nine ~]$

at the end they disappeared, on this last run.

But if I do a 'killall remove_on_exec' and stop that loop (control+C/Z)
we get all those exec_child running a seemingly eternal loop:

[acme@nine ~]$ ps ax|grep exec_child|wc -l
479
[acme@nine ~]$ ps ax|grep exec_child|head
  30143 pts/0    R      0:01 exec_child
  30144 pts/0    R      0:01 exec_child
  30145 pts/0    R      0:01 exec_child
  30147 pts/0    R      0:01 exec_child
  30150 pts/0    R      0:01 exec_child
  30151 pts/0    R      0:01 exec_child
  30153 pts/0    R      0:01 exec_child
  30154 pts/0    R      0:01 exec_child
  30155 pts/0    R      0:01 exec_child
  30156 pts/0    R      0:01 exec_child
[acme@nine ~]$ sudo cat /proc/30143/stack=20
[<0>] irqentry_exit_to_user_mode+0x1c9/0x1e0
[<0>] asm_sysvec_apic_timer_interrupt+0x16/0x20
[acme@nine ~]$

[acme@nine perf_events]$ uptime
 18:36:17 up 16 min,  2 users,  load average: 460.01, 375.77, 240.59
[acme@nine perf_events]$ uptime
 18:36:21 up 16 min,  2 users,  load average: 461.53, 377.49, 241.87
[acme@nine perf_events]$ uptime
 18:36:24 up 16 min,  2 users,  load average: 462.85, 379.16, 243.14
[acme@nine perf_events]$ uptime
 18:36:27 up 16 min,  2 users,  load average: 462.85, 379.16, 243.14
[acme@nine perf_events]$

- Arnaldo

