Return-Path: <linux-kernel+bounces-143206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEA8A35C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD01F228F1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A514F139;
	Fri, 12 Apr 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEuR5gVX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A620148313;
	Fri, 12 Apr 2024 18:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946792; cv=none; b=JJ5SinqxKSo9ZSl6aEy2vP4HiezdfIj4mDGtakqYDgF392TD9UhhNKbEUmlV0lH9qQSGDJKHnu0bCJxesPtqzB7L14Nn9czhVLleAQ4MEwYvbaxQAkXtEk6QIAaWr20lY1IyKIHllC0tUZzydGhdFiPNSOc++rPJDYRCIkSoGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946792; c=relaxed/simple;
	bh=fY814fzcHenJo2QDXcpObQ8TZ74Z0JBV4+BBtdSgHZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iECXm8fj7NZYaPg4HxBZ8WINH2WwNeDBETqrvzP6KSJijCVOghs2OxQUylFJzFSi/gt5U/+iT398kPkAkJjznhqDEyWi/4GK7oGWoAkd2VKLJ28pfg9XU/rqBfdn7K73RqtrrbR1j1XB136WW4pVKq5tsqWompncKUq6lf8aY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEuR5gVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E38FC113CC;
	Fri, 12 Apr 2024 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946791;
	bh=fY814fzcHenJo2QDXcpObQ8TZ74Z0JBV4+BBtdSgHZg=;
	h=From:To:Cc:Subject:Date:From;
	b=LEuR5gVXXl3rh1T4LyyCWCmvuK98AIvyDDhA3m7C+J0uCh97SBVjL9Wm3f1Gw2uWr
	 22dxdT/OZuu0LOhnIesGvimB1MDQlH0WB1YKacDxM2Aity8E1dKac80XOcXfnDivS9
	 lmqMWLBmDUPVIu6oQf0Wk8Mt7euE4XUcXcqs6/orWwL+AsyZW//Gg46/L3AFL/sz1T
	 seUOCWT2bYCdKNUt7J91Vkg7E4YxTdsfryF9JMJIr4AnF4SfBmyuqN/+bJG7xyrMd3
	 yvvn5npq7Xvc/pPYQVIJJsLU63lR9MqXNSpKyjxogyQR9baUQ+EWNePrRjRQB+Dpvc
	 YVQBl2NU55hiA==
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
Subject: [PATCH 0/4] perf annotate-data: A couple of small updates
Date: Fri, 12 Apr 2024 11:33:06 -0700
Message-ID: <20240412183310.2518474-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am working on improving quality of the data type profiling and I
found some issues.  One is when more than one variables are placed at
the same location.  Then it should find the correct one based on the
given info rather than checking the first one and bailing out.  This
one (patch 2) can go to the perf-tools tree.

Another issue is use of the stack pointe register when it's not the
frame base register.  I found a case where rbp is used as the frame
base but rsp is also used to point some stack variables.  And it
confuses itself how to interpret the type of the variable.

I think these are rare cases but it would depends on the code pattern
and compiler behavior.  Anyway I can see a tiny improvement in my data
with this change. :)

Thanks,
Namhyung


Namhyung Kim (4):
  perf annotate-data: Improve debug message with location info
  perf dwarf-aux: Check pointer offset when checking variables
  perf dwarf-aux: Check variable address range properly
  perf annotate-data: Handle RSP if it's not the FB register

 tools/perf/util/annotate-data.c | 126 +++++++++++++++++++++++++-------
 tools/perf/util/dwarf-aux.c     |  35 ++++++---
 2 files changed, 125 insertions(+), 36 deletions(-)


base-commit: 0ffc8fca5c15a70f32c8aff12c566bbd3991bd0a
-- 
2.44.0.683.g7961c838ac-goog


