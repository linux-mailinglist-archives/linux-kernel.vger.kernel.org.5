Return-Path: <linux-kernel+bounces-55059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F1B84B702
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150C61C20AC0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EE5131752;
	Tue,  6 Feb 2024 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUBk4Tp+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C01DFFB;
	Tue,  6 Feb 2024 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227743; cv=none; b=KebRyaLfSoh1ZYOZi4NBVjRmRKz1SAaMgrIrzMnQZ/ce9mPR8HV1/1pIyNYbJ8gYaVQvvz0ZFga7J9wk1pn9sQOLC37bratoKFsAagev+T2HpmhYcze6t60TL15DTTDPANzao4F0vDX2iOnxiwAWBW3QKKhah+kjgvBUswb7434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227743; c=relaxed/simple;
	bh=NHm0CaGPvl7QRtoPx9ZdauKLwSadbIEpR5aSnSh0Ocw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hERqQ3r90MEmh2LxJo2Mb3hGUC65Kh8eFsB8DNdxVz9BR7YYx4h3cAfsT7/5PDknNScXy5OPpQ5QEVtJE/ClG3d/pxKoRhXv3Q2+F6DF/m1IbqVdsOO9cGLedMZ0hEKRnhGPQiZ8n56chqj6sHhIvr7J7bkxJzyQBrQL7rAUNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUBk4Tp+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e02597a0afso2393342b3a.1;
        Tue, 06 Feb 2024 05:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707227742; x=1707832542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiKhd+IF+PohxjtiTJp6AsTR6pYMx+iKQC+3ZmbqxLI=;
        b=eUBk4Tp+GNbx6zyqoGuinamZ6cY9nFo5hR1bhgimhslzobEAvvh7QXHTW+5Pie0s7I
         rSaOJ9n/6Xa/+o4r7PByiBgoWbAlaynkUuWM2q6h30hI7aBsm0mWMuQ9aqQulUypjvLQ
         EY1B4vngp0PgzI+rEGdLdPjWq6S1LjKNUUaKmc4HCHzYcilaO0R/ecnR1T+XcraZ7Bdj
         HZ8eLd5sUjLVtnWnTcKg/ieYoBtMXDzK8qjtuKqO9wTEqGtwqipmb2vc1c05/HPYQlQI
         aTEgwiYwgDTLTJCIum2a1xwUk7cTJ9a+49YnxYxoH8dDTZFRhfKGtLeUvO3gJXq5kqDQ
         hfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707227742; x=1707832542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiKhd+IF+PohxjtiTJp6AsTR6pYMx+iKQC+3ZmbqxLI=;
        b=s8tb+/LFut1mobirIR3t8SfbvdPmIgrPidQlcvZrn57ORPiqLoAn+n6ObT/Z8C+i5W
         VAT7d+R4ShxrGC+J/fAXWDQooS9fA2JDGGUBDcE8qB7BWDOq2rfvNvJno7XIGbFnRhiS
         XTJFdlwn2TqtmMJeHFjU3KYTer4RCkTrF9B6+UwtVtJDhCWjR3Dd6GCE/z1Tw1FyL7pv
         TBFnBmhD6ZiFYl9uPIPA2VhW3DTyQ1VaEO9SBRv0Q8/ommZtdUgBKzI8uqWn/Eu38LSa
         KHT4j8dgR5Jwol/LG9DmyuP0PngIZk3MNLzq/6XwYjVnWALzcr31g3D5PnyLGoWd+GcJ
         WOyQ==
X-Gm-Message-State: AOJu0YwrammF15SR/N2pbZf5nWnIr3oqJR8UofKG8ZwoDvf/82UkdbhJ
	ZZL42GljlYtnX0mMomnH/zhWtw2sFfpo99QkwM7N/ZJMA4U9vyJaCNfR2/fiSJ0+3WBV3YJXT6H
	zaNxaq5uL/CebiJiMZWTqfO8czg==
X-Google-Smtp-Source: AGHT+IGTxhbGpOwxQJKNFP0+tB++vCp0gI0VXvgYtL6kC0+C1Zy7/z4Kn6sNWG1tbZhPaCJ+4mOGui5wLwrSW9lMzOU=
X-Received: by 2002:a05:6a00:d77:b0:6e0:53a2:9690 with SMTP id
 n55-20020a056a000d7700b006e053a29690mr2652865pfv.18.1707227741599; Tue, 06
 Feb 2024 05:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206132111.1772867-1-frut3k7@gmail.com> <2a78bdf0-bb9b-4c1c-a4f6-2314ef43dc00@linaro.org>
In-Reply-To: <2a78bdf0-bb9b-4c1c-a4f6-2314ef43dc00@linaro.org>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 14:55:30 +0100
Message-ID: <CAKEyCaCGOk7viSEz7=+tk7uYwA6_tLnnvQZ1VipndROKh+CgRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Peter Yin <peteryin.openbmc@gmail.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Andre Werner <andre.werner@systec-electronic.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Lukas Wunner <lukas@wunner.de>, 
	Fabio Estevam <festevam@denx.de>, Alexander Stein <alexander.stein@ew.tq-group.com>, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 2:22=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/02/2024 14:21, Pawe=C5=82 Owoc wrote:
> > Add Qualcomm QCA4024 to trivial devices.
> >
> > Signed-off-by: Pawe=C5=82 Owoc <frut3k7@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index 79dcd92c4a43..50efbdf2a735 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -309,6 +309,8 @@ properties:
> >            - plx,pex8648
> >              # Pulsedlight LIDAR range-finding sensor
> >            - pulsedlight,lidar-lite-v2
> > +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 SoC
> > +          - qca,spidev
>
> You keep resending the same ignoring my comments. I don't understand why.
>
I'm sorry for that.
I forgot to send this originally to the spi project and now I have
mistakenly sent again.

> Sorry, still NAK.
>
> Respond to comments instead.
>
> Best regards,
> Krzysztof
>

