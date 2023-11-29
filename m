Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391517FD179
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjK2I5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjK2I53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:57:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBD619B1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:57:35 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701248254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGut62ybfe28ybZ43VX49v4u3VfIheCoqpgPTSbsrts=;
        b=pyYGXSkHrtNeAaJdR2tkk5ywCxuX9h0psTJRmlkpAaCB6+TdGqElK6xStunG6NMUoLz35Z
        pQvxtfJTk/JKC3UamdRQKAz3BkL8ng+fxqy45yPhCJXCZq/YGo2OaCdKouU1TBec2/gEED
        nc5Ti+DtToptqH0XfughR4KBg6NThZ9QkddGnN0LJyaurf20cMVz4/zXRjkWrZUixW7cBi
        27YqXL7cwyn1xg0jMsH8A6BhBzBJqzunZhjqodaWmYIGS627m7xgs5+FsiokWD2kmSgo6H
        7/VwO9KTxlPhuQYrC2bLsu/95HznhOgoGj8tWavwm4bBJE+uIp+QqfswA/5Zsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701248254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gGut62ybfe28ybZ43VX49v4u3VfIheCoqpgPTSbsrts=;
        b=3zM/MGcDpAN5/7z76YtFg8pTuLKzdlJyznkN/bsnYMJgFCc3A6r9+u/4ct3tdc+BSUlIWx
        EU44GYdo98LHkzAA==
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>, paul.gortmaker@windriver.com
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        richard.purdie@linuxfoundation.org, x86@kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
In-Reply-To: <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
References: <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
Date:   Wed, 29 Nov 2023 09:57:33 +0100
Message-ID: <87r0k9ym0y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11 2023 at 12:51, Linux regression tracking wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>
>> [Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 20:30) Thomas Gleixner wrote:
>> 
>>> On Mon, Oct 30 2023 at 19:24, Thomas Gleixner wrote:
>> 
>>> > Can you add "debug-alternative" to the kernel command line and log both
>>> > a working and the non-working kernel output. It's noisy :)
>>> >
>>> > Also do you have a .config and the qemu command line handy?
>>> 
>>> Forgot to ask: Does the probkem persist with 6.6 ?
>> 
>> My bad, should have mentioned v6.6 and linux-next is impacted. Always a
>> conflict between burying the lead and boring people with details.
>
> Paul, was this regression ever solved? I wonder as I could not find
> anything with a "Fixes: 6c480f222128 [...]" tag on lore and this thread
> looks stalled.

Hmm. I was waiting for the .config file to materialize and for an
eventual analysis of the alternatives debug output....
