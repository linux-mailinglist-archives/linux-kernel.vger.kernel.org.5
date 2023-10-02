Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B07B594A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbjJBQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbjJBQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:57:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D1B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:57:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3f97f2239so243205ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696265861; x=1696870661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i59JrJXWn0I4GHAvwruiaJLmC8yZXpZX5lGiOcVDgzc=;
        b=PeLHX79hqfPPghINRHy0NyX1l38B9zVeBq+7a8z4kHmh4FFCx+7eB6/gKx3ef/oszV
         fiWE6PMcj9ge30QBGjV+52aCFjzmMO5wu0nFmyJg3zX1SN5xfYr9SM63OEtfb4tKS2Dl
         MfXWWLL1Ej+9ZQra2TN8dWtqRfklqut//hn8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696265861; x=1696870661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i59JrJXWn0I4GHAvwruiaJLmC8yZXpZX5lGiOcVDgzc=;
        b=l0/fh46eU3VAvaaSuZOMbzG1LlVFU3wXry/S4MHszZyM/6y2BGdyPdONH1Yx0SM6oJ
         orslir6feu7gD11OtV8A4CzhP51LRaX4ujI+BB5r0zdJI/7g5MqAsSr3gKckVXLXoa0s
         l5EBNlGkrAfc3RCxcjyoR2s2yO/qLVzv3qKufyz6wKyh1peRiZQZ+bGuVN5wh66Q78EJ
         +EULeLUYOCMM7ua44c/2RewuwUh6NhjJZWpfUOfo9qqQVmjHVTcyaCCOe/21DpjAyN7t
         iRMzeF2oAV/yAVLA+Y+flpEXGqJqnlXXE9iZNPye3dN2DR8Jqvt67p/3pUf1PLO3dm0h
         OwDQ==
X-Gm-Message-State: AOJu0Yx4trHgyrp+RS0BomqrjnFD6GAuf5yKNZz0qr3TN9XgCzhkzdiS
        FYL5Yo0UrM3LFhf7MhPOX05nhA==
X-Google-Smtp-Source: AGHT+IGnn5OV17hnLKq0t7/owjFSVTDzAdiCLLhTlLFY2ZcuMqxzI7nr2Ppl/kYZdYMGR2rJMkFcew==
X-Received: by 2002:a17:902:c409:b0:1c5:f4c7:b4d5 with SMTP id k9-20020a170902c40900b001c5f4c7b4d5mr14735849plk.34.1696265860790;
        Mon, 02 Oct 2023 09:57:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001c728609574sm10420569plw.6.2023.10.02.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 09:57:40 -0700 (PDT)
Date:   Mon, 2 Oct 2023 09:57:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/5] params: Do not go over the limit when getting the
 string length
Message-ID: <202310020956.AF556DC@keescook>
References: <20231002124856.2455696-1-andriy.shevchenko@linux.intel.com>
 <20231002124856.2455696-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002124856.2455696-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:48:53PM +0300, Andy Shevchenko wrote:
> We can use strnlen() even on early stages and it prevents from
> going over the string boundaries in case it's already too long.

It makes sense to avoid calling strlen() multiple times. I don't have
much opinion one way or another about using strnlen() here, since we
know the string will be terminated.

-Kees

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  kernel/params.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/params.c b/kernel/params.c
> index 626fa8265932..f8e3c4139854 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -260,7 +260,10 @@ EXPORT_SYMBOL_GPL(param_set_uint_minmax);
>  
>  int param_set_charp(const char *val, const struct kernel_param *kp)
>  {
> -	if (strlen(val) > 1024) {
> +	size_t len, maxlen = 1024;
> +
> +	len = strnlen(val, maxlen + 1);
> +	if (len == maxlen + 1) {
>  		pr_err("%s: string parameter too long\n", kp->name);
>  		return -ENOSPC;
>  	}
> @@ -270,7 +273,7 @@ int param_set_charp(const char *val, const struct kernel_param *kp)
>  	/* This is a hack.  We can't kmalloc in early boot, and we
>  	 * don't need to; this mangled commandline is preserved. */
>  	if (slab_is_available()) {
> -		*(char **)kp->arg = kmalloc_parameter(strlen(val)+1);
> +		*(char **)kp->arg = kmalloc_parameter(len + 1);
>  		if (!*(char **)kp->arg)
>  			return -ENOMEM;
>  		strcpy(*(char **)kp->arg, val);
> @@ -508,7 +511,7 @@ int param_set_copystring(const char *val, const struct kernel_param *kp)
>  {
>  	const struct kparam_string *kps = kp->str;
>  
> -	if (strlen(val)+1 > kps->maxlen) {
> +	if (strnlen(val, kps->maxlen) == kps->maxlen) {
>  		pr_err("%s: string doesn't fit in %u chars.\n",
>  		       kp->name, kps->maxlen-1);
>  		return -ENOSPC;
> -- 
> 2.40.0.1.gaa8946217a0b
> 

-- 
Kees Cook
