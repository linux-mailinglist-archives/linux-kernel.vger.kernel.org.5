Return-Path: <linux-kernel+bounces-41829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EC83F828
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387E5B2113F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B50148309;
	Sun, 28 Jan 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmuWS5aS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1D1487D5;
	Sun, 28 Jan 2024 16:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458633; cv=none; b=ZTYkDE9rsijEXfjK0wP7NJc6dSvpr3T1CST0aafEKdPHltXA1RHai0u2scMLjKILdbsAWBqdsY9F2DZ3A+JQwFvq9C8JfFNTHvmD6yjiLdIWN1/0hJBwePRARIacRVnKyRVk8lc9mf3QFa7+EUxcYhVcvXI/A66TjZhWj5iWzWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458633; c=relaxed/simple;
	bh=M6xQ5kPfjgUCaL/CzdSiLrR73e1XID4Ir7kfTv+Ehj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/uGgkz244EYtK87Te2+bd07b8f99pdh97ieVxCnWQ24pqB8l8kfQtZSLFoN0PcoU/edY0cihAJLcEWxmyaMeWgqSAaAZ9a8VpN9QpA3LnuWFE9dpy2MnNDozB3vXsYqvT+b3RHd7s4745xuIw6TZ6uZPQ/BhCeoEd6yIcn8U2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmuWS5aS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB53C433C7;
	Sun, 28 Jan 2024 16:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458632;
	bh=M6xQ5kPfjgUCaL/CzdSiLrR73e1XID4Ir7kfTv+Ehj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmuWS5aS54VLIYFHDMhwvbPiUV8SCeDiqqkYSkGLFLyvgD82Wo+svoXbw+WVsyZeE
	 cWStPlQbP9w4MGlzO/Zho11nlmse+jafD2h3O+nj2Q76eoWVbDzByuM/gpMoYaAOS+
	 At/fnUsUBN+a/Cvox1hh8BUy5ocwwSKI5NCcTz+/f5j7ukxzal8RKB2MmV3qz13hlc
	 ueKpoO2NJcVMk9i+8de6HOE2oJFLF4Baxv33V0Bkmuq8c01l63FnjxIRu6E45NycRR
	 kBUOrmRokmM+L9xrOUqOJgsvZbLHVq14ad1vutDWRocjS6U1gbGlVw6147BBFOS66M
	 gTEX+fnFETCAQ==
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
Subject: [PATCH AUTOSEL 4.19 4/8] libsubcmd: Fix memory leak in uniq()
Date: Sun, 28 Jan 2024 11:16:55 -0500
Message-ID: <20240128161704.205756-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161704.205756-1-sashal@kernel.org>
References: <20240128161704.205756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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


