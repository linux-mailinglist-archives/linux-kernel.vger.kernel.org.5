Return-Path: <linux-kernel+bounces-128517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D90895BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5015FB27289
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF77E15B157;
	Tue,  2 Apr 2024 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5Rw7oYe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2132F17582;
	Tue,  2 Apr 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712083545; cv=none; b=dHMEpn/NKomV//1EofR+uPPbCVZNKv9w8NMJZtNbAfJYhjlyT2XxzsemF4qT3fvEHjsGVNpDGNjH1oKFrW/47tf8Gw/lgxg500G7OEp1cH05I6OKPmtBcS+wpbBFBgMkFCRcttD1SIXXOhwBpyBb3pZvkso702/jcYaF2lb9P4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712083545; c=relaxed/simple;
	bh=HOVqg2Er+74+MeO5rrzusHbqWwKSikD0noVEquqbUw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jf5FsJbxkTSOCVMZLN86veYrc81mdKoqLMlCkV/46ytJM771QKHlP5+YOCKtiSfWKU0yveIyHz+BE4jqqO3Ee6bMUXNlTqRCneLeU5bjR+UrA2JxVw8NOqE+HsUt8BSUuj/Ght10xadtmoRSqaZWfFnhOi/GiAEEc5ERVugHNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5Rw7oYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C24C433C7;
	Tue,  2 Apr 2024 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712083544;
	bh=HOVqg2Er+74+MeO5rrzusHbqWwKSikD0noVEquqbUw0=;
	h=From:To:Cc:Subject:Date:From;
	b=U5Rw7oYeehrvzdYKOy9I4OhtE0J+OS7A91mVCv8R5+y6LyKuJBR53Mr+xm4UFuaTu
	 Wq6l+yU83oepmkeOsyjlgZzWVXqScOin+hYP/rZi6UBevq3pSzeg4ICgPpGs5rKk1z
	 o47A7ls168CBvGfUzOTai+KFeAs7/tx1P86j1/ebglkYz+irSk3UZo0KD1QI3PKIrn
	 kuZOtXRBWMSU5GujaO/8qNgg7uO8hf2lE7O37NyzYkPIAUM0cP5Z3kUlIyZ7NKYWBx
	 z6qyml6XXVy7lkPOGN/+pFLV34X0cLbwzhjuCLHQixFQmzcDY1ELv1FyCsqdDypsg7
	 vYUW+d7YnXDAg==
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
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH] perf lock contention: Add a missing NULL check
Date: Tue,  2 Apr 2024 11:45:43 -0700
Message-ID: <20240402184543.898923-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I got a report for a failure in BPF verifier on a recent kernel with
perf lock contention command.  It checks task->sighand->siglock without
checking if sighand is NULL or not.  Let's add one.

  ; if (&curr->sighand->siglock == (void *)lock)
  265: (79) r1 = *(u64 *)(r0 +2624)     ; frame1: R0_w=trusted_ptr_task_struct(off=0,imm=0) R1_w=rcu_ptr_or_null_sighand_struct(off=0,imm=0)
  266: (b7) r2 = 0                      ; frame1: R2_w=0
  267: (0f) r1 += r2
  R1 pointer arithmetic on rcu_ptr_or_null_ prohibited, null-check it first
  processed 164 insns (limit 1000000) max_states_per_insn 1 total_states 15 peak_states 15 mark_read 5
  -- END PROG LOAD LOG --
  libbpf: prog 'contention_end': failed to load: -13
  libbpf: failed to load object 'lock_contention_bpf'
  libbpf: failed to load BPF skeleton 'lock_contention_bpf': -13
  Failed to load lock-contention BPF skeleton
  lock contention BPF setup failed
  lock contention did not detect any lock contention

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index fb54bd38e7d0..4e5914d7eeaa 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -305,7 +305,7 @@ static inline __u32 check_lock_type(__u64 lock, __u32 flags)
 		break;
 	case LCB_F_SPIN:  /* spinlock */
 		curr = bpf_get_current_task_btf();
-		if (&curr->sighand->siglock == (void *)lock)
+		if (curr->sighand && &curr->sighand->siglock == (void *)lock)
 			return LCD_F_SIGHAND_LOCK;
 		break;
 	default:
-- 
2.44.0.478.gd926399ef9-goog


