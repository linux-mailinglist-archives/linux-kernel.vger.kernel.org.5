Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA27DE4D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjKAQsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKAQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:48:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75565FD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 09:48:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1AE051F74A;
        Wed,  1 Nov 2023 16:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698857324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9LlQDf6L5flbywxuUr0vUhsjISwDWf3rnihr9I/fAx8=;
        b=AfVhE87VJNvxstipLdhohGxwA0Ka27gY0FYJCjWzEnMBG4nBmnprOs4r0iY3lblC0d4lHF
        77R/Ht/ltb+9IaYVUbljGS3VsVnN8yn8irFYFNvID4fldXhkkx1eFR8NPPWMDRWPIycQ1F
        ExPXyw83Fl+BcTfSjtZmiP+kgAdCOoE=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B4242C33E;
        Wed,  1 Nov 2023 16:48:43 +0000 (UTC)
Date:   Wed, 1 Nov 2023 17:48:43 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vsprintf: uninline simple_strntoull(), reorder arguments
Message-ID: <ZUKBa0iTH6YBIPS_@alley>
References: <82a2af6e-9b6c-4a09-89d7-ca90cc1cdad1@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82a2af6e-9b6c-4a09-89d7-ca90cc1cdad1@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-10-27 17:13:58, Alexey Dobriyan wrote:
> * uninline simple_strntoull(),
>   gcc overinlines and this function is not performance critical
> 
> * reorder arguments, so that appending INT_MAX as 4th argument
>   generates very efficient tail call
> 
> Space savings:
> 
> 	add/remove: 1/0 grow/shrink: 0/3 up/down: 27/-179 (-152)
> 	Function                            old     new   delta
> 	simple_strntoll                       -      27     +27
> 	simple_strtoull                      15      10      -5
> 	simple_strtoll                       41       7     -34
> 	vsscanf                            1930    1790    -140
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

I am usually quite skeptical about these micro-optimizations. They might
help only on some architectures with some compiler versions. And
they might make it worse for others.

Well, I could imagine that passing constant via the last parameter
might help in most cases. And the new ordering of the parameters
is fine. So let's get it in.

Reviewed-by: Petr Mladek <pmladek@suse.com>

I have just pushed the patch into printk/linux.git, branch for-6.7.

Best Regards,
Petr
