Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2376F789
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjHDCKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjHDCKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:10:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FA34488;
        Thu,  3 Aug 2023 19:10:23 -0700 (PDT)
X-QQ-mid: bizesmtp65t1691114992tuk4aivs
Received: from i5.. ( [171.221.145.181])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Aug 2023 10:09:45 +0800 (CST)
X-QQ-SSF: 01000000000000B0Z000000A0000000
X-QQ-FEAT: rZJGTgY0+YN53cTr2cIpJ9qqpsAB3ZnP5VKPymf13aW7xyciAuZpWPNNmLZah
        Gt+CmTWkdjHsmlXH1hrtJlnlcRsIehh03JDrwmNshMrcRVidPcMtt6Xpr2YEgWSV5ps23G1
        WFUBFh6XsM+Yx3DmImktiQVRBKqtMXFbPjRFP/oWhP7K7wTTWAAnSj0Ah2ymyKaWcxypyVG
        9je2d4mloklbUXY720gWhWEa7yP2rfLwP9i5ejoooBsWSilw5EKear+3Vt7/DnbDfH7I33m
        hCqxKkuqGodmmnNXA2cWAr7LbDAtXP0yKTqkc1tfjNvNn1Lf+HO6rVMGxOfAxtWv8fpZljU
        nuC+mJ+aETAl94fvuxInLiOUkGt9hT5Qer2O7br0awtltdUkO4=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12857096553463341832
From:   Kaige Ye <ye@kaige.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kaige Ye <ye@kaige.org>
Subject: [PATCH v2] perf stat-display: Check if snprintf()'s fmt argument is NULL
Date:   Fri,  4 Aug 2023 10:09:08 +0800
Message-ID: <01CA7674B690CA24+20230804020907.144562-2-ye@kaige.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kaige.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
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
V1 -> V2: Addressed Ian's comments (Ian Rogers)
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 7329b3340..031888545 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
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

base-commit: f6b8436bede3e80226e8b2100279c4450c73806a
-- 
2.41.0

