Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C708E789F82
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjH0NhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjH0NhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:37:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67FEB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:37:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a520dba33so1923149b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693143427; x=1693748227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fxGmRwFDOPFQ2VNKBgkXhNqTcIAg/eEBzz2KL/VMfQ4=;
        b=qLZ111W4W442a6ooOGzUM1cbV+FmoG1PtWYfNcmvLZNHMZ+S1Pe3QzAPziv/zKmvcd
         HGmEe9NYUdjnAMUFVZEvaO8CcQr1R2pkl3hddzURsk0ho3GLlz90zpAgrpLi9lgbaqHo
         4MRWRbUnieXVTh8DRru2qaPkLGmCYg7aJbBeH2/q0w6LCkldc/FCZJiEWOvbtkD2bUhr
         Gh2mRYFUJZlVOl5pgshjbuiVcdRdrBSc2IPUS4mXdoocrfvpBV2wperkBtIfwC9COw3O
         dRAhAp6lrv4r7oOr+BvJ+JMRpVYmj/0gC4bL++6SePVNdpH+FwvwkvPwPMcS3rLO4v6c
         YYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693143427; x=1693748227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fxGmRwFDOPFQ2VNKBgkXhNqTcIAg/eEBzz2KL/VMfQ4=;
        b=DMKwR4OaeXojkgsYjijVRcRK6pT2SOQ9jgWvTFoJhYKPu9Iky6RLMa8uAKl3ZZJ9q2
         zv9OYRmy+5cbeBFS6VHXoxPvvkHusCkHOWb7Zr6mzjfb7rWNuzYmCjJ3hMIaxbOn2VAk
         yEC9sD5AqweB/yeaz6MJYjdICg+IU7K8FS6Wbz5YthYf0NBt975sJd7O9pKF3y5xuvMt
         f33SN4cHpRGG34rgi05egtt7BuwX/WfplJbKgG3iZiW7nD1eh5DMwmp2JNeVi18Sx5lq
         e2iSO2BRYBId9EqAobB2kmPtRQOby/b0CVbd+uii3w+JG1Gnxu4IG/iatMeX1h360U0Z
         NBXA==
X-Gm-Message-State: AOJu0YxmxG1w0u0xEE6xPNr71Q25z89uIAdHLZ5WAHlJbX1kPlTOwwq6
        AZFT3Ra96jVHCCcTYYOI1O7jLw==
X-Google-Smtp-Source: AGHT+IERYpuwTJTlj0ke5t7pAohCypc8C9ZeCEec+440h7vM7t37OT+xF5GUTjWJ6hrqtpi65H4oqg==
X-Received: by 2002:a05:6a21:329f:b0:10f:be0:4dce with SMTP id yt31-20020a056a21329f00b0010f0be04dcemr30895212pzb.8.1693143427445;
        Sun, 27 Aug 2023 06:37:07 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id e29-20020a63371d000000b00565eb4fa8d1sm5273627pga.16.2023.08.27.06.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 06:37:06 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/2] perf cs-etm: Improve timestamp tracing
Date:   Sun, 27 Aug 2023 21:35:55 +0800
Message-Id: <20230827133557.112494-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is to improve timestamp handling in per-thread mode.

The current code doesn't validate timestamp and always return success for
per-thread mode, for a sane implementation, the first patch is to allow
validation timestamp tracing in per-thread mode.

The second patch is to respect timestamp option "--timestamp" or "-T",
when users set this option, the tool will automatically enable hardware
timestamp tracing in Arm CoreSight.


Leo Yan (2):
  perf cs-etm: Validate timestamp tracing in per-thread mode
  perf cs-etm: Respect timestamp option

 tools/perf/arch/arm/util/cs-etm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.34.1

