Return-Path: <linux-kernel+bounces-92351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8129871EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC491C235F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55E85A7AB;
	Tue,  5 Mar 2024 12:20:25 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35B459B5E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641225; cv=none; b=ndF5DLRsSx2vpiTg6f3vazwLwP4YHeGhiSs+YJkDQxkYxrYOjLwvqjhsqzdHWzO5+etWGGDAc0Hj1auo7kvyfq/w9opuWeyg041j/Gp9QB6I5FSjlkKM+b5GWtImuUBvERN68+hzw7Yee1vgZaanNY8FrKduEXSj5zG8a1jTEbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641225; c=relaxed/simple;
	bh=gzqSxF3J4/X2VZKljyICmd3WC2eIxG/K3MMXzIEXafQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjHT9YboLNLkD4hYoO09cKp9iED8byvUaT8ryRPkEb5FCC3MZz1sWoKV/OA1avArpC/zFClt+UHHZxR1ORSgBr6thsEbJ92YP3TiiF/UiAg/hzY5mXT/xgrm0SS0LWAcs1a54/Z51pbSnBlUFyGER2HZACnB0ukIyndqO6LuGQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 425C5t73023911
	for <linux-kernel@vger.kernel.org>; Tue, 5 Mar 2024 20:05:55 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 425C5fPc023278;
	Tue, 5 Mar 2024 20:05:41 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Mar 2024
 20:05:37 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <dylan@andestech.com>, <tim609@andestech.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>
Subject: [PATCH 1/2] perf daemon: Fix the warning about time_t
Date: Tue, 5 Mar 2024 20:05:00 +0800
Message-ID: <20240305120501.1785084-2-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305120501.1785084-1-ben717@andestech.com>
References: <20240305120501.1785084-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 425C5t73023911

In the 32-bit platform, the size of time_t is still 64 bits. Thus, use 
PRIu64 to resolve the format problem.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 tools/perf/builtin-daemon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 83954af36753..0b6ffd51c475 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -23,6 +23,7 @@
 #include <sys/signalfd.h>
 #include <sys/wait.h>
 #include <poll.h>
+#include <inttypes.h>
 #include "builtin.h"
 #include "perf.h"
 #include "debug.h"
@@ -688,7 +689,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* lock */
 			csv_sep, daemon->base, "lock");
 
-		fprintf(out, "%c%lu",
+		fprintf(out, "%c%" PRIu64 "",
 			/* session up time */
 			csv_sep, (curr - daemon->start) / 60);
 
@@ -700,7 +701,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				daemon->base, SESSION_OUTPUT);
 			fprintf(out, "  lock:    %s/lock\n",
 				daemon->base);
-			fprintf(out, "  up:      %lu minutes\n",
+			fprintf(out, "  up:      %" PRIu64 " minutes\n",
 				(curr - daemon->start) / 60);
 		}
 	}
@@ -727,7 +728,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session ack */
 				csv_sep, session->base, SESSION_ACK);
 
-			fprintf(out, "%c%lu",
+			fprintf(out, "%c%" PRIu64 "",
 				/* session up time */
 				csv_sep, (curr - session->start) / 60);
 
@@ -745,7 +746,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base, SESSION_CONTROL);
 			fprintf(out, "  ack:     %s/%s\n",
 				session->base, SESSION_ACK);
-			fprintf(out, "  up:      %lu minutes\n",
+			fprintf(out, "  up:      %" PRIu64 " minutes\n",
 				(curr - session->start) / 60);
 		}
 	}
-- 
2.34.1


