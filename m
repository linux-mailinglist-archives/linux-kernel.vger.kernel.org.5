Return-Path: <linux-kernel+bounces-66029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7430A855590
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2968A282B03
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79D114198D;
	Wed, 14 Feb 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWWp+3yv"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C91DDF1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948577; cv=none; b=QqPOGQG+THYTZ2kkNfvdJqre6cHq2JIIvkVdWk45WlJoS4lYesKMvKjN5RUcNIeKLoFNU5Gid1qh8slGTPXIdROCVlyTm7ZQ/q+0qNbwjJcZAAGCLTR1ptidapl9tJejgIEtkt0MN13E1VubnnTJ1pr8ObWWSz4g4+IT6o73kD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948577; c=relaxed/simple;
	bh=VTAmMg+BgFLnXnjh2RFbOxx2A7QCbkF4jCDwOsg/fb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIZt+8BHj/mZrKtqFYKGr1tx0QamFbDX+nW38Eqpht4kzTDbngx2CIJ/cYcHyCSJVWeX64xThHKSI4MjFBc8XEOYjtj43TZUsHVv2cUgiWLxmt2xBTYsVOCPlSUg5EbjzRkQ1zcCoRZVdbcHelHsc7c1ztQtCnk7XhztTFnnBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VWWp+3yv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-298fe09f851so29816a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 14:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707948575; x=1708553375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKC90cK1z5oF1gcZg9hwRMmNU2RFG8t/vNnGjpX63Tw=;
        b=VWWp+3yv7CVu4Ichuui2QgsbyitfZhwzs4yUF31iOb6W9cV+Zf5P83zejS5AzEhHsX
         cDf+hgBQSi5BkgRRgsu3523uDnm0vY1PcoqYPBUcI3X36/BmdeUsrJRWQPwOcG2+fFhq
         GQ6qsGltSotZho7dChjqnPcBLS0VJ6h+K2zQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707948575; x=1708553375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKC90cK1z5oF1gcZg9hwRMmNU2RFG8t/vNnGjpX63Tw=;
        b=YZ0cBD3ocqSCTDtlcqwDYQJEZ68pna5+eA7CCryhzlZgjSaprxbs71nnqNI50ZVwyr
         hHU36qmZk6gfL9DBDTnu7s29lj+adYAU8v3jJ68vMiWRfyMw08PK3kYumRB22ddk2noL
         9RM6cwuB1jAsiiDLTjFR5bc2J/sEFezOjXp54CM2bS1j/Wy4N5+3I5J+qdNZXfdyXpb8
         OgkCn0zPQdN/fZ4+E1VZNK+2c+sqx/4RDLS2gpGrIai+V0BtKGx2nJ8GKa6u//HNJejn
         XuS9tDUg8k86dLpv2QWy70lHODxb3/vHv4GWU43wZceNUXnMhK53Gl9FQNgRJlihwdiM
         o37Q==
X-Gm-Message-State: AOJu0Yx9yCL/eq4wyA7wl4Fyj3sYY4eZNZLGaCgcbB8ddu58wASZtrrl
	JkoAv/yA0WwT9CQBBCUWoyQ8uHMW5YIwxEUnnaNVHMF916R3qgOxWesHJ7YO+A==
X-Google-Smtp-Source: AGHT+IGTjHOYA94BG0K7UshyYHyh3FY0JkwVS/a2AcWoZcNN56CXDoJOkccas+6uzaul20xonyumwg==
X-Received: by 2002:a17:90a:ce08:b0:295:ff5d:cb1d with SMTP id f8-20020a17090ace0800b00295ff5dcb1dmr47666pju.4.1707948575070;
        Wed, 14 Feb 2024 14:09:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a728400b00297022db05dsm1872088pjg.40.2024.02.14.14.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 14:09:34 -0800 (PST)
Date: Wed, 14 Feb 2024 14:09:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 1/2] wordpart.h: Helpers for making u16/u32/u64 values
Message-ID: <202402141408.0E78D47@keescook>
References: <20240214214654.1700-1-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214214654.1700-1-michal.wajdeczko@intel.com>

On Wed, Feb 14, 2024 at 10:46:53PM +0100, Michal Wajdeczko wrote:
> It is quite common practice to make u16, u32 or u64 values from
> smaller words.  Add simple helpers for that.
> 
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> ---
> v2: new macro names due to conflict with crypto/aria.h
>     explicit cast and truncation everywhere (Alexey)
>     moved to wordpart.h (Andy)
> ---
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Jani Nikula <jani.nikula@intel.com>
> ---
>  include/linux/wordpart.h | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
> index f6f8f83b15b0..8c75a5355112 100644
> --- a/include/linux/wordpart.h
> +++ b/include/linux/wordpart.h
> @@ -31,6 +31,38 @@
>   */
>  #define lower_16_bits(n) ((u16)((n) & 0xffff))
>  
> +/**
> + * make_u16_from_u8 - make u16 value from two u8 values
> + * @hi: value representing upper 8 bits
> + * @lo: value representing lower 8 bits
> + */
> +#define make_u16_from_u8(hi, lo) ((u16)((u16)(u8)(hi) << 8 | (u8)(lo)))

Do we want to actually do type validation here? Right now it's just
cast/truncating, which based on the version log is by design. Is silent
truncation the right thing to do?

-- 
Kees Cook

