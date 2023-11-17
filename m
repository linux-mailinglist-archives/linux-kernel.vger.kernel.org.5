Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F237EEEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjKQJbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbjKQJbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:31:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AD7171C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=ppwT8VyimAKMgC19SK9ngEk35dk5QKKSagA+KcAqPIY=; b=B5+U4HDoTfMq6KcIACKbrYQ9Sx
        X2hkgrOpg36GI0eUh5O4g658wAzurA49cH5oOxyks0/vjSVHwQTY4V7k4oJTQ+umRquMuSxG/LS4a
        xRam5ipUk7arw4T159D+fDWU1GjQrxvpRsfEhWWbOpm6rUrX/hpVrluWOAer8ujjweZsDbUtVY0xI
        VFhgEU8S6VMZvRBqB/0a0efpkMgK5y8cLHAFzuW38t8vtPHcfIa05HHfUxzIGKkJPCfRq3pGNtWKY
        +kXzq97SoOZ7qDaycqP8lXqf8QsTGdiDl5nf4m3NaM0wCHVX+nyjLQvkE2NBnm7uvsjHOnCSLW9tK
        mZEAs6CQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r3vBd-008ZoX-2m; Fri, 17 Nov 2023 09:30:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 59DC2300581; Fri, 17 Nov 2023 10:30:52 +0100 (CET)
Date:   Fri, 17 Nov 2023 10:30:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Sam James <sam@gentoo.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix calloc call for new -Walloc-size
Message-ID: <20231117093052.GL8262@noisy.programming.kicks-ass.net>
References: <20231107205504.1470006-1-sam@gentoo.org>
 <20231109214030.jxx44y3q4rxrltkw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231109214030.jxx44y3q4rxrltkw@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 01:40:30PM -0800, Josh Poimboeuf wrote:
> On Tue, Nov 07, 2023 at 08:55:00PM +0000, Sam James wrote:
> > GCC 14 introduces a new -Walloc-size included in -Wextra which errors out
> > like:
> > ```
> > check.c: In function ‘cfi_alloc’:
> > check.c:294:33: error: allocation of insufficient size ‘1’ for type ‘struct cfi_state’ with size ‘320’ [-Werror=alloc-size]
> >   294 |         struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
> >       |                                 ^~~~~~
> > ```
> > 
> > The calloc prototype is:
> > ```
> > void *calloc(size_t nmemb, size_t size);
> > ```
> > 
> > So, just swap the number of members and size arguments to match the prototype, as
> > we're initialising 1 struct of size `sizeof(struct ...)`. GCC then sees we're not
> > doing anything wrong.
> > 
> > Signed-off-by: Sam James <sam@gentoo.org>
> > ---
> >  tools/objtool/check.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index e94756e09ca9..548ec3cd7c00 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -291,7 +291,7 @@ static void init_insn_state(struct objtool_file *file, struct insn_state *state,
> >  
> >  static struct cfi_state *cfi_alloc(void)
> >  {
> > -	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
> > +	struct cfi_state *cfi = calloc(1, sizeof(struct cfi_state));
> >  	if (!cfi) {
> >  		WARN("calloc failed");
> >  		exit(1);
> 
> Thanks!
> 
> Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Peter are you able to grab this or should I put it in my tree first?

Got it, thanks!
