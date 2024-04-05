Return-Path: <linux-kernel+bounces-132848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214A3899B27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF58E281118
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C416ABC8;
	Fri,  5 Apr 2024 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGWwebyO"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A6618659
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313981; cv=none; b=uyiGcXXJ6WcaYUv1MOaRHKbFwXP+8hrRxMs1KYxciGtxvJO6CfgHVJAn9mDAUZgtCP8cnZiwiEJ+XxhDrS5KgRVCUd1zPpbVMDOkWAtwU3capg63paSZdzffQdqvhL8u8ei+w7Dyyh0d9CXdBkw7hTjjQOzbYswrX0kiSMd3t/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313981; c=relaxed/simple;
	bh=L4E8p/GV0Ds3nAyTGC7XhelVlzhjjV+Qy3Ty0PI9xhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/hUV5576zHFcThiEe6DZ7jF+hh1G44Fh6+thWaCDz3d3V1CTz17jzCrbTPDAsMtHw0wCLg04aafrV47AgFZelyKnuNQuD2EV+Ye3mtbtlPC46YUZN9LNAFZ/AbCKaitSB19xeXMRwIrnRXQor1fQFDOZwicIKsbZzlw4CovC1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGWwebyO; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc74435c428so2025717276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712313978; x=1712918778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q464s0pydIE+zRv4fDUf6M5jc7NXRIaMdUPXgVeAtAQ=;
        b=GGWwebyODwX1q83KcA6XibR/TAUUryUs9RAXB6qHCP44ebWZzZS5aIXNPQWAxE1AO7
         gYKsazdPwfBfDJvbTpgXc68DiPMoCz+dqMq9Q0M1hIaJnwpCyA9SrtkIubiAXlCAMcsS
         78goY38sLNRvBNY95rZKbN0OHqZytgDZd+TFDwzZvnl6+F9Nvu3hDdFSvn/ovsPPgNkm
         OI6GYMzBW4EXmaee6BavjZ9WetJnuyyzm1Hm4oXdkWhqAlr93wPkIbuAb8bvH9ofV9qt
         gpwBNontvPPV6cDagbQqe7sMvoItWqAjbq/YWvIHiu5HYF6PabV77Yavag1P+VUnamnX
         Hadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712313978; x=1712918778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q464s0pydIE+zRv4fDUf6M5jc7NXRIaMdUPXgVeAtAQ=;
        b=ep2V44qQjr79E9x6WRft+EZCfJ73SAsp2GAcPt3cjqql+7ngIgmzkncQz1vpfQZS/z
         6YpTKRwTNDQtZZsEJQIxtoWhY5c5IGekGKRGBM+jJK271Iwk64VHJTFB8WB1yrERKrWy
         Z3DRTJz1p6Y5ifa+RLey6amLqRDBg0+CpV4rHk12Uy/MXG869fPLHbAsLmTYIY+0KiMO
         iQRphfOx07DX06EhXK81/lGbdbyRyMa9RD/Cdcqyhb4yDZsFZkTCPL4EUItd8fAWYZ7Y
         G6beyC8TEQr1IPgQ84ZCglxNBeCX/GpirVkaeT658tVlS+I9UZBAvALu/Il8C7EZ8fkR
         /0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCXdSroiRGLgOka1viAeeR5ZaChUfirw1hB8SoWNg8jcD6JQHVnrUrhXGp31BPPtl7deaP+qoKrQrT/9wTfPuJzYprr5S3O4/waPxjkG
X-Gm-Message-State: AOJu0YwGPODI9V7s1FHauuaGa34Jj0NMowM7yc3r2LVNMtMyMFgn2Gjz
	0rSGiPWEewWd83ioGTgq7kCiavwnlevSQMlpsKVv5Cz7GwQI2juh9ucpmCsxabNKbfxuAysnZll
	x36uOwyPObVrhw2+Axrwv4FEEDFvsSbT68M3LWA==
X-Google-Smtp-Source: AGHT+IFD4lOAA6OE545MWaALDTv8kewFB0UhOTHwNBgdOdA/c4Xh5GLbUDrWS+o4QO2az8mbVpwytUQzz3UDkLFdfw8=
X-Received: by 2002:a25:bc85:0:b0:dcc:44d7:5c7f with SMTP id
 e5-20020a25bc85000000b00dcc44d75c7fmr782319ybk.62.1712313978067; Fri, 05 Apr
 2024 03:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404084631.417779-1-quic_mohs@quicinc.com>
 <20240404084631.417779-2-quic_mohs@quicinc.com> <CAA8EJpqWaYhzPKgTREtJnfdNZ4oSFZaRFM7Jhg+qd3AqadGOkA@mail.gmail.com>
 <797d67b9-9e09-8b84-9abc-dd4a4a2a40f5@quicinc.com>
In-Reply-To: <797d67b9-9e09-8b84-9abc-dd4a4a2a40f5@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 5 Apr 2024 13:46:07 +0300
Message-ID: <CAA8EJpo2__vcpqq1zofyyZ6UwPPn7Ed0R=TPcMZ25+JHwRExwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCM6490 snd
 QCS6490 sound card
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@quicinc.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_rohkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 08:56, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
>
> On 4/4/2024 2:23 PM, Dmitry Baryshkov wrote:
> > On Thu, 4 Apr 2024 at 11:48, Mohammad Rafi Shaik <quic_mohs@quicinc.com> wrote:
> >>
> >> Document the bindings for the Qualcomm QCM6490 IDP and QCS6490 RB3Gen2
> >> soc platforms sound card.
> >>
> >> The bindings are the same as for other newer Qualcomm ADSP sound cards,
> >> thus keep them in existing qcom,sm8250.yaml file, even though Linux driver
> >> is separate.
> >>
> >> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> >> ---
> >>   Documentation/devicetree/bindings/sound/qcom,sm8250.yaml | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> index 2ab6871e89e5..ff1a27f26bc2 100644
> >> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
> >> @@ -29,6 +29,8 @@ properties:
> >>         - enum:
> >>             - qcom,apq8016-sbc-sndcard
> >>             - qcom,msm8916-qdsp6-sndcard
> >> +          - qcom,qcm6490-sndcard
> >> +          - qcom,qcs6490-rb3gen2-sndcard
> >
> > My 2c: you are adding one soundcard for the SoC family (qcm6490) and
> > another one for the particular board kind (qcs6490-rb3gen2). That
> > doesn't seem logical.
>
> The qcm6490-sndcard compatible for enabling soundcard on
> qcm6490 IDP boards.
>
> Will change compatible name as qcom,qcm6490-idp-sndcard.

Any consistent way is fine with me.


-- 
With best wishes
Dmitry

