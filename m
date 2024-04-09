Return-Path: <linux-kernel+bounces-137725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFB89E666
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B7D1F230C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D311591E1;
	Tue,  9 Apr 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgd+GiKy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38D21EB5C;
	Tue,  9 Apr 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706602; cv=none; b=ETXnFicurpEBkfiFEKbQo1LKgB4Sdh54v1vKn0ZI6d48+2prwfIVpq4qKkBntSfGO3dJhnpB2FSF6kw/VwExhc5SgjwA5CEwXVRnWU7dAKeezhdZU2pl1M5kujbjOrN+5ciM/5D7IRn0QLeMShb2z1Ct5mp739bGH5+eejwmEa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706602; c=relaxed/simple;
	bh=Ui3MOaTZXGUeavlImoYOyo+UW/KdX4KD/cXGTpTDHko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEOvU3ECsU+wp8CDHLIE5b2mWrC21bVG7A+KztFw31Sa2sz6/Vgr7dIUCEOgbRZmlzfikkz6pRa0aarBen5Kr1KICznZrdmZuEKSV0T71aWa68LcvlSuGC5bqw17BJgqWWtgR4G3eIBBo/GlOOdpSIG0SbKBTipFUaJB/dKex8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgd+GiKy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14DE6C433F1;
	Tue,  9 Apr 2024 23:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706601;
	bh=Ui3MOaTZXGUeavlImoYOyo+UW/KdX4KD/cXGTpTDHko=;
	h=From:To:Cc:Subject:Date:From;
	b=tgd+GiKyOdv+V1+HYDZBE+RXsIxSWu2TcHyu1qA3HkipnWb/Cwmfl2jw+ETT7jYIK
	 R/jwAjP89L7xHG40hTyejaQAZ2zFvrFP40NdXfbdpZglIlqyWMO1TuVMS1wagIlP/Y
	 4JoLXq61QsRAUf1Ye76oxafXBwsWa08/L4DVcY0MXfOWSh8gOpyIJN3w5hA9h7gf+g
	 M9XJ4HSOyVhOkcVEOkTUzP/O6mx3kQraIc3OqKUOrt4oUCObnxW3I84a3UOlZZICwU
	 ppOHxrI8+BlVbzkpuKB5ABsTZZ7abCPJN5oOWhk3smXiUxwyNeEnTzt44UGdFv7u0M
	 2t5i65nlu+0cA==
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
Subject: [PATCHSET 0/6] perf annotate: Add TUI support for data type profiling (v1)
Date: Tue,  9 Apr 2024 16:49:54 -0700
Message-ID: <20240409235000.1893969-1-namhyung@kernel.org>
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

Like the normal (code) annotation, it should be able to display the data type
annotation.  Now `perf annotate --data-type` will show the result in TUI by
default if it's enabled.  Also `perf report -s type` can show the same output
using a menu item.

It's still in a very early stage and supports the basic functionalities only.
I'll work on more features like in the normal annotation browser later.

The code is also available at 'perf/annotate-data-tui-v1' branch at

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (6):
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
 tools/perf/util/annotate-data.h        |   6 +
 tools/perf/util/annotate.c             |   7 +
 8 files changed, 515 insertions(+), 111 deletions(-)
 create mode 100644 tools/perf/ui/browsers/annotate-data.c


base-commit: 9c3e9af74326978ba6f4432bb038e6c80f4f56fd
-- 
2.44.0.478.gd926399ef9-goog


