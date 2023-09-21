Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9367AA150
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjIUVAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjIUU7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:59:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEEB93C4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bwElb4FLHLZ9yVB+qHk0J5FYWrvoWV55wBsQBNN8sAY=; b=pvGPTKPEGtYqOyvHoagN3qNrrb
        dk2R5HiXs14CSj9t1+6Qjc+gDQ4J2InblgCeijvlWQsB/k4+ruherBwVZB1LIwFFqZkNl6x7aeyPH
        cHtUebsI/yK7nlZpk+XseYH7cwt4EIvLRpTd36h9xD+lh4wUmnKsHYoSXFFdgYE2axqMJKmC8hwWe
        xVNlbmRG9udcVV7qd4MkJbjQQC/E67v9c8M0cFPzUfS/TaDbWcAbX1nxsJR5jCvewTVXuJ+Og4FXt
        jEnOcIVYxz211XYyjD0X2oQyxiEBjSkB/4WANeGgnyhggpefEura3QRkI2peXAZ8m6ZcK5bwE60EU
        b4Pyi3DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjKHm-00CFbR-Hq; Thu, 21 Sep 2023 14:04:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C0D03002E3; Thu, 21 Sep 2023 16:04:06 +0200 (CEST)
Date:   Thu, 21 Sep 2023 16:04:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <20230921140406.GF14803@noisy.programming.kicks-ass.net>
References: <20230913154907.GA26210@redhat.com>
 <20230913154953.GA26242@redhat.com>
 <20230916085117.GA35156@noisy.programming.kicks-ass.net>
 <20230921114826.GA20728@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921114826.GA20728@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 01:48:26PM +0200, Oleg Nesterov wrote:
> On 09/16, Peter Zijlstra wrote:
> >
> > On Wed, Sep 13, 2023 at 05:49:53PM +0200, Oleg Nesterov wrote:
> > > 1. Kill the "lockmember" argument. It is always s->lock plus
> > >    __seqprop_##lockname##_sequence() already uses s->lock and
> > >    ignores "lockmember".
> > >
> > > 2. Kill the "lock_acquire" argument. __seqprop_##lockname##_sequence()
> > >    can use the same "lockbase" prefix for _lock and _unlock.
> > >
> > > Apart from line numbers, gcc -E outputs the same code.
> >
> > With seqlock_ww_mutex gone, yes this is a nice cleanup.
> 
> Thanks.
> 
> Can you look at 2/5? To me it looks like a good cleanup too.
> I am going to resend 1/5 and 2/5, as no one is interested in
> stats_lock change.

2 seems okay. Will need a new changelog without the rest thouhg. Perhaps
talk about how it perserves the constness instead?
