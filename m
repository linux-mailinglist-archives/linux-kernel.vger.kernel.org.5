Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163C80F193
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376616AbjLLPzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjLLPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:55:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6BF59109
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:55:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81E8F143D;
        Tue, 12 Dec 2023 07:55:51 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB1173F738;
        Tue, 12 Dec 2023 07:55:03 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 0/8] coresight: Separate sysfs and Perf usage and some other cleanups
Date:   Tue, 12 Dec 2023 15:53:57 +0000
Message-Id: <20231212155407.1429121-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
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

I've been finding it quite difficult to reason about some of the state
and functions in coresight-core.c because they have generic names when
they are actually only relevant to the sysfs usage of Coresight rather
than usage through Perf. This is probably because sysfs came first and
Perf was added later. This has caused a couple of issues where these
things have been used in the wrong context, for example the first
commit is a fixup.

To fix this I've mainly just moved all of the sysfs stuff to the sysfs
file and removed the 'enable' state, which was just for sysfs. While
doing the refactor it became obvious that refcnt didn't need to be
atomic either, so that can be simplified along with some other comment
clarifications and simplifications.

Hopefully it's also a step towards to removing all of the duplicate
refcnt and mode tracking code from the individual devices. That tracking
pretty much always results in a one-shot enable/disable and fixes the
mode to either sysfs or Perf, and there is no reason that can't exist in
the core layer outside of the devices. I tried to finish that in this
set, but there turned out to be some complexities, so I cut it short at
a point where I can be sure that there are no behavioral changes.

James Clark (8):
  coresight: Fix issue where a source device's helpers aren't disabled
  coresight: Make language around "activated" sinks consistent
  coresight: Remove ops callback checks
  coresight: Move mode to struct coresight_device
  coresight: Remove the 'enable' field.
  coresight: Move all sysfs code to sysfs file
  coresight: Remove atomic type from refcnt
  coresight: Remove unused stubs

 drivers/hwtracing/coresight/coresight-core.c  | 494 +-----------------
 drivers/hwtracing/coresight/coresight-etb10.c |  29 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   2 +-
 drivers/hwtracing/coresight/coresight-etm.h   |   2 -
 .../coresight/coresight-etm3x-core.c          |  17 +-
 .../coresight/coresight-etm3x-sysfs.c         |   4 +-
 .../coresight/coresight-etm4x-core.c          |   4 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   9 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  24 +-
 drivers/hwtracing/coresight/coresight-sysfs.c | 391 ++++++++++++++
 .../hwtracing/coresight/coresight-tmc-core.c  |   2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   |  46 +-
 .../hwtracing/coresight/coresight-tmc-etr.c   |  33 +-
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 -
 drivers/hwtracing/coresight/coresight-tpda.c  |  13 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |  14 +-
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  22 +-
 drivers/hwtracing/coresight/ultrasoc-smb.h    |   2 -
 include/linux/coresight.h                     | 114 +---
 19 files changed, 561 insertions(+), 663 deletions(-)

-- 
2.34.1

