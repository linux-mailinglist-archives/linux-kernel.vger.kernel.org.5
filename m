Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84B479DF30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 06:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbjIMEhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 00:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjIMEhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 00:37:47 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41830AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 21:37:43 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0506140E01A3;
        Wed, 13 Sep 2023 04:37:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ugShwTVKim6; Wed, 13 Sep 2023 04:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694579858; bh=Pz7c/WMnHT0flYYZWzn0cXH0lAG+t30L4SOhIfVvX/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hElXVje7w8/V5niOvnUjjG6mCMqsPocxm9p0Q3jGz7aTXXgCiUfctiD9DC2btR+l0
         Gk8myDC14n0Nq0Lh8Y2V0rHiE20ar+9eFxCpeoEwp/KdICKwILgU5IfkhSZskTFQ4b
         ZvNq3VJIha+vOKebKvDzY5TdWNeSDxKYQdzauhgtmJqr+uM4z8b7/oATK74PfQXKb/
         B3il99oRq1aSLlam7DUjpdgl5rPUjrV+QWsztQr3udjRSlXScjZySdpzjHM5itLA9t
         EMZCMENdObaVREoxsErmxBAlA1rVKxkZ5uwvCQkJNxlSr6P0bM2oc7FUWVPhKvZX7F
         umdZ7Aqxq4hGxJdOgkzICIo9SPgfuOY51QoBb4N473E6Ob4ac/LwjrbWP62OdzCw9U
         pvT5AdViYOqHrqi5VdQsN0vaEoyH/7nNFYzfHmZJjUiZdbPIm4ihuH4OQdmAKvU0W0
         pOrL40/XCfDSMO8PgVGsyr2/OJN9iItXFtwzwSTLkNVrFJWfEva0872YGZFJRkBfBN
         SrzCmWVX3JMR2sdqkQSLpXLJQJhYTzfMb0rma3sJ8bmvh8IMDS9bS80L84SoElb11c
         kOfqO9LYBs0N1Jk6OG5ljSbas9cELtxH9rK+f/CIpHjto0XNn2sjQ+2BMz6i4PoC8p
         r3SRrvk1QXns9qXGS4X9Fy4o=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C8C240E0140;
        Wed, 13 Sep 2023 04:37:30 +0000 (UTC)
Date:   Wed, 13 Sep 2023 06:37:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
References: <20230814121149.176244760@infradead.org>
 <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912094441.GA13926@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 11:44:41AM +0200, Peter Zijlstra wrote:
> OK, I think objtool really does need the hunk you took out.
> 
> The problem there is that we're having to create ORC data that is valid
> for all possible alternatives -- there is only one ORC table (unless we
> go dynamically patch the ORC table too, but so far we've managed to
> avoid doing that).
> 
> The constraint we have is that for every address the ORC data must match
> between the alternatives, but because x86 is a variable length
> instruction encoding we can (and do) play games. As long as the
> instruction addresses do not line up, they can have different ORC data.
> 
> One place where this matters is the tail, if we consider this a string
> of single byte nops, that forces a bunch of ORC state to match. So what
> we do is that we assume the tail is a single large NOP, this way we get
> minimal overlap / ORC conflicts.
> 
> As such, we need to know the max length when constructing the
> alternatives, otherwise you get short alternatives jumping to somewhere
> in the middle of the actual range and well, see above.

Lemme make sure I understand this correctly. We have a three-way
alternative in our example with the descrptors saying this:

feat: 11*32+15, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a362b, len: 5)
feat: 3*32+21, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a3630, len: 5)
feat: 11*32+19, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 16), repl: (ffffffff833a3635, len: 16)

i.e., the address to patch each time is ffffffff81c000d1, and the length
is different - 5, 5 and 16.

So that ORC data is tracking the starting address and the length?

I guess I don't fully understand the "middle of the actual range" thing
because you don't really have a middle - you have the starting address
and a length.

Or are you saying that the differing length would cause ORC conflicts?

In any case, I guess I could extend your commit with what we've figured
out in this thread and send a new version of what I think it should look
like and I can start testing it on my pile of hw next week, when I get
back...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
