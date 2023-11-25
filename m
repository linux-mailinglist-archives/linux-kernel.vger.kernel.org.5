Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C9D7F88F2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjKYHsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:48:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E507610F6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:48:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AEEC433C8;
        Sat, 25 Nov 2023 07:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700898524;
        bh=2Jqvgdk2LpiV1WxebiiaBPjnXuNkuIUOCoXEMB6dMgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6eKkn/Lpf0Na1PwR3q0Nc9EpletVID6t2uGQTizJ0bBHU8T5dmAJrHfyIfZ609+Y
         Yc0nv8ke+kSp+LuCytllFm86LqbCcVQrmMX6lZd8ixrC5x/EF+wewWwSVCD5vSh6+q
         wP5N6pCisVTRJTMOHjY2hdSpIeMRN7PglaDSYyts=
Date:   Sat, 25 Nov 2023 07:48:41 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phillip Potter <phil@philpotter.co.uk>
Subject: Re: [PATCH V3] media: stk1160: Fixed high volume of stk1160_dbg
 messages
Message-ID: <2023112554-bagginess-banker-089e@gregkh>
References: <20231125073738.649948-1-ghanshyam1898@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125073738.649948-1-ghanshyam1898@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:07:38PM +0530, Ghanshyam Agrawal wrote:
> The function stk1160_dbg gets called too many times, which causes
> the output to get flooded with messages. Since stk1160_dbg uses
> printk, it is now replaced with printk_ratelimited directly.
> 
> Suggested-by: Phillip Potter <phil@philpotter.co.uk>
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
> V3:
> Fixed the issue with my patch needing previous versions being applied
> first.
> 
> Used printk_ratelimited instead of dev_warn_ratelimited because
> of compiler error "incompatible pointer type".
> 
> V2:
> To add KERN_WARNING in printk_ratelimited, and later as per warning by
> the checkpatch script, replaced  printk_ratelimited with 
> dev_warn_ratelimited.
> 
> V1:
> The function stk1160_dbg gets called too many times, which causes
> the output to get flooded with messages. Since stk1160_dbg uses
> printk, it is now replaced with dev_warn_ratelimited.
> 
>  drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> index 4e966f6bf608..98417fa31d70 100644
> --- a/drivers/media/usb/stk1160/stk1160-video.c
> +++ b/drivers/media/usb/stk1160/stk1160-video.c
> @@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>  
>  	/*
>  	 * TODO: These stk1160_dbg are very spammy!
> -	 * We should 1) check why we are getting them
> -	 * and 2) add ratelimit.
> +	 * We should check why we are getting them.
>  	 *
>  	 * UPDATE: One of the reasons (the only one?) for getting these
>  	 * is incorrect standard (mismatch between expected and configured).
> @@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
>  
>  	/* Let the bug hunt begin! sanity checks! */
>  	if (lencopy < 0) {
> -		stk1160_dbg("copy skipped: negative lencopy\n");
> +		printk_ratelimited(KERN_WARNING "copy skipped: negative lencopy\n");

You changed a debug message level to a KERN_WARNING level?  That feels
like a step backwards.

thanks,

greg k-h
