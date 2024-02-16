Return-Path: <linux-kernel+bounces-69493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA872858A54
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 850B8280C96
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF9149016;
	Fri, 16 Feb 2024 23:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIf4KlhW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2F12CD81;
	Fri, 16 Feb 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127665; cv=none; b=Owm5eVAEq6DypLfapMjfFA8+hyR2r5iPW2u9cfrCIsaeBPXKgeIsePv/BmoW6rnkmxLnSuqxJuVhw+CC0CT5xn62/ckWJwED5kuavNRPX/ClbVIvAVsSbH3mr++xrYLFX1pX6Gh7sdW+bvRYERsf9AooaYlWbxmftopiPzyOEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127665; c=relaxed/simple;
	bh=GGQvQ/+WBVLP8ch54nHxUo1wdtqt4gDJvXHKXUqMU3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0LbiAWc9cnLE6mH3WyaPRVQvOoT47K5MMayKJzzFl7TyJ3T3NU8drGiBgipjl6RBc2kl83ZEePLfS4Lo/2TfVQ4M53flapnQX70WlUupoxpuTX3dNgwgIuNJG+o8MrAclcJs06XqbtQ2wLEWdA4aFa9rm8Ez1eg08pd8U9ocIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIf4KlhW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBC5C433F1;
	Fri, 16 Feb 2024 23:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127665;
	bh=GGQvQ/+WBVLP8ch54nHxUo1wdtqt4gDJvXHKXUqMU3g=;
	h=From:To:Cc:Subject:Date:From;
	b=VIf4KlhWG0HmbiDVvq7OxorlyHYzLCq64uHvqGDeiN4S4Emp2K4LOB4fLqNPz3Leu
	 sjAPzNV4gr8JQq2HP03BHsnhXcZ5qvhcHbdktOsCeQAYljEeoszTXMzMIBMdvhnl1f
	 /vhIFSw0ypHgDQXZyKbrhYu2Ig58ml+6hMU1ShH2QtUXdEjUjko2eJvSJvpTKwEsWP
	 nsLBQDrUMDTuiiU7O8/rFOhLBq4Zivwd7K+WrVfJk8RSNcrxegfeflDEoVcIeuEFV+
	 B8oSYGmUJevoi6MP3GiYx6EYMqLarnTgB8xhjAnt1zvib+tiO1uB7y+H78YrSL9Lpr
	 QSGA4oc0lIRhA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org,
	Ben Woodard <woodard@redhat.com>,
	Joe Mario <jmario@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	David Blaikie <blaikie@google.com>,
	Xu Liu <xliuprof@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Mark Wielaard <mark@klomp.org>,
	Jason Merrill <jason@redhat.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	William Huang <williamjhuang@google.com>
Subject: [PATCHSET 00/14] perf tools: Remaining bits of data type profiling (v6)
Date: Fri, 16 Feb 2024 15:54:09 -0800
Message-ID: <20240216235423.2343167-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is the last part of the data type profiling series.
So far we added the basic pointer variable support, and direct access to
global/local variables.  Now it's time to add instruction tracking. :)

For the history and background, you can refer to the previous version
[1] and the LWN article [2].

 * Changes from v5
  - rename register state from scratch to caller_saved
  - change comment in map__objdump_2rip()


Basically it needs to track variable (and its type) assignment to get
a type of memory access at the sampled instruction.  Compilers don't
generate DWARF information for every memory accesses so it cannot find
all the necessary information from DWARF.  Therefore, it follows the
path to the sample in the function, and update type information at
each location when the instruction moves it.

For the DWARF search, it has a list of scope entries (subroutines or
blocks) that covers the sample already.  So it can use the scopes to
find the shortest path to the sample instruction.

Let's say we have this.  It got 5 scopes but couldn't find a matching
variable for the sample.

      +----------------  scope[0] subprogram
      |
      | +--------------  scope[1] lexical_block
      | |
      | | +------------  scope[2] inlined_subroutine
      | | |
      | | | +----------  scope[3] inlined_subroutine
      | | | |
      | | | | +--------  scope[4] lexical_block
      | | | | |
      | | | | |     ***  target instruction
      ...

Then it starts with the closest scope (at index 4), and find the
shortest path from the start of the scope to the target instruction.
Along the way, it updates type information in the scope and see if the
location at the target instruction has the type.  If so, it can
return with the type.

Otherwise, it goes to the scope[3] and find the shortest path from the
start of scope[3] to the start of scope[4].  And then it can combine
the existing shortest path from the scope[4] to the target with the
new path.  Now it can start from the scope[3] with new variables and
types.  It can repeat this algorithm for the outer scopes.

I did it this way because mostly it was able to find a type in the
closest scope.  So it can avoid unnecessary work for outer scopes.

And it added a basic per-cpu variable support for this CPU on x86_64
which uses %gs segment register.  Also it can detect the stack-canary
pattern which is added by compiler to detect stack overflow.

The code is available at 'perf/data-profile-v6' branch in the tree
below.  I've dropped the debug patch at the end in this series but you
can find it in the git branch.

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Cc: Ben Woodard <woodard@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
CC: Kees Cook <keescook@chromium.org>
Cc: David Blaikie <blaikie@google.com>
Cc: Xu Liu <xliuprof@google.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Mark Wielaard <mark@klomp.org>
Cc: Jason Merrill <jason@redhat.com>
Cc: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: William Huang <williamjhuang@google.com>


[1] https://lore.kernel.org/linux-perf-users/20231110000012.3538610-1-namhyung@kernel.org/
[2] https://lwn.net/Articles/955709/


Namhyung Kim (14):
  perf dwarf-aux: Add die_collect_vars()
  perf dwarf-aux: Handle type transfer for memory access
  perf annotate-data: Introduce struct data_loc_info
  perf map: Add map__objdump_2rip()
  perf annotate: Add annotate_get_basic_blocks()
  perf annotate-data: Maintain variable type info
  perf annotate-data: Add update_insn_state()
  perf annotate-data: Handle global variable access
  perf annotate-data: Handle call instructions
  perf annotate-data: Implement instruction tracking
  perf annotate: Parse x86 segment register location
  perf annotate-data: Handle this-cpu variables in kernel
  perf annotate-data: Track instructions with a this-cpu variable
  perf annotate-data: Add stack canary type

 tools/perf/util/annotate-data.c | 710 ++++++++++++++++++++++++++++++--
 tools/perf/util/annotate-data.h |  87 +++-
 tools/perf/util/annotate.c      | 366 ++++++++++++++--
 tools/perf/util/annotate.h      |  38 ++
 tools/perf/util/dwarf-aux.c     | 232 +++++++++--
 tools/perf/util/dwarf-aux.h     |  23 ++
 tools/perf/util/map.c           |  17 +
 tools/perf/util/map.h           |   3 +
 8 files changed, 1370 insertions(+), 106 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


