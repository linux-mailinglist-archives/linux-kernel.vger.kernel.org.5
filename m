Return-Path: <linux-kernel+bounces-91395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE38710EB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6292B1C21F78
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3687C7D090;
	Mon,  4 Mar 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X37Ff001"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C337CF03;
	Mon,  4 Mar 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593697; cv=none; b=onGYz15zMNOKPVvUgpDpzQUUO1l/Xz42oMlemk9MArxWqeGW3TsTs79bf6IBuUnaD3CQDmUrE9aaj8+3rHgadQQANaG1y1xvFplBfyKhUTsALo3QxKsE1stfDjFB/cKRnaahuMdjpBm5UyAdAgCu674PmDq/PozDhDQzFgSR8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593697; c=relaxed/simple;
	bh=/5bbCzf48je/36eQ9gunlgLxqUEMLvbbEKof6Y9DYOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mH447jcvcWALg583QN1s5WMF5Yw+nSzSGXG1w4j8+TwV3AjaIlOoPoaSci3KXQjl8hGto5QCa7GW+lwHtGIfr+Eu4SOqIDTZpHe/uhIWT4gsHWBXujp6Z1Ik0Z+UNtmQ5plGkNmkieK+HwkOrkz7IiXzO+l6Nb04g/3kXJGHcCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X37Ff001; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A2EC433C7;
	Mon,  4 Mar 2024 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709593697;
	bh=/5bbCzf48je/36eQ9gunlgLxqUEMLvbbEKof6Y9DYOY=;
	h=From:To:Cc:Subject:Date:From;
	b=X37Ff001BXrUyw8X1CoYnojBl6XK3FBnPqCXu3fw7lfSNCqmvKZqfZfNPcJ8lVqpA
	 BuD5MvHA4BZmR32+JO4N7HOrr6UIHUBBKCPtn///0mD/SRG+wutw5SW4asxIybmO+6
	 Zs7nTS4PHfP6+62cxyIgyxKrBErRTv35x4B0zaxLSjXeEax5LeO1trZt8YOXjUqK6c
	 jN/fY/19YfI3aavGXwVm22RYMbZ+dcnjrAErxojDj/GZ9T6c0rAjlq7vAFGD4WNCC9
	 wE02J59mDhd1PuDxYzOcXxOabY9dAVqhVhDeyDumh6rJC0VkJROcy0Jfg7KBG3N9oJ
	 sM5mpjjbMQuQA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2 0/4] perf annotate: Improve memory usage for symbol histogram
Date: Mon,  4 Mar 2024 15:08:11 -0800
Message-ID: <20240304230815.1440583-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is another series of memory optimization in perf annotate.

v2 changes:
 * fix a bug when offset is bigger than 16 bits


When perf annotate (or perf report/top with TUI) processes samples, it
needs to save the sample period (overhead) at instruction level.  For
now, it allocates an array to do that for the whole symbol when it
hits any new symbol.  This comes with a lot of waste since samples can
be very few and instructions span to multiple bytes.

For example, when a sample hits symbol 'foo' that has size of 100 and
that's the only sample falls into the symbol.  Then it needs to
allocate a symbol histogram (sym_hist) and the its size would be

  16 (header) + 16 (sym_hist_entry) * 100 (symbol_size) = 1616

But actually it just needs 32 (header + sym_hist_entry) bytes.  Things
get worse if the symbol size is bigger (and it doesn't have many
samples in different places).  Also note that it needs a separate
histogram for each event.

Let's split the sym_hist_entry and have it in a hash table so that it
can allocate only necessary entries.

No functional change intended.

Thanks,
Namhyung


Namhyung Kim (4):
  perf annotate: Add a hashmap for symbol histogram
  perf annotate: Calculate instruction overhead using hashmap
  perf annotate: Remove sym_hist.addr[] array
  perf annotate: Add comments in the data structures

 tools/perf/ui/gtk/annotate.c |  14 ++++-
 tools/perf/util/annotate.c   | 116 ++++++++++++++++++++++-------------
 tools/perf/util/annotate.h   |  86 +++++++++++++++++++++++---
 3 files changed, 159 insertions(+), 57 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


