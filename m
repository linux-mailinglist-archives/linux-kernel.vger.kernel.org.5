Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F447DBFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 19:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjJ3SYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 14:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJ3SYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 14:24:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C7FC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 11:24:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698690269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97/h0rsfmKE3PULX2h/B1YZWKyhuTtryM6A8RB83aLQ=;
        b=OjKkLIAfDfB1qOz9SX3A4qNUsq7BfACuIuPMwDsPQ8S31qj5DH0qpDU/msqXaKVdmGgJXp
        F+jjtfYQsQAi19eHdGX8GOEhkD7s12JrRv864OjG796egpUH3HlqV1+i4eMt841qMACq4d
        GzRctOmrTglSq3B/IhPG1aSBWvBczcgK8AoTRd+ROhyjWDMgLCHeqzrkyz3t2MJ8tBZCi4
        X5UcZ7eK+1BjGuCu8uVyS5bKEA9n1+o7D3IPKqi4NYswX6mP5U9JsUm/RiBop+ywPBpKrN
        AFrAXYixher0z3K6Zh6c8VZbGM19DA+mbSsbVSE9SRaLAl2K1UwKHG2tRuSKOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698690269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=97/h0rsfmKE3PULX2h/B1YZWKyhuTtryM6A8RB83aLQ=;
        b=mwTaufuYy0K/4Dovc2Mlj10u2Xq8QjMOpVHK/S/Xr/QYny+RNNxKuVfPefky7s13Y/kjfu
        vxLWj93D6TgwAwBw==
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
In-Reply-To: <ZT/Lmj3xAdwvLE7R@windriver.com>
References: <ZT6narvE+LxX+7Be@windriver.com>
 <20231030082644.GK26550@noisy.programming.kicks-ass.net>
 <ba1369810b39f79c0b092151bfa062dd0cf505b3.camel@linuxfoundation.org>
 <20231030114450.GB12604@noisy.programming.kicks-ass.net>
 <ZT/Lmj3xAdwvLE7R@windriver.com>
Date:   Mon, 30 Oct 2023 19:24:27 +0100
Message-ID: <877cn4ynms.ffs@tglx>
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

On Mon, Oct 30 2023 at 11:28, Paul Gortmaker wrote:
> [Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/alternative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 12:44) Peter Zijlstra wrote:
>
>> Thomas was looking at this and wondered if something like the below
>> would help?
>
> I tested this on a vanilla v6.5.7 baseline, for lack of a better choice
> and got six failures in 136 boots - everything else unchanged - even the
> shell instance that builds the kernel.

While the sync_core() invocation is definitely at the wrong place, I did
not really expect that this cures it.

Can you add "debug-alternative" to the kernel command line and log both
a working and the non-working kernel output. It's noisy :)

Also do you have a .config and the qemu command line handy?

Thanks,

        tglx
