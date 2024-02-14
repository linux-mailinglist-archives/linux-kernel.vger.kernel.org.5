Return-Path: <linux-kernel+bounces-65844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9893A8552C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AAE01F29D95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C3D139569;
	Wed, 14 Feb 2024 18:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DE7QeQ1U"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2532189
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936891; cv=none; b=AbyJKSLeHwhP7hc8iXF0CHANU2sh5wGBoVjgmCzAeNpWZjJk3hbDxVf69RHsyislHOGrCTkBZyIf2ba9Ti+gE5jysRu9JfMy4r4hlkfZqFidWKho2r3fN8agLYd3omx0qMZihMk0Y08LlKLor14MTkk2xNnilxSA73+CG5vlE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936891; c=relaxed/simple;
	bh=TjwmYLpeypFyyfpfgocmzJcbXJdu9sn6DKS6rnbBQY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIfsS8oZTUq81mHu7mc07J4hI4dkWDfgaHjUFH4eb6lqGTpxQW4C86Wzdkugg/jsPLYEVvLbugCav8v9FIfCnwcm9f75WAVzK6+FPE5+W/LcvG5mO7v7MWM52o/jQYXQtjKcedzTWu0DWuskSQqXXINmrcxLLgu23W0RzNm65AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DE7QeQ1U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d94323d547so346975ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707936889; x=1708541689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gJax3xnMcf0xkXtG70TyKKTkMb2f84I8rlNloLbyxRY=;
        b=DE7QeQ1UhJnuT0p/xb8HT/lhgNotxw6QXRcZGMaJiKuOZDvOyDUjMvpzF569DKqb8R
         F0KN7V1LnzXwyop9QfaWi7N5T1YL0SNsq/rVqyJy7ZneprhopZOfH+IMf534ocdy/7Ds
         L25531626KRO8iifSIPst/D69N+/ltWXBiqbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936889; x=1708541689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJax3xnMcf0xkXtG70TyKKTkMb2f84I8rlNloLbyxRY=;
        b=VxNXwaFj9cQKgm1YZQN1Coqrq0x0p1YsY0UNFeMIeOH7zxLUdhTX9zirpRuKkUv5G/
         NF9NyVfxNSW8r+ANsFz/cmSi4AJfikjvv/9x1/I0DMRfozux3U5cwcFsx7NqSd/2G89R
         3scXhIYoagHnj4XgiM37nEKo7XSvxaWPQ1e4rUJGI731V9iDUAXY+EvD9WWpVOS6mwr9
         snRJTX0NAB+r6d6BbWk16cjQss+Y2mPeu0XZLpVC91tneZUYcdYY7V0Eu7HrpLOS6Tpe
         UjvXlqeGcJvZoKgMfrwFuGBkSvPOBq0pXEegtfMn4eDhKh9IN1oOLkViM7r1icn763wc
         7Qhw==
X-Forwarded-Encrypted: i=1; AJvYcCUEV8cFrnVzk77FljyDIrQPDjR0BCLipDlYvS39dCJZ1XHmxifgimF3gWQJXrcomvdJGav7dR/D4DaHzPow9MqSY9+WGtEzY9HctTJU
X-Gm-Message-State: AOJu0Yy2t5hKQtfoA41Wmx+9TTf3i1glF0jGvLu1d+Y3Pz2yHNs+cwlq
	ntd50bdW/tmhkof6BQjccrEYJr5j8S5SIAS6MIym+zz8niVDu+1/BV7SUp7QcQ==
X-Google-Smtp-Source: AGHT+IFEXPGujPYWfk2dgFzzpvP8+mCnkKpBOyrGwAqKCL6ktBZbgZ21WVAx0yuguQoVvn6Malb4dw==
X-Received: by 2002:a17:902:eac4:b0:1db:4b29:9b21 with SMTP id p4-20020a170902eac400b001db4b299b21mr3729306pld.23.1707936888638;
        Wed, 14 Feb 2024 10:54:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUC8y+VQV7BSrcRmIHAX9HUlvrsurVRPHRPjbDKm3X6ckF4SuLMyLXN0BxDCdPJCoVsDPfvIQUecDf3CgEIuPWSTYBu9jowYDsZ4j88B4XyGhCa/lrdrB2GcOyDGZO3RApeZ/TJmqsZSw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc19-20020a17090325d300b001db2ff16acasm3422657plb.128.2024.02.14.10.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:54:48 -0800 (PST)
Date: Wed, 14 Feb 2024 10:54:47 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits()
 to wordpath.h
Message-ID: <202402141054.13640F7@keescook>
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
 <9cba3b78-1020-4337-a1f9-5857a297aee4@infradead.org>
 <Zc0CcNbpFrkkqiow@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc0CcNbpFrkkqiow@smile.fi.intel.com>

On Wed, Feb 14, 2024 at 08:12:00PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 10:09:10AM -0800, Randy Dunlap wrote:
> > On 2/14/24 09:26, Andy Shevchenko wrote:
> > > The wordpart.h header is collecting APIs related to the handling
> > > parts of the word (usually in byte granularity). The upper_*_bits()
> > > and lower_*_bits() are good candidates to be moved to there.
> > > 
> > > This helps to clean up header dependency hell with regard to kernel.h
> > > as the latter gathers completely unrelated stuff together and slows
> > > down compilation (especially when it's included into other header).
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > > 
> > > Kees, since wordpart.h is now only in your tree, this is supposed
> > > to go there as well.
> > 
> > after someone corrects the Subject (wordpath -> wordpart).
> 
> Oh, indeed. Thanks for spotting this!
> Kees, should I send a v2 or you can amend when applying?

I've amended it; thanks for the catch Randy!

-Kees

> 
> > Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks!
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Kees Cook

