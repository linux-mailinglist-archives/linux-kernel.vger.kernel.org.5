Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C20767D41
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjG2Ioi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 04:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjG2Iog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 04:44:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF10130;
        Sat, 29 Jul 2023 01:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=/WBUqBKlZCcgIkihfK24/SSF4pz1v//Vy8IKpbv82rg=; b=YoH/UG4qEoY0Movq+F4o+2RRe1
        prgXGOYaHb+43cM7KMOO/EjoCezsNGiLmRqxVqVDHmj6/Kn+qliqvpBx0eXKk2pkj4V9Uhf8lC6jQ
        9LEW+BBchXHg8mo5Np65YPM93V9PG9SgWamRpyEj+5MX8NZ8L/FkSTc0YVzMkBJ6fGS1g/BeJLaGW
        Uft7BTpqYEoNCkHAgsEDmMNDklRq92D/prpbSqlV+NFihwsTndLsG5C8BJCiLJcK2xdnRfxvMI1E1
        SG+OEITFGpjUFks39TZS/MOf54lKfus7PL3HUIPoMw8DrfOSi5//cXOsP49Cc/VK/rpAdxbYSahNS
        AfZhmxzg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qPfYg-0092NC-28;
        Sat, 29 Jul 2023 08:44:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A571F3002CE;
        Sat, 29 Jul 2023 10:44:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 808DB202C39FE; Sat, 29 Jul 2023 10:44:17 +0200 (CEST)
Date:   Sat, 29 Jul 2023 10:44:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     anna-maria@linutronix.de, tglx@linutronix.de, frederic@kernel.org,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Subject: Re: [RFC][PATCH 1/3] cpuidle: Inject tick boundary state
Message-ID: <20230729084417.GB3945851@hirez.programming.kicks-ass.net>
References: <20230728145515.990749537@infradead.org>
 <20230728145808.835742568@infradead.org>
 <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gNqEuqvV0RtrXiDDGtvKB2hronLwAU8jnmuGppKmyDxA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:36:55PM +0200, Rafael J. Wysocki wrote:
> On Fri, Jul 28, 2023 at 5:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > In order to facilitate governors that track history in idle-state
> > buckets (TEO) making a useful decision about NOHZ, make sure we have a
> > bucket that counts tick-and-longer.
> >
> > In order to be inclusive of the tick itself -- after all, if we do not
> > disable NOHZ we'll sleep for a full tick, the actual boundary should
> > be just short of a full tick.
> >
> > IOW, when registering the idle-states, add one that is always
> > disabled, just to have a bucket.
> 
> This extra bucket can be created in the governor itself, can't it?

I couldn't find a nice spot for the governor to add idle-states.

