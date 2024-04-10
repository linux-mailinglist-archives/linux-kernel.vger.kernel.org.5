Return-Path: <linux-kernel+bounces-138012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE41A89EB16
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10F01C21042
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23D36137;
	Wed, 10 Apr 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wv6MdDm3"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8753282F0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731345; cv=none; b=ARkL5LO0SIqjMPuqPM5YliedkS9lLDzhy8sqXafuupHi3OCAi9uOrTONB0OoMlUK5ydLQIhAaGa/f0V6JrDh3R6l/Ks4zdyin0PxBRD4axEYpvgDNDBnUIMFSU5Gn1WAMLLwUP+My9v17UAtQWTyDJ8S2X3KP+JNkl14x/osdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731345; c=relaxed/simple;
	bh=WR4U2+IgQKOHVW76MTANWwHhOHoeGdsnUej/bUOxOGQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=mPB7vD3YfDvaZIlPcZy60g227Mpr7Pgty2fTD0pHU3v7cfUam/hi0RFwbe/rlzY01meKi4nfERhX5t9AfZwORiSJeFnGHTRqT7Pnpy9lhyGGQoMBQWO/3W/+Vqe5tdrJDTd6b8YgRnR+r0dE2p9g7h8Z3N7sAgyDo32NYw/8PSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wv6MdDm3; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615073c8dfbso124014567b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731341; x=1713336141; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q86w5uI23jus8/CWfQjASonlaMPM3a4X8veinZQZY5Y=;
        b=Wv6MdDm3SIEAAbhKx0f8bCwiYFmzfn6cdVDZkVJcfu9G3XPrXODmiW4xbGOiESgyC9
         +U3V6743juDFTNUHEd380TekbxE5chAvxJp8/qSvBl0vAmZGwfvEB0y/BKOg2GEYA/0h
         ykSDDyLgFL6+lb3MlGKEa/F4+b+/AHhW6Sm4aiOtVub5n6QTUrrH202cb5lXV2hE9mD2
         ltMvrF5ykIyy/ad09FAZB8d5xUVLWlkkxzU7fWyS8hLFkvnE+YDfCTzaiAJaiGrW1q57
         xA+J+9b0QuOdWggV+N0Vs4vLm2TeNBzpcFUGCtPTIlnzxfvxh/6dBSAphjG+ivLu28bT
         1jRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731341; x=1713336141;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q86w5uI23jus8/CWfQjASonlaMPM3a4X8veinZQZY5Y=;
        b=hYz8fxdr8cuNp+p/lBifPkR2KOV7w3SffhJZltn2oBrfnR7DWV12ZHX5cADUS7ZDVT
         XfraLYuhzVhfGnYw7V0ydmhbxXoLjtzoirobiAtw+c/+kXCKcsXaU6emkMJwi/PyAynd
         xVOahcW+jR8lmHllssBlk8AfKXDVUvwSJkM2wUApzse9gP0ik24k4N6DyVW8zaozu1Rz
         B300TrtIMkZrZxh/d51nv/a4iG399/XdbVwFT9OyYr1JinMYTbjlP7lHHGMWTn4TTBt+
         irmhwOCaJSMMAYXMmfPfzq52Nn0BXbFFjWpTj257VwZNdTohjVKEv3C8HpEKUqSrS6a4
         R9gA==
X-Forwarded-Encrypted: i=1; AJvYcCWN2+bCoiYpbIIFSvw0ayd5eSa5o/lqO/yv4nsb9hmL6eLHydeAWqQZ67YKu7E+IvMxb5zMpmURW4G3nNATW5lMlSvP6I6vcgWBEUVR
X-Gm-Message-State: AOJu0YwMOWNGTsrXDOUW/s6Fd6H9OHq73IWIHIYKMCVbwkI6ViEiQpx0
	NSnBoKEujVcOg/nKuFnx+Al4aGJ0K9zWJt+SEKpc2tFoLeAxvPHFoL1h1Xipddg7JHFzBvlGQDp
	5QfXYPw==
X-Google-Smtp-Source: AGHT+IFGcYAFv+Xc7SS3K5nS30WllCx+fJ9sYsJ8doCFfo1LiQA9/DtjLe/aybUC2wi/FM0J+04P6J2InV2Z
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a25:15c7:0:b0:dc6:e823:9edb with SMTP id
 190-20020a2515c7000000b00dc6e8239edbmr135855ybv.12.1712731340866; Tue, 09 Apr
 2024 23:42:20 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:02 -0700
Message-Id: <20240410064214.2755936-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 00/12] dso/dsos memory savings and clean up
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

12 more patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
a near half year old adventure in trying to lower perf's dynamic
memory use. Bits like the memory overhead of opendir are on the
sidelines for now, too much fighting over how
distributions/C-libraries present getdents. These changes are more
good old fashioned replace an rb-tree with a sorted array and add
reference count tracking.

The changes migrate dsos code, the collection of dso structs, more
into the dsos.c/dsos.h files. As with maps and threads, this is done
so the internals can be changed - replacing a linked list (for fast
iteration) and an rb-tree (for fast finds) with a lazily sorted
array. The complexity of operations remain roughly the same, although
iterating an array is likely faster than iterating a linked list, the
memory usage is at least reduce by half.

As fixing the memory usage necessitates changing operations like find,
modify these operations so that they increment the reference count to
avoid races like a find in dsos and a remove. Similarly tighten up
lock usage so that operations working on dsos state hold the
appropriate lock.

Here are some questions (with answers) that I am expecting from reviewers:

 - Why not refactor dso with accessors first and then do the other things?

My ambition with this change was to lower memory overhead not to
particularly clean up and fix dso. Fixing the memory overhead, by
refactoring and changing the internals, showed that locking discipline
and reference counting discipline was lacking. The later changes try
to fix these as a service to the community while I am changing the
code and to also ensure that code is correct (more correct than it was
wrt locking and reference counting than before the patches).

Reordering the patches to do the refactoring first will be a giant
pain. It will merge conflict with every other patch in the series and
is basically a request to reimplement everything from square 1. The
only thing I'd have in my favor would be how the code should look at
the end of the series, and reordering patches doesn't change the
eventual outcome of applying the patches. Note also, were I to send
the memory saving patches and then a week later send the API clean up
and reference counting fix patches the patches would be merged in the
order they are here. I've done my best, I know you may consider that
I'm adding to your reviewing overhead but I've also got to think about
the overhead to me.

 - Please break apart this change...

The first changes are moving things, but when a broken API is spotted
like the missing get on dsos__find I put it in a change to move the
function and to add the missed get. Could this be two changes? Yes, it
could. Does moving code materially change the behavior of the tool?
No. I've done it in one patch to minimize churn and to some extent for
my sanity. Such changes are less than 100 lines of code and all
independently tested.

 - The logic in dso around short, long name and id with sorting is weird

Yes, I've tried to make it less weird while retaining the existing
behavior. It would be easy to make a series of patches just cleaning
it up but I came here to save memory not change the dso API.

 - Move the fixes in the 12th patch earlier.

This is possible but then impossible to test with reference count
checking. This does mean there are broken reference counts before the
patch is applied, but this is generally already the case. Yes, some
hypothetical person may decide to fork midway through this patch
series and my order would mean they wouldn't have a fix. I've done my
best while working within the bounds of my time and trying to avoid
churn.

v3. Rebases and drops merged "perf dso: Reorder variables to save
    space in struct dso"

v2. Rebases on top of tmp.perf-tools-next resolving merge conflicts.

Ian Rogers (12):
  perf dsos: Attempt to better abstract dsos internals
  perf dsos: Tidy reference counting and locking
  perf dsos: Add dsos__for_each_dso
  perf dso: Move dso functions out of dsos
  perf dsos: Switch more loops to dsos__for_each_dso
  perf dsos: Switch backing storage to array from rbtree/list
  perf dsos: Remove __dsos__addnew
  perf dsos: Remove __dsos__findnew_link_by_longname_id
  perf dsos: Switch hand code to bsearch
  perf dso: Add reference count checking and accessor functions
  perf dso: Reference counting related fixes
  perf dso: Use container_of to avoid a pointer in dso_data

 tools/perf/builtin-annotate.c                 |   8 +-
 tools/perf/builtin-buildid-cache.c            |   2 +-
 tools/perf/builtin-buildid-list.c             |  18 +-
 tools/perf/builtin-inject.c                   |  96 ++--
 tools/perf/builtin-kallsyms.c                 |   2 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-record.c                   |   2 +-
 tools/perf/builtin-report.c                   |   6 +-
 tools/perf/builtin-script.c                   |   8 +-
 tools/perf/builtin-top.c                      |   4 +-
 tools/perf/builtin-trace.c                    |   2 +-
 tools/perf/tests/code-reading.c               |   8 +-
 tools/perf/tests/dso-data.c                   |  67 ++-
 tools/perf/tests/hists_common.c               |   6 +-
 tools/perf/tests/hists_cumulate.c             |   4 +-
 tools/perf/tests/hists_output.c               |   2 +-
 tools/perf/tests/maps.c                       |   4 +-
 tools/perf/tests/symbols.c                    |   8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   6 +-
 tools/perf/ui/browsers/annotate.c             |   6 +-
 tools/perf/ui/browsers/hists.c                |   8 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/annotate-data.c               |  14 +-
 tools/perf/util/annotate.c                    |  17 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   2 +-
 tools/perf/util/bpf-event.c                   |   8 +-
 tools/perf/util/build-id.c                    | 136 ++---
 tools/perf/util/build-id.h                    |   2 -
 tools/perf/util/callchain.c                   |   2 +-
 tools/perf/util/data-convert-json.c           |   2 +-
 tools/perf/util/db-export.c                   |   6 +-
 tools/perf/util/disasm.c                      |  34 +-
 tools/perf/util/dlfilter.c                    |  12 +-
 tools/perf/util/dso.c                         | 472 ++++++++++------
 tools/perf/util/dso.h                         | 502 +++++++++++++++--
 tools/perf/util/dsos.c                        | 529 +++++++++++-------
 tools/perf/util/dsos.h                        |  40 +-
 tools/perf/util/event.c                       |   8 +-
 tools/perf/util/header.c                      |   8 +-
 tools/perf/util/hist.c                        |   4 +-
 tools/perf/util/intel-pt.c                    |  22 +-
 tools/perf/util/machine.c                     | 192 ++-----
 tools/perf/util/machine.h                     |   2 +
 tools/perf/util/map.c                         |  82 ++-
 tools/perf/util/maps.c                        |  14 +-
 tools/perf/util/print_insn.c                  |   2 +-
 tools/perf/util/probe-event.c                 |  25 +-
 .../util/scripting-engines/trace-event-perl.c |   6 +-
 .../scripting-engines/trace-event-python.c    |  21 +-
 tools/perf/util/session.c                     |  21 +
 tools/perf/util/session.h                     |   2 +
 tools/perf/util/sort.c                        |  19 +-
 tools/perf/util/srcline.c                     |  65 ++-
 tools/perf/util/symbol-elf.c                  | 145 +++--
 tools/perf/util/symbol-minimal.c              |   4 +-
 tools/perf/util/symbol.c                      | 186 +++---
 tools/perf/util/symbol_fprintf.c              |   4 +-
 tools/perf/util/synthetic-events.c            |  24 +-
 tools/perf/util/thread.c                      |   4 +-
 tools/perf/util/unwind-libunwind-local.c      |  18 +-
 tools/perf/util/unwind-libunwind.c            |   2 +-
 tools/perf/util/vdso.c                        |  56 +-
 63 files changed, 1794 insertions(+), 1197 deletions(-)

-- 
2.44.0.478.gd926399ef9-goog


