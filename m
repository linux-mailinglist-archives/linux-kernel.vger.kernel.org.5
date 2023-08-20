Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4337D781E82
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjHTPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjHTPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:25:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F8449D
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:24:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31768ce2e81so2268333f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692545066; x=1693149866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TK555uHCst9oQmvkd3McRBjvZbo0q+tfOD4sf3AzsfM=;
        b=dFp6Pki6lvfmOuTcHpoH0HRKt3dxycOuRkBLc0wkyKBh7yrau69puh0mXYciWBtNhb
         PhW9TLxypWWx0zmT4j6dg6nnOpA+rWW6/nuNwJA5TOb5IRkU3BhBLf7mVhbxuugA54YM
         MZT/e54rzwkjuRm8mIioxlzJf5BrdrMYiJEruzC3HkoqnI7ACDAkoN8v8H89JizsFD4b
         rtx2+gyEWLj3nV+tXWVuYhXw6yarr/D/we9Wi0OClPsd4bUgis7BkOMRY/Z7zivgLpTX
         oL7iGgjruAcNHKuU5ewKsjuo1isX9iJ2MEkGBlObRinRikkBngXTWpsQWaW1PiQtSYyD
         q14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692545066; x=1693149866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TK555uHCst9oQmvkd3McRBjvZbo0q+tfOD4sf3AzsfM=;
        b=CgSQlMITe8NVyOLnsFDgEfoKmeIElNx1nED450K/Ayj1CG3PNjQ6+d3yCWxFkzOiyR
         76zgzDD1T+PMKvScKRnRBBZo7j/sO1LYvOz+cTstM9/F46yYBVg+N4G0gKvaR2kIab+o
         NeTZSbY1BthoTsD4JotWhG3SCtj7x/XBznpqM7Z9oUYhkwZSe2bz00vCqucvafI/rN89
         zx12NJL8I9l+5jHX0b9yKzfWOZ2noobz1ftlsHy+die2qxSooRV3oKecDGpDcKx9vFyG
         vqBD4c2efxRIVk/3Pj9tcgeHI3kgqxhIw+daeCubtw/VujNpLSr4O8ikDDKxuqEUwlB2
         X2ew==
X-Gm-Message-State: AOJu0Ywn+NYxPZspt0Q6HpELA8TqsWLbmQjC3I3aBSTAbAJ94Nz5iQO7
        lnB0QDWSbhG9V09y0VAKbAKP7Q==
X-Google-Smtp-Source: AGHT+IHTJ0uHwuQfeABnNnevxeNyCEuvGJaEotUHth1xnQ5IAKBMQIIhvBlkxxCTRROVlPv7pm1KEQ==
X-Received: by 2002:a5d:4904:0:b0:317:4cf8:35f9 with SMTP id x4-20020a5d4904000000b003174cf835f9mr2998385wrq.16.1692545066086;
        Sun, 20 Aug 2023 08:24:26 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d4fcb000000b003141e629cb6sm9419257wrw.101.2023.08.20.08.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:24:25 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 0/6] Backport rework of deadline bandwidth restoration for 6.1.y
Date:   Sun, 20 Aug 2023 16:24:11 +0100
Message-Id: <20230820152417.518806-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a backport of the series that fixes the way deadline bandwidth
restoration is done which is causing noticeable delay on resume path. It also
converts the cpuset lock back into a mutex which some users on Android too.
I lack the details but AFAIU the read/write semaphore was slower on high
contention.

Compile tested against some randconfig for different archs and tested against
android14-6.1 GKI kernel.

My testing is limited to resume path only; and general phone usage to make sure
nothing falls apart. Would be good to have some deadline specific testing done
too.

Based on v6.1.46

Original series:

	https://lore.kernel.org/lkml/20230508075854.17215-1-juri.lelli@redhat.com/

Thanks!

--
Qais Yousef

Dietmar Eggemann (2):
  sched/deadline: Create DL BW alloc, free & check overflow interface
  cgroup/cpuset: Free DL BW in case can_attach() fails

Juri Lelli (4):
  cgroup/cpuset: Rename functions dealing with DEADLINE accounting
  sched/cpuset: Bring back cpuset_mutex
  sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
  cgroup/cpuset: Iterate only if DEADLINE tasks are present

 include/linux/cpuset.h  |  12 +-
 include/linux/sched.h   |   4 +-
 kernel/cgroup/cgroup.c  |   4 +
 kernel/cgroup/cpuset.c  | 246 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 +++----
 kernel/sched/deadline.c |  67 ++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 246 insertions(+), 130 deletions(-)

-- 
2.34.1

