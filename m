Return-Path: <linux-kernel+bounces-122100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B288F1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BAA1C31906
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB4D15251E;
	Wed, 27 Mar 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPEWNJrU"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27AEEAE5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711578595; cv=none; b=X9Bx5JpJ2oPez2oNrHyZEN7e/oRZ/QBdZawMfPqUsJoQoOItA6q7AzlH0Rg6OChrmf4eSDlw35HM1R0300Bu6BUT/P+WLOvJ3oNuiJHY08I9uNh1RBlFvKRktu6E2Dc7tqB7Vd8ZOEo2C5bIcvpj6FArCv1HhvHZ6/2C8mNt/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711578595; c=relaxed/simple;
	bh=uQZWf1z2g5EkDsuZ+JXF0zg9NReUumhN41xOtlzzRiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2H1LvPKpqVW1J0z1gwQrtwiBxfrFCdOr6HtxSqpp95avXyoHGy5Zw8iYVrC6EW4tGCTAyuly8Oa5M6aBBXjSUZa3Q10bBlDE7gO4Vq1+AVGWnXHq1Y+dBrTLnDhE6d37cUjLI8dkrh9X2FeE+DFnsNpGNJtKVO2O2qPWu5N4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPEWNJrU; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a4715d4c2cbso38754166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711578592; x=1712183392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7hfzMDD6Cf+PT6Udlfkf6Vck2EoOCaENymKmzHzlvE=;
        b=uPEWNJrUxtgOOBSOTfSbmkHUy347dgXIRGaH0s5lH3fPyqihKMLSqH9BbDRqIbxkdJ
         0feRw9Xi9P+b2wxofsaPmiDPFcLSanSK962lBhnCqFskYZfWicRbG7TQioGSc0zl/snx
         OoCfUgXMQBx/hRmZDd4PV4bSdr2fohzcYoEEFyULQqGD98t5/eTNezQar3S6OAB4hahP
         iw9eeIn7m7PzlPcY1O9jxQ7fOjExoZwWVMWhLwTyIAJxSdZDoqw23G+WEicvNH2xDOMe
         ZeI4Xd2rAkatbIo37W2bkRvRdvH1bH9aWXgbL0FAAENV51Xm7cTqPWp30WZ7D5v0axF2
         kNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711578592; x=1712183392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7hfzMDD6Cf+PT6Udlfkf6Vck2EoOCaENymKmzHzlvE=;
        b=V4BNUGBlGeuI9Mq64O1etBT6L0acoOd5vGvX562Giy073p13e+JfLZNnN8nd5/68a2
         XBq/0IkLFqoeVhhRI1ud8CRfMSrfRAIpIH5ZXE0ybKO64/UBpt8PaEDwNYcCOVuBh0DL
         WZ+s39KMYh6Hmc49XApNPn4qPa6KWFr8DQ8ebtakgnvUxuhLv/rabRvrIq3VUat0peHK
         UgydO2/5g3Twc8XnFcYj2KeHEgHpC9zvzAr2p2iNxCSU07UPg6QZP8UHdjZhR7HZpC0M
         NWaGjQhpyqD/gRj966z7b+/eew2oaE7SskaQ/d0z21OGWufeGOSSmNh0Ej4iyWFfM2xU
         MSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgpWdR53uRfrDVPTpPciI/SpBjGf4vLPE+imtx/P0J7WONx4MuxzFQqhOuNbctScCPg4ZKFEVYDvUZgQiu2ZMO3902TeUnbgiEVQdP
X-Gm-Message-State: AOJu0YzoFd92ge7gws/0nQt1qMxGRqDJ2pr/zG0u6aiEVXjbFW/idPOa
	4iyafEBo1k7p5WKpwivNo2t9TYP2ozoCJ1oanSf1hd7wdpmkdrA5af9DZhnnlTjbT4vkahWi5BC
	LbZlaJgKvVKC4xD687hRz/NCG1rEiNn7I+rfO
X-Google-Smtp-Source: AGHT+IFFxuKwEuMQUbTJjf1TClC0l4CS1aDNxL2HTZKYktZWM3POp3FVSMhvZh8n/lYqFlEpJGoXwRu/IFonbL+rcrE=
X-Received: by 2002:a17:906:150a:b0:a47:3469:d75a with SMTP id
 b10-20020a170906150a00b00a473469d75amr498589ejd.67.1711578591788; Wed, 27 Mar
 2024 15:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325235018.2028408-1-yosryahmed@google.com>
 <20240325235018.2028408-3-yosryahmed@google.com> <5e394253-4f01-4172-998e-bbf3d82de6b9@linux.dev>
In-Reply-To: <5e394253-4f01-4172-998e-bbf3d82de6b9@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 27 Mar 2024 15:29:13 -0700
Message-ID: <CAJD7tkaty2vE5Wz-dHRnMnnwjoSwBCaXgtxHzTqgUSJEpkSoRg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] mm: zswap: refactor storing to the tree out of zswap_store()
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 7:25=E2=80=AFPM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2024/3/26 07:50, Yosry Ahmed wrote:
> > Refactor the code that attempts storing to the xarray, handling erros,
> > and freeing stale entries into a helper. This will be reused in a
> > following patch to free other types of tree elements as well.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/zswap.c | 42 ++++++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 1cf3ab4b22e64..ff1975afb7e3d 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -827,6 +827,30 @@ static void zswap_entry_free(struct zswap_entry *e=
ntry)
> >       atomic_dec(&zswap_stored_pages);
> >  }
> >
> > +/*********************************
> > +* zswap tree functions
> > +**********************************/
> > +static int zswap_tree_store(struct xarray *tree, pgoff_t offset, void =
*new)
> > +{
> > +     void *old;
> > +     int err;
> > +
> > +     old =3D xa_store(tree, offset, new, GFP_KERNEL);
> > +     err =3D xa_is_err(old);
>
> Seems to use xa_err() to return errno, xa_is_err() just return a bool.

Good catch. It happens to work out because returning 1 would have the
same effect as returning the errno. Will fix it in the next version.

Thanks!

