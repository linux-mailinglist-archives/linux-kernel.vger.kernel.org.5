Return-Path: <linux-kernel+bounces-64531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C9F853FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530001F21BF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA966310B;
	Tue, 13 Feb 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BYe52ioW"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32D63104
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707866461; cv=none; b=rGVMxAUDbKASl34AtsaXyf51AMOOYwv1OMLWsC6TnJDBbSGQ819RnriFRK7Xp/RF0cCRaMJAEDqrkeUAnvCPJM91+8yOBreniwSM6FXVDpc2+YyJVOHVzIZHY149KECqlwZeNy1gFgTdbBHjxQUmvfqKYX4+bWWgcvGe1yyRfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707866461; c=relaxed/simple;
	bh=BY5GoIGSOP7dLIG63O9VwREj4mpAu2roSy6H3SM/o2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ed2d21WRtmSICmS5ixpRjSq7boKEfc0GCD7ZWsrQSqKIKww2i34G0u+zPbfkSTGYIeuxMYPseR4sE3Rr3wcXTjyS5KgB021rH+QZ0vPY78eNKCliJNVZrcF2oP15nKxsnA/5hU3Mlr8BoQGyG20X4JZpc+Njim4IZXa8VF9f22I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BYe52ioW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6da9c834646so4033850b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707866459; x=1708471259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krbgXuktMmXDvx9RRRlz549Z3gZJaVVWAcsZQ2TwLyg=;
        b=BYe52ioWyrdtKDhW43xgl7IAsSt4i4qQca6n47xD4n8M5oNj2EjZuW4am3gta1dumA
         BjJJ8hdMU3HQztoAQSKVNk9ELOm2xpNG2+WGyVPlmkZge6FJSIjK45qULLgI7BXtbC6A
         1V7UqQtlnrEh9h5AhemVhB5zqBh8XVkF3mHkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707866459; x=1708471259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krbgXuktMmXDvx9RRRlz549Z3gZJaVVWAcsZQ2TwLyg=;
        b=JZSjpx5iG3eObqbGZIvodvZSWM1rPBDf0XhCfyOMhiYv73L8z3clZDU5uh24yRvDf1
         +8De9OAP9zJj9fBY2fqsKq0I8H6u6ej5hdc+9xiOWRh5FHTEPb4qT8RTtqJSuuDQhkPV
         6dQ2tenLCORVNeLUX58+X+Q7WA1gKj2pqd+OUt4hZepLnJQXzWKMp6OTgIWPmGKPu84K
         N4VkTDMNPpGIsSAmelarpoPfV19bvG+gEJe5jQELr/BamCpckp7hFTgNZI6o3emegcsb
         klxZn/BifplaJKwFFD3Kt46MOdwkN0qKv8dKfFKjtDrdsS3PhafBK9pIFkjujgb/4dmR
         f7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJtz3tCqhCXNBjZhHPp3IwHGviSquaWQE9zw+FELp2sApPLYC+enDwKo8cyQ90rZLZ8EojVwh8/qTjQcZF0/W8Y/zlVuJKQlgG4aOl
X-Gm-Message-State: AOJu0YxS+L+ZArT3YrlC0ehbsb/69UyAA1J1PjoUruYqbHg6SIhv1DDd
	E9zOljTp47yK7MDB0qBkl+sRgy3foV5HKINwcIco3W8kkQxvDD5AfUvozduyoQ==
X-Google-Smtp-Source: AGHT+IEIuNhWErXPZ9nXSxooGV1ezrrMMASQdK7KNyZegoK2alICLBJHRNefpd8UR9NyYC1J3nvTHQ==
X-Received: by 2002:a05:6a21:e85:b0:19e:4aa7:e6ab with SMTP id ma5-20020a056a210e8500b0019e4aa7e6abmr1139087pzb.47.1707866459244;
        Tue, 13 Feb 2024 15:20:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyenkEM0u8YInNl7wXozwjZjFy/pXcY9Apg99QhcV/RG5k0XYmMLfT5qvVBGU+4ublGB2Gh0IB+DvVFVX2LHoZaqPLwwP+UDSK61Y38mC4BzrV3YrV9ZndFHySmtg1MlF6QjEE6MU3aqhGrWVKBJ81hqkMZfHgkHa/Ex+SVf3Z6I4o+H2yYwcwPCpotd0owZpuVm9uMAb4vFZEpgecX9iu81mt0X0vJc5gj9XLK5hDy6UJNVzmuKTK34snoJebc1VU6J27iLfQerSVfqOKmKroKxtOgAQPBjWd8yWMAiF8nWyHwbySptDxlzRhQji66Aydeo4SVQktIxW9Qb93pzVSXFR/mqdQ+bTDb/kkhSZ38doMzgLKmHEHXVYLy+W6JjVRBR33GjVcXymuw17ZuQNDz5ZxCdD6yg20EF2K2WIsjF7c5rNfe5J3KlsUuSmIFeKTtLkFl6fuJ5fiMM2cNY0R7p0oYg==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g15-20020a056a0023cf00b006e08f07f0d1sm7971669pfc.169.2024.02.13.15.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:20:58 -0800 (PST)
Date: Tue, 13 Feb 2024 15:20:58 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Keith Packard <keithp@keithp.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] stddef: Allow attributes to be used when creating
 flex arrays
Message-ID: <202402131520.4C9A035AC@keescook>
References: <20240210011452.work.985-kees@kernel.org>
 <20240210011643.1706285-1-keescook@chromium.org>
 <8ff2496e-925a-4a86-b402-6229767d218d@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ff2496e-925a-4a86-b402-6229767d218d@rasmusvillemoes.dk>

On Tue, Feb 13, 2024 at 08:22:00AM +0100, Rasmus Villemoes wrote:
> On 10/02/2024 02.16, Kees Cook wrote:
> > With the coming support for the __counted_by struct member attribute, we
> > will need a way to add such annotations to the places where
> > DECLARE_FLEX_ARRAY() is used. Introduce DECLARE_FLEX_ARRAY_ATTR() which
> > takes a third argument: the attributes to apply to the flexible array.
> > 
> 
> > - * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
> > - *
> > + * __DECLARE_FLEX_ARRAY_ATTR() - Declare a flexible array usable in a union
> >   * @TYPE: The type of each flexible array element
> >   * @NAME: The name of the flexible array member
> > + * @ATTRS: The list of member attributes to apply
> >   *
> >   * In order to have a flexible array member in a union or alone in a
> >   * struct, it needs to be wrapped in an anonymous struct with at least 1
> >   * named member, but that member can be empty.
> >   */
> > -#define __DECLARE_FLEX_ARRAY(TYPE, NAME)	\
> > +#define __DECLARE_FLEX_ARRAY_ATTR(TYPE, NAME, ATTRS)	\
> >  	struct { \
> >  		struct { } __empty_ ## NAME; \
> > -		TYPE NAME[]; \
> > +		TYPE NAME[] ATTRS; \
> >  	}
> 
> Is it too ugly to not introduce a separate _ATTR macro but instead just do
> 
> #define __DECLARE_FLEX_ARRAY(TYPE, NAME, ...) \
>   ...
>   TYPE NAME[] __VA_ARGS__;
> 
> ?

Oh, yes. That will be much nicer, I think! I will send a v2...

-- 
Kees Cook

