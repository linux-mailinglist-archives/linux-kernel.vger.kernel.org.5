Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14E7BF522
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442540AbjJJH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442536AbjJJH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:59:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03E91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Nj9L8S16JaIWgV0JAYOYMZ2qHAOcfxJsWPV6+o/Mys=; b=kGlwxKji2C5uS5qN0p/dVyZYyb
        XTT0mzW7uw+v7QFq96bdgnXpnubJhSt/RQybxPcjYzRZEWhotvH15UGSIm26ibjuoUesnrVllpeB6
        RV/pNpbuG/sfO79cnIj3u7ooxI5eaE2hwtqtVhBPTK9swDGmaPp92e9Bnx7eQKaXSscVGfLShOGTj
        jJpvLBuC7q64N0jVnQ9quQRnkuKrMltwCapc6U99KcMBoNHXpYvOKUOPklaBbz+e+z5+JXEg1mO0w
        taosobfGIUFw5wPjTxfajLw8L7Cl8HX4V72+zkrqpvFvpiABYnugB5qEk1mq/OUEotDSnOseuNWKW
        qooJF30Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qq7eJ-00GhCE-0V;
        Tue, 10 Oct 2023 07:59:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 45152300392; Tue, 10 Oct 2023 09:59:28 +0200 (CEST)
Date:   Tue, 10 Oct 2023 09:59:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] sched/fair: Use printk_deferred instead of printk in
 pick_eevdf()
Message-ID: <20231010075928.GA377@noisy.programming.kicks-ass.net>
References: <20231010032541.339606-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010032541.339606-1-yu.c.chen@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:25:41AM +0800, Chen Yu wrote:
> When no eligible entity is found in pick_eevdf(), it has to pick
> the entity with smallest vruntime. This indicates a potential issue
> and scheduler will print this error.
> 
> However this printk could introduce possible circular locking issue
> because when the code path reaches here with the rq lock held, the
> printk could trigger further scheduling which loops back to the
> scheduler.
> 
> Use printk_deferred() to defer the console write from current context
> to the irq work in the next tick.

No.. I detest printk_deferred with a passion. This is effectively a WARN
and we don't do silly buggers for them either.
