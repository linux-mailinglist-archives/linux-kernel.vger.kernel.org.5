Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA26F77296F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjHGPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjHGPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:38:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204E8BD;
        Mon,  7 Aug 2023 08:38:37 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691422715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8gXw28Rp0mMrJEUhB/kKjewz2rdG+p8v2WZO5btGqk=;
        b=h4l+d+nsasJB11pMYv2PFS8UVaI/eYIwYlWrXA9l4CTpxDL0XVmWTtfRRIg/KVeg8ehur7
        3Ma8Tm4NNPPQPJTa8AVPzGdSJr+jAsycWTXUbChtPyzIF/hAc5YCljiIGa0jGs1vJmdtVs
        u0Kwjq8cdipV+IV5msyC/kn78e5D/vjWJ05VLXywNamjDArMwaW5C3hc1EHiRBOhzHgJzo
        PhQhyZZvUQ0mlsuqT/XxKkJcRiBXzFMliX6MZXBGXd5pRkoL1ahx6Y03oZ7OeZykNKZi8a
        dAOXfBNEupVRq9/vDjY2JhGVXJmeOONXNVJvAogHpD8Cfz73JrnVJ1RMItwkbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691422715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8gXw28Rp0mMrJEUhB/kKjewz2rdG+p8v2WZO5btGqk=;
        b=kg8fg/UTIZOShMWbVmm9xXpQkN7KHrpej4SkIOQIP+OjbUB/xnL3vYfLFoj3kvepwMjd9n
        5mdaianJWA5zBgBQ==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers unconditionally
 every time
In-Reply-To: <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
Message-ID: <e3dc9417-626d-bae2-c016-36e14914c9b8@linutronix.de>
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-956484182-1691421535=:1859"
Content-ID: <5afcbb2f-5f12-5e79-e1c-14e1dc13ee62@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-956484182-1691421535=:1859
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <8c6bc3a-399a-3390-ecc0-84cd9b5b12f5@linutronix.de>

On Thu, 3 Aug 2023, Rafael J. Wysocki wrote:

> On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > Hi Folks,
> >
> > This is the second iteration of:
> >
> > https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> >
> > with an additional patch.
> >
> > There are some small modifications of patch [1/3] and the new
> > patch causes governor statistics to play a role in deciding whether
> > or not to stop the scheduler tick.
> >
> > Testing would be much appreciated!
> 
> For convenience, this series is now available in the following git branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  pm-cpuidle-teo
> 

Gauthams tests and the distribution of idle time durations looks pretty
good. Also the prevention of calling tick_nohz_get_sleep_length() is very
nice (21477 calls of tick_nohz_next_event() and the tick was stopped 2670
times).

Here is the deviation of idle time durations (based on your branch):

Idle Total		2670	100.00%
x >= 4ms		2537	95.02%
4ms> x >= 2ms		19	0.71%
2ms > x >= 1ms		10	0.37%
1ms > x >= 500us	7	0.26%
500us > x >= 250us	6	0.22%
250us > x >=100us	13	0.49%
100us > x >= 50us	17	0.64%
50us > x >= 25us	25	0.94%
25us > x >= 10us	22	0.82%
10us > x > 5us		9	0.34%
5us > x			5	0.19%


Thanks,

	Anna-Maria
--8323329-956484182-1691421535=:1859--
