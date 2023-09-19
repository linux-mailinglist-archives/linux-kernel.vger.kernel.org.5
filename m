Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C97A5E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjISJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjISJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:52:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5B6DF5;
        Tue, 19 Sep 2023 02:52:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D19891FB;
        Tue, 19 Sep 2023 02:52:53 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ED23F3F67D;
        Tue, 19 Sep 2023 02:52:14 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] Documentation: arm64: Document the PMU event counting threshold feature
Date:   Tue, 19 Sep 2023 10:51:29 +0100
Message-Id: <20230919095137.360963-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919095137.360963-1-james.clark@arm.com>
References: <20230919095137.360963-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the two new Perf event open parameters and
the threshold_max capability file.

Signed-off-by: James Clark <james.clark@arm.com>
---
 Documentation/arch/arm64/perf.rst | 58 +++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/Documentation/arch/arm64/perf.rst b/Documentation/arch/arm64/perf.rst
index 1f87b57c2332..122a12607f37 100644
--- a/Documentation/arch/arm64/perf.rst
+++ b/Documentation/arch/arm64/perf.rst
@@ -164,3 +164,61 @@ and should be used to mask the upper bits as needed.
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
+threshold_control is set to 5 ('Greater than or equal, count'), and
+the threshold is set to 2, then the PMU counter will now only increment
+by 1 when an event would have previously incremented the PMU counter by
+2 or more on a single processor cycle.
+
+To increment by the value of the event instead of 1, use the non 'count'
+comparisons, in this case 4 ('Greater than or equal'). Each comparison
+has a count and non count version, where the 'count' version always
+increments the PMU counter by 1 instead of the value of the event.
+
+How-to
+------
+
+The threshold and threshold control values can be provided per event:
+
+.. code-block:: sh
+
+  perf stat -e stall_slot/threshold=2,threshold_control=5/ \
+            -e dtlb_walk/threshold=10,threshold_control=4/
+
+And the following control values are supported:
+
+.. code-block::
+
+  0: Not-equal
+  1: Not-equal, count
+  2: Equals
+  3: Equals, count
+  4: Greater-than-or-equal
+  5: Greater-than-or-equal, count
+  6: Less-than
+  7: Less-than, count
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
+0, and both threshold and threshold_control will be silently ignored.
-- 
2.34.1

