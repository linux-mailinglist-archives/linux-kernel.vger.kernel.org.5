Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F597E9B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjKML1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjKML1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:27:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0157044B8;
        Mon, 13 Nov 2023 03:26:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8AAD150C;
        Mon, 13 Nov 2023 03:26:47 -0800 (PST)
Received: from e127643.arm.com (unknown [10.57.71.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 191A73F6C4;
        Mon, 13 Nov 2023 03:25:59 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com,
        will@kernel.org, mark.rutland@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] Documentation: arm64: Document the PMU event counting threshold feature
Date:   Mon, 13 Nov 2023 11:25:06 +0000
Message-Id: <20231113112507.917107-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113112507.917107-1-james.clark@arm.com>
References: <20231113112507.917107-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the new Perf event open parameters and
the threshold_max capability file.

Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/arch/arm64/perf.rst | 56 +++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
index 1f87b57c2332..36b8111a710d 100644
--- a/Documentation/arch/arm64/perf.rst
+++ b/Documentation/arch/arm64/perf.rst
@@ -164,3 +164,59 @@ and should be used to mask the upper bits as needed.
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/arm64/tests/user-events.c
 .. _tools/lib/perf/tests/test-evsel.c:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c
+
+Event Counting Threshold
+==========================================
+
+Overview
+--------
+
+FEAT_PMUv3_TH (Armv8.8) permits a PMU counter to increment only on
+events whose count meets a specified threshold condition. For example if
+threshold_compare is set to 2 ('Greater than or equal'), and the
+threshold is set to 2, then the PMU counter will now only increment by
+when an event would have previously incremented the PMU counter by 2 or
+more on a single processor cycle.
+
+To increment by 1 after passing the threshold condition instead of the
+number of events on that cycle, add the 'threshold_count' option to the
+commandline.
+
+How-to
+------
+
+The threshold, threshold_compare and threshold_count values can be
+provided per event:
+
+.. code-block:: sh
+
+  perf stat -e stall_slot/threshold=2,threshold_compare=2/ \
+            -e dtlb_walk/threshold=10,threshold_compare=3,threshold_count/
+
+And the following comparison values are supported:
+
+.. code-block::
+
+  0: Not-equal
+  1: Equals
+  2: Greater-than-or-equal
+  3: Less-than
+
+The maximum supported threshold value can be read from the caps of each
+PMU, for example:
+
+.. code-block:: sh
+
+  cat /sys/bus/event_source/devices/armv8_pmuv3/caps/threshold_max
+
+  0x000000ff
+
+If a value higher than this is given, then it will be silently clamped
+to the maximum. The highest possible maximum is 4095, as the config
+field for threshold is limited to 12 bits, and the Perf tool will refuse
+to parse higher values.
+
+If the PMU doesn't support FEAT_PMUv3_TH, then threshold_max will read
+0, and both threshold and threshold_compare will be silently ignored.
+threshold_max will also read as 0 on aarch32 guests, even if the host
+is running on hardware with the feature.
-- 
2.34.1

