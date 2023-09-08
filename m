Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEB798AA2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245073AbjIHQXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbjIHQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:23:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA8D1FCD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:23:03 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694190181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qVtF5LabI0Kl8BqhXxdHJ091bczxU1fOJdNCeSMf2YQ=;
        b=JyMVbjRQpaC/YhVyJUM1kQoW3HquvlMpZk0XMzilWlLcZzlmwwSNly5mI0ybzENKlVo8+8
        //XZhfmocBK2NGbP598BV1mR8OEdnLsnuSQkfJRaGwoA85vnmll2BnWaCQI+qzFals3TwA
        /oiWndXf1Fpj964llOUxe+MX++SEuFCFpPSNSqtisqL0kCtxL5v7oKKkWhCF0p9veZdgqJ
        VCwxseBig5u2HiociY/cCg7FknUMUsc+UDurAwmy1VhSmRfLkBxOSW/pjEW97KoAK8AWDa
        +KrSW6pgKzkFm3fwA8aqQpy9ZoCb3vPH0JPBhj2tT9zHdCddMdsAO79/nm+p0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694190181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qVtF5LabI0Kl8BqhXxdHJ091bczxU1fOJdNCeSMf2YQ=;
        b=aja08nMUse//w4SjGgDOFOjdwykKtLI5iTy2rs7MwmIpSunj2BVGu/n7KPr2UNiiOjfJjg
        u13BPjUPrWbghyAw==
To:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc:     bigeasy@linutronix.de, tglx@linutronix.de, boqun.feng@gmail.com,
        bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        jstultz@google.com, juri.lelli@redhat.com, longman@redhat.com,
        mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
        swood@redhat.com, vincent.guittot@linaro.org, vschneid@redhat.com,
        will@kernel.org
Subject: [PATCH v3 0/7] locking/rtmutex: Avoid PI state recursion through sched_submit_work()
Date:   Fri,  8 Sep 2023 18:22:47 +0200
Message-Id: <20230908162254.999499-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

this is the third iteration of the patch series that PeterZ sent.

PeterZ v1: https://lore.kernel.org/all/20230815110121.117752409@infradead.o=
rg/
My v2: https://lore.kernel.org/all/20230825181033.504534-1-bigeasy@linutron=
ix.de/
It contains a range-diff what changed, in brief:
- + include linux/sched/rt.h to get compiled
- rt_mutex_pre_schedule()/post() for rwbase_write_lock().

Now the v3:
- Sultan Alsawaf reported a deadlock in write_lock(). A brown paper back
  later, I replaced rt_mutex_pre_schedule()/post() with
  rwbase_pre_schedule() in rwbase_write_lock().

- The reported futex splat in v2 has been addressed with a trylock. This
  is 7/7.

Sebastian


