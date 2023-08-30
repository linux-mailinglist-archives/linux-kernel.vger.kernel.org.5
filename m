Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C4778DFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243268AbjH3TMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242361AbjH3IMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:12:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696521A2;
        Wed, 30 Aug 2023 01:12:35 -0700 (PDT)
Date:   Wed, 30 Aug 2023 08:12:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693383154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f34kCiXmgNtBuK7hahCUdbcDNwHofdNRhJArD8FDyrE=;
        b=nmRM8VRNEVwCU+S6J2QSJ1RdGvjjMSQgQdJlvCmdCHidMT6ISvsdLeDJhqdRNg965UobRf
        o5x36bO9gjXHwe9gutQwJHF7EZj3H2STkAgii3G7L9GwnCxHosffMWS0khIpcZytznJPUM
        +tz1ePyWxovGN4aqjK0/z6yZ7nC+Nh///TnXhDWkVniCSEawnfvt/33in6I+92c3cmjb4/
        gardySxbal6HCke0rwrK6sdGANWXXrQTvwb/VajailFwCNYA1BIYcYYWrzznf91a09X3Qr
        bhcbgWm5/uQLlk/kQQpjt5HQkmVQ27LoENqKYrDnKQQXXaNdIAHzPY1SphW+bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693383154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f34kCiXmgNtBuK7hahCUdbcDNwHofdNRhJArD8FDyrE=;
        b=YChGUCSgrZ0OAjiCqkpeEH4mloMznpXO4UYSIyPMkas4jGCGjdaODckOJ+qRdvMqhxVTz4
        Pu0D7kiaZKUO0EBQ==
From:   "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Report correct state for TASK_IDLE |
 TASK_FREEZABLE
Cc:     NeilBrown <neilb@suse.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <169335025927.5133.4781141800413736103@noble.neil.brown.name>
References: <169335025927.5133.4781141800413736103@noble.neil.brown.name>
MIME-Version: 1.0
Message-ID: <169338315320.27769.8110818359397808973.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0d6b35283bcf1a379cf20066544af8e6a6b16b46
Gitweb:        https://git.kernel.org/tip/0d6b35283bcf1a379cf20066544af8e6a6b16b46
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 30 Aug 2023 09:04:19 +10:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 30 Aug 2023 10:08:38 +02:00

sched/core: Report correct state for TASK_IDLE | TASK_FREEZABLE

task_state_index() ignores uninteresting state flags (such as
TASK_FREEZABLE) for most states, but for TASK_IDLE and TASK_RTLOCK_WAIT
it does not.

So if a task is waiting TASK_IDLE|TASK_FREEZABLE it gets incorrectly
reported as TASK_UNINTERRUPTIBLE or "D".  (it is planned for nfsd to
change to use this state).

Fix this by only testing the interesting bits and not the irrelevant
bits in __task_state_index()

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/169335025927.5133.4781141800413736103@noble.neil.brown.name
---
 include/linux/sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ae6fd76..77f01ac 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1671,7 +1671,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(TASK_REPORT_MAX);
 
-	if (tsk_state == TASK_IDLE)
+	if ((tsk_state & TASK_IDLE) == TASK_IDLE)
 		state = TASK_REPORT_IDLE;
 
 	/*
@@ -1679,7 +1679,7 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
 	 */
-	if (tsk_state == TASK_RTLOCK_WAIT)
+	if (tsk_state & TASK_RTLOCK_WAIT)
 		state = TASK_UNINTERRUPTIBLE;
 
 	return fls(state);
