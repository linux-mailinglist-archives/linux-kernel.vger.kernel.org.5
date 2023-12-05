Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90AC805DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjLES3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjLES3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:29:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9951B9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:29:37 -0800 (PST)
Date:   Tue, 5 Dec 2023 19:29:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701800976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySmI1BlCATAwtUlHx5ZUGUPowYOnS+FxgNwcQP+uqBM=;
        b=ji+cR+dTTqrxcSIyfB6S2TBPOt/yFP3/3IeyCaR53TP/eN+k2XaOS9uvGSGoWbA2FuRPqY
        Vg1yRHlxsw+FER8tp0fO3/fVdyo6PaYNizqWBE+KbHPZcx2DwzBcASE4o9xPVAq9Oql6Vf
        YjbDICgVrzwjEkWCl9g6DQuMSoJc+BPq9lJmEnfX7f61suSV1fmHqxnzvOWUmuncDGwAGA
        2vDeh55ByWzYz24JZ67khXQOmXbv64eV0ZwO9sz6MrTub6PIKcyrwy6xkbDtaUraL2AyKK
        Ua1yh/ZiRtMPJwNwV6SSBwEDZliRVUnjaSas5Ac5SJPI2kFZTGaC1/f+mzvYyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701800976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySmI1BlCATAwtUlHx5ZUGUPowYOnS+FxgNwcQP+uqBM=;
        b=gK3tU4iystBXbfW6gOoD/93G93dtIkOcfwfAu6YHE63d9as46fusVR/mAV9JQwrr9IEcVw
        lWNR5esVyrVgAqDg==
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
Subject: Re: [PATCH v9 21/32] timers: Split next timer interrupt logic
Message-ID: <20231205182934.Qhc0WRGy@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-22-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-22-anna-maria@linutronix.de>
X-TUID: FnWDwtAIYOql
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:43 [+0100], Anna-Maria Behnsen wrote:
> Logic for getting next timer interrupt (no matter of recalculated or
> already stored in base->next_expiry) is split into a separate function
> "next_timer_interrupt()" to make it available for new call sites.

Be authoritative.

| Split the logic for getting next timer interrupt (no matter of recalculated or
| already stored in base->next_expiry) into a separate function named
| next_timer_interrupt(). Make it available to local call sites only.

> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Sebastian
