Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E86805DC4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjLES2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbjLES2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:28:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A59A1B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:28:40 -0800 (PST)
Date:   Tue, 5 Dec 2023 19:28:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701800918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8MAQ1Emi2jCjaoH7WqvjyWqWAD8pvizcprsR94furY=;
        b=wAnEGkLNxkgpsPtvpE6ydat8g9JO/jw4ewJg2IGs5CIkL8FDnGSmCOrO5TU0VH9hGt+be3
        rxJktjw+rySLmBODnMT5UCj2MJ8PiVxBZh4XvzmRFbDk2l3X6D37f9LOe0CrMzzKRLkh8+
        QJAJY4nzilwQH2ezfRSLJU4Y/R6OGO8JxSXbezdRP0MNF0MHkubugK6ZJl6BVjqiu9+12O
        bLVdjH18ysFs1dy6eMxAp3AzrZNlolYUBMz9rLBbOf3aKlsk0Yr1M54zy4MG+7GoWo80ny
        pikDLFMBo63xUsl5TJi8s6X1bw0YVTMypGmbVnw/Fvm7FdXsTd+6mRuJ+EyvnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701800918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8MAQ1Emi2jCjaoH7WqvjyWqWAD8pvizcprsR94furY=;
        b=SfVCePc2VbLAsNakDeRV2UICQjTkhaqXmyFKXaEwpqE/QmVPV4lmp2BUGInpGqIn2wm9qy
        M3sdXivOFznfXkDA==
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
Subject: Re: [PATCH v9 17/32] timers: Introduce add_timer() variants which
 modify timer flags
Message-ID: <20231205182835.DNCNokiI@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-18-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-18-anna-maria@linutronix.de>
X-TUID: CbN7IBXSeobx
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:39 [+0100], Anna-Maria Behnsen wrote:
> Timer might be used as pinned timer (using add_timer_on()) and later on as
> non pinned timers using add_timer(). When the NOHZ timer pull at expiry
> model is in place, TIMER_PINNED flag is required to be used whenever a
> timer needs to expire on a dedicated CPU. Flag must no be set, if
> expiration on a dedicated CPU is not required.

Slightly reworded.

| A timer might be used as a pinned timer (using add_timer_on()) and later
| on as non-pinned timer using add_timer(). When the "NOHZ timer pull at
| expiry model" is in place, the TIMER_PINNED flag is required to be used
| whenever a timer needs to expire on a dedicated CPU. Otherwise the flag
| must not be set if expiration on a dedicated CPU is not required.

> add_timer_on()'s behavior will be changed during the preparation patches
> for the NOHZ timer pull at expiry model to unconditionally set TIMER_PINNED
> flag. To be able to reset/set the flag when queueing a timer, two variants
> of add_timer() are introduced.

and here.

| add_timer_on()'s behavior will be changed during the preparation patches
| for the "NOHZ timer pull at expiry model" to unconditionally set
| TIMER_PINNED flag. To be able to clear/ set the flag when queueing a
| timer, two variants of add_timer() are introduced.

I let you be judge of this.

Sebastian
