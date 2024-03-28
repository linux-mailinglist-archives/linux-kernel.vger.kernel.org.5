Return-Path: <linux-kernel+bounces-123827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6B0890E81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F301C230CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E780BE0;
	Thu, 28 Mar 2024 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gziQcKXX"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8783BBF1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668529; cv=none; b=tB6hAu1GqQH3116LDMGllClKjjRrtWBfJBFaT/Fg6fdlkMjgaCOHaMosVasNIVX3GSBZR15/RMbd2U7lR229WTqFwnY5X7JZHMqhkFw7pkQGB17U9bL4Xpu0lfk60AIuNMAI8yIhR1hGFDqPoQK2LJqktLIPVwPuryRrUpJAl08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668529; c=relaxed/simple;
	bh=af2lsfoXHDLd/352y7E2LEui2nimY5r7GEl4JA0YSJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfH7mRid7g3l50sHoz0eO1m2ItjGlF4n9pDhozcVlDGimSu8Qe928BAy/Rscv2tfq+CLb8QuJOrjG1aam+wM/r9uOd8geXqjhOz/oiXr180uWayt9lKC1uAxGGHbEOY+l3erSOWGJF27i1GXQHPvjx0jZG5/ZD+dEUgwIidT3F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gziQcKXX; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d0486cf91aso65377739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711668527; x=1712273327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rgK/m0H462r5jl378Ykwjg1mm44w08HwGWoGWcoQbgE=;
        b=gziQcKXXzn/7dIEOWuw7fkji/A4yEnicAxJMDhAsM2JXxT5TKnU4ZbluF7n8czXnci
         wqhjQ4+6Zs/adMJv7jRIAdNDUNprQnXYqY6W4TQpKhvsHSup5lOUT9m9vTux1kU4S/hy
         pY2gy47j6SMkmS0TgSAP1xL/vfVrpVdgvFCxqPvVWe6qTalln/rzLaWrHH/NA8B4qthv
         58XyaLRyl3SP9d9emaXg3rQmbt+8TCiiyqEYt2bkUwpYmHTZpbEPAjkLxFuglmK6My3/
         Op+drEmnqRPNL9Xa8MkWYLSjLOvxlvOj0ITEHMBwp5iKm6jhKeE79qFJOVc/aRIWw741
         K+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668527; x=1712273327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgK/m0H462r5jl378Ykwjg1mm44w08HwGWoGWcoQbgE=;
        b=cyvTlGm9Dm4R6198MQh3sWA8EhHi+PxVsL9wRutUCWc/SFquZfx+XserXTPf4p9/vj
         4cwhcZKUUrPMZIF1n8ZdR6FqgQoTJEUhHHCQGl/RJZB8FUHybzFPHJ6oVSvcUbb/dcsO
         8cZ3I0z6IwvJfueCuiIfF/bzjeRucIeedHW5Q4C/UwSawD+3MSd6QVuyj/gPumSwdTiJ
         4YWrhPCX9o2BfPod3gvoWcZSL6nF/2NY+LIkwUUMoYgubOWdcDN2YFPSfisSxAeMTPkt
         vu1PXYYTaCzqMvcwrQcV+gNY7FKJ35Ro0gLGnAX/rNu1OPFCYZ8GhKGz0Q3CW2KMBSRJ
         1pDg==
X-Gm-Message-State: AOJu0YyJkJgeCKj0mFHVD/3VCeKgV6lw0M2fx4li9HH5GbsdSO6MfHI1
	DDC88XfoGuHe7w0n33WZIYDs/hTWMeIl6VTOCHhlYgoBblBNqkbm36us7Hgb4g==
X-Google-Smtp-Source: AGHT+IGs2igEEehahi3XCvRqfhCt+CMMDEaFPcvv5gQgFXaivHDXEVbAns5XERYqvjB1h1K1XUCPqg==
X-Received: by 2002:a5e:920a:0:b0:7d0:8536:42f9 with SMTP id y10-20020a5e920a000000b007d0853642f9mr727107iop.6.1711668526876;
        Thu, 28 Mar 2024 16:28:46 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id y24-20020a6be518000000b007d08e86d43esm608938ioc.0.2024.03.28.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:28:46 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:28:43 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 10/11] staging: greybus: change strncpy() to strscpy()
Message-ID: <uejqjxh3ntjdyziy3avisav7ghhb3s66iccfwchjkm534zy3ja@3kxet4bu2ck3>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-11-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-11-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:54PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-10 warns about a strncpy() that does not enforce zero-termination:
> 
> In file included from include/linux/string.h:369,
>                  from drivers/staging/greybus/fw-management.c:9:
> In function 'strncpy',
>     inlined from 'fw_mgmt_backend_fw_update_operation' at drivers/staging/greybus/fw-management.c:306:2:
> include/linux/fortify-string.h:108:30: error: '__builtin_strncpy' specified bound 10 equals destination size [-Werror=stringop-truncation]
>   108 | #define __underlying_strncpy __builtin_strncpy
>       |                              ^
> include/linux/fortify-string.h:187:9: note: in expansion of macro '__underlying_strncpy'
>   187 |  return __underlying_strncpy(p, q, size);
>       |         ^~~~~~~~~~~~~~~~~~~~
> 
> For some reason, I cannot reproduce this with gcc-9 or gcc-11, so I'm not
> sure what's going on. Changing it to strspy() avoids the warning. In this
> case the existing check for zero-termination would fail but can be replaced
> with an error check.
>
>
Arnd, I see 4 instances of strncpy() in this file. Could you clean them
all up at once which would help GREATLY towards:
https://github.com/KSPP/linux/issues/90

strncpy() is an often misued and misunderstood (and deprecated [1])
string API, let's get rid of that thing all together!

[1]: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is from randconfig testing with random gcc versions, a .config to
> reproduce is at https://pastebin.com/r13yezkU
> ---
>  drivers/staging/greybus/fw-management.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
> index 3054f084d777..35bfdd5f32d2 100644
> --- a/drivers/staging/greybus/fw-management.c
> +++ b/drivers/staging/greybus/fw-management.c
> @@ -303,13 +303,13 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
>  	struct gb_fw_mgmt_backend_fw_update_request request;
>  	int ret;
>  
> -	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
> +	ret = strscpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
>  
>  	/*
>  	 * The firmware-tag should be NULL terminated, otherwise throw error and
>  	 * fail.
>  	 */
> -	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
> +	if (ret == -E2BIG) {
>  		dev_err(fw_mgmt->parent, "backend-update: firmware-tag is not NULL terminated\n");
>  		return -EINVAL;
>  	}
> -- 
> 2.39.2
> 
Thanks
Justin

