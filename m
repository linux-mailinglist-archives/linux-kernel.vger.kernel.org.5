Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2677957B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbjHKRA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjHKRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:00:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5938030C4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:00:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAAC26320F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 17:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD066C433C7;
        Fri, 11 Aug 2023 17:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691773255;
        bh=jVRqlDNHn1NWUyt5QV1FjlsGmvmBFLA4o68wuA3Uvo8=;
        h=From:To:Cc:Subject:Date:From;
        b=XKkkmSr09BSZQItE5YKIpx3UptQ7tLx3XuP5zxrP6uQ5T6i3TdFcGJ/6Ig3iqcl+X
         l8+2PSMIeTwk/XtdVoItTgX9L7ZPwoV6iHxhhItNVDno0Umyfk8llPe3fMNhhbmP9h
         hrTjMxdUA2i3TP1OBbUk7/ZV1t3coLsP51UlvExsUMCcDjoZ2WmmqE5+3/t/8t8OUX
         S6NBRZYYcLVY1BD4jZX3jFmnVgRnF0U7UlrznTCz5hyGbkB0td/hG1FOEaQiD2Di3E
         zUfEbO/qjtfy3BVsjkmaVWPamds1eTLi4qgC+XXUdl4v/f3NTXq+8/sVYo7IuKfJ2W
         x+fXk00EPP1ug==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 00/10] timers/cpuidle: Fixes and cleanups
Date:   Fri, 11 Aug 2023 19:00:39 +0200
Message-Id: <20230811170049.308866-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first part of the series is cpuidle callback fixes against timers,
some of which haven't been Signed by Peter yet.

Another part is removing the overhead of useless TIF_NR_POLLING clearing.

The rest is comments.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/idle

HEAD: b66dd12bb29cca558b9323f2b270a7dae8f56c48

Thanks,
	Frederic
---

Frederic Weisbecker (8):
      x86: Add a comment about the "magic" behind shadow sti before mwait
      cpuidle: Report illegal tick stopped while polling
      cpuidle: Comment about timers requirements VS idle handler
      cpuidle: Remove unnecessary current_clr_polling_and_test() from haltpoll
      cpuidle: Remove unnecessary current_clr_polling() on poll_idle()
      x86: Remove __current_clr_polling() from mwait_idle()
      x86: Remove the current_clr_polling() call upon mwait exit
      sched/timers: Explain why idle task schedules out on remote timer enqueue

Peter Zijlstra (2):
      cpuidle: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
      loongson: Fix idle VS timer enqueue


 arch/loongarch/kernel/genex.S      | 32 ++++++++++++++++++--------------
 arch/loongarch/kernel/idle.c       |  1 -
 arch/x86/include/asm/mwait.h       | 21 ++++++++++++++++++---
 arch/x86/kernel/process.c          |  1 -
 drivers/acpi/acpi_pad.c            |  1 +
 drivers/cpuidle/cpuidle-haltpoll.c |  5 +----
 drivers/cpuidle/poll_state.c       | 10 ++++++++--
 drivers/idle/intel_idle.c          | 19 +++++++------------
 kernel/sched/core.c                | 22 ++++++++++++++++++++++
 kernel/sched/idle.c                | 30 ++++++++++++++++++++++++++++++
 10 files changed, 105 insertions(+), 37 deletions(-)
