Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8C47DC085
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJ3Ta0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJ3TaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:30:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF88A9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 12:30:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698694220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxOzVWRVWndMriKyitaS+zmoM3aDQBQB0n2Xig2ZtpM=;
        b=CSGQbhr3SZYqIJ/1rpMro2nZVj6lGUcYf7uzhxm75okJuGM3TbZobpWnYfmgQCQ3b9PftK
        U/sFslkEQ2LilUQq8Wow2953UQANeLxAcgIQXpv+C3YccdzrRUcw/IwzxCRZd86EVe3E/e
        X7wu7MgGOsfZq496GgupyKtlnvKtaNLn75sTLJ9z1gM1SL5P5bCY3Cl9v/DjZsDSZCZomT
        7FSNGKN41V1uw+3rHMVerFTB43l5aIp4CW5f6FG9wdmpL2xp/DJ3vUvkvGvNtrlllSWuJ+
        jJDTUvfL7UhAJwVWpUqHHe66JoPuyK0tV/mmIt91CcP99IY8jf6dTAx5CJ77Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698694220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DxOzVWRVWndMriKyitaS+zmoM3aDQBQB0n2Xig2ZtpM=;
        b=iC0CKuDBrH70QCf9gUf1Bwqq1la2RrdBCMsCKUMcxQj/wWDQ0vmrOUfwzZ3WwIG2Pjqqe3
        kXbPcO/bvCD70pDA==
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
In-Reply-To: <877cn4ynms.ffs@tglx>
References: <ZT6narvE+LxX+7Be@windriver.com>
 <20231030082644.GK26550@noisy.programming.kicks-ass.net>
 <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
 <20231030114450.GB12604@noisy.programming.kicks-ass.net>
 <ZT/Lmj3xAdwvLE7R@windriver.com> <877cn4ynms.ffs@tglx>
Date:   Mon, 30 Oct 2023 20:30:20 +0100
Message-ID: <871qdbzz5f.ffs@tglx>
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

On Mon, Oct 30 2023 at 19:24, Thomas Gleixner wrote:
> On Mon, Oct 30 2023 at 11:28, Paul Gortmaker wrote:
>> [Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 12:44) Peter Zijlstra wrote:
>>
>>> Thomas was looking at this and wondered if something like the below
>>> would help?
>>
>> I tested this on a vanilla v6.5.7 baseline, for lack of a better choice
>> and got six failures in 136 boots - everything else unchanged - even the
>> shell instance that builds the kernel.
>
> While the sync_core() invocation is definitely at the wrong place, I did
> not really expect that this cures it.
>
> Can you add "debug-alternative" to the kernel command line and log both
> a working and the non-working kernel output. It's noisy :)
>
> Also do you have a .config and the qemu command line handy?

Forgot to ask: Does the probkem persist with 6.6 ?

Thanks,

        tglx
