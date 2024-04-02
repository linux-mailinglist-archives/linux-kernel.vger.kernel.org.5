Return-Path: <linux-kernel+bounces-127816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A06895154
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94531C22B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6A179B84;
	Tue,  2 Apr 2024 11:02:26 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EB377F1B;
	Tue,  2 Apr 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055745; cv=none; b=MdSis70d6eUMDI5PIW6dAox/LPTK9bfJFMMNk0q8PBj9Iiam+8qYG1t8/wZanOl85ppv8br04fxAYbius39iqBWMOuGC5JXmTvnUjyKTWYqAM/P1I0c038N2gg5nDz7XSdALk5ieArmLfMSxHYQYGTXxfN1U2izKWjxL7sjJXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055745; c=relaxed/simple;
	bh=syS53TaP5xr+RBfcVafSpph7BiRYEvMuSuViwqVPUAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERiuDWOnlBtrKRKePtfgeOpbc4H7CEia+36S+39DFYS9iW/UQIHbL9UgZ70v4hD5i7MPwMUuH4LnJMI7l5jXq7vEwa+XSea2BcE1ly0JDWVBZcqy6E+QD9VikYin5u52N/4Mjg5hqg/y5xs/EhYkFV1qyAQJv9h727XhRzxnhr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-415584360c0so18263695e9.1;
        Tue, 02 Apr 2024 04:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055742; x=1712660542;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Io4rbOkovnV2rRCmQ11vxGTzUj5kuj9+rol3bt/mr48=;
        b=Yy+9wn+yqvUIKvWiMi6F4wShKEDhgHZntROLVlyS4nf1OZHScaLNQgtuHyTQc224u0
         fRaDZXadSTLQzCXXDOuaLiVNWjMl3fg2mWfzRduT6wAeTP9FAVIKTdGl+X6eNj9pVsyQ
         LP1vSh28tJr587FCZhRHWdLGKpJxL0n4tdqdrtEaWWc9uEim4t4NnXtaQThU+PKIdpMr
         qOIH1Ja2+70xcOy1UllgUNUGCcJA45B/J/j1h5R4+RU0XZ9rQ8N0mHKFHcyN403EEBfQ
         WX9fpE/pLhoFat1y2hQJ2wQIveUEImj5MHYM734+Z9Y/JSyvjKQJO8C0AbcOhRqiav5D
         AuRw==
X-Forwarded-Encrypted: i=1; AJvYcCX7WdiXDZVnuJsHW4zah8bYEb0XyVoKzq087hDuFnGDgj1SXddiLrkHq3R2zlT0Y+4dJnLKaTr0byJcBQsei2Q+m8ZI4sFaiHsUCSGLcq9GUeX/ifEIA9VQVpfqlCZNvyxyNHBW2xw1PkqUhFt08rfIn1iblQazc5bKTUU71jRCqI0mXOw=
X-Gm-Message-State: AOJu0YwMHAzpSzxkXUt32+3Ar37Mk/Y+pIeOdcz4esAHfJTAMyfCuDP5
	AF8krJcTB4xE8XEYkKtWpd9SiXCgJbEISaKIMjGXubgZmQ2wz/9Y/XwHfrZvm1U=
X-Google-Smtp-Source: AGHT+IEw/WKBY4iyFrYhB7Iu4Y2WLb+Ml0G3jylTOHEj7zys8rr8dpOOhPc8kbi7CB7K5X9ygrBsFA==
X-Received: by 2002:a05:6000:1562:b0:343:39ef:53b0 with SMTP id 2-20020a056000156200b0034339ef53b0mr9835351wrz.24.1712055742012;
        Tue, 02 Apr 2024 04:02:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id dn2-20020a0560000c0200b0033e25c39ac3sm13889079wrb.80.2024.04.02.04.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:02:21 -0700 (PDT)
Message-ID: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
Date: Tue, 2 Apr 2024 13:02:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 1/2] VT: Add KDFONTINFO ioctl
To: Alexey Gladkov <legion@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <cover.1710252966.git.legion@kernel.org>
 <cover.1712053848.git.legion@kernel.org>
 <ed056326540f04b72c97a276fbcc316e1b2f6371.1712053848.git.legion@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ed056326540f04b72c97a276fbcc316e1b2f6371.1712053848.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 02. 04. 24, 12:32, Alexey Gladkov wrote:
> Each driver has its own restrictions on font size. There is currently no
> way to understand what the requirements are. The new ioctl allows
> userspace to get the minmum and maximum font size values.

minimum

> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
> ---
>   drivers/tty/vt/vt.c       | 24 ++++++++++++++++++++++++
>   drivers/tty/vt/vt_ioctl.c | 13 +++++++++++++
>   include/linux/console.h   |  2 ++
>   include/linux/vt_kern.h   |  1 +
>   include/uapi/linux/kd.h   | 13 ++++++++++++-
>   5 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 156efda7c80d..8c2a3d98b5ec 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4680,6 +4680,30 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
>   	return -ENOSYS;
>   }
>   
> +int con_font_info(struct vc_data *vc, struct console_font_info *info)
> +{
> +	int rc = -EINVAL;

This initialization appears to be unneeded.

> +
> +	info->min_height = 0;
> +	info->max_height = max_font_height;
> +
> +	info->min_width = 0;
> +	info->max_width = max_font_width;
> +
> +	info->flags = KD_FONT_INFO_FLAG_LOW_SIZE | KD_FONT_INFO_FLAG_HIGH_SIZE;
> +
> +	console_lock();
> +	if (vc->vc_mode != KD_TEXT)
> +		rc = -EINVAL;
> +	else if (vc->vc_sw->con_font_info)
> +		rc = vc->vc_sw->con_font_info(vc, info);
> +	else
> +		rc = -ENOSYS;
> +	console_unlock();
> +
> +	return rc;
> +}
> +
>   /*
>    *	Interface exported to selection and vcs.
>    */
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 8c685b501404..b3b4e4b69366 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -479,6 +479,19 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
>   		break;
>   	}
>   
> +	case KDFONTINFO: {
> +		struct console_font_info fnt_info;
> +
> +		if (copy_from_user(&fnt_info, up, sizeof(fnt_info)))
> +			return -EFAULT;

Who uses the copied values?

> +		ret = con_font_info(vc, &fnt_info);
> +		if (ret)
> +			return ret;
> +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))

We should do the preferred sizeof(*up) here...

> +			return -EFAULT;
> +		break;
> +	}
> +
>   	default:
>   		return -ENOIOCTLCMD;
>   	}
..
> --- a/include/uapi/linux/kd.h
> +++ b/include/uapi/linux/kd.h
> @@ -183,8 +183,19 @@ struct console_font {
>   
>   #define KD_FONT_FLAG_DONT_RECALC 	1	/* Don't recalculate hw charcell size [compat] */
>   
> +#define KDFONTINFO	0x4B73	/* font information */

Why not properly define the number using IOC() et al.? K (that 0x4b) is 
even reserved for kd.h.

> +#define KD_FONT_INFO_FLAG_LOW_SIZE	(1U << 0) /* 256 */
> +#define KD_FONT_INFO_FLAG_HIGH_SIZE	(1U << 1) /* 512 */

_BITUL()

> +struct console_font_info {
> +	unsigned int min_width, min_height;	/* minimal font size */
> +	unsigned int max_width, max_height;	/* maximum font size */
> +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */

This does not look like a well-defined™ and extendable uapi structure. 
While it won't change anything here, still use fixed-length __u32.

And you should perhaps add some reserved fields. Do not repeat the same 
mistakes as your predecessors with the current kd uapi.

> +};

thanks,
-- 
js
suse labs


