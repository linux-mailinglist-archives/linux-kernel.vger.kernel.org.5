Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D5764004
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjGZTy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjGZTyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:54:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB426A6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uQtg7bF8jO9wCtSaK/MwXeMPoj7DNzEunPVvhTy7B7w=; b=Autuc1dtXMh3LmG7zFivT+nsBZ
        e/zaY0iH68e8vBtFcruaESTyK1l1zUZL+TvJYApc23Qg0V/rv2bCO9YHr6XWzJ9iF0IQcHYFM3G7W
        517jkdFj6aI5YpcIgncyndlq1ehnhH0QJPZ6y7jstiyGIKcptrl4mi65V8UXSdkYzu+F2KW1hXY0v
        CCjJgCcr7X4N5HtnMQMl73D7O1UvFBBueOOihYfAre/yZOajffVwTzx5IAyJJBxccNXLjoYjBotFe
        CaK4bmeCNtMqb9DwnGm+ElZ4ZW19ovGAjRYFDhWJtsUgfliGyW/aCxIr30H6aWSiCDtVtbd6Ab5dH
        /jybaIFg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOkam-006njw-5b; Wed, 26 Jul 2023 19:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BAB23005FA;
        Wed, 26 Jul 2023 21:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EABF205963BA; Wed, 26 Jul 2023 16:40:55 +0200 (CEST)
Date:   Wed, 26 Jul 2023 16:40:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     triangletrap12@gmail.com, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] locking/rtmutex: Fix task->pi_waiters integrity
Message-ID: <20230726144055.GV4253@hirez.programming.kicks-ass.net>
References: <20230707161052.GF2883469@hirez.programming.kicks-ass.net>
 <20230726141253.R_LS0bsr@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726141253.R_LS0bsr@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:12:53PM +0200, Sebastian Andrzej Siewior wrote:
> On 2023-07-07 18:10:52 [+0200], Peter Zijlstra wrote:
> > 
> > Henry reported that rt_mutex_adjust_prio_check() has an ordering
> 
> I'm going to apply it to the RT tree so it does not get lost :)

It sits in tip/locking/urgent and should make it's way to Linus
soon-ish.
