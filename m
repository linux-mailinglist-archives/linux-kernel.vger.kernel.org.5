Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832127F6F81
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjKXJ1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjKXJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:27:00 -0500
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6820D68;
        Fri, 24 Nov 2023 01:27:03 -0800 (PST)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
        by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee865606c655ca-855ca;
        Fri, 24 Nov 2023 17:27:01 +0800 (CST)
X-RM-TRANSID: 2ee865606c655ca-855ca
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain.localdomain (unknown[10.54.5.252])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee165606c63cde-0afff;
        Fri, 24 Nov 2023 17:27:01 +0800 (CST)
X-RM-TRANSID: 2ee165606c63cde-0afff
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
Subject: [PATCH] perf lock: Fix a memory leak on an error path
Date:   Fri, 24 Nov 2023 17:26:57 +0800
Message-Id: <20231124092657.10392-1-zhaimingbing@cmss.chinamobile.com>
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

if a strdup-ed string is NULL,the allocated memory needs freeing.

Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
---
 tools/perf/builtin-lock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index b141f2134..086041bcb 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2228,8 +2228,10 @@ static int __cmd_record(int argc, const char **argv)
 		else
 			ev_name = strdup(contention_tracepoints[j].name);
 
-		if (!ev_name)
+		if (!ev_name) {
+			free(rec_argv);
 			return -ENOMEM;
+		}
 
 		rec_argv[i++] = "-e";
 		rec_argv[i++] = ev_name;
-- 
2.33.0



