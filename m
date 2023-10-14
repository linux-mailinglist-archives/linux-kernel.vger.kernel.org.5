Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5623A7C934E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjJNHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:45:28 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69075BF
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:45:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-577e62e2adfso1929335a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697269525; x=1697874325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqzza3fB+lsTu4YDyKGQewlzLBuqykDjZxJnSTk9ygs=;
        b=O22icRODd7YeUQ3NMkgufhsxl+X9aQcr1ZQLQqEAoLgn7zhy2F8gUxcADh7HEnpbaN
         BDNjPpsgMNEGCVkkSNKepZdev+jjuy5WERpN3dVLetXF6YxSnRNFfB2YDxKXXTPBT6uV
         lGdsz1iQswTpiRnmBr1BhlLayVdFMaA1U7pZiKaDIURFHFDttabWiAocm2ivvmUb7gLL
         xUu/WtsN8W7TAS6IKEDh7IMczr6X4YYIoWP3jxqSsfE4mwrX5oi46HadeUqE+ceq05gF
         BZq82u5ujjzzzU1COKg/a9OmrYTVd5sZC+nWeYdvMHnWk2TBj5uZMvP1yb8VtQnQFeao
         eutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697269525; x=1697874325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vqzza3fB+lsTu4YDyKGQewlzLBuqykDjZxJnSTk9ygs=;
        b=TX/P5umqNg0G7lkj8XfQWX0rqzrEHue3ZJnXxnsP9ZugkDAIdEk5JDjcNHLJrT4aGZ
         EinFrzsZHAmmj5Q+K8pZWLEAIcjR0NIglT1o6DoqM7dldtOhcfYe9rSoRDgnYa+bCc1P
         99Wnh+bgOJ79raN6IE9KMtJrOCkNh8lLG+E0bDsHEKv/ckop4e55AGbk1+1ody6R2IJr
         D8f5UnQX/BuxLuXuUgkfGc+71yKlLXbkyddZ3SzDrMR+Y/dQacg5y3opT7NFDMKcRoKF
         h2CTqDOHlulHsKS2RQxP93EzbCmPQlaQOIRjEeDKC5gruVi+kJLYSZY0PVhCrdMYM4+3
         n5fQ==
X-Gm-Message-State: AOJu0YzRkqNdiwrYnc4ieD6OzqJcVl0ehdkKexoK/GQp3Yfe3+UQHulp
        oXiprFxjSLjiH2Zh1PM/lXeztg==
X-Google-Smtp-Source: AGHT+IF4z4Im1nLH/k2ekf0tUd+qFPog23mz/Cdj38aUXoF9RZZSYKa8hP9ec6ysGxLmrBKlb+u/Ww==
X-Received: by 2002:a17:903:2305:b0:1c6:c3f:9dc3 with SMTP id d5-20020a170903230500b001c60c3f9dc3mr28632806plh.54.1697269524823;
        Sat, 14 Oct 2023 00:45:24 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.106])
        by smtp.gmail.com with ESMTPSA id r8-20020a170902be0800b001c3e732b8dbsm4965124pls.168.2023.10.14.00.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 00:45:24 -0700 (PDT)
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
Subject: [PATCH v1 0/2] perf cs-etm: Add support for itrace option 'T'
Date:   Sat, 14 Oct 2023 15:45:11 +0800
Message-Id: <20231014074513.1668000-1-leo.yan@linaro.org>
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

This patch set is to introduce a new itrace option 'T' for forcily use
timestamp trace for kernel time and support this option in cs-etm.

Some Arm platforms (either Arm CPUs prior to Armv8 or miss the FEAT_TRF
feature, currently the ETM driver cannot decide if the timestamp trace
is same with kernel time.  This is why we introduce the itrace option
'T', we leave decision to users so users can specify this option to
forcily use the timestamp trace as the kernel time.

This patch set is tested on Arm Juno board.

Leo Yan (2):
  perf auxtrace: Add 'T' itrace option for timestamp trace
  perf cs-etm: Enable itrace option 'T'

 tools/perf/Documentation/itrace.txt |  1 +
 tools/perf/util/auxtrace.c          |  3 +++
 tools/perf/util/auxtrace.h          |  3 +++
 tools/perf/util/cs-etm.c            | 21 ++++++++++++++++++---
 4 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.34.1

