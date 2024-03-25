Return-Path: <linux-kernel+bounces-118008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3A88B24B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46A82C31E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B76CDBD;
	Mon, 25 Mar 2024 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBDnjIS5"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9485D738;
	Mon, 25 Mar 2024 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400798; cv=none; b=XzTKtMPB6g7RYJhFoixL77OxZ27WJsriKCmERbtNZ488pOjeOL0/8Ddvrsg6cuJoL9DuvdOwrgs3YNmRAQF7nt3G4pbmE0KI7dbb99sQOrPX7SVToaO/Mq0jN9hxyBEEIAfrdyWuC+Q91yS277sx5gE5hVllRCqSd9OdBD2FAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400798; c=relaxed/simple;
	bh=W/IRNaNn/CQabWeEAK+puc7p/pV2c9JtLZ3NURaI1O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHcO2Tul9GjROFIamm+w2ScRYIkb1679M2zoB7u/f5SLuBzBMfad3WwWzNdvswigZ//Q6Yg/DcvF+o/jktYoTXmLtQzpBreqYE5ahl7qC/zROFO6ES0+4UJ6lPWu/TRBJehLnPmSiizjtGo3xv5QM68Zn/zoFMruuVnG7cdH6gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBDnjIS5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so3784242276.1;
        Mon, 25 Mar 2024 14:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711400795; x=1712005595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/IRNaNn/CQabWeEAK+puc7p/pV2c9JtLZ3NURaI1O4=;
        b=DBDnjIS5h4/MEmvmCgqF2eRDfQcwTrD5HS/8mXBERY5+mYe6nNbNWR4j2osLlvBNIi
         3BN8/puX6FW2Msp6ndlRurQEVJkDrZ497og+yB+RT6S5I1VrKhBr609rSKJIL2JQwVl3
         ujwiywgiRGohWFOrGq+G9jbNHMVZkKoJMx9mv42PZ2rRt/NCF/MkK4PmwIuZsvfQY9Rh
         EyKkXa/ripwEdS2fLrl7f2tthgvBMgeO4g9fWsNGpM7x+8SX0P5LoUK21dU5JRLKMXMl
         lKMT1h8Vq6YCo7OyaMPHDVTcTmu2YMuU36/fw2DFpoPs3E1jADlDm8lEDFckBOfkBnwP
         6yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711400795; x=1712005595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/IRNaNn/CQabWeEAK+puc7p/pV2c9JtLZ3NURaI1O4=;
        b=p0vyCx9D0fxns1xKp/7MUPRgTf7mnSjtYi9e6NGL6DRlDvLaggm/czsD7owD+hGXbX
         ju/d+3Ga6ohIO/x1/r7DCNaei/fl0acKX6c1l41FVHtWyJWi24BHXSZEGmblAPVCKhyc
         fO/qciwmiokHrc8VOZr0JJaER2FnhHQ0KW6Ks+9eem9Ir/zWAAW8yDfcU8Iq3tiAIc7Y
         IFpCZTillwM9go87+9/PiqkB4XG+jjSkOpDGOVcOB0VcL1LsgxMcYRnPfwWp0MRMp3ML
         vZujvEvxqvFsaQ7TQ8oJzRqYJi6WuclRW/QcY7nkctdG7WLF3uXq4T4rtOOoda38PR9y
         a7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfzt8DjRQBE/NfVKVJKsF5Xg1twNfg2ZLM22kyvsSMYPQxRk7YtpGVHaw/sjJCiB1sQD+kUbzsGsPOF5EtWCDrEBTurr2fhAcQsuBdFQ+gEvogI16FvQ5/4iMUGWT9pdr2iLCaVatksp1ev6W1XLTudrKlmUki99DiaoXSxjLXdPmC9w==
X-Gm-Message-State: AOJu0Yy5LSxuzLiIm8WHDVAlfUBZCcSn3lwCDRcF6VDor92G/rwveSCI
	g7m93iQVQsgh2I7fnwYBkpG8AOW/MVxmVl3Ol32hPUPcwvXZfjTohgu6mwbzwN3IXhPWpEY0+VA
	3BJcvsKkNNkiYz+wKXIrGrBVIufU=
X-Google-Smtp-Source: AGHT+IH9IPJks2s90kBg2ZyyfUE1y9Ifh8TkFCKNgLReMFQCUKv95yuhw4iTET9DuENgGiGlNkIQATL5nj3tqVLyy3E=
X-Received: by 2002:a25:b28d:0:b0:dc7:46fd:4998 with SMTP id
 k13-20020a25b28d000000b00dc746fd4998mr3706871ybj.13.1711400795296; Mon, 25
 Mar 2024 14:06:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325153356.46112-1-l.rubusch@gmail.com> <20240325153356.46112-5-l.rubusch@gmail.com>
 <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org>
In-Reply-To: <f74a01bd-46a3-46cd-a47a-fcfccd7e4dc6@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 25 Mar 2024 22:05:59 +0100
Message-ID: <CAFXKEHbJ_5unY24aZeutvM-xrjevQ=z7ngDcgwJR=NXzXONx5A@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 7:32=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 25/03/2024 16:33, Lothar Rubusch wrote:
> > Add spi-3wire because the driver optionally supports spi-3wire.
>
> This is a friendly reminder during the review process.
>
> It seems my or other reviewer's previous comments were not fully
> addressed. Maybe the feedback got lost between the quotes, maybe you
> just forgot to apply it. Please go back to the previous discussion and
> either implement all requested changes or keep discussing them.
>
> Thank you.
>

You refer yourself to the above mentioned wording. Would replacing
"driver" by "device" in the dt-bindings patch comment be sufficient?
Did I miss something else?

> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add

Just for confirmation: when I receive a feedback, requesting a change.
And, I accept the change request. This means, I received a tag
"Reviewed-by" which I have to mention in the upcoming patch version
where this change is implemented and in that particular patch?

> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>

I'm pretty sure we will still see further iterations. So, I apply the
tags in the next version, already scheduled. Ok?

> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>

Going over the books I feel it does not make sense to still mention
feedback ("Reveiewed-by") for the v1 or v2 of the patch here in a v5,
does it? Your link mentiones "However if the patch has changed
substantially in followin version, these tags might not be applicable
anymore"
https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/subm=
itting-patches.rst#L579

> If a tag was not added on purpose, please state why and what changed.
>
> Best regards,
> Krzysztof
>

I give it a try with b4. Let's see.

