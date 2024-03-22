Return-Path: <linux-kernel+bounces-111460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F031886CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92BFD1C215FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530F45BFC;
	Fri, 22 Mar 2024 13:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksAuSmKp"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538EE446DB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113599; cv=none; b=pb7IvtXvXgifoZ9jpfQbbSZzCRRTaswy9lJ9S8WxB5aUcptXo0GN2bReGKCGgW/XFmxF+20Rx0Q4LHwyYpO9zHL+iBg0qcHlIfmSuWxVmdWNRmRtQ+Dc22QdS5/0/QxKJFBFdJWY/GFJ5jsPNnYvTmUOIRb+sBHNVjNkhbB3MCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113599; c=relaxed/simple;
	bh=YAAwhajDAShwntv7VTSrLoQpHcAhajmE3DG47Tw9EbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8h5HAAQ9uaPDFbJLY9HEzcFfUA2QDejcJU5UcjWNKDqnJcLGY2RloRs25HqwcTp7C5fHzoezKMEbPsytRz3DQJIOFoWLFcmJqmbMzEFMlZTwMKeTvu32FjIgTgEN3wiYDMpb33rsHHzMtCc5XT0BLwPmwe/TD5YDJ5nI4Ag4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksAuSmKp; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-609ff069a40so24016997b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711113597; x=1711718397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T78z1nOSwZno9foTloy4dRS2ODcsdxPFmoFq7VTiovc=;
        b=ksAuSmKphs3bQQ8uTYv7xuU56fGhh9+8pHhCrSCz7Sqp9S/goGvzf0I/ACui2Pc0oI
         3XwMy3rw2TIqREYT9tYf1IVjEvcJ4DQ1B+KdjkkCslfTqq9rCDhuQo4ZZRoVoPR4+zGT
         ysEwZiX6Txp7+8/XLPg6u8b5CKtrdpXP07V7CbQ+QTqJvCnYvQknjbKWBPcBSSem+86b
         jpU+uNL0TRXHXI7nKh6FRscRnEeN6vnL6hOy70M3V5/iRe5CX6KoHlmBIUhr6A60/B4k
         02PIE3JY3jEvCuN6Vj91nAv6TTs/GTFXfLwoFTrspw0jrXilP50ETzIh7PxR2GL+kZZF
         QjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711113597; x=1711718397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T78z1nOSwZno9foTloy4dRS2ODcsdxPFmoFq7VTiovc=;
        b=oPk/YmmQ3sYA1kLQiRvA0lfqp8EybVeYjAoMujQEZpUi/YIlfHw8lcqSq4aGPDOQxL
         11bBQCHe+TJBxB0T6RFUPTlJcyds1Qu7EhcVCv5G+EMrOEj3H5i/eCpd6wyr+hsunPsm
         FFeMH5t/aaIeG+ViUjvZSWJvW5b1oHZHrlhdIDgV3oNTAq8KXJiB3paaeyOrjLEHZcuT
         uz3IGwChYiIWZj7lShgCAPYUMVFvZdSSnOXjb2fyvLplPOcVS9j14/Kuvs1/1zqDzU7k
         IdaCvYJYkYkz0RB/6lEztJU2C84eyuzwbnBdvYy3mxp95lEheV8GbkHAEJtQzMO9C8Ss
         Wt9g==
X-Forwarded-Encrypted: i=1; AJvYcCUweaLB2ax9fX80OZTpXRUTKdzMmYe06xuFSrYrF9VxTld6St2WQJHsEMmwTyqPsTN5OfGHDUNRnTOTdgqnOQYBUtmfF/ZTHpNRrXIn
X-Gm-Message-State: AOJu0Yx3/LF/zyCS5vJoFcBV1qA1MZgUu8z2u3mLo5amdxG/2C3H7JqA
	cm7k4YYqCeGDDjtCuhu6fK/xzCeHcVLU2EoBDqCXpqjztrGHTAPNsVyyWqLndSi+tipmigJEalM
	3QBmHj3LteztzBp6xWo1qN6cx8F9ZnVHf7pMp/w==
X-Google-Smtp-Source: AGHT+IG+SZfQK1DL1hghh4bEZkeXinAkbG2OAt0nX5blt+D+l9hJLR0PHCZqRRAPCLeNeeuIOd4XZSMRS4sju+TapJc=
X-Received: by 2002:a25:b227:0:b0:dcc:f0a:e495 with SMTP id
 i39-20020a25b227000000b00dcc0f0ae495mr1995183ybj.3.1711113597315; Fri, 22 Mar
 2024 06:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-typec-fix-sm8250-v1-0-1ac22b333ea9@linaro.org>
 <20240322-typec-fix-sm8250-v1-2-1ac22b333ea9@linaro.org> <635f7501-82cf-4df1-9194-27f24eb40a53@linaro.org>
In-Reply-To: <635f7501-82cf-4df1-9194-27f24eb40a53@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 15:19:46 +0200
Message-ID: <CAA8EJpoYBsB8kx8P9w9M3pd6E7iUfqWk4XYwMr2oLoZV_nuYpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250: add a link between DWC3 and
 QMP PHY
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Weiss <luca.weiss@fairphone.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 14:11, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 22/03/2024 11:58, Dmitry Baryshkov wrote:
> > The SuperSpeed signals originate from the DWC3 host controller and then
> > are routed through the Combo QMP PHY, where they are multiplexed with
> > the DisplayPort signals. Add corresponding OF graph link.
> >
> > Reported-by: Luca Weiss <luca.weiss@fairphone.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/sm8250.dtsi | 24 ++++++++++++++++++++++--
> >   1 file changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > index d57039a4c3aa..e551e733ab94 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> > @@ -3917,6 +3917,10 @@ port@0 {
> >
> >                               port@1 {
> >                                       reg = <1>;
> > +
> > +                                     usb_1_qmpphy_usb_ss_in: endpoint {
> > +                                             remote-endpoint = <&usb_1_dwc3_ss_out>;
> > +                                     };
> >                               };
> >
> >                               port@2 {
> > @@ -4195,8 +4199,24 @@ usb_1_dwc3: usb@a600000 {
> >                               phys = <&usb_1_hsphy>, <&usb_1_qmpphy QMP_USB43DP_USB3_PHY>;
> >                               phy-names = "usb2-phy", "usb3-phy";
> >
> > -                             port {
> > -                                     usb_1_dwc3_hs_out: endpoint {};
> > +                             ports {
> > +                                     #address-cells = <1>;
> > +                                     #size-cells = <0>;
> > +
> > +                                     port@0 {
> > +                                             reg = <0>;
> > +
> > +                                             usb_1_dwc3_hs_out: endpoint {
> > +                                             };
> > +                                     };
> > +
> > +                                     port@1 {
> > +                                             reg = <1>;
> > +
> > +                                             usb_1_dwc3_ss_out: endpoint {
> > +                                                     remote-endpoint = <&usb_1_qmpphy_usb_ss_in>;
> > +                                             };
> > +                                     };
> >                               };
> >                       };
> >               };
> >
>
> I think these should go into platform definitions, there's nothing at
> the SoC level that imposes the port constraint.

The link between DWC3 and QMP PHY is fixed in the SoC, if I remember correctly.

-- 
With best wishes
Dmitry

