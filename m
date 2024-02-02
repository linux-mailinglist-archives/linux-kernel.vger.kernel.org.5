Return-Path: <linux-kernel+bounces-49239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D89A8467D2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C55C1C24323
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AE71755E;
	Fri,  2 Feb 2024 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LwF5HFzu"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE51754C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854549; cv=none; b=kw/7uUJ22UmPF7vez6Fz63TWv701SNURU37wyDtulZbHBtp63cy9eD5T83PVjEyZuwlAcXDPCUyPnA9aP62uzvxnJ+5eYzWrUehExnEByceO6thEsq12j7e8wA7kPL41YhszGnvlLg6WTor4vnJn3WOBbMKuIZODdsVvhAZ1N30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854549; c=relaxed/simple;
	bh=OCQzyEernErTiBbOinzinjqKGcvOczIkmmI+fHqcj4M=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=fnuWHSPEF0M/ZCIEmWlAPfnPew26oeSWkb8y/JpFchLlUHXE55qrfV3sGdadKfjMjXH2pF28oK6jeArZX8vEZhpFrYqk24dHi6F3+M6FZpv2Ls92GCwk861pU+QC50b2QYOh8C8l1J5YUAjfnVC9yp7YZq8rrRPPdKFHm4c6fxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LwF5HFzu; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so2151553276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854546; x=1707459346; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ToMQh9MBYwlmTbfVjgqllQD0+5gjP+gk6l8SI0jON1k=;
        b=LwF5HFzuP1u+49UNK//0LwDWo3Kz+5UoDwQ5ByVF42OwYFyszfOtEBwYUuGZeMCKEb
         VkmHG1mbaFfSiKdTkFi9lrjuvDw+ghlk03FpYg5MS8ogGz+61FjiKJ8mdKoomHVq2QI3
         XHTNQtUaq9XooDhfLRe7GKg7/TdHnjAsLUYuhAQzocZSdl4Lqciv7EpdZjDKNw+wgzbJ
         +hKSyVkYOFv2BwUPMrwIr0l1I9FlUrdQ+yBM/9Qh+7h/MJjopJZzrlUFNVdW8IO/9FuO
         xaVAXlwvo7simVD3xrohdQbBgsvdsWVcwhgSCRQDsYK33P6XAUARKs0S+PnzsspzWOJh
         HBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854546; x=1707459346;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToMQh9MBYwlmTbfVjgqllQD0+5gjP+gk6l8SI0jON1k=;
        b=XSW1NHRNY9ZY+vVhcT4l6sDgGi1ZAczNLSpkDYFfOHArX10WTUpQkovs3LQlvezWmg
         9MUcDz9hXpOYbk4z8nlTWTvsOuKE0sw4QPrDm4YvK/AlSFLldXB0N+AHstb8YfbqZpYB
         pQbxNDgTGbZ+UgqPTa9d0At6bZ84nMLeKQ8Thveb20QIe8GdKmzp2qx+9CGhnACdEgou
         Uz2SI03elkUHw/ME4GPqQmUUIAWcXWRKeqzWD+B3oFjaqw6s93cHu/ue4DYj4an7yOC/
         maW6c0K/+vHDIr02///IFtXvmjAb1R8SDOuJikroeTGZ+uqhnPUBHE/UyF/lOgF3EZQV
         96aA==
X-Gm-Message-State: AOJu0Yw4yqIh6ZpVzPwAbj2leiYRZFMjm6I9B/iV9AZRtSJD28sk+Swv
	Er8rs2+j4jxB8FCSlH9xSDEfahxZovdT8s3JwWu9WUYxEVF5v7OCSS7BgeWcnx+jQQvKjSHX6C9
	yzNuUzw==
X-Google-Smtp-Source: AGHT+IEGuUtuz4V+hJTjTG5ndRXX1/JkjFWcK4HLGjCODrcsINQMSzqIEv6DOD9ZaJ0v+SXcY224B/wiqwfs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:11ce:b0:dc6:b982:cfa2 with SMTP
 id n14-20020a05690211ce00b00dc6b982cfa2mr156881ybu.8.1706854546285; Thu, 01
 Feb 2024 22:15:46 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:07 -0800
Message-Id: <20240202061532.1939474-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 00/25] maps/threads/dsos memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Modify the implementation of maps to not use an rbtree as the
container for maps, instead use a sorted array. Improve locking and
reference counting issues.

Similar to maps separate out and reimplement threads to use a hashmap
for lower memory consumption and faster look up. The fixes a
regression in memory usage where reference count checking switched to
using non-invasive tree nodes.  Reduce its default size by 32 times
and improve locking discipline. Also, fix regressions where tids had
become unordered to make `perf report --tasks` and
`perf trace --summary` output easier to read.

Better encapsulate the dsos abstraction. Remove the linked list and
rbtree used for faster iteration and log(n) lookup to a sorted array
for similar performance but half the memory usage per dso. Improve
reference counting and locking discipline, adding reference count
checking to dso.

v8:
 - in "perf maps: Switch from rbtree to lazily sorted array for
   addresses" use accessors and remove some duplicative invariant checks as
   requested by Namhyung.

v7:
 - rebase to latest perf-tools-next where 22 patches were applied by Arnaldo.
 - resolve merge conflicts, in particular with fc044c53b99f ("perf
   annotate-data: Add dso->data_types tree") that required more dso
   accessor functions.

v6 series is here:
https://lore.kernel.org/lkml/20231207011722.1220634-1-irogers@google.com/

Ian Rogers (25):
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps
  perf dso: Reorder variables to save space in struct dso
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8
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

 tools/perf/arch/x86/tests/dwarf-unwind.c      |    1 +
 tools/perf/builtin-annotate.c                 |    8 +-
 tools/perf/builtin-buildid-cache.c            |    2 +-
 tools/perf/builtin-buildid-list.c             |   18 +-
 tools/perf/builtin-inject.c                   |   96 +-
 tools/perf/builtin-kallsyms.c                 |    2 +-
 tools/perf/builtin-mem.c                      |    4 +-
 tools/perf/builtin-record.c                   |    2 +-
 tools/perf/builtin-report.c                   |  209 +--
 tools/perf/builtin-script.c                   |    8 +-
 tools/perf/builtin-top.c                      |    4 +-
 tools/perf/builtin-trace.c                    |   43 +-
 tools/perf/tests/code-reading.c               |    8 +-
 tools/perf/tests/dso-data.c                   |   67 +-
 tools/perf/tests/hists_common.c               |    6 +-
 tools/perf/tests/hists_cumulate.c             |    4 +-
 tools/perf/tests/hists_output.c               |    2 +-
 tools/perf/tests/maps.c                       |    7 +-
 tools/perf/tests/symbols.c                    |    2 +-
 tools/perf/tests/thread-maps-share.c          |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c           |   16 +-
 tools/perf/ui/browsers/annotate.c             |    6 +-
 tools/perf/ui/browsers/hists.c                |    8 +-
 tools/perf/ui/browsers/map.c                  |    4 +-
 tools/perf/util/Build                         |    1 +
 tools/perf/util/annotate-data.c               |    6 +-
 tools/perf/util/annotate.c                    |   45 +-
 tools/perf/util/auxtrace.c                    |    2 +-
 tools/perf/util/block-info.c                  |    2 +-
 tools/perf/util/bpf-event.c                   |    9 +-
 tools/perf/util/bpf_lock_contention.c         |    8 +-
 tools/perf/util/build-id.c                    |  136 +-
 tools/perf/util/build-id.h                    |    2 -
 tools/perf/util/callchain.c                   |    4 +-
 tools/perf/util/data-convert-json.c           |    2 +-
 tools/perf/util/db-export.c                   |    6 +-
 tools/perf/util/dlfilter.c                    |   12 +-
 tools/perf/util/dso.c                         |  469 +++---
 tools/perf/util/dso.h                         |  549 ++++++-
 tools/perf/util/dsos.c                        |  529 ++++---
 tools/perf/util/dsos.h                        |   40 +-
 tools/perf/util/event.c                       |   12 +-
 tools/perf/util/header.c                      |    8 +-
 tools/perf/util/hist.c                        |    4 +-
 tools/perf/util/intel-pt.c                    |   22 +-
 tools/perf/util/machine.c                     |  570 +++-----
 tools/perf/util/machine.h                     |   32 +-
 tools/perf/util/map.c                         |   73 +-
 tools/perf/util/maps.c                        | 1298 +++++++++++------
 tools/perf/util/maps.h                        |   65 +-
 tools/perf/util/probe-event.c                 |   26 +-
 tools/perf/util/rb_resort.h                   |    5 -
 .../util/scripting-engines/trace-event-perl.c |    6 +-
 .../scripting-engines/trace-event-python.c    |   21 +-
 tools/perf/util/session.c                     |   21 +
 tools/perf/util/session.h                     |    2 +
 tools/perf/util/sort.c                        |   19 +-
 tools/perf/util/srcline.c                     |   65 +-
 tools/perf/util/symbol-elf.c                  |  132 +-
 tools/perf/util/symbol.c                      |  217 +--
 tools/perf/util/symbol_fprintf.c              |    4 +-
 tools/perf/util/synthetic-events.c            |   24 +-
 tools/perf/util/thread.c                      |    8 +-
 tools/perf/util/thread.h                      |    6 -
 tools/perf/util/threads.c                     |  186 +++
 tools/perf/util/threads.h                     |   35 +
 tools/perf/util/unwind-libunwind-local.c      |   20 +-
 tools/perf/util/unwind-libunwind.c            |    9 +-
 tools/perf/util/vdso.c                        |   56 +-
 69 files changed, 3143 insertions(+), 2160 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.43.0.594.gd9cf4e227d-goog


