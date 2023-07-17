Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBC3755AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjGQFnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGQFnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:43:47 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E610FD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:38 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7672303c831so395193685a.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689572618; x=1692164618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uuuapjCm4uGRuklqDX8mlQes8ibPwf0zSHbcBhv1+wk=;
        b=YHIL+Q4b3CFfCYm9CihgC3tCGEJLGrMGXdGiZ2Bh6+7eKpxaMZRlVHfornWX0kWU7A
         crgNhpc+tHNK2BD7thw8Dqg2KDc41WFfz0xEmU9W6cWrMoeBgnyCDdJRfwoPsEmE5vOJ
         xcvrFigQLXZiyHn4D4MljNTGqQ7jZ/+Ms9EuulbqKhTTD6T0wixnoPGMZG9kfeMSDeXi
         felWXDFVueNqirjzjSV5jRmTc6FX0+6c9fRO2zfpXGJXVj+6EnwLyq4v0ROcrWb0Pr1R
         HlCNziFKcalhPrTXjhKkbLukviIh3aYFLpseQ9llEWD45v34k6O66ZZZVU1A+mp75msk
         43dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689572618; x=1692164618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuuapjCm4uGRuklqDX8mlQes8ibPwf0zSHbcBhv1+wk=;
        b=NBCul2GEwbjZsqslhK8j5KlY5sZcr4kE6/5zvNFK8qzS+A6CAbHx7T7xqqpYzt84ZR
         oNIAYx8HM+XdBoP4F2TVIBVfWpm+7kKV8Em7/kzNVhP9ZJNnH1USvJ7zGUbMVblRfrEw
         XBDPRmwcgEaWMJld5F2Lg8a7/sJBdOea6V43lC8zZyCjfZ6ie+u7EM/bEbtqEXFkmAVv
         ZlajuywbmhqHzLKQ8iERmj7ns1Vt2wh2C0ovWdZ9zQm74I0ZgBXr8/NWpqKOiFuUZ1/w
         OcWdQBk+EXULd81SweSd/oGo2dZZ7uh8E0c8HSmq63Z5cchoqY6NVWsydofTSuGqCXYc
         eDEQ==
X-Gm-Message-State: ABy/qLYKcXnTS9hNeGItfw2Zyv3hocN+seeLNLS9k38jW5sDRB/dDvcf
        HTTi/7d8EsolgsIuBLUuZD2Rzw==
X-Google-Smtp-Source: APBJJlFXTfi8g5jBhSbeBObDe11usDkfzwOunbCh7CEeZgDBWe4niHoSon7iQk0OGp5W9T40RiM4+w==
X-Received: by 2002:a05:620a:4516:b0:765:a518:c31d with SMTP id t22-20020a05620a451600b00765a518c31dmr14358123qkp.54.1689572617873;
        Sun, 16 Jul 2023 22:43:37 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a17090a2a0e00b00263e59c1a9fsm4625849pjd.34.2023.07.16.22.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 22:43:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        John Garry <john.g.garry@oracle.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, fissure2010@gmail.com
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] arm64: Support Cortex-X4 CPU for Perf Arm SPE
Date:   Mon, 17 Jul 2023 13:43:24 +0800
Message-Id: <20230717054327.79815-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series support Cortex-X4 CPU in Perf Arm SPE.

The Arm64 and tools both include the header cputype.h for CPU part and
MIDR definitions, to de-couple between the tools and the kernel, the
tools doesn't directly use the kernel's header, alternatively, the tools
maintain a copy and sync with kernel's header.

To keep the exact same content between kernel and tools' headers, this
series firstly adds Cortex-X4 CPU part and MIDR definitions in the
kernel header; then the second patch syncs the change into the tools'
header.  The first patch is to support the Cortex-X4 in perf Arm SPE
with the new CPU definitions.

I don't have Cortex-X4 machine in hand, so just verified with
compilation perf tool.


Leo Yan (3):
  arm64: Add Cortex-X4 CPU part definitions
  tools headers arm64: Sync Cortex-X4 CPU part definitions
  perf arm-spe: Support data source for Cortex-X4 CPU

 arch/arm64/include/asm/cputype.h       |  2 ++
 tools/arch/arm64/include/asm/cputype.h |  2 ++
 tools/perf/util/arm-spe.c              | 14 ++++++++------
 3 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.34.1

