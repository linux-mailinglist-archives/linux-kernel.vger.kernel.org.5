Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C548176B5B5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjHANYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjHANYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:24:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4751985
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D30861592
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE704C433C8;
        Tue,  1 Aug 2023 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690896287;
        bh=gi17WKwgWC1yvGrPqagQBV1JsuFx4OzmnPfU0tzhjOs=;
        h=From:To:Cc:Subject:Date:From;
        b=ZrKDSANaiRFMP0aOHzjxabn7HIaX8xWTDBeOTIcsPw5bJX8ogS4WP+BE+g+6ZAld9
         5zNl5zp3Hd5PUoxahbRgmB3hY1e5a0Ca6qDB8RASF5NOHhMfZveg5wWvtXs5HbvLUd
         cG8KOOAEVuSzhneLl+uR4vLoRv71t2mqIIqCNO6Tp4T0vuAGjgB+sj1c8Inln2/Te8
         x9jJN4fPEtB2olcPE2LUN//VKrRUxeiTSGth2pZ1qGTncvhYtciNlwyrSTJbTlwI7+
         mcDyd+9YALri04qhE8ViPLPgjjQTYuc3Tz8PbmIJLIt6YAhPdO3bJFD6UY95sLBMfF
         AqkRr+RI40QNQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: [RFC PATCH 0/6] softirq: Start pushing down the big softirq lock
Date:   Tue,  1 Aug 2023 15:24:35 +0200
Message-Id: <20230801132441.559222-1-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Networking softirqs can take time, holding the execution of block,
tasklets, timers and RCU callbacks.

People fight hard through this big softirq lock, proposing more and
more hacks over the years to deal with the resulting fundamental
unfairness that is not only a problem for RT users.

Here is a proposal for an entrypoint to dealing with that issue in the
long term. The purpose is to adopt a similar journey to the one we took
with the BKL push-down but with timers. Most timers are unrelated to
other softirq vectors, those can simply be tagged with the new
TIMER_SOFTINTERRUPTIBLE flag that makes a callback soft-interruptible.
The others can carry the TIMER_SOFTINTERRUPTIBLE after they get converted
to use appropriate synchronization against other vectors callbacks
(using spin_lock_bh() for example).

Once all timers are dealt with after a few years (famous last words),
they can be handled separately from the softirq infrastructure.

RCU could follow a similar treatment, if we manage to find room for a
flag somewhere...

(Only -RT and x86 are supported for now)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/softirq-preemptible

HEAD: c233aee141ddb78d07b2f7311be38cfc286de654

Thanks,
	Frederic
---

Frederic Weisbecker (6):
      softirq: Turn set_softirq_pending() to reset_softirq_pending()
      softirq: Make softirq handling entry/exit generally available
      softirq: Introduce softirq disabled mask
      x86/softirq: Support softirq disabled mask
      timers: Introduce soft-interruptible timers
      timers: Make process_timeout() soft-interruptible


 arch/Kconfig                   |  3 +++
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/current.h |  1 +
 arch/x86/include/asm/hardirq.h |  1 +
 include/linux/bottom_half.h    |  9 +++++++++
 include/linux/interrupt.h      | 15 ++++++++++++---
 include/linux/timer.h          |  5 +++--
 kernel/softirq.c               | 40 ++++++++++++++++++++++++++++++++--------
 kernel/time/timer.c            | 20 +++++++++++++++++++-
 9 files changed, 81 insertions(+), 14 deletions(-)
