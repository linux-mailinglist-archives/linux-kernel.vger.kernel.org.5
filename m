Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9A782133
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 03:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjHUBad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 21:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHUBac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 21:30:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2428A7;
        Sun, 20 Aug 2023 18:30:29 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RTZd905jnz1L9Cl;
        Mon, 21 Aug 2023 09:29:00 +0800 (CST)
Received: from localhost.localdomain (10.67.174.95) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 21 Aug 2023 09:30:26 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
        <james.clark@arm.com>, <tmricht@linux.ibm.com>,
        <ak@linux.intel.com>, <anshuman.khandual@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH v6 0/7] perf record: Track sideband events for all CPUs when tracing selected CPUs
Date:   Mon, 21 Aug 2023 01:27:27 +0000
Message-ID: <20230821012734.18241-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.95]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space tasks can migrate between CPUs, track sideband events for all
CPUs.

The specific scenarios are as follows:

         CPU0                                 CPU1
  perf record -C 0 start
                              taskA starts to be created and executed
                                -> PERF_RECORD_COMM and PERF_RECORD_MMAP
                                   events only deliver to CPU1
                              ......
                                |
                          migrate to CPU0
                                |
  Running on CPU0    <----------/
  ...

  perf record -C 0 stop

Now perf samples the PC of taskA. However, perf does not record the
PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.
Therefore, the comm and symbols of taskA cannot be parsed.

The sys_perf_event_open invoked is as follows:

  # perf --debug verbose=3 record -e cpu-clock -C 1 true
  <SNIP>
  Opening: cpu-clock
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0 (PERF_COUNT_SW_CPU_CLOCK)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CPU|PERIOD|IDENTIFIER
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    freq                             1
    sample_id_all                    1
    exclude_guest                    1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
  Opening: dummy:u
  ------------------------------------------------------------
  perf_event_attr:
    type                             1 (PERF_TYPE_SOFTWARE)
    size                             136
    config                           0x9 (PERF_COUNT_SW_DUMMY)
    { sample_period, sample_freq }   1
    sample_type                      IP|TID|TIME|CPU|IDENTIFIER
    read_format                      ID|LOST
    inherit                          1
    exclude_kernel                   1
    exclude_hv                       1
    mmap                             1
    comm                             1
    task                             1
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
  ------------------------------------------------------------
  sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
  sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
  sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
  sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
  sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
  sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
  sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
  sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
  <SNIP>

Changes since_v5:
 - No code changes.
 - Detailed commit message of patch3.
 - Add Acked-by and Tested-by tags from Adrian Hunter.

Changes since_v4:
 - Simplify check code for record__tracking_system_wide().
 - Add perf attr test result to commit message for patch 7.

Changes since_v3:
 - Check fall_kernel, all_user, and dummy or exclude_user when determining
   whether system wide is required.

Changes since_v2:
 - Rename record_tracking.sh to record_sideband.sh in tools/perf/tests/shell.
 - Remove "perf evlist: Skip dummy event sample_type check for evlist_config" patch.
 - Add opts->all_kernel check in record__config_tracking_events().
 - Add perf_event_attr test for record selected CPUs exclude_user.
 - Update base-record & system-wide-dummy sample_type attr expected values for test-record-C0.

Changes since v1:
 - Add perf_evlist__go_system_wide() via internal/evlist.h instead of
   exporting perf_evlist__propagate_maps().
 - Use evlist__add_aux_dummy() instead of evlist__add_dummy() in
   evlist__findnew_tracking_event().
 - Add a parameter in evlist__findnew_tracking_event() to deal with
   system_wide inside.
 - Add sideband for all CPUs when tracing selected CPUs comments on
   the perf record man page.
 - Use "sideband events" instead of "tracking events".
 - Adjust the patches Sequence.
 - Add patch5 to skip dummy event sample_type check for evlist_config.
 - Add patch6 to update system-wide-dummy attr values for perf test.

Yang Jihong (7):
  perf evlist: Add perf_evlist__go_system_wide() helper
  perf evlist: Add evlist__findnew_tracking_event() helper
  perf record: Move setting dummy tracking before
    record__init_thread_masks()
  perf record: Track sideband events for all CPUs when tracing selected
    CPUs
  perf test: Update base-record & system-wide-dummy attr expected values
    for test-record-C0
  perf test: Add test case for record sideband events
  perf test: Add perf_event_attr test for record selected CPUs
    exclude_user

 tools/lib/perf/evlist.c                       |   9 ++
 tools/lib/perf/include/internal/evlist.h      |   2 +
 tools/perf/Documentation/perf-record.txt      |   3 +
 tools/perf/builtin-record.c                   | 106 +++++++++++++-----
 tools/perf/tests/attr/system-wide-dummy       |  14 ++-
 tools/perf/tests/attr/test-record-C0          |   4 +-
 .../perf/tests/attr/test-record-C0-all-kernel |  32 ++++++
 tools/perf/tests/shell/record_sideband.sh     |  44 ++++++++
 tools/perf/util/evlist.c                      |  18 +++
 tools/perf/util/evlist.h                      |   1 +
 10 files changed, 198 insertions(+), 35 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-C0-all-kernel
 create mode 100755 tools/perf/tests/shell/record_sideband.sh

-- 
2.30.GIT

