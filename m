Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1037A1E24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjIOMId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjIOMIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:08:31 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E240430FF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:05:47 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A25BB40E01A4;
        Fri, 15 Sep 2023 12:05:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1_G8pgAPhPW5; Fri, 15 Sep 2023 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694779543; bh=2wPZCYdmJSGcS7R40rFJDPDabOwTKkdMTTnMvA5piYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cX84+6mPOUM6MHA/aC9KjMClcLEA3Mz6L9uhXwcxQSN0yIOPNkK5uSc/tTX0pAGkT
         pmN30Tn73pqt7wcee1q/7hHNmri+3w0PO0ySlAgvZ2V/a+/J8vm+uRTOjZHzFa37bF
         OQetXvTvKgmdpXKXfw1UxbD4LJldmHsRAElFeoG0jnNyN9ezBaQsNbrrsyvzOsxwHj
         1wEDECfDqh2fOGXlmRqDRBhMJheGlkff93x8JbjJCeBrGahHytEU7emo6fk56jHdcy
         4TXOrGnvVk/hKbI5p1rCak8fwwCneXFWkiHepgKFMI8dMPO/kt0doGFr6dBp9+PCWZ
         WzZxbhbS+B9Ms1HmMgmoaOAZifkIj1/JDKJSfdlLyno0DypIrHA6RmWnEsXhqLZBlo
         9P1bAj5rDGNqCGqKddxJ/GmROG+uydRY6qEiI69DEeWhSB55noPYY16CZVz04+pfTI
         ACfHNvWweLzc+2ceZEv96DbunX36j0DIujI0WAdQsbb0xvG8w7n9ZTIF1QQVm5JeHT
         wS5iwqlDSSaIwRXBV75JWf26ZHHpQF3RFxyTeGqeD6UXRt+uq2pXnb8JrNf7RrM1oB
         32h1rAq272Hg+Xy3XtfGjfnu+mEIW0nZuVnjlvTcNQBA8fk7lq+rfzmby55MwwAm3/
         iyrfOdGmV0cdVL1D7pZGKklI=
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AECCF40E01A2;
        Fri, 15 Sep 2023 12:05:35 +0000 (UTC)
Date:   Fri, 15 Sep 2023 14:05:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230915120553.GBZQRIoX+2s14BDaKw@fat_crate.local>
References: <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
 <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
 <20230913084658.GA692@noisy.programming.kicks-ass.net>
 <20230913143847.GBZQHJd24PX0l0gLG+@fat_crate.local>
 <20230915074647.GA6721@noisy.programming.kicks-ass.net>
 <20230915075106.GA6787@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230915075106.GA6787@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:51:06AM +0200, Peter Zijlstra wrote:
> > So I see what you did with that @n argument, but urgh, do we really need
> > this? I mean, it just makes things harder to use and it doesn't actually
> > fix anything.. :/

It only addresses this repeating of the 661 labels:

# 53 "./arch/x86/include/asm/page_64.h" 1
	# ALT: oldnstr
661:
	# ALT: oldnstr
661:
	call clear_page_orig	#
662:

but this is only the produced asm which no one but me and you look at so
I guess it is not worth the effort.

I still think, though, that adding the comments explaining the situation
more is worth it because we will forget.

> That is, if we can magic this using __COUNTER__ without a user interface
> penalty, then sure. But the last time I tried that I failed utterly and
> ended up with labels like:
> 
>   .Lalt_old___COUNTER__:
> 
> no matter how many layers of CPP macro eval I stuck in it. So clearly I
> wasn't having a good day ....

Yeah, I tried it too because Matz said it should work with it but
I failed too. Reportedly, the approach should be to do that in CPP and
use CPP even for the asm macro but my CPP-fu is basic, to say the least.

I'll poke him next time we meet - I might've missed an aspect.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
