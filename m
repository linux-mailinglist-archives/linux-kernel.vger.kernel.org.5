Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19277AC713
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIXH4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 03:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjIXH4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 03:56:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E463106
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 00:55:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695542153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJ3bFtBX+xFFyPEDv2OXIlVM2+4Lakum4JeZyJHofeI=;
        b=zHuPw4ApKlRAWEypkg2Ve2Sy10ibX4+DZ70jnonQBEKLHvmpsHiMnB3qY8Ptn9x8IXhsbp
        dTwyZRWqSYsKgYCKcXcsSbUEwUAVsztza7s1lZpOoxM6sCbTsteIBQjZlizQJWhfCafwrN
        pzVTughblLnHUMkupvN78oBWNzgMUMZGyyTXCh7b1PJtcX5fmKh8+hx3JDSW+fAQVjBJSj
        9IgK1PeZpjTb8BH/L6dJWcVPXNXaXzyimebKYLdUq9iVAXMiSH/pcHIh1/u0s78CWZezw2
        HadSQjFkQvt0w+DeLsLQyxFpBuZhoxrEhbQJ3HTM+xumQBVE+/kMft8bMrh9Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695542153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uJ3bFtBX+xFFyPEDv2OXIlVM2+4Lakum4JeZyJHofeI=;
        b=BTG/KIxfrzyYh56D/+yZfbnO+4ToZq5D5hFTY9eyiGzvurxE+tWRjSOgX7QEuQMYxFgZAq
        W7nsrZV/qTBVZQBA==
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
In-Reply-To: <ZQ/i6CC86PzaYCzw@casper.infradead.org>
References: <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
 <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <87h6nkh5bw.ffs@tglx>
 <ZQ/i6CC86PzaYCzw@casper.infradead.org>
Date:   Sun, 24 Sep 2023 09:55:52 +0200
Message-ID: <878r8wgg3b.ffs@tglx>
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

On Sun, Sep 24 2023 at 08:19, Matthew Wilcox wrote:
> On Sun, Sep 24, 2023 at 12:50:43AM +0200, Thomas Gleixner wrote:
>> cond_resched() cannot nest and is obviously scope-less.
>> 
>> The TIF_ALLOW_RESCHED mechanism, which sparked this discussion only
>> pretends to be scoped.
>> 
>> As Peter pointed out it does not properly nest with other mechanisms and
>> it cannot even nest in itself because it is boolean.
>
> We can nest a single bit without turning it into a counter -- we
> do this for memalloc_nofs_save() for example.  Simply return the
> current value of the bit, and pass it to _restore().

Right.

That works, but the reverse logic still does not make sense:

        allow_resched();
        ....
        spin_lock();

while
        resched_now_is_suboptimal();
        ...
        spin_lock();

works.

Thanks,

        tglx
