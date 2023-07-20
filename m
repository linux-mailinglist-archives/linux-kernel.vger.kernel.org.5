Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179CA75B064
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGTNv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGTNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:51:56 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E031FC8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:51:51 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668704a5b5bso709437b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689861110; x=1690465910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXSLhAf39ywnScbmnhUoNCy7kFUzY0ELotpofi8TE5U=;
        b=D3+J1Yn1+oN7iuHEQFcdEwrOcaGE9JOdjW/Hxv4MDNhJcvvM5sYZkkTba3DnvsqtU8
         cqVc0jFG+k0/ItS+PfskCaXWDZtoualQxOQlD1pshPlpJdThRy7Vxgar+Qptw+PdK7TU
         uiHHnIXyolAVg1qQTAyZp9MO5Weaf2pyOB+m0aBZTEg2o/zRIC+hyUG6kXztXgVzCv4M
         nKxfLo+XAX8mqtBm33vPfiU8+28JUKCqq8l+D8FIXpyn4hIdX0SSBgnxiSudYTd4iisz
         xaGl8/9nmExGOS56wNW85e8qGWyYsAKTDUxtaQHRy1ZZxgPs97BbJe2XIJ+LU1Oiz8xd
         VEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689861110; x=1690465910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXSLhAf39ywnScbmnhUoNCy7kFUzY0ELotpofi8TE5U=;
        b=gLUa6byJeeZ74H9jaFPHgEU8n161mrPZSHQfvRH5Vs7XaBdHmq9od7oLpS5EDZThMF
         WCDpl80gcMSYtBHtaLvFo3IUq8A6rK46wF58f8+lsB7E1yfkpea7Xo/XBoYFJOPaXvxj
         SfzfBNUpzYGiDy7GGoecm9UGukK0k3kd6rAF77ndKg2FQsAYvN8ABglj0wkxecCHbq9R
         A354hPtFLzxYPzUjjE+0H8n/6B3NSKR5KrEyAIGXeiVRLdEmdfMgwpgjs0/6GJ5u96GH
         f/XMJdNa2M53OCNkJpL+DDBC8jj6lIcm46rZMMPGFRPRv/zrUItWSipbKklN2cP0+SXd
         EYLg==
X-Gm-Message-State: ABy/qLbv65jn6D3kYc77ySnzwWuJ5JEI6uYH/OHyWtWy9kvrvWAbFteZ
        MhZPG4qO/u6ln9fOMe+Kxm5Tww==
X-Google-Smtp-Source: APBJJlE/slAz3uyMZ8L7/7wp/jRvf4X8awMBqdrGa+1oT4Y+YdCDFXF2MFPhc2ilfywHh7n6Sxnihg==
X-Received: by 2002:a05:6a20:12cf:b0:137:8036:ab93 with SMTP id v15-20020a056a2012cf00b001378036ab93mr4425186pzg.40.1689861110312;
        Thu, 20 Jul 2023 06:51:50 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id j18-20020aa78d12000000b00679fef56287sm1197529pfe.147.2023.07.20.06.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:51:49 -0700 (PDT)
From:   Eric Lin <eric.lin@sifive.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        will@kernel.org, mark.rutland@arm.com, tglx@linutronix.de,
        peterz@infradead.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     zong.li@sifive.com, greentime.hu@sifive.com,
        vincent.chen@sifive.com, Eric Lin <eric.lin@sifive.com>
Subject: [PATCH v2 0/3] Add SiFive Private L2 cache and PMU driver
Date:   Thu, 20 Jul 2023 21:51:18 +0800
Message-Id: <20230720135125.21240-1-eric.lin@sifive.com>
X-Mailer: git-send-email 2.40.1
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

This patch series adds the SiFive Private L2 cache controller
driver and Performance Monitoring Unit (PMU) driver.

The Private L2 cache communicates with both the upstream L1
caches and downstream L3 cache or memory, enabling a high-
performance cache subsystem. It is also responsible for managing
requests from the L1 instruction and data caches of the core.

The Private L2 Performance Monitoring Unit (PMU) consists of a
set of event-programmable counters and their event selector registers.
The registers are available to control the behavior of the counters.

Changes since v1:
 - Rebased on Linux-6.5-rc2
 - Change pl2 cache compatible string to lowercase
 - Add cpuhp_remove_state() after pl2 cache driver probe fail
 - Return 0 instead of return ret at the end of sifive_pl2_cache_init()
 - Cut down the pl2 cache config log lines in pl2_config_read()
 - Sorting the variable by types in sifive_pl2_cache_dev_probe()
 - Change the error message when failing to find the CPU node
 - Add pl2 PMU driver to support per-task profile
 - Move the pl2 PMU driver implementation to the drivers/perf folder
 - Keep only one pl2 cache compatible string suggested by Krzysztof and Conor
 - Addressed Krzysztof's and Conor's comments on DT binding

Eric Lin (2):
  dt-bindings: riscv: sifive: Add SiFive Private L2 cache controller
  soc: sifive: Add SiFive private L2 cache driver

Greentime Hu (1):
  soc: sifive: Add SiFive private L2 cache PMU driver

 .../bindings/cache/sifive,pl2cache.yaml       |  62 ++
 drivers/perf/Kconfig                          |  10 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/sifive_pl2_pmu.c                 | 602 ++++++++++++++++++
 drivers/soc/sifive/Kconfig                    |   8 +
 drivers/soc/sifive/Makefile                   |   1 +
 drivers/soc/sifive/sifive_pl2.h               |  29 +
 drivers/soc/sifive/sifive_pl2_cache.c         | 202 ++++++
 include/linux/cpuhotplug.h                    |   1 +
 9 files changed, 916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/sifive,pl2cache.yaml
 create mode 100644 drivers/perf/sifive_pl2_pmu.c
 create mode 100644 drivers/soc/sifive/sifive_pl2.h
 create mode 100644 drivers/soc/sifive/sifive_pl2_cache.c

-- 
2.40.1

