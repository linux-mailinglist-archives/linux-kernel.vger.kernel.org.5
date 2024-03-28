Return-Path: <linux-kernel+bounces-123118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17E890259
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41040B234B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8831312CDBF;
	Thu, 28 Mar 2024 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="gafSkfD4"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF812EBC4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637642; cv=none; b=qj99I2NhGFseBKjD0dbLLzXySDbu+KHgrz52RLKPcTjPtjI/eTYpGSwOKzErBRzlT7oPNtpG+LRvsEFBA3aBri6GgytbnM3IMvWNTuQDow+hCo4PibhJoTPEr34T2cOB/NZ7X+qTVieF5EPHNKVDSjFNkU7ivPp1JcTQqAYseNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637642; c=relaxed/simple;
	bh=iZIfvRAXPiN1hUOqhcrIgulJC/h0qg4G0zbfy7UTFog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/FSdLCgKPZ9Sav1vJ2EkDanabvRxI8JVXLOWDTXNOYVIIVLRDwxBpzwrZYR0R4CMOtjuMnEeu9deQ++lKH1qmBnFoBHUIXcsXZYKBzZ29imsmmf4wuEJQjX714vsBGfN3YhOEWetcB6ndj2d2UIEExUIs0kUpZWfsgBcIaQKEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=gafSkfD4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-781753f52afso55177985a.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1711637638; x=1712242438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ch1rSN60qRNe5jZReHI5Y78NslDtRUbpHN7Kv6Yk4Rs=;
        b=gafSkfD4I9UUsl7v479VXMwpQfzA11f7ivm4sjOBEbRWuFRyiSmT1MZbdowifcrVd6
         kFEXvPwaA9xgqLNj18mmuAo5rTyLYjRmGgj30qY9c5m0+gUm+KCbnGM+FqGZFQGcZIjN
         0SJKUFYFxNUFLVfAW+tJnv7KFHDXI5d5kWdeY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637638; x=1712242438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch1rSN60qRNe5jZReHI5Y78NslDtRUbpHN7Kv6Yk4Rs=;
        b=rsB9XeIvY5KoHguwiE3zlO80Ck6XoFb771O/VNgDVIFjV8Of1emGQglUQjhAL61uN5
         lvcM99RvlfIjNdocNf1q5+Nf9x8m2DGPlmd0bkjgkkQBb3l7d1zz5geQCne/9eIsCHAr
         AeJoOQWFUyZkxoBYhdPQcUgSpbVAaTTsMwvyEj7GiCE3f1wYYHyIcdWwetaU+QbCRWiH
         aHqmdzZdY5zL6+o/aGwVhCXOlUJ/UWjBH/2rvb72VnDbouUniV+RbBdnB0Tr9nZ5jxvk
         tXYUxy9IfUb7aBkWNv7i5/dQgoLYtyInPXOIt09iaN1RD7g6wXjPI2ch1sEt3mL5giqc
         5Q0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgs7ixx3sn36yN/K+WrV0/8vCOXwqhAkiI+0I5smNAuT0I6v1PaDJGjzTKkyn9cdZhzMJQzSEAhTNp7DkdcziA7aZd4RefKSiKDMmI
X-Gm-Message-State: AOJu0YwaV38Q2uKK7aA1zF80JfzNp26yA9cTz4R+/s6lL6gdlgLxvYFQ
	KP49FLtiF8TuE9qSGa1rm8sd7J85I4Pn623nTKdivlPPMBMUzxk/KIBWNbVt9A==
X-Google-Smtp-Source: AGHT+IEnRGCY/sQi9y+ccYFEbyJVObyHWpdhYti3ZYxnNsR7GFx/Tq+iuzOTlBR8697MpFQbDAmQmg==
X-Received: by 2002:ad4:5507:0:b0:696:990b:dfeb with SMTP id pz7-20020ad45507000000b00696990bdfebmr2685430qvb.16.1711637638145;
        Thu, 28 Mar 2024 07:53:58 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id jf11-20020a0562142a4b00b006987272f5cbsm399690qvb.71.2024.03.28.07.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 07:53:57 -0700 (PDT)
Message-ID: <b8e848fe-96d8-4f75-a2e9-2ed5c11a2fd7@ieee.org>
Date: Thu, 28 Mar 2024 09:53:55 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] rbd: avoid out-of-range warning
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>, Alex Elder <elder@inktank.com>,
 Josh Durgin <josh.durgin@inktank.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Hannes Reinecke <hare@suse.de>, Christian Brauner <brauner@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Ricardo B. Marliere" <ricardo@marliere.net>,
 Jinjie Ruan <ruanjinjie@huawei.com>, Alex Elder <elder@linaro.org>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, llvm@lists.linux.dev
References: <20240328143051.1069575-1-arnd@kernel.org>
 <20240328143051.1069575-4-arnd@kernel.org>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20240328143051.1069575-4-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/28/24 9:30 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-14 points out that the range check is always true on 64-bit
> architectures since a u32 is not greater than the allowed size:
> 
> drivers/block/rbd.c:6079:17: error: result of comparison of constant 2305843009213693948 with expression of type 'u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
w
>              ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This is harmless, so just change the type of the temporary to size_t
> to shut up that warning.

This fixes the warning, but then the now size_t value is passed
to ceph_decode_32_safe(), which implies a different type conversion.
That too is not harmful, but...

Could we just cast the value in the comparison instead?

   if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))

You could drop the space between sizeof and ( while
you're at it (I always used the space back then).

					-Alex

> 
> Fixes: bb23e37acb2a ("rbd: refactor rbd_header_from_disk()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 26ff5cd2bf0a..cb25ee513ada 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6062,7 +6062,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>   	void *p;
>   	void *end;
>   	u64 seq;
> -	u32 snap_count;
> +	size_t snap_count;
>   	struct ceph_snap_context *snapc;
>   	u32 i;
>   


