Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3D47F862B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjKXWcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKXWcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:32:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FFF10F7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:32:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D35C433C8;
        Fri, 24 Nov 2023 22:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700865161;
        bh=11MQ+yZzITnqG5iCSLzAR411rSB6tjFg5VyDfzbjJAM=;
        h=From:To:Cc:Subject:Date:From;
        b=XhXhw1f/S1WGDrAxGBXKoFRjkAl3m8ee/Z6PP7+fkqRZHpPw0P1gqNELFuM1dbqSs
         6fa6akfIxfcqRgbU/Pmj46etXPL+xKU6Z6ucguTJEScf7sh48+bXECbUClAwaFCliP
         DSFJvBkAlhezpVWCqnSflQWwxjUHTpadGKfM51138/a38+otC8lpu+3wwmKXL9TbET
         EZcKh68iwwoLw5hpvFBt/LgC4G2GcYm0EGbds/YTx6R/VC1NJfFUzrz8dKuv9weQbF
         k1yztCZeocTb5l7lFX3QCMRsUJFMbojpa+ROwgIn3OBomvPF2oL6ZcMpJD6VZE/g5s
         lLzN914NGjREQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/7] cpuidle: Handle TIF_NR_POLLING on behalf of polling idle states
Date:   Fri, 24 Nov 2023 23:32:19 +0100
Message-ID: <20231124223226.24249-1-frederic@kernel.org>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TIF_NR_POLLING handling against polling idle states (mwait and also
software polling) is a bit messy, with quite some wasted cycles spent
on useless atomic operations. This is a try to consolidate this state
handling from the cpuidle core.

Frederic Weisbecker (4):
  x86: Add a comment about the "magic" behind shadow sti before mwait
  cpuidle: Remove unnecessary current_clr_polling_and_test() from
    haltpoll
  cpuidle: s/CPUIDLE_FLAG_POLLING/CPUIDLE_FLAG_POLLING_SOFT
  cpuidle: Handle TIF_NR_POLLING on behalf of software polling idle
    states

Peter Zijlstra (3):
  x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
  cpuidle: Introduce CPUIDLE_FLAG_POLLING_HARD
  cpuidle: Handle TIF_NR_POLLING on behalf of CPUIDLE_FLAG_POLLING_HARD
    states

 Documentation/driver-api/pm/cpuidle.rst |  2 +-
 arch/x86/include/asm/mwait.h            | 23 +++++++++++---
 drivers/acpi/processor_idle.c           |  3 ++
 drivers/cpuidle/cpuidle-haltpoll.c      |  5 +---
 drivers/cpuidle/cpuidle-powernv.c       | 12 +-------
 drivers/cpuidle/cpuidle-pseries.c       | 15 ++--------
 drivers/cpuidle/cpuidle.c               | 22 +++++++++++++-
 drivers/cpuidle/governors/ladder.c      |  4 +--
 drivers/cpuidle/governors/menu.c        |  8 ++---
 drivers/cpuidle/governors/teo.c         |  8 ++---
 drivers/cpuidle/poll_state.c            | 32 ++++++++------------
 drivers/idle/intel_idle.c               | 24 +++++++--------
 include/linux/cpuidle.h                 |  3 +-
 include/linux/sched/idle.h              |  7 ++++-
 kernel/sched/idle.c                     | 40 +++++++++----------------
 15 files changed, 104 insertions(+), 104 deletions(-)

-- 
2.42.1

