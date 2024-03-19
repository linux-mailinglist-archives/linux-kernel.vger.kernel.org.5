Return-Path: <linux-kernel+bounces-107026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5ECD87F6DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713661F222F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9643245C12;
	Tue, 19 Mar 2024 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XciRp+eJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B773BBE6;
	Tue, 19 Mar 2024 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827477; cv=none; b=IsmfvSwTOHaEInEQBmK+WGUuTRcvA0kIfxHMP/f70q0H+HKA0ZW9gayW3e7T+QcabBYl8/uUCcxmmp4Hr3gj9Y9lgg+tx5kgtOeHQyu8c+zsEyuTzX0HJtRkcKdBLPbdb+JWGtViQ2XsK5A3jmpFAffpghgMQxQwDevAAigCwp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827477; c=relaxed/simple;
	bh=Bwl3wVxI2jAUzS6Vvv2sxEob6eMMWXHwYnXX5VZoPI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B5Bubagoc1C0NBVsokDa/YG5rVvuTvGg4ltwvsvEV+TzuQ8aSw3PsGAoNEChX63F6aTabjbJy27pTK2uoX6c38CBv3yWwMYZz4Z/fxcPb0LfUa+FM/zXj8f0I+8FUs3HIpRgYV3xRAbPjau0y5zEbHyEcSNrfthEydkzaMNP9T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XciRp+eJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70166C433C7;
	Tue, 19 Mar 2024 05:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827477;
	bh=Bwl3wVxI2jAUzS6Vvv2sxEob6eMMWXHwYnXX5VZoPI0=;
	h=From:To:Cc:Subject:Date:From;
	b=XciRp+eJ8D1bYPVelwmFVzS8GxJHG0VaUFmCTc/uegbNKrHV3NbNLzAyuxcou9iPd
	 VDjjf9gBAMMualFdWhQ1W9A7ruY8xsO1jhDilKwQStTsHxMkd8tgDPJcBChcotICMj
	 gwSJ2IqA1WSV4iOQ2QVOxvQm/dKjl80Aw21KV2UY528n+4eIf9Dscusu9NNb97Rac7
	 uVxJrko6WSBgS273xzl+XU7qoAaIPQUOBkNAOmJnf/yN4oq85eqre9hJftrWFE8erq
	 enykkmLokLufo4wwev9yDODieaJ9fTorgDTWdzVGlS5JW0lN8xpo5QjvAsEe+DLuv4
	 gBB+5+eu/WvIg==
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
Subject: [PATCHSET 00/23] Remaining bits of data type profiling (v7)
Date: Mon, 18 Mar 2024 22:50:52 -0700
Message-ID: <20240319055115.4063940-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hello,

This is the last part of the data type profiling series.
So far we added the basic pointer variable support, and direct access to
global/local variables.  Now it's time to add instruction tracking. :)

For the history and background, you can refer to the previous version
[1] and the LWN article [2].

 * Changes from v6
  - add a new debug option for data type profiling
  - fix return value look up for function calls
  - handle general per-cpu access (by tracking ADD instructions)
  - add cache for global variables
  - fail insn tracking early when no further info is expected
  - and more small bug fixes

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

The code is available at 'perf/data-profile-v7' branch in the tree
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


Namhyung Kim (23):
  perf dwarf-aux: Remove unused pc argument
  perf dwarf-aux: Add die_collect_vars()
  perf dwarf-aux: Handle type transfer for memory access
  perf dwarf-aux: Add die_find_func_rettype()
  perf map: Add map__objdump_2rip()
  perf annotate-data: Introduce struct data_loc_info
  perf annotate: Add annotate_get_basic_blocks()
  perf annotate-data: Add debug messages
  perf annotate-data: Maintain variable type info
  perf annotate-data: Add update_insn_state()
  perf annotate-data: Add get_global_var_type()
  perf annotate-data: Handle global variable access
  perf annotate-data: Handle call instructions
  perf annotate-data: Implement instruction tracking
  perf annotate-data: Check register state for type
  perf annotate: Parse x86 segment register location
  perf annotate-data: Handle this-cpu variables in kernel
  perf annotate-data: Track instructions with a this-cpu variable
  perf annotate-data: Support general per-cpu access
  perf annotate-data: Handle ADD instructions
  perf annotate-data: Add stack canary type
  perf annotate-data: Add a cache for global variable types
  perf annotate-data: Do not retry for invalid types

 tools/perf/builtin-annotate.c   |    1 +
 tools/perf/util/annotate-data.c | 1320 +++++++++++++++++++++++++++++--
 tools/perf/util/annotate-data.h |   52 +-
 tools/perf/util/annotate.c      |  334 +++++++-
 tools/perf/util/annotate.h      |   31 +
 tools/perf/util/debug.c         |    3 +
 tools/perf/util/debug.h         |    1 +
 tools/perf/util/dso.c           |    2 +
 tools/perf/util/dso.h           |    6 +-
 tools/perf/util/dwarf-aux.c     |  282 ++++++-
 tools/perf/util/dwarf-aux.h     |   33 +-
 tools/perf/util/map.c           |   17 +
 tools/perf/util/map.h           |    3 +
 13 files changed, 1955 insertions(+), 130 deletions(-)


base-commit: 2ebf53c2894623d1ef3bcecf1464dbcc3fe1cb72
-- 
2.44.0.291.gc1ea87d7ee-goog


