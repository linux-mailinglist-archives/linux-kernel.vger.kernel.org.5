Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5726811083
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 12:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378195AbjLMLtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 06:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjLMLtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 06:49:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC0B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 03:49:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C3CC433C7;
        Wed, 13 Dec 2023 11:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702468151;
        bh=gspTYGLvdxm7u26jTqUP9QE4qxk4YHzbc1GF9KCiV7E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jMPgGAXsD59orXEQwSuT3rrXWW+pwXyhY9fvZ8X6kscY5uXVHv+7pQdZ8goX2tQg2
         YnuEt2SSM/+22Vslb33Z83s5HAblMc1uQOIaG4veD5qb26z++yizSosHRt/zeNJpDD
         sfJk9uv4C59KHCtmYD2t+RV+82qkDt21V06xknzZ4iINstdfEXqU4zfhj4uKCi/J+G
         EsWkDUP8byKlb9sAFOVfbuceSmcQJsTYHZu7QeY/MivUpoRnnF3fRE3KKFA+0Qu5dW
         aVht0LKmFKpZLjEFy5xGUQtQ/UH0eUsSY0jQ18zyyKdoMrXvxkyPosGgru0Aj5veHw
         UplXJHZ3IJyIA==
Date:   Wed, 13 Dec 2023 11:49:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: fotg210-hcd: delete an incorrect bounds test
Message-ID: <20231213114906.GL111411@google.com>
References: <87dfa523-1882-417d-97b5-f606ff0099f9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87dfa523-1882-417d-97b5-f606ff0099f9@moroto.mountain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2023, Dan Carpenter wrote:

> Here "temp" is the number of characters that we have written and "size"
> is the size of the buffer.  The intent was clearly to say that if we have
> written to the end of the buffer then stop.
> 
> However, for that to work the comparison should have been done on the
> original "size" value instead of the "size -= temp" value.  Not only
> will that not trigger when we want to, but there is a small chance that
> it will trigger incorrectly before we want it to and we break from the
> loop slightly earlier than intended.
> 
> This code was recently changed from using snprintf() to scnprintf().  With
> snprintf() we likely would have continued looping and passed a negative
> size parameter to snprintf().  This would have triggered an annoying
> WARN().  Now that we have converted to scnprintf() "size" will never
> drop below 1 and there is no real need for this test.  We could change
> the condition to "if (temp <= 1) goto done;" but just deleting the test
> is cleanest.
> 
> Fixes: 1dd33a9f1b95 ("usb: fotg210: Collect pieces of dual mode controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/usb/fotg210/fotg210-hcd.c | 3 ---
>  1 file changed, 3 deletions(-)

Super additional clean-up, thanks.

Reviewed-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg210-hcd.c
> index b2f8b53cc8ef..8c5aaf860635 100644
> --- a/drivers/usb/fotg210/fotg210-hcd.c
> +++ b/drivers/usb/fotg210/fotg210-hcd.c
> @@ -426,8 +426,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
>  				td->urb);
>  		size -= temp;
>  		next += temp;
> -		if (temp == size)
> -			goto done;
>  	}
>  
>  	temp = scnprintf(next, size, "\n");
> @@ -435,7 +433,6 @@ static void qh_lines(struct fotg210_hcd *fotg210, struct fotg210_qh *qh,
>  	size -= temp;
>  	next += temp;
>  
> -done:
>  	*sizep = size;
>  	*nextp = next;
>  }
> -- 
> 2.42.0
> 

-- 
Lee Jones [李琼斯]
