Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0597DA7C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjJ1P1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1P1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:27:43 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3952DF3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:27:40 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id wlDtqYmVP63GJwlDtqx8Ol; Sat, 28 Oct 2023 17:27:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698506858;
        bh=Rr61ezqlXIq+++3fG0PqDAvd8T62b+RT8E7liIDwSbI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=JaK34++6Peed5B3Y4WwXjt7qsuwfg4ZQp5BCr1IxNyZY0F9M9QpVc2671n0v9rgX3
         B0IcKccT08IF8fLuo/rhu++vuCEcVRsI/92rboy2I+pOdsQ5uFDjF5FtTZzGn6/orq
         Zxv1dv+FjBUHhBwSGIruFeyLTwwv5FwymTGs3Q5Hc4iKeDS98TTE9qCUK7UVlL7yKv
         5JSHQleTGkb9aow4KtNUmNzeaMwG2idl05oqc06iY+NaM1Hs+0AUgICQLsh6uUMh3q
         0IUbFCbPY4kVVs02k1Lk55cKfXSfE6XTr4KHJBMSjmpz7GqnrqF8JFG3iRdIPnx9AY
         o/I828mmiNrfg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 28 Oct 2023 17:27:38 +0200
X-ME-IP: 86.243.2.178
Message-ID: <701141cc-bfe8-4bde-93cd-5fd7d13da3e4@wanadoo.fr>
Date:   Sat, 28 Oct 2023 17:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc2: Use seq_buf instead of hand writing it
Content-Language: fr
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <4c8b71efe4fe05ed0cc37f33ef774746d4d55299.1698489641.git.christophe.jaillet@wanadoo.fr>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <4c8b71efe4fe05ed0cc37f33ef774746d4d55299.1698489641.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/10/2023 à 12:41, Christophe JAILLET a écrit :
> cat_printf() re-implements what the seq_buf API does.
> So, switch to the seq_buf API to save some line of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

NACK.

This was built tested, but i think that DWC2_PRINT_SCHEDULE was not defined.

	seq_buf_init((&s, tmp, sizeof(tmp));
can't compile, 's' is not defined.

Let me give another look at it.

CJ

> ---
> seq_buf_printf(&buf, ", "); could be seq_buf_puts(), but the result could
> be slightly different. So I kept a conservative approach.
> 
> If only some seq_buf_printf() are used, the final seq_buf_terminate() can
> be avoided, but I think it is cleaner with it.
> ---
>   drivers/usb/dwc2/hcd_queue.c | 53 ++++++++----------------------------
>   1 file changed, 11 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> index 0d4495c6b9f7..66fb74a70bdd 100644
> --- a/drivers/usb/dwc2/hcd_queue.c
> +++ b/drivers/usb/dwc2/hcd_queue.c
> @@ -18,6 +18,7 @@
>   #include <linux/io.h>
>   #include <linux/slab.h>
>   #include <linux/usb.h>
> +#include <linux/seq_buf.h>
>   
>   #include <linux/usb/hcd.h>
>   #include <linux/usb/ch11.h>
> @@ -359,41 +360,6 @@ static unsigned long *dwc2_get_ls_map(struct dwc2_hsotg *hsotg,
>   }
>   
>   #ifdef DWC2_PRINT_SCHEDULE
> -/*
> - * cat_printf() - A printf() + strcat() helper
> - *
> - * This is useful for concatenating a bunch of strings where each string is
> - * constructed using printf.
> - *
> - * @buf:   The destination buffer; will be updated to point after the printed
> - *         data.
> - * @size:  The number of bytes in the buffer (includes space for '\0').
> - * @fmt:   The format for printf.
> - * @...:   The args for printf.
> - */
> -static __printf(3, 4)
> -void cat_printf(char **buf, size_t *size, const char *fmt, ...)
> -{
> -	va_list args;
> -	int i;
> -
> -	if (*size == 0)
> -		return;
> -
> -	va_start(args, fmt);
> -	i = vsnprintf(*buf, *size, fmt, args);
> -	va_end(args);
> -
> -	if (i >= *size) {
> -		(*buf)[*size - 1] = '\0';
> -		*buf += *size;
> -		*size = 0;
> -	} else {
> -		*buf += i;
> -		*size -= i;
> -	}
> -}
> -
>   /*
>    * pmap_print() - Print the given periodic map
>    *
> @@ -417,8 +383,7 @@ static void pmap_print(unsigned long *map, int bits_per_period,
>   
>   	for (period = 0; period < periods_in_map; period++) {
>   		char tmp[64];
> -		char *buf = tmp;
> -		size_t buf_size = sizeof(tmp);
> +		struct seq_buf buf;
>   		int period_start = period * bits_per_period;
>   		int period_end = period_start + bits_per_period;
>   		int start = 0;
> @@ -426,6 +391,8 @@ static void pmap_print(unsigned long *map, int bits_per_period,
>   		bool printed = false;
>   		int i;
>   
> +		seq_buf_init((&s, tmp, sizeof(tmp));
> +
>   		for (i = period_start; i < period_end + 1; i++) {
>   			/* Handle case when ith bit is set */
>   			if (i < period_end &&
> @@ -442,17 +409,19 @@ static void pmap_print(unsigned long *map, int bits_per_period,
>   				continue;
>   
>   			if (!printed)
> -				cat_printf(&buf, &buf_size, "%s %d: ",
> -					   period_name, period);
> +				seq_buf_printf(&buf, "%s %d: ", period_name,
> +					       period);
>   			else
> -				cat_printf(&buf, &buf_size, ", ");
> +				seq_buf_printf(&buf, ", ");
>   			printed = true;
>   
> -			cat_printf(&buf, &buf_size, "%d %s -%3d %s", start,
> -				   units, start + count - 1, units);
> +			seq_buf_printf(&buf, "%d %s -%3d %s", start, units,
> +				       start + count - 1, units);
>   			count = 0;
>   		}
>   
> +		seq_buf_terminate(&s);
> +
>   		if (printed)
>   			print_fn(tmp, print_data);
>   	}

