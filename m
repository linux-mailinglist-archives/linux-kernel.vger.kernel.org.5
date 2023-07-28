Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFF0766093
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjG1ANB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG1AM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:12:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7099C269E
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:12:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d052f58b7deso1454349276.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690503173; x=1691107973;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pjo35PlF/wWvhS1Cmx8bdMFmFen6pv+m7YZnMKsM5hM=;
        b=Kxi7gcEHRIDlZ8Dkc2GhTzNZ20lYfZCvlq+ldSJviigTVdp0JZgOz5hqDz2Aa+rfvi
         ALuAGwd59azVJCigV88ctSOJRFGTPP4BBeZmqsXtVJHiu8EPgdhC+vGXNffNbbA7hgqk
         ch9Vw/sRFCzPTn5XUWe6FfCeQ5btSOpQNPO+NUm5v+uKBT5PVH+SPSlp1/7oen9+0w2w
         k3RM8rts+l34AAbcdCkYj/0SI/q7OatEGzGM/HC+I4fcH9sd9tJNIiSqVDD7ku8+8viG
         bkmvcEUxK/AocjL1j0qx0gGXFo9PmD6uL+XwQYpa4obRkNKAZhZPCKBbc0//y5EraIMJ
         ZKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690503173; x=1691107973;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pjo35PlF/wWvhS1Cmx8bdMFmFen6pv+m7YZnMKsM5hM=;
        b=eUg2hqAQ5ATHqpnt4b9mVnCQyldnk75xd4Z2CKj+TLQSdn6Xd8VYMe4gHFIcmOllma
         /1c8C1XIb8vAqgf+KaQIHjgr5ShSji3Gv4/mulxInYUXczVJYjDPHEwC/xTab2xt95MY
         klT6DHFHyyOWcYeu5w3hRTdnTnyqyXuM1SX+dP5c0CXGBgMjtRqzLo8mxiRShExoAj3A
         cnw7pox723kxgh4Uep5FbYSiyK7/1ZdrHHrBJ/uiedetTiP5l99kn2j3q8AhOAtmyKiV
         PhxqvYkA07S1B1qK/RaHFnLXOfdA2NNXIeLPMX6UfTRfPK8WAIWGH1sPGmMKHxeNBsaV
         ZzSw==
X-Gm-Message-State: ABy/qLYCgAezNijDtCwGNkIU5ujPzi/QE6eMF0K/KNxZ4nOROa7RP3cc
        5mkqC6TVG0jMVVyMKjYocwKReYcQMvMW
X-Google-Smtp-Source: APBJJlF8HwXtj+YshMZZDcCVKC35WCn7D5t/5BkZSF40yl9o6ZL5PKImCZTzA7ciNPRV+LorQdyG8DubR6So
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3d03:ff18:af30:2dad])
 (user=irogers job=sendgmr) by 2002:a25:37d8:0:b0:c64:2bcd:a451 with SMTP id
 e207-20020a2537d8000000b00c642bcda451mr973yba.7.1690503173648; Thu, 27 Jul
 2023 17:12:53 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:12:09 -0700
Message-Id: <20230728001212.457900-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 0/3] Remove BPF arrays from perf event parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, He Kuang <hekuang@huawei.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Event parsing was recently refactored:
https://lore.kernel.org/all/20230502223851.2234828-1-irogers@google.com/

During these changes I wanted to get coverage of all parts of the
parse-events.y and found that I couldn't test the array code.

The first patch fixes a BPF testing issue.
The 2nd and 3rd patch remove the BPF array event parsing code so that
it isn't adding complexity to event parsing.

Ian Rogers (3):
  perf parse-event: Avoid BPF test segv
  perf tools: Revert enable indices setting syntax for BPF map
  perf parse-events: Remove array remnants

 tools/perf/util/bpf-loader.c   | 101 ---------------------------
 tools/perf/util/parse-events.c |  18 +----
 tools/perf/util/parse-events.h |  10 ---
 tools/perf/util/parse-events.l |  11 ---
 tools/perf/util/parse-events.y | 122 ---------------------------------
 5 files changed, 2 insertions(+), 260 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

