Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7AC7CEB7F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 00:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjJRWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 18:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJRWxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 18:53:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26B7115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 15:53:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697669586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVtOactJ1TymnCHMGNnseSmaZvbustdeqqgs9YNOttw=;
        b=Ysch+2hE7gZoO4Qjd+aj7FnyWHzDCjfW4UPnXGM0S3fbccS5V6CbBZHDSTOuhQi03pDodd
        jVfeynUjZ3svRNvkYgXFVizsgwYgFPm1vkD0A/IFPgRUu9OP9dbubHuYs1+48r0Nt4nZxb
        7i+ShMbFMZBvalRIQ1p5LghwuASVYBFotDRLwqvcLNWG7kHz5SUG/ZHEJSYFQXx4h39LZQ
        qipWXN5ox9kbahUJOewlhdwCdyyC3zMS3LqJAmv0XGZMahPdBuQ9SP+i0KDBsWDocCCSLO
        UPZBjM7kBHGbnKZWgJusgHWOWdoS3AN+7CIPbhtHOdjeaUAZ4gZEz/eF231y9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697669586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aVtOactJ1TymnCHMGNnseSmaZvbustdeqqgs9YNOttw=;
        b=1z15eYutbjRCKrR8dISYOIoDdqZUhSkpp/QQKbwHDPWI4V6wEtoI9q/kEA9Bw2IBVx1ht3
        k/hmWXX13pk4InCQ==
To:     paulmck@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>, urezki@gmail.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <7520a5b9-b604-4da2-b874-32505f175f39@paulmck-laptop>
References: <87ttrngmq0.ffs@tglx> <87jzshhexi.ffs@tglx>
 <a375674b-de27-4965-a4bf-e0679229e28e@paulmck-laptop>
 <87il74qghh.fsf@oracle.com>
 <7520a5b9-b604-4da2-b874-32505f175f39@paulmck-laptop>
Date:   Thu, 19 Oct 2023 00:53:05 +0200
Message-ID: <875y334k6m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2023 at 10:51, Paul E. McKenney wrote:
> On Wed, Oct 18, 2023 at 05:09:46AM -0700, Ankur Arora wrote:

Can you folks please trim your replies. It's annoying to scroll
through hundreds of quoted lines to figure out that nothing is there.

>>  This probably allows for more configuration flexibility across archs?
>>  Would allow for TREE_RCU=y, for instance. That said, so far I've only
>>  been working with PREEMPT_RCU=y.)
>
> Then this is a bug that needs to be fixed.  We need a way to make
> RCU readers non-preemptible.

Why?

