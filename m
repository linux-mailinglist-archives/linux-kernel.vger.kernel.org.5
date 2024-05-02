Return-Path: <linux-kernel+bounces-165993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61488B9474
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B7A283FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAF7219F6;
	Thu,  2 May 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaTWrmYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D81CAB3;
	Thu,  2 May 2024 06:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629613; cv=none; b=WE2d3xtcrFENtHV2IyHjNxRhemmTAL+6vkA3S0GeStzRYV3Zq825Kk5H4kaSTju3Eqa9Ej/m9/+6pyxkdcxIECQ9Z7IDY1UivAm6wPb6mU1zNtW7kw/FJqkKGjlN95YpX9w1WWedjGrSfkzDfyz3X3fCl0KgcqS3Pe/pPlD/+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629613; c=relaxed/simple;
	bh=IXs2m0Z9B4ZLED76OzsFAyfEm21c5zbXn+r+RNAH7p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWWAEu99dpStoNu1lLo89CkgWUBs9NxmlKHK6A0UI7xMe0E0NCrkRWnmWn2lLzUgbv23XXys88qddbghmn363eZSMJUDEE8+rubGynziUauJe++IYMqaEFgLqg86jCq6G6q+7ESFRyoi7Uht0CS7vm39ZyG4EZYGzr5SUl/jdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaTWrmYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5A5C116B1;
	Thu,  2 May 2024 06:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629612;
	bh=IXs2m0Z9B4ZLED76OzsFAyfEm21c5zbXn+r+RNAH7p4=;
	h=From:To:Cc:Subject:Date:From;
	b=TaTWrmYaGxWmMYuQ/o0Shf3my25Y+Z57Km/NCDRy+40y/5aJ2As53BrzFid09gzcA
	 G+Jy715v6Kj8vQwsCOPZwmagEwKbDwKO6Thg+Sop8nVlAgqaCPZ4RY4Q5aagncOGVk
	 jegOwfbqVh0Vo/BuR5uM30prW3PKLy5PmlEZKQN6Hf56Hh3hRVBwXyia/wJJNA8Wwm
	 WZNVdz+2D12a/hbTlgeHB7GKAK07R9gTxJNBojfmTSZ1VvB5niizSMeb4sUYYy0MNq
	 PQEAGga5HZOjJ1as5V7Evz+qSRMirY91McjDNQrNoX/KBW5LHCsVfO3vR8owUGBdam
	 8jHEscuHKzE8Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/6] perf annotate-data: Small updates in the data type profiling (v1)
Date: Wed,  1 May 2024 23:00:05 -0700
Message-ID: <20240502060011.1838090-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a mix of bug fixes and optimization in the data type profiling.

Firstly it now caches global variables and looks them up by address later.
This will be good for performance as well as improves the success rates
because some variables are defined in a separate file (compile unit) and
has no info in the call site for some reason.

Also it properly checks instructions that use more than one register for
a memory access like x86 SIB addressing.  And check the type of stack
variables correctly and discard constant values (without type info).

Thanks,
Namhyung


Namhyung Kim (6):
  perf dwarf-aux: Add die_collect_global_vars()
  perf annotate-data: Collect global variables in advance
  perf annotate-data: Handle direct global variable access
  perf annotate-data: Check memory access with two registers
  perf annotate-data: Handle multi regs in find_data_type_block()
  perf annotate-data: Check kind of stack variables

 tools/perf/util/annotate-data.c | 157 ++++++++++++++++++++++++++------
 tools/perf/util/dwarf-aux.c     |  62 +++++++++++++
 tools/perf/util/dwarf-aux.h     |   8 ++
 3 files changed, 197 insertions(+), 30 deletions(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


