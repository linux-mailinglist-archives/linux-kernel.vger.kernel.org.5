Return-Path: <linux-kernel+bounces-164694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BD8B8128
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 22:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B931C2599D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7181A0B0E;
	Tue, 30 Apr 2024 20:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAq66FZ4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9642C199EA1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 20:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714507621; cv=none; b=KrhI1obGZqcpiRK0aRtVW52HnmLzq7+GK3dYhw3fcYkruEr1RZ52PLPt5kk6dqa8A5Tdo5k3c4mLoHS/xH12VNiv9nUD2Ayh2z59xSJ/ElQKUaWEhE5g+khL8iqcv9QZsTPqZWXTR7i+LcmlKE2FMWD8U4c7fTO0fL0h43kUE4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714507621; c=relaxed/simple;
	bh=ug3YfKik7AumLDou9Srebnw6+kedHrFJPLCWgOx1frE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlvFix0TmZfOva+frBZwIJvogA/5GvHL6Dr7PaawFqt0HkoS/eSODPW0w41SQz0vxCjpILHr1zU0JNMKcuQA3BpOjOS0p4jflCb7bPEdp+26e4O1inss1iFq/M13pS/8QbqGRsYXx5OQJZh3eGKApu2Gr4nHU4nFW1kO4huGvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAq66FZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714507618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dxTrrQAHX5LIHD8+8RfIAMS1TPkS1k3rljcnnnsPEVE=;
	b=jAq66FZ4tlALHbPQhE/ZoM181Z5KaVwK5JqgoZvkc3hXGqI4AHAyPfmyWrljrNgyE/Xm5M
	DH+Zv8/7YFinrf1L8i8nTQH9B1/Pa88b7oXud1+56AOGkf5dnmgj0GJE9GnYbq9A0sPE/0
	gJfYmC3yw7JsWET72Yh01Ne4dOOk4Vc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-gNReqLd6OsSRkY_4UvXOAw-1; Tue, 30 Apr 2024 16:06:57 -0400
X-MC-Unique: gNReqLd6OsSRkY_4UvXOAw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5723fc9eda3so3596404a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714507615; x=1715112415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxTrrQAHX5LIHD8+8RfIAMS1TPkS1k3rljcnnnsPEVE=;
        b=UrKSOU1Brre/MbyiztA8k9sRLs8nWcfmZYggHiMFXabcsqK+7wBE44oHU4wgH8AFLs
         v9CF/vbhbl5Wx7wghHHDIsPUmLKf3tHP00LcHzoBFW8rVHv0Yo0ro/besz8XuyqYlt1C
         PgEASVYx8uYeFoVKtnGH6/3l5b5qUPlz8HQQRLV1WkB6ctGEMOMhTu/gm29PmczcW2DE
         OKJePfuiKjlduThm6g5CszGnOnytrT95RDtx+P79lFt1wCphW1eQJiGDnWUTnp50ifX/
         a5eQYfgTt7BixBp7Jp4ClZnqPsyDkwjg9Ga7pmj2j82ZEzjcfu5U/N7B/DwKRhWatExt
         aJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVFIX563LDOkueIGk/xWOx2xegW745WBCo/y8Ou2xP3ecrzimvwJq4DnBxuIOgUESirlHU/1baDqrImPJnAkMWXKYYSrGQAhDdEBGNI
X-Gm-Message-State: AOJu0YzPPmp2pW48O8FviKqloGBe8HsEKveaIvXZK/+Z2PCO3YtrshGE
	BICVaqiDrdyA1bqYT288lmHIavtVZAa8c+z5dKztUCVLv4dyUaySs5L+QfkIkZb0SMbyv9jY8Gk
	1CfkQ2U9a0gweKnl2aN8jYOtzCik581Ht87IH3kyVTuCHl7vEdarcT1wQoFKfoQ==
X-Received: by 2002:a17:906:2a44:b0:a58:ee10:ad05 with SMTP id k4-20020a1709062a4400b00a58ee10ad05mr484895eje.69.1714507615500;
        Tue, 30 Apr 2024 13:06:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7ocL9+DqttG8t6q0QKC2cVrRfgcVUPqW7FLSaNzemeZLoe4wornulVDynqTC9/Zrj4O1LwA==
X-Received: by 2002:a17:906:2a44:b0:a58:ee10:ad05 with SMTP id k4-20020a1709062a4400b00a58ee10ad05mr484881eje.69.1714507614890;
        Tue, 30 Apr 2024 13:06:54 -0700 (PDT)
Received: from redhat.com ([2.55.56.94])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a4e24d259edsm15356306ejj.167.2024.04.30.13.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 13:06:54 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:06:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Darius Rad <darius@bluespec.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_net: Warn if insufficient queue length for
 transmitting
Message-ID: <20240430121730-mutt-send-email-mst@kernel.org>
References: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjFH7Xb5gyTtOpWd@localhost.localdomain>

On Tue, Apr 30, 2024 at 03:35:09PM -0400, Darius Rad wrote:
> The transmit queue is stopped when the number of free queue entries is less
> than 2+MAX_SKB_FRAGS, in start_xmit().  If the queue length (QUEUE_NUM_MAX)
> is less than then this, transmission will immediately trigger a netdev
> watchdog timeout.  Report this condition earlier and more directly.
> 
> Signed-off-by: Darius Rad <darius@bluespec.com>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 115c3c5414f2..72ee8473b61c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4917,6 +4917,9 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
>  	vi->guest_offloads_capable = vi->guest_offloads;
>  
> +	if (virtqueue_get_vring_size(vi->sq->vq) < 2 + MAX_SKB_FRAGS)
> +		netdev_warn_once(dev, "not enough queue entries, expect xmit timeout\n");
> +

How about actually fixing it though? E.g. by linearizing...

It also bothers me that there's practically
/proc/sys/net/core/max_skb_frags
and if that's low then things could actually work.

Finally, while originally it was just 17 typically, now it's
configurable. So it's possible that you change the config to make big
tcp work better and device stops working while it worked fine
previously.


>  	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>  		 dev->name, max_queue_pairs);
>  
> -- 
> 2.39.2


