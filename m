Return-Path: <linux-kernel+bounces-123699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F64B890CDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C649AB22ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1013B5A3;
	Thu, 28 Mar 2024 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V079LFyD"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A7837165
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663404; cv=none; b=eqzZ2RUvvQ7paOINwBp6030MDen4l4eASUVORV3uP9EXYkPhFqbiS+m8wm/C47i4eWyecl09NiH5sqEzVwnPSA2qnaqpd55ijq7AktqL6xjCGafyZ47otW2h4rRD3T7kRAkwjkvF2HtPhM6CIP9aXwS3BDZFWFBmIB13Ky2QlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663404; c=relaxed/simple;
	bh=evPzJ3UC1mje7szxpzWn9LwNktULR6gDuyQnitvPF+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fp7fab4zfly2Th/4ekzGE19s62CZjA5MApEELmu+/yw2IwFGX3qhqYAAQFf1gdo20ZiBRgdH7GD9lZ4tluXwbBvItwkDs/MLxMh1zImyM8pyVZcbyW0WvPd0LNVkzXf5pt9wg3BYN/cHAxxftHXP2J8AIAPbKlBnYI8ZWSJ7Yek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V079LFyD; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e8f765146fso1280188b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711663402; x=1712268202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5W1XwHUqOUXzkT7pj5ftVmW2F1U2vvJHxbFamzQmMtE=;
        b=V079LFyDs2wGDhXkbdErDL+UNyfuQCP8y5KDhEB1xTW5hOxTWS4krXURvcoKNpLoa6
         QNmTFFhwuoAuzQun8BSwT1jbu6GQSbYzJWT+fzM45tm4HNBY6xBEYAAZPuu00ZaERBmT
         lfcFFkNyNVy7KF8OSUMEhAWTw7pGFm5lccR3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711663402; x=1712268202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W1XwHUqOUXzkT7pj5ftVmW2F1U2vvJHxbFamzQmMtE=;
        b=vRxTSFpdHfvaCt2kItsJ9zFwDoG6yaVWOls9qaNEfYEapCh0kwUhquVr5qjDmwWRI1
         6TPkqrg8cCUGA1kEdpgFBegEI6GDX+EUQJdlu5ntkDAjn3MemtgIF/wobTlbALfm5kny
         MEa5EZm/x0Byr0f+1EZaH/hj/Aw+BC+CmUczoVq+vevxudjZxThkbTjNaL7BNgClE9b1
         2jCJyVoMLcSbw0k3RBEDcBHUVL0Y0uRwz8h8sKQ/TvGFBZhS9nZKCQWVB9Mv4S0Yhzz3
         uHDGkJCqJxo4d8iUcMmsD6yit3Ex5krYxyCjPKQnuWTrPMRQ8ROoXNh3ulbEbeuHlNcc
         0N8w==
X-Forwarded-Encrypted: i=1; AJvYcCX8Tj0y5XANISvHKFxbL+/JP+Id2c7EF01UpbgurcUQoKNEAlGPNRkdxt5XVY4+LHPdnM0Os36NXYEgcPIiD+o9OZQtg+m82B+ZH9Wr
X-Gm-Message-State: AOJu0Yy6wFA9NswGUH0RNYRKr7CPZOVLGTpRV1OErtmGcQ/TKJ4U8tH3
	dx3AIhqJ5td6vjAhl4XO1w51YxdaA/7Zj7h+h8uMP2bUOjo/V2qdQuGby00uEg==
X-Google-Smtp-Source: AGHT+IEVXwyYhggPVw8VuFhU/t79pm25Cu/RS/1a4nClVa0kQslD07bEuERIBQRwDdkrXkWM7nSBkg==
X-Received: by 2002:a05:6a21:998e:b0:1a3:c3fd:8e03 with SMTP id ve14-20020a056a21998e00b001a3c3fd8e03mr502896pzb.38.1711663402543;
        Thu, 28 Mar 2024 15:03:22 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78044000000b006eab6f3d8a9sm1857451pfm.207.2024.03.28.15.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 15:03:22 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:03:21 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
Message-ID: <202403281502.BD156CD01@keescook>
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>

On Wed, Mar 27, 2024 at 09:10:52PM +0000, Justin Stitt wrote:
> strncpy() is in the process of being replaced as it is deprecated in
> some situations [1]. While the specific use of strncpy that this patch
> targets is not exactly deprecated, the real mission is to rid the kernel
> of all its uses.
> 
> Looking at vmcoredd_header's definition:
> |	struct vmcoredd_header {
> |		__u32 n_namesz; /* Name size */
> |		__u32 n_descsz; /* Content size */
> |		__u32 n_type;   /* NT_VMCOREDD */
> |		__u8 name[8];   /* LINUX\0\0\0 */
> |		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> |	};
> ... we can see that both `name` and `dump_name` are u8s. It seems `name`
> wants to be NUL-padded (based on the comment above), but for the sake of
> symmetry lets NUL-pad both of these.

Do we have a way to know that dump_name is not parsed by userspace as a
NUL-terminated string?

> 
> Mark these buffers as __nonstring and use strtomem_pad.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  fs/proc/vmcore.c            | 5 ++---
>  include/uapi/linux/vmcore.h | 4 ++--
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 1fb213f379a5..5d7ecf3b75e8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
>  	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
>  	vdd_hdr->n_type = NT_VMCOREDD;
>  
> -	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
> -		sizeof(vdd_hdr->name));
> -	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
> +	strtomem_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME, 0);
> +	strtomem_pad(vdd_hdr->dump_name, data->dump_name, 0);
>  }
>  
>  /**
> diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
> index 3e9da91866ff..7053e2b62fa0 100644
> --- a/include/uapi/linux/vmcore.h
> +++ b/include/uapi/linux/vmcore.h
> @@ -11,8 +11,8 @@ struct vmcoredd_header {
>  	__u32 n_namesz; /* Name size */
>  	__u32 n_descsz; /* Content size */
>  	__u32 n_type;   /* NT_VMCOREDD */
> -	__u8 name[8];   /* LINUX\0\0\0 */
> -	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
> +	__u8 name[8] __nonstring;   /* LINUX\0\0\0 */
> +	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES] __nonstring; /* Device dump's name */
>  };

Unfortunately since this is UAPI, we can't sanely use __nonstring here.
:(


-- 
Kees Cook

