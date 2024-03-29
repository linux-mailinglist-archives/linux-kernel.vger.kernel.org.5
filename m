Return-Path: <linux-kernel+bounces-125464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68C2892680
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D5D1F229AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7F13CC7A;
	Fri, 29 Mar 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp6T4qQv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4373413C67C;
	Fri, 29 Mar 2024 21:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749494; cv=none; b=FaEFEf4fIueTQhxeaIjHF4bXgrdW/n/3UCIud1n11FQhcHJwWIu+voonobLlL44RcEbfl1edjnbCpVfmgfRwZu6zYAxnGwlMdh3VyZlmkh1mf0bX8saX5SzHcLEan10qBjRZdkS+Kok7uKS5M10UI2fRbwGXWwOrPPkhZydoDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749494; c=relaxed/simple;
	bh=7/9SJAE0PB0hZ2kr9hir4oUxXdgdOk98SElceGoGKmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vp4GBlRT/+bOeSQLEgfPePVT4xdXanGhOzMqbt6CKIt6e2YfkBTaR+ek9pN9QpT8Gk/9NzoJDlkFn/Z/fZuO+53AC3LArrUvxQt5cOoPIREAUb+qqha5Nxk61YFLY36Mb0W2Da/J5Dk+MmRuvubX+GEVwmNajLrI59lHU62L/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp6T4qQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE0C433F1;
	Fri, 29 Mar 2024 21:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749493;
	bh=7/9SJAE0PB0hZ2kr9hir4oUxXdgdOk98SElceGoGKmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hp6T4qQvst5fN/PU/zJ2s/8oDLDa83TrXKYJk7JoKjnggCHEsCnJUTmZ6MVcXoUUk
	 VRu0vXKIdsHvpB35hiCMUsakrVavRNsdg9TbaXgILTYgqTcPhola4qsKeswHTXm7fE
	 DLxCnRW2+Zk+MKylVdlTtfvoXnmFdRIE79KcRAXCPJLIe9SPpFyn1SlfHBgBa/9nGY
	 +KwMTjZfPt2isF+EGDbcSqgL/qcNPzOGSuvYi6X6tylTYE0CaS+Uf+lJdCogd5z8Mh
	 r8f0b+Ew1DQn+qq32PVcVbEwEeULPVzJ+Ur9L3u6zw/0dyxv/nAcp1J99BVcvZssUB
	 ktT7BqKUn3Mgw==
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
Subject: [PATCH v2 0/5] perf annotate: Use libcapstone as a disasssembler
Date: Fri, 29 Mar 2024 14:58:07 -0700
Message-ID: <20240329215812.537846-1-namhyung@kernel.org>
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

* v2 changes
 - Show global symbols in the comment  (Changbin)
 - Update the commit message for split  (Ian) 
 - Add Ian's Tested-by

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


Namhyung Kim (5):
  perf annotate: Use ins__is_xxx() if possible
  perf annotate: Add and use ins__is_nop()
  perf annotate: Split out util/disasm.c
  perf annotate: Use libcapstone to disassemble
  perf annotate: Add symbol name when using capstone

 tools/perf/util/Build      |    1 +
 tools/perf/util/annotate.c | 1711 ++--------------------------------
 tools/perf/util/annotate.h |   59 +-
 tools/perf/util/disasm.c   | 1814 ++++++++++++++++++++++++++++++++++++
 tools/perf/util/disasm.h   |  112 +++
 5 files changed, 1989 insertions(+), 1708 deletions(-)
 create mode 100644 tools/perf/util/disasm.c
 create mode 100644 tools/perf/util/disasm.h

-- 
2.44.0.478.gd926399ef9-goog


