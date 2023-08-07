Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAC1772974
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHGPjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjHGPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:39:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14F5C4;
        Mon,  7 Aug 2023 08:39:29 -0700 (PDT)
Date:   Mon, 7 Aug 2023 17:39:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691422768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqdnFbl738oR8cRWvn387Yj00aiFEzrIeqig444EZ/I=;
        b=nwDgECVqeVo+Nt9YavO29KbogAZ0wYZhvaz5pLHXcmB6EDfkMmmqlhISwOD5x4bt4QnRea
        23+u8qnltxUkayCY/LpVSv+e7S5zya5fJDbUxeBXdXWnSuT9bdUhCc/PWckuHCkCgFfOJF
        WsH3R36uG9srlR7ruR1tpVkk3kJvepT4AMDuHbxAp5nbrshzUqYnUdF7uteCqQuPzRmVOX
        aHA7c0YqL0JfSssxmnWFIKrL98P6KU1gCsBfXZSBiGUuvz8Tn9dMc9DsJstkSbL4+54ioV
        Ha4ZUz580fNO4QW0NVdFQ76FpCvRMvjoA/mpzk6kIK6z56uUeT3okdzmrZflEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691422768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rqdnFbl738oR8cRWvn387Yj00aiFEzrIeqig444EZ/I=;
        b=+3Czz3yp39UzL8DKlAxuGZ3/MMvrnF+zCo/oxHyBn+jUCF3HwN/Mj/6mQ5Nzu3yrUWq9yC
        iy4Jq8dIIriHHxDw==
From:   Anna-Maria Behnsen <anna-maria@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
cc:     Linux PM <linux-pm@vger.kernel.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFT][PATCH v2 0/3] cpuidle: teo: Do not check timers unconditionally
 every time
In-Reply-To: <e3dc9417-626d-bae2-c016-36e14914c9b8@linutronix.de>
Message-ID: <44a36b57-92cd-e3fd-da1d-367450c76010@linutronix.de>
References: <5712331.DvuYhMxLoT@kreacher> <CAJZ5v0jTG-oqV+misnP-=W5aq0S9X631kW9EhKNEn1VJQqwL2g@mail.gmail.com> <e3dc9417-626d-bae2-c016-36e14914c9b8@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-584093606-1691422768=:1859"
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

--8323329-584093606-1691422768=:1859
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 7 Aug 2023, Anna-Maria Behnsen wrote:

> On Thu, 3 Aug 2023, Rafael J. Wysocki wrote:
> 
> > On Thu, Aug 3, 2023 at 11:12 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi Folks,
> > >
> > > This is the second iteration of:
> > >
> > > https://lore.kernel.org/linux-pm/4511619.LvFx2qVVIh@kreacher/
> > >
> > > with an additional patch.
> > >
> > > There are some small modifications of patch [1/3] and the new
> > > patch causes governor statistics to play a role in deciding whether
> > > or not to stop the scheduler tick.
> > >
> > > Testing would be much appreciated!
> > 
> > For convenience, this series is now available in the following git branch:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  pm-cpuidle-teo
> > 
> 
> Gauthams tests and the distribution of idle time durations looks pretty
> good. Also the prevention of calling tick_nohz_get_sleep_length() is very
> nice (21477 calls of tick_nohz_next_event() and the tick was stopped 2670
> times).
> 
> Here is the deviation of idle time durations (based on your branch):

Sorry, s/deviation/distribution

> Idle Total		2670	100.00%
> x >= 4ms		2537	95.02%
> 4ms> x >= 2ms		19	0.71%
> 2ms > x >= 1ms		10	0.37%
> 1ms > x >= 500us	7	0.26%
> 500us > x >= 250us	6	0.22%
> 250us > x >=100us	13	0.49%
> 100us > x >= 50us	17	0.64%
> 50us > x >= 25us	25	0.94%
> 25us > x >= 10us	22	0.82%
> 10us > x > 5us		9	0.34%
> 5us > x			5	0.19%
> 
> 
> Thanks,
> 
> 	Anna-Maria
--8323329-584093606-1691422768=:1859--
