Return-Path: <linux-kernel+bounces-150547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC4A8AA0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77D55281969
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52810171E77;
	Thu, 18 Apr 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2/2f+K3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA216191A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460329; cv=none; b=hWnTSsPA0TWrQLPiktuFcPE+raMKOkvCcmAbtKkpO0e4whhfaR3iDXTKbPS/OIBWEMdCKY+ciaa69MFf86R78+hJkJ2ASY23oNS/og3tyfGRAJz4FYzR31ZeuemAQyKIGZY8lL+X3KOJUzZK7jd1GDPjdbqX7tkRrMHC/sFuZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460329; c=relaxed/simple;
	bh=V4bD0JhlT+UQ1ATauOhPA9TteDqpGdm2KZM8d041ViM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPBqhnNXS7RuMv28V8tRzgZK0WjLDGbhoA+t+KHYwgWQkeVq71sCJnNS/tt8ucM6pkm1C+qCb+RHQTs/hx226hPaIVtXUMXT4ySsiKJkqnKaJiUp8/9qBYNfw+rCjQSAb4EQhtBgwq6EGBh1Yz1eaad5pk1L2Ec0IjAa71YrOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c2/2f+K3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so10019605ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713460328; x=1714065128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Srcc8GSfebZLoUs5UEqC/Q5n1RryFdWaKvCpiJ/RKN0=;
        b=c2/2f+K3iNgmz9NGLiIrElX2rcXto28Q773Y5I2zC2/ext9ebHLiBn5t/R7eJnJaRj
         /PoD3mqROt5aFHFxPXdY/RNO5VXF4g1gU6wj4lJmrP7QYIgdl3wh2eubW19wUGf6vMnL
         ewaGuVjAHJV+LMZDbF2X2g7fhHEqOP43wPm+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460328; x=1714065128;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Srcc8GSfebZLoUs5UEqC/Q5n1RryFdWaKvCpiJ/RKN0=;
        b=qcavGmjPBzrkxUrgrvyTLFELptC6GuhOSRsIV5X7Y2xCt1wTqs14NhqFOUEVcWzkjA
         p8oHN8TeLJute3tZWSRXEFTLXad12IVRRC1E/QL4OC3z5GF8JsjpEVRwCHOHIuD5xfzE
         6PJ++3ejyAyFXWIB6/e2CsN4bfxMfsfcskuetukC56nzeUcG+lmPkOjviAQStsPsE19t
         nsxcL/lyiWIDOnskxA5cwK306fKcAVKI3oToqmpAiedJBKkUIdSJa5MrGheKApK8o+ny
         klls0lRQ3htZpGCH13/MOLzZ48/44b9miOYQPAjLEITwXwD7WwxCOtRUdKOYw8/GrbHJ
         Oc9w==
X-Forwarded-Encrypted: i=1; AJvYcCXNx9jmT82f+8F6c3DwVa936xCsMTHuYB3reL54ahOtkH3zvBawZoRNGpAk90ANmdxpnM9iKnVKjmxPUsz+g59mpd9NI/FVAsWjD/VV
X-Gm-Message-State: AOJu0YxHtwDjhbb8m8buaFrTcotik0zMs3FCWrPfrlKvADkKV0m2xdGp
	CE1K26KE0a30OKb4GzgHRIe3Ogw/1IS2suS5stLdFs8XShmOT23c9tR7NNqumw==
X-Google-Smtp-Source: AGHT+IGXRsPSakc8glvVR0fVaanCDT0iQFBXasCGzm9NwhaKMLnvjPABcG55nXEozQZ+YUznpYVeKA==
X-Received: by 2002:a17:903:493:b0:1e2:6165:8086 with SMTP id jj19-20020a170903049300b001e261658086mr3335872plb.61.1713460327781;
        Thu, 18 Apr 2024 10:12:07 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x7-20020a1709027c0700b001e2c8bc6bebsm1765424pll.81.2024.04.18.10.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:12:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:12:06 -0700
From: Kees Cook <keescook@chromium.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alex Elder <elder@linaro.org>, corbet@lwn.net,
	gregkh@linuxfoundation.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coding-style: don't encourage WARN*()
Message-ID: <202404181010.5C27FE82D@keescook>
References: <20240414170850.148122-1-elder@linaro.org>
 <20240418161430.GB2410@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418161430.GB2410@sol.localdomain>

On Thu, Apr 18, 2024 at 09:14:30AM -0700, Eric Biggers wrote:
> Also, it's not true that "Android" sets this option.  It might be the case that
> some individual Android OEMs have decided to use it for some reason (they do
> have the ability to customize their kernel command line, after all).  It's
> certainly not used by default or even recommended.

Ah yes, you are right. I had misremembered; last I looked Android uses
of CONFIG_UBSAN_TRAP=y, which has a similar affect (effectively promoting
warning into bug) for UBSAN checks.

-- 
Kees Cook

