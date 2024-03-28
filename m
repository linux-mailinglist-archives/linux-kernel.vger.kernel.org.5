Return-Path: <linux-kernel+bounces-123817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA4890E6D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D454A1F24CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B8535D2;
	Thu, 28 Mar 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzBZ/XQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A01CAA4;
	Thu, 28 Mar 2024 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668011; cv=none; b=cliERQY7hTMWMv2esfvnZ9HJAL73mGVOkv8/OgUxujxhSZqxuihf3eeqK6gyjnaL9ZHCn5apfu8J2myvYrWFZ7j6eCq0oQI26u/s9RNH5HZWYM38OIHGelfxsiD7spAiRT3otaAJ8Zm6mylAqft5TOxgu3o+Eb/1oGLu/0aaspQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668011; c=relaxed/simple;
	bh=JdsS1Ph4X37kZPwaxpWEWGD43JuhTV198Fbqnu88sSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mR2mErAy6MTjDNbbLk8h3xmiorzSDckqR9+NZ9cR3bmowcGr1UnORxhRYntuAqsHk5NoQxBwHdbLMx9rc5KIQeqIeSL3RVe3GRB9FNpqD3fvStjNRJKTHQsgW7wyfoBk/u8jbi0M1pRiPMkY9WlI4O4O35IWAaFp3JbwXn5Yckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzBZ/XQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6846AC433C7;
	Thu, 28 Mar 2024 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711668010;
	bh=JdsS1Ph4X37kZPwaxpWEWGD43JuhTV198Fbqnu88sSw=;
	h=From:To:Cc:Subject:Date:From;
	b=mzBZ/XQgkj/kNnFMUahn5RCa6UYJNuKBI9W/+LWeWNyD2VhZttYaOC4QEC9fUHYoB
	 usU6Lh99zYSSjBl/HucEspgd9sbbyDQtFPK2F16lWJWA+2MS8ylC6Qh0o/MNA0zvwq
	 4ZP5AaEs1I4kt3O+TajgPkkPOP/vfucEJskdtSViu7XI5iez92A54WWuXAo4KcgijD
	 1vSrfaoYEDPATCl9Q3/fe/RA9PuU5+QS62Abrek+SUpvYTFDy6dOWJeeH+iRhoRRiW
	 xi3y6cesVzCiSf4RGHaFQ4lWzoySnnZk41enilMqW5eTgbSB8updgN5QoNAyjAzhlx
	 O6phQNgWHBgNw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Changbin Du <changbin.du@huawei.com>
Subject: [PATCH 0/4] perf annotate: Use libcapstone as a disasssembler
Date: Thu, 28 Mar 2024 16:20:05 -0700
Message-ID: <20240328232009.466018-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

As we've added libcapstone support, it's natural to use it for perf annotate
as well.  This change added the capstone support on x86 first.  Other archs
can be added later (by someone who can verify it doesn't break things).

For now it tries to use capstone (if available) before objdump.  But it
doesn't support source file and line number info.  So users should use the
objdump (by passing --objdump=PATH option) if they need them.  For example,
this command line will keep the existing behavior (i.e. using objdump).

  # not to use capstone for disassembly
  $ perf annotate --objdump=objdump

The capstone uses LLVM objdump style output which is slightly different than
the GNU objdump.  But it should not have differences besides that.  I've
verified the result of data type profiling and it produced the same output
but gave me ~3x speedups.

Thanks,
Namhyung


Cc: Changbin Du <changbin.du@huawei.com>


Namhyung Kim (4):
  perf annotate: Use ins__is_xxx() if possible
  perf annotate: Add and use ins__is_nop()
  perf annotate: Split out util/disasm.c
  perf annotate: Use libcapstone to disassemble

 tools/perf/util/Build      |    1 +
 tools/perf/util/annotate.c | 1711 ++---------------------------------
 tools/perf/util/annotate.h |   59 +-
 tools/perf/util/disasm.c   | 1739 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/disasm.h   |  112 +++
 5 files changed, 1914 insertions(+), 1708 deletions(-)
 create mode 100644 tools/perf/util/disasm.c
 create mode 100644 tools/perf/util/disasm.h

-- 
2.44.0.478.gd926399ef9-goog


