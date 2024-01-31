Return-Path: <linux-kernel+bounces-46536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8938E84410B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC13C1C21978
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53B580BFD;
	Wed, 31 Jan 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7NCyMCF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D54F7BAF6;
	Wed, 31 Jan 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709184; cv=none; b=bzSVnx9F5/0VLMJqPDCbW7jRpBNsflHoG6UtFhAWaD4ycIR6Gc2IgMaC5bcXq4bky1tB5eE3cB/Tk2C3IYmEw7SLGOyOwe/KDEUysQSUIBTfcHMde8K/Y4+mxqXO6KqM1Wc+362WHf7c9w4EQkQwFqxn+BLHTfZ1VsLuozH1x1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709184; c=relaxed/simple;
	bh=pehbt8V3EqnIUmYWdqifG2DIXs/t3uQ4R+BQF3GdtPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZ0nED68dFuVyQ3sIn2yk/NV3GVc+Fn5rTvB4RiLiTUJC02z8sr6ZmaQkgv/MeT9kZh6BSgqrO6PBfNdo3SSNTghRmpVB+WiM7Sgx56D7GJ/++wDv/42NS9JgibDuULq4APCUpf6QyNhCS/UleF8pyxvYniLfAxdUuUwx9MdLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7NCyMCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D413C433F1;
	Wed, 31 Jan 2024 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706709184;
	bh=pehbt8V3EqnIUmYWdqifG2DIXs/t3uQ4R+BQF3GdtPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e7NCyMCFF7NR7zjQGMEe/b4ezrEk/mt97rIYtMNJUPAzKMK90gUUYZT2nHMTfaMoy
	 LWcysl2q05hbyGwhMA5BDkW+hqqfmj2fXonynGjtTAl4KFKg2WxMaHsdpxk0Cl6nN4
	 NwE+Do3+y5LtNgca+urjTpUqKPetQESVLQ7Pf5MyDSxnrgCKiBxUmd4vlt7Hzo6wGT
	 hBUGFytRGkTAMSqQO0LW1c9QdEQsuxXsgFhTec8TAJ2LuylVFAsWYkJfCBR3NVSM4X
	 vyc6WvO8+8h8npsWdxjRRG3oHCk12tKv43MK1UXqg6SS3IizkeLmy3j9lH+Y9C+eSL
	 QTnM2VBwB3ing==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 56B0E40441; Wed, 31 Jan 2024 10:53:01 -0300 (-03)
Date: Wed, 31 Jan 2024 10:53:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org,
	Veronika Molnarova <vmolnaro@redhat.com>, acme@redhat.com,
	mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] perf testsuite: Add common regex patters
Message-ID: <ZbpQvUFO0oQ7c_Iq@kernel.org>
References: <20240131113951.17077-1-mpetlan@redhat.com>
 <ZbpPa1ZjoOdGw9Yd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbpPa1ZjoOdGw9Yd@kernel.org>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 31, 2024 at 10:47:23AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 31, 2024 at 12:39:45PM +0100, Michael Petlan escreveu:
> > From: Veronika Molnarova <vmolnaro@redhat.com>

> > Unify perf regexes for checking testing output into a single file
> > to reduce duplicates and prevent errors when editing.

> > This will be used in upcomming patches in shell tests.

> Thanks for working on this!
 
> The cover letter could've said that this is an effort to upstream a
> pre-existing test suite that is being used for quite a long time, that
> it is available in github, etc :-)

Also it should CC the perf tools reviewers and maintainers:

⬢[acme@toolbox perf-tools]$ scripts/get_maintainer.pl tools/perf/tests/shell/
Peter Zijlstra <peterz@infradead.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Ingo Molnar <mingo@redhat.com> (supporter:PERFORMANCE EVENTS SUBSYSTEM)
Arnaldo Carvalho de Melo <acme@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:101/122=83%)
Namhyung Kim <namhyung@kernel.org> (supporter:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:40/122=33%,authored:13/122=11%)
Mark Rutland <mark.rutland@arm.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Alexander Shishkin <alexander.shishkin@linux.intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Jiri Olsa <jolsa@kernel.org> (reviewer:PERFORMANCE EVENTS SUBSYSTEM)
Ian Rogers <irogers@google.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM,commit_signer:66/122=54%,authored:17/122=14%)
Adrian Hunter <adrian.hunter@intel.com> (reviewer:PERFORMANCE EVENTS SUBSYSTEM,authored:8/122=7%)
Athira Rajeev <atrajeev@linux.vnet.ibm.com> (commit_signer:50/122=41%,authored:20/122=16%)
Kajol Jain <kjain@linux.ibm.com> (commit_signer:31/122=25%,authored:10/122=8%)
linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM)
⬢[acme@toolbox perf-tools]$

For reviewers, the series of patches can be accessed via the
linux-perf-users mail archive at:

https://lore.kernel.org/linux-perf-users/ZbpPa1ZjoOdGw9Yd@kernel.org/

There are many, many tests in Michael's test suite, its super great that
this work is being done so that people using 'perf test' will have a far
greater tool testing coverage,

Again, thanks a lot!
 
- Arnaldo
  
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > ---
> >  tools/perf/tests/shell/common/patterns.sh | 256 ++++++++++++++++++++++
> >  1 file changed, 256 insertions(+)
> >  create mode 100644 tools/perf/tests/shell/common/patterns.sh
> > 
> > diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/tests/shell/common/patterns.sh
> > new file mode 100644
> > index 000000000000..919a07b8b454
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/common/patterns.sh
> > @@ -0,0 +1,256 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +export RE_NUMBER="[0-9\.]+"
> > +# Number
> > +# Examples:
> > +#    123.456
> > +
> > +
> > +export RE_NUMBER_HEX="[0-9A-Fa-f]+"
> > +# Hexadecimal number
> > +# Examples:
> > +#    1234
> > +#    a58d
> > +#    aBcD
> > +#    deadbeef
> > +
> > +
> > +export RE_DATE_YYYYMMDD="[0-9]{4}-(?:(?:01|03|05|07|08|10|12)-(?:[0-2][0-9]|3[0-1])|02-[0-2][0-9]|(?:(?:04|06|09|11)-(?:[0-2][0-9]|30)))"
> > +# Date in YYYY-MM-DD form
> > +# Examples:
> > +#    1990-02-29
> > +#    0015-07-31
> > +#    2456-12-31
> > +#!   2012-13-01
> > +#!   1963-09-31
> > +
> > +
> > +export RE_TIME="(?:[0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"
> > +# Time
> > +# Examples:
> > +#    15:12:27
> > +#    23:59:59
> > +#!   24:00:00
> > +#!   11:25:60
> > +#!   17:60:15
> > +
> > +
> > +export RE_DATE_TIME="\w+\s+\w+\s+$RE_NUMBER\s+$RE_TIME\s+$RE_NUMBER"
> > +# Time and date
> > +# Examples:
> > +#    Wed Feb 12 10:46:26 2020
> > +#    Mon Mar  2 13:27:06 2020
> > +#!   St úno 12 10:57:21 CET 2020
> > +#!   Po úno 14 15:17:32 2010
> > +
> > +
> > +export RE_ADDRESS="0x$RE_NUMBER_HEX"
> > +# Memory address
> > +# Examples:
> > +#    0x123abc
> > +#    0xffffffff9abe8ae8
> > +#    0x0
> > +
> > +
> > +export RE_ADDRESS_NOT_NULL="0x[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*"
> > +# Memory address (not NULL)
> > +# Examples:
> > +#    0xffffffff9abe8ae8
> > +#!   0x0
> > +#!   0x0000000000000000
> > +
> > +export RE_PROCESS_PID="\w+\/\d+"
> > +# A process with PID
> > +# Example:
> > +#    sleep/4102
> > +
> > +
> > +export RE_EVENT_ANY="[\w\-\:\/_=,]+"
> > +# Name of any event (universal)
> > +# Examples:
> > +#    cpu-cycles
> > +#    cpu/event=12,umask=34/
> > +#    r41e1
> > +#    nfs:nfs_getattr_enter
> > +
> > +
> > +export RE_EVENT="[\w\-:_]+"
> > +# Name of an usual event
> > +# Examples:
> > +#    cpu-cycles
> > +
> > +
> > +export RE_EVENT_RAW="r$RE_NUMBER_HEX"
> > +# Specification of a raw event
> > +# Examples:
> > +#    r41e1
> > +#    r1a
> > +
> > +
> > +export RE_EVENT_CPU="cpu/(\w+=$RE_NUMBER_HEX,?)+/p*"
> > +# Specification of a CPU event
> > +# Examples:
> > +#    cpu/event=12,umask=34/pp
> > +
> > +
> > +export RE_EVENT_UNCORE="uncore/[\w_]+/"
> > +# Specification of an uncore event
> > +# Examples:
> > +#    uncore/qhl_request_local_reads/
> > +
> > +
> > +export RE_EVENT_SUBSYSTEM="[\w\-]+:[\w\-]+"
> > +# Name of an event from subsystem
> > +# Examples:
> > +#    ext4:ext4_ordered_write_end
> > +#    sched:sched_switch
> > +
> > +
> > +export RE_FILE_NAME="[\w\+\.-]+"
> > +# A filename
> > +# Examples:
> > +#    libstdc++.so.6
> > +#!   some/path
> > +
> > +
> > +export RE_PATH_ABSOLUTE="(?:\/$RE_FILE_NAME)+"
> > +# A full filepath
> > +# Examples:
> > +#    /usr/lib64/somelib.so.5.4.0
> > +#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
> > +#    /usr/bin/mv
> > +#!   some/relative/path
> > +#!   ./some/relative/path
> > +
> > +
> > +export RE_PATH="(?:$RE_FILE_NAME)?$RE_PATH_ABSOLUTE"
> > +# A filepath
> > +# Examples:
> > +#    /usr/lib64/somelib.so.5.4.0
> > +#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
> > +#    ./.emacs
> > +#    src/fs/file.c
> > +
> > +
> > +export RE_DSO="(?:$RE_PATH_ABSOLUTE(?: \(deleted\))?|\[kernel\.kallsyms\]|\[unknown\]|\[vdso\]|\[kernel\.vmlinux\][\.\w]*)"
> > +# A DSO name in various result tables
> > +# Examples:
> > +#    /usr/lib64/somelib.so.5.4.0
> > +#    /usr/bin/somebinart (deleted)
> > +#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
> > +#    [kernel.kallsyms]
> > +#    [kernel.vmlinux]
> > +#    [vdso]
> > +#    [unknown]
> > +
> > +
> > +export RE_LINE_COMMENT="^#.*"
> > +# A comment line
> > +# Examples:
> > +#    # Started on Thu Sep 10 11:43:00 2015
> > +
> > +
> > +export RE_LINE_EMPTY="^\s*$"
> > +# An empty line with possible whitespaces
> > +# Examples:
> > +#
> > +
> > +
> > +export RE_LINE_RECORD1="^\[\s+perf\s+record:\s+Woken up $RE_NUMBER times? to write data\s+\].*$"
> > +# The first line of perf-record "OK" output
> > +# Examples:
> > +#    [ perf record: Woken up 1 times to write data ]
> > +
> > +
> > +export RE_LINE_RECORD2="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\.data(?:\.\d+)?\s*\(~?$RE_NUMBER samples\)\s+\].*$"
> > +# The second line of perf-record "OK" output
> > +# Examples:
> > +#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB perf.data (~109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB ./perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB ./perf.data.3 (109 samples) ]
> > +
> > +
> > +export RE_LINE_RECORD2_TOLERANT="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\.data(?:\.\d+)?\s*(?:\(~?$RE_NUMBER samples\))?\s+\].*$"
> > +# The second line of perf-record "OK" output, even no samples is OK here
> > +# Examples:
> > +#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB perf.data (~109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB ./perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB ./perf.data.3 (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB perf.data ]
> > +
> > +
> > +export RE_LINE_RECORD2_TOLERANT_FILENAME="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\w*\.data(?:\.\d+)?\s*\(~?$RE_NUMBER samples\)\s+\].*$"
> > +# The second line of perf-record "OK" output
> > +# Examples:
> > +#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB perf_ls.data (~109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB perf_aNyCaSe.data (109 samples) ]
> > +#    [ perf record: Captured and wrote 0.405 MB ./perfdata.data.3 (109 samples) ]
> > +#!    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/my_own.data (109 samples) ]
> > +#!    [ perf record: Captured and wrote 0.405 MB ./UPPERCASE.data (109 samples) ]
> > +#!    [ perf record: Captured and wrote 0.405 MB ./aNyKiNDoF.data.3 (109 samples) ]
> > +#!    [ perf record: Captured and wrote 0.405 MB perf.data ]
> > +
> > +
> > +export RE_LINE_TRACE_FULL="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*$RE_PROCESS_PID\s+.*\)\s+=\s+\-?$RE_NUMBER|$RE_NUMBER_HEX.*$"
> > +# A line of perf-trace output
> > +# Examples:
> > +#    0.115 ( 0.005 ms): sleep/4102 open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) = 3
> > +#    0.157 ( 0.005 ms): sleep/4102 mmap(len: 3932736, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f89d0605000
> > +
> > +export RE_LINE_TRACE_ONE_PROC="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*\w+\(.*\)\s+=\s+(?:\-?$RE_NUMBER)|(?:0x$RE_NUMBER_HEX).*$"
> > +# A line of perf-trace output
> > +# Examples:
> > +#    0.115 ( 0.005 ms): open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) = 3
> > +#    0.157 ( 0.005 ms): mmap(len: 3932736, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f89d0605000
> > +
> > +export RE_LINE_TRACE_CONTINUED="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*\.\.\.\s*\[continued\]:\s+\w+\(\).*\s+=\s+(?:\-?$RE_NUMBER)|(?:0x$RE_NUMBER_HEX).*$"
> > +# A line of perf-trace output
> > +# Examples:
> > +#    0.000 ( 0.000 ms):  ... [continued]: nanosleep()) = 0
> > +#    0.000 ( 0.000 ms):  ... [continued]: nanosleep()) = 0x00000000
> > +
> > +export RE_LINE_TRACE_SUMMARY_HEADER="\s*syscall\s+calls\s+(?:errors\s+)?total\s+min\s+avg\s+max\s+stddev"
> > +# A header of a perf-trace summary table
> > +# Example:
> > +#    syscall            calls    total       min       avg       max      stddev
> > +#    syscall            calls  errors  total       min       avg       max       stddev
> > +
> > +
> > +export RE_LINE_TRACE_SUMMARY_CONTENT="^\s*\w+\s+(?:$RE_NUMBER\s+){5,6}$RE_NUMBER%"
> > +# A line of a perf-trace summary table
> > +# Example:
> > +#    open                   3     0.017     0.005     0.006     0.007     10.90%
> > +#    openat                 2      0     0.017     0.008     0.009     0.010     12.29%
> > +
> > +
> > +export RE_LINE_REPORT_CONTENT="^\s+$RE_NUMBER%\s+\w+\s+\S+\s+\S+\s+\S+" # FIXME
> > +# A line from typicap perf report --stdio output
> > +# Example:
> > +#     100.00%  sleep    [kernel.vmlinux]  [k] syscall_return_slowpath
> > +
> > +
> > +export RE_TASK="\s+[\w~\/ \.\+:#-]+(?:\[-1(?:\/\d+)?\]|\[\d+(?:\/\d+)?\])"
> > +# A name of a task used for perf sched timehist -s
> > +# Example:
> > +#     sleep[62755]
> > +#     runtest.sh[62762]
> > +#     gmain[705/682]
> > +#     xfsaild/dm-0[495]
> > +#     kworker/u8:1-ev[62714]
> > +#     :-1[-1/62756]
> > +#     :-1[-1]
> > +#     :-1[62756]
> > +
> > +
> > +export RE_SEGFAULT=".*(?:Segmentation\sfault|SIGSEGV|\score\s|dumped|segfault).*"
> > +# Possible variations of the segfault message
> > +# Example:
> > +#     /bin/bash: line 1:    32 Segmentation fault      timeout 15s
> > +#     Segmentation fault (core dumped)
> > +#     Program terminated with signal SIGSEGV
> > +#!     WARNING: 12323431 isn't a 'cpu_core', please use a CPU list in the 'cpu_core' range (0-15)
> > -- 
> > 2.43.0
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo

