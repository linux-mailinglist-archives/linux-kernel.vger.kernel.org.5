Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B277C4C67
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjJKHxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjJKHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:53:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F65CA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:53:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E99C433C7;
        Wed, 11 Oct 2023 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697010794;
        bh=GgwVDJvvCqbsJ90WXFWRK1qi4oMBE8/9c9WObZa6mTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ufsbm2XEeGZiZuQF7Rx85fJ0Dr79urIechCSfD3UoU9/1pr6rejnp6a0cpQ4dZ29l
         2hs+omIR49qqY5B2EXpsGUl6a0VgRK/EzeHUk4HJ8c0zG5YRvHeANwWWUxZPGFQ4+2
         bCOeg4HshlZa3isAz9F0sj02lUKBMYoCxiPAk8Ps=
Date:   Wed, 11 Oct 2023 09:53:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] printk: Check valid console index for preferred
 console
Message-ID: <2023101131-maroon-stubborn-1364@gregkh>
References: <20231011074330.14487-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011074330.14487-1-tony@atomide.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 10:43:25AM +0300, Tony Lindgren wrote:
> Let's check for valid console index values to avoid bogus console index
> numbers from kernel command line. While struct console uses short for
> index, and negative index values are used by some device drivers, we do
> not want to allow negative values for preferred console.

What drivers use a negative index for the console?

> Let's change the idx to short to match struct console, and return an error
> on negative values. And let's also constify idx while at it.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> 
> - Use const short idx and return an error on negative values
> 
> ---
>  include/linux/console.h |  2 +-
>  kernel/printk/printk.c  | 11 +++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/console.h b/include/linux/console.h
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -340,7 +340,7 @@ enum con_flush_mode {
>  	CONSOLE_REPLAY_ALL,
>  };
>  
> -extern int add_preferred_console(char *name, int idx, char *options);
> +extern int add_preferred_console(char *name, const short idx, char *options);
>  extern void console_force_preferred_locked(struct console *con);
>  extern void register_console(struct console *);
>  extern int unregister_console(struct console *);
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2404,12 +2404,19 @@ static void set_user_specified(struct console_cmdline *c, bool user_specified)
>  	console_set_on_cmdline = 1;
>  }
>  
> -static int __add_preferred_console(char *name, int idx, char *options,
> +static int __add_preferred_console(const char *name, const short idx, char *options,
>  				   char *brl_options, bool user_specified)
>  {
>  	struct console_cmdline *c;
>  	int i;
>  
> +	/*
> +	 * Negative struct console index may be valid for drivers in some cases,
> +	 * but negative index is not valid for a preferred console.
> +	 */
> +	if (idx < 0)
> +		return -EINVAL;

Looks good to me, I'll take this through my tty tree if no one objects.

thanks,

greg k-h
