Return-Path: <linux-kernel+bounces-101691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2C87AA95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2370F1F23918
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D3747A73;
	Wed, 13 Mar 2024 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRkhO/Q/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA1481BE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344485; cv=none; b=Fm8RFka0FKiiSpTqJJ+nplT4lWF2nclUbJXYnG/slz67Mrcng6is+aXZtonxUh1JF+QxAulLCNARyBG22HFD4TroFf4HN++hl/mGrvDOzkJ+mVe3HYPidokrZvLUOfmCg+z17w8Wz/OIUB8zW0kruSleBq0dbcU25KOKU9RsZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344485; c=relaxed/simple;
	bh=145LGBIIbFGitWjkjqb+xZP1asaiY34xwZaQtZhXB/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lxlhj11a6xF+O6EG1eqUi2sBTbMt3E5Rp2pko3BaxNZzetYk95NgtWq1a68GW1z+zW8wYOIVKqpZJPPzBtvbWr0mcuPPbrQu2MCRNJn1H3EWcGAa2NfCTIh/i3c1xQQKC+1Eav6EhckzHWFThptMKvZHwDkK3XLU/aDGnFQJQXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRkhO/Q/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710344481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4m99PKufR99CbJzmaNHgQ9BpyX8a7GHA951gGV1Wgwc=;
	b=KRkhO/Q/SqhiLdl2OYIZeco+BnP2Nle9K5wLO31kj+tmmV/1zrhu9UbXK3cPbRMstjYi8V
	rQmFsB1uu6LuBAnmYoCzPWdsRo/HBSLNJCfAw8q0l+laj1/JjtSzw0Ko1cEqwjoay8XM8m
	cTlDs9Wj8XveIyETERYo99SgTFBxT5E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-UaoKHYwdNJCSeLradlRrKA-1; Wed, 13 Mar 2024 11:41:20 -0400
X-MC-Unique: UaoKHYwdNJCSeLradlRrKA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412f0158ddaso7324535e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344479; x=1710949279;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4m99PKufR99CbJzmaNHgQ9BpyX8a7GHA951gGV1Wgwc=;
        b=c4McELzksfa95SWFrELURVP8uA68ZEONOe6hyu5k7hsP1DI5ETBnJSLDnq4eZ5YQdp
         1ChAKKnsIb4WXuwYfYUFa7sgyR3WBARyvfzpcX/VPyHmzN9/0lEGxQDPfk+qA6/W+WOk
         D6t1fHEOmdtx1N1SOpQnIzsVI0IQ3UgBx4BrQJwFxXDhHTZQlkJMu61ZDrB+rf2HxKCn
         7d6k3ca+er5/GYGOZ09GZVcIv8phjH80B+JRhgxBRjvLskZIJUZd/WwkoNlZ4dHo1Ljy
         F/5a/x8gbR3MUpmthOk8egy9GQsvXFn5mEkaTeywDa7OhXpgtj3nM2sH8tTqaIoEBF71
         DAPg==
X-Forwarded-Encrypted: i=1; AJvYcCV36YT+OHwd99ct0WyLJE7FDo7AUMVMebotIPNuxvrA8Rwiv9QUuzPhZoLvIVP6heg8gFfW+n9zDky1dBs40V+hbRCrqG7My+vCmm8S
X-Gm-Message-State: AOJu0YzfVU/bLtoH55zB3N4qQq+SPSl2M7HCbJvf/+BvlLDZl7dWbV7u
	vaeIDQRbS8+AAdnk283iSNck9kJ/SdaZxssO4sVEr37L18dlVdywzgoST8aM367vrMbzmQvsenT
	ySBUit2z9oAd9FIie8whrbA9ITrfuxovQYvGtypUXq3uRjp+tdNGEiTANOVO/+g==
X-Received: by 2002:a05:600c:1f0a:b0:412:ddee:e66f with SMTP id bd10-20020a05600c1f0a00b00412ddeee66fmr1617031wmb.2.1710344478984;
        Wed, 13 Mar 2024 08:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuxcedPNKR3ChMcgAsmRfgZCiVheZQmFQRxZQf9+ZjawsgxJkCbYOoPtFPns8Dy+ezQ4MM1g==
X-Received: by 2002:a05:600c:1f0a:b0:412:ddee:e66f with SMTP id bd10-20020a05600c1f0a00b00412ddeee66fmr1617013wmb.2.1710344478571;
        Wed, 13 Mar 2024 08:41:18 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-131.dyn.eolo.it. [146.241.239.131])
        by smtp.gmail.com with ESMTPSA id fc6-20020a05600c524600b00413ee7921b4sm382424wmb.15.2024.03.13.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 08:41:18 -0700 (PDT)
Message-ID: <e826f337c3db612852c5f543d123ee53adc885bb.camel@redhat.com>
Subject: Re: [PATCH net] udp: fix segmentation crash for untrusted source
 packet
From: Paolo Abeni <pabeni@redhat.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lena.wang@mediatek.com
Date: Wed, 13 Mar 2024 16:41:16 +0100
In-Reply-To: <20240313133402.9027-1-shiming.cheng@mediatek.com>
References: <20240313133402.9027-1-shiming.cheng@mediatek.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-13 at 21:34 +0800, Shiming Cheng wrote:
> Kernel exception is reported when making udp frag list segmentation.
> Backtrace is as below:
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:229
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:262
> features=3Dfeatures@entry=3D19, is_ipv6=3Dfalse)
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:289
> features=3D19)
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/udp_offload.c:399
> features=3D19)
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/ipv4/af_inet.c:1418
> skb@entry=3D0x0, features=3D19, features@entry=3D0)
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/core/gso.c:53
> tx_path=3D<optimized out>)
>     at out/android15-6.6/kernel-6.6/kernel-6.6/net/core/gso.c:124

A full backtrace would help better understanding the issue.

> This packet's frag list is null while gso_type is not 0. Then it is treat=
ed
> as a GRO-ed packet and sent to segment frag list. Function call path is
> udp_rcv_segment =3D> config features value
>     __udpv4_gso_segment  =3D> skb_gso_ok returns false. Here it should be
>                             true.=C2=A0

Why? If I read correctly the above, this is GSO packet landing in an
UDP socket with no UDP_GRO sockopt. The packet is expected to be
segmented again.

>				Failed reason is features doesn't
match
>                             gso_type.
>         __udp_gso_segment_list
>             skb_segment_list =3D> packet is linear with skb->next =3D NUL=
L
>             __udpv4_gso_segment_list_csum =3D> use skb->next directly and
>                                              crash happens
>=20
> In rx-gro-list GRO-ed packet is set gso type as
> NETIF_F_GSO_UDP_L4 | NETIF_F_GSO_FRAGLIST in napi_gro_complete. In gso
> flow the features should also set them to match with gso_type. Or else it
> will always return false in skb_gso_ok. Then it can't discover the
> untrusted source packet and result crash in following function.

What is the 'untrusted source' here? I read the above as the packet
aggregation happened in the GRO engine???

Could you please give a complete description of the relevant scenario?

> Fixes: f2696099c6c6 ("udp: Avoid post-GRO UDP checksum recalculation")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
>  include/net/udp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/net/udp.h b/include/net/udp.h
> index 488a6d2babcc..c87baa23b9da 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -464,7 +464,7 @@ void udpv6_encap_enable(void);
>  static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
>  					      struct sk_buff *skb, bool ipv4)
>  {
> -	netdev_features_t features =3D NETIF_F_SG;
> +	netdev_features_t features =3D NETIF_F_SG | NETIF_F_GSO_UDP_L4 | NETIF_=
F_GSO_FRAGLIST;

This looks wrong: real UDP_L4 GSO packets will not segmented anymore
and should be dropped (?!?)



