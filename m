Return-Path: <linux-kernel+bounces-67783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A98570B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C5F1C21BDE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68B13DBBE;
	Thu, 15 Feb 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FaW8KCF0"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BB1EA80
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708037223; cv=none; b=W8suwwlAc6imfF+/VRFkfWdOAfv9lqKBR19oBS/DonEoyksqu4dSyi3Y83YmyCUXX4MSkW15aSc3g18G84wVyEq5JHzdKkIR1odTEmwB7IJruDNp05QIE+fHHQBuWKznJLacoPb53y/irQIqBtY0VrX7q5tVJCxxr0+Y/ZtTBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708037223; c=relaxed/simple;
	bh=ySqDVtaxhw9+go8nYfR3xSx2fEIuu3orLN2+ehZNwLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhyqVcqDoOHgsY70JeuslQvSHwbGisnYJrzylods9m41oTZD0ULmeDcUXI7gfcJ23+OPD7+p+04SyZaNnMvGoFSYucMLO459Sz+DzDA9oOX5Zal8RqU80LkKEU2tV1dnF2FlzoIRKQI5wGxIzIiT1rlnS/R78yRdgZPlzyuNkzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FaW8KCF0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e09a890341so942458b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708037222; x=1708642022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RwGyOLLUpGP52iFQkqVrw7uMnUv0aQEKJVIPOZEZaEc=;
        b=FaW8KCF06Ydi4TGPOeF1/CDqyfPPqO+Pka7HqTjQElatg+Pzw1FnTl2HmmaXlQA/G/
         LCmAqBA6X66kXmTMVAA7XhbiPYWsy3DBzy0PViHCiPL03RL1967JnfHh87xfYH/mmo2z
         Ad3F8RjwWm0P5RClLu0Hy+3udZtkQSJ+nmVb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708037222; x=1708642022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwGyOLLUpGP52iFQkqVrw7uMnUv0aQEKJVIPOZEZaEc=;
        b=Gn4A585dGGiseYmfYYoRGVAx5uYiFD0iizf2mNeNtFsa8iBL80wvwXp4PFAz/Z/fLh
         Q1Fghjs0RuNtC6LmxB/21UD1HoQbaHlBmwfMrO7SK5T5U5gm2islGMF0dzJyILX0nlOT
         Ph/f4sgpi5DSbBxJoQvFkZ+1UHPrIbwjsp4DQaRE7Ykq2JdZizmrXEzV/SVdKqSHcp1U
         /7AAbWPmv1e1UOGQnksXzANBNXn7FoiH4rtKOm0OOuf8Y5eRCOP6uX6GyvG/vpGuruTY
         Q+2IYFLi/uUO8ejW0OthBLAiovu751Olxv1ld0PPm5PNrUY2G4Xg3BlyWMWS/vYeTFk0
         IWQQ==
X-Gm-Message-State: AOJu0YyHTfOxt1luwiB1t/dkVlQ15q8C+CkphQm4xyOrMyJx+EeBqUsu
	AYrriFjFA4IjiKa0a7XgETnr8m5Zs1SFDoupA9tr7bT+mnn1rTJSdmt+cQgftw==
X-Google-Smtp-Source: AGHT+IHGP7caxK/sgbw8TPup0kP1V7LQ9zZNHAE4HwpBj9dOkQe9KhI+cYQXIQXSRLUDdE/1tgtpcA==
X-Received: by 2002:a05:6a00:1d06:b0:6df:f7f3:6197 with SMTP id a6-20020a056a001d0600b006dff7f36197mr3644481pfx.34.1708037221717;
        Thu, 15 Feb 2024 14:47:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e10-20020a056a001a8a00b006dd810cdd91sm1842236pfv.88.2024.02.15.14.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 14:47:01 -0800 (PST)
Date: Thu, 15 Feb 2024 14:47:00 -0800
From: Kees Cook <keescook@chromium.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH 1/2] wordpart.h: Helpers for making u16/u32/u64 values
Message-ID: <202402151446.D9AE0626@keescook>
References: <20240214214654.1700-1-michal.wajdeczko@intel.com>
 <202402141408.0E78D47@keescook>
 <a6652e88-c66f-44d5-93a4-be9fa7a4623d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6652e88-c66f-44d5-93a4-be9fa7a4623d@intel.com>

On Thu, Feb 15, 2024 at 09:40:40PM +0100, Michal Wajdeczko wrote:
> On 14.02.2024 23:09, Kees Cook wrote:
> > On Wed, Feb 14, 2024 at 10:46:53PM +0100, Michal Wajdeczko wrote:
> >> It is quite common practice to make u16, u32 or u64 values from
> >> smaller words.  Add simple helpers for that.
> >>
> >> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> >> ---
> >> v2: new macro names due to conflict with crypto/aria.h
> >>     explicit cast and truncation everywhere (Alexey)
> >>     moved to wordpart.h (Andy)
> >> ---
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> >> Cc: Jani Nikula <jani.nikula@intel.com>
> >> ---
> >>  include/linux/wordpart.h | 32 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 32 insertions(+)
> >>
> >> diff --git a/include/linux/wordpart.h b/include/linux/wordpart.h
> >> index f6f8f83b15b0..8c75a5355112 100644
> >> --- a/include/linux/wordpart.h
> >> +++ b/include/linux/wordpart.h
> >> @@ -31,6 +31,38 @@
> >>   */
> >>  #define lower_16_bits(n) ((u16)((n) & 0xffff))
> >>  
> >> +/**
> >> + * make_u16_from_u8 - make u16 value from two u8 values
> >> + * @hi: value representing upper 8 bits
> >> + * @lo: value representing lower 8 bits
> >> + */
> >> +#define make_u16_from_u8(hi, lo) ((u16)((u16)(u8)(hi) << 8 | (u8)(lo)))
> > 
> > Do we want to actually do type validation here? Right now it's just
> > cast/truncating, which based on the version log is by design. Is silent
> > truncation the right thing to do?
> 
> note that even FIELD_PREP() is doing silent truncation and these macros
> here could be treated as specialized/simplified variants of FIELD_PREP()
> as alternate implementation can look like:

Also, isn't all of this endian-specific?

-- 
Kees Cook

