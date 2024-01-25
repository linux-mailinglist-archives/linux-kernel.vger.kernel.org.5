Return-Path: <linux-kernel+bounces-38050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745DD83BA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B571C22174
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64EA10A1E;
	Thu, 25 Jan 2024 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6e+ztjS"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9319C4411
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165475; cv=none; b=HXwZoZOObkbuAeMt5BAEmMG5CfejJh1nvfcfLcCs28upcY3hasF9uZlk+Dn8/ZQy+fsqxIqW/vDh/gcs2LYIYUxcdj0LPmVr08AZN+pQnvJjaRDd/V8m+qLjI1SrWpkB4V76N8g5uAX7mPAP6G5q4Ncm65gZgUHNhj0TlvjoK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165475; c=relaxed/simple;
	bh=+goqnjmhjwCrbgzCPnU67DdoeacZ3F59LFmr585je5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VDpti6NeQBUwAwOA5YlsZ/ZL/bebikLIgCSiz/UVbX8gepGP1XozMtOAJntqmS1LWeUX9ZzMn5zxdEDbmq91eHxOuGpRmU9u7QhqlDIlfkH7kGkxn/MVTA86MOuafhEoQWQMaPNB1B5k1RpTENvZmLW3QSAAbW5waW/fnMbKbPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6e+ztjS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55cdaa96f34so771062a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706165472; x=1706770272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+xeN85GCAQuC34lteVDcBey5w6Xz4urLxxRWMpJ/4s=;
        b=C6e+ztjSq9BhEeM2Qt2c3jdyJV9dyo6+pQ12H70dCZEqrq/TVWcj9z/WZWOuU4CVnr
         NbxdLt8vXOR7nw8N/XnTjXlH9oPELxEd1CVOmSQ+kbIrH/FjAlXh40q/OK9jIbxY7rtb
         DVQgrzZ6UMCc+WtglfSGybgW40n2dEh63RzhdXQyNRjHiCOtLzBGFHYh7zzALYVJV0Ub
         iWjJOJjmTAaR7SYy+FmVYD91Kb8twRT4ys80nFc6HRmzHAwWRaH8umsyPysDa/qPt7MQ
         q1NepVcWlLJlOHVZbGAAaMafK7Pc+j3f8iLEPt1rSlccn1STKbRZf0XKIL0vaQ1pVJAH
         ATPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165472; x=1706770272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+xeN85GCAQuC34lteVDcBey5w6Xz4urLxxRWMpJ/4s=;
        b=WXo5SXOql/LZZ0fuOYcRX8gKKUyPK/3OdD6thXHMhvbXJWfHr4ukJ6cZJc9is/lnS3
         jo22YLmvl6Ck2q6gua6GWH71xSdtxHBepd7fZN5sehmkotKtEBDeO55LXNj9m7Z7pACN
         oC53+QcD3nZXd7Sg+Zlxk3sn98rtwE10MxXHHZdbhnEZegKwdOUiXcbdAATAlHhqE7jj
         44JzWUpJpBEdgoORx4TCPR9AACxZ+KQh+/1iSmQuR+8pdGavB8P3Bo1KRyeKTllF7uXR
         DKYdR7C4h/Q1OedxY7X858FeQn6fTqPB+OmY9fY6fWYZAiLFCqdKgEaCnfQQuQKkcUEc
         uePA==
X-Gm-Message-State: AOJu0YywefNcGViD9kNduTmDAAqwwzU8/yiTTVkYyd34dDc/DhdVS5dJ
	KRzG91JJfrj+szeuEZOjoEpYRQvCZwzF/3L/eUNYvq00Wu85p4d00wpt1L2JmDIdD3h71Kmsk2s
	u/LpCaxKwtjXRQS4Rz7G4YcwaJhs=
X-Google-Smtp-Source: AGHT+IFDaBPwETdq+Yooxzd1JvlgzMI7LmbOlI8dt0gDK8rlK/hv6U+8xPOcEaPZuVCFiIMlIFr4KgGymrBbc9xDfbM=
X-Received: by 2002:a17:906:a3c3:b0:a2e:d233:c312 with SMTP id
 ca3-20020a170906a3c300b00a2ed233c312mr503668ejb.27.1706165471458; Wed, 24 Jan
 2024 22:51:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com> <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706087654.2583706-2-xuanzhuo@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 25 Jan 2024 14:50:59 +0800
Message-ID: <CAKhg4tKzhnXKVNfefHBF1vWEgXaX8wawF-7k5HX8F5OArQR1tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	mst@redhat.com, jasowang@redhat.com, hengqi@linux.alibaba.com
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
> This may change the logic of the csum offset and so on.
>
> Please not do this.
>

Sure. This will be dropped in v3. Thanks.

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

