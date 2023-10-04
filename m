Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790A27B7C84
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjJDJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242069AbjJDJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:44:02 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B50CFA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bC4URj9HssgP3HuoZwUSqV1NBIXkZYdW64Lwc9hHIho=; b=Gqbdwf67CniLERE4c8IGtyLqqO
        ilZAB+7PVrKb8/ujO1YTrSQ1c7n96DNnCAY5wL5hp54+Ay6QBIwKxZGzjVaAlDnQ2KURMvmWXlX39
        TA0B+d87YgqWPrQus34CwDxYBLalWiENvk6E5sYmJUJzudza5jKVA4Di3OEQ19Mj26tVYVjS9tCWY
        4R3mTWX4C7bZdWj5BRShxfudlvQY6tAgZZe+wZzLHUxW1YHHahaVYVTyRpZ9+jM/KYEqz8YeYwJ8m
        rxuySG0osm3820Fc5xMBZfdXPDSaZ8liH9Dhal6766fD8blO5oCOyFKOaYINUXrytQreO09BBpwxQ
        9PSZTbKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qnyPh-00Ag0G-08;
        Wed, 04 Oct 2023 09:43:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A1B0300365; Wed,  4 Oct 2023 11:43:30 +0200 (CEST)
Date:   Wed, 4 Oct 2023 11:43:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4] sched/core: Use zero length to reset cpumasks in
 sched_setaffinity()
Message-ID: <20231004094330.GL1539@noisy.programming.kicks-ass.net>
References: <20231003205735.2921964-1-longman@redhat.com>
 <20231004083648.GI27267@noisy.programming.kicks-ass.net>
 <ZR0vHXDeGi+iVogR@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0vHXDeGi+iVogR@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:23:41AM +0200, Ingo Molnar wrote:

> >  	if (user_mask) {
> > -		cpumask_copy(user_mask, in_mask);
> > +		/*
> > +		 * All-set user cpumask resets affinity and drops the explicit
> > +		 * user mask.
> > +		 */
> > +		cpumask_and(user_mask, in_mask, cpu_possible_mask);
> > +		if (cpumask_equal(user_mask, cpu_possible_mask)) {
> > +			kfree(user_mask);
> > +			user_mask = NULL;
> > +		}
> 
> Question: is there any observable behavioral difference between current 
> (old) all-set cpumask calls and the patched (new) one?

Very little I think -- the main difference is that we no longer carry
the ->user_cpus_ptr mask around, and that saves a little masking.


