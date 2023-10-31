Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8580C7DCCB0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344205AbjJaMGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344145AbjJaMGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:06:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2516558E;
        Tue, 31 Oct 2023 05:05:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E225E139F;
        Tue, 31 Oct 2023 05:06:31 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.. (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.2.18])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C27EE3F738;
        Tue, 31 Oct 2023 05:05:48 -0700 (PDT)
From:   Nick Forrington <nick.forrington@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Nick Forrington <nick.forrington@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/2] perf lock info: Enforce exactly one of --map and --thread
Date:   Tue, 31 Oct 2023 12:05:25 +0000
Message-ID: <20231031120526.11502-3-nick.forrington@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031120526.11502-1-nick.forrington@arm.com>
References: <20231031120526.11502-1-nick.forrington@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve error reporting for command line arguments.

Display error/usage if neither --map or --thread are specified (rather
than a non user-friendly error "Unknown type of information").

Display error/usage if both --map and --thread are specified (rather
than ignoring "--map" and displaying only thread information).

Signed-off-by: Nick Forrington <nick.forrington@arm.com>
---
 tools/perf/builtin-lock.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 3aa8ba5ad928..cf29f648d291 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2021,6 +2021,27 @@ static int check_lock_report_options(const struct option *options,
 	return 0;
 }
 
+static int check_lock_info_options(const struct option *options,
+				   const char * const *usage)
+{
+	if (!info_map && !info_threads) {
+		pr_err("Requires one of --map or --threads\n");
+		parse_options_usage(usage, options, "map", 0);
+		parse_options_usage(NULL, options, "threads", 0);
+		return -1;
+
+	}
+
+	if (info_map && info_threads) {
+		pr_err("Cannot show map and threads together\n");
+		parse_options_usage(usage, options, "map", 0);
+		parse_options_usage(NULL, options, "threads", 0);
+		return -1;
+	}
+
+	return 0;
+}
+
 static int check_lock_contention_options(const struct option *options,
 					 const char * const *usage)
 
@@ -2709,6 +2730,10 @@ int cmd_lock(int argc, const char **argv)
 			if (argc)
 				usage_with_options(info_usage, info_options);
 		}
+
+		if (check_lock_info_options(info_options, info_usage) < 0)
+			return -1;
+
 		/* recycling report_lock_ops */
 		trace_handler = &report_lock_ops;
 		rc = __cmd_report(true);
-- 
2.42.0

