Return-Path: <linux-kernel+bounces-37933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 194B583B87A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DE2283497
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E47462;
	Thu, 25 Jan 2024 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJS7UWA6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E016FC3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706154514; cv=none; b=lz1HL1ZVHMUBpBBonUf+MkxQ4R6uz7A45HN8Or961Wp9V1p3xdebBRkZ4w5xXRjBS19+/7g/TSVnD/bWouvK+TNo/ebbLPtIC5e/9QcEz3fSWznqoFCTySPRtqnpSVFU1Bea7WFWcmcONqSO/I82IrLq+bzehgWwk3JEW5vcHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706154514; c=relaxed/simple;
	bh=bBevjUjT1huD29t3h/NaxpM64oREcTWJc/SMjCAPABM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZ45g48mqkXZhvSik6aGzukbqH84FMvBGsJOO+jyDbhI951MHhboWVVK+bLHEinTszaWnGFpUuXGoIkJb7TUc+Ev+z4cAZeAbjZCRZtvXxytBY3WKKYLVsqS/8kY73QmmCXQ3DAKhbv8JCcUjqaRsriM27M7f+wyUhB7nr+7Eqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJS7UWA6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706154511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Oex+9bxQoM5lZR85M4x8kxFVXC381LSPaJScy8SPKE=;
	b=bJS7UWA6JJjyyeDzeHqO9C1tnYlWvppeYj7uE8Qf2Pvk/Dv0Kzjq68h6PIG8QGnWqnxb32
	+FydeZ2AHhpgcKg13SVbOSq5nETOiaaw24RWdA/bba7vP7XweDYH15uu5Vp1FkFvuzaMZ7
	ijvaR6pvXFfROlpAEJ1XdobGr6kgT0w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Jnx98LY5Np6MZLeO-NoZHw-1; Wed, 24 Jan 2024 22:48:30 -0500
X-MC-Unique: Jnx98LY5Np6MZLeO-NoZHw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3bd393ae026so8578202b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:48:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706154509; x=1706759309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Oex+9bxQoM5lZR85M4x8kxFVXC381LSPaJScy8SPKE=;
        b=OLkriwKXyqJHqj0jZ4TMymZ6dDyQup2hAzX4p9Ac4cLFQTWgHoHdV+CIr/JPmnK1HE
         nwc4z894Mtw+r55nAQL7oT6VZ7k5NhOQYGcPz8LFxXW/HdguqfP2Zp3T2ibgXgwLndME
         JbAuIJiJRF8iIx9n4X7k3pqhlhOhAs9XUx6KgMlFXga0yknFQ5jI1HO5JM1TO9zuL7T/
         ssgWQQEP5tjO8+nBzXx8+q0iOZ4R0iN793+A3z/5/hbuCqEClZO70rZWvLYoaCHF7qBl
         9msA7lL7rp1i0ZnFr5UyS42PhfHmfKTxiCgIw6IcG9+F8Uz+EvzjPNUoBl3eF+qYzk5V
         JIqQ==
X-Gm-Message-State: AOJu0YzL0MuPZNKuu453WdwecgoEmPavs+meRaCDoa+LM02N7JbY8hWo
	L1NPU3CI+bnV69WxWK5553ku3wVSSoSxeptuZNoysJnjxds7V2Gx1XjU8Mhysbb0n7UaXQHbq1p
	JfSWrcy7c1XuDm+cqzvaTN9cYog1F20/zsLCvrRbothfbRB8avxNMaPW7083te3JzVJf/Rw5rRQ
	/8spWcp5idylzF12kqddOlVnnAIf8vn2Y/2ZH6
X-Received: by 2002:a05:6808:16a2:b0:3bd:dc70:fcad with SMTP id bb34-20020a05680816a200b003bddc70fcadmr27545oib.89.1706154509383;
        Wed, 24 Jan 2024 19:48:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGa11YxvgPS1ZLgaOqg1jLfBIwlTSwrok1dhvTJIz3CcuRakx4fnPIlNVNtjTz6pDJlViAd3Xt/5f5zPCjrNDg=
X-Received: by 2002:a05:6808:16a2:b0:3bd:dc70:fcad with SMTP id
 bb34-20020a05680816a200b003bddc70fcadmr27536oib.89.1706154509150; Wed, 24 Jan
 2024 19:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com> <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 11:48:18 +0800
Message-ID: <CACGkMEvQTXmyAeUeWxgxgMPJ3VQJWH1DRnt__Yb0ifnSyuZ7Cw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Liang Chen <liangchen.linux@gmail.com>, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, hengqi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 5:16=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 24 Jan 2024 16:57:20 +0800, Liang Chen <liangchen.linux@gmail.com=
> wrote:
> > For the XDP_PASS scenario of the XDP path, the skb constructed with
> > xdp_buff does not include the virtio header. Adding the virtio header
> > information back when creating the skb.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index b56828804e5f..2de46eb4c661 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1270,6 +1270,9 @@ static struct sk_buff *receive_small_xdp(struct n=
et_device *dev,
> >       if (unlikely(!skb))
> >               goto err;
> >
> > +     /* Store the original virtio header for subsequent use by the dri=
ver. */
> > +     memcpy(skb_vnet_common_hdr(skb), &virtnet_xdp.hdr, vi->hdr_len);
>
> About this, a spec is waiting for voting.
>

A pointer?

> This may change the logic of the csum offset and so on.

 Btw, doesn't it need a new feature bit?

Thanks

>
> Please not do this.
>
> Thanks.
>
>
> > +
> >       if (metasize)
> >               skb_metadata_set(skb, metasize);
> >
> > @@ -1635,6 +1638,9 @@ static struct sk_buff *receive_mergeable_xdp(stru=
ct net_device *dev,
> >               head_skb =3D build_skb_from_xdp_buff(dev, vi, xdp, xdp_fr=
ags_truesz);
> >               if (unlikely(!head_skb))
> >                       break;
> > +             /* Store the original virtio header for subsequent use by=
 the driver. */
> > +             memcpy(skb_vnet_common_hdr(head_skb), &virtnet_xdp.hdr, v=
i->hdr_len);
> > +
> >               return head_skb;
> >
> >       case XDP_TX:
> > --
> > 2.40.1
> >
>


