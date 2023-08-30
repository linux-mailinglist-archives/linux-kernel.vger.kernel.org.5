Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C4678DFEC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjH3T5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjH3T5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:57:15 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1674436D2A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:29:28 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-68bed8de5b9so11543b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693423625; x=1694028425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YZMBO3cq35PjwKKIG6m42W7fw7Uuq0v6gb0qcGM7SrQ=;
        b=hR0Ei8t6wqohymZFZGwguVrcTqVtJZs7bleS9AYXdH4FqSCAmOeUbe+6nWJdsJVcVj
         +NGqjfviWqcLzMVx4MR+qo3AvhRMg2mja/X7yCBjjYmH6A0tEY8pLLPb+RZ78LrdXuJ2
         KkgWpSTnXIXl5GSjUkNYqvxOABA1BA7hL2AfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423625; x=1694028425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZMBO3cq35PjwKKIG6m42W7fw7Uuq0v6gb0qcGM7SrQ=;
        b=KKZ5Iz4SKrfjKD0o32bfQfO5g9X0i8JdXQoY+Hf5d2yuFYSswg+etHRTP1mezmTVNs
         PBhaJi4vbkrjLtRHBzd+InbPv05+YvC5DxNnDi5DLbrcEi0c+zjahuYJkxjW81VkjlSV
         3WdlBmlYHR55e6Jpn4yY+XY0tuMWvVBycwltekTFSGsSu1fem6I1kHYEl5XKi/PBdCpw
         JpgS8qobzpgXQpBswmXIioXJcF77LXzg9MD+cmg+dG/2ZqBz/LAQEHxRom4YFKmV+K8b
         Ft7elT+NCxIgEV5yStJJ8eJBME1yr0a5lJ+mNuIZ1lIetO/TxcViiiY+D06GpAf3t573
         JjRg==
X-Gm-Message-State: AOJu0YxYzXdjv/bouiXji8P7rhh+uMBGZmTXINrH01pen2HhF2crhfWf
        GylkxRVTlVVCpdbaOZ0xzAXHuA==
X-Google-Smtp-Source: AGHT+IGykiElXISO5VTbxBJsqAwOC0C4+ZKKK6xBNTjZEalBwc53bWlt/bicp+NzrhLj4nYHS0HvIg==
X-Received: by 2002:a05:6a00:1ace:b0:68b:dfef:de8f with SMTP id f14-20020a056a001ace00b0068bdfefde8fmr3255663pfv.12.1693423625426;
        Wed, 30 Aug 2023 12:27:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g10-20020a62e30a000000b00688965c5227sm10324255pfh.120.2023.08.30.12.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:27:04 -0700 (PDT)
Date:   Wed, 30 Aug 2023 12:27:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Message-ID: <202308301222.3BD87A6@keescook>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 04:04:10PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.

Perhaps add:
"... and returns the size of the source string, not the destination
string, which can be accidentally misused."

> This read may exceed the destination size limit if
> a source string is not NUL-terminated [1].
> 
> The copy_to_user() call uses @len returned from strlcpy() directly
> without checking its value. This could potentially lead to read
> overflow.

Since the code as written today is "accidentally correct", it's worth
clarifying this: there is no existing bug, but as written it is very
fragile and specifically uses a strlcpy() result without sanity checking
and using it to copy to userspace. (This is the exact anti-pattern for
strlcpy(), and only because the source strings are known good is this
safe.)

> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 358f216c6cd6..15359c328a23 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -2079,12 +2079,15 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>  			return -ENOMEM;
> 
>  		spin_lock_irqsave(&func_buf_lock, flags);
> -		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
> +		len = strscpy(kbs, func_table[kb_func] ? : "", len);
>  		spin_unlock_irqrestore(&func_buf_lock, flags);
> 
> +		if (len < 0) {
> +			ret = -EFAULT;

I think this should be -ENOSPC as EFAULT implies an actual memory fault.

> +			break;
> +		}
>  		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
>  			-EFAULT : 0;
> -
>  		break;
>  	}
>  	case KDSKBSENT:
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
> 
> 

Thanks for sticking with these refactorings; we're almost free from
strlcpy. :)

-Kees

-- 
Kees Cook
