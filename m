Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5270E806CD4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377839AbjLFK6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377508AbjLFK6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:58:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C99C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:58:10 -0800 (PST)
Date:   Wed, 6 Dec 2023 11:58:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701860288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0BPpnkeIBWztkssLgKJ5OKX3kt+/0R/h8JTeiGvo70=;
        b=3RGXAT0wefHrWBk6g5pfEh8YMH7owzQNQFu133LvqHw/K5zZ04q7WbM8F3S8mamBO22gns
        Km+cmDK7TeTCfx9smjPuxFq05RuoeeTalOvuZ4+5/YxVjkWxiHOyqCpoJM7BRbh0iLk4My
        hJi9HTsqSz7rnpdd2ZW4gSIaIxM36XrbXRbVt9gKbF+Bu/wwLv0NtFEPCPV+Of6rxo+iuu
        xrJAdOI7+X47vha5nn2c67HaBj92unsIEUNAa2R5Y5QqzrDlC39irwf+YMqtQYMH5E1VP4
        JljM27RMpMX/+y7wvOhloy5XfytCvwozKZ0mBdkkZo3I1mYzVj1sh+NyX2T9Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701860288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0BPpnkeIBWztkssLgKJ5OKX3kt+/0R/h8JTeiGvo70=;
        b=5mE8OU0hgpYwCEwq27o8MAoYyMm+F86TFPOuKD9uh3zYLxTAsMRPW0Cukf9+ZjB675ucBD
        /oZxrq/tRdv2qNDg==
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
Subject: Re: [PATCH v9 27/32] timers: Check if timers base is handled already
Message-ID: <20231206105806.e4A02OHA@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-28-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231201092654.34614-28-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:49 [+0100], Anna-Maria Behnsen wrote:
> Due to the conversion of the NOHZ timer placement to a pull at expiry
> time model, the per CPU timer bases with non pinned timers are no
> longer handled only by the local CPU. In case a remote CPU already
> expires the non pinned timers base of the local cpu, nothing more
                                                  CPU

so it is consistent with the other.

> needs to be done by the local CPU. A check at the begin of the expire
> timers routine is required, because timer base lock is dropped before
> executing the timer callback function.
> 
> This is a preparatory work, but has no functional impact right now.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Sebastian
