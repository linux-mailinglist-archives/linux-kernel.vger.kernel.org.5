Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8E7C6588
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbjJLGZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377474AbjJLGZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:25:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6A22121
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id BE20980E1;
        Thu, 12 Oct 2023 06:24:49 +0000 (UTC)
Date:   Thu, 12 Oct 2023 09:24:48 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Check valid console index for preferred
 console
Message-ID: <20231012062448.GF34982@atomide.com>
References: <20231011074330.14487-1-tony@atomide.com>
 <18944d40-321a-46b2-b97c-a8c3f98daccd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18944d40-321a-46b2-b97c-a8c3f98daccd@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [231012 05:54]:
> On 11. 10. 23, 9:43, Tony Lindgren wrote:
> > Let's check for valid console index values to avoid bogus console index
> > numbers from kernel command line. While struct console uses short for
> > index, and negative index values are used by some device drivers, we do
> > not want to allow negative values for preferred console.
> > 
> > Let's change the idx to short to match struct console, and return an error
> > on negative values. And let's also constify idx while at it.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> ...
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2404,12 +2404,19 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
> >   	console_set_on_cmdline = 1;
> >   }
> > -static int __add_preferred_console(char *name, int idx, char *options,
> > +static int __add_preferred_console(const char *name, const short idx, char *options,
> 
> This "const char *name" change is somehow not related to 1/2, but to 2/2, I
> suppose.

Thanks I just noticed that too, that sneaked in while I was resolving a
merge conflict while changing the order of the two patches.

Regards,

Tony
