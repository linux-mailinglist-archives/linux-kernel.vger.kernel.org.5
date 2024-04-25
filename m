Return-Path: <linux-kernel+bounces-158118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C0B8B1BD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E861C23C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3D6CDB9;
	Thu, 25 Apr 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/G+iImO"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDEC3A268;
	Thu, 25 Apr 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029808; cv=none; b=UZuO/1dhYzjRIoDQqY/lR8GXKO3I1sSWRU/ohEVX0RMgQsWkoPChWg+GpX9TYREbRccApl7J2rGITy6kNUqtR3ClR2yGHbM62MAa9UfCNHBBgbZqrJlw2h28myjQZah3Nhbkz135NqzGjWEW+n2HNz0tIzViuaWeRBsPOxAaJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029808; c=relaxed/simple;
	bh=A/4Kk+ecoj6p93X8Ek2vHbx5mGDcRoxKNP+8wWGtgUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCzh5LAr4YKTJW03VKIDdrt5gl2aLmZuGuUaUnmd1fc5Fm7r1Nx60D83pWiByvl63cwbUp52pSrGFe/0t86HzFj0ydAFj9DZcnJQQNMcdjHvl59VY9Xoow6FIqms7WS+95XYI+F+fVkHmTHugULJ62Rd/DarN691HAHVx/ifjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/G+iImO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-572347c2ba8so607043a12.3;
        Thu, 25 Apr 2024 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714029805; x=1714634605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/4Kk+ecoj6p93X8Ek2vHbx5mGDcRoxKNP+8wWGtgUc=;
        b=i/G+iImO/wcySpB33jryMD1918BsOJNH/eETO/BgrOyXUOgJivQ7Yu3Y/nOpAWv62K
         AYKvsnHchc/gCL62toK/EV+g1GsMFYpuemBLPFjTdy4AOYWDal+CAdJ8pIQrpMKjgwzo
         X0wvPRnT8f2z01/SaAEnJQt4aBRS+kNDBIy8aOrchLLdVagYA990KWLSkbsYMnW2PCvt
         uVRoHL3iuZOwd+STQjbOAkBdjR6YTsTGX7OkmW4Va90usLDZunbG3nCD54B8ePZ5izzK
         GrBE4lTG4tFnCI42Bb4XqDgLQiJCF8+6e6Ymg4EwKbb2LKMHsrUsyNL+rxHsm0s4mZTX
         BaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029806; x=1714634606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/4Kk+ecoj6p93X8Ek2vHbx5mGDcRoxKNP+8wWGtgUc=;
        b=R9DbzWctnESvYQtXGHdEr/YvrG/SKRlRnr+xlyE7Uuw079EGILMnsd4kwW2f6Mx2hr
         VUplqJu1TWxLWtfqEX46nxmpzkMJ/pd39V82hW/XUbD25nbqGkQcthEnBpJrpnaakFhd
         wUau6aKD5UnS2vmVj0UtXC8Hda8wMJODS2unKfJKuWqhEmUVLVRrqHYjnf2zs5mCTq87
         DGSdaGIv92bBIVVDcVAJu71+pfXzlr1i4ybYXzCFEpW0oiruPihxI6VsM7SBn3xxpGLp
         w818nfr7pOkqPlSJRfZ4qlxYVYoa9wekvz/45oJInWFV7ZYc52iwBgAeh8oG9lSNvCbf
         vh1A==
X-Forwarded-Encrypted: i=1; AJvYcCUbw4FWCuuUEQ7VkSYXKsUny225LzBBGx9mNthuYp59Yso6dc1CWGjh2DoG6JZoC6ak6hwbOMGfs+hU2ISQVWlh4gn9x4orKJWzyzfdNzmFerMsgIABLnWBlnZCJ+tpE7Pfe8kXb8jCuka03RQKBvgDXjHn4/wYGTG+uyj7CTHgwsaSXKUmgA==
X-Gm-Message-State: AOJu0YxL9bCyLLZPTxIHw2wSdSplNGEkqguUbg/7GX3uGHcUOwi4D1Lk
	VPDqixnVratcP2KYupd8eVrgHx6hP7Pkor0ye975yNHse5G+0ASCCF1ghPvFvXZ02qLMICZhu+E
	QgHnwQcC5UZ6ZaNkpebKK2Bf2w2A=
X-Google-Smtp-Source: AGHT+IEnj6asV4dQ7pWNGOS519gonypRgW5g4IX/Ggz2tgJLhFLFeVhxInVks58EbeT6yPIr6CPGr7NzMG46lDt6/Pg=
X-Received: by 2002:a17:907:700c:b0:a55:9a35:5e9d with SMTP id
 wr12-20020a170907700c00b00a559a355e9dmr3083273ejb.42.1714029805371; Thu, 25
 Apr 2024 00:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424191908.32565-1-rilian.la.te@ya.ru> <20240424191908.32565-3-rilian.la.te@ya.ru>
 <CAHp75VfpRBDTjnZCdOKK+YWZKJ+wbjsg-n4wxjA7qVE0L1WSxw@mail.gmail.com>
In-Reply-To: <CAHp75VfpRBDTjnZCdOKK+YWZKJ+wbjsg-n4wxjA7qVE0L1WSxw@mail.gmail.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Thu, 25 Apr 2024 10:25:41 +0300
Message-ID: <CAF1WSuxAFHbSVAV1r2cDzZms=T_Qg6y3qbgU5rrjySuAd3FUNw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 10:34=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 24, 2024 at 10:19=E2=80=AFPM Konstantin Pugin <rilian.la.te@y=
a.ru> wrote:
> >
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > EXAR XR20M1172 UART is mostly register-compatible with NXP SPI UARTs.
> > It will be handled by same driver, so, it makes sense to add DT
> > definition for these block into driver's documentation.
>
> blocks
>
> ...
>
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> Hmm... Did I? IIRC I only reviewed patches 1 and 3. Am I mistaken?

I think it is my mistake, not yours. If you want, I can do a new
version without a tag.

> --
> With Best Regards,
> Andy Shevchenko

