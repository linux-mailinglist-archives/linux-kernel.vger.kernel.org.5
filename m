Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32375A027
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjGSUt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGSUtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:49:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A161FC0;
        Wed, 19 Jul 2023 13:49:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CD2E6183C;
        Wed, 19 Jul 2023 20:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDC4C433C8;
        Wed, 19 Jul 2023 20:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689799763;
        bh=TCKxv/PHrVcQ5XdxdCykqXw0ltN3EL+j1VJlZlY1wLM=;
        h=From:To:Cc:Subject:Date:From;
        b=YdGqtMP33hjX75NyVhuJIx7Rw5aALcujWh2MP1QXqFqarNdczfbrpVgeL2qWwlMo+
         FKwtG5pYm/oTE2CuTf68RObM6d1NhodRdsClj+1w0Q4NIy1tjQtuDpNZzUSblIEdqE
         ZxCD0W8kI2ZMPk77vixU7SzHEC+wTtNPvdhnlrRORJkctnKCU6CoRJwQZLcsYcsSYv
         BGkAForzwMiHmBRRyrzAg+NfR/Nj58dZ25u2D2rEbYaoeHIxryIiGEekOOG5SmWKKe
         lAQKXiXaP6DtAOwWGSFm761H5750AG/zdQdtjEpGB0drczZpLSjsowtae/tF0M4xvx
         L4H5ZoR8EQkDQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCHES/RFC 1/5] perf bench uprobe + BPF skel
Date:   Wed, 19 Jul 2023 17:49:05 -0300
Message-ID: <20230719204910.539044-1-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This adds a 'perf bench' to test the overhead of uprobes + BPF
programs, for now just a few simple tests, but I plan to make it
possible to specify the functions to attach the uprobe + BPF, other BPF
operations dealing with maps, etc.

	This is how it looks like now:

  [root@five ~]# perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,053,963 usecs
  
   1,053.963 usecs/op
  
  # Running uprobe/empty benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,056,293 usecs +2,330 to baseline
  
   1,056.293 usecs/op 2.330 usecs/op to baseline
  
  # Running uprobe/trace_printk benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,056,977 usecs +3,014 to baseline +684 to previous
  
   1,056.977 usecs/op 3.014 usecs/op to baseline 0.684 usecs/op to previous
  
  [root@five ~]

I put it here:

  https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=perf-bench-uprobe

  git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-bench-uprobe

Further ideas, problems?

- Arnaldo



Arnaldo Carvalho de Melo (5):
  perf bench uprobe: Add benchmark to test uprobe overhead
  perf bench uprobe: Print diff to baseline
  perf bench uprobe: Show diff to previous
  perf bench uprobe empty: Add entry attaching an empty BPF program
  perf bench uprobe trace_printk: Add entry attaching an BPF program that does a trace_printk

 tools/perf/Documentation/perf-bench.txt     |   3 +
 tools/perf/Makefile.perf                    |   1 +
 tools/perf/bench/Build                      |   1 +
 tools/perf/bench/bench.h                    |   3 +
 tools/perf/bench/uprobe.c                   | 198 ++++++++++++++++++++
 tools/perf/builtin-bench.c                  |   8 +
 tools/perf/util/bpf_skel/bench_uprobe.bpf.c |  23 +++
 7 files changed, 237 insertions(+)
 create mode 100644 tools/perf/bench/uprobe.c
 create mode 100644 tools/perf/util/bpf_skel/bench_uprobe.bpf.c

-- 
2.41.0

