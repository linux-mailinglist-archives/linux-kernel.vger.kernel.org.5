Return-Path: <linux-kernel+bounces-152395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B168ABDCD
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 02:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A90C7B20B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670574414;
	Sun, 21 Apr 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEOpJYwv"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868021C33
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713657638; cv=none; b=rOYzHg764J21E9L35rd/yhxdI9FDFz4EhV6NkCf3tfpg7EXXpx14wA7k8tkw0NFsiD3YIB34Kax+xMYTeB9fnLq2549aHqnTp/Z3ICt29jI64WlxZJCrXMTWYs3fZkbt6SgV+UjPJzcQWk2A7wv4qDVApp5HZ28kJfpVo3aJeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713657638; c=relaxed/simple;
	bh=0H9fOBBCoY5g2gdmsJAilkNhmk7pDmb/337HauY6yM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTDuY8Z6ULuRI8kyW+4rqzl2guE2z+yJlT30rkO4IRSz+j8sMCuipMNQ2lD+ZbdqA4qZRZO1AD+k8UtVT9MKF1h0eD5i0mZv6svHw7PK5aPi3c0Ugl1xRgTd1hn3Cq2hahz7Jf224oLORFNxdBLfZLbONivX0tg0uMqlFCFZgmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEOpJYwv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f074520c8cso3207073b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713657636; x=1714262436; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pbbNzG6RR7ekxyfxB+geoIx5fClIv1DY5BuwyLNUvn4=;
        b=zEOpJYwvsLuHQG+OudaD2xjL0nNYpOS90bdUuD18l1d7uZfK6zzCSUdtwss8TjoEFz
         urPbLwekIUAjBvMehYdIpezPjuqJVsmwj5FUznsjN/MrHCmUFrsBLYnzSzMdu9kIgKnI
         Dj9pokiVEM+xnBW2JDufQrjiLyfRaWaWJMR7AhbK/T4VmYYOKJX/EoJyebKbzhrZeQtM
         fxXTWk2ZlvHtea2xxXuwGCYc4NFQcOUhaVnILEcxBG6WeOFvuhh+DauNZ51/7ljLjaQJ
         Xhdz+di8ujQ14UYWfa8jvi1TBO/+LUde985ErKkP4awzyc0DUuwyKpMJ0kwOH2ZTKyRv
         PxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713657636; x=1714262436;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbbNzG6RR7ekxyfxB+geoIx5fClIv1DY5BuwyLNUvn4=;
        b=nTx/H3z7e206XkUo2c7tYWhzDRSjVCAAPKe9f4vSmjVmjRi8G4m7g2wGirgCWVGzBO
         LmwsVqyT1fzFbHT7shzFLVPI00DVpq3iSUUlXXtggezNnVQVIqc4S73VXcmK7id4Lwnp
         MdthZGoG24E+oWVEUHEpwYL2hsBNV0+09oyTaae9hI6rw2Z93Rw8EzlVXNRbBZ45Elaz
         hZEuWNXmN223ZOZ4DFn8/QQb7QuVZ0cm7kxOSCCjQb2TIFB7I7xVeDO7dxVx9thM88iy
         i64dBEnHwZpYykL/n3csIjUXJlrlRWqksNm8OAQxPZjavXj0LnuyFpHARRJ2YJYXt7Wu
         G1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXtUPUjj0AJUmDXnaDN9gl8PH60hfAabYuAGFwFVeAR2u9pmFynUNr36Xx5/snWgYyBUZYVvzeO8n4MiJpjxFJreiwxQGSCHgV347V9
X-Gm-Message-State: AOJu0YxYA55FGEnxg05/YV7VV6a1yff6ahffzO9HnriDsl7E01K0PLJv
	JpB2k21XzGmSDrtz6huEn4v/OxMF0GTRw8MY+C+I7T9IH+MpxuE30VAIDkRD0w==
X-Google-Smtp-Source: AGHT+IGKrCn5lJjwZzmLFl99+WUKiZhw2WYlWdCXA/kRIfdcUb0ATIVldr7Mbw+xyb6iOQbxEtKHuQ==
X-Received: by 2002:a05:6a00:10cb:b0:6ed:1c7:8c5e with SMTP id d11-20020a056a0010cb00b006ed01c78c5emr6822584pfu.12.1713657635554;
        Sat, 20 Apr 2024 17:00:35 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id ei55-20020a056a0080f700b006ead47a65d1sm5384191pfb.109.2024.04.20.17.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 17:00:34 -0700 (PDT)
Date: Sun, 21 Apr 2024 00:00:30 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Serban Constantinescu <serban.constantinescu@arm.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] binder: fix max_thread type inconsistency
Message-ID: <ZiRXHs9_Uszd7xzS@google.com>
References: <20240417191418.1341988-1-cmllamas@google.com>
 <20240417191418.1341988-5-cmllamas@google.com>
 <2024041858-unwoven-craziness-13a6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024041858-unwoven-craziness-13a6@gregkh>

On Thu, Apr 18, 2024 at 06:40:52AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2024 at 07:13:44PM +0000, Carlos Llamas wrote:
> > The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> > size_t to __u32 in order to avoid incompatibility issues between 32 and
> > 64-bit kernels. However, the internal types used to copy from user and
> > store the value were never updated. Use u32 to fix the inconsistency.
> > 
> > Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> > Reported-by: Arve Hjønnevåg <arve@android.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > ---
> >  drivers/android/binder.c          | 2 +-
> >  drivers/android/binder_internal.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Why does only patch 4/4 need to go into the tree now, and as a stable
> backport, but the first 3 do not?  Shouldn't this be two different
> series of patches, one 3 long, and one 1 long, to go to the different
> branches (next and linus)?

Yes, that is correct. Only patch 4/4 would need to be picked for linus
now and for stable. The others would go to next. Sorry, I was not aware
that sending them separately would be preferred.

I'll drop 4/4 patch from the series in v2. Let me know if you still need
me to send it again separately.

Thanks,
Carlos Llamas

