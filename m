Return-Path: <linux-kernel+bounces-93704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC898733A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9DFAB2BC19
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45535F869;
	Wed,  6 Mar 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg5cNgRD"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E995F466;
	Wed,  6 Mar 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719607; cv=none; b=ox4CvS1HNPUy5GcVT6rXnnXI5g9lZmIeFN6ExL0kkwFtgMF9qREQ2BFfkGkP1cEfN2Ie6r5/Bqs69T7STGqfRLs3+wyHOd9xoaeSjLsnpZrGOWEQSTAKi4voTrYDIRgDnGtBHA66+pYDIKEquMgxjQgjdOrupZwyyx1/JUwI8dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719607; c=relaxed/simple;
	bh=neda+ll9xMd2T7fw5COkPSMTdIF7ybWsYTL/HbYkMnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SP3dYvX/26GvFYVmLnsVFBhKFHkGVT16AiOJJMkMSKneS2LYxWd53OKB9ehiFZcLq3hrpdyzcpgJ1k6gbaGCyf3qQWC0Wgaxta72EUyzP7stPA8yG2k7L1zWAjiqjkvPGREq2vuH6F1jV/Nk8MHURDpfiEVgC8GwnneeKLMwQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg5cNgRD; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4d37e76a3dfso375827e0c.1;
        Wed, 06 Mar 2024 02:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709719604; x=1710324404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neda+ll9xMd2T7fw5COkPSMTdIF7ybWsYTL/HbYkMnc=;
        b=gg5cNgRDskV/qbNPwKWjVRKgEmpA8XYC0f0NNnO+I04z3UCvGqbruyqa+uX9de39Kh
         JlGNaXbJAKOFqlEUqOpmjO/R15mNCoUAqiyhHyceI8LxMCdWyLWdwt0p20dPFV8obq0u
         EKzFrr1QDFKgqzUYWd7Eq+/81oMmYiVHXWMRkbzdEzKSBy7D7n6vLfilFvlfZAVOeM4l
         za6Ppw17NejXY46Sne7vW8d8Lh9P7C18t8j0pLGxFiiiemnf1sMIKtqN2DNB2lADJ1im
         JtA7Jco47VxgDvb62M29qxVIiGUpYwkN6JLOsusLrUkgbIdMrF+rJpqpEIil9HP3Onx1
         mB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709719604; x=1710324404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neda+ll9xMd2T7fw5COkPSMTdIF7ybWsYTL/HbYkMnc=;
        b=gNbISK5lCoKN19JCzQjEaJXpQKTnfyunIQHYd7vrRkFolrDRLZraEJPTaBt7yqER6O
         O/z1qRwgQKpH7WR2PM0Yz5yzQzaq078TTm5zr5Wo1fVCrJqrESXv/edDKBnJKj8gqhQp
         IjaHt4Kf8wqsum0rM8YqNlpjcbr9qN43W6J0Bd3QvfBHuh8RKbaATlYiVM4Gcg+Nz27V
         IcSzONK6lvGFaCLfx5L5fgf6D9LB8LGcWghwvu26B4BWQQfshQsxJ7X96gEuhHs7QwBL
         5RH15Yeyo3wKXBHXg4QzlyRu+AIvVPDYEsshsuWwyQevB4s8+L19XkBIB5l7T9wL7DEk
         bEfw==
X-Forwarded-Encrypted: i=1; AJvYcCXxR6OIWN79UeZZzuwt3IFULTaS3Lf/0+NwlUGb+8xzhdlSxIZ+mxFhEmIfuuGDX+3mfPYFnvrbTJ/VkFDeL8E5Us7QT4+zCB3Z9RAijt6FqjWBEKB6KQxC0VnnIEpwSXt1aV+9fKiFRDyfy9+U0ctCLXsm/mzdYaLalMpqS6gsMJnIipq4L+Ppi9b49e/SKWhKIkc1G1rWkgEcPS3gG01AZYQfjMn2mrNR
X-Gm-Message-State: AOJu0Yxt7rMUOu/Pj0qui0kQalv0zMF0r7Hq/G58mTEg0effRelMeAIb
	bsJf962k+IET3kmO84AS5ekeeaNOY//EvnYnDv7yGY3BBYBzbdXek/WPP38x9wjQR6MITgSOSKe
	rNIxwV8mWwsonIIc1dicqdiEKVz4=
X-Google-Smtp-Source: AGHT+IENl8z6yKbP3w97g/9zhyS6P5SBkWKWGholQlgyfFQX8+rRE4VE45IFbhVSIFugwVoYDrJ+/QoO8WWuBN125mk=
X-Received: by 2002:a05:6122:1699:b0:4d3:394b:d997 with SMTP id
 25-20020a056122169900b004d3394bd997mr3513155vkl.4.1709719604467; Wed, 06 Mar
 2024 02:06:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
In-Reply-To: <CAMuHMdW0MxqxRwULhLsRtnYXYK8NYxq-uU7E2BscbvPh3axYFg@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 6 Mar 2024 10:06:18 +0000
Message-ID: <CA+V-a8vKo8ADB_R==vgBhVpSH43DOzdeA_NhZ1BCBdNuam3UmQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, Mar 6, 2024 at 9:53=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Tue, Mar 5, 2024 at 6:16=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document support for the Serial Communication Interface with FIFO (SCIF=
)
> > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface =
in
> > the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> > (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC =
has
> > three additional interrupts: one for Tx end/Rx ready and the other two =
for
> > Rx and Tx buffer full, which are edge-triggered.
> >
> > No driver changes are required as generic compatible string
> > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.
>
> If you declare SCIF on RZ/V2H compatible with SCIF on RZ/G2L, you
> state that the current driver works fine (but perhaps suboptimal),
> without adding support for the extra 3 interrupts?
>
Yes the current driver works without using the extra interrupts on the
RZ/V2H. The extra interrupts on the RZ/V2H are just sort of duplicate
ie
- Transmit End/Data Ready interrupt , for which we we have two
seperate interrupts already
- Receive buffer full interrupt (EDGE trigger), for which we already
have a Level triggered interrupt
- Transmit buffer empty interrupt (EDGE trigger), for which we already
have a Level triggered interrupt

Are you suggesting to not fallback on RZ/G2L and instead make RZ/V2H
an explicit one so that in future we handle these 3 extra interrupts?

Cheers,
Prabhakar

