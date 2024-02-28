Return-Path: <linux-kernel+bounces-84254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D706C86A437
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783C21F24985
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F69C2103;
	Wed, 28 Feb 2024 00:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTf+tThp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8D3184F;
	Wed, 28 Feb 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078679; cv=none; b=PHM9AIsdRoxqgrpfGognPHelrmWXKJqGEpxyd4zHi1564EUcQIdJ0zNSr0nrDjfnHF3F64fqeJUrbxBvZeZnEUDIseDWVgQQS+HyS8iqXeZIUk0Z9mkL7F5JxsrMDVmWPE9dfKRcsv9r8ZFi+40iLiWDR6vykgfSHfqV76hXS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078679; c=relaxed/simple;
	bh=JGUgWS4grQla5O7HdEiyj3k63HrCOx5ncAUPSxH5+bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kk2CGH86guxc8LTgxJ43wrgoGDQdzztL23Xy1B4SIUr8IbfwBvHp+V2ftFZ41xqWRC/smE5FceW5sil+l/c/QoSUR/uiza43a9DtayTRV/5o7zmGenGlXNS5Yy0tqg7TjBT0sh71x/HDTNFAWBUYOqgq0/xNr7MnuJa0a6u4E8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTf+tThp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a437a2a46b1so275921566b.2;
        Tue, 27 Feb 2024 16:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709078676; x=1709683476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGAsf5cgvi4hUcPvX6gI5YnLh72rWWc63kIQDyDiu9Q=;
        b=MTf+tThpVGrJdwGtpMVfoBVNq9uH+eiSbu4c0aoxaO6nqvxKVaUZqazzwgbUI5S4vB
         kdNmwBecgiUWQctuIUnrIPV1aG1WP7uJLk4UAnOUdtxLXqKLu0i/BmUyKKWR5spunF6k
         lJk0bDYedqnuiOvpO0a4gPl1wqIyI1KB9X4+KmN8DIaXZnWBNHg3gdfFbvvmQE/Z2E3q
         WIbLNmE6bOord8Cz6sEYlcsRbscYhzj2VQf7QdkjY6bc4SnT8RWrXzqepyhsNSuxOBd9
         2faGP24LtEd42fvZ5w/Ydj2MFDcylvKp7MIveS0GziMSuOv+4n/J3VSefMt1zcvosrGy
         QaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709078676; x=1709683476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGAsf5cgvi4hUcPvX6gI5YnLh72rWWc63kIQDyDiu9Q=;
        b=fFm8k6G5H+Px9p+bkhcEPQW+RHS7IEJ53KZWI4iLBXLHbOlhVe0REWKRv4+bR1gsUL
         284lT+gC92uNoPPE569HsqB1nfLl5HBDLAkoN/fXVoL3+8SRugl3n4npdF+UYwAvdvrg
         ji7+05vwShEQ1WSfJz83Qzpde58LE7afp8+m+anUZLhV+JXnLonjKCBRcHlqz8LezCYC
         erdKnIp4UQhCOYAA+YMbVr7wPmblujaRhL5LvDfF/G8WGO1L+m1CvbcZ75iXjw16oMce
         TlEM1clxY7ymJTyo1N2sLg0ziL51FsL0dc23orAG/AKiqTs5kep99wsxf9feB+xBey2T
         iIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu7WV4w7ucdq06LIODGa0wkiijC2IPZ1S2BSoaf3rB0hB7QOJcyMufyeaA9w5s7hfqMx2a76SdSfJiMRpH7NnZIW4YlvgyE+I/UBxOT85iPKJ6XfJMOO7Dn1hgqMU2ooiKVsSq1WEVMKKKRpLpA6eWPWqaDBjXSoR29ES2rpkISRiDutY=
X-Gm-Message-State: AOJu0YyQosQsVGy/SxmGgrxIjxhnwChZJkKrY8x/jM3R29LggjS5nZUr
	8POr/rLHxCuY7J75bNOFU957gEDqK46iOmBD/QjiTDJKSzei9RNGR02zJi6OmddGkHaxEsJT2L1
	FgoFALB6AD8exoOTQkYl/RWPc9iY=
X-Google-Smtp-Source: AGHT+IGXLgvtICyW0r81gWFgD3HrWKOjnkobiDubKg4V9DdmTC/M0dtG3PZq8BTs+ZginsAuk4xm9JsdwYJtrkb5tpo=
X-Received: by 2002:a17:906:1cd4:b0:a3e:5993:96e9 with SMTP id
 i20-20020a1709061cd400b00a3e599396e9mr6993567ejh.42.1709078676009; Tue, 27
 Feb 2024 16:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227212244.262710-1-chris.packham@alliedtelesis.co.nz> <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240227212244.262710-3-chris.packham@alliedtelesis.co.nz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2024 02:03:59 +0200
Message-ID: <CAHp75Vdi2c=s_z9wwxWzVcL+4tx5ZnXymbiN4O1FS+D3kz5vqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: auxdisplay: Add bindings for generic
 7 segment LED
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, geert@linux-m68k.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch, 
	gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, 
	ojeda@kernel.org, tzimmermann@suse.de, javierm@redhat.com, robin@protonic.nl, 
	lee@kernel.org, pavel@ucw.cz, devicetree@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:22=E2=80=AFPM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

..

> +  segment-gpios:
> +    description:
> +      An array of GPIOs one per segment.

This is a vague description. Please explain the order (e.g., LSB =3D
'a', MSB =3D 'g'), use of DP (optional?), etc.

> +    minItems: 7

maxItems?

..

> +    led-7seg {

Probably it should be more human readable. DT people might suggest
something better.

> +        compatible =3D "generic-gpio-7seg";
> +        segment-gpios =3D <&gpio 0 GPIO_ACTIVE_LOW
> +                         &gpio 1 GPIO_ACTIVE_LOW
> +                         &gpio 2 GPIO_ACTIVE_LOW
> +                         &gpio 3 GPIO_ACTIVE_LOW
> +                         &gpio 4 GPIO_ACTIVE_LOW
> +                         &gpio 5 GPIO_ACTIVE_LOW
> +                         &gpio 6 GPIO_ACTIVE_LOW>;

Dunno how to handle DP. Either we always expect it to be here (as
placeholder) or with additional property.

> +    };

--=20
With Best Regards,
Andy Shevchenko

