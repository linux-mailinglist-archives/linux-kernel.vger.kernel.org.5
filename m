Return-Path: <linux-kernel+bounces-36098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11910839B8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE901F25256
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351B48CCF;
	Tue, 23 Jan 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dnUsN6DK"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B2048CC5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046997; cv=none; b=iBH143rmrKWHGa6MepuOj+rkxT14TRQLuCVXC0aKxIvvgdKfEl+1mm5HMtO74Rd04SjcL2koxf+Tdri7OithSC2SYBTjjQi13f80xzaQiQ2j59yMCvVV9gwjFrIt2nt/PGaEeKtUHJajZ0q7q9GIjX2a3U/8PLFlDqpNOzNnIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046997; c=relaxed/simple;
	bh=0c0F7eeZoGxLjeqmmKMm57vl0kvVl9qLdYbdVXMjG/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcrVD/eeKfpz3H7KYrV3yqO9U2E1iy1lHUgbcJdll3/mRdFRii4lvZ5IRrU3iidGRdVTzF2Af7C4kWpxGZVABgDjAERrpCKBCOPb0mGk5Ufl4P93GTA1U+jAVc/m7Pcgg4QCqpRtMkWVFDuqI8eQddTl6BpsvceWiHGPj9rtpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dnUsN6DK; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e0a64d9449so3087899a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046995; x=1706651795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E9lSja7LT9ZtyMjrI1OsUow8Sb3Qq23rG9UTWBb1Ccs=;
        b=dnUsN6DKQh+VpiCCuR37lloHK4N+7R+RrkbATSNTwzOVUoquPjBXkYO4b4/1E0a/Bb
         Lvj+F1d9YgEK79pu6YXtXvLijPzWslhB4cKK7R7DeP9LnP5vcULVDKtKiTfqRxJL0Ewb
         es1itWf9x4GhHLJsHK04rMahYijelxnFy4qZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046995; x=1706651795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9lSja7LT9ZtyMjrI1OsUow8Sb3Qq23rG9UTWBb1Ccs=;
        b=lhrLgXj0er5AjXNEnp4OcTqfoWNCmhcTwk6e+Gds+hnCijOcpw1unZGsSEgOr2//H/
         Yq324QPaOKdmZHZRacIX765ntYr69Os1vs3+xxLES6wEag6h5e3jb5yYtN6ijvkqQCob
         tKRf619oAZ8flUGucyGXYPCm+Foqe71WWrS/KxBmMrnelDIJp7ozJmM/GvZqbYf3W69H
         RnpIzYJeEPgRHvvAYq5+VuqMWYJgVSiWwAGWdTFk0IPedAcyuLbpqQGWZh8EnR4MfH9C
         eZwVpHvlnvMk4CcmdoHdnvvj77TqI33ixp7O8DtQ7G5YYxocG1BLofBkfvbBbGe+ycVq
         EGoA==
X-Gm-Message-State: AOJu0Yy9OsH7SCmow/oba5RYuWOivOp6CifOIvmgh3MLY3e5R+eJy0Hf
	PnMp+ti002Bp1rLfPR2KrlDBkMz/4OjFKy1VRrog/dipwk78o1URxqLsCCb29Q==
X-Google-Smtp-Source: AGHT+IHrC0JsOHXDSkWplzZP5dJON/Iq8CLEVyg/OoprJ47UgtWcaFQU2EZfDJcGRYxMPUlvC77W1Q==
X-Received: by 2002:a05:6359:4598:b0:176:860c:cc5a with SMTP id no24-20020a056359459800b00176860ccc5amr588759rwb.5.1706046995347;
        Tue, 23 Jan 2024 13:56:35 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b006dd85222cc3sm683579pfl.134.2024.01.23.13.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:56:35 -0800 (PST)
Date: Tue, 23 Jan 2024 13:56:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/82] overflow: Refactor open-coded arithmetic
 wrap-around
Message-ID: <202401231355.A94FADCAE@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <Za-K-3aSBULf4NWE@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-K-3aSBULf4NWE@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:46:35AM +0000, Mark Rutland wrote:
> With that in mind, I note that this patch primarily modifies addition
> operations, but leaves subtraction operations unchanged (even though those
> permit the value to go below the minimum, or above the maximum if a negative
> value is used as the subtrahend).

Right, this was kind of a "first pass" on what I'd found so far.

> Shouldn't we address both at the same time? I'll note that in many places the
> same logic is used for both the add and sub, and can legitimately overflow or
> underflow; I hope that whatever we use to suppress overflow warnings also
> ignores underflow.
> 
> [...]
> 
> Looking at the diffstat, I think you've missed a few places:
> 
> [...]
> 
> This misses the include/asm-generic/{atomic,atomic64}.h implementations.
> 
> This also misses the include/linux/atomic/atomic-arch-fallback.h
> implementations. Those are generated from the scripts/atomic/fallbacks/*
> templates, and you'll need to adjust at least fetch_add_unless and
> inc_unless_negative. As noted on other patches, my preference is to use
> add_wrap() in those.
> [...]
> This misses lib/atomic64.c.

Thanks! I'll take a closer look at places we can use the helpers on the
atomics.

-Kees

-- 
Kees Cook

