Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29C475C2BD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGUJPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjGUJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:15:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A76830C1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=fpQ0C0yK77AMt6tXTuim5bxXTIW3hXHiPvuLtdx9U7Q=; b=BotTGZDRAvsuRWd712okFAAfMG
        x945I8UehwJBNbN0aZBdDoTYEIH9RQC9jei9qodV0sJ066AsVFuQXL+XkTiq+u45EeAyOyQR6lUvq
        sEBFFUBaOKe26e8ClRxuiybr5CD/TMkwWGIBWIHDE7vX0ZTH9awdXVl9amEJeofUD/VOPDGW31lZh
        vuTpScMF5TzEWm90y77TvPzsbWYIw4QGa3vQrC+cOxMpHoQLCAIspkqB7PoZHsXs313Oin5HueBC8
        dyym/ArLc8KEgjPnTpKyDk1WIHFK/G/m4ChM0eA9BOTW+cgX6s1YRwDHcqzfSlicfr66EyTvqasje
        ZxO/d35g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMmCX-00HXUy-1i;
        Fri, 21 Jul 2023 09:15:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2E26230020C;
        Fri, 21 Jul 2023 11:13:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1757D30A5FDF2; Fri, 21 Jul 2023 11:13:29 +0200 (CEST)
Date:   Fri, 21 Jul 2023 11:13:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, luoben@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU
 topology.
Message-ID: <20230721091328.GE3630545@hirez.programming.kicks-ass.net>
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
 <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
 <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
 <CAKfTPtCmBL6aq9CaPvmhcyvGZtu=98crDyaHXRdwQxjyGtcDkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtCmBL6aq9CaPvmhcyvGZtu=98crDyaHXRdwQxjyGtcDkQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:33:44AM +0200, Vincent Guittot wrote:
> On Fri, 21 Jul 2023 at 04:59, Kenan.Liu <Kenan.Liu@linux.alibaba.com> wrote:

> > The SMT topology in qemu native x86 CPU model is (0,1),…,(n,n+1),…,
> > but nomarlly seen SMT topo in physical machine is like (0,n),(1,n+1),…,
> > n means the total core number of the machine.
> >
> > The imbalance happens when the number of runnable threads is less
> > than the number of hyperthreads, select_idle_core() would be called
> > to decide which cpu be selected to run the waken-up task.
> >
> > select_idle_core() will return the checked cpu number if the whole
> > core is idle. On the contrary, if any one HT of the core is busy,
> > select_idle_core() would clear the whole core out from cpumask and
> > check the next core.
> >
> > select_idle_core():
> >      …
> >      if (idle)
> >          return core;
> >
> >      cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
> >      return -1;
> >
> > In this manner, except the very beginning of for_each_cpu_wrap() loop,
> > HT with even ID number is always be checked at first, and be returned
> > to the caller if the whole core is idle, so the odd indexed HT almost
> > has no chance to be selected.
> >
> > select_idle_cpu():
> >      …
> >      for_each_cpu_wrap(cpu, cpus, target + 1) {
> >          if (has_idle_core) {
> >              i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >
> > And this will NOT happen when the SMT topo is (0,n),(1,n+1),…, because
> > when the loop starts from the bottom half of SMT number, HTs with larger
> > number will be checked first, when it starts from the top half, their
> > siblings with smaller number take the first place of inner core searching.
> 
> But why is it a problem ? Your system is almost idle and 1 HT per core
> is used. Who cares to select evenly one HT or the other as long as we
> select an idle core in priority ?

Right, why is this a problem? Hyperthreads are supposed to be symmetric,
it doesn't matter which of the two are active, the important thing is to
only have one active if we can.

(Unlike Power7, they have asymmetric SMT)
