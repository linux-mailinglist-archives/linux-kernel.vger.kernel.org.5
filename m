Return-Path: <linux-kernel+bounces-41821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E8D83F812
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE8F28AC32
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC83145B1A;
	Sun, 28 Jan 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW0YK6v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DD6145B0C;
	Sun, 28 Jan 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458610; cv=none; b=teuRpyI7QQYRjiIyYrDnRvje0l8HMUZAzJ/NyUfPN9zXu5dqFFzw8srV3QYldUi/ppNubD598mlwBMdv0M3FeCGg2d6NK76TILg9X0oT99zmDr4K2urCuSEoSAY4zEm7YWpl3iCDgfzpSZVJxzhbNPI25gXdo3pA7nNe+aTVblk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458610; c=relaxed/simple;
	bh=M6xQ5kPfjgUCaL/CzdSiLrR73e1XID4Ir7kfTv+Ehj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsN5Z75EQrOywVu1AjqfeePNDyU2VAYqtxthb+//3CQzxtTrm/hdVNBrvpLbKUfrhA8ooflGJtCCTi6YbFlD1s05ZpzTAE/X5jHNHlmoD6NeIfDL2FH+6hkp9lblRNUiELazL+yqP/OZqPCFPr6C3s1GMUI1ahv6z1fXPsg+LYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW0YK6v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125E4C433F1;
	Sun, 28 Jan 2024 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458610;
	bh=M6xQ5kPfjgUCaL/CzdSiLrR73e1XID4Ir7kfTv+Ehj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QW0YK6v7ITm44Obl0FANdZHVSnfLgrZqMzbSJ0Vo1Sdst4puz/bxn6EfG7kO/0ZjG
	 dZON1MlyGs12xYEmbi1KhAbkrs3UBki6CxjBCzcv75G3FoH+lyRIYeBKwOPoBjhtww
	 EVs2o8wu207n7gS1TRzZlsSUajjLazT9ZILgB19JoCydZzgIPoGcQ6rIx6EwjBtjTB
	 IavuvJK7Nm+Vk+2ODAGRzz1N1xoNMRVPs7pBs1h6S1Iu+qeSggOt9NsrTNGB0GztxS
	 udQK7eRBsONx8XOla2gJfssoQWE/Y2Vt2+fau5z4k4AGYyeKM986YS3PTLWdZ8ufer
	 qoNtQQz+lhAjQ==
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
Subject: [PATCH AUTOSEL 5.4 07/11] libsubcmd: Fix memory leak in uniq()
Date: Sun, 28 Jan 2024 11:16:28 -0500
Message-ID: <20240128161637.205509-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index 2859f107abc8..4260c8b4257b 100644
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


