Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B041C7B1F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjI1O1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjI1O1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:27:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536419D;
        Thu, 28 Sep 2023 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4veK4h8MnCIHD8dLpIFbw5HKoCnVUh6S/Jh0++RlbFc=; b=oO+IJ5rhHVkD2WElUuMm4fRIjN
        LxKYnzQ6vkvHTJu9mVx10IyIRe/OrH6eFGm8l6VQj7pCNBMWWZFI9+ISu3amj9xG7hmh19ddQAiul
        UuoW7Bha8+d/CyvyPtrz9+PF7DYgWdMdn9x45gQinOgdA5eOqCCveDCd0nE8kisONdIhZIb689PcB
        H7FCgQmhtzDXxNDsIkUjmLQdD6EDNGALUthVVrUZkzKL7Lzc86BubaVmZmPihrPevMyOZ1Bzghrdc
        YhhrWjBtUxF7/WNFcZRUSeBm0S3hwgiLVguKsGYnIFuqNXLtrG9/2WFO14BPWkzqL4v8KY8BgwvfI
        0qJo18CQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qlryH-002yth-2F; Thu, 28 Sep 2023 14:26:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id B59B63002E3; Thu, 28 Sep 2023 16:26:28 +0200 (CEST)
Date:   Thu, 28 Sep 2023 16:26:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Message-ID: <20230928142628.GC27245@noisy.programming.kicks-ass.net>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <20230928103926.GI9829@noisy.programming.kicks-ass.net>
 <ef39143ad24743008a896d2a09da1066@AcuMS.aculab.com>
 <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34ddb730-8893-19a8-00fe-84c4e281eef1@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 09:20:36AM -0400, Mathieu Desnoyers wrote:

> Of course things are more complicated with PI-futex, is that what you have
> in mind ?

PI futex has to go through the kernel, also, they already spin-wait on
owner.
