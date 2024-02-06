Return-Path: <linux-kernel+bounces-55361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A87484BBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36EC1F2588F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CF679DD;
	Tue,  6 Feb 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRO9Oygv"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5F6FAF;
	Tue,  6 Feb 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240033; cv=none; b=hmrzY81Hu/xGygW2rnmUit6+GKXRWOZZ43wADxsS5zurX3F0mqmSyzhlcNS1tdzMDYZ8vamTNQCq6oLdnZ2sP9kIWxT98Gd2fMdeg63kXRPc43rKwAIvpNkzndKqodesZt+VTAs3xvQTnfaN7DcUfZr9Qz0CL+zA4FF/0h2bdUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240033; c=relaxed/simple;
	bh=48zwX4cdRuvFsDRvDb1OTWbijEmDQqwVQ9OKmCBLNqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHXTJnAIjvEd4ZyYSVdF7ZrOS5ojlG/NjDOCVDczddzZmVLrNd9v5dK7QFOPZj4Ha9ipBEXhTyoWOOuWQ8z5avc9yaghIUMDWGGrVOpThuNw9zzZepT1nlL6rCcNRCYDCkCukIGomVMXy8HCewgmC5Xg9o2UsHr3cyLQcKbCuLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRO9Oygv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso4420847a91.1;
        Tue, 06 Feb 2024 09:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707240031; x=1707844831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEpDIST9h9yaifs/R99eDIKxr1oKIOjzVlU8EGHsrRE=;
        b=iRO9OygvfUmP0MVmTSXOMyFMiMoSYx8u9fao8DJK4rtljnIWvokWiotfIcOrf3+21/
         CbtFwE4FwnmE58GJhz9OM/Rx3ZussX3pyFUInNC8KFNqLpMXtJ3pJ5aIWd1kSv33eIwC
         l+vnepCUxLcHE8Ywa9ENigumLs/oHEYiAkdxivPLVjYljRDVBXDPgcHfULekU48ULQih
         1Y7562AF+D0/DOybp0SDnU4GtoFyGA+KUtkFAqSWYCLDd689QOUdvmAMtNANtiJSbyZY
         UizttDIkEw2TnyEGGr0FQCLR6f2YrUitztAH7fa80euivIfUeJ9UMyAfvOgN+JYAHPyT
         iwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240031; x=1707844831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEpDIST9h9yaifs/R99eDIKxr1oKIOjzVlU8EGHsrRE=;
        b=t3h8sFX72nmx/2rZ0neXfIR67zkCXQpg0TEbqcxslOtkInUpDBpJDxEW6UmIQeaJBV
         XOMuzSe0Ss9LW67j0Rts5uSwSdzaxIry37PDDgPTheIPM0XVoPGpS2s7b74BsV7kf2YT
         s/pUVIhGHkl+8/MuFKJ2LaJIYU9ge03zjnPf68Wb7WhMzyZWkPo6dyhSAupWz/6zjCx2
         exqDbkKzlwf51kxoQmq6HMZLYCQsflGwwExVzXPbLBvf4Uusrbp0cx2lQtCSlYn0SYNQ
         v6VUKxAqVrg2u0ktVXrx2oSZCn/d0qam37puOMDZXaUC0C32f3x5iD0jvSTJMLyUpkcN
         xrBA==
X-Gm-Message-State: AOJu0Yx3lIRaS359UOcPizjvbllQpRlEJH+WaARO5Oau4EcNHKZ3SUfL
	AZZCvnvfvKHvgWDzCaFTC5txsB+sH1PAvVt2OPhJVlj9cK6dxnfUAaZkOfIIG/0Ot9ydBPGgdbC
	tcTZdYaJEjOs3hSaDLiK8ZPhQGA==
X-Google-Smtp-Source: AGHT+IEoplUefw7rvL8SQ+8RghCz5pebfVVsAA3lYam19JsCz3fVFmbC2KV6T5Wm+c0EM0HDyQ/JDPj7eO1TcHLgugE=
X-Received: by 2002:a17:90b:4c85:b0:296:2057:28c with SMTP id
 my5-20020a17090b4c8500b002962057028cmr175786pjb.31.1707240031006; Tue, 06 Feb
 2024 09:20:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205191828.998783-1-frut3k7@gmail.com> <fb9767e0-c5a8-448f-b3f7-e6f81ef008e6@linaro.org>
 <CAKEyCaAXqhzMbTQL8WhLze39cey_DuE-LYOrK+oitD=NiZMuTQ@mail.gmail.com>
 <7e2d927b-ce84-4939-8d0f-adfad2a3ef70@linaro.org> <CAKEyCaBADYxbU3XkJYv3WkZpJZ93nvfg+Zg2bvaViHCg47=9zw@mail.gmail.com>
 <70cdc60e-2f6c-49ca-914a-e28be4ac3714@linaro.org>
In-Reply-To: <70cdc60e-2f6c-49ca-914a-e28be4ac3714@linaro.org>
From: frut3k7 <frut3k7@gmail.com>
Date: Tue, 6 Feb 2024 18:20:19 +0100
Message-ID: <CAKEyCaBgrrUWCCnGOvYSP2ZvZDp+shTE3yOCCMcy_DD7xRaAjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: trivial-devices: Add qca,spidev
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Naresh Solanki <Naresh.Solanki@9elements.com>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, Peter Yin <peteryin.openbmc@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	Lakshmi Yadlapati <lakshmiy@us.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Fabio Estevam <festevam@denx.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 5:53=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/02/2024 17:34, frut3k7 wrote:
> >>>>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml=
 b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>>>> index 79dcd92c4a43..50efbdf2a735 100644
> >>>>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> >>>>> @@ -309,6 +309,8 @@ properties:
> >>>>>            - plx,pex8648
> >>>>>              # Pulsedlight LIDAR range-finding sensor
> >>>>>            - pulsedlight,lidar-lite-v2
> >>>>> +            # Qualcomm QCA4024 Multi-mode Bluetooth and 802.15.4 S=
oC
> >>>>> +          - qca,spidev
> >>>>
> >>>> There is no such hardware as spidev and you even mentioned it is cal=
led
> >>>> QCA4024, not spidev. Please don't use that name but a real name.
> >>>>
> >>> The compatibility will be changed to "qca4024" and a new patch versio=
n
> >>> will be prepared.
> >>
> >> That would be ok except:
> >>
> >>>
> >>>> Also, I have doubts that Bluetooth is a trivial device. Such devices
> >>>> need supplies, have reset/powerdown GPIOs.
> >>
> >> this is not resolved. Bluetooth chips are not trivial devices. This on=
e
> >> particular exposes several interfaces to the host, needs a clock and
> >> power supply.
> >>
> > Device is used over QUP4 SPI controller inside of IPQ8074:
> > https://lore.kernel.org/all/20231123121324.1046164-1-robimarko@gmail.co=
m/
> > I'm not sure if these pin settings should be upstreamed as they are
> > specific to this platform:
> > https://github.com/openwrt/openwrt/pull/14051/files#diff-ed3fbf0226fbdc=
76c9c160f2f2b9e988120df472480b9861abe7a46796558115R81-R111
>
> Why do you think qca4024 is specific to this platform? Judging by
> Qualcomm website: it is not.
>
Unfortunately, I do not have access to the documentation for this SoC.
Currently, even after adding support, communication with the SoC is
not possible. QAPI (Qualcomm API) support is missing.
> Best regards,
> Krzysztof
>

