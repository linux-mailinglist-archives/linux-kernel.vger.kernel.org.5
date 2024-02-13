Return-Path: <linux-kernel+bounces-63061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D8852A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214E31C21964
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974E9182A1;
	Tue, 13 Feb 2024 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVYTRJWx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3517743;
	Tue, 13 Feb 2024 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707810777; cv=none; b=AFwlRdzvSQusN085zPT+mBkh9z/CTvhytyxNPXUTwX0xDZiJEFrO4QAR62IjhWugwknUwGHOyhrcwn4HMfuIJ6uqHU/V1qdGez2wozUYb1T4IupR8tVyRLCzqck178VVxevpRaeCmKa1OT7bDcjZTlVzwJ/s5YUZXoli3uJzqck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707810777; c=relaxed/simple;
	bh=RAMSiO9LDsSEGaCX0VfpRG5twBN521Gc1CP60zBfNjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1YBMR2ycjwFZMXa26idFR4Q3kHflxssskHajqXikKtcyNYrgLR02Dxdpz13aacdCXl2357TsfbSoYFNC/L0yAWPn0JVG6Nk0hUS19gt8vjJ0VMtgOygS5bX/LG2287udx9BXoHD0NuMlyFnC+GzxBPtXqSWwNce0OqciQoDQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVYTRJWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA3FC433F1;
	Tue, 13 Feb 2024 07:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707810777;
	bh=RAMSiO9LDsSEGaCX0VfpRG5twBN521Gc1CP60zBfNjM=;
	h=From:To:Cc:Subject:Date:From;
	b=rVYTRJWxch4D6YJ6sy/5Q5z5Cfn84zgis4PxTRcNmSOMUKdd+CrgaCQqpgWkf7MvO
	 PoLnU2fBZCZeQUXB29GfakR1M1Xdf+VG9hf6OiZzZNUI6q4/HVV95b4KsHRAJRr1XM
	 BZ52S9728iPK6ie7ZdJKJlWpCjiPcvU4KTtDsJgnirhJR9zFCsmvmgA1WMyym5Crq6
	 ljLAXFs2m8/UvNWbYycjeppBLyNQ9ei5b3bfMNjPZ6Mm8JtSAFqyHb6+Ka2f3azXe0
	 7EEugxs3fU3Q/+qJVnklrhjVocRs/yQQLrl3cyAABJV/t/s40sbaXV/LCb+04xkSIW
	 FapA8tqtv8vYQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/4] perf report: Omit dummy events in the output (v1)
Date: Mon, 12 Feb 2024 23:52:52 -0800
Message-ID: <20240213075256.1983638-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This work is to make the output compact by removing dummy events in
the evlist.  The dummy events are used to save side-band information
like task creation or memory address space change using mmap(2).  But
after collecting these, it's not used because it won't have any
samples.

Sometimes users want to run perf report --group to show all recorded
events together but they are not interested in those dummy events.
This just wastes the precious screen space so we want to get rid of
them after use.

perf report already has --skip-empty option to skip 0 result in the
stat output.  I think we can extend it to skip empty events that have
no samples.

Example output:

Before)
  #
  # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P, dummy:u'
  # Event count (approx.): 3089861
  #
  #                 Overhead  Command      Shared Object      Symbol                               
  # ........................  ...........  .................  .....................................
  #
       9.29%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
       5.26%   0.15%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
       4.15%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
       3.87%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
       3.79%   0.17%   0.00%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
       3.63%   0.00%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
       2.86%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       2.78%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
       2.34%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
       2.32%   0.97%   0.00%  swapper      [kernel.kallsyms]  [k] psi_group_change

After)
  #
  # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P'
  # Event count (approx.): 3089861
  #
  #         Overhead  Command      Shared Object      Symbol                               
  # ................  ...........  .................  .....................................
  #
       9.29%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
       5.26%   0.15%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
       4.15%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
       3.87%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
       3.79%   0.17%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
       3.63%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
       2.86%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       2.78%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
       2.34%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
       2.32%   0.97%  swapper      [kernel.kallsyms]  [k] psi_group_change

Now 'Overhead' column only has two values for mem-loads and mem-stores.

Thanks,
Namhyung


Namhyung Kim (4):
  libperf evlist: Update group info in perf_evlist__remove()
  perf hist: Simplify hist printing logic for group events
  perf hist: Do not use event index in hpp__fmt()
  perf report: Do not show dummy events with --skip-empty

 tools/lib/perf/evlist.c                  | 21 +++++++
 tools/perf/Documentation/perf-report.txt |  3 +-
 tools/perf/builtin-report.c              | 14 ++++-
 tools/perf/ui/hist.c                     | 77 +++++++++++++-----------
 4 files changed, 79 insertions(+), 36 deletions(-)

-- 
2.43.0.687.g38aa6559b0-goog


