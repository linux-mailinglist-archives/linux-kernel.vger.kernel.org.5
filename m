Return-Path: <linux-kernel+bounces-38054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0446083BA56
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9219A1F23266
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FC510A25;
	Thu, 25 Jan 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g41KHtWP"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411810A13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165584; cv=none; b=dw43jXJrkcQ5D6t1nkBJq7l742Mg0eLtUBKrw2eZudO4DhuWGL0SPMTcDb/OuRrhGnU1SGDvlWeWDhKJHVQZtFkZwd//gQx2NfqxFZMg9ePdeNWBC+yG6ZZ9vuCdi2fExD46Gk8m00duDMWe53VaIr6nLBfd8Zh0Fov4rz/ns0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165584; c=relaxed/simple;
	bh=ez40Hiks973HTdNYyPZ0h1dvEzreMQy5gsShFgPphuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcgD98g03pgVnSgWYiJAFNWWfXK80UtvLIx24oQDYR0wfLdKnS5E6CZzVJTINtZfJLVSGr+g4smPh+0PMJBFM9e99wkPcu8m6Vyj6EdWo37poxlvew9kkH9gWeEXWPQJJmcn56ibPHx+FFHLZ6C3C8DR+KA3NSdRrHmzOoVtPzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g41KHtWP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2dc7827a97so703277066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 22:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706165580; x=1706770380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EVz39pSu3r4g8xcNZ73J3NLB8OQE3qZV4lHSi35Q0Q=;
        b=g41KHtWPz6pBgV7ZrCchAXg47bdnB4neCc4yP2pZAqXu/EKELUp8uF0+aJZ17yDmHk
         fKAFmeFukNCuCMuLYYcErm41MpE6gW8eeWUwnXQan7t31k53ls+06YRp4D5CMk3qGAbU
         4NXggSlef7qfMTg5XErAQ8mNL0SKsacjBgxViBKGnKrtxBREfbINKB9G9UgURsVSwuw7
         B2lGHoU7JUaYWUeCDrcfIDsTkDHriKukOVM/fm+DIAJ4f29JMtgsN0WGN/pimQ8NOBuL
         kIQrnvw49IaVfzNcBqarAbgDsOAK23deN8YfTDBgpo6b8fWFUUxEmYWWclzB54RrSsFv
         Zz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706165580; x=1706770380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EVz39pSu3r4g8xcNZ73J3NLB8OQE3qZV4lHSi35Q0Q=;
        b=GNo5JeZjjSBxtN7vuKLb3j4C7TQOTKBG6t1ZPmN15ZIbTvoW5a0TeovnGWvaCWUJHj
         2Ej8rPJvc/oxZiOwtL3hMf+6H/oajyrQLbZanc9aAAqkTMeXvUCZeA/I7QxYfu3TrS77
         A/xrHnBOmNX+dvhsIXhpBAAMZNsDImlM7BBTWrA+Uez1ECQAo8/o+vJcPbRQlrNNCWjE
         aJ3vRLt97sHinCKGmkAlAOlz3n5Fuybt1yIvLhum1L7T7fLXg05jzt19WkNnWj2hulZY
         SoNYVk/M710wes+pZJVMmgTBQu6cCvzPgGo5GLLoeaIL3Y9L2uCf2gmbilEAPbhH4DlA
         WUbg==
X-Gm-Message-State: AOJu0Yxc4vHvLD4IUE8p8Tlmk0AZbZZ1jtewC/Ax9krBDagXvlKgD535
	RFYyk4i8+ufXstsd8fqnV3H/Mp3jxxxBYTA4LOnaNZMO0n4D5kJiChARrYYg3s8R4hhQYOMnXTC
	4AKbZDPbfhV+BBC4DgM7B0M4SzmKIRftP1H4=
X-Google-Smtp-Source: AGHT+IFyfX5j4hHaJ5PWa31hvMgEZNaXpF6meOqSVo9coOsPvYcm0tQboIho2tsiwbd8kO6jVuQPHID7YOki1oXXjpM=
X-Received: by 2002:a17:907:96aa:b0:a30:6278:3968 with SMTP id
 hd42-20020a17090796aa00b00a3062783968mr287716ejc.116.1706165580432; Wed, 24
 Jan 2024 22:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124085721.54442-1-liangchen.linux@gmail.com>
 <20240124085721.54442-3-liangchen.linux@gmail.com> <896749de-39b6-4081-91f3-1e316706a0e9@linux.alibaba.com>
In-Reply-To: <896749de-39b6-4081-91f3-1e316706a0e9@linux.alibaba.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 25 Jan 2024 14:52:48 +0800
Message-ID: <CAKhg4tJRM4qMJBwNs=HWczq7muw0_m_szH8L0CDaxpC+kJSeNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_net: Add missing virtio header in skb for XDP_PASS
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:04=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/1/24 =E4=B8=8B=E5=8D=884:57, Liang Chen =E5=86=99=E9=81=93=
:
> > For the XDP_PASS scenario of the XDP path, the skb constructed with
> > xdp_buff does not include the virtio header. Adding the virtio header
> > information back when creating the skb.
> >
> > Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> > ---
> >   drivers/net/virtio_net.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
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
> If xdp push or xdp pull modifies xdp_buff, will the original header
> still apply to the modified data?
>

No, it would be an issue then. Anyway, this patch will be dropped in v3. Th=
anks.

> Thanks,
> Heng
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
>

