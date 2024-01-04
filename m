Return-Path: <linux-kernel+bounces-16509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA56823F80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB0E282764
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0420DC4;
	Thu,  4 Jan 2024 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3hD1lil"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0C420B28;
	Thu,  4 Jan 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204df0830ccso253335fac.1;
        Thu, 04 Jan 2024 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704364483; x=1704969283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fS/Q9GVBRyVKTadPh7mSSJ4C5FDOro6DyfomCqB3lUk=;
        b=U3hD1lilzFA0MIr5avaKtQv5KvVt5rCrQDcwLJll2Z9/gGK2OR8LZWRJcfqTet7VrJ
         l50X9h/xLu3WhV/JsPlmpl+tTXX4pLW/XQB4XICszSTcNBgWwjDRN5RBsgNILAzerkYk
         KsGDQQtLPSV/bURaiDrStEP5yE4rIy57rCGQ2i1/4Vn/0fOVgE6Cdesa5u2RhPMl3jsi
         dpYP2bzX5j4slqNRYOC15AeTTG/VE4xVgQ7wAkBecmvV8LUpctYiaBiepJv+B9os8GyZ
         ZOXWJMHcaDVFNwHPG7JsefnxxHOeG4573j944Uo3G05Zn7nmkvtjl5gYhJdMupHNiaxx
         p5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364483; x=1704969283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fS/Q9GVBRyVKTadPh7mSSJ4C5FDOro6DyfomCqB3lUk=;
        b=wG5By7E+z4jm0V3VrZnEGNr9t/TyZ2R0mGtDNPTqUnq847lBxKCvs5bhHyJjblajBe
         WO1BdLN4Hqy94zUXmCLBVdBL8nIpHTojdtem+nreAr7KjMI5tzDdf7zrODOJN1fKCRyS
         d7LwlP41sBID1jiN93dAjoYZMUxziIuT8pAL8+NZzWMqnY8E/VZBWyf9QcLC4LhaZKLZ
         bifaejAYtGPCT0b+fkEhCv48na+Iv+LyDZ2lfZeHInTOTMn+ooMe73wHVV10lBX3GOtY
         IMiy1c1eqPMoK7yoWAitvAsYvv2o020pqbNA0tmh4/Hw+kyQtmD52W4/PPVeCUsY4D+B
         M36A==
X-Gm-Message-State: AOJu0YzAcnMa0WguGhf86jwSccPktjru7NOgtRThn1rxr2FoMXRCttPM
	7xwwr9uqXlgx+uX6HWU0Z2oDvkpjA1P9WVVmVKU=
X-Google-Smtp-Source: AGHT+IE2tgR1X/gyhHMsmwRS5MbhKev21ngS0vyt9Oeqr9406leou2qM2IPXgJCx8/5X5ZnGKBUYa6UehjNKUrKP7P0=
X-Received: by 2002:a05:6871:a908:b0:203:64c3:7b86 with SMTP id
 wn8-20020a056871a90800b0020364c37b86mr372875oab.44.1704364482541; Thu, 04 Jan
 2024 02:34:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-2-qiujingbao.dlmu@gmail.com> <c5f7571e-8c99-4143-bfcd-cfd5b08329a9@linaro.org>
In-Reply-To: <c5f7571e-8c99-4143-bfcd-cfd5b08329a9@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 4 Jan 2024 18:34:31 +0800
Message-ID: <CAJRtX8SjutyeA29zvkHR2LmoPF0BSWSVVg44MOGqzn5znOmQVw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: rtc: sophgo: add RTC for Sophgo
 CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:32=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/12/2023 10:06, Jingbao Qiu wrote:
> > Add devicetree binding to describe the RTC for Sophgo CV1800 SoC.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> > This patch depends on the clk driver
> > Clk driver link:
> > https://lore.kernel.org/all/IA1PR20MB49539CDAD9A268CBF6CA184BBB9FA@IA1P=
R20MB4953.namprd20.prod.outlook.com/
>
> I don't understand how binding can depend on a driver. This is very
> confusing and suggests you write binding for the driver, which is not
> what we want.
>
> What's more, I really do not see the dependency here, so your message is
> incorrect?
>

What I mean is that clk is used in the following example. In the clk
patch, there
is a macro definition that can be used to replace this number.

> >
> >  .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 40 +++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv1800=
-rtc.yaml
> >
>
> You have dependencies between patches, but I do not see this explained
> at all. How people can figure out merging strategy if they are not aware
> there is dependency?

I'm sorry for that, I will add an explanation in the description.

Happy new year!

Best regards,
Jingbao Qiu

>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

