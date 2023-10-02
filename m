Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE67B507E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbjJBKlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbjJBKlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:41:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEDEAB
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AA7nmoAyLF0A+oeQqQnncAoTAl+IjCg4AvOPjPTKPFw=; b=eizFjP6hx1bHEnv2zyaIlMtBCJ
        m1yIhYfxkc1ZwEbvPUjdNY643PA3OhC8ZTz4fEv+GKC8PkCDThtDkPC6it+ZtFBS7p7CC4Z/LOQII
        094JDhaX3AesiiyQ68aVL1I6hqV4TmkSNNWkDfBwtKPbwaa7ZIdK99chTtmfjUbpSvZiG5cggDrI2
        FFJWcqzl3m/Epu9Davcl8YwAuC/vzIX44RsxKb4UkZqqO2/tcfGwlD6a3Z6XH3skw4h+Yl/V+LmP+
        WGlDmgTF+alnPdFhsHw/9rtpxsvxj/BDfPmhL8EhsqPjdpkcC/waHo/bd7zd/ZgodvEI1qtgsHvcd
        Rbem96TQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qnGMC-008bhu-Oq; Mon, 02 Oct 2023 10:40:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7194A30036C; Mon,  2 Oct 2023 12:40:56 +0200 (CEST)
Date:   Mon, 2 Oct 2023 12:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
Message-ID: <20231002104056.GA13957@noisy.programming.kicks-ass.net>
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora>
 <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 11:17:21PM +0900, Hyeonggon Yoo wrote:

> OK, I looked into this a little bit, and it turns out that the problematic
> address here is from cleanup_trusted() in
> security/keys/trusted-keys/trusted_core.c.
> (and it's builtin due to CONFIG_TRUSTED_KEYS=y)

That code is insane.. wth would you want to use an explicit
static_call() in either __init or __exit ?!?

I think the reason we support init was because it was just really hard
to avoid throughout the abstraction layers etc.. But this seems to be
the only __exit user, and it is really quite daft.

> The function is marked as __exit, so it does not fall within the
> 'core kernel text address range,' which is between _stext and _etext
> (or between _sinittext and _einittext). and thus __text_poke() thinks that
> it's vmalloc/module area.
> 
> I think __text_poke() should be taught that functions marked as __exit
> also belong to kernel code just like __init.

Should we not do something like:

#ifdef MODULE
#define __exit __section(".exit.text") __exitused __cold notrace
#else
#define __exit __section(".discard.exit.text")
#endif

It's not like that code should ever be ran or referenced when built-in.
