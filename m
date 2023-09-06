Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F8794233
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 19:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243301AbjIFRtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 13:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242051AbjIFRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:49:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E119AE;
        Wed,  6 Sep 2023 10:49:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26f57f02442so73335a91.0;
        Wed, 06 Sep 2023 10:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694022545; x=1694627345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=rbxxF3pN1PaPN9re65XUx8AyYVj3neI58zu4FlTZdnI=;
        b=NneKSSnWP9k+Gmm3c9BjmStAPPkEeTLG2eX/mfZpZM5S9zX1hplXVI9360FVdF7d5W
         PiOZcVESIaTDZ4QwgnvJF0C2wBVEpVfxshE1ru7VGjgzwOFBDilVcfArLZ6zow7lTlGq
         sWM5mpYKJJt8IIwmpSP+9IdNhEe+nx1mTroGNl0oxCcXgieqai8jxCWVIarvNfYDQTzM
         BojYSmvCktpBFwdQ4XewDLv3OIssPI48kRvBmGlguWSzLl9SsFl6JF5LXEN6Pn/5FrpK
         7RSqV+My3sjnZG2zo2igf0gGzOjAzqF2eZJJehyD0i7Nt0evVQsSRIvHeqxJ1GR6aivK
         eZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694022545; x=1694627345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbxxF3pN1PaPN9re65XUx8AyYVj3neI58zu4FlTZdnI=;
        b=hgxyMHcDcLIDEScEBudu4NNmu+F9NU1h14XLzhKezQRAXyb12zA8XlH+MX1nkHGmcZ
         w3hWACXsdGIDKqYbTtdazv2RXSbmqxSQ96Fl48vjt+5mwpqBrv5lM8vw+OkMUsigQG2h
         Mi1aphQvLprheAhjB5aV1pCZEinfeNQ4H45RWNKK4W5JLSJGFtrnjV090ZvxnrDmSm4U
         iy6ImFrIQR7SPY+89Q4vXtG/q/4ezOLJYiqaKoonQVrju55PR5A9Gln+tTZwuz+gHLPQ
         AuLLzOf+VYYqkzplmlnlTZH5l2A+mny/d8NlS7sl2lgGQH6v7im/Yw1vgq9HPIu341BE
         C/Ew==
X-Gm-Message-State: AOJu0Yy8o9hEA/RZ7v+vLHlGtPWLMCqkyGYzGv2Ya+Ppe+8jTYaf+9Jx
        plVTvSIn8vV2yd0impF+JiU=
X-Google-Smtp-Source: AGHT+IHIsJB5k5MtRKBtd9SIsU3bq2FtvyoDxLeB6d+PFGwSuPycpKDnvgaXIq9FsjtETtPqxw3hMQ==
X-Received: by 2002:a17:90a:2acf:b0:26b:36dc:2f08 with SMTP id i15-20020a17090a2acf00b0026b36dc2f08mr14447576pjg.46.1694022545392;
        Wed, 06 Sep 2023 10:49:05 -0700 (PDT)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:5035:1b47:9a3f:312c])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090ad30b00b00262eccfa29fsm63564pju.33.2023.09.06.10.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 10:49:04 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Subject: [PATCHSET 0/5] perf lock contention: Add cgroup support (v2)
Date:   Wed,  6 Sep 2023 10:48:58 -0700
Message-ID: <20230906174903.346486-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The cgroup support comes with two flavors.  One is to aggregate the
result by cgroups and the other is to filter result for the given
cgroups.  For now, it only works in BPF mode.

* v2 changes
 - fix compiler errors  (Arnaldo)
 - add Reviewed-by from Ian
 
The first one is -g/--lock-cgroup option to show lock stats by cgroups
like below.  The cgroup names were shortened for brevity:

  $ sudo perf lock con -abg perf bench sched messaging
   contended   total wait     max wait     avg wait   cgroup

        1052      3.34 ms     84.71 us      3.17 us   /app-org.gnome.Terminal.slice/vte-spawn-52221fb8-b33f-4a52-b5c3-e35d1e6fc0e0.scope
          13    106.60 us     11.48 us      8.20 us   /session.slice/org.gnome.Shell@x11.service
          12     21.20 us      4.93 us      1.77 us   /
           3     12.10 us      8.80 us      4.03 us   /session-4.scope
           2     10.98 us      7.50 us      5.49 us   /app-gnome-firefox\x2desr-34054.scope
           2      6.04 us      4.88 us      3.02 us   /app-gnome-google\x2dchrome-6442.scope
           1      5.63 us      5.63 us      5.63 us   /app-org.gnome.Terminal.slice/gnome-terminal-server.service
           1      3.51 us      3.51 us      3.51 us   /pipewire.service
           1      2.15 us      2.15 us      2.15 us   /pipewire-pulse.service
           1       742 ns       742 ns       742 ns   /dbus.service

The other is -G/--cgroup-filter option to show lock stats only from the
given cgroups.  It doesn't support cgroup hierarchy and regex matching.

  $ sudo perf lock con -abt -G / perf bench sched messaging
   contended   total wait     max wait     avg wait          pid   comm

           2     10.58 us      8.39 us      5.29 us       257552   kworker/4:1
           2      9.76 us      7.96 us      4.88 us            0   swapper
           4      5.36 us      2.09 us      1.34 us       255462   kworker/0:2
           3      3.33 us      1.48 us      1.11 us       257680   kworker/3:1
           2      2.59 us      1.46 us      1.29 us       257478   kworker/2:2
           1      1.50 us      1.50 us      1.50 us           15   rcu_preempt

You can also use these two options together. :)

The two more test cases were added to the existing lock contention test.

The code is available at 'perf/lock-cgroup-v2' branch in the tree below.

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git


Thanks,
Namhyung


Namhyung Kim (5):
  perf tools: Add read_all_cgroups() and __cgroup_find()
  perf lock contention: Prepare to handle cgroups
  perf lock contention: Add -g/--lock-cgroup option
  perf lock contention: Add -G/--cgroup-filter option
  perf test: Improve perf lock contention test

 tools/perf/Documentation/perf-lock.txt        |  8 ++
 tools/perf/builtin-lock.c                     | 99 ++++++++++++++++++-
 tools/perf/tests/shell/lock_contention.sh     | 45 +++++++++
 tools/perf/util/bpf_lock_contention.c         | 51 +++++++++-
 .../perf/util/bpf_skel/lock_contention.bpf.c  | 48 ++++++++-
 tools/perf/util/bpf_skel/lock_data.h          |  3 +-
 tools/perf/util/cgroup.c                      | 63 ++++++++++--
 tools/perf/util/cgroup.h                      |  5 +
 tools/perf/util/lock-contention.h             | 10 +-
 9 files changed, 312 insertions(+), 20 deletions(-)


base-commit: 45fc4628c15ab2cb7b2f53354b21db63f0a41f81
-- 
2.42.0.283.g2d96d420d3-goog

