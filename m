Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAF799716
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344438AbjIIJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjIIJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:29:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E873510F9;
        Sat,  9 Sep 2023 02:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5f0fYPajxvMLjiTkfmPyOmdt95nfZt54Bxw6PTBnT88=; b=T7IwzKvwGnSREd5YdjLFLimbuk
        JdIvA1lacNaPuFvo+wiXGQy6hwhPjVQhPmt0gOmBUN0ucb3Qy2KBqn/WTKvshU+umJsHFLnlGHK/2
        aCFzxr0h5j6qXG3ATxazoPNR1ES39O9Hlf/Fk1N4Cam1ycZ0OX4lcdDyS07RjP5YcWKzuuyDaytnw
        JuKbLWSGDZy3/rPsGPz/3sjC9f2mMppq1d9ROmQvdGQZ2Ese9XRwW2gVy0nM6LbcuK2sCFNRgpdSZ
        +M0Nxtiu1ywGEkgPn5fD4aU+QDtawS404jR7B+TcLiAxoURahN9zWmnQQhEECxuWTYfcwh6aDJvuY
        FkJYVN1w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeuHb-005Qcq-V5; Sat, 09 Sep 2023 09:29:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A383300348; Sat,  9 Sep 2023 11:29:39 +0200 (CEST)
Date:   Sat, 9 Sep 2023 11:29:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] freezer,sched: Use saved_state to reduce some
 spurious wakeups
Message-ID: <20230909092939.GD2771@noisy.programming.kicks-ass.net>
References: <20230830-avoid-spurious-freezer-wakeups-v2-1-8877245cdbdc@quicinc.com>
 <20230904212324.GA2568@noisy.programming.kicks-ass.net>
 <df61af06-a43e-05c5-66e8-5a68b08ff14b@quicinc.com>
 <20230907094651.GB16872@noisy.programming.kicks-ass.net>
 <4c5b5a0b-6d78-878e-7e66-e08e83e6e1c8@quicinc.com>
 <20230908220804.GA29218@noisy.programming.kicks-ass.net>
 <783c60ef-5341-7893-e9e8-2b1b249f89c9@quicinc.com>
 <20230908224829.GA32012@noisy.programming.kicks-ass.net>
 <8b917006-2c77-0b36-060a-76a1ca04d2e0@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b917006-2c77-0b36-060a-76a1ca04d2e0@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 04:17:09PM -0700, Elliot Berman wrote:

> I was wondering what time zone you are in, I saw your previous replies
> are early in my morning. I think you are giving Greg a run for his money
> with responses at all hours :-) 

Hehe, Greg and me are both in .nl. Me being an actual native here and
Greg is an expat, but he seems to enjoy the country :-)
