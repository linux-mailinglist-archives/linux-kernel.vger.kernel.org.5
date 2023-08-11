Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ECF778999
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbjHKJTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjHKJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:19:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A182D5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 02:19:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691745564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SnS7nYhKA1NCaRvQ1U07W2Kay15t1atAB4UQPyjumhM=;
        b=xE3KuGJxr2u7d/79N9H8XqbqHl5leYvMr/6Fuhqg9/8G/WxwHHnyv3199ooaz+dTzG9vdN
        DUStdyjlD52WsmLONQuvWmghu6sZ7WBEKvjU2BUiupxeGtgixccvcAbXKhnUupTBePC0Px
        UxBhcOgkv6lO+GlmLjgd2aUiCUxUyIUDd2MTN9e+toxhdayd6b81YFE1g/pcXwpdvO8f6N
        cSPFUM1/S+BEPzPw+HBP1LkEcNDGlnKkr06LSp1r+vrEQvLfMXjPG3fsXHK68OYB0UmbWB
        DiHxSpOkmVXVisAY/eqTgcOMqnZZ4pwBX5D0AnvUQ9kiB+UWhMwN1vnYjw3oGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691745564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SnS7nYhKA1NCaRvQ1U07W2Kay15t1atAB4UQPyjumhM=;
        b=tnGcIaZjCORvEoqg7VgtS/jzI7lGMu+4iUk6/YLcde6VgFVyytGiZvQ6SikEKM9CKJsKNE
        joos3hOGD/+QmzBA==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 26/30] x86/microcode: Protect against instrumentation
In-Reply-To: <20230810203640.GE212435@hirez.programming.kicks-ass.net>
References: <20230810153317.850017756@linutronix.de>
 <20230810160806.448579267@linutronix.de>
 <20230810203640.GE212435@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Aug 2023 11:19:23 +0200
Message-ID: <877cq2hr6s.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10 2023 at 22:36, Peter Zijlstra wrote:
> On Thu, Aug 10, 2023 at 08:38:04PM +0200, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> The wait for control loop in which the siblings are waiting for the
>> microcode update on the primary thread must be protected against
>> instrumentation as instrumentation can end up in #INT3, #DB or #PF, which
>> then returns with IRET. That IRET reenables NMI which is the opposite of
>> what the NMI rendezvouz is trying to achieve.
>
> asm_exc_nmi will re-enable NMIs when DEBUG_ENTRY before we reach C.
> Late loading had better depend on !DEBUG_ENTRY.

Good point
