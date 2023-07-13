Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7998F75258C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGMOvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjGMOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:51:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0A02706
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:51:36 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F89922012;
        Thu, 13 Jul 2023 14:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689259895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oO7aD35eYMKobQdpQfGHe4xxRqZLVh3XRDwJLqLCZak=;
        b=idhWlAruB5rF+nWw49jSmOaDY58XsmbhmzOUKUm5LVUA0FU7Ut7JdAfI3nwzimVbbTLa/9
        Jq6qio104uHKsGQv07Ym1x8F45/bFnF29TeDHarS45tF7PopFv7y6KQLpyUUMP2QP/ih4U
        YlGvlk18qwMcOsqvWAYBqLy2vTYm7HU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4688D2C142;
        Thu, 13 Jul 2023 14:51:35 +0000 (UTC)
Date:   Thu, 13 Jul 2023 16:51:33 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 3/5] printk: Consolidate console deferred
 printing
Message-ID: <ZLAPdSFhvTRkeBPz@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-10 15:51:22, John Ogness wrote:
> Printing to consoles can be deferred for several reasons:
> 
> - explicitly with printk_deferred()
> - printk() in NMI context
> - recursive printk() calls
> 
> The current implementation is not consistent. For printk_deferred(),
> irq work is scheduled twice. For NMI und recursive, panic CPU
> suppression and caller delays are not properly enforced.
> 
> Correct these inconsistencies by consolidating the deferred printing
> code so that vprintk_deferred() is the top-level function for
> deferred printing and vprintk_emit() will perform whichever irq_work
> queueing is appropriate.
> 
> Also add kerneldoc for wake_up_klogd() and defer_console_output() to
> clarify their differences and appropriate usage.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
