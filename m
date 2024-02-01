Return-Path: <linux-kernel+bounces-48826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78684621A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2011C243FD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F73D563;
	Thu,  1 Feb 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj5oBC8C"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB03CF74
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706820355; cv=none; b=MKK1b+EC9AOnsfyorDG4gOHeG4j/FCe7L6z1UKPAHvK6SispzNs6kK2yCPoaj5xvVNtgc4nP/Ft7QQLRimGvJlklbsKBRj0cjWGCBJJRtQnD6IYfjQy8AeE+sBSRIVg8krQSFARpJ3K3AtdzGu9x2aIZ/+Qvw1v1jAtdf6G41y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706820355; c=relaxed/simple;
	bh=Dgw6KwuT5iOSIOfdXghS0A8NOeSxhwpnWQcPHTaILOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owCopdqCZsps5qEbo8yGCELjvsJXFQ3zGpJsAXfqLrqXiEJXsmBUQaR7O9LCfsZi2SEXRNH/YYzq/SwjY5MViGfpUSjVJWvfDUDs+gx/kxPJY0pfNhSBYbqkDgHaN9ueVbkJkSylVVTJAr7MWOSb0VRD7/xVZM/h8oy2VKN+2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj5oBC8C; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a36597a3104so194758866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 12:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706820351; x=1707425151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nVZO6y8TcIQYcaKwHAm6Bz36UagPk36lmeIjL1j0eQ=;
        b=rj5oBC8C7/ctfHD7gaN0OpOE9NLag6pQNHUV4LFFXvTm3rWKSe++BmiruwSOkFHXYI
         CGX2AcnkSeszcUx4PO3yPMoqdMfaTSC8IbjKoK4yqlm0iZ3gEYi2SXMuR6xxAfktXrSz
         SFTBPqk4iSe8LNyCHSRxNwGxHKtq/aMoVOsL0tyHPpWanclL3JTxAj6xbFBc3sIuo2+V
         T9PtmGkZGsJajodx2sE4E3gGyEx1Xa4MSZSkAJZuLjJue9c97xyHpu1ItlwImJ/6MSFG
         OSs8b+LGR+A2CoUnB0we0Tz3gh8TMdt/cfXNh2490NiChuYgdQkJceqB3l0jCyRc6blw
         lvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706820351; x=1707425151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nVZO6y8TcIQYcaKwHAm6Bz36UagPk36lmeIjL1j0eQ=;
        b=WfZz/XmtLgsgJPh2WFtcoBHsTXKlPbfk6aayHvI/jaiGj04pQXB5ABiVjHOs8XxGTa
         rH290EBtzDNWhK5yqKG0iK7pCQa3HciG0UGzDU7mmKjHmgCz+VWKVJaSzXFM7oO5hT87
         ZOl69qq/iprbzkuTfHawByiNFg43TsFMjAPfqcZcvF8rXULGQkMRwH1tO3tuWUFZlsl9
         KxKUIz/DnH+YwkEf43cnMefksvFL7BtrSyWctcG17/tnIHyOV3pnWKFYbKL73HzFf/3k
         BbBVmWtvtyorjH7GyoDWpZKS9rciTvu0sVX74ZeK5BePpLc0//VWrfXPX0Hxl2P29m5N
         z5pw==
X-Gm-Message-State: AOJu0YwDOBfk0TCMFsrDYGnJh+kJAxf8x3bufGfY/Gsco6EDCoiYV1GX
	W4ZQfWM3e68owxM7yGCC9ajnMXcnuNz73tEGxKfpzvBo6O8k3V/PCA5WKicRUptZ+fDcB1lP34f
	VB9x5ofkc07X63kVtUtw11nezOi06etfCCrGGos3lSXsF0EPR0myZ
X-Google-Smtp-Source: AGHT+IG/DL6INtFHc9j0F77V2IEAikGcResQBCFRtVCsiZS9TEJ+CqZIrzxtUr08GJ7e33dJapOrJizJUMeB5E/tYFo=
X-Received: by 2002:a17:907:c82:b0:a36:c353:952e with SMTP id
 gi2-20020a1709070c8200b00a36c353952emr143080ejc.41.1706820351053; Thu, 01 Feb
 2024 12:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123221749.793069-1-almasrymina@google.com>
 <20240123221749.793069-3-almasrymina@google.com> <cff078e234e94593fb3fcfce9732d7988ead42d3.camel@redhat.com>
In-Reply-To: <cff078e234e94593fb3fcfce9732d7988ead42d3.camel@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 1 Feb 2024 12:45:37 -0800
Message-ID: <CAHS8izMHciG28ZdiRmvxpoKcffS7uXEHNTC+EfDgtd96btx7tw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/2] net: add netmem to skb_frag_t
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> Hi,
>
> I'm sorry for the late feedback.
>

Thanks for looking.

> On Tue, 2024-01-23 at 14:17 -0800, Mina Almasry wrote:
> > @@ -845,16 +863,24 @@ struct sk_buff *__napi_alloc_skb(struct napi_stru=
ct *napi, unsigned int len,
> >  }
> >  EXPORT_SYMBOL(__napi_alloc_skb);
> >
> > -void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, in=
t off,
> > -                  int size, unsigned int truesize)
> > +void skb_add_rx_frag_netmem(struct sk_buff *skb, int i, netmem_ref net=
mem,
> > +                         int off, int size, unsigned int truesize)
> >  {
> >       DEBUG_NET_WARN_ON_ONCE(size > truesize);
> >
> > -     skb_fill_page_desc(skb, i, page, off, size);
> > +     skb_fill_netmem_desc(skb, i, netmem, off, size);
> >       skb->len +=3D size;
> >       skb->data_len +=3D size;
> >       skb->truesize +=3D truesize;
> >  }
> > +EXPORT_SYMBOL(skb_add_rx_frag_netmem);
> > +
> > +void skb_add_rx_frag(struct sk_buff *skb, int i, struct page *page, in=
t off,
> > +                  int size, unsigned int truesize)
> > +{
> > +     skb_add_rx_frag_netmem(skb, i, page_to_netmem(page), off, size,
> > +                            truesize);
> > +}
> >  EXPORT_SYMBOL(skb_add_rx_frag);
>
> Out of sheer ignorance, I'm unsure if the compiler will always inline
> the above skb_add_rx_frag_netmem() call. What about moving this helper
> to the header file?
>

Will do.

> > diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> > index 1184d40167b8..145ef22b2b35 100644
> > --- a/net/kcm/kcmsock.c
> > +++ b/net/kcm/kcmsock.c
> > @@ -636,9 +636,14 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
> >               for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++)
> >                       msize +=3D skb_frag_size(&skb_shinfo(skb)->frags[=
i]);
> >
> > +             if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0=
]))) {
> > +                     ret =3D -EINVAL;
> > +                     goto out;
> > +             }
>
> I feel like the following has been already discussed, but I could not
> find the relevant reference... Are all frags constrained to carry the
> same memref type? If not it would be better to move this check inside
> the previous loop, it's already traversing all the skb frags, it should
> not add measurable overhead.
>

Yes, this was discussed before. I believe the agreement is that, yes,
all the frags in a single skb will be constrained to a single type. It
was discussed on one of the many RFCs I believe.

Supporting skbs with mixed netmem types is certainly possible, but
requires per-frag checking and per-frag handling. Constraining all
skbs to the same netmem type just simplifies things greatly because
frag0 can be checked to determine the type of all the frags in the
skb, and all the frags in the skb can be processed the same as they're
the same type. There are no interesting use cases I can think of right
now that require mixed types, and the code can always be extended to
that if someone has a use case in the future.

I plan to add a WARN_ON_ONCE or DEBUG_NET_WARN_ON_ONCE in
skb_add_frag_rx_netmem that detects if the driver is trying to mix
types in the devmem series which adds non-page netmem.

If OK with you, I'll keep the check for only frag 0, but combine it
with the nr_frags check above like this:

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 145ef22b2b35..73c200c5c8e4 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -627,7 +627,8 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
                        skb =3D txm->frag_skb;
                }

-               if (WARN_ON(!skb_shinfo(skb)->nr_frags)) {
+               if (WARN_ON(!skb_shinfo(skb)->nr_frags) ||
+                   WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0])=
)) {
                        ret =3D -EINVAL;
                        goto out;
                }
@@ -636,11 +637,6 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
                for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++)
                        msize +=3D skb_frag_size(&skb_shinfo(skb)->frags[i]=
);

-               if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0])=
)) {
-                       ret =3D -EINVAL;
-                       goto out;
-               }
-

But I'm happy implementing the check exactly as you described if you
strongly prefer that instead, I don't think it's a big deal from my
end either way. Thanks!

--=20
Thanks,
Mina

