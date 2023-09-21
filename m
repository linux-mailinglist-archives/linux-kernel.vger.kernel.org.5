Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0847E7AA314
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjIUVqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjIUVq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:46:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFB55ADD
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:26:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 989E0338AF;
        Thu, 21 Sep 2023 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695306156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dn1k1r5da4rQtEd0iZuQ+iYXLZlUQCaqY/0AqZ+Wc8o=;
        b=F7oiSwksmb4QB309/9SpOd5+wU90hYM8knO4UaWwEEdJ9tc/Qm6y8/YIVJEFBrdVM5oEPR
        3iNqZh/h5TvIrc2B0HtA6QJZN31AuNtVkW0yfuaXSZMmWsZj/poy8yx4XGvrXf6Vao7aZc
        byHYSE+I/hweyKYWpwZzt1yhkQmJRUI=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2DE732C142;
        Thu, 21 Sep 2023 14:22:35 +0000 (UTC)
Date:   Thu, 21 Sep 2023 16:22:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: fix the check on modifying printk_devkmsg
Message-ID: <ZQxRqxLFWZ1w45qE@alley>
References: <20230816234745.2856989-1-yun.zhou@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816234745.2856989-1-yun.zhou@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, I am sorry for the late review. So many things have accumulated
during my vacation.

On Thu 2023-08-17 07:47:45, Yun Zhou wrote:
> When we use 'echo' to write a string to printk_devkmsg, it writes '\0' at
> the end. It means lenp is larger then the length of string 1. However,
> sometimes we write data with string length by other way, e.g
>     write(fd, string, strlen(string));
> In this case, the writing will fail.
> 
> Comparing err with string length is able to handle all scenarios.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  kernel/printk/printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 357a4d18f6387..992872f7b7747 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -229,7 +229,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>  		 * Do not accept an unknown string OR a known string with
>  		 * trailing crap...
>  		 */
> -		if (err < 0 || (err + 1 != *lenp)) {
> +		if (err != strlen(devkmsg_log_str)) {
>  
>  			/* ... and restore old setting. */
>  			devkmsg_log = old;

I see. _proc_do_string() does the following:

_proc_do_string(char *data, int maxlen, int write,
		char *buffer, size_t *lenp, loff_t *ppos)
{
[...]
	if (write) {
[...]
		*ppos += *lenp;
		p = buffer;
		while ((p - buffer) < *lenp && len < maxlen - 1) {
			c = *(p++);
			if (c == 0 || c == '\n')
				break;
			data[len++] = c;
		}
		data[len] = 0;

It means that it proceeds "*lenp" characters but the trailing
'\0' need not match. It might be inserted earlier when
(c == 0 || c == '\n') was true earlier. Or one bite behind when
the trailing '\0' was missing within the *lenp characters.

As a result, the *lenp check is not reliable.

Reviewed-by: Petr Mladek <pmladek@suse.com>
