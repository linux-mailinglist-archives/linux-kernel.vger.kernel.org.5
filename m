Return-Path: <linux-kernel+bounces-41041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F256983EAA1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08D41F24094
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFBD11729;
	Sat, 27 Jan 2024 03:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWvBCTQW"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A16165C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706326724; cv=none; b=VMGdbNDDiiBv0yxSh4HMzez3IoU3SPHS/LXAgP+TrNq/prKbJASOL4h72LziTviQAvuvA4rWSIvaLIN6z7cFQpf64+qw9NWfmKjO/95g3mCiotpOXSLkWO8Q301FND52ueDD/bNIC/sebbBsIBp4m++u/NXJEbtOs066kN6TfTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706326724; c=relaxed/simple;
	bh=ptRvofd1XSyL64ByZHUaDprHNiV0o1rEa53gEIm7ko8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcmXtZdtjkSOhsE0Uen1688FBWy6mezYsJSU750fbYJ3Xkys4SJyHpoXy6XgxUnrwiStCDnOpxoofnS6agAKZLkUgcc8uxape9a+drJjCfwLYE1GeQdXgo45K8w/Jh4xjL2lyyRZrnN9DiF+U6wFqmY+7xFwWmBCNnOTDt+YImU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HWvBCTQW; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783dc658b59so76567385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706326722; x=1706931522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3+lSaV5k4Dfkc53Op2tvfbF0vHcLdK/yHeAoCK2Liw=;
        b=HWvBCTQWShdP0MzEScLNIYWez2JgxH2X2iflY9i0ZC4PF5usnuzS2Ww+YMMqsDlNnO
         pjf3s7meCi/g1JnW4PiovqVRQgQu4zzxHaxe3SuWHslBO/0DSbKnF2t+PDCSiKcEjt8z
         9f0/PxElx2aMRQr5zCuEbQ/Os6gcaNFMW2HV9MbmJB7PrAeX9MJhTXmUEJTvB1dA0JPv
         sYcYTIQ1QtCGRACu2FBxfaORUtVDgWZEHdjgG8z6uncPijGZHXksVK1T/so3ClxCsqsn
         Gc9m/wajC0n6NvCYML50wxmSHxmTfQLaVNFFU/SgGJFWNKDmLFfo8s1X0fe3nVverzVI
         xBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706326722; x=1706931522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3+lSaV5k4Dfkc53Op2tvfbF0vHcLdK/yHeAoCK2Liw=;
        b=U6hl3xhhGH3RxIoUvFlTzU4TIr9dEU39ZB5TAnbhqRqIIu18kisxmRB9nDnor2tfen
         eYlTraIPNk3MijmF1ZQTpxPh9RjVuu1xSAdjkre9l/PYu2gSXety1Tr+1K9vDeOVI6Lz
         qYrVhcqfr6I/IL8GBPaf5uomqdR4OPWl1yk54n+vToRnonlvR6vJJX5456jvfTDaSx+t
         yEeKvunqrkJuRdJNAQ6ojwqZOLDHIB++QwAOYpMEP781aoLF4siY68aYlwi7/oufIe0V
         8EpUyTOZ9FoAZdNot26dlJMnMKzUVXHpNtqpmcgQ+/EPGjHiauOnATQOeaVaK5QknC/u
         PiVQ==
X-Gm-Message-State: AOJu0YztISAvoxuOPel8sBdRXqknVQtfmYVCIy7vFsu3iu/Tzm4T6CiW
	wLIY3uK6+Rl6dZVKoGEih/OlBk20AtvEKZ/xYw/Gr9Pra946vOenHh3vi6Nsvor1hNpwPSf0dvi
	W59lTkH/A6Y3R3yDlvyIq6yDIIsBXkyofLhLdKw==
X-Google-Smtp-Source: AGHT+IGMqouLo1o+ccPzY5vjpHB4grmiMzGREKYTDFUgW1x4VF9zcneNjf49KACEqgsJZVxW7u7GEfa/a763D0Awua8=
X-Received: by 2002:a05:620a:4441:b0:783:b9e4:8b4f with SMTP id
 w1-20020a05620a444100b00783b9e48b4fmr1081283qkp.31.1706326722307; Fri, 26 Jan
 2024 19:38:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126171546.1233172-1-tudor.ambarus@linaro.org>
 <20240126171546.1233172-18-tudor.ambarus@linaro.org> <CAPLW+4nL6D7R88Q_kJjAT-bWTFBk8a=FT0vL+fyRgxaDeSyhNw@mail.gmail.com>
 <b5ecacaa-8ccc-4588-b3be-4b5f85813909@linaro.org>
In-Reply-To: <b5ecacaa-8ccc-4588-b3be-4b5f85813909@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 21:38:31 -0600
Message-ID: <CAPLW+4nN--gG9XsOu6a-mo5vcM-GycRrhPQFOtNidfVTM=KonQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/17] spi: s3c64xx: use bitfield access macros
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, krzysztof.kozlowski@linaro.org, 
	alim.akhtar@samsung.com, jassi.brar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 9:23=E2=80=AFPM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Hi, Sam,
>
> Thanks for the review feedback!
>
> On 1/26/24 20:12, Sam Protsenko wrote:
> >> -               val |=3D S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD;
> >> -               val |=3D S3C64XX_SPI_MODE_CH_TSZ_HALFWORD;
> >> +               val |=3D FIELD_PREP(S3C64XX_SPI_MODE_BUS_TSZ_MASK,
> >> +                                 S3C64XX_SPI_MODE_BUS_TSZ_HALFWORD) |
> >> +                      FIELD_PREP(S3C64XX_SPI_MODE_CH_TSZ_MASK,
> >> +                                 S3C64XX_SPI_MODE_CH_TSZ_HALFWORD);
> > Two people complained it makes the code harder to read. Yet it's not
> > addressed in v3. Please see my comments for your previous submission
> > explaining what can be done, and also Andi's comment on that matter.
>
> I kept these intentionally. Please read my reply on that matter or the
> cover letter to this patch set.
>

I read it. But still don't like it :) I'm sure it's possible to do
this modification, but at the same time keep the code clean an easy to
read. The code above -- I don't like at all, sorry. It was much better
before this patch, IMHO.

> > Also I think new patch series are being submitted a bit too fast,
> > people might not have enough time to provide the review.
>
> This patch set contains patches that are already reviewed or too simple
> to being lagged.
>

Ok, agreed.

> Cheers,
> ta

