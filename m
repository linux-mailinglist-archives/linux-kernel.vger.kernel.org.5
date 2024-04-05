Return-Path: <linux-kernel+bounces-133065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3024E899E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE701F23228
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B016D4E1;
	Fri,  5 Apr 2024 13:30:38 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4454916D32D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323837; cv=none; b=j45zvY1VP0p7D/K5O4aWgv5E8LiuGKrVQmgFqbmAD+E6PGlUTCumvYOAkDcPU2CLFYzbSC3Szk3fkfEbq+pEK11dgiiYPBqqeUVaKnnxZwkaVWjwNqA/F+RTCdKfCm49OjZ9a3JwJ/BlST4FA/XM2uBysnycVnVFcJqNFS1i4/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323837; c=relaxed/simple;
	bh=EJcW0sZ77+XrV5zGyzG0ZY2MZYMLOhwYkIOwA+cbql8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PGtgYsE74qCG2Dq2Sdwwie+bGVMMmoZeYINwAMYK7nYwwuxMqTjGKd0lsKRMnZo9qaMn7R7Pp+7XL6xGnbsk2BD48BGjpjA6MEs4N70J0/WhUXPOIZdrNDlyG0GykHEHE6wA4e1j+6haoeO5Jnd5bd/+5WemclJw1bRtWUC/VZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc0370e9b0so239552839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323835; x=1712928635;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSSqrMatCEUW1BHeL7+LvxirvHxOF6dEe7+WLCWA82s=;
        b=CKph0x31naT0Kab9Rr4EqAqnvk+XOyQFYKW7Nvx+SgoOOyzif3ua+OObi8zHgYU1hS
         7Bd0CQwWrOLkiDvBbMwWkuHwZqsfQa6e2m8bmd5R/D+ucTg6SoGpOVZ6YeE1abDnAL9N
         zZEkWmiYlBtcWw863VMoht7Yv6ckLkiTVRnZWKMMeVFIXwbg1QDZhobZ27kIxfy14Upw
         xPFBH+f/1MexJK5y0wNKgkeSjliHIne0KCBLH6SXWQWY0ngjHO4kEo76sre0yBCIHUcb
         /9N/fER701gsxJPlMCKDwHKGbq9Qt/46D6vhEFvDyPi79aXi3NeRbHIdk8TyTIEY1sL4
         lIfA==
X-Gm-Message-State: AOJu0Yz1+yBZd2RMTgOD3+IaCiH1+oo1k2lX2v5vR1kogXz41wLVmK0y
	W7sTVWEpKvySErXPh8M/03OKD9IYVD5xQbOTV38jV6A7RPhFEWWx3vHYFQX6mmhNMVZSLIsVD0Z
	fjPIhlMpAs6y4HhZV27g4Z/i8iaq50oyKJF0I+WaATf9aMlfn2s6z65Q=
X-Google-Smtp-Source: AGHT+IFsEQRfeqa2H7O2024jQT7tS4Gj8WduUTwKRu7NEF08O8r/ZG7bylKfMhWCQHGKuP87hGLXnrFRDKZ4vCGJAnT01fr6oAvO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c3:b0:7cc:7112:ea9c with SMTP id
 o3-20020a05660213c300b007cc7112ea9cmr53057iov.2.1712323835436; Fri, 05 Apr
 2024 06:30:35 -0700 (PDT)
Date: Fri, 05 Apr 2024 06:30:35 -0700
In-Reply-To: <20240405133030.21567-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3b0e906155975f2@google.com>
Subject: Re: [syzbot] WARNING in vmk80xx_auto_attach/usb_submit_urb
From: syzbot <syzbot+5f29dc6a889fc42bd896@syzkaller.appspotmail.com>
To: n.zhandarovich@fintech.ru
Cc: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> Refactor endpoint checks to ensure there is no ambivalence
> about endpoint types.
>
> Try a specific branch to mitigate unrelated issues with boot/build.
>
> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git 4090fa373f0e763c43610853>

"4090fa373f0e763c43610853>" does not look like a valid git branch or commit.

> ---
>  drivers/comedi/drivers/vmk80xx.c | 35 ++++++++++++-----------------------
>  1 file changed, 12 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/comedi/drivers/vmk80xx.c b/drivers/comedi/drivers/vmk80xx.c
> index 4536ed43f65b..476885403c61 100644
> --- a/drivers/comedi/drivers/vmk80xx.c
> +++ b/drivers/comedi/drivers/vmk80xx.c
> @@ -641,33 +641,22 @@ static int vmk80xx_find_usb_endpoints(struct comedi_device *dev)
>  	struct vmk80xx_private *devpriv = dev->private;
>  	struct usb_interface *intf = comedi_to_usb_interface(dev);
>  	struct usb_host_interface *iface_desc = intf->cur_altsetting;
> -	struct usb_endpoint_descriptor *ep_desc;
> -	int i;
> +	struct usb_endpoint_descriptor *ep_rx_desc, *ep_tx_desc;
> +	int i, ret;
>  
> -	if (iface_desc->desc.bNumEndpoints != 2)
> -		return -ENODEV;
> -
> -	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
> -		ep_desc = &iface_desc->endpoint[i].desc;
> -
> -		if (usb_endpoint_is_int_in(ep_desc) ||
> -		    usb_endpoint_is_bulk_in(ep_desc)) {
> -			if (!devpriv->ep_rx)
> -				devpriv->ep_rx = ep_desc;
> -			continue;
> -		}
> -
> -		if (usb_endpoint_is_int_out(ep_desc) ||
> -		    usb_endpoint_is_bulk_out(ep_desc)) {
> -			if (!devpriv->ep_tx)
> -				devpriv->ep_tx = ep_desc;
> -			continue;
> -		}
> -	}
> +	if (devpriv->model == VMK8061_MODEL)
> +		ret = usb_find_common_endpoints(iface_desc, &ep_rx_desc,
> +						&ep_tx_desc, NULL, NULL);
> +	else
> +		ret = usb_find_common_endpoints(iface_desc, NULL, NULL,
> +						&ep_rx_desc, &ep_tx_desc);
>  
> -	if (!devpriv->ep_rx || !devpriv->ep_tx)
> +	if (ret)
>  		return -ENODEV;
>  
> +	devpriv->ep_rx = ep_rx_desc;
> +	devpriv->ep_tx = ep_tx_desc;
> +
>  	if (!usb_endpoint_maxp(devpriv->ep_rx) || !usb_endpoint_maxp(devpriv->ep_tx))
>  		return -EINVAL;
>  

