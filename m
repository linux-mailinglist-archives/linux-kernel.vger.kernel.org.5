Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D357B59BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238039AbjJBRuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbjJBRuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:50:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019B6E5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:50:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-692d2e8c003so2297496b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696269050; x=1696873850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6LTVtBdQwyffDdkyOthmcLPzL+TcPsE+wXsu6L8tqo=;
        b=SNQ0jdC+l+/YKGbd0QCpphMZif0PHo7Tedsby7WYxws/JwMgLGLzUkf3t+tg3SbkMm
         8dngLvGkHGcegK8BGYT9v6aq1p2yGlLphmPnV+ZqClFwaDmzdVmU0ajbg3EyX3rM9Pb/
         GftevvByqhAOHjBqNkFTuulgedjk620zjwMgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269050; x=1696873850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6LTVtBdQwyffDdkyOthmcLPzL+TcPsE+wXsu6L8tqo=;
        b=l/IyvfpCIHviSv9qIThJc+/OtwwC2sW4y1632QixrqrKyVbSX6CUjXrq3deNfaOGtP
         /UVR0mWxC1LdAdcR78iD+5NLYbsWTZ5DMQxUdIt9w+O51RPNfZDpg3BH1lZfY9C2G44v
         4lWBZKoVjSf+DRwrvG+74ks5Zs592jlh6WB+lG/o5NYqAuuMagVcYlQQ3VHMcf33hBAj
         XC4OZCDgm4iW4IgrNhuyxHLy9ILNpUcLK0jNF83GxsbIJarOnz1YtAYPfJURMCe2XFAD
         OY8l48K7jvxoK8wV/GcwA8Tyod4UCbmOo1ptObGSMu/fmQok/UCSOeD9sf86/G1TtuXF
         yYgQ==
X-Gm-Message-State: AOJu0YweeAWBLDEVb0uLwE3kcW+xttEhqNvektcT4iHliWtmWnDcrw/g
        BQ3xs8Ubl9gOo+M9X2IaUDRmwOft/CqhtLr+D3A=
X-Google-Smtp-Source: AGHT+IHwyE5uceh2fKRq6zo0UrhOLBVICH0oGIR89K8eolqmFM72O6lmzJq3w8zwcNX60UAzD8wWrw==
X-Received: by 2002:a05:6a00:995:b0:693:43b5:aaf3 with SMTP id u21-20020a056a00099500b0069343b5aaf3mr437525pfg.13.1696269050426;
        Mon, 02 Oct 2023 10:50:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k9-20020aa78209000000b0069348918cfcsm7869876pfi.193.2023.10.02.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:50:49 -0700 (PDT)
Date:   Mon, 2 Oct 2023 10:50:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] eeprom: idt_89hpesx: replace open-coded kmemdup_nul
Message-ID: <202310021050.B6A9651@keescook>
References: <20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-v1-1-08e3d45b8c05@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-v1-1-08e3d45b8c05@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 05:37:06AM +0000, Justin Stitt wrote:
> A malloc + strncpy + manual NUL_termination is just kmemdup_nul. Let's use
> this interface as it is less error-prone and more readable.
> 
> Also drop `csraddr_len` as it is just used in a single place and we can
> just do the arithmetic in-line.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>

Yup, this looks correct to me. Another good case of using kmemdup_nul().

Reviewed-by: Kees Cook <keescook@chromium.org>

> ---
> Note: build-tested only.
> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index 1d1f30b5c426..d807d08e2614 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -905,7 +905,7 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
>  {
>  	struct idt_89hpesx_dev *pdev = filep->private_data;
>  	char *colon_ch, *csraddr_str, *csrval_str;
> -	int ret, csraddr_len;
> +	int ret;
>  	u32 csraddr, csrval;
>  	char *buf;
>  
> @@ -927,21 +927,16 @@ static ssize_t idt_dbgfs_csr_write(struct file *filep, const char __user *ubuf,
>  	 * no new CSR value
>  	 */
>  	if (colon_ch != NULL) {
> -		csraddr_len = colon_ch - buf;
> -		csraddr_str =
> -			kmalloc(csraddr_len + 1, GFP_KERNEL);
> +		/* Copy the register address to the substring buffer */
> +		csraddr_str = kmemdup_nul(buf, colon_ch - buf, GFP_KERNEL);
>  		if (csraddr_str == NULL) {
>  			ret = -ENOMEM;
>  			goto free_buf;
>  		}
> -		/* Copy the register address to the substring buffer */
> -		strncpy(csraddr_str, buf, csraddr_len);
> -		csraddr_str[csraddr_len] = '\0';
>  		/* Register value must follow the colon */
>  		csrval_str = colon_ch + 1;
>  	} else /* if (str_colon == NULL) */ {
>  		csraddr_str = (char *)buf; /* Just to shut warning up */
> -		csraddr_len = strnlen(csraddr_str, count);
>  		csrval_str = NULL;
>  	}
>  
> 
> ---
> base-commit: 6465e260f48790807eef06b583b38ca9789b6072
> change-id: 20230927-strncpy-drivers-misc-eeprom-idt_89hpesx-c-b09ed5507b7d
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
