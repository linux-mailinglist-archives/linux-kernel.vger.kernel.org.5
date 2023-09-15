Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12977A1530
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjIOFOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIOFOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:14:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE66270E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:13:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68fb85afef4so1655684b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694754839; x=1695359639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=acxoPaFG2XivBgSqeYmNEHpuYiUIRZSTppMtTxUUVv4=;
        b=LHngbTCDJz3Em4dhXY6g//LOWe1Aom63Rt767jlE7l+Bj1m+SXfOawigiCNHMkBX1v
         WVHMgL2+ABpt6jgDM5XzEVMy3DJ/toQ6yNLIclciC187GySEIGG7tCHg/LbrXkMOr2+N
         2s/7I+XxIp5uQJHsi5gZ+1XyDkFAe+PdnpKLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694754839; x=1695359639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acxoPaFG2XivBgSqeYmNEHpuYiUIRZSTppMtTxUUVv4=;
        b=MaAXgEGBor4aEJjLnOqlKQcxUGRCr6COYyPF54HmBQBSBYb2/h5IVDUHPNv3LDtO5p
         iFLrPWt0/YixrzGwEiH2fFzAcJo30SuEt5DsiOxgiufg4t29zKZhJwSNNm8E4KagYClW
         fE9QcYgPGB7Oyuiw8jJhcpA4rJ1OTUKUTtB4AGVGt46+XmSgNlW+CZz375B+OFh2qKJf
         AkWz9CqXUPZrOrsTeV5Z7Rj33lzHRQutzWFoRhrVv0hLzQt3naagwkGocp4FUoJuszlr
         nG9zeQbohpcx5k1vVTMly8zh2a9J/NL/1Sk5LjezqQuzO/AbAWwxRV6u4Ib1ysH/+tdl
         My1A==
X-Gm-Message-State: AOJu0YykVLA8HaCurrcvT1tMstxRxc68R2bF/SA6NKbGS/y9MMPuq/f6
        hGc6m8LoRAxalEGXFpbkXKVuJg==
X-Google-Smtp-Source: AGHT+IEquLYBi8sSjq5A+2YWx7Db2apHzQGj6HjTIbzo17AHn22AV3GYdk/osPgTVE3YoftBRuNm4Q==
X-Received: by 2002:a05:6a00:190f:b0:68f:b3ed:7d56 with SMTP id y15-20020a056a00190f00b0068fb3ed7d56mr736933pfi.34.1694754838876;
        Thu, 14 Sep 2023 22:13:58 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79216000000b0068fff63eb16sm2126681pfo.132.2023.09.14.22.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:13:58 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:13:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     David Rheinsberg <david@readahead.eu>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: uhid: refactor deprecated strncpy
Message-ID: <202309142206.60836CE@keescook>
References: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-hid-uhid-c-v1-1-18a190060d8d@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:47:21PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
> 
> Looking at: Commit 4d26d1d1e806 ("Revert "HID: uhid: use strlcpy() instead of strncpy()"")
> we see referenced the fact that many attempts have been made to change
> these strncpy's into strlcpy to no success. I think strscpy is an
> objectively better interface here as it doesn't unnecessarily NUL-pad
> the destination buffer whilst allowing us to drop the `len = min(...)`
> pattern as strscpy will implicitly limit the number of bytes copied by
> the smaller of its dest and src arguments.

I think the worry here is that ev->u.create2.name may not be %NUL
terminated. But I think that doesn't matter, see below...

Also, note, this should CC David Herrmann <dh.herrmann@gmail.com>
(now added).

> So while the existing code may not have a bug (i.e: overread problems)
> we should still favor strscpy due to readability (plus a very slight
> performance boost).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/hid/uhid.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 4588d2cd4ea4..00e1566ad37b 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -490,7 +490,7 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>  			    const struct uhid_event *ev)
>  {
>  	struct hid_device *hid;
> -	size_t rd_size, len;
> +	size_t rd_size;
>  	void *rd_data;
>  	int ret;
>  
> @@ -514,13 +514,9 @@ static int uhid_dev_create2(struct uhid_device *uhid,
>  		goto err_free;
>  	}
>  
> -	/* @hid is zero-initialized, strncpy() is correct, strlcpy() not */
> -	len = min(sizeof(hid->name), sizeof(ev->u.create2.name)) - 1;
> -	strncpy(hid->name, ev->u.create2.name, len);
> -	len = min(sizeof(hid->phys), sizeof(ev->u.create2.phys)) - 1;
> -	strncpy(hid->phys, ev->u.create2.phys, len);
> -	len = min(sizeof(hid->uniq), sizeof(ev->u.create2.uniq)) - 1;
> -	strncpy(hid->uniq, ev->u.create2.uniq, len);

ev->u.create2 is:
struct uhid_create2_req {
        __u8 name[128];
        __u8 phys[64];
        __u8 uniq[64];
	...

hid is:
struct hid_device { /* device report descriptor */
	...
        char name[128]; /* Device name */
        char phys[64]; /* Device physical location */
        char uniq[64]; /* Device unique identifier (serial #) */

So these "min" calls are redundant -- it wants to copy at most 1 less so
it can be %NUL terminated. Which is what strscpy() already does. And
source and dest are the same size, so we can't over-read source if it
weren't terminated (since strscpy won't overread like strlcpy).

> +	strscpy(hid->name, ev->u.create2.name, sizeof(hid->name));
> +	strscpy(hid->phys, ev->u.create2.phys, sizeof(hid->phys));
> +	strscpy(hid->uniq, ev->u.create2.uniq, sizeof(hid->uniq));

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  
>  	hid->ll_driver = &uhid_hid_driver;
>  	hid->bus = ev->u.create2.bus;
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-hid-uhid-c-a465f3e784dd
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
