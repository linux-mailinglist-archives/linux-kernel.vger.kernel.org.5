Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71C97A2355
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjIOQK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236527AbjIOQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:10:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B1710D9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:10:41 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694794239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sLPP8onuSARsCwSAyYrp8gYtOMK/jw8QlFYWJcq0fcE=;
        b=oRn7XqWnkQnAmaJV6aBUM/oKsxviO5+GNKo1OwPVxanXWOZQHXavRSTuAXYLtBELrBVyin
        +fSBVxmYP4v9GP99Y+xXxsacOyucTbGGoUu59E9yThIhYi34LRERtmbtuBcCq+ojF7WaJe
        ktoyF3D9XsUmQoYtNPEio9KyhXooIIwssu3HV9FnFZIo0TbRD96on/m81OT7H4USqwciY9
        UCFJXWlYGOhk1f2ML35qEisreUNoJFTZrD8N34KUjuu0FfOX9n+736NbpIioa4O3bzPYLj
        rDRE+dn65ghnx2bqxoSljR/n2QSOkCNgD2saOYI+wTfOVHlC0Y/XWUzsb5J5ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694794239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sLPP8onuSARsCwSAyYrp8gYtOMK/jw8QlFYWJcq0fcE=;
        b=mnTcMeZs9Sbv0Bn2wQxLtttoppMBS99jcRXgk8P4ouf0GqPzbxAoCqqrM0uBttSvnPVVMF
        JXkLGdrRh0fmo5BQ==
To:     Peter Hilber <peter.hilber@opensynergy.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Hilber <peter.hilber@opensynergy.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
Subject: Re: [RFC PATCH v2 2/6] timekeeping: Fix cross-timestamp
 interpolation corner case decision
In-Reply-To: <20230818012014.212155-3-peter.hilber@opensynergy.com>
References: <20230818012014.212155-1-peter.hilber@opensynergy.com>
 <20230818012014.212155-3-peter.hilber@opensynergy.com>
Date:   Fri, 15 Sep 2023 18:10:29 +0200
Message-ID: <87a5tn1kp6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18 2023 at 03:20, Peter Hilber wrote:
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1247,7 +1247,8 @@ int get_device_system_crosststamp(int (*get_time_fn)
>  		 */
>  		now = tk_clock_read(&tk->tkr_mono);
>  		interval_start = tk->tkr_mono.cycle_last;
> -		if (!cycle_between(interval_start, cycles, now)) {
> +		if (!cycle_between(interval_start, cycles, now) &&
> +		    cycles != interval_start) {
>  			clock_was_set_seq = tk->clock_was_set_seq;
>  			cs_was_changed_seq = tk->cs_was_changed_seq;
>  			cycles = interval_start;

So the explanation in the changelog makes some sense, but this code
without any further explanation just makes my brain explode.

This whole thing screams for a change to cycle_between() so it becomes:

     timestamp_in_interval(start, end, ts)

and make start inclusive and not exclusive, no?

That's actually correct for both usage sites because for interpolation
the logic is the same. history_begin->cycles is a valid timestamp, no?

Thanks,

        tglx


