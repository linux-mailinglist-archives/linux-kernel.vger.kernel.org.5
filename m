Return-Path: <linux-kernel+bounces-65886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73485534A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1BC1F28991
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1007113B7A8;
	Wed, 14 Feb 2024 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxM9v6zF"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8113B7A6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939540; cv=none; b=XeLDU7D7TeVTd0Vf4Rp9j7KESm1+gfoH1sNXZTI004bZp361ToS5JyAuGkZP8BLaq7c+anYYfIs/hlbgJglEwF6QMieOHe+HQjVSdgS4Q38hExSj1poAFE0yF/L9SQkVLGJ0G4/XwmiKZTJx6decb68PuCVWVUofPyKmom3oXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939540; c=relaxed/simple;
	bh=uK/uiC9xQoMrRYzHaj/0K7lprzw7OLm3ONfyrd3XA2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzGdTRBggd03NbnTR0rrbS6yzJq4ozdIk0kJieF3e42prf2f0LGbrfxnLGBXO88cJlKpmvDjwnvaG1b8BALU31BMxkLvRtFPlFaWNaVNl7yrMeMZM3EgBsPnC0qt6TDnR9sr6DXbQayub68/ZqaanTRmqHF0X+WmFMSRwY99Q+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QxM9v6zF; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d918008b99so723835ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707939538; x=1708544338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/rQz56FZw2RH2/D+KmiOQoX2U0utfpN1YnKl4r/zwck=;
        b=QxM9v6zFd4CGlpP3G4ukKltcjkvOQ8xSHSrHg0swTj9iUB5/6Xuew6PhfbKmSEjemO
         rmbQ5k3cQKhBBtSGo9AotZuisZc/3O1TQusMIze18dDAjV+1yrl9Mb+6dh1otJfMGIqE
         m04HzeKvsGg3tnDojam64hV1atXqLANR6yqBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939538; x=1708544338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rQz56FZw2RH2/D+KmiOQoX2U0utfpN1YnKl4r/zwck=;
        b=MhXjnPdTsiGYmq/ulIlO3/w9ZxEX+0g2wMTKvZN+aKx73JjTWhOFLKmkeGunNRHADW
         Vi0JAO4cSDUeZN+wIkZutzOk8+OHHi2SU5H2RDve/nfPLsYG5VCA04sH/ErMcEX7QUk/
         W6WXZ9Mlo/enYvWaxy2uqz/9LXhMNImB0s+wk6YN+lCQTwjPIDwg22A2drVzO6wBLru1
         bQc6wlRvtsfwppycIHEf/esj4R96C8yQXDzy2Y56Nz+uw7dmUeQGDbajL5yuHG5QzDuE
         uLoCbp+bTR3PFvEKmAbRSP5WAFuWX67mD5PCy4pWKzpXdNRWhaxQ1YfT1GkXnKGeTgN9
         a+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrdQ0IT+DZZ7Y5BZBIsv93av+SKmQxYLuyreV3y1Ug3JullgS6HW2Gz2Ho4QNFBjpV6gXtXW3TYZAw7tiQUeLZ448M0+qZj/RtIFXi
X-Gm-Message-State: AOJu0YwGzDF/h54A6Ky99l8aYoygrPrXC3c3qLlGl6zzwZiesYBrrnKU
	S538tH+BLdV0k21xoPFdVa5v3JdZ7/H1Vj0z98NrGBKWau9bU5cSAJAJ1DtF8w==
X-Google-Smtp-Source: AGHT+IFeLbM4q9oE3yTdnPC3ZKFeX7ALUUgaZIz9TQ5M0+/49eUCHnVui91o6qgIZaw5T42/8VQ34A==
X-Received: by 2002:a17:90b:605:b0:296:2057:28c with SMTP id gb5-20020a17090b060500b002962057028cmr3614823pjb.31.1707939538082;
        Wed, 14 Feb 2024 11:38:58 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090a604f00b00298cc4c56cdsm1795818pjm.22.2024.02.14.11.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:57 -0800 (PST)
Date: Wed, 14 Feb 2024 11:38:57 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] overflow: Adjust check_*_overflow() kern-doc to
 reflect results
Message-ID: <202402141136.6B12D6E6@keescook>
References: <20240213220844.it.345-kees@kernel.org>
 <20240213221100.3556356-1-keescook@chromium.org>
 <ZcyqqN3wVrKwkzrs@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcyqqN3wVrKwkzrs@FVFF77S0Q05N>

On Wed, Feb 14, 2024 at 11:57:28AM +0000, Mark Rutland wrote:
> On Tue, Feb 13, 2024 at 02:10:57PM -0800, Kees Cook wrote:
> > The check_*_overflow() helpers will return results with potentially
> > wrapped-around values. These values have always been checked by the
> > selftests, so avoid the confusing language in the kern-doc. The idea of
> > "safe for use" was relative to the expectation of whether or not the
> > caller wants a wrapped value -- the calculation itself will always follow
> > arithmetic wrapping rules.
> > 
> > Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  include/linux/overflow.h | 18 ++++++------------
> >  1 file changed, 6 insertions(+), 12 deletions(-)
> > 
> > diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> > index 7b5cf4a5cd19..4e741ebb8005 100644
> > --- a/include/linux/overflow.h
> > +++ b/include/linux/overflow.h
> > @@ -57,11 +57,9 @@ static inline bool __must_check __must_check_overflow(bool overflow)
> >   * @b: second addend
> >   * @d: pointer to store sum
> >   *
> > - * Returns 0 on success.
> > + * Returns 0 on success, 1 on wrap-around.
> 
> Sorry for the last minute bikeshedding, but could we clarify 'success' here?
> e.g. I think it'd be clearer to say:
> 
>   Returns true on wrap-around, false otherwise.
> 
> Note that also uses true/false since these all return bool (as do the
> underlying __builtin_*_overflow() functions).

Yeah, that's a good point. I'll update this.

> >   *
> > - * *@d holds the results of the attempted addition, but is not considered
> > - * "safe for use" on a non-zero return value, which indicates that the
> > - * sum has overflowed or been truncated.
> > + * *@d holds the results of the attempted addition, which may wrap-around.
> 
> How about:
> 
>   @d holds the results of the attempted addition, regardless of whether
>   wrap-around occurred.
> 
> ... and likewise for the others below?

Yeah, that's more clear. Thanks!

-Kees

-- 
Kees Cook

