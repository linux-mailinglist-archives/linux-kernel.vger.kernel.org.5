Return-Path: <linux-kernel+bounces-83602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE9869C80
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15B38B32A97
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FD8148FFB;
	Tue, 27 Feb 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UziWEeKT"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55161148FF4;
	Tue, 27 Feb 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051374; cv=none; b=Z5Y/4gEYdS6z94HRY4R41UxnBNkaGLV6Ml5EN5Y7Dcj7u5SZkXYuazsN8WL51Al+kbNBdCfIJ92uZrn7H1rFNKB/ccTiEEkMPUU65Y417J5RULnoMR0LXT1yyoF/RfsbjXkn6vvxrx90fjplpGGKLAWPqszs/qd+6Sh3PDUKoUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051374; c=relaxed/simple;
	bh=HXzssYEYqtzr5qnD1CqK7udX2j/OUVEGL3tqoCbTsBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiTEYXledCZXAHVV3W6i9hnrDWrSU8tLD+jeco854JiqMTvNXKLTFzYjXwsRvlbdyAhxQIH5Isk8Swg3RMz4GqFl7djGtNSiLB/lj2TwRX/K4SVChBzvJfd5vcIHKoMBbaDq/3AqavcIqF+pwiL9s8ci0/ieVhTHcT2m4Zttptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UziWEeKT; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4396b785b8so176734566b.3;
        Tue, 27 Feb 2024 08:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051370; x=1709656170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+v8WkYj+V0jmQrnbBd89P9mj/CLIV68PxeJ4A/mdwE=;
        b=UziWEeKTqhOU5lAXQ666cgnXqS56Lcgr6ySjzWM9vGsdlAlu8107o/PrjH77+3mIjW
         z2oLJ/sJq9Ka0GfBDNKXvOuoJoVofHeTCiyMX4YZShhQTyiJ2wla/1STNk5f6WSxuwc6
         25mh7VJ6veHLifAVbsfY8IEefEIHkMz9gft8JcdyofBbMPGNVrIVLeHdTNYKmrd2ewM2
         zm+QV58Xgvag2x6Hpnu36AvjxOa0if7QX4mIJD6JH0/o7XqOKrF5V6fngCHwr0nK2JEt
         qK+GVgS3mm2U3/jLNFPRkCfT6dYijkV+dTS+FemO6mY2OCiFi7bm+SV4Xcuf4gXBf7lR
         rvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051370; x=1709656170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+v8WkYj+V0jmQrnbBd89P9mj/CLIV68PxeJ4A/mdwE=;
        b=JgcAzqkUFJh7sR77Xk7PZHger0dakMjfz84YLR5uLKnVo5mKAHqoXrZ4JGitmR4p+/
         IlX5Xe8uK+gzIaNFckqUkyvP/i2P0DiZOdnbvb1YT9NDYdeG5Hp2l7P/rdR+RGM6FFb2
         2wgdQFoZ/NKG7w00TB07Nohj6K9WyYGfPPmFXFkNGV4K6Vu6WdMAG6olYednd1Y5OyYB
         QbVMi8pMwj9qOPsRxvj6WCSs8yezIyZYeDlqDzn93ABDyXnRj6U+sTjiq8BHlMYHh/M4
         A9xBxSwSHscLEaNmKEPbFLIn096N3sVrDTCL7GNRuZ6FfIgLnx0SKZJQE8HJlpcEtvns
         rGQg==
X-Forwarded-Encrypted: i=1; AJvYcCWXMY8HvjeOoscGHi+GyZM03In5BHU41SuAN8qlYIGgFggPsbwtwkNivvAec2c9AtBX4hsUtuoQT76JUBME48sWwvITjptzBtz3My2oeXOPJZaXnjDWbwifNZ90O0zRlh3sR0dQOR2/OA==
X-Gm-Message-State: AOJu0Yxx1T0cJ3MBZCkdOKvnVCMmDRc2cw9140AeL1EQ2BS1/dsDRI2i
	M1G/bK0xPp8oFP7rMJnqgCXIsn9H+4u31boyk4kILG2YbLOPfj8vOL16rZFNKljUZZbAPAvpeZy
	ob8c8pmwWRo31hNW0NVgzitqHx4Q=
X-Google-Smtp-Source: AGHT+IF5cEV1+76NYOs+Omrynj4SA56WXsfZuwIoV5pmFaKXW0rXxBMKRAb+95kzbV3G/8fND+psJN9gkQVVzVm4zP4=
X-Received: by 2002:a17:906:f44:b0:a3e:a712:ba9d with SMTP id
 h4-20020a1709060f4400b00a3ea712ba9dmr7700879ejj.4.1709051370555; Tue, 27 Feb
 2024 08:29:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
 <20240227160952.615291-1-javier.garcia.ta@udima.es> <CAEnQRZDY5Jfj6d008goccsWwwUuUuryw1s8xJH6EyGXEiqnovw@mail.gmail.com>
In-Reply-To: <CAEnQRZDY5Jfj6d008goccsWwwUuUuryw1s8xJH6EyGXEiqnovw@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 27 Feb 2024 18:29:18 +0200
Message-ID: <CAEnQRZAvqHfNYu+dYObJA=T7S_KfQMxB8TJGmdjK9Ea_FPrLOA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: img,spdif-in: Convert to dtschema
To: =?UTF-8?Q?Javier_Garc=C3=ADa?= <javier.garcia.ta@udima.es>
Cc: daniel.baluta@nxp.com, broonie@kernel.org, krzysztof.kozlowski@linaro.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Damien.Horsley" <Damien.Horsley@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:27=E2=80=AFPM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:
>
> This looks much better than v1. Make sure you have addressed all
> comments from the previous version
> and add a short log under the scissor line explaining what you have chang=
ed.
>
> Few comments inline:
>
>
> On Tue, Feb 27, 2024 at 6:13=E2=80=AFPM Javier Garc=C3=ADa <javier.garcia=
ta@udima.es> wrote:
> >
> > Convert the Imagination Technologies SPDIF Input Controllerto DT schema=
.
> >
> > Signed-off-by: Javier Garc=C3=ADa <javier.garcia.ta@udima.es>
> > ---
> ^ this is the scissor line. Here you add the change log.
>
> Changes since v1:
> - re-written the subject inline to include relevant prefix
> - removed header file as it is not used
> - ....etc
>
>
> > +$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Imagination Technologies SPDIF Input Controller
> > +
> > +maintainers:
> > +  - Liam Girdwood <lgirdwood@gmail.com>
> > +  - Mark Brown <broonie@kernel.org>
>
> Please do not blindly add people here. The most proper candidate for this
> is the people who wrote the original file.
>
> Using git log we can find Damien.Horsley <Damien.Horsley@imgtec.com>

Looks like this address bounced back.

@Krzysztof Kozlowski @Mark Brown is it OK to add a mailing list as
maintainer for a yml file?

