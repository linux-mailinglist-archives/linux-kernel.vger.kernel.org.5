Return-Path: <linux-kernel+bounces-52677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81899849B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9EB8B28054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B4C1C6B8;
	Mon,  5 Feb 2024 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SDZwewWG"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743001BDC8
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138112; cv=none; b=uJ8Ie8PRCvRIe1FC1/212lGhbCPF++J/dgmGcQwVv1L4ytokRg/E5dJG+sY/dmV3TNwYBvYEKccbLSR2sFH7j34IVrB3I/y3J26cxf4cY/gXfIpi5TSsLGfacfvaiqrYdWFHpJWHVGIBtpRJ4gEkQC3gteH8CIozzmYwkRpSt0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138112; c=relaxed/simple;
	bh=u7/FoYb551+6GiEJx2PLVrRRol56CFg9Lgrs6ZHrVGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXp+Ofa9vjzDvNOamr/FmX+f/7KUwUitEnbRF0KW3ObVg5eoNZrJ2NdYp+KzzFPYSOZNXRol4BhpNykMRxKVe8mNIFI7kr3xCI2o0bHxSM4vrEtJiWg0b3+9vxeftCL/1EtPUncknXhdmqRVsfUtGlt+OxhxzBHL0G0YS9EXcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SDZwewWG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dc20645871so259396a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707138111; x=1707742911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=57ai5j/KdXT8Xuudktal72yNjlF1/d5qdT3nTQk3sYc=;
        b=SDZwewWG+NQIkeC5kHbN5QjrbnCn0YhohNSrRHvUdrvUD2rXWHN9iCXStKdAlJhZ1c
         N5420yjHUEONYx6VhZlcw7WaXz5yDR6kASxcYEbi86RxdjEA9Zi6dfvtsx17aFCkwfxH
         ddvWU7cT9PGayuRtYsLJHGvCJXjwsROm9OB6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138111; x=1707742911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57ai5j/KdXT8Xuudktal72yNjlF1/d5qdT3nTQk3sYc=;
        b=H/GcdaZH4bTsIdaGYUqqA2ubS62+r7JPMu3ssdeYTsb2O30jvl2mjIA5/p9Zu8qv7P
         HITe3KO3X0S2YQC4ye4Teys4vnJLujhT2SHfVphJZBa9s6XPqM4TciSDqB75RWnd0yzT
         1Qldat3IYGeGjrKQUXPmm9HzNA+rqbcQUvBt1KJJwMrWmFLzrl0TY8HKKQAYvrsYGMSy
         fzAvaa4i0UbD5jX8k0Mdq6UNh90Hurs4YfQBI/7S3OLlcG1u++KY5Yw+6tNWhv9xufRn
         VSOJHSJPq/7+E0Q43q5ggZY1tK6FcMs8bsWFsZnZtExc5nC9IVosEZtSlfQU55FIEU7c
         LDKg==
X-Gm-Message-State: AOJu0YwEkUZhBWxZYCWz0kts9P/YChZnxYkUX1gSXCbB4JAf+I3CI2Pa
	GvroZ/sZLvIBsoNtowquGzNeC9VsTpbD8ljX0wK47nt37uGJKaJXMwcZZwZw7Q==
X-Google-Smtp-Source: AGHT+IFe46ojQoH2YselLfpT2gtd5+tRvTVNZVqNDtKHKqs4ZRDAvyBfalg9/6eSbk6JPFFd2KNgDg==
X-Received: by 2002:a05:6a21:339d:b0:19c:9c76:e9b2 with SMTP id yy29-20020a056a21339d00b0019c9c76e9b2mr8360893pzb.13.1707138110568;
        Mon, 05 Feb 2024 05:01:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUtUWfFSyD5FOGxTMeDCC5sR5gUOAGgcddh8KV/jODNhPn5ACeCKZ3SkqqhVQVpNQraBpC/C1/0tXH2vZKCoyMeSgRjv8RKjZSYXvIGngozhzeSa/rU+CFomNmjTNw8z/lWkx5sC7C8VFqoseDjplggWGRcH7U0J54E28KmSIsCwLP/K6HmevdIjmnwQHT47IHbtlkFVatwH/c18MX95YHvZUWmhxR56RksDd0/ZQfPKkxxPz3sH6mexzOyY+H3hVeuwDE5yeC5Af1o86/PZytEPQ60NHI480KqDdZHH2SaGg1gF3HsPGBqN6dVTRipIvNLrDeCqiK27uPMD7wkobpvF/jZMInY1YW2+2Sir81+QAu2Z6A7VRbZh31vBe2u9NlcWFbRmHdrrqI+aywr5Ca49yqEXBLEjPEis65uNn1MR6zraDeR3OceSvEwQzxRqdoyAt/+OTUDeZu69MrtUNLv
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o133-20020a62cd8b000000b006e033804fa8sm3691905pfg.101.2024.02.05.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:01:50 -0800 (PST)
Date: Mon, 5 Feb 2024 05:01:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 2/4] string: Allow 2-argument strscpy()
Message-ID: <202402050459.892907C59C@keescook>
References: <20240205122916.it.909-kees@kernel.org>
 <20240205123525.1379299-2-keescook@chromium.org>
 <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU2c75WDCX+ptQgB7h0taHjG2pwL9db6gE3LKxv5Vz04Q@mail.gmail.com>

On Mon, Feb 05, 2024 at 01:47:08PM +0100, Geert Uytterhoeven wrote:
> > +/*
> > + * The 2 argument style can only be used when dst is an array with a
> > + * known size.
> > + */
> > +#define __strscpy0(dst, src, ...)      \
> > +       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
> > +#define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
> 
> (dst), (src), (size) etc.

I normally don't do this when macro args are being expanded into
function arguments. I've only done it for when macro args are used in
expressions. Am I missing a side-effect here, or is this more about
stylistic consistency?

-- 
Kees Cook

