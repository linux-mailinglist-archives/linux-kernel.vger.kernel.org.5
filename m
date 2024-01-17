Return-Path: <linux-kernel+bounces-28558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C08830018
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CFAD287AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDF98F66;
	Wed, 17 Jan 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iuzmSA6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3B28F45;
	Wed, 17 Jan 2024 06:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472819; cv=none; b=rJGKuJ32y5XdlBhvvpTJMSYx3v2YXf19VMumT1QWQApOFDF9+i8koJNTStQbHjDHqwFPwHXr9cpqTu7t2lHGuf1TuMBOm9zSlhKim3QsVD9AE59uZCFMMerdXH9IZrxO9xk5ZuBcSq+A4YorsNrKapp+Q74QpTUKqcbCiyUfKJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472819; c=relaxed/simple;
	bh=ACrg/7DLGZRD8QgGGTMtaPSKoz1b/3nJA3a7YJt6Lsc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=UBo3gvQg0pas2tiKeSNa2dRiKlaiOVsonv+6ttQQV1wKTToG1+gBjmJ/ZPvJA+vmWh2obwp+G/z8iFAr/d54EK53NkyiUWY2KhKf6qvcWwGt3Fm+Mz2l5pRtYPVP0Pr/sLfQKdgyaI0LDSB6VZfEUOy3UtlAB02J3MSTMx1aJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iuzmSA6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F86C433C7;
	Wed, 17 Jan 2024 06:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472819;
	bh=ACrg/7DLGZRD8QgGGTMtaPSKoz1b/3nJA3a7YJt6Lsc=;
	h=From:To:Cc:Subject:Date:From;
	b=iuzmSA6em8xjjVPSo7lcvYHQ/zHzLwtwpDAMtrYt7FPpSVZxh8eVUqxqgxEdGiJWH
	 nC/7ZxxXvkWAG37gCcuEVsMb3LD5PL82yjh2HGqzbi/iNZbTWA6rjGQl1nV2JWeUZy
	 VM1kX8fFsB+qs5B7R4YUS12Q0hkCYcdKlaSAj2dRBlGrIAjt84+E6cThW8NaAgm3hQ
	 soHF4u83qvfCx9wjU9W3Nstd2i946k+QFHg9ENXS3aTQ6lc/8FFtsZA0VL7KiT5ExH
	 7bXNcgm05WCu2DbU2NqONQFlv0aGXMl72T0LFowq+BU23SuHD7TVIH1nCFgNnc758G
	 vofww3mZHL+/Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
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
Subject: [PATCHSET 0/9] perf tools: More updates on data type profiling (v4)
Date: Tue, 16 Jan 2024 22:26:48 -0800
Message-ID: <20240117062657.985479-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a continuation of the data type profiling series.  Now the basic
part (v3) which uses pointer variables is merged to the perf-tools-next
tree.  And this part is for memory accesses without pointers as well as
small updates to handle some corner cases.  Still mores to come to
complete the original series.

There's no change from the previous version.  For background and usages,
pleaes refer the posting of previous version [1] and a LWN article [2].

Basically most memory accesses happen with pointers, but there are cases
don't use pointers - direct accesses to global and local variables.

Global variables are located in a static memory at a specific address.
So the DWARF location expression for the global vairable would also have
the static address.  And it's common to access them using PC-relative
addressing mode.  Thus it needs a special handling for global variables.

On the other hand, local variables are located in the stack which varies
as program executes.  So the local variables are accessed either by the
(stack) frame pointer or (current) stack pointer.  But sometimes DWARF
location expression uses a frame base address (CFA) to specify location
of local variables.  So it may need to convert or normalize the location
extracted from the instruction to match DWARF expression.

Lastly, there are some cases DWARF location expressions end up having
complex (or not straight-forward) location.  In that case, it cannot
simply match just the first expression with the instruction location.
It'd be safer to reject them.

The code is available at 'perf/data-profile-update-v4' branch in the tree
below.  The full version of the code is in 'perf/data-profile-v4' branch.

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

[1] https://lore.kernel.org/linux-perf-users/20231213001323.718046-1-namhyung@kernel.org/
[2] https://lwn.net/Articles/955709/


Namhyung Kim (9):
  perf annotate-data: Parse 'lock' prefix from llvm-objdump
  perf annotate-data: Handle macro fusion on x86
  perf annotate-data: Handle array style accesses
  perf annotate-data: Add stack operation pseudo type
  perf annotate-data: Handle PC-relative addressing
  perf annotate-data: Support global variables
  perf dwarf-aux: Add die_get_cfa()
  perf annotate-data: Support stack variables
  perf dwarf-aux: Check allowed DWARF Ops

 tools/perf/util/annotate-data.c | 119 ++++++++++++++++----
 tools/perf/util/annotate-data.h |   8 +-
 tools/perf/util/annotate.c      | 153 ++++++++++++++++++++++++--
 tools/perf/util/annotate.h      |  12 +-
 tools/perf/util/dwarf-aux.c     | 187 ++++++++++++++++++++++++++++----
 tools/perf/util/dwarf-aux.h     |  18 +++
 6 files changed, 439 insertions(+), 58 deletions(-)


base-commit: d988c9f511af71a3445b6a4f3a2c67208ff8e480
-- 
2.43.0.381.gb435a96ce8-goog


