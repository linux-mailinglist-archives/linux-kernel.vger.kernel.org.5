Return-Path: <linux-kernel+bounces-152223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4E88ABAE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06C11F21B99
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34F17C67;
	Sat, 20 Apr 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azbt1Y+5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79C17BAE
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713607526; cv=none; b=UIX8vg5/yw1QsEE0xfAZ3Py7GI1KeSMtCLQFd80pIr7sHMJTu5XBSmqjlHUPo7XkGJjgg8mJe7yCgls44oDyXZ0qDZvB5JQ4kuwnhobEYZmkJIib9tYwvFuwlnXZqE1eduU7wXhiJlT1B3oQIOn8LtC3Y9kP4PkUdNiLM2Kwr2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713607526; c=relaxed/simple;
	bh=UKYeRD8/XiIyAg9qRBsvwBklh4EieGaHp8R88F3ZOck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC56tywpyA1mHK+hFoETan1+Sm9yvvBFo0KQ9yGavdVfuGcWy66NOqGsfhmozHAOq+CJjMV72+TYTVMzwiyYO9wQAqZ2hg+MKhMIZET0ffdKeRWP3/udG6RZTwfCldte7tdEZXXB8I9enar8EXEYnOZt1TEKk7ZUCtERIIa5XtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Azbt1Y+5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713607523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dupUFX22MvWJlz2LiPNASjX/H+JRFaBqC9DPNGlEAKk=;
	b=Azbt1Y+5Bq3SR0V8qnkiI77kmtGeMvQV6hN/yh9OaYHP0XNn+S8G/mUNVQHWLmfJwgaKZX
	Ck0ULpPrNEl5m5iM5jwQ6xNbyLSo4Vp+QPYIM5iv3pXjWRqKUrTVr3jYJw+8YFABahxBxV
	ksTWwfPGZE8O3d4HZxeFv7PNBNxJIMs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-V7-MdX0HOOymectq8NRbCg-1; Sat, 20 Apr 2024 06:05:22 -0400
X-MC-Unique: V7-MdX0HOOymectq8NRbCg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d883dab079so27469371fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 03:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713607520; x=1714212320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dupUFX22MvWJlz2LiPNASjX/H+JRFaBqC9DPNGlEAKk=;
        b=DsUtKlpKTIOx+/5nCw9f584xyxauO+jm/02RXbde394e1K4U8aAr3tNK0PHqqmnoMr
         gvBfsG4Hmkp9s4carc4ZRJCUn+jZ7Y9tsFpTDVeAZkzFvz5yJZVhYTnnjsVliXDWcCsu
         iahsmLmIyCv7He8kqHoxve+/S/F+rp1d8fwdJsoZ0fUxlU4T/+R0SlGtkf46SBtSFELX
         rJoP+EVwIy5MHs9Pdhzi4Y5Sl1MCwnc4sWEjLCPFD33f3fSJktBjiT1IAWH42p7KPP5p
         JL4HVk0n2mtQlbiWGej1SZsaUa2cywLtD8hBweyoUaUU1vziK/rx/e/J8+zzoQCQ7fb0
         Tq4w==
X-Forwarded-Encrypted: i=1; AJvYcCWge11HNRhDqYKsMYf6DCYj90BTv9a02lwZ9Hu1aP/lRwE0/Dd8oVXbsLiv36sbdJ1BYRSn0CeyZiG42EpY2ueFgjb+GSuPpm+hVN4f
X-Gm-Message-State: AOJu0Yw5Yd5HTiRugMqmtX5X8nQzFY/myaYVrOLT9E954n/rzVKNjoIL
	uutLliFqPpJ5LAAOz0xtpbqLJrndzdkB3A/Tql6i4KmqrEYjYPiUrOdqn+aXW4tsf7uL3IdUv6o
	022XfC7Pj32Htk56HZpVQaQYTgE8eCFEwXIKht2pecZ74QpvPGNQ9IAoq9taX+w==
X-Received: by 2002:a2e:9798:0:b0:2da:a73:4f29 with SMTP id y24-20020a2e9798000000b002da0a734f29mr3610193lji.30.1713607520474;
        Sat, 20 Apr 2024 03:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYBnMGeF141NDJiiAEbx9ZNUBUqnu1GBz0moT4dPDvrOwYJoOemN0dK9MgDRfLJOyGBx1O+Q==
X-Received: by 2002:a2e:9798:0:b0:2da:a73:4f29 with SMTP id y24-20020a2e9798000000b002da0a734f29mr3610179lji.30.1713607519984;
        Sat, 20 Apr 2024 03:05:19 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b00419fba938d8sm973597wmq.27.2024.04.20.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 03:05:19 -0700 (PDT)
Date: Sat, 20 Apr 2024 06:05:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com,
	stefanha@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH virt] virt: fix uninit-value in vhost_vsock_dev_open
Message-ID: <20240420060450-mutt-send-email-mst@kernel.org>
References: <000000000000be4e1c06166fdc85@google.com>
 <20240420085750.64274-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420085750.64274-1-aha310510@gmail.com>

On Sat, Apr 20, 2024 at 05:57:50PM +0900, Jeongjun Park wrote:
> Change vhost_vsock_dev_open() to use kvzalloc() instead of kvmalloc()
> to avoid uninit state.
> 
> Reported-by: syzbot+6c21aeb59d0e82eb2782@syzkaller.appspotmail.com
> Fixes: dcda9b04713c ("mm, tree wide: replace __GFP_REPEAT by __GFP_RETRY_MAYFAIL with more useful semantic")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

What value exactly is used uninitialized?

> ---
>  drivers/vhost/vsock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ec20ecff85c7..652ef97a444b 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -656,7 +656,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
>  	/* This struct is large and allocation could fail, fall back to vmalloc
>  	 * if there is no other way.
>  	 */
> -	vsock = kvmalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
> +	vsock = kvzalloc(sizeof(*vsock), GFP_KERNEL | __GFP_RETRY_MAYFAIL);
>  	if (!vsock)
>  		return -ENOMEM;
>  
> -- 
> 2.34.1


