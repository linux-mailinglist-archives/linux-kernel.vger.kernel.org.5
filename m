Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8B8085E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjLGK1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGK1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:27:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0164313D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 02:27:14 -0800 (PST)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701944833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7ZjGWcJgb+uztqtM66PdF8Y8tzrLNMo8NNctRBhZoQ=;
        b=zhImG8X6xj5P8hj792OVcJD6SpRgzNyRZckxT6IHOMilz+msh63h3PMJIZPV62ff13UGIw
        ujxqMdpxPY+hMQdyOxL0q1pxQnR6DmsZZ4gXrG7LZPvfWV6DVYOlgCo8c46r/qSwe+g/Cm
        uhs1Kql9eubbacsfLWYgsC6qCn8r/nBldkdg7ClZLONoGOaNJUGjQoHi3cXz+csiqT3d2h
        EW1R/HNcdxOIGq3iUwN8026Cx391JZOQM/UQEoEHUPhDYqIDUVNd8zSctG2jIotsYKFje8
        j7L3PPY7M5F/vF/yUVvaJHUKepOiAVjkEk2P6BDfebqV0HD1O6N5gxhxkw6uWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701944833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D7ZjGWcJgb+uztqtM66PdF8Y8tzrLNMo8NNctRBhZoQ=;
        b=WDvu/RKAZcokwrlhEYtLuMjXWyQitsUV9LtVawgXz8xIlF2/e6Ob4XZfc7kknDeVBbtDV9
        sdsrpLPNG0hPdvAQ==
To:     Sebastian Siewior <bigeasy@linutronix.de>
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
In-Reply-To: <20231206104409.mcNIiNBs@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-26-anna-maria@linutronix.de>
 <20231206104409.mcNIiNBs@linutronix.de>
Date:   Thu, 07 Dec 2023 11:27:12 +0100
Message-ID: <87cyvi8fzz.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Siewior <bigeasy@linutronix.de> writes:

> On 2023-12-01 10:26:47 [+0100], Anna-Maria Behnsen wrote:
>> To prepare for the conversion of the NOHZ timer placement to a pull at
>> expiry time model it's required to have functionality available getting the
>> next timer interrupt on a remote CPU.
>> 
>> Locking of the timer bases and getting the information for the next timer
>> interrupt functionality is split into separate functions. This is required
>> to be compliant with lock ordering when the new model is in place.
>> 
>> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
>
> Please fold the hunk below, it keeps sparse happy.

Thanks, I will do!

	Anna-Maria

