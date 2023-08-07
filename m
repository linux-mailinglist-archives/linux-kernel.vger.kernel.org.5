Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ECF772885
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjHGPD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHGPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:03:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DA610DE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 08:03:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE1E91FE49;
        Mon,  7 Aug 2023 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691420600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3A2NsvXpmNRnd8PNau9KuaPdja1LGVqq+oucwV7B34=;
        b=e6SNj8R713ZAAtu9DcuUfZqEtfKTl8DeMypsLAoGTGdfqcoR4T2yEVzvjrykJiB1+VmeYO
        vcmcyfr/xYigmi95BOsdYOgMbOC+xj8cZff8BI/GiNnTw8pgUn9StcWccERojMAS69TpnF
        SqkgvXce6Ob9uND7M59kPc3u1X0maqI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5ADD22C142;
        Mon,  7 Aug 2023 15:03:20 +0000 (UTC)
Date:   Mon, 7 Aug 2023 17:03:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNEHt564a8RCLWon@alley>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2023-08-05 20:50:26, Andy Shevchenko wrote:
> kernel.h is being used as a dump for all kinds of stuff for a long time.
> sprintf() and friends are used in many drivers without need of the full
> kernel.h dependency train with it.
> 
> Here is the attempt on cleaning it up by splitting out sprintf() and
> friends.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/kernel.h  | 30 +-----------------------------
>  include/linux/sprintf.h | 25 +++++++++++++++++++++++++
>  lib/test_printf.c       |  1 +
>  lib/vsprintf.c          |  1 +
>  4 files changed, 28 insertions(+), 29 deletions(-)
>  create mode 100644 include/linux/sprintf.h

I agree that kernel.h is not the right place. But are there any
numbers how much separate sprintf.h might safe?

Maybe, we should not reinvent the wheel and get inspired by
userspace.

sprintf() and friends are basic functions which most people know
from userspace. And it is pretty handy that the kernel variants
are are mostly compatible as well.

IMHO, it might be handful when they are also included similar way
as in userspace. From my POV printk.h is like stdio.h. And we already
have include/linux/stdarg.h where the v*print*() function might
fit nicely.

How does this sound, please?

Best Regards,
Petr
