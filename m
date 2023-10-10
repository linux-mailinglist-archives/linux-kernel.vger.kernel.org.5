Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E6F7BF5F0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442861AbjJJIcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442752AbjJJIcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:32:03 -0400
Received: from outbound-smtp58.blacknight.com (outbound-smtp58.blacknight.com [46.22.136.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5985497
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:31:57 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp58.blacknight.com (Postfix) with ESMTPS id 4071CFABD8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:31:55 +0100 (IST)
Received: (qmail 6476 invoked from network); 10 Oct 2023 08:31:55 -0000
Received: from unknown (HELO morpheus.112glenside.lan) (mgorman@techsingularity.net@[84.203.197.19])
  by 81.17.254.9 with ESMTPA; 10 Oct 2023 08:31:55 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Raghavendra K T <raghavendra.kt@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Bharata B Rao <bharata@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/6] sched/numa: Complete scanning of partial and inactive VMAs
Date:   Tue, 10 Oct 2023 09:31:37 +0100
Message-Id: <20231010083143.19593-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NUMA Balancing currently uses PID fault activity within a VMA to
determine if it is worth updating PTEs to trap NUMA hinting faults.
While this is reduces overhead, it misses two important corner case.
The first is that if Task A partially scans a VMA that is active and
Task B resumes the scan but is inactive, then the remainder of the VMA
may be missed. Similarly, if a VMA is inactive for a period of time then
it may never be scanned again.

Patches 1-3 improve the documentation of the current per-VMA tracking
and adds a trace point for scan activity. Patch 4 addresses a corner
case where the PID activity information may not be reset after the
expected timeout. Patches 5-6 complete the scanning of partial and
inactive VMAs within the scan sequence.

This could be improved further but it would deserve a separate series on
top with supporting data justifying the change. Otherwise and gain/loss
due to the additional changes could be masked by this series on its own.

 include/linux/mm.h                   |   4 +-
 include/linux/mm_types.h             |  36 +++++++++-
 include/linux/sched/numa_balancing.h |  10 +++
 include/trace/events/sched.h         |  52 ++++++++++++++
 kernel/sched/fair.c                  | 103 ++++++++++++++++++++++-----
 5 files changed, 182 insertions(+), 23 deletions(-)

-- 
2.35.3

