Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9661788D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344043AbjHYQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjHYQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:42:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979F92121;
        Fri, 25 Aug 2023 09:41:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68bed286169so1043812b3a.1;
        Fri, 25 Aug 2023 09:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692981718; x=1693586518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FW4E+AM7YfY1SfwCvaK4TvyMvmZxYdEKJUfQGWCuPjs=;
        b=nO1w4DJNHgyLYN+YaD2UH1IU6QsEOHPw+OcMe40j0TSIrzFaDNU25vWWX4csZVlYcN
         EKZlbArr9MKOdcCzrJwmkGbD0ujewuWri1rneVPwUZa+qQh8JCbgOK3+P+UNQn7hNnkc
         b/0kauIQgro4FVCMvVeoMzRT3tS8ngyu3pRoj9UA0Yuy0IH+6vAwQtMkMhQPyXphZuyv
         o3/s8rBICYtouECK7KdaJOwxp0fSgMZINTpK75C0srYFeitinC8ZuzwJcsUustNuNs9u
         M1M4VHfJVZaS0V5k6norBY2xiX1/Q1pj42tFr+KWRGsRBbuJ7Q34qx4+QnR9yCxxDFYJ
         lGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981718; x=1693586518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FW4E+AM7YfY1SfwCvaK4TvyMvmZxYdEKJUfQGWCuPjs=;
        b=TPWxV05K49lAnl2fdfxQy3w/rJur8EzsoIZ+KySKrbWeHN429k1/x84RSpFfveoOwT
         Y4L/SpeQvVOMOYFlmKs3lE1AcEvMeF60DvckI4Ye0+Z9oXUQLoVsizc4Uzy+Eit22qnD
         I6WfVIqAKHiU/AOGZ8CWns0FlL76CGn+/qAv2s3MoyX40qZoO3cbJcxHlQIOA/HEsB00
         GCry0jtcHo8GMo35WGqeNwAadwuZHHvsohb4fCjV4RK05Ok60EiJOTtCrmB5JoNghoSp
         928jRdVsa7WwQeEPjew53QLWRyd+KOlhw03aUUZ7dZIEX5Z92z7I/hvxHBZ3YKyvzfFD
         gxTg==
X-Gm-Message-State: AOJu0YwK4cWPA83BW/xPOJkRjRl6m+zl6/x9sN9bM4tBxkzYu4FM5hHj
        pLvPsz11ZhBh8TD8OLLJqlIH9hzvgB8=
X-Google-Smtp-Source: AGHT+IH76Uy9dWfkzhunLc6Inzv3riPINmhk+8c2nZQNB9rYOK3YNOq3x/747NYqsfjgA52CB0xHsA==
X-Received: by 2002:a05:6a20:ceaf:b0:147:e55f:ccf3 with SMTP id if47-20020a056a20ceaf00b00147e55fccf3mr19396079pzb.47.1692981717962;
        Fri, 25 Aug 2023 09:41:57 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:a7ba:1788:3b00:4316])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b001a5fccab02dsm1938755plh.177.2023.08.25.09.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 09:41:57 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH 3/3] perf test: Enhance perf stat cgroup BPF counter test
Date:   Fri, 25 Aug 2023 09:41:52 -0700
Message-ID: <20230825164152.165610-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230825164152.165610-1-namhyung@kernel.org>
References: <20230825164152.165610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has system-wide test and cpu-list test but the cpu-list test fails
sometimes.  It runs sleep command on CPU1 and measure both user.slice
and system.slice cgroups by default (on systemd-based systems).

But if the system was idle enough, sometime the system.slice gets no
count and it makes the test failing.  Maybe that's because it only looks
at the CPU1, let's add CPU0 to increase the chance it finds some tasks.

Fixes: 7901086014bba ("perf test: Add a new test for perf stat cgroup BPF counter")
Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index a74440a00b6b..e75d0780dc78 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -60,7 +60,7 @@ check_system_wide_counted()
 
 check_cpu_list_counted()
 {
-	check_cpu_list_counted_output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
+	check_cpu_list_counted_output=$(perf stat -C 0,1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
 	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
 		echo "Some CPU events are not counted"
 		if [ "${verbose}" = "1" ]; then
-- 
2.42.0.rc1.204.g551eb34607-goog

