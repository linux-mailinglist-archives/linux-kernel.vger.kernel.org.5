Return-Path: <linux-kernel+bounces-123825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405A890E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D761C28980
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC87F471;
	Thu, 28 Mar 2024 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fslp7Mww"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9382882
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668301; cv=none; b=TR1MWAxvH0lJxDX1utuUqwUfSBVnhMS1qXb6xqUyv68zTkUHp9LbNN2lvH+kqPohp3OQX1pQEssfvIjMcI7EjeAZrEiyV4xEpahOWjHDhHaxwTPvniGL15qItBykvgq7fwA8aLpTXNNN17UxJkp4d6cpozqlPLM3N6LBqLlqELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668301; c=relaxed/simple;
	bh=wXfg/+AxvkOnFrYF3BJt/cT/EGxwBVaS6XpJy/hWFFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4KuPZNzIiFAKv+q/KIQrV7ZM4d/KwwQmIEF9y1ZMRbRX8rrtPvYCe9KA8PZIfeSmhllZvSYNr0XjLgfKGaOcCcXrO1+Lf76kKcneYa8R4nO28BdgTxbRT674e/Pf6iAihAKKwT1IjZK6JBMFc4ZdsFwyGUKZee2lIz7xv9edrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fslp7Mww; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d08aea7546so51071239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711668299; x=1712273099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qNXZWa7ff+gZO9/7qJdAv1MXiheIN0/3fR3ZzkSZyM=;
        b=Fslp7MwwrIxxIMJnOJTvA6zxB4REFHZxdCr3XoHBqqm7DH2VVCTOZWES3LC0T0NdMd
         UDjlyzUQcHrOmWC6v+KCIs7+JGgDRLoHSRSsLzDwWQ+XqjdfA/Ct5eY3TVJrycSiC9rw
         ZhcBF8Z8gXiE417zpi17qtvaVBdneGcQ3BfaLx31Ar8S/TqqrZVRKh4ikgDdgr1COqum
         ugD6FBHoRLtLN/vUoRdJhSsqBgp5SaGFqis1I4shN25SVMH8XLZ3DHdZKMJlxRSYzLeM
         YA08FETKMRCik3wPo83TqidqOu1L+I8+Ffc9WeX+lL9UM73+NLYvR0sgbKvTrPAplFnk
         7IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668299; x=1712273099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qNXZWa7ff+gZO9/7qJdAv1MXiheIN0/3fR3ZzkSZyM=;
        b=BM9DGyhJHMqeeXj2fy2uBZuSjXfIaCSa7knrcictFImVzeMqgMUw5rY8SpNzcU3oAD
         ++Hypym7angFsc9F8wWok7+OoJv8epd/iQT/ubn369zezcxxjH05V0majWHzXrQZWzbo
         wniaBrUjdpJznpFTv7Wmcj5FqeZA5+FG4trlTdbBuQZ+xLGwHhZlrYhqJHLaDgmwL4Y+
         /79TqyY+1yCKvOdcWONqcGTQG1s9v+iTfkBwzl6SMnKYFDcGMgWxyRnkvdlyJsE8nzSa
         0wDzOV736fwsgo4R3Vz3hojCCfmzK5V1jks7hEwTLdB4TGYDxV1yt3OhHfqNi9NxWUrk
         u7DA==
X-Gm-Message-State: AOJu0YxU2S6Dc0Tuvg42aG9I6N44FVR3IK+4WdDWQLgCk9E/usVb8fN8
	f4kID/M7Kk+cMGZIpc9XEcmEh0SwJd9j32R+9TvVvViuPHuqrNAuCpNqJssvdQ==
X-Google-Smtp-Source: AGHT+IH/359JmtRlhVfnHXRBxGMxdiBxsOXPtiJP+s9PFPDvBB1vfKbmbWpup/GqtPGDEEuv8/wGDQ==
X-Received: by 2002:a5d:8454:0:b0:7d0:807d:33dc with SMTP id w20-20020a5d8454000000b007d0807d33dcmr699533ior.15.1711668299282;
        Thu, 28 Mar 2024 16:24:59 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id x15-20020a6bda0f000000b007d06ef8020bsm669877iob.40.2024.03.28.16.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:24:58 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:24:56 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"Richard Russon (FlatCap)" <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, 
	linux-ntfs-dev@lists.sourceforge.net, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/11] block/partitions/ldm: convert strncpy() to
 strscpy()
Message-ID: <a5vkpjykxex64vti4wvx7h64jthw7inc23uelol5s3beezoiuz@scl2uhf6pkl7>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-8-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-8-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:51PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The strncpy() here can cause a non-terminated string, which older gcc
> versions such as gcc-9 warn about:
> 
> In function 'ldm_parse_tocblock',
>     inlined from 'ldm_validate_tocblocks' at block/partitions/ldm.c:386:7,
>     inlined from 'ldm_partition' at block/partitions/ldm.c:1457:7:
> block/partitions/ldm.c:134:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>   134 |  strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> block/partitions/ldm.c:145:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>   145 |  strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> New versions notice that the code is correct after all because of the
> following termination, but replacing the strncpy() with strscpy_pad()
> or strcpy() avoids the warning and simplifies the code at the same time.
> 
> Use the padding version here to keep the existing behavior, in case
> the code relies on not including uninitialized data.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!

This helps towards: https://github.com/KSPP/linux/issues/90

Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  block/partitions/ldm.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
> index 38e58960ae03..2bd42fedb907 100644
> --- a/block/partitions/ldm.c
> +++ b/block/partitions/ldm.c
> @@ -131,8 +131,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
>  		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
>  		return false;
>  	}
> -	strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
> -	toc->bitmap1_name[sizeof (toc->bitmap1_name) - 1] = 0;
> +	strscpy_pad(toc->bitmap1_name, data + 0x24, sizeof(toc->bitmap1_name));
>  	toc->bitmap1_start = get_unaligned_be64(data + 0x2E);
>  	toc->bitmap1_size  = get_unaligned_be64(data + 0x36);
>  
> @@ -142,8 +141,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
>  				TOC_BITMAP1, toc->bitmap1_name);
>  		return false;
>  	}
> -	strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
> -	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
> +	strscpy_pad(toc->bitmap2_name, data + 0x46, sizeof(toc->bitmap2_name));
>  	toc->bitmap2_start = get_unaligned_be64(data + 0x50);
>  	toc->bitmap2_size  = get_unaligned_be64(data + 0x58);
>  	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
> -- 
> 2.39.2
> 

Thanks
Justin

