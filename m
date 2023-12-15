Return-Path: <linux-kernel+bounces-831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C48146CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF11F2321F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A752250E6;
	Fri, 15 Dec 2023 11:24:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47C24B39
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4849C15;
	Fri, 15 Dec 2023 03:25:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A98DD3F738;
	Fri, 15 Dec 2023 03:24:54 -0800 (PST)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: lucas.demarchi@intel.com,
	mark.rutland@arm.com,
	pengfei.xu@intel.com
Subject: [PATCH] perf: Fix perf_event_validate_size() lockdep splat
Date: Fri, 15 Dec 2023 11:24:50 +0000
Message-Id: <20231215112450.3972309-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When lockdep is enabled, the for_each_sibling_event(sibling, event)
macro checks that event->ctx->mutex is held. When creating a new group
leader event, we call perf_event_validate_size() on a partially
initialized event where event->ctx is NULL, and so when
for_each_sibling_event() attempts to check event->ctx->mutex, we get a
splat, as reported by Lucas De Marchi:

  WARNING: CPU: 8 PID: 1471 at kernel/events/core.c:1950 __do_sys_perf_event_open+0xf37/0x1080

This only happens for a new event which is its own group_leader, and in
this case there cannot be any sibling events. Thus it's safe to skip the
check for siblings, which avoids having to make invasive and ugly
changes to for_each_sibling_event().

Avoid the splat by bailing out early when the new event is its own
group_leader.

Fixes: 382c27f4ed28f803 ("perf: Fix perf_event_validate_size()")
Reported-by: Lucas De Marchi <lucas.demarchi@intel.com>
Closes: https://lore.kernel.org/lkml/20231214000620.3081018-1-lucas.demarchi@intel.com/
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Closes: https://lore.kernel.org/lkml/ZXpm6gQ%2Fd59jGsuW@xpf.sh.intel.com/
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

Hi Ingo, Boris, Peter,

I'm not sure who's still around and who has disappeared for the
holidays, but I'm hoping at least one of you is able to queue this. I've
tested the patch on arm64 with Syzkaller (and syz-repro); before this
patch it hits the splat near-instantly, and after this patch all seems
well.

The broken commit was merged in v6.7-rc5 via:

  https://lore.kernel.org/lkml/20231210105949.GAZXWaJe6DeHU9+ofl@fat_crate.local/

... in merge commit:

  537ccb5d28d6f398 ("Merge tag 'perf_urgent_for_v6.7_rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")

Mark.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index c9d123e13b579..9efd0d7775e7c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1947,6 +1947,16 @@ static bool perf_event_validate_size(struct perf_event *event)
 				   group_leader->nr_siblings + 1) > 16*1024)
 		return false;
 
+	/*
+	 * When creating a new group leader, group_leader->ctx is initialized
+	 * after the size has been validated, but we cannot safely use
+	 * for_each_sibling_event() until group_leader->ctx is set. A new group
+	 * leader cannot have any siblings yet, so we can safely skip checking
+	 * the non-existent siblings.
+	 */
+	if (event == group_leader)
+		return true;
+
 	for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)
-- 
2.30.2


