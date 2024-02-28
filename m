Return-Path: <linux-kernel+bounces-84286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0965C86A492
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B3211C21269
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B691FB5;
	Wed, 28 Feb 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBZYTBSY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C85A34;
	Wed, 28 Feb 2024 00:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081552; cv=none; b=NfrSkkOdctOY7yKxlWnpIbtXhKsptS7xinRSBNF5J4eJe9vibF31kxW+B0QgH8VALSf0NREX3eSTznOVRvMRu706SePT3Mc0VxP4bZLqGxJ2UNhZEJICdghYoXxDAwPMqdZn8b4QCqEarzk6IYeM5mDWC6Sc1vzvfnqJ1f4yqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081552; c=relaxed/simple;
	bh=Pf04X6SV6XUlQWu1+HzF9j9trt7MUo1jU/RSKN5kwes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkrTKNnsBt71HmEJBIpZec9hhmvwroAYNJvvLJ43MmQoGNkqPcZiQ97L8ttbEer0mPCd+hCS3nUslFKYH/O3/m4LaGRT3ox0HiYg/qqX6xox2yu0beWKb2pThS+1jrqPh6+AOBmXanTjkaPaXS9+JqrEFlxMsmFTFmiVnOYzMpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBZYTBSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90394C433F1;
	Wed, 28 Feb 2024 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709081551;
	bh=Pf04X6SV6XUlQWu1+HzF9j9trt7MUo1jU/RSKN5kwes=;
	h=From:To:Cc:Subject:Date:From;
	b=pBZYTBSYsSsFTPfDvsBGpMOVpCgniu+PwtBRwJqD+aP+ESBTeZAdxvn2h0QG0+0k5
	 aoQhKj+hq+wVVkHajIRys6Zc/luHWr73ZMoY2cPCBMkSvRSiNeHB71Z6McWYm0FN5g
	 g7E3THuYdsKu5Hcpb1jSmbdq/81kvzPRIwGlLW05kuqr1tM0Z/c6SDp5Z3KTCZCVHr
	 e/b0E9Hs1IT25EF1Jo1oi33g+VLvSE4HmxrdGnW4mxS+yR8NE/8Qizt4WC5whonSay
	 xjPnHZZaW4m0/AogNqq7P6QUOj3JNMDPmM+E/an2EBWdh0sDN+GJDf2mp5/JJPMhjX
	 ffT5ZjRd1rGbQ==
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
Subject: [PATCH 0/4] perf annotate: Improve memory usage for symbol histogram
Date: Tue, 27 Feb 2024 16:52:26 -0800
Message-ID: <20240228005230.287113-1-namhyung@kernel.org>
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
samples in different places).  Also note that it needs separate
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
 tools/perf/util/annotate.c   | 114 ++++++++++++++++++++++-------------
 tools/perf/util/annotate.h   |  86 +++++++++++++++++++++++---
 3 files changed, 158 insertions(+), 56 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


