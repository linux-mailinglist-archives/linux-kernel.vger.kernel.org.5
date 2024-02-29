Return-Path: <linux-kernel+bounces-87588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65ABA86D639
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F6E2841FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838866D512;
	Thu, 29 Feb 2024 21:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Otdgupdr"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7054916FF43
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242306; cv=none; b=cj4cLng/KmiFvY4LqJtW7EIXXtBIjZRnTo983GYpohLf2CVPzZjkNHBua3FmtIwcWlnb5SBr5gohy5XAsXBIWOe/p29iVA7+9/awXwVQbSKqCfjfVGtUJL4+8N3nvgDSyBH0+vzMcTyF/jEj59DnPMLz8oaPMA3Ko8BsnivEARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242306; c=relaxed/simple;
	bh=QzZTm6RzwKOCXz1s1DDgA6t36vWxFMgXU9qMOsdvjRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLVAldLQEn6ZYYkcKIGxhvrJyQlVSwDqYCtI0OLRSpW00UlNvUqb42YEK3gO9vmAmjYJ2Cx44qApyvslKt9Tt8QLyc2dDfb1ZHebSYKd9ocFnjrJY1TGQiMQ2o8UwMuxV0byDdOQBMh37WUavSlDfFTre+rKyL6efw4mzGywJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Otdgupdr; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0e5b223eso13742465ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709242305; x=1709847105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fi9gJh0JIT3rydMe7Re3YRcK5pxmffs/i/bQwJvpoAc=;
        b=OtdgupdrMqUU6v6YG5ItdSUVYWtggtW7CLi08MPwU/tGTaozH8afksz/j9WnraUdkZ
         gQO7+saJw0TruPFKJJShHIMwzH14EPnGlOS+T/kEWAOEPVR4l6UaIrHpoabCCEf3XPtP
         BuKQeG2cQ0ZPa/TIhRpwB3WIcITiVw6Bv0O6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242305; x=1709847105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fi9gJh0JIT3rydMe7Re3YRcK5pxmffs/i/bQwJvpoAc=;
        b=gOTEw+Uk8OYMIGEmTy/7+lZ8EGhH+PP52MhoHIhUkXLcj57ihEo23GVOcBxEg/rJ33
         7qo63aIrOS0tDUOrOU3MvDVP0H14EMDCZXq+J1iTV3QUUO/UErfwynO0AQAnFvwADMLI
         veVd4BjVzvslKedt6Fk4vr2cvbTebWYS0QEhvdeMsDa8Djs7b0r1ym1MDHZxrBKoojHi
         v6/r2nIL4MEx0CRuAfqL5zNk9kwj9n3X3tOaIbac+C/IsB2xU8LsoHPlgz8m0BNh1tIp
         Z7OCA5/dSDN95T+xnLmKoE8AbvAw+llDHL2NNXqc/wQaTdY1p1oXUviJtj8H+OPHjl6w
         p8ow==
X-Forwarded-Encrypted: i=1; AJvYcCUduAWpyP9kJKUwIRoruGiXhKnQErdsMbfS48TTy3LyBmO/4aXrOgn0DjNKGnNGZrbhR1U16eQeLx9qo0jm9sJD7XQV71zIRroKZrG1
X-Gm-Message-State: AOJu0YwH1ODkGGxoGfvrZhLaS+uxxn4ODf+TpztGVSiwf3HnLc85Qcqa
	HFsFYnJjPKGOw5GQmLF4CHe3WeiftnAfmFtkbXu4CqSwqmVzzBBL3mQuQIT2ng==
X-Google-Smtp-Source: AGHT+IE+DUv8Qdh0LZ32jo8m9iF3a01wivEsDDN/MHriPt719iWzbKIbR1Qbd56MoYjYqe7Ub9Claw==
X-Received: by 2002:a17:902:654a:b0:1dc:ca72:8318 with SMTP id d10-20020a170902654a00b001dcca728318mr2807886pln.37.1709242304905;
        Thu, 29 Feb 2024 13:31:44 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y9-20020a1709027c8900b001db717d2dbbsm1954387pll.210.2024.02.29.13.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:31:44 -0800 (PST)
Date: Thu, 29 Feb 2024 13:31:43 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-spi@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v4 7/8] net-device: Use new helpers from overflow.h in
 netdevice APIs
Message-ID: <202402291330.0510946B67@keescook>
References: <20240228204919.3680786-1-andriy.shevchenko@linux.intel.com>
 <20240228204919.3680786-8-andriy.shevchenko@linux.intel.com>
 <202402281341.AC67EB6E35@keescook>
 <20240228144148.5c227487@kernel.org>
 <202402281554.C1CEEF744@keescook>
 <20240228165609.06f5254a@kernel.org>
 <202402291059.491B5E03@keescook>
 <20240229113706.42c877a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229113706.42c877a1@kernel.org>

On Thu, Feb 29, 2024 at 11:37:06AM -0800, Jakub Kicinski wrote:
> On Thu, 29 Feb 2024 11:08:58 -0800 Kees Cook wrote:
> > > And some seem to be cargo-culted from out-of-tree code and are unused :S  
> > 
> > Ah, which can I remove?
> 
> The one in igc.h does not seem to be referenced by anything in the igc
> directory. Pretty sure it's unused.

I'll double check. After trying to do a few conversions I really hit
stuff I didn't like, so I took a slightly different approach in the
patch I sent.

-- 
Kees Cook

