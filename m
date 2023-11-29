Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8348C7FD301
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjK2JmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2JmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:42:04 -0500
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C958A1999;
        Wed, 29 Nov 2023 01:42:06 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee565670766cd0-3c572;
        Wed, 29 Nov 2023 17:42:04 +0800 (CST)
X-RM-TRANSID: 2ee565670766cd0-3c572
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76567076b191-69aba;
        Wed, 29 Nov 2023 17:42:04 +0800 (CST)
X-RM-TRANSID: 2ee76567076b191-69aba
From:   zhaimingbing <zhaimingbing@cmss.chinamobile.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Subject: [PATCH] perf help:Fail check on dynamic allocation
Date:   Wed, 29 Nov 2023 17:42:02 +0800
Message-Id: <20231129094202.11500-1-zhaimingbing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return error  if dynamic allocation failed.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/builtin-help.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index b2a368ae2..ca05cc795 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -196,6 +196,11 @@ static void add_man_viewer(const char *name)
 	while (*p)
 		p = &((*p)->next);
 	*p = zalloc(sizeof(**p) + len + 1);
+	if(!*p) {
+		pr_err("Failed to zalloc man viewer list\n");
+		return ;
+	}
+
 	strcpy((*p)->name, name);
 }
 
@@ -211,6 +216,10 @@ static void do_add_man_viewer_info(const char *name,
 				   const char *value)
 {
 	struct man_viewer_info_list *new = zalloc(sizeof(*new) + len + 1);
+	if(!new) {
+		pr_err("Failed to zalloc man viewer info list\n");
+		return ;
+	}
 
 	strncpy(new->name, name, len);
 	new->info = strdup(value);
-- 
2.33.0



