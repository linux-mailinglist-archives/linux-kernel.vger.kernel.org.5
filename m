Return-Path: <linux-kernel+bounces-139713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 346078A06C4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6538D1C21D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C1513BAE7;
	Thu, 11 Apr 2024 03:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkAlxtus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116F13BAD1;
	Thu, 11 Apr 2024 03:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806378; cv=none; b=mpD7q8op3IR5deO30VVH4tIDp3A1PaXlXB9qe4TniH+8hz5pTS/Yuwg73hFhYh0swNrD2ydALXWAKfuwzy67nwboXLSWLjsplOtKrtIlzAQwr02jy52R98VqE+Z6nU8sC47G1nwnCaeC03IJSHCbb/9BqqNrrihFRoLWr25mGGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806378; c=relaxed/simple;
	bh=CHiFbLxairoTiGbx1GSuvG58rkHjFayrKvmJhpk8jPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UyYARM69c0r+Cy23UP1fRJltPCJfOBA0hBYnNIkqcUWOFlto2/e2dN58MJ7HlX2jjuc5eUtRWH9boq349EXWpNoS1bmtRzuVbRS0WhHV7+5CPiOoH99SD5GCS5CVmzS7WjEoxiwefrNkpbUo/NcgT5h0fe1HSP+VgUAs2SuhzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkAlxtus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7F1C433F1;
	Thu, 11 Apr 2024 03:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806377;
	bh=CHiFbLxairoTiGbx1GSuvG58rkHjFayrKvmJhpk8jPo=;
	h=From:To:Cc:Subject:Date:From;
	b=YkAlxtusli66qs6gLp55URIOphPV2pF5UXWeBFTpSqzaTpd+W3B8F/dimLoysV/uN
	 qDl99WYXqCelcSHVvAHwx3aLJigG+a7ayfBRoZFyABiC/gi7a1VCdK2HUBUpfBzLR/
	 hChtfViXoVqX0IAcs9257yYYm+bc/tJGlq/JuAQO/MSIJxrbjFM/CNSOzbld8Mpys3
	 /gtw0LEmiQlVJW7LvmU+MM19Jgh0Z91hsusZk//Dw7Bc08pA+q0oZTsMMuu3CWj2JP
	 qYchvLqpksGoFhz8iP5DhY6JLMYLLVV09zPO151iIIzCACSkU5M4uj64CPk2OsBAhZ
	 EKDAuFAC5ktEA==
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
Subject: [PATCHSET 0/7] perf annotate: Add TUI support for data type profiling (v2)
Date: Wed, 10 Apr 2024 20:32:49 -0700
Message-ID: <20240411033256.2099646-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to support interactive TUI browser for type annotation.

v2 changes:
 * fix build errors when libslang2 or libdw is missing  (Arnaldo)
 * update commit messages with examples  (Arnaldo)
 * skip updating sample histogram for stack canary  (Arnaldo)
 * add Reviewed-by from Ian
 
Like the normal (code) annotation, it should be able to display the data type
annotation.  Now `perf annotate --data-type` will show the result in TUI by
default if it's enabled.  Also `perf report -s type` can show the same output
using a menu item.

It's still in a very early stage and supports the basic functionalities only.
I'll work on more features like in the normal annotation browser later.

The code is also available at 'perf/annotate-data-tui-v2' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (7):
  perf annotate-data: Skip sample histogram for stack canary
  perf annotate: Show progress of sample processing
  perf annotate-data: Add hist_entry__annotate_data_tty()
  perf annotate-data: Add hist_entry__annotate_data_tui()
  perf annotate-data: Support event group display in TUI
  perf report: Add a menu item to annotate data type in TUI
  perf report: Do not collect sample histogram unnecessarily

 tools/perf/builtin-annotate.c          | 149 ++++--------
 tools/perf/builtin-report.c            |   7 +-
 tools/perf/ui/browsers/Build           |   1 +
 tools/perf/ui/browsers/annotate-data.c | 312 +++++++++++++++++++++++++
 tools/perf/ui/browsers/hists.c         |  31 +++
 tools/perf/util/annotate-data.c        | 113 +++++++++
 tools/perf/util/annotate-data.h        |  22 ++
 tools/perf/util/annotate.c             |  12 +-
 8 files changed, 534 insertions(+), 113 deletions(-)
 create mode 100644 tools/perf/ui/browsers/annotate-data.c


base-commit: 9c3e9af74326978ba6f4432bb038e6c80f4f56fd
-- 
2.44.0.478.gd926399ef9-goog


