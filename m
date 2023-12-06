Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD033806C67
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377552AbjLFKoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377467AbjLFKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:44:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D212B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:44:12 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:44:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701859451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+kDKxHX12JlyMFJ6Fwr7VrEw2RqXj2PWYxwiKRqpvI=;
        b=Ul2mb0vCslqqLW0F0jUulkrp7u9VjaPLeGrCEjeKWcBnmgASZ3xc5exePNwQcq4LNYvrwS
        2MZtTAE3sKfEH3sJi37VSLfHj9WzFnJKvFaOrLNZioKwxw3sTJrOBcX2HA389PRhWMvVO2
        ghaR7BX2fJaoHWbiSwRBm4IrRqZw/hx+J8F614mkLeD0i/LR+tYGTU3bzx/9ESxIGG61TX
        r+3sDuf58C1mb7+spXANcMPmcaBg4LSlNtAA+yPCDWY79lzXHgNVziVs4HUmLTjUZPB+LU
        zyL8vsmwDtCrd9Nk8l8aqD1t0RMlCRPvKQedkCmup1TdUnXAa7uMT1jPGJyhFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701859451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z+kDKxHX12JlyMFJ6Fwr7VrEw2RqXj2PWYxwiKRqpvI=;
        b=XO4NjLLjGyLR8KCppb3bLn57Aug8GsVWoFB3d5b1Xxc4pOxPwOeuSBJy1pX5RkELGcbb59
        UifM81kGT5J86kDA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 25/32] timers: Add get next timer interrupt
 functionality for remote CPUs
Message-ID: <20231206104409.mcNIiNBs@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-26-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-26-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:47 [+0100], Anna-Maria Behnsen wrote:
> To prepare for the conversion of the NOHZ timer placement to a pull at
> expiry time model it's required to have functionality available getting the
> next timer interrupt on a remote CPU.
> 
> Locking of the timer bases and getting the information for the next timer
> interrupt functionality is split into separate functions. This is required
> to be compliant with lock ordering when the new model is in place.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Please fold the hunk below, it keeps sparse happy.

------->8---------

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 2cff43c103295..00420d8faa042 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2075,6 +2075,8 @@ void fetch_next_timer_interrupt_remote(unsigned long basej, u64 basem,
  * Unlocks the remote timer bases.
  */
 void timer_unlock_remote_bases(unsigned int cpu)
+	__releases(timer_bases[BASE_LOCAL]->lock)
+	__releases(timer_bases[BASE_GLOBAL]->lock)
 {
 	struct timer_base *base_local, *base_global;
 
@@ -2092,6 +2094,8 @@ void timer_unlock_remote_bases(unsigned int cpu)
  * Locks the remote timer bases.
  */
 void timer_lock_remote_bases(unsigned int cpu)
+	__acquires(timer_bases[BASE_LOCAL]->lock)
+	__acquires(timer_bases[BASE_GLOBAL]->lock)
 {
 	struct timer_base *base_local, *base_global;
 

Sebastian
