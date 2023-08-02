Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCE576C3E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHBEIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjHBEIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:08:13 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509871FEE;
        Tue,  1 Aug 2023 21:08:10 -0700 (PDT)
X-QQ-mid: bizesmtp79t1690949036tyb32jua
Received: from i5.. ( [171.221.145.181])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 12:03:44 +0800 (CST)
X-QQ-SSF: 01000000000000B0Z000000A0000000
X-QQ-FEAT: 9fp+MOMfZT3hZ97GkXCF6T6RWRzLM87ON4Q3rpOGvo4QohvGz+Pl6LDuI8H9f
        WNWiTd/dq18vUcIwa4YnCVAUL2rOVJcD8TjWFU23w6S8BnD3ZAeUwLSEkm3PGo/XQ/AfAcM
        smMsoDoscYcKvlJnvUjicASxPab71CxeDyuSePhMushj4tYRWprC1E68Cty/dehVEezvygP
        rfg2Q4SggtVDyX+mHnIQrO9kXilAB40+kTzd9rp32SBqLsFqhj4Ly2GsuctU2bMgK4Jj3jk
        CPSPJcrXFa6a2G0zJXLtLkiEUnnxM16Qu+OIBp+M5k6ZE8+HoGA1liTxrBHE98TKiUbsTgv
        TBnJBG9EO39NaXiPjD/zTOv6J2hqp8HupxjkY4VdJ6X7vA7e90=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 35962698903440785
From:   Kaige Ye <ye@kaige.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaige Ye <ye@kaige.org>
Subject: [PATCH] perf stat-display: Check if snprintf()'s fmt argument is NULL
Date:   Wed,  2 Aug 2023 12:03:16 +0800
Message-ID: <F762DED397BFDFD1+20230802040315.106038-2-ye@kaige.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kaige.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is undefined behavior to pass NULL as snprintf()'s fmt argument.
Here is an example to trigger the problem:

  $ perf stat --metric-only -x, -e instructions -- sleep 1
  insn per cycle,
  Segmentation fault (core dumped)

With this patch:

  $ perf stat --metric-only -x, -e instructions -- sleep 1
  insn per cycle,
  ,

Signed-off-by: Kaige Ye <ye@kaige.org>
---
 tools/perf/util/stat-display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7329b3340..e8936cffd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -438,7 +438,7 @@ static void print_metric_csv(struct perf_stat_config *config __maybe_unused,
 		fprintf(out, "%s%s", config->csv_sep, config->csv_sep);
 		return;
 	}
-	snprintf(buf, sizeof(buf), fmt, val);
+	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
@@ -578,7 +578,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
-	snprintf(buf, sizeof buf, fmt, val);
+	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
@@ -600,7 +600,7 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
 	if (!valid_only_metric(unit))
 		return;
 	unit = fixunit(tbuf, os->evsel, unit);
-	snprintf(buf, sizeof(buf), fmt, val);
+	snprintf(buf, sizeof(buf), fmt ?: "", val);
 	ends = vals = skip_spaces(buf);
 	while (isdigit(*ends) || *ends == '.')
 		ends++;
-- 
2.41.0

