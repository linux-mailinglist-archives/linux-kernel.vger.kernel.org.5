Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69877E353A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 07:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjKGGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 01:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 01:31:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CF4122
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:31:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A17DC433C7;
        Tue,  7 Nov 2023 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699338690;
        bh=ZbbXEst1MN/YJ42gHNB9eN+R+I0GdIoD7UuNAgu6/yQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf1/0XV+gkdPJBLGuEoR2UXNy7zwrTPyTD2jOyIuNHR0KzHKF1XISytb25na/r5Y8
         kvuGsJd5Cqg2pk8fq1Cvtlqb4iRJjEd31GSk+J+l9rmMKy5V2eKeG0JRudF/+lFLza
         iqNbYODmazsUFGcYdSb0qQH20121Fnr2zo4JY9v4=
Date:   Tue, 7 Nov 2023 07:31:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuran Pereira <yuran.pereira@hotmail.com>
Cc:     linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        marcel@holtmann.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] Bluetooth: Replaces printk with pr_debug in bt_dbg
Message-ID: <2023110752-headset-gains-41a7@gregkh>
References: <DB3PR10MB6835C002EB4C5A05AD17610BE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
 <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3PR10MB6835DE6D279B65EC040B92AEE8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:56:08AM +0530, Yuran Pereira wrote:
> bt_dbg() uses printk, as opposed to other functions in this file
> which use pr_* family of logging functions.
> 
> This patch changes that by replacing `printk(KERN_DEBUG` with
> the equivalent pr_debug() call which makes the overall file
> look more uniform and cleaner.
> 
> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  net/bluetooth/lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
> index 063032fe9c68..96ba39f8b461 100644
> --- a/net/bluetooth/lib.c
> +++ b/net/bluetooth/lib.c
> @@ -329,7 +329,7 @@ void bt_dbg(const char *format, ...)
>  	vaf.fmt = format;
>  	vaf.va = &args;
>  
> -	printk(KERN_DEBUG pr_fmt("%pV"), &vaf);
> +	pr_debug("%pV", &vaf);

You might have just changed the functionality here, are you SURE this is
identical to the original code?  How was it tested?

I'm not saying this is a bad idea to do, just be aware of the
consequences for this change and document it properly (hint, the
changelog does not document the user-visible change that just happened.)

Note, pr_debug() is NOT identical to printk(), look at the source for
the full details.

thanks,

greg k-h
