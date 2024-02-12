Return-Path: <linux-kernel+bounces-62355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C253851EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751F51C22158
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3641D4C60B;
	Mon, 12 Feb 2024 20:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRM4zYfB"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45481DDC5;
	Mon, 12 Feb 2024 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770911; cv=none; b=hsAOVWurFSIJtBqrP8D4qtpGvUEvIzJUZnySI0UPQubGmRimVsEn4/IaIg3kkPOHohYMwpLk/LieucS5e9ErrkZUkG5UDVgUgX4PRn+/3Uh/W3BdB23y79BWCPRTcXS5JrsRTp38mnbilrnzhYfOT8QXJGYVlk5liw76vUE5/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770911; c=relaxed/simple;
	bh=Md/pSFafsE4akhvdvEWt6/CnKkJ3vWl/IHLH8J5Duvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCgOTvPUtvYa5YhI/0+JtFUxJtLcV/OiywzVun2vphD/xIbPnZ9hBtuUM3R1dB72QMCjMiW8iJnC4wPp+9e75pRGkc+Vz4T71Wfh2vMq11ozLhMfIRgVyKciDh5Gpu11HhFZdvwWK3ea4b3z8mcXy8EDBGgpoDaJRugmXzEHuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRM4zYfB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0d95e8133so45650621fa.1;
        Mon, 12 Feb 2024 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707770908; x=1708375708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md/pSFafsE4akhvdvEWt6/CnKkJ3vWl/IHLH8J5Duvc=;
        b=ZRM4zYfBNfovOuafhAwPQAkD/Z/Eh5NGoO2jcX53h0nB7TRcMhM2EGbwM13S5GhqUz
         RqaUwfB5hCC5Iws1z1grhJD8xcS+dYUGqiQPBlwY42fYTFY38sBhZrU3o1H1gy7vlwMD
         IcYe3SvLeGP2jEpjinS7pcUH6GugOrl2LgXr9uF+T3SpntSvQJk3lSHy7TlcLE0xVfb/
         ljbdSyUiuQAVI7A+VBrVSyVUBpBb8t45lBGF/vDaqGXhMRnkCpR0P65u267dIwtOQMDr
         4rEDFNGh95Oaf5gbOXVH5nOYr1+VKrOyMN5zq2jFlGA67AsYxSK82xdVd0ptKIp/TRQ5
         dB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707770908; x=1708375708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Md/pSFafsE4akhvdvEWt6/CnKkJ3vWl/IHLH8J5Duvc=;
        b=U8RnhK7p8a0GXF6h3gQflrOYWT3JG0ZtbkxSKnZRbXl24QmrkwdF7Wt54cX6+iEDY8
         i1YgwPUFxTEfJEoetByTfuMH0Zb1ruXYYfsv17+W09dNm+zuklaHN9PHgI8StTlmma7Q
         faBffX1IlptGhp+XW7+RG2yEZ5AsjR0fWMgY+xV/oqKC3wau1sNw4YcgSK9bZNdEHUn2
         t0SON5s1tMYZ0Axz9d8xTqxsGS6xjQiWrUE/xn3l4DFaXkTPoU3dRqoIVkaloQQYjp5k
         7OwZ42EvbjQuCI1wivJnvqpRaHmDNCwca3YImzsnp9V4vEw+xeyizjAJB3FDC5eCUNWN
         ANyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIuiKqNfk2MbY1/38DDC0DsYE2rbTFYayaVB8Kb2ksef8ErRLjYHWHj6rnsWBQJ4Mp+yNjZO2Um1j94IHwJ2wtVFzEdNYfTLuF6jA9/JPJ+FAOdhe/STkKwq8v5azw33r7Va7i
X-Gm-Message-State: AOJu0Yzz6xbVqRuj/ZXAHx+wXBMOVL4WRErCpTmgzIIh0rdfuy3IHxdQ
	19amk2qU5FuTvvX4caRKqW3GZsEdBT3DdxQVacJy1DrW5S99X2HeAl40J6bWkjYQEsShIgvY1/4
	wpw4+JXNcNlC4GO/D8+Gfq/XzM34=
X-Google-Smtp-Source: AGHT+IFUDKv/nSVTdAiug7ouaZyRQFNxk9dF2F/eicYdMp6meoob3vj9Fnxkz0fIEjDGLJb2Yza9pO5x0Z7dHlU9RmI=
X-Received: by 2002:a2e:854e:0:b0:2d0:b29b:2350 with SMTP id
 u14-20020a2e854e000000b002d0b29b2350mr5172616ljj.1.1707770907736; Mon, 12 Feb
 2024 12:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122053348.6589-1-arinc.unal@arinc9.com> <20240123154431.gwhufnatxjppnm64@skbuf>
 <d32d17ed-87b5-4032-b310-f387cea72837@arinc9.com> <CAJq09z6pidHvtv=3F_yKHDdY89kzYSF+xh89pzg1raAiQPMyMg@mail.gmail.com>
 <20240129145632.d2mu6vbwcqhjpyty@skbuf> <816442dc-b420-4413-a29f-c73b95f1026b@arinc9.com>
 <120646e5-bd05-48bd-a308-e0e8685633e9@gmail.com>
In-Reply-To: <120646e5-bd05-48bd-a308-e0e8685633e9@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 12 Feb 2024 17:48:15 -0300
Message-ID: <CAJq09z7BdTsjFPXGQoaUZA5QGny4EEDh+AAcutPfd7RHU6vjYg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: dsa: remove OF-based MDIO bus registration
 from DSA core
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, mithat.guner@xeront.com, 
	erkin.bozoglu@xeront.com, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> >> I don't see why this patch could not wait until you resubmit the realt=
ek
> >> consolidation set and it gets accepted.
> >
> > I agree. I didn't anticipate that realtek-mdio didn't set IRQs on PHYs =
for
> > the MDIO bus registered non-OF-based. I'd much rather wait and then sen=
d v2
> > with the mention to realtek-mdio removed.

Hello Arin=C3=A7,

Realtek-mdio now uses its own mdiobus driver. The revert is good to go.

Acked-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Regards,

Luiz

