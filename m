Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B247E8E60
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjKLEwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLEww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:52:52 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F128430D5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 20:52:48 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-113-74.bstnma.fios.verizon.net [173.48.113.74])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AC4qHFg025618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Nov 2023 23:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1699764741; bh=6eeV0JQAfBjKRrPx7Ol5znehKOwNsZTtSFwyplKveTA=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=A0AprTCXTkwN0jCF8UynimChnUMeGYcRmNvJjk4aXFijdqo69OKNda5nwUpWwyu7k
         uh7/xVJxv/GVwvCnANRwrbg7bpzo/gAiH1EmwHFq1ZfvzDBoNpURfmS+8pPuFrrhSM
         a6kk3fDldIZqdh+vY14pXBuXgcFEPImjodPu4r5d4142AHjeziC4HCKXt3BEmaR6x/
         eFRZxAHjcYEUCfsz3IFwGosMozh486KDSsAGYWjXX+/oq/Z0u/7WFqYz4z8nPmD85m
         rTIYpCZ6eAMoOADI2lscgLPxHwlP9WxCmAQorFEPyhQ+w6fR0LTqEsAcwF3Y3pfxGi
         9Q/TCo6FQEAIg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2BFDB15C0243; Sat, 11 Nov 2023 23:52:17 -0500 (EST)
Date:   Sat, 11 Nov 2023 23:52:17 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Willy Tarreau <w@1wt.eu>
Cc:     York Jasper Niebuhr <yjnworkstation@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] exitz syscall
Message-ID: <20231112045217.GA39417@mit.edu>
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231111132431.GA3717@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 02:24:31PM +0100, Willy Tarreau wrote:
> Hello,
> 
> On Sat, Nov 11, 2023 at 01:51:26PM +0100, York Jasper Niebuhr wrote:
> > Adds a system call to flag a process' resources to be cleared on
> > exit (or, in the case of memory, on free). Currently, only zeroing
> > memory is implemented.
> (...)
> 
> IMHO it does not make sense to add a syscall for this, please have a
> look at prctl(2) instead, which is already used for similar settings.

Another reason to use prctl() is there are other cases when you'd want
to zero a process's memory.  For example, if the process gets killed
to some kind of signal, or when it gets OOM killed (where there is no
system call which forces the process to exit).  Also, if you want to
zero memory when the process exits, you'd want to zero the process
memory on an exec(2).

Cheers,

						- Ted
