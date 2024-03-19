Return-Path: <linux-kernel+bounces-107027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D887F6E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025BC1F2237A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72D4EB5D;
	Tue, 19 Mar 2024 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZG40xFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA545959;
	Tue, 19 Mar 2024 05:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827478; cv=none; b=GW6h9WnbaLcS4YdfB7nI91GzUh+EadLIAHWH/bEKJq8UY9nbJVZ9yB+1aNLo6APupC64njs+ogAij3sSM56LwukcLPNdLNx3SRYnoEwVm258a37amMCy1xmIXcY/X29kAggdGVbP5ZJ++ucU5ITe+ziD45Uu0i/jAPuLHkQsKVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827478; c=relaxed/simple;
	bh=C7LYq6JKaTAwOM2QkVdpQCMOhtyFYmI4+gd4jRMnB14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8eZHGBZ4xTPGdHZgCG7B2DjqWvevpbpfUkynBrgy6blTDyFQ5guKjDXRWJjkDuFAL3kMnjYIhTZ962zzYy1VBGFB+bRf7Jso2EIpO6bKMbXF9KSmvaNLJdo/+Ecr6pideWhwEIj9RodEhh4qnxmrP83qgvHpYL3ApavyvTeMFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZG40xFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBF4C43399;
	Tue, 19 Mar 2024 05:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827477;
	bh=C7LYq6JKaTAwOM2QkVdpQCMOhtyFYmI4+gd4jRMnB14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kZG40xFbs4VlIycftOn8idSvy3zl45dTcJFgZ+zEzTQEgl+Yen29pc4FIL5vjJcey
	 t+bpNsMA4c1OOFtaPpuCgw3JBJPV24uxtqm3hr/12SPDwbXugGtwpeh9NKoW9ddEg3
	 7QykcT7S+LNHElvYu+94VHXVmyrCUT8cqAALrpx5XdMCU60pAniQhUEsfA4eDp7Bg4
	 WQMLo2QpAu1BqrETgUu/BVTErMTJ/e3lmSW+9k2O889WvfOsfDY4ELGHNtzV8cyjz8
	 qinra53kU8Xkdck+XXYDlPvUJFiPodhNEGnc6uOfcUXksUv+M6wUhebvzm6/rQ3LQF
	 qtY+US9jSCxoQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 01/23] perf dwarf-aux: Remove unused pc argument
Date: Mon, 18 Mar 2024 22:50:53 -0700
Message-ID: <20240319055115.4063940-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not used, let's get rid of it.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 4 ++--
 tools/perf/util/dwarf-aux.c     | 7 ++-----
 tools/perf/util/dwarf-aux.h     | 6 ++----
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 30c4d19fcf11..59ce5f4f4a40 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -263,7 +263,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	offset = loc->offset;
 
 	if (reg == DWARF_REG_PC) {
-		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+		if (die_find_variable_by_addr(&cu_die, addr, &var_die, &offset)) {
 			ret = check_variable(&var_die, type_die, offset,
 					     /*is_pointer=*/false);
 			loc->offset = offset;
@@ -312,7 +312,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		if (reg == DWARF_REG_PC) {
-			if (!die_find_variable_by_addr(&scopes[i], pc, addr,
+			if (!die_find_variable_by_addr(&scopes[i], addr,
 						       &var_die, &offset))
 				continue;
 		} else {
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 2791126069b4..e84d0d6a7750 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1456,7 +1456,6 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 /**
  * die_find_variable_by_addr - Find variable located at given address
  * @sc_die: a scope DIE
- * @pc: the program address to find
  * @addr: the data address to find
  * @die_mem: a buffer to save the resulting DIE
  * @offset: the offset in the resulting type
@@ -1464,12 +1463,10 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
  * Find the variable DIE located at the given address (in PC-relative mode).
  * This is usually for global variables.
  */
-Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
-				     Dwarf_Addr addr, Dwarf_Die *die_mem,
-				     int *offset)
+Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
+				     Dwarf_Die *die_mem, int *offset)
 {
 	struct find_var_data data = {
-		.pc = pc,
 		.addr = addr,
 	};
 	Dwarf_Die *result;
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 85dd527ae1f7..9973801a20c1 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -146,9 +146,8 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 				    Dwarf_Die *die_mem);
 
 /* Find a (global) variable located in the 'addr' */
-Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
-				     Dwarf_Addr addr, Dwarf_Die *die_mem,
-				     int *offset);
+Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr addr,
+				     Dwarf_Die *die_mem, int *offset);
 
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
@@ -170,7 +169,6 @@ static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unus
 }
 
 static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
-						   Dwarf_Addr pc __maybe_unused,
 						   Dwarf_Addr addr __maybe_unused,
 						   Dwarf_Die *die_mem __maybe_unused,
 						   int *offset __maybe_unused)
-- 
2.44.0.291.gc1ea87d7ee-goog


