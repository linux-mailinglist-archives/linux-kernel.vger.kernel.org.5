Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C278F00D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242748AbjHaPQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbjHaPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:16:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4CA5E4A;
        Thu, 31 Aug 2023 08:16:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1D36C15;
        Thu, 31 Aug 2023 08:17:29 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F2F4B3F64C;
        Thu, 31 Aug 2023 08:16:46 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/7] perf: strcmp_cpuid_str() expression fixups
Date:   Thu, 31 Aug 2023 16:16:11 +0100
Message-Id: <20230831151632.124985-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set of fixes related to the comments here [1]. Mainly cleanups,
additional tests and refactoring since adding the new strcmp_cpuid_str()
metric expression.

I added the string replace function to the perf utils
rather than tools/lib/string.c because it didn't seem
easy to add tests for tools/lib.

[1]: https://lore.kernel.org/linux-arm-kernel/CAP-5=fVnUx0BnJC7X1rrm42OD7Bk=ZsHWNwAZMBYyB7yWhBfhQ@mail.gmail.com/

James Clark (7):
  perf test: Check result of has_event(cycles) test
  perf jevents: Remove unused keyword
  perf util: Add a function for replacing characters in a string
  perf test: Add a test for strcmp_cpuid_str() expression
  perf pmu: Move pmu__find_core_pmu() to pmus.c
  perf pmus: Simplify perf_pmus__find_core_pmu()
  perf pmu: Remove unused function

 tools/perf/arch/arm64/util/pmu.c | 20 ++++++-------
 tools/perf/pmu-events/metric.py  |  3 +-
 tools/perf/tests/Build           |  1 +
 tools/perf/tests/builtin-test.c  |  1 +
 tools/perf/tests/expr.c          | 33 ++++++++++++++++++----
 tools/perf/tests/tests.h         |  1 +
 tools/perf/tests/util.c          | 30 ++++++++++++++++++++
 tools/perf/util/expr.c           |  2 +-
 tools/perf/util/pmu.c            | 22 ---------------
 tools/perf/util/pmu.h            |  3 +-
 tools/perf/util/pmus.c           |  6 ++++
 tools/perf/util/string.c         | 48 ++++++++++++++++++++++++++++++++
 tools/perf/util/string2.h        |  1 +
 13 files changed, 127 insertions(+), 44 deletions(-)
 create mode 100644 tools/perf/tests/util.c

-- 
2.34.1

