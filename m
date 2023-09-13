Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0EF79E27E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbjIMIrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjIMIrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:47:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C2B198E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PiAJszYPLMXIus6FeXBGbXa7aE/a6K4hwuwqZEVTyuM=; b=UdQfugefwC+WlwiyTNc3v4fXJu
        v9xjUuvklNLPDuZSKsDRMlXcU4fgsa8Q/hAwy8ZQS4NybaFwPLNcO0ljnsY9K6XkKLr5hN5CVCu0O
        1eEu0ixHrvha/FbYRY1RElGFTHY5Z+DlsNc2iczH9FGpbuSqCdslecU7IsL6HBlL64k0Xo7Fvw9gS
        wjRgsTpx23tbV+eKR7klfzDS9q5RW8KlyxlXvTFWuypGNYH4twjylGeIoIS2oTmtYdZYE+h5VYXva
        CgGraBnFRlRmZfr0Iv+HyHhUCZg3ZUNh35zz+hLqvSZFioTL+uqc5k9QpOD4Nde4Fkh7BkXBOLOUM
        E5O+j3hg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgLWV-00Cpzq-5a; Wed, 13 Sep 2023 08:46:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0577300348; Wed, 13 Sep 2023 10:46:58 +0200 (CEST)
Date:   Wed, 13 Sep 2023 10:46:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, jpoimboe@kernel.org,
        gregkh@linuxfoundation.org, nik.borisov@suse.com
Subject: Re: [PATCH v2 10/11] x86/alternatives: Simplify ALTERNATIVE_n()
Message-ID: <20230913084658.GA692@noisy.programming.kicks-ass.net>
References: <20230907083158.GBZPmKfjarnaQk1ofB@fat_crate.local>
 <20230907110917.GA10955@noisy.programming.kicks-ass.net>
 <20230907150632.GAZPnm+Ly+Vyt8VPYr@fat_crate.local>
 <20230907153036.GBZPnsnNreLCyGpJFn@fat_crate.local>
 <20230909075009.GAZPwjsYZ4sSALN/5+@fat_crate.local>
 <20230909092554.GC2771@noisy.programming.kicks-ass.net>
 <20230910144227.GAZP3V0/mQ73C2hx/l@fat_crate.local>
 <20230912092709.GE35261@noisy.programming.kicks-ass.net>
 <20230912094441.GA13926@noisy.programming.kicks-ass.net>
 <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913043738.GCZQE8kuw8p3WsnCXd@fat_crate.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 06:37:38AM +0200, Borislav Petkov wrote:
> On Tue, Sep 12, 2023 at 11:44:41AM +0200, Peter Zijlstra wrote:
> > OK, I think objtool really does need the hunk you took out.
> > 
> > The problem there is that we're having to create ORC data that is valid
> > for all possible alternatives -- there is only one ORC table (unless we
> > go dynamically patch the ORC table too, but so far we've managed to
> > avoid doing that).
> > 
> > The constraint we have is that for every address the ORC data must match
> > between the alternatives, but because x86 is a variable length
> > instruction encoding we can (and do) play games. As long as the
> > instruction addresses do not line up, they can have different ORC data.
> > 
> > One place where this matters is the tail, if we consider this a string
> > of single byte nops, that forces a bunch of ORC state to match. So what
> > we do is that we assume the tail is a single large NOP, this way we get
> > minimal overlap / ORC conflicts.
> > 
> > As such, we need to know the max length when constructing the
> > alternatives, otherwise you get short alternatives jumping to somewhere
> > in the middle of the actual range and well, see above.
> 
> Lemme make sure I understand this correctly. We have a three-way
> alternative in our example with the descrptors saying this:
> 
> feat: 11*32+15, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a362b, len: 5)
> feat: 3*32+21, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 5), repl: (ffffffff833a3630, len: 5)
> feat: 11*32+19, old: (entry_SYSCALL_64_after_hwframe+0x59/0xd8 (ffffffff81c000d1) len: 16), repl: (ffffffff833a3635, len: 16)
> 
> i.e., the address to patch each time is ffffffff81c000d1, and the length
> is different - 5, 5 and 16.
> 
> So that ORC data is tracking the starting address and the length?

No, ORC data tracks the address of every instruction that can possibly
exist in that range -- with the constraint that if two instructions have
the same address, the ORC data must match.

To reduce instruction edges in that range, we make sure the tail is a
single large instruction to the end of the alternative.

But since we now have variable length alternatives, we must search the
max length.

> I guess I don't fully understand the "middle of the actual range" thing
> because you don't really have a middle - you have the starting address
> and a length.

The alternative in the source location is of size max-length. Because
there must be room to patch in the longest alternative.

If you allow short alternatives you get:

	CALL entry_untrain_ret
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	
Which is significantly different from:

	CALL entry_untrain_ret
	nop11

In that is has about 10 less ORC entries. But in order to build that
nop11 we must know the max size.

> Or are you saying that the differing length would cause ORC conflicts?

Yes, see above, the short alternative will want to continue at +5, but
we have a string of 1 byte nops there, and this will then constrain
things.

What objtool does/want is make then all of the same size so all the
tails are a single instruction to +16 so that we can disregard what is
in the actual tail.

We've gone over this multiple times already, also see commit
6c480f222128. That made sure the kernel side adhered to this scheme by
making the tail a single instruction irrespective of the length.
