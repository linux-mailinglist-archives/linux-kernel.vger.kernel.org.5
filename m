Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425907A1557
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 07:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjIOFY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 01:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjIOFYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 01:24:55 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B20F2710
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:24:50 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68fc9a4ebe9so1578386b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 22:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694755490; x=1695360290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x0qVdiNnNK1x44nux0ZGC5YO/63axRdKDDjAcPyMmoU=;
        b=eq3Fj1bPTp4EN47AXXmrfGqA4A24a9bNZDEaVXXpLiFSlMwiXk8sqa9Y3mBuu59PHi
         NE9JPzBlHX+yOkYJnLWcOIS84j9R+3F95bwyTZm6iV+/iLQM1mBzu8DMp2w0emeGnVaH
         l4BM+HY9mEGK18mozAYogUo57aISMLYo84sAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694755490; x=1695360290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0qVdiNnNK1x44nux0ZGC5YO/63axRdKDDjAcPyMmoU=;
        b=bwtGVLybHBpDBpzzj5k27lc9kmw6N3KsHQKkGmRECuGi0kKeQdsfPiK5VhIiM5J6uq
         9cc9Yb/jid+idkMCbVK6Z6KL7lA5qr8i885+4Il51ba9nctEGXPB9ynghXVhJ+nncq19
         i2qegNlYX2r+myrf5LDrNU0SXZLHlv+OrKzxHhouiUTe3tChMTbmX2ls+ouoBCdK3R5D
         p/nsoqBJ8YLyv8Neuw57qAMSJSBhDczk0FiDAWrBLDoT7CyeEWa/5SslpTrF/Vd9RaEf
         s2Fdf+8TgfXh2Kb+sk+suahzXcA/Fm4YygazY/RY44slB0tpkupBTDJjT6iRMm9jCLoB
         6wuA==
X-Gm-Message-State: AOJu0YxWbAUSy8SDeef3QxDBHjhi3x8gSGjofrAbXzfhEd4jLBXCXG68
        bEDEns/WbbQI8QnyMncg7qpFwA==
X-Google-Smtp-Source: AGHT+IFED1FDb4BajsYclNy37LUDYQbCJaFpMaXLXHfXnR4m0zHZlA65aGamnmGLaiEoj43nxFWQ+w==
X-Received: by 2002:a05:6a20:244e:b0:134:8d7f:f4d9 with SMTP id t14-20020a056a20244e00b001348d7ff4d9mr1002623pzc.52.1694755490009;
        Thu, 14 Sep 2023 22:24:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001aadd0d7364sm2521635pld.83.2023.09.14.22.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 22:24:49 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:24:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-hwmon@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] hwmon: (ibmpowernv) refactor deprecated strncpy
Message-ID: <202309142223.D16446A30D@keescook>
References: <20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-strncpy-drivers-hwmon-ibmpowernv-c-v1-1-ba6b7f42c98c@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:21:06PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding since `buf` is already zero-initialized.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/hwmon/ibmpowernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 594254d6a72d..57d829dbcda6 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -234,7 +234,7 @@ static int get_sensor_index_attr(const char *name, u32 *index, char *attr)
>  	if (copy_len >= sizeof(buf))
>  		return -EINVAL;
>  
> -	strncpy(buf, hash_pos + 1, copy_len);
> +	strscpy(buf, hash_pos + 1, copy_len);

This is another case of precise byte copying -- this just needs to be
memcpy. Otherwise this truncates the trailing character. Imagine a name
input of "fan#2-data". "buf" wants to get "2". copy_len is 1, and
strscpy would eat it. :)

-Kees

>  
>  	err = kstrtou32(buf, 10, index);
>  	if (err)
> 
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-hwmon-ibmpowernv-c-80a03f16d93a
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 

-- 
Kees Cook
