Return-Path: <linux-kernel+bounces-102005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA4C87AD83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA1C2829B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5572714C5A7;
	Wed, 13 Mar 2024 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZWMt/64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268E64CDC;
	Wed, 13 Mar 2024 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348218; cv=none; b=UGaMzLDm09AH38fo56a9s0VqhSaK14RHGd6fQxWwrCojOGPd653Sio1gOXdp8IdTY2vUHf1eqbY1nTvrbcmnlhMEyO4msHQ1Lo3zcA9yCD54vI8RWeBm/jPB8sRALxw4ccdXi+GozYIbOtdgt/B3OsK1ykUokB85lxS65s0gJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348218; c=relaxed/simple;
	bh=0rNqNmlVXTX/11HQ0XAMJYZPgzeF+GgYg85DZhweKCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cUGSie4Wy/s7jOObi0pT88uGwNgJD20unuYzemz0Do43bIb0NBHuw174SsJCsveeNfeLnEbpxxSykTy1cUVTLHK+yHJ/o6xeZ4UI3TxxBeo7kaOjeDDLASTKUZJH9+Xz3WjVeHaliQnPF1tdf6EgxD/MqfUI9N+ThQOTp5pAk3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZWMt/64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2138EC43399;
	Wed, 13 Mar 2024 16:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348217;
	bh=0rNqNmlVXTX/11HQ0XAMJYZPgzeF+GgYg85DZhweKCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZWMt/6437nPh+VHuEI38fkI24S/Fv9GizfeL1EbCRGZGFTihVS4wtdE0Gws1qL5Z
	 6bpaMgYN9QbbsBMnPstAclVqBqljLR2wdMuXXjHjbTYLKom7i8XB7jUhT5qGUotdsm
	 vGaiNnORwjWsrRbTLUHhLUYeoqpG4I+88zDSSvYDVrpJAD5O7GbDmZo1Or73y9aC42
	 +kKUkax9Hfsc5N7V5N/oLPwVRynZg4Kwzmg32/gU2hd6fdvtlOyv8nCmx1IsDVh6mr
	 /0oszIjM28bRBwdHqr3lDYALui2TOSwqXSa2SNg1yV4i74IkZXlDYkUM0XA3Auai1/
	 bAxCOMNweyGDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 64/76] proc: Use task_is_running() for wchan in /proc/$pid/stat
Date: Wed, 13 Mar 2024 12:42:11 -0400
Message-ID: <20240313164223.615640-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 4e046156792c26bef8a4e30be711777fc8578257 ]

The implementations of get_wchan() can be expensive. The only information
imparted here is whether or not a process is currently blocked in the
scheduler (and even this doesn't need to be exact). Avoid doing the
heavy lifting of stack walking and just report that information by using
task_is_running().

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211008111626.211281780@infradead.org
Stable-dep-of: 60f92acb60a9 ("fs/proc: do_task_stat: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 49be8c8ef555e..77cf4187adecc 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -541,7 +541,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	}
 
 	if (permitted && (!whole || num_threads < 2))
-		wchan = get_wchan(task);
+		wchan = !task_is_running(task);
 	if (!whole) {
 		min_flt = task->min_flt;
 		maj_flt = task->maj_flt;
@@ -606,10 +606,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	 *
 	 * This works with older implementations of procps as well.
 	 */
-	if (wchan)
-		seq_puts(m, " 1");
-	else
-		seq_puts(m, " 0");
+	seq_put_decimal_ull(m, " ", wchan);
 
 	seq_put_decimal_ull(m, " ", 0);
 	seq_put_decimal_ull(m, " ", 0);
-- 
2.43.0


