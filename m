Return-Path: <linux-kernel+bounces-41809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B82283F7EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 976D8B20F37
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7652813EFE8;
	Sun, 28 Jan 2024 16:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgB0BdkU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B413E23B;
	Sun, 28 Jan 2024 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458580; cv=none; b=KFJVZZ2OSumDqEMLZti0eg6XeP56iUH3ROdnRWHm7LT4USSZWLEGeVI1Ee2Q7GYkBmfzL7Yyc9qz2X7y2qs4yTeiAv/pDo8YzuxCIkiYKy7X21MGh5ToMt5TVn+9qEek8ROT00lQcHtQ8KrhaRkO8u8Iv5d9l/nBQaSikCPc6+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458580; c=relaxed/simple;
	bh=IYwW7e4E9Y2kJYiXwrhyvYQ/jZmbm9wx+dLNWmt5YQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYPGnlIHOqLEBTbUjHF3mWofwxZ7bROV6SdaJ5kF3HE9X7LFHYJV0xlwWaA5VELm+tN/ZMo5JdirHRBzn4zqyhkF+ZlsT2ZxWrIoEm0V+ZarJIH/njUta/nUN4colkYwXP9mK0GkPEH795Fp7jvYWARZiYny8H0L+bmsvQWQJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgB0BdkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3256DC433F1;
	Sun, 28 Jan 2024 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458580;
	bh=IYwW7e4E9Y2kJYiXwrhyvYQ/jZmbm9wx+dLNWmt5YQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sgB0BdkUnXkgv45naZnhjwTxGyjEfrpalLWZbGL6zpzURow+ge/47q/9LO1dvN55n
	 n5bUNMWWCJDEZfIdiGk5EklzhKYI/zHglEBrx88kUX3hOZPCmuawdF6NBr2D8NdYTb
	 WhTofGk2sq07JyuTJx3z8Z7NyOsM05BxbR3Slk7KGPrjtuMTc6tpwt9A0bR/h3dsR+
	 2KeHONFMc0ysyOO3j+FxzYDkEbrFyGN/N3zIVawaK2uxGRss9tIuRueZzsoQNWSoWW
	 9J7u5U9QYbFAsuIZ5jrIDr4cES63l1Ed0ftCtlN1V6bzJIN9z/TNBr4hmrMQ84V14i
	 OuuDVpqqvnKwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.10 08/13] libsubcmd: Fix memory leak in uniq()
Date: Sun, 28 Jan 2024 11:15:54 -0500
Message-ID: <20240128161606.205221-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Ian Rogers <irogers@google.com>

[ Upstream commit ad30469a841b50dbb541df4d6971d891f703c297 ]

uniq() will write one command name over another causing the overwritten
string to be leaked. Fix by doing a pass that removes duplicates and a
second that removes the holes.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Chenyuan Mi <cymi20@fudan.edu.cn>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231208000515.1693746-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/subcmd/help.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..42f57b640f11 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -50,11 +50,21 @@ void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
-			cmds->names[j++] = cmds->names[i];
-
+	for (i = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+			zfree(&cmds->names[i - 1]);
+	}
+	for (i = 0, j = 0; i < cmds->cnt; i++) {
+		if (cmds->names[i]) {
+			if (i == j)
+				j++;
+			else
+				cmds->names[j++] = cmds->names[i];
+		}
+	}
 	cmds->cnt = j;
+	while (j < i)
+		cmds->names[j++] = NULL;
 }
 
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
-- 
2.43.0


