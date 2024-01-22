Return-Path: <linux-kernel+bounces-32933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB383621A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F321C241FF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF1946449;
	Mon, 22 Jan 2024 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="C1E3gLN+"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429D4643B;
	Mon, 22 Jan 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923113; cv=none; b=TaLlfO12iiAQtPUR9PfBJb7lspgbZFKz4lubn2nAYuBdS0dTbtLI5CuzZBDRGzZMOvWPbkG0nj0a2x6R7nZg9clNnwN5cURftPbTQHrukhgTjsU7fJiWrOkbXc85nWWVW6rVbKOU08Xk29MxCuzViBE4BdFZFRgjUkoTt8NAt6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923113; c=relaxed/simple;
	bh=QJRXftv5htaGrRJpvd/RlmMy4vOMeaylsoskctG39LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gX3/GpBvvT80WmIoBcc29aZeTk3JV7KxNvM39od8a/hFHnBaRVLsKXUeVMc7ar4UcHZk/wcx3YLweMLUqiXQX+WqsDKNAQA6B970m3AGIB+ykIxkcpy0WzMkzN7uFu28WtqFO12T0dthjVowa91zWKoFE69mq8Bgxx18xPTl/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=C1E3gLN+; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8FEF940F1DE6;
	Mon, 22 Jan 2024 11:31:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8FEF940F1DE6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1705923107;
	bh=GIiZsYrmgQCjlr/AmrPL2dhePcSW3bDC4ZjkPnqyyw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1E3gLN+RWBe7hsAeyUQlphmiR9c466+8dSVYEblMCzqS096G05/SIHIJ50sdsViT
	 9oj+VIuEvcLmepxPBbJAtSP8QgJ5stFMZ6AMLZLuhusSDjh2DD1JwNZDjFsb4XW3yd
	 DuVI9tm0XSPDosXsRJ384m3RSMUWcLM6VwdOzFts=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH 5.10/5.15 1/1] kprobes: Fix to handle forcibly unoptimized kprobes on freeing_list
Date: Mon, 22 Jan 2024 14:30:31 +0300
Message-Id: <20240122113031.301202-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122113031.301202-1-pchelkin@ispras.ru>
References: <20240122113031.301202-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

commit 4fbd2f83fda0ca44a2ec6421ca3508b355b31858 upstream.

Since forcibly unoptimized kprobes will be put on the freeing_list directly
in the unoptimize_kprobe(), do_unoptimize_kprobes() must continue to check
the freeing_list even if unoptimizing_list is empty.

This bug can happen if a kprobe is put in an instruction which is in the
middle of the jump-replaced instruction sequence of an optprobe, *and* the
optprobe is recently unregistered and queued on unoptimizing_list.
In this case, the optprobe will be unoptimized forcibly (means immediately)
and put it into the freeing_list, expecting the optprobe will be handled in
do_unoptimize_kprobe().
But if there is no other optprobes on the unoptimizing_list, current code
returns from the do_unoptimize_kprobe() soon and does not handle the
optprobe which is on the freeing_list. Then the optprobe will hit the
WARN_ON_ONCE() in the do_free_cleaned_kprobes(), because it is not handled
in the latter loop of the do_unoptimize_kprobe().

To solve this issue, do not return from do_unoptimize_kprobes() immediately
even if unoptimizing_list is empty.

Moreover, this change affects another case. kill_optimized_kprobes() expects
kprobe_optimizer() will just free the optprobe on freeing_list.
So I changed it to just do list_move() to freeing_list if optprobes are on
unoptimizing list. And the do_unoptimize_kprobe() will skip
arch_disarm_kprobe() if the probe on freeing_list has gone flag.

Link: https://lore.kernel.org/all/Y8URdIfVr3pq2X8w@xpf.sh.intel.com/
Link: https://lore.kernel.org/all/167448024501.3253718.13037333683110512967.stgit@devnote3/

Fixes: e4add247789e ("kprobes: Fix optimize_kprobe()/unoptimize_kprobe() cancellation logic")
Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[fp: adjust comment conflict regarding commit 223a76b268c9 ("kprobes: Fix
 coding style issues")]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 kernel/kprobes.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 07d36cee2a80..5d713a7d7e87 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -549,17 +549,15 @@ static void do_unoptimize_kprobes(void)
 	/* See comment in do_optimize_kprobes() */
 	lockdep_assert_cpus_held();
 
-	/* Unoptimization must be done anytime */
-	if (list_empty(&unoptimizing_list))
-		return;
+	if (!list_empty(&unoptimizing_list))
+		arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 
-	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
-	/* Loop free_list for disarming */
+	/* Loop on 'freeing_list' for disarming and removing from kprobe hash list */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-		/* Disarm probes if marked disabled */
-		if (kprobe_disabled(&op->kp))
+		/* Disarm probes if marked disabled and not gone */
+		if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
 			arch_disarm_kprobe(&op->kp);
 		if (kprobe_unused(&op->kp)) {
 			/*
@@ -788,14 +786,13 @@ static void kill_optimized_kprobe(struct kprobe *p)
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 
 	if (kprobe_unused(p)) {
-		/* Enqueue if it is unused */
-		list_add(&op->list, &freeing_list);
 		/*
-		 * Remove unused probes from the hash list. After waiting
-		 * for synchronization, this probe is reclaimed.
-		 * (reclaiming is done by do_free_cleaned_kprobes().)
+		 * Unused kprobe is on unoptimizing or freeing list. We move it
+		 * to freeing_list and let the kprobe_optimizer() remove it from
+		 * the kprobe hash list and free it.
 		 */
-		hlist_del_rcu(&op->kp.hlist);
+		if (optprobe_queued_unopt(op))
+			list_move(&op->list, &freeing_list);
 	}
 
 	/* Don't touch the code, because it is already freed. */
-- 
2.39.2


