Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848AF7D99E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjJ0Ndn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0Ndj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:33:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACF1D6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338ADC433C7;
        Fri, 27 Oct 2023 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698413617;
        bh=mkOAnvc/y5wxjD9fXidKsxRBk6fewzPGPXWV4xJ0YoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW6FLLzrRuFXBKlkMAVKVRP6B3RxZ8In9jAfCOPWFr16tWZbGQDWD5Epqb9vU1f4Y
         J87uvzRTKxM3lkIyNhQGUO2THqxsHkPcssnPkp3e7o3AyJVJ2TbHWefrOWK/b3F0qv
         DbKWsp4QxJR+UXPysGYq7sFiA9c2BTLbOolNUiiJ2cFPUL4CCHbhwZ6v8zBkUP++qn
         rVSkwhC9QKh3S+LX0qhdWwu8KfBOIj6jEEJ+AZb1kmEfyNg2crak8yMkvM4IfQlfir
         AsaJRzNVJbJJ+7ZJdGXZkiVCC8AMlkhlZv5/M9ZJI1seHR9UPAH3Yf3F5Hag9Q0Uy1
         SX+2gKi4C++EQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8BCBE4035D; Fri, 27 Oct 2023 10:33:30 -0300 (-03)
Date:   Fri, 27 Oct 2023 10:33:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf python: Fix binding linkage due to rename and move
 of evsel__increase_rlimit()
Message-ID: <ZTu8Kgb2KqifMBZ3@kernel.org>
References: <20231023033144.1011896-1-yangjihong1@huawei.com>
 <ZTrCS5Z3PZAmfPdV@kernel.org>
 <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjhSSV+18ZCHLdTFpMM+MmpoDkYSGjUa5JKZp02Kx9XRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in ("perf evsel: Rename evsel__increase_rlimit to
rlimit__increase_nofile") ended up breaking the python binding that now
references the rlimit__increase_nofile function, add the util/rlimit.o
to the tools/perf/util/python-ext-sources to cure that.

This was detected by the 'perf test python' regression test:

  $ perf test python
   14: 'import perf' in python        : FAILED!

  $ perf test -v python
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   14: 'import perf' in python                                         :
  --- start ---
  test child forked, pid 2912462
  python usage test: "echo "import sys ; sys.path.insert(0, '/tmp/build/perf-tools-next/python'); import perf" | '/usr/bin/python3' "
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /tmp/build/perf-tools-next/python/perf.cpython-311-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!
  $

Fixes: e093a222d7cba1eb ("perf evsel: Rename evsel__increase_rlimit to rlimit__increase_nofile")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Yang Jihong <yangjihong1@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/lkml/ZTrCS5Z3PZAmfPdV@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python-ext-sources | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 26e1c8d973ea0b95..593b660ec75e24e1 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -40,6 +40,7 @@ util/rwsem.c
 util/hashmap.c
 util/perf_regs.c
 util/fncache.c
+util/rlimit.c
 util/perf-regs-arch/perf_regs_aarch64.c
 util/perf-regs-arch/perf_regs_arm.c
 util/perf-regs-arch/perf_regs_csky.c
-- 
2.41.0

