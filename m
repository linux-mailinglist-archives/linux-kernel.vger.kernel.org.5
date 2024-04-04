Return-Path: <linux-kernel+bounces-131918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10343898D91
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEDBB260B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7312FB3A;
	Thu,  4 Apr 2024 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eArUhlwy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5BA12F37C;
	Thu,  4 Apr 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253439; cv=none; b=EaHfTLb3wK61WOUQyCUl4ZzhqBRyn4J3bgFL0U4ayx4YyoRjmOL0IniX94+WgzgKMeKniOeJo2WfZEXvN5kJWzbNdSUdxkTrqbqG1dyC3Z6hQkccK3983gOJziYD6tAf7vH0QgEWTci1guhTlpXM0lP3PkLfLyrsu/nyG358qzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253439; c=relaxed/simple;
	bh=d2PCxk9Zsf2Hnfy5fE4WxVlTuBZciJqW8hx+PjbLWxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xn185ofCuomZ5fq85zBw4TehQZxRVb1gWWYN3p63KQya3Ws7eF+4K1Kv4Uf/TsT+8fQyi3mHWIypFSFK1Qb+3TrT5hr4n3ZL4ZfVtj+2S4fqZIpqxmo/feG7ogQ40ZZ8/weCHaNIXbKR0FXoxPFcu9Bn6OKneYDWXK7Qt0620g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eArUhlwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C91DC433C7;
	Thu,  4 Apr 2024 17:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253438;
	bh=d2PCxk9Zsf2Hnfy5fE4WxVlTuBZciJqW8hx+PjbLWxc=;
	h=From:To:Cc:Subject:Date:From;
	b=eArUhlwyoItIceyua56BQPR1OiS4rkbM8z7Qg+QiOHgXmiQkl2OtuXQ+t75/9a+P0
	 mrad/r6ijhZXXP4hpooENDm+i9DMv9FuGd7fprogSixFa56mFXE6D9eRXkaFPvYo6V
	 +m4QCKhF8kgLcFxtceU0aMA9YqgmuzdvUU6SRR/QSmzqZQzb7/rIF+Nzj4IpNSuwdO
	 Z4+3cqMjE8FOG7a3nc6Aco9xqLVKolwQdkBeEdfXH+wLHPDueBypvEmXYe2i+29XbW
	 QumJDjxF2ki8lOmJw0/bU8COaZ7YlxzinT3jrivyoTsadgOUH9KgyLTFJhn7f4ZxX3
	 urAzYuY6ImrBA==
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
Subject: [PATCHSET 0/9] perf annotate: More memory footprint reduction
Date: Thu,  4 Apr 2024 10:57:07 -0700
Message-ID: <20240404175716.1225482-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This work is continuation of the previous work to reduce the memory
usage in symbol and annotation structures.  Basically I moved some
fields in the annotation which consume spaces in the struct symbol
which is allocated regardless if the symbol has a sample or not when
annotation is enabled.

With this change applied, the struct annotation only has two members -
annotated_source and annotated_branch.  The next step would be to
remove the struct annotation and to have a hash table from symbol to
each annotated struct directly.

No function changes intended.

The code is available at perf/annotate-diet-v3 branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (9):
  perf annotate: Fix annotation_calc_lines()
  perf annotate: Staticize some local functions
  perf annotate: Introduce annotated_source__get_line()
  perf annotate: Check annotation lines more efficiently
  perf annotate: Get rid of offsets array
  perf annotate: Move widths struct to annotated_source
  perf annotate: Move max_jump_sources struct to annotated_source
  perf annotate: Move nr_events struct to annotated_source
  perf annotate: Move start field struct to annotated_source

 tools/perf/ui/browsers/annotate.c |  15 ++-
 tools/perf/util/annotate.c        | 174 +++++++++++++++++-------------
 tools/perf/util/annotate.h        |  39 +++----
 3 files changed, 123 insertions(+), 105 deletions(-)


base-commit: b6347cb5e04e9c1d17342ab46e2ace2d448de727
-- 
2.44.0.478.gd926399ef9-goog


