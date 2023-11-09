Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0757E618E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjKIAnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjKIAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B14D18E;
        Wed,  8 Nov 2023 16:43:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED83C433C7;
        Thu,  9 Nov 2023 00:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490620;
        bh=hx3Djh/kYdFvuxP2oBZvphYZwmXCDf5Wl1myLGWOnwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UkgQZtvQExzTHY3D9/R+gZTaVgixkNq7It9ld+PdOzhlcIJywX31Vqfpwp5trYRh1
         TMPQt3zCAaSNL+vrxVJ2CX8UJki9Okqz/7lcD+9X/mykWEDYdH8QUOOrJDHmSfFBj0
         80gxfa0dhcCHmclYMfhki//DWESzs6TZL1ln5Rt4w+xCHdEICqOJ4uYmcsVx5YSA6/
         rONHgpZNMdzJdvo+B4kOJmxCWpqfT50m35xO+gvZhLptDC3lZUSviD1p4PXhn0DiDx
         +XNXnevNVU/cgDgbrf/aZjDfnDAXF3s6S5luXuhEIiwdwH4l16qbfh7DjJDIpILzys
         wnHgkXJtYJYkg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 03/10] perf: Simplify get_perf_callchain() user logic
Date:   Wed,  8 Nov 2023 16:41:08 -0800
Message-ID: <6456d4d523841fb97b639433731540b8783529a1.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the get_perf_callchain() user logic a bit.  task_pt_regs()
should never be NULL.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 kernel/events/callchain.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index aa5f9d11c28d..2bee8b6fda0e 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -202,20 +202,18 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 
 	if (user) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs = task_pt_regs(current);
-			else
-				regs = NULL;
+			if (!current->mm)
+				goto exit_put;
+			regs = task_pt_regs(current);
 		}
 
-		if (regs) {
-			if (add_mark)
-				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+		if (add_mark)
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
-			perf_callchain_user(&ctx, regs);
-		}
+		perf_callchain_user(&ctx, regs);
 	}
 
+exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
-- 
2.41.0

