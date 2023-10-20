Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9755F7D16CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJTUJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjJTUJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:09:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DB2D6B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:09:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF142C433C7;
        Fri, 20 Oct 2023 20:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697832543;
        bh=Ut9daOcuRRD9l+ZL0uzgf+bMBQJQzFl0hfVsSHDlVRI=;
        h=From:To:Cc:Subject:Date:From;
        b=EYf4a+ORI5h5jjRlejSEcLpwemqffiv05jqD/AVDRCmAst99cs2nmaJLixh3CZAI4
         fjVRIjsff42p1QXiyyvbD0LpAg4TWu0Ba2VOphxXXMDZiqXtuTmXZpW9ehfmRdL6FS
         RTCMInhZBZpTUBwEUIOq76gkXLdkn6gLAtmktvCvcdQoS6qHWwfeJ3T7Pg+72RwLnV
         7/uzMVrrW9YHxl+4aiqfQCjTcoETeotlAjJJinDqzn3gcuYz0qVDZBO8/aixImLWRR
         0AJ720RBtjVoXZ2yA71vS5ASMx2SxX6Pb1qynnbSsX5xdmTuoCfednoDxNsOI2K8Qm
         50yzhH0eGiSJg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Manu Bretelle <chantr4@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.6: 2nd batch
Date:   Fri, 20 Oct 2023 17:08:46 -0300
Message-ID: <20231020200846.99350-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit e47749f1796d1df39a7eaae95f2784aaa43df57d:

  perf jevent: fix core dump on software events on s390 (2023-09-17 15:51:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.6-2-2023-10-20

for you to fetch changes up to 4fa008a2db484024a5cb52676a1b1534dc82330c:

  tools build: Fix llvm feature detection, still used by bpftool (2023-10-19 22:33:58 -0300)

----------------------------------------------------------------
perf tools fixes for v6.6: 2nd batch

- Fix regression in reading scale and unit files from sysfs for PMU
  events, so that we can use that info to pretty print instead of
  printing raw numbers:

  # perf stat -e power/energy-ram/,power/energy-gpu/ sleep 2

   Performance counter stats for 'system wide':

              1.64 Joules power/energy-ram/
              0.20 Joules power/energy-gpu/

       2.001228914 seconds time elapsed
  #
  # grep -m1 "model name" /proc/cpuinfo
  model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
  #

- The small llvm.cpp file used to check if the llvm devel files are present was
  incorrectly deleted when removing the BPF event in 'perf trace', put it back
  as it is also used by tools/bpf/bpftool, that uses llvm routines to do
  disassembly of BPF object files.

- Fix use of addr_location__exit() in dlfilter__object_code(), making sure that
  it is only used to pair a previous addr_location__init() call.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (2):
      perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()
      perf dlfilter: Add a test for object_code()

Arnaldo Carvalho de Melo (1):
      tools build: Fix llvm feature detection, still used by bpftool

Wyes Karny (1):
      perf pmu: Fix perf stat output with correct scale and unit

 tools/build/feature/test-llvm.cpp           | 14 +++++++++++++
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 12 ++++++++++-
 tools/perf/dlfilters/dlfilter-test-api-v2.c | 12 ++++++++++-
 tools/perf/util/dlfilter.c                  | 32 ++++++++++++++---------------
 tools/perf/util/pmu.c                       |  8 ++++----
 5 files changed, 55 insertions(+), 23 deletions(-)
 create mode 100644 tools/build/feature/test-llvm.cpp
