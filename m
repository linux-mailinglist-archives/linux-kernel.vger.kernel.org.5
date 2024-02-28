Return-Path: <linux-kernel+bounces-85725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF786B9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308DF289116
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1C27003F;
	Wed, 28 Feb 2024 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBN6sDQb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8E4D11F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155998; cv=none; b=ra/CRRoq6q7s2tUVumJ3b3C3JCi34ml7nI/qEGqaYMJg6ZQxff1jwK5oWUjbY30rCSi6QWnJoHbPwkBfmkAgXd7b1zW2il8wKgehTynXMXQ/46DeF9V3UHA/Y/v0PQr/49vFomYDI3GWOW68ARhSMxa3UZR4Gi47eC9r1cPB61c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155998; c=relaxed/simple;
	bh=2QplW/PSL+l5wBlz2Fhb2MD7icGVtnf5yghrdyR7zlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzQgaPxtXpcEJYN/faCYIOGfrg7DCPHMtaGa6/mKhs2iJL5gh1X8GX5RVjwqR+EyiCgMYEYDfQ+7lN2qQ5okC3gGUOgWFvUd0Tq1ivQLIFRoUKUbuPBp8P9VAxCT1WYWH6aOHEt+M2izOcpV19agZeZsddb+z78y25ef/oyJ1aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBN6sDQb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d944e8f367so2158555ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709155997; x=1709760797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XLd8h0kEPBZWXG99LoXPX1j7y1LhX/a2aDKq9S3uX68=;
        b=aBN6sDQbxrowODDrLK+SjX+fBVboj16jTtc0JmnAsYlX+IxsJR//Q78Ef229q7BVeH
         k1loVZK1lowplOUnadJZy6JVfXerQXD8WmyZTW9TvRQjvfhk9aXLvNV/TdU3BT+CZ6AJ
         AA8I7rfTB85C3iJawTE0geey0WYKINkco6uXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155997; x=1709760797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLd8h0kEPBZWXG99LoXPX1j7y1LhX/a2aDKq9S3uX68=;
        b=JWYA2mtCQdSspT0zvjTLFj3jONagiHaaTObqxruw9gXfLUyeu8xaPLsft4pvXN1p/f
         bamyH4LydwkP20uE5mWpL9Y/Rlq860kC/V63RAwH2zwalaSRrIQjf+223cfhRV8413ny
         WBIlBAumUst06bKhb1M8p/ahPpGWxCeY2+fEIIVWkzgLcPgJqRlbwsHZ2nnG88xCF/Na
         jzDg4avVseRJyFWOR91JrahNy4hw1DddSTaLRey4Mj3ouAR3kRbnDPvOT2G8OfTJZnOc
         Jr8rQ6CI/oJcsKUIHjVFmdJ6YLfWw0zmale6S1itx9+W7J06Oo0XL1iSirTROlf3Q8y9
         Ljlw==
X-Forwarded-Encrypted: i=1; AJvYcCUkwoMdE8ZFEHkcYHS162B36f3Qqzx6nWCRoow7WeTI1rrBoDH4cO/E2I5xrlUns2G39s/GF+xUYS399TiK3VInupb2+qT5DBDVDGPB
X-Gm-Message-State: AOJu0YzWMHiUraNX1TQLi6Rax47WWtfKRbAveEYYth3bQnSnYXTHhFgt
	V0ElqQRXEZYkG28Y46Flu+49YXcgS/8Ldq3dY4HvCZIrPD2Ogk2wntQkz1039Q==
X-Google-Smtp-Source: AGHT+IGO5QT2ql8Rf0ElQjy3mY7mI7ajEF2Z3zSl9mRYp9jbKdiPIbR1SfabYEntk3bTWsEUAJJ/WQ==
X-Received: by 2002:a17:902:ce02:b0:1d9:f83e:3a54 with SMTP id k2-20020a170902ce0200b001d9f83e3a54mr192671plg.64.1709155996838;
        Wed, 28 Feb 2024 13:33:16 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902848200b001dca997b3e3sm3729404plo.65.2024.02.28.13.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 13:33:15 -0800 (PST)
Date: Wed, 28 Feb 2024 13:33:15 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 1/8] overflow: Use POD in check_shl_overflow()
Message-ID: <202402281332.9B2F13570@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228204919.3680786-2-andriy.shevchenko@linux.intel.com>

On Wed, Feb 28, 2024 at 10:41:31PM +0200, Andy Shevchenko wrote:
> The check_shl_overflow() uses u64 type that is defined in types.h.
> Instead of including that header, just switch to use POD type
> directly.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

