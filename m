Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B68275F967
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjGXOIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGXOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:08:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141721737
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=73LckR6J4u0JB+AYHnfHZy4GusyoM9zVoaHpepAFy1w=; b=K7h1gKR0orYCeull4LaoFpvZjP
        DNRW3eFZtWzjMbTB52h0PHu8K+lcVKOqGG0RytNkOrg0mP4lKomdBNp8YukoaUtW2XIjfKumwAuRB
        vrerb7sIP3fQObOhWdgxODozn2y3buUj/BNKhVKD02EZxkOZ88jmyBP0XtFOh3MxbKeveVy1Bhye1
        E5wg9soCXR0sX6AP0ZwAmMKSV+BurLSHBNhUfwI08EaXw/pNaMYh1Ukkyh4nTb2z8B7PCGSk4mr0I
        3kxPCQanuQOkK1D3lRP5WDuz2YBt1Io/bFZK7J6zL5nF3xNAjR0syOZKZw4QUq7oKjZ+kIF5YfKpp
        01+dukWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qNwDz-004TTi-SB; Mon, 24 Jul 2023 14:07:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DFA87300579;
        Mon, 24 Jul 2023 16:07:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A2BD2266880BA; Mon, 24 Jul 2023 16:07:46 +0200 (CEST)
Date:   Mon, 24 Jul 2023 16:07:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     luoben@linux.alibaba.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, pbonzini@redhat.com,
        mikelley@microsoft.com, yu.c.chen@intel.com,
        "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Adjust CFS loadbalance to adapt QEMU CPU
 topology.
Message-ID: <20230724140746.GB3735636@hirez.programming.kicks-ass.net>
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
 <20230720085032.GB3569127@hirez.programming.kicks-ass.net>
 <6a70900a-649f-3a4d-2e47-61648bc95666@linux.alibaba.com>
 <CAKfTPtCmBL6aq9CaPvmhcyvGZtu=98crDyaHXRdwQxjyGtcDkQ@mail.gmail.com>
 <20230721091328.GE3630545@hirez.programming.kicks-ass.net>
 <70494547-a538-baf5-0554-6788ac2b45e8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70494547-a538-baf5-0554-6788ac2b45e8@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:57:57PM +0800, luoben@linux.alibaba.com wrote:

> > Right, why is this a problem? Hyperthreads are supposed to be symmetric,
> > it doesn't matter which of the two are active, the important thing is to
> > only have one active if we can.
> > 
> > (Unlike Power7, they have asymmetric SMT)
> > 
> 
> hi Peter and Vincent,
> 
> Some upper-level monitoring logic may take the CPU usage as a metric for
> computing resource scaling. Imbalanced scheduling can create the illusion
> of CPU resource scarcity, leading to more frequent triggering of resource
> expansion by the upper-level scheduling system. However, this is actually
> a waste of resources. So, we think this may be a problem.

This is a problem of your monitoring logic -- there is absolutely no
functional problem with the kernel AFAICT.

Teach the thing about SMT instead.

> Could you please take a further look at PATCH#2? We found that the default
> 'nr' value did not perform well under our scenario, and we believe that
> adjustable variables would be more appropriate.

That patch is tweaking default disabled code -- which we should be
removing sometime soon I suppose. So no.

