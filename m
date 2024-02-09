Return-Path: <linux-kernel+bounces-60162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9027D8500E8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A461F24E86
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27538DF8;
	Fri,  9 Feb 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6A7sSIC"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D325748
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522937; cv=none; b=UZw1cG780qT9CyNqK2LpCzd4SO5PwrPKTHYzYrPh5hKmSn28tsgt3CXGkf1nU7XGZ1WAleoQuvYBdjlzBgfuSt3iY+xMb28g9WGY6JoOpJ/sMZbjS9YZiY1qXNZp1l0jNoK7xbjNkH9l4jsvu5R4VlxWW4HOLj7bpOAk9ziTLIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522937; c=relaxed/simple;
	bh=fc+hHoZ5CFIKYFO1vI9NXJRErDi6K3hwEsV9omxvjMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx+ka9c5A9OZaGi7InydJIhi0kYE9S4w5z+rYtISyr4F/auqpSVwElv0Vhv4IM8pUACeDHDRirvSxP6l4CKoU7ZD3o7yyR+9x05krD8Kcubl7HET5o5vYpj4PM86a0I2r9ZVTOduwpRwTskdJJgIBj1/oYm9Dz4lpErR5EVFKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y6A7sSIC; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e0a608a36bso35416b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 15:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707522935; x=1708127735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbhYVJ+YRmdFvd9fVgrgRmb2O4rRA+JPLjEMmqpd5Ak=;
        b=Y6A7sSICgyk+4ycUB24TkDFkGOpwmVfRmw96Ud2BEktO8rKVIgkeG8m7aS6llVsm+E
         Po8MzOha3KuA1YGCfrkrDoItH43GTkUu7cOd/JBPXmDf7nsphII1ok6qMVg7Hs1IwGok
         g1V2p5MzPl/AuL3gP/cXY62Z8U1naqNLIskfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707522935; x=1708127735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbhYVJ+YRmdFvd9fVgrgRmb2O4rRA+JPLjEMmqpd5Ak=;
        b=buRMYGLpPUhl67dxfTIGXSa1/OtDxDqbafjAIlPcf18c1aI+zVLjBsbMlHGGXsXoag
         7l3yF+HKuxr/+5mTbE3+xYVa7lISunGJA0Bg7WFLKxzWrH3hfT4TVxarGOkqO6bvJafX
         r+y/+0l1f7PMS/JaNRxz2nC7ZCgWUcbUkk7oIZogoP1U66+nNi580bRyQfxEbay8/5Wo
         mqoIcV15b3pEj0MyL7XGzTSXBkjs/9oLiB7O7KkjJF1kyndyAWV2UHJ3N83mX+NtRalx
         /1Uacp5BlcfcLf3//TPbvOynqvJfPB5XFg0FQcrQHrxxs7EjZNd2ZDJ1QFAMKhXr+sSO
         zHqg==
X-Gm-Message-State: AOJu0Yy0eHVUrFTKJ54/Fd56qjjyzibNYXy83vxeHbHOoNvRLNkeq2JW
	zaGcY0rowq9JnsLHEvhwmbEhZI0ojg6NGRh3xi5UA3JoDjy8VhiE5Kxoh/wPwg==
X-Google-Smtp-Source: AGHT+IE1SPbuXu0qrELvVP9tuLXcxT6SYr3wLXIKGhQ3HnxRbv7QGB3O2E0zj4V9Kmie0Mf2ARodSg==
X-Received: by 2002:a05:6a00:2f97:b0:6e0:9ce2:b598 with SMTP id fm23-20020a056a002f9700b006e09ce2b598mr945628pfb.31.1707522935228;
        Fri, 09 Feb 2024 15:55:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVh1wpK1Nhm4zpQwXPeZ8biyVHpx2fewntmnKhTIhkvlmlcFkFKGzUQ0MdxSFTJraJqHOlbWa2zoIqhgq5+ix95kF1IGjlWxGi50hnqm5VSoOa4AHkBItwm5pDkxbuCJCqIox6JhUD6OwAKWf0Qo0CoAj8n6EDJt9366gLr9alYwFKllY3QmPVQbtGdvKFpx9ertKflu3XEtEADExQ3MKeKO1IJtkrbtdVfw4OKyCLvRi21XTk7PJgRiReV1Smtg0UaS2vhtfQpCPK3XgKc6AiI6+txEdqGFoYJoVOIy5ew4M9h0xtEJ0GHUw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b006e0826bf44csm1135389pfn.172.2024.02.09.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:55:34 -0800 (PST)
Date: Fri, 9 Feb 2024 15:55:33 -0800
From: Kees Cook <keescook@chromium.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: linux-kernel@vger.kernel.org, David.Laight@aculab.com,
	pmalani@chromium.org, andriy.shevchenko@linux.intel.com,
	torvalds@linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH] minmax: Add notes to min_t and max_t
Message-ID: <202402091551.16A4A2A7F@keescook>
References: <20240209150657.1.I45addf7579e1233fa97c05ba72120cd1c57b4310@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209150657.1.I45addf7579e1233fa97c05ba72120cd1c57b4310@changeid>

On Fri, Feb 09, 2024 at 03:07:02PM -0800, Abhishek Pandit-Subedi wrote:
> Both min_t and max_t are problematic as they can hide issues when
> comparing differently sized types (and especially differently signed
> types). Update the comments to nudge users to other options until
> there is a better fix for these macros.
> 
> Link: https://lore.kernel.org/all/01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com/
> Link: https://lore.kernel.org/all/CAHk-=whwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com/
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> Andy Shevchenko made me aware of this particular footgun in
> https://lore.kernel.org/linux-usb/ZcZ_he1jYx8w57mK@smile.fi.intel.com/.
> 
> While David + others work on the full fix, I'm hoping to apply a
> bandaid in the form of comments so the problem doesn't get worse by devs
> (**cough** me **cough**) inadvertently doing the wrong thing.

I think a better example for the docs would be something like u16
(rather than size_t) which shows very quickly the potential for
truncation. See, for example:

https://lore.kernel.org/all/20230811054528.never.165-kees@kernel.org/

> 
> 
>  include/linux/minmax.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 2ec559284a9f..96646f840a1f 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -154,6 +154,18 @@
>  
>  /**
>   * min_t - return minimum of two values, using the specified type
> + *
> + * Note: Downcasting types in this macro can cause incorrect results. Prefer to
> + * use min() which does typechecking.
> + *
> + * Prefer to use clamp if you are trying to compare to size_t.
> + *
> + * Don't:
> + *   min_t(size_t, buf_size, sizeof(foobar))
> + *
> + * Do:
> + *  clamp(buf_size, 0, sizeof(foobar))
> + *
>   * @type: data type to use
>   * @x: first value
>   * @y: second value

Please keep the types immediately after the definition -- notes can go
after.

> @@ -162,6 +174,10 @@
>  
>  /**
>   * max_t - return maximum of two values, using the specified type
> + *
> + * Note: Downcasting types in this macro can cause incorrect results. Prefer to
> + * use max() which does typechecking.
> + *
>   * @type: data type to use
>   * @x: first value
>   * @y: second value

Same.

But yes, I welcome the added comments! :)

-- 
Kees Cook

