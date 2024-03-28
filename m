Return-Path: <linux-kernel+bounces-122393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D793788F61D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 05:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867FE1F29F66
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F8B381C9;
	Thu, 28 Mar 2024 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqWwDxwS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C85291E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598591; cv=none; b=JgTfcu8VyzjwUgTXszdbl7EbXeUDPy7HkegaWjYTrqlVFruL8m+vfriORiRIcziT/eSytW8aDS3aTzcIshcuyea04uDZP4ui9Ozp9b6bj9g8nnSf5Q0ySKTSM1FGUdU+T4rYO7L2lv7aoxkinhTLF/9chotbihA/eCcfJAsF6nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598591; c=relaxed/simple;
	bh=MA0vU3W1LZn4Qn1ileNbbCmxahwffPLbnt6IdvVY1DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RY2c75zYSkLH6HjZYWgFxS1x35bTnce5O9ZmdpaZ4peyWyEINVtjDok+6a77VDgegAsVovugsH53t4rmgiDKVfg63VWQN9E+IzOc6t8BSaP8kZSYM6k2UioEVsA84dW6WIXoZI8wNpwZSqz7vLJyIuJ4AsjDjwxocx621JuysX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqWwDxwS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711598589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VR9QH5sWK+/AEwJzme4Yl+zpIsFT2eAe45QtEGaUS2M=;
	b=NqWwDxwSYGuV5Cpq6ssZRGnCZWSLZ7qYFHuTugIF1K3svlIfpHC0xL902wfSZ7t3rvwatu
	QT6K0MZScf8F9F/MlLw/4lks20Rm+xgSgwzzgvIm8jJdRz5RSvtm4XlEyL1n7Z3IegYOHs
	X3rAUkmHn0OCPvlCMWR1MH/wrvMq7zM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-zlhKVtOlOVy1CLqnS2-AKQ-1; Thu, 28 Mar 2024 00:03:06 -0400
X-MC-Unique: zlhKVtOlOVy1CLqnS2-AKQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a05923dbd9so468201a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 21:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711598586; x=1712203386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR9QH5sWK+/AEwJzme4Yl+zpIsFT2eAe45QtEGaUS2M=;
        b=KkdDyt5Vx9W2v4cX1FJIxv6a2c+bXWGVbBn7j9qvL8dTGh176lOkdp55DwTmJP49vs
         JA67wp/T5wsOAKbcifnmlkqdI2rAFLmS1KimvIeYgmZN23siYcw/coSYgplF4SB6ciMQ
         aBH/qVH/ZMUh5+05DA5ZYiZbdXohwrXAlTxeKZVzbNFsJOOzdzb8d6x1u4pZvG0w9pS1
         V+Ne8y2KwfIwq4w8czXHLaXqA5uZr+Vl+SxAaHlM81jRSURkHOGcX+yaGBsB65sIPygc
         HtjMdkLO0ow3jugqYl5YzciF+Ctsdur5sjDmgslIEex9HSBxMjrs5XSMX/s3GYd5friO
         GCtA==
X-Forwarded-Encrypted: i=1; AJvYcCXhafqUHby0jxrhtqxSP4K7vUI3+brVsnwaLMWhVv9JuCMjEEthPjeiM8NaaumRj4Mq4bAe5Q0p1MyEW1Rk9/54a/yf95gPMuUFxpPB
X-Gm-Message-State: AOJu0YzQmfA96EbWYXkj80vqyNinaw+KtR5GPU176/Apgld1cY6O+7Iy
	i0ju2L6LOofSimESejwDHc77DkjTzMTY3hWFn1bx+U1dHBJgub04pmldeGEWEktzQAKtLROYs5l
	DOdMjX0pUaokXwLTK9rDv/Q2ZOypuNBuPwA65V1c8HbAAQvLWHC19P6IMlDaCrKofsBtwbN8UQK
	8nhWvTZ9ueqex7Efvxc6zimM0tyQbJ/wZYbTLN
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id em10-20020a17090b014a00b002a07815dd25mr1734990pjb.20.1711598585816;
        Wed, 27 Mar 2024 21:03:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/veJ62gWCxJH+rJXD0BAZFk49zg7RYhlAQmbs4vW7XEiQGECvkaoiOerml1BopvTt9smdmlPuOr7dLI1u01k=
X-Received: by 2002:a17:90b:14a:b0:2a0:7815:dd25 with SMTP id
 em10-20020a17090b014a00b002a07815dd25mr1734975pjb.20.1711598585557; Wed, 27
 Mar 2024 21:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327231826.1725488-1-andrew@daynix.com>
In-Reply-To: <20240327231826.1725488-1-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:02:54 +0800
Message-ID: <CACGkMEuW8jLvje0_oqCT=-ih9JEgxOrWRsvjvfwQXw=OWT_RtQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] vhost: Added pad cleanup if vnet_hdr is not present.
To: Andrew Melnychenko <andrew@daynix.com>
Cc: mst@redhat.com, ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, 
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	yuri.benditovich@daynix.com, yan@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 7:44=E2=80=AFAM Andrew Melnychenko <andrew@daynix.c=
om> wrote:
>
> When the Qemu launched with vhost but without tap vnet_hdr,
> vhost tries to copy vnet_hdr from socket iter with size 0
> to the page that may contain some trash.
> That trash can be interpreted as unpredictable values for
> vnet_hdr.
> That leads to dropping some packets and in some cases to
> stalling vhost routine when the vhost_net tries to process
> packets and fails in a loop.
>
> Qemu options:
>   -netdev tap,vhost=3Don,vnet_hdr=3Doff,...
>
> From security point of view, wrong values on field used later
> tap's tap_get_user_xdp() and will affect skb gso and options.
> Later the header(and data in headroom) should not be used by the stack.
> Using custom socket as a backend to vhost_net can reveal some data
> in the vnet_hdr, although it would require kernel access to implement.
>
> The issue happens because the value of sock_len in virtqueue is 0.
> That value is set at vhost_net_set_features() with
> VHOST_NET_F_VIRTIO_NET_HDR, also it's set to zero at device open()
> and reset() routine.
> So, currently, to trigger the issue, we need to set up qemu with
> vhost=3Don,vnet_hdr=3Doff, or do not configure vhost in the custom progra=
m.
>
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Acked-by: Jason Wang <jasowang@redhat.com>

It seems it has been merged by Michael.

Thanks

> ---
>  drivers/vhost/net.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f2ed7167c848..57411ac2d08b 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -735,6 +735,9 @@ static int vhost_net_build_xdp(struct vhost_net_virtq=
ueue *nvq,
>         hdr =3D buf;
>         gso =3D &hdr->gso;
>
> +       if (!sock_hlen)
> +               memset(buf, 0, pad);
> +
>         if ((gso->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) &&
>             vhost16_to_cpu(vq, gso->csum_start) +
>             vhost16_to_cpu(vq, gso->csum_offset) + 2 >
> --
> 2.43.0
>


