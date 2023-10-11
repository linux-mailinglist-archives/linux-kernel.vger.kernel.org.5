Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190E47C4BF5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345207AbjJKHeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345040AbjJKHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:34:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 876AF91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:34:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 0154880E1;
        Wed, 11 Oct 2023 07:34:06 +0000 (UTC)
Date:   Wed, 11 Oct 2023 10:34:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Check valid console index for preferred console
Message-ID: <20231011073405.GB34982@atomide.com>
References: <20231004085434.42570-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004085434.42570-1-tony@atomide.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [700101 02:00]:
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2410,6 +2410,10 @@ static int __add_preferred_console(char *name, int idx, char *options,
>  	struct console_cmdline *c;
>  	int i;
>  
> +	/* See struct console */
> +	if (idx > SHRT_MAX)
> +		return -EINVAL;
> +

We can just use const short idx for preferred console and return an error
for negative values for preferred console. I'll send out v2 patch.

Regards,

Tony
