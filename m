Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5435C7C934B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjJNHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:42:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C9BF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:42:14 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6b9af7d41d2so268465b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269334; x=1697874134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXxaobQ9K38/gK95bNuK+bvOAZXTWecB5ef3F+VH4sQ=;
        b=Yt7n2HOTqvk4ba2+v+wAwpvjzFtSq7tQJ5of/2XfnH1+EKt9UgHPjmt8sQWlt/3JDV
         ayeAbqFezE0sT6WR8A2Zp0f4tJt5a9uXp3Aby3IooeT2d/2IzG0QBHJbqD6iL3YiAbcT
         kL724o3y9siPdAli/vDa4PS9Y4vQn660lIFyEj+WhUzCwW5kwhg94j0OoAuksme2K+mY
         1ZPNenwOBiCz03sCCtucR+db3jYvJIXRk9oBEEnLtAaspL0/zW7xkxr4VM+sbL9UYf5h
         C87KpIAfPcncBJ21J3NE+ni2CeikwU64K/02WVVDUo8stZvMWKY8wMbQhsmH1zFGH5FT
         nnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269334; x=1697874134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXxaobQ9K38/gK95bNuK+bvOAZXTWecB5ef3F+VH4sQ=;
        b=QJYo/rjTV/z+Ebg/BKJgMNWiTtmdfmv6Ttma0EtmA5hWbGWUvYHUB6MisGG1tzgfeQ
         7YipgrRzggo7inidG7DMPu06jx1KvCxrMKfsl5OlcpLmouItfqjSo+dWL0SVE9LmpybL
         0OV5rNpQmlAi+7acAF82n19iq/ETPmD78w9tbTu7k9bRukrySEE2ZrSxz5A91Fd2zBWL
         nawXl5fSuDSO0NugFKqeQ1pv77ylSS5yNZwWmymSyiq6SoAz2tcJ0GnRZlPf7A7f6tix
         EFIztfN74GUkloCpzZRtu8WvY/m+Do2ML1K3GCqCKyQsdewHidBV6JvGaTu64BxxiU+S
         aV/Q==
X-Gm-Message-State: AOJu0Yzo4wa3zbFWfOai9rgxJZuLTiyIs8AEzVBJFz58VcQz8fvLBn0P
        bz5GHFzopAcN1RPHQ5W8NaQQpA==
X-Google-Smtp-Source: AGHT+IGcVUgx3nU+w0wcZJrjCCPKDU059QOm4igtEbkEJHWclbME3f2cxUe/LO9Opao5s93fynh/Zg==
X-Received: by 2002:a05:6a20:7291:b0:157:b453:dbb9 with SMTP id o17-20020a056a20729100b00157b453dbb9mr31350342pzk.6.1697269333671;
        Sat, 14 Oct 2023 00:42:13 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902b78b00b001c5b8087fe5sm4957319pls.94.2023.10.14.00.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:42:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 RESEND 0/2] perf cs-etm: Improve timestamp tracing
Date:   Sat, 14 Oct 2023 15:41:57 +0800
Message-Id: <20231014074159.1667880-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

This patch set is rebased on the latest perf-tools-next branch, and
tested on Arm Juno board. And added James Clark's review tags.


Leo Yan (2):
  perf cs-etm: Validate timestamp tracing in per-thread mode
  perf cs-etm: Respect timestamp option

 tools/perf/arch/arm/util/cs-etm.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.34.1

