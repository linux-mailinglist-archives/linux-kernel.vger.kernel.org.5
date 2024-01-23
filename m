Return-Path: <linux-kernel+bounces-36153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02724839C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7F51F26621
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3745380A;
	Tue, 23 Jan 2024 22:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A7C2args"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA251010
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049722; cv=none; b=E9eK95ttZ7LDQn5ANqadBBoneVypQjFZpwrtjr51KHbUQ41lWRtUKYnDMDw+C+/4qD1bRXjqwq2EFl5/eQYPpxEHzpIUzqJxIwK1k0FGIsBQLCD5R3jBycIJkF1b/Oaejl53BzatPxEPIp3jYtf8RoMU/cF6zbcmhlM+LdRYtC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049722; c=relaxed/simple;
	bh=zKrh9Cm8LBMdmMkZwJbUhPVyyd35s47X76PNGXAhQBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaMqNEx7K3fShSBUtJr1MO/4a34J//Sp7tBNkn0zgNubKUC2JTkzZxhyuPJMimyfrkfF/DxN1H/eT5WvzeQUoN69Bu7MCTn0gbuUrhLEhwP9KeT/4CUK/fGhYKgTpTxMxQxuyQ1It92BqOdvpNaE7/qD8gdpiFANTidGmlc965c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A7C2args; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b13fe9e9so3931268b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706049720; x=1706654520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLP204yME76cKWvSKqR4QvH8/WxYNOPL78/EyvH5yzk=;
        b=A7C2argsd3w1FTAqLxve7TteXsyWVG+pgmxReCn2t0rVKKDeQI8i0DZxUyQUulG//H
         7NXwjNUhMY/+uLxTo+BvibNxtnB1+tuMjREgkpQvI1twX5dYst7kqTkEeReA0gVAmeOg
         VD0WojfvS6MrngQ7AAduFdFv3hPiiG957MXps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049720; x=1706654520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLP204yME76cKWvSKqR4QvH8/WxYNOPL78/EyvH5yzk=;
        b=IaA58TlsbLeMxOnRwuz13QIXZYd4fKgMdz9Ej9Z5s/LV063Vox5zfSDhfki2I7awWH
         1Y/WpvBYBR6EKn7mNcsS/hrW5MtkWic7DRqfjT4bFDgL8pNJhOZLyH/S4kl2I5h25fVr
         nqg7AzZeIBtKJcfSrphx7XvSHvoo9UQoypNzKnXz9vqgPCi1bAklgUFmP/9At7WsfRN+
         4ybUhYM85EyLPs1dkQeA+eTtTKKO9uheZsOseoTa/NZVtL9Ru5gXbrlzWfpZfganJFkG
         wk1qkdZoxWjaSLD23vQllq2BDFdwuFuHRfydzv8V6nMvJluQjYaIR2fOCR/ck43bqlPE
         BTDg==
X-Gm-Message-State: AOJu0Yyh8mEwRyfw/28K2Y4h7hhUSpfBRKYrOhkfp6MxkCKBUFzpb0w7
	SYY+knV/7kOkOxVQ3Ayol9kP+n8BLnQ8Lj0l/SiNXVid41IsLd40/KfbEXQROw==
X-Google-Smtp-Source: AGHT+IHwpTHhUNklJYwoOZzlpbiuoqmorVbDQt+RpuA3sITy6NnTDgE24fxse09JSEmVMJKrdG/Alg==
X-Received: by 2002:aa7:9f4d:0:b0:6dd:81e6:e93c with SMTP id h13-20020aa79f4d000000b006dd81e6e93cmr1032305pfr.63.1706049720687;
        Tue, 23 Jan 2024 14:42:00 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hq15-20020a056a00680f00b006dbd2231184sm6411616pfb.70.2024.01.23.14.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:42:00 -0800 (PST)
Date: Tue, 23 Jan 2024 14:41:59 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 38/82] arm: 3117/1: Refactor intentional wrap-around test
Message-ID: <202401231441.7A15A53419@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-38-keescook@chromium.org>
 <Za-NRm5e_-Cfz1Nl@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-NRm5e_-Cfz1Nl@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:56:22AM +0000, Mark Rutland wrote:
> The commit title is odd here; '3117/1' is the patch tracker name for the last
> patch. The title should probably be:
> 
> 	arm: nwfpe: Refactor intentional wrap-around test

Whoops, yes. I need to teach my prefix-guessing script to drop the ARM
patch tracker numbers...

-Kees

> 
> Mark.
> 
> On Mon, Jan 22, 2024 at 04:27:13PM -0800, Kees Cook wrote:
> > In an effort to separate intentional arithmetic wrap-around from
> > unexpected wrap-around, we need to refactor places that depend on this
> > kind of math. One of the most common code patterns of this is:
> > 
> > 	VAR + value < VAR
> > 
> > Notably, this is considered "undefined behavior" for signed and pointer
> > types, which the kernel works around by using the -fno-strict-overflow
> > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > want to get the kernel source to the position where we can meaningfully
> > instrument arithmetic wrap-around conditions and catch them when they
> > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > or pointer[4] types.
> > 
> > Refactor open-coded wrap-around addition test to use add_would_overflow().
> > This paves the way to enabling the wrap-around sanitizers in the future.
> > 
> > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > Link: https://github.com/KSPP/linux/issues/26 [2]
> > Link: https://github.com/KSPP/linux/issues/27 [3]
> > Link: https://github.com/KSPP/linux/issues/344 [4]
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/arm/nwfpe/softfloat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
> > index ffa6b438786b..0635b1eda1d3 100644
> > --- a/arch/arm/nwfpe/softfloat.c
> > +++ b/arch/arm/nwfpe/softfloat.c
> > @@ -603,7 +603,7 @@ static floatx80
> >      roundBits = zSig0 & roundMask;
> >      if ( 0x7FFD <= (bits32) ( zExp - 1 ) ) {
> >          if (    ( 0x7FFE < zExp )
> > -             || ( ( zExp == 0x7FFE ) && ( zSig0 + roundIncrement < zSig0 ) )
> > +             || ( ( zExp == 0x7FFE ) && (add_would_overflow(zSig0, roundIncrement)) )
> >             ) {
> >              goto overflow;
> >          }
> > -- 
> > 2.34.1
> > 
> > 

-- 
Kees Cook

