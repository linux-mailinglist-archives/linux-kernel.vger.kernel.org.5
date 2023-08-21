Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F58783581
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 00:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjHUWUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 18:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHUWU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 18:20:29 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C53FD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:20:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so36656355e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692656421; x=1693261221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VcwuxIDWqi7zySJDkuXgYqXHdkQMVuMBWMZbaaDC588=;
        b=qPwDksHT/apYM4Jvja9KqlHNLBgDkFxR+Em5jcqWkunkVhGcI4z9bDHRikk613dh2d
         c1WmiFB+ntsqeuWHUTFAFxyOylUclWW9vrHIq/uWinYw/hZAWWSzeOyFf9iFpsUJNdRb
         F4B5seudrovo7mAiGhBbgeQe+dQu2eTagkhE4cYqsVsd2/4GX9/KaX3rAPZsytFLOcxC
         oLRsoOjx+yFbiIU9BDEgCeFgUjpFXVXAQazWJXK9spiFb5zT1Dib7bADStWbIBcEmyDC
         PeX7L0vheQGnkVCD3hQDF1lLUaDYLeQyRy9eKjs2FPocnq9CR1+sQXc8jaFfu6zHYgrr
         yB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656421; x=1693261221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VcwuxIDWqi7zySJDkuXgYqXHdkQMVuMBWMZbaaDC588=;
        b=B5tXskYwqGvNySjCpufbKwhiyxALVrw8Szw5swDjVefbifRrsHXQ7GqWhfXNBnlz1N
         waTEKRkJ6hvqGOGgajrS2d0avLeHkFH4d1DMkVoDn5J7o7EQyAmdFEap2YSYEgrUM4tr
         WWZi5QpRhn+PZV0CvuGDzypeX3tJq5haoVD2l27CM0fx/s8Vy672J3+jZ4S9SZdqUmVU
         JyZvmcbgjyIY5Az3Ve8lfv/DSFdCbqjyNl2HkiegV0fEk6It9iuOEkkBEDdTWaTeAOtj
         3LEfrLXGclNq5+cl08hgphQLgEl4XUCFcHG1M6V2Zimd5Zt0jR6deMqinyZoqVK6llWu
         Dtfg==
X-Gm-Message-State: AOJu0YwMo6bDqMh+CdhllEvLxQSo5SYUlScEjbpvHnuq9MPdWpO/QN43
        E1cnFIwThkhKQldvbkSu1AGdvA==
X-Google-Smtp-Source: AGHT+IGTmg9P0/0JLewO6rbawb4B/lo1LE5wo9T9du6XptLW/jnw2XjgqAteccXME15yR5c2e8fEXQ==
X-Received: by 2002:a7b:cb88:0:b0:3fe:24df:4180 with SMTP id m8-20020a7bcb88000000b003fe24df4180mr5972002wmi.13.1692656420386;
        Mon, 21 Aug 2023 15:20:20 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fe61c33df5sm17751154wmb.3.2023.08.21.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:20:19 -0700 (PDT)
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
Subject: [PATCH 0/6] Backport rework of deadline bandwidth restoration for 6.4.y
Date:   Mon, 21 Aug 2023 23:19:50 +0100
Message-Id: <20230821221956.698117-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Compile tested against some randconfig for different archs. Only boot tested on
x86 qemu.

Based on v6.4.11

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
 kernel/cgroup/cpuset.c  | 244 ++++++++++++++++++++++++++--------------
 kernel/sched/core.c     |  41 +++----
 kernel/sched/deadline.c |  67 ++++++++---
 kernel/sched/sched.h    |   2 +-
 7 files changed, 246 insertions(+), 128 deletions(-)

-- 
2.34.1

