Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D027EA2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 19:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbjKMSdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 13:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjKMSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 13:33:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221B2D68;
        Mon, 13 Nov 2023 10:33:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F72C433D9;
        Mon, 13 Nov 2023 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699900429;
        bh=8NjS89hbWhwt4yhDIQItvSnRL6mEheaGL6+ZT7V8APc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDJb8ouT1juPLx8+Zl6jcFByZ9IMVbdRaeUf3O2XAqDIp2d13t+RLv3CIfaVcdsYj
         KdSMPrKQMXhHPYtmeArlF5Di22WLoeNPMnBYdaK0fl+Up5Q/V6xOFr34MDh+V75tgu
         4BtSme2Br4b+pLk193hBhHmcRfdJDpyp0jDoc528=
Date:   Mon, 13 Nov 2023 13:33:48 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tomas Mudrunka <tomas.mudrunka@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] /proc/sysrq-trigger: accept multiple keys at once
Message-ID: <2023111333-duly-mobility-edc7@gregkh>
References: <20231113182227.698989-1-tomas.mudrunka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113182227.698989-1-tomas.mudrunka@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 07:22:19PM +0100, Tomas Mudrunka wrote:
> Just for convenience.
> This way we can do:
> `echo reisub > /proc/sysrq-trigger`
> Instead of:
> `for i in r e i s u b; do echo "$i" > /proc/sysrq-trigger; done;`
> 
> Signed-off-by: Tomas Mudrunka <tomas.mudrunka@gmail.com>
> ---
>  drivers/tty/sysrq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 6b4a28bcf..bc5a679f6 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -1154,10 +1154,12 @@ EXPORT_SYMBOL(unregister_sysrq_key);
>  static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
>  				   size_t count, loff_t *ppos)
>  {
> -	if (count) {
> +	size_t i;
> +
> +	for (i = 0; i < count; i++) {
>  		char c;
>  
> -		if (get_user(c, buf))
> +		if (get_user(c, buf+i))

What did you just break where people would send a string and only relied
on the first character being checked?  This might not be ok to do.

Also, no documentation update?

thanks,

greg k-h
