Return-Path: <linux-kernel+bounces-152547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917D8AC059
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7727B20BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E9374F6;
	Sun, 21 Apr 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoYuZvqH"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DEE1401C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 17:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713721691; cv=none; b=tR7b1LpRpafM58MW1b2/fiM88Ifdf3L/4At7+AhRmw0OJ/FD5a8m0mKZQxS7okGCT6y0BMwj91tZ8l2rzsoDC+jegCWOizDUuKJ8OFf+m5KymGtnicnqC2IGMEAfoy6OjlshJnVZufoefovumkiSr6ULKcl6FZy36TCClheIykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713721691; c=relaxed/simple;
	bh=nVqmOLqS8Jm879/wAzi3qp2fB/Kd9kS1cq5sv7FOepE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyQItQgo1BChVVBAnfornIr8jncr139B/wOI1ISSfPXL0rqVa5FhErS+9OBwgBW/Cg1IY17lqX8X2Je1dQ7yHVtmYqEh0T48YxjywVWAnZEpORog1GvNfGICt1/v8vHCfgpkU04rSKkkC07hik+kOV15sif8+5vc5YY1Fs3vLhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoYuZvqH; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1563322b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713721689; x=1714326489; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ci/J2ILNecORXupy9IHKIghPdBckTpTbuTnDZ9u6/Us=;
        b=eoYuZvqH1UkPW1+ZnsDJqA6ya7IIgZSVbu0CpxBIXy8RAmqmwdQP484s6PcGKaaqrV
         YDZKZKlkcgc53EJv4MWmyLKYEUgBXy+IEkQeNjfcdEQh9EKAIzWmVfbzgGne1OPFVbny
         kefL1BdBpwKClgX3+HnGOPdlyYVHAVix90k/1gVx+YK4jD0AS3Amqwi5g9gvjmGwsadt
         E0ar1iob0jZmzR+XcMCk2nljPudkpmZ/CZgnUetEaij6QWZoqj8Fu5F49Hgup0BRPKAW
         18ffDCa4lasawp/Tho2lpTBDSeIuHanezNVHwshf3HFWUQZ2iQhVTDTvjXjzJEO6ZdbD
         RUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713721689; x=1714326489;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ci/J2ILNecORXupy9IHKIghPdBckTpTbuTnDZ9u6/Us=;
        b=n6/HA/3BERriyNagve1ZvTD9aty31sT7rMQ27qnF6lJe+ZRHGYG9eCL2Jyzb7hCJow
         nNBPpBza9ChvohrNZ0ahhQG5HDKEiKIBe7U5EhWh1ZrqjiLOIDLgkmUYUDafJrrtmu6G
         4VJIiJgs8dNLCEijiysHOcllDvbmwKLr/4uMYQYLhjc+UHPKXkfNM8thaTpR+Qqm6Bal
         u51dHXgImapQnukpBxmB8JAHpkItjpMpzZtkb/60NR/1o3Shhbf/xmSyenDZD4UVXmQ5
         KPZsuqPscHrCqBAGA6e2LBMl3F+JJgL72YjIsylt7ljJPIYJFIXjeFA9G80lPUaASw8+
         Qjew==
X-Forwarded-Encrypted: i=1; AJvYcCXGjcWVWS2I2bdQahqtI9ixOJxEWC2JEvOxKsOa1jpo5qvSB3aek5eSBxb+v3nGZJY96K1SEXeKnV+5CPoG8Qim6TURtmUFo1mzTeaw
X-Gm-Message-State: AOJu0YwkhbAkdCCdqi+i/IHosOo1cWRix6Q9T0KLP8DOFJd3cYF3r2/W
	IqpZDVgcQT6mHaNP/eLNmpJ3C3+pkgO1n4eMOCbd9hB6t5Qvh1xnQ9VFY8Zq+Q==
X-Google-Smtp-Source: AGHT+IGi2HySwpde2wPLGS1rXBVAEyk1Wfn9J93KyuB17lYPSWAXzJl73cC5aQiCwTgjPjlaLTj62A==
X-Received: by 2002:a05:6a00:3929:b0:6e7:b3c4:43a4 with SMTP id fh41-20020a056a00392900b006e7b3c443a4mr9638797pfb.25.1713721688439;
        Sun, 21 Apr 2024 10:48:08 -0700 (PDT)
Received: from google.com (139.69.82.34.bc.googleusercontent.com. [34.82.69.139])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm6192755pgj.1.2024.04.21.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 10:48:07 -0700 (PDT)
Date: Sun, 21 Apr 2024 17:48:03 +0000
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
Message-ID: <ZiVRU_nBc91qp0j7@google.com>
References: <20240417191418.1341988-1-cmllamas@google.com>
 <20240417191418.1341988-5-cmllamas@google.com>
 <2024041858-unwoven-craziness-13a6@gregkh>
 <ZiRXHs9_Uszd7xzS@google.com>
 <2024042112-landscape-gains-1bb0@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024042112-landscape-gains-1bb0@gregkh>

On Sun, Apr 21, 2024 at 08:39:23AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Apr 21, 2024 at 12:00:30AM +0000, Carlos Llamas wrote:
> > On Thu, Apr 18, 2024 at 06:40:52AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Apr 17, 2024 at 07:13:44PM +0000, Carlos Llamas wrote:
> > > > The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
> > > > size_t to __u32 in order to avoid incompatibility issues between 32 and
> > > > 64-bit kernels. However, the internal types used to copy from user and
> > > > store the value were never updated. Use u32 to fix the inconsistency.
> > > > 
> > > > Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS declaration")
> > > > Reported-by: Arve Hjønnevåg <arve@android.com>
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> > > > ---
> > > >  drivers/android/binder.c          | 2 +-
> > > >  drivers/android/binder_internal.h | 2 +-
> > > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > Why does only patch 4/4 need to go into the tree now, and as a stable
> > > backport, but the first 3 do not?  Shouldn't this be two different
> > > series of patches, one 3 long, and one 1 long, to go to the different
> > > branches (next and linus)?
> > 
> > Yes, that is correct. Only patch 4/4 would need to be picked for linus
> > now and for stable. The others would go to next. Sorry, I was not aware
> > that sending them separately would be preferred.
> > 
> > I'll drop 4/4 patch from the series in v2. Let me know if you still need
> > me to send it again separately.
> 
> Please do, thanks!
> 
> greg k-h
> 

Ok, done. The separated patch is here:
https://lore.kernel.org/all/20240421173750.3117808-1-cmllamas@google.com/

Thanks,
Carlos Llamas

