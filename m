Return-Path: <linux-kernel+bounces-43464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1967984143B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89D6AB247B5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA181534EB;
	Mon, 29 Jan 2024 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C+R5wmvj"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0CA6F09C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706559987; cv=none; b=PEQzYV/jcXyvAe2LZobWu8V2qrFXAtPHod6LQSddiavB3Vf89PzCFUgkfu8yAYanSlQdYIgoXsZK/cVkqcRxgOquW2ySlhdie7cJfBF6vHtunZvkzAM+upLh/VOevkgC7h0s0bPt9GiK3ItsFAeLK1nqnz1gQfiH7I7ngk1jID8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706559987; c=relaxed/simple;
	bh=SMrAnU030wuDhlboOt55byceqkItemYdSY9Vo59Y2yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOcsliQ4DDBwt6JxxOCWhWWjj7STclUUNKzC2cWIBUWQkdyo/TAGKDAlUcSFlWfuHwgyXalibwK+iQWKa4hCRp8tg7/uFTocLRzSEES9PCkKBStsNHT6ad3ejQtk5nnp/idFjFejx8X8ngdZoIMzXZGLFQCWDUHdkjy135lcSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C+R5wmvj; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ddc1fad6ddso2690207b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706559985; x=1707164785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6E+CSDDSvT91f9Viy+M6uu4Auu69C79V+Tns03Gp4VA=;
        b=C+R5wmvjfctGYZ9SDDMSVdhjyUSByuz1xutV7NvLPV+DijWDZeL0ByHkiMBD9nuV42
         cUMhqHqVCk9SaqAvZ09kpnC7D/IFzz2OjBu1Th9eqTBS2gWlDRpmew+m+G0g9QDSQJk8
         hgt7tmGFi3bGZp1p+rPFWDyzoPpr8I4X1fysM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706559985; x=1707164785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E+CSDDSvT91f9Viy+M6uu4Auu69C79V+Tns03Gp4VA=;
        b=L++LGq5fEIqT5tJZH+VNyzvhr47HlSjsr4aSJdMQDxysGI5HV0Lar2sZ+tiAdH7T4D
         +f2S1hguWfBDqWI/CaVxZUcMnjUM7B81M6fHB3irqRjc66cvN0Nn2nUvmJOErFalE/cE
         oqC4jZh6Hlr1fkfBioAjTt9AqnsCVvT3c+k1H5Mq3wVikbmq9XtSCPuB/35IA+oOiBXF
         M9Xe1xAR1m80rlVXPHRrqGmgFJwNXoI5OnFCoDU0Baaad6obLvrpdixBNQtTWJ0iHhij
         yVc0JnDel0TuT2qG7pQX1QrBhNySodBCo/u9sC0pd5tnZdsHhnmanxfJAmwVpLMqhf3i
         8IZA==
X-Gm-Message-State: AOJu0Yyhl0CAG1lWh0uXdqvICUWGNJ1vjx0ghgS44ZnepKM1ouZ5DF0r
	Z062Jrqb/0lJokVPi32LlfQ4IzBsHcERK1TW0r+RJjxEEViYedoaosyLPAPD3g==
X-Google-Smtp-Source: AGHT+IEljCTSge/PCk3xrZvAhS+vec3Iv/hm4f2dPqTNvAEMD81HKYx4c8Hh7l8Y79fYPZE4uKvCYQ==
X-Received: by 2002:a05:6a00:d74:b0:6dd:8a25:e167 with SMTP id n52-20020a056a000d7400b006dd8a25e167mr4255359pfv.34.1706559985074;
        Mon, 29 Jan 2024 12:26:25 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a15-20020aa78e8f000000b006ddc3794de7sm6239422pfr.134.2024.01.29.12.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:26:24 -0800 (PST)
Date: Mon, 29 Jan 2024 12:26:23 -0800
From: Kees Cook <keescook@chromium.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 4/5] overflow: Introduce add_wrap(), sub_wrap(), and
 mul_wrap()
Message-ID: <202401291224.53CA9C17E0@keescook>
References: <20240129182845.work.694-kees@kernel.org>
 <20240129183411.3791340-4-keescook@chromium.org>
 <8dead2fb-d522-492b-89f2-1358198c1cdf@prevas.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dead2fb-d522-492b-89f2-1358198c1cdf@prevas.dk>

On Mon, Jan 29, 2024 at 09:08:43PM +0100, Rasmus Villemoes wrote:
> On 29/01/2024 19.34, Kees Cook wrote:
> > Provide helpers that will perform wrapping addition, subtraction, or
> > multiplication without tripping the arithmetic wrap-around sanitizers. The
> > first argument is the type under which the wrap-around should happen
> > with. In other words, these two calls will get very different results:
> > 
> > 	add_wrap(int, 50, 50) == 2500
> > 	add_wrap(u8,  50, 50) ==  196
> 
> s/add/mul/g I suppose.

Oops, yes.

> > Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 54 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 54 insertions(+)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 3c46c648d2e8..4f945e9e7881 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -120,6 +120,24 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >  		check_add_overflow(var, offset, &__result);	\
> >  	}))
> >  
> > +/**
> > + * add_wrap() - Intentionally perform a wrapping addition
> > + * @type: type to check overflow against
> 
> Well, nothing is "checked", so why not just say "type of result"?

Yeah, that's better. I was trying to describe that @type will affect the
value of the result.

> > +/**
> > + * sub_wrap() - Intentionally perform a wrapping subtraction
> > + * @type: type to check underflow against
> 
> The terminology becomes muddy, is (INT_MAX) - (-1) an underflow or
> overflow? Anyway, see above.

Right, I should explicitly say "wrap-around".

> 
> >  
> > +/**
> > + * mul_wrap() - Intentionally perform a wrapping multiplication
> > + * @type: type to check underflow against
> 
> And here there's definitely a copy-pasto.

Ek, yes.

> The code itself looks fine.

Thanks!

-- 
Kees Cook

