Return-Path: <linux-kernel+bounces-94279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D152B873C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A99C287595
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8D137914;
	Wed,  6 Mar 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eotKCtCl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459D2134CE3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743222; cv=none; b=uxMjO2sp5YKNm9wxNae1JaN6l415kyxM+oYPS0NMKruTTKYeiVCvwUHpbYinJlFr644A49Z002MhxwpFnIJsq8zOPQt6KQnAtgmM2N5fsKWLJB1qfy9zNnIrWtcaZiKpE7Dvx1v44ubWcMZY+ELySb9ZEMm85Eq3SyuLjG1FWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743222; c=relaxed/simple;
	bh=Yegp3wOSPvL1W7YR800iskMPmhja07Aw33gkny63/R4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyAAgmwOL0GlDckGidVAAAnieuvBbNb4jL6kDzxsA1pDQtZktO4WWwdgZTOPS1lIxV2HxI5p7DKEN2/iNv6WGxLsEHbJ4XenzeA1FoLEZtSmNHxeiRZo0r6M6M7NxPMtyH3alkLoso2V9B04j3nk3EvzwurX7TfOQSDRPIn6Lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eotKCtCl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so1027973566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709743219; x=1710348019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjlGkktx8405hHF5yhBJ78WUMqlW3sHOtv1UsXx/Tng=;
        b=eotKCtClQjby+TlKa1BqftSG9J4OuD8acB51YpBT58FKSzg1ZLX3qEU5kyxjQvJkei
         Z/eEtvXS0RfBj+oVcZZta/yOLSIHYmZR37leN9xqZ56iARrpjQrepZh0bDULODWYKVFr
         aSgfr0IJxTu/BIhskDYqgHV+o/gkdsyjyaKBI0z2kS3r8xiTw/yiVlthr56aVdUdPg83
         fOPcYNGsbN2ZFCqXPMReCrxHKSrQ5b5V9jz9FXiaqQ/5cWa8aasDNaJ1+A0qJryiANS3
         oZV+wh50QnhPj+10yqYJaGlWqJo2sMZdf9q78DiuxygUcKaMsyeXIJYMbH16sgOxqsUN
         EgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743219; x=1710348019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjlGkktx8405hHF5yhBJ78WUMqlW3sHOtv1UsXx/Tng=;
        b=eJ8v5wWlGI6t+H/nDhg/f9XhO6a43R0R762jG4Pzsbf3LSBEPlzkma/PT6SUpncogH
         JmucEv9h9G9QiacbzatxyfoN1eM4D9Y1xgKMEK2G33eD3NIQbRrC3huFCgXQsm1BQuO0
         2Ev0EQ7rjiBm0daZyPAZztg2id/Nh9F9na/IjSa2Np8XS1FoUZjjreBtXZpxCgYM+Sng
         TD4E+MPVA9mLQKuc94dKTQJ7srtr+3m57sch8gO9Rg6xW9XWNB7ZMYnLCSl2NChFI66p
         EeJuB7bKEHDcKly3fq7V9EdD31yQFKSDMxkUlzeoLjv1zHGpOFO4L7YuYcY28QBPhmPC
         er0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdCgFjl+Hm2VU1PBUZSaw+lK7z/GgmKu+xN7/ZV5Dau41aJtU1WCztarB4sZAJOaSidWTz/Jnrkx9AXFpVaugcyjVtIzFyg87GQJAA
X-Gm-Message-State: AOJu0YwV4IS9lc4rWmfoorGU3b48jWL5PQyOoPdi4NPth6ufKDEanfK9
	16934xTGTGcsLO45VLtzxV1P5aBETvvU0Up4z/dd93TY1ymz5u+c5Gk98FXWJlxsSpynJR7fKLv
	gPZS7o1xiWTqohLAR4qZg+UyvMjaRfedYvA/e
X-Google-Smtp-Source: AGHT+IEYIFPLuidYagpc6h1Pc4i7Rm1xE1UUat5OYul8fQF42ujHnTo6FRnkomzB3xZgNd8pXEwxcFKrtDPvo6gGLQs=
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c779 with SMTP id
 lh22-20020a170906f8d600b00a452e21c779mr6965186ejb.4.1709743218198; Wed, 06
 Mar 2024 08:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304094950.761233-1-dtatulea@nvidia.com> <20240305190427.757b92b8@kernel.org>
 <7fc334b847dc4d90af796f84a8663de9f43ede5d.camel@nvidia.com>
 <20240306072225.4a61e57c@kernel.org> <320ef2399e48ba0a8a11a3b258b7ad88384f42fb.camel@nvidia.com>
 <20240306080931.2e24101b@kernel.org>
In-Reply-To: <20240306080931.2e24101b@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 6 Mar 2024 08:40:04 -0800
Message-ID: <CAHS8izMw_hxdoNDoCZs8T7c5kmX=0Lwqw_dboSj7z1LqtS-WKA@mail.gmail.com>
Subject: Re: [RFC] net: esp: fix bad handling of pages from page_pool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	Gal Pressman <gal@nvidia.com>, 
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, 
	"Anatoli.Chechelnickiy@m.interpipe.biz" <Anatoli.Chechelnickiy@m.interpipe.biz>, 
	"ian.kumlien@gmail.com" <ian.kumlien@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 8:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 6 Mar 2024 16:00:46 +0000 Dragos Tatulea wrote:
> > > Hm, that's a judgment call.
> > > Part of me wants to put it next to napi_frag_unref(), since we
> > > basically need to factor out the insides of this function.
> > > When you post the patch the page pool crowd will give us
> > > their opinions.
> >
> > Why not have napi_pp_put_page simply return false if CONFIG_PAGE_POOL i=
s not
> > set?
>
> Without LTO it may still be a function call.
> Plus, subjectively, I think that it's a bit too much logic to encode in
> the caller (you must also check skb->pp_recycle, AFAIU)
> Maybe we should make skb_pp_recycle() take struct page and move it to
> skbuff.h ? Rename it to skb_page_unref() ?
>

Does the caller need to check skb->pp_recycle? pp_recycle seems like a
redundant bit. We can tell whether the page is pp by checking
is_pp_page(page). the pages in the frag must be pp pages when
skb->pp_recycle is set and must be non pp pages when the
skb->pp_recycle is not set, so it all seems redundant to me.

My fix would be something like:

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index d577e0bee18d..cc737b7b9860 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3507,17 +3507,25 @@ int skb_cow_data_for_xdp(struct page_pool
*pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);

 static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+napi_page_unref(struct page *page, bool napi_safe)
 {
-       struct page *page =3D skb_frag_page(frag);
-
 #ifdef CONFIG_PAGE_POOL
-       if (recycle && napi_pp_put_page(page, napi_safe))
+       if (napi_pp_put_page(page, napi_safe))
                return;
 #endif
        put_page(page);
 }

+static inline void
+napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+{
+       struct page *page =3D skb_frag_page(frag);
+
+       DEBUG_NET_WARN_ON(recycle !=3D is_pp_page(page));
+
+       napi_page_unref(page);
+}
+

And then use napi_page_unref() in the callers to handle page pool &
non-page pool gracefully without leaking page pool internals to the
callers.

> > Regarding stable would I need to send a separate fix that does the raw =
pp page
> > check without the API?
>
> You can put them in one patch, I reckon.



--
Thanks,
Mina

