Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9142079010C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbjIAREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIAREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:04:07 -0400
Received: from galois.linutronix.de (unknown [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4C410F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:04:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693587827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsk/WpOd783kikBjV3lPWNsCfDm784RsCYIzeJskNyo=;
        b=hMS7QpTOnZvyvaKsAPVzYtumZc/OQ3or2BFhetB4qzrXbdzKcUP2iqwhCR4wO4MPov1LsM
        TvarURWgumafpdkZdYB4Tdw0357vqdO7LN4jN3vZ5tMB+9BLfPu0pWJypqrYCbMnP//srS
        tHParzkESCQ0FUeBi0IFDaX1AEKL+0HhUs4AeetieN4BdILTsv8MF8iimP1Ei8Ejxe1PtX
        cMw+BnMVbhsAoMpehFFnLd/WLerzqsy3um+NiBrbV6d5Uuf2RZLTmHoNRy6SRNfY9a1YyZ
        KPy8t6x/dyC9TKKms0mnFcoVQJ4AFT1GRWjquNoEbNkuhvyWZt+zNsI9UWcMiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693587827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsk/WpOd783kikBjV3lPWNsCfDm784RsCYIzeJskNyo=;
        b=faGAOkLaNq0I6OdmEx0vKgSnI3wimlT00K62fSRQBIassU4obT0EeZOErDZsCpa4Bb5vka
        4K5FZEikqZdCI6Dw==
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Joshua Hudson <joshudson@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     x86-ml <x86@kernel.org>
Subject: Re: System Call trashing registers
In-Reply-To: <dbce949f-d8b5-fb88-af63-21a82e431aa3@gnuweeb.org>
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
 <dbce949f-d8b5-fb88-af63-21a82e431aa3@gnuweeb.org>
Date:   Fri, 01 Sep 2023 19:03:46 +0200
Message-ID: <87fs3x4yh9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01 2023 at 23:24, Ammar Faizi wrote:
> On 8/24/23 11:15 PM, Joshua Hudson wrote:
>> 2) syscall is documented to trash rcx and r11.
>> 
>> What I don't understand is why this hasn't ever led to a security
>> issue due to leaking values from kernel space (in the trashed
>> registers) back to userspace.
>
> That behavior is architectural. It's the 'syscall' instruction that
> clobbers %rcx and %r11. Not the kernel.
>
> The kernel's syscall entry point even saves %rcx and %r11, but at that
> point they've already been overwritten by the syscall instruction
> itself with the original %rip and %rflags values. So they contain
> userspace values. No internal kernel data is leaked in %rcx and %r11.

Correct.

It does not matter which entry method you use. The kernel always saves
all registers and restores them. syscall, sysenter, int80 behave the
same way. The implicit clobber by the syscall instruction is done in
hardware and the kernel can't do anything about it.

I can't reproduce this either and the code tells me that any attempt to
reproduce is futile.

Thanks,

        tglx
