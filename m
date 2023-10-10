Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1B7BFEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjJJOQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjJJOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:16:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06EC5E0;
        Tue, 10 Oct 2023 07:16:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EBC51FB;
        Tue, 10 Oct 2023 07:17:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FD073F762;
        Tue, 10 Oct 2023 07:16:33 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Reiji Watanabe <reijiw@google.com>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Subject: [PATCH v3 3/3] Documentation: arm64: Document the PMU event counting threshold feature
Date:   Tue, 10 Oct 2023 15:15:43 +0100
Message-Id: <20231010141551.2262059-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010141551.2262059-1-james.clark@arm.com>
References: <20231010141551.2262059-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

