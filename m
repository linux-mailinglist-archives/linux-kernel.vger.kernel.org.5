Return-Path: <linux-kernel+bounces-130623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F49897AA7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2371FB228CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB92515667C;
	Wed,  3 Apr 2024 21:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hz396Yjl"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE472154C03
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179720; cv=none; b=EN0uscYZceQYBrGWtTRynUVPtf8U/C4A/Sju5e3kZH5kl1/PcOYhww3t+S0YZLh0V1oNAek2srE7/rb4sUcvrSEChAXqekfh5h14iPrkj7g+iOv9a7ZgW489BFctuCvK0MPCiuVhNO0oxmk60EpJJkRRrmQzgajb2OJRjbeSaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179720; c=relaxed/simple;
	bh=Ge+rflQ68heO7Dqnl93qWvqW52u05lKmj6Bb7IZgcsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoHfS0G30iE8H3uzRGc5wfQHy0clROjo9djetAIlSqrAKm2qW6sQPG8uADfxx4G5RzDwPR0Xtca+4aFDDySmNcno27iYuaoELIbuICa9z2plGu9gkIzM77lWDMR//S6zQdH/zN8JrodMJUuSg8lDOgOzDhFlhKTlsnrr+yJWIe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hz396Yjl; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0bec01232so2451415ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712179718; x=1712784518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7hT1bDm6uwQ8drV4Fteto7D8//xOnGyJfRith5G1SQ=;
        b=hz396YjlZGrQwEA7LNmgv1z6KbCc0HC1+V1YnCnsy3R2wuUGq106ICp9naxMcZ+lzE
         AFboxNBKf9/BWoHJH7qIMjcRY2//O1t/lhxVSujEnL3gEipd2tu5P7itRQqkEw8xkHJq
         /f7rfdmROCoCzt8PihVPit3frIFZn38b1ebbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712179718; x=1712784518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7hT1bDm6uwQ8drV4Fteto7D8//xOnGyJfRith5G1SQ=;
        b=SlQXJlhpheElXSyAibGCzn4mLz1xeiWcQ1NgDjnhajQoOnQfp8K424V4bzYqxEjrn0
         qBKQ3p4f6BYtk38573Tq8C7E5EVuPvvFGTbWMM25yclVcMeREJ4aj1wxQIa5aeZ8HgOm
         P1eglefaMoTr+crPVkum9P7wrYi3G926t2mXy0Z0iC7Gky38P013nVwVfHKnnQ3GcIlF
         MBNO/9XmDlL8dbi/Hn0rsJ86ePEitfGkFLQDYYkJDoKhBgdPRM89M2VHZprVoHpXoIST
         Q4hZahDDSEXEyinmqasbckfnSLkO1aLzzmavk2/0R+G+2wfnrz/KDPZeTYst/qpFVohP
         oJhg==
X-Forwarded-Encrypted: i=1; AJvYcCXrYe7IjYR8nZtCILoKLQqQYs9XsmMn2e54fB13dH+T/HaS3TqgnKqxJSRVk14fTj0uURGrT02bNqTWiPOUdVZRzpgcnyzdSf5h3Iw/
X-Gm-Message-State: AOJu0YwWPNpCNuIKlVlWY/+QGqAAaFv/XGxGJxALGS01p5QRwg8SAkl7
	yRlgTIB1MAfCEjXuOMC9M3gB1ZSBkra80utC0sJW/L3wZvCptvt+1AJEuCzDppSm7rhQX374eeU
	=
X-Google-Smtp-Source: AGHT+IFHGnpRz+fZSnPJwYSaprPus/wpr7Q3vxnOZ7+XcX+WrDIGVbL7cDPbvGULxW631sH9YEjFiw==
X-Received: by 2002:a17:902:ecc8:b0:1e2:7ad5:19b3 with SMTP id a8-20020a170902ecc800b001e27ad519b3mr474309plh.43.1712179718159;
        Wed, 03 Apr 2024 14:28:38 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902e84100b001e0da190a07sm13808692plg.167.2024.04.03.14.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 14:28:37 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:28:36 -0700
From: Kees Cook <keescook@chromium.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	justinstitt@google.com
Subject: Re: [PATCH] Squashfs: remove deprecated strncpy by not copying the
 string
Message-ID: <202404031428.867B90D87D@keescook>
References: <20240403183352.391308-1-phillip@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403183352.391308-1-phillip@squashfs.org.uk>

On Wed, Apr 03, 2024 at 07:33:52PM +0100, Phillip Lougher wrote:
> Squashfs copied the passed string (name) into a temporary buffer
> to ensure it was NUL-terminated.  This however is completely
> unnecessary as the string is already NUL-terminated.  So remove
> the deprecated strncpy() by completely removing the string copy.
> 
> The background behind this unnecessary string copy is that it
> dates back to the days when Squashfs was an out of kernel patch.
> The code deliberately did not assume the string was NUL-terminated
> in case in future this changed (due to kernel changes).  This
> would mean the out of tree patches would be broken but still
> compile OK.
> 
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

