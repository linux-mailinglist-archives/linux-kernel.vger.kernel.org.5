Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB41C7CFBC2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345827AbjJSN4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbjJSN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:56:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD6B0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:56:00 -0700 (PDT)
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697723758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAyla9zbEzBqXnPEaM8zZpPa8/CLifnjpeuStw/HUJ0=;
        b=KPs/2QWrzTSaIlJjHYJ725VeUa+bJujeYRBqScppyHfMYv0181T/uWLbWWRUmV5xD+Xa++
        nhUusnNSM5mDpAMm0bSR5gxtLMKRiagG1fbpaqrKfCaBpJpvkViNNLHAfJ12dlF4jV+yjX
        SNYw8P9bOjErnLLlAXqt9hViPSRwTfD3Sf81OAtaZt9qCGFWqTw+tgLbqaoxUTvLNycMgc
        IfwTz1RJGTqrQ3raaIk53VQlnyYrwrJCSD7d+63rzdfosQkihCG09kkNS2VTxMUImnk+Ym
        GwWhXPRrl3lC1Cd7bN2ruVXLoz1duDSQ9pugk8I3irHP/8gronRPBvHzg7Rh9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697723758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAyla9zbEzBqXnPEaM8zZpPa8/CLifnjpeuStw/HUJ0=;
        b=09pKiW5wUEXoEAJO0AcQ89lDst+MQj0V1KgrkapQy9PUHG8+PeisKwTlfwwWeb77ut8XWh
        1/uR3rLryX+VnjAg==
To:     K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH v8 00/25] timer: Move from a push remote at enqueue to a
 pull at expiry model
In-Reply-To: <28563e2d-6746-e2c4-7d21-4ca39a82edc1@amd.com>
References: <20231004123454.15691-1-anna-maria@linutronix.de>
 <28563e2d-6746-e2c4-7d21-4ca39a82edc1@amd.com>
Date:   Thu, 19 Oct 2023 15:55:57 +0200
Message-ID: <87jzri90nm.fsf@somnus>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Prateek,

K Prateek Nayak <kprateek.nayak@amd.com> writes:

> Hello Anna-Maria,
>
> Happy to report I don't see any regression with this version of series.
> I'll leave the detailed report below.

[...]

> Thank you for debugging and helping fix the tbench regression.
> If the series does not change drastically, feel free to add:
>
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>

Thanks a lot for all the testing you did! When posting v9, I'll
summarize the changes and if required, I'll ask for testing support, if
it is ok?

>> 
>> Possible Next Steps
>> ~~~~~~~~~~~~~~~~~~~
>> 
>> Simple deferrable timers are no longer required as they can be converted to
>> global timers. If a CPU goes idle, a formerly deferrable timer will not
>> prevent the CPU to sleep as long as possible. Only the last migrator CPU
>> has to take care of them. Deferrable timers with timer pinned flags needs
>> to be expired on the specified CPU but must not prevent CPU from going
>> idle. They require their own timer base which is never taken into account
>> when calculating the next expiry time. This conversation and required
>> cleanup will be done in a follow up series.
>> 
>
> I'll keep an eye out for future versions for testing.

I'll keep you in the loop.

Thanks,

	Anna-Maria

