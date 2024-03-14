Return-Path: <linux-kernel+bounces-103280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C0E87BD67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23781C21E9E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101F5B696;
	Thu, 14 Mar 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbExeOXW"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B996D5B200
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422086; cv=none; b=Lwq88C3rRAUZLfN1UMzob/v3LiVXtVqQ8CsBnQ4Fn8/fQXn6gJb7msTQasdjASOCC3QdZw9cpv+dMZfdl4jm6WCAH66CBsVYaNrnVnLGcXU0sawJlh7VyO0uIFxZKSgkQWKF72FJTLUNlkNGTa3HJtHqMEpVePViuASONW3QR6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422086; c=relaxed/simple;
	bh=nzs6zCI1jdSZw5ilnOs66b3DiJ+Gf76pVPexRiRqK7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3ev6ZFDjEd1YMOqNmPpmhQQhAkVWgIpVUoD1dVLEqu6z7QetOlCYEZBUtZQ/sTOjjiq20bT41DHEebqkpX/cWCIsCyKZXKkfGIWaku7mGk4Fhzm8kis59whOht27/CBByIcc8kw9AP5Sxg2qyer+cyF4g7BiwK5AT5yK8hbWNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbExeOXW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a068e26d8so10632377b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710422084; x=1711026884; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fkD0KnYDjnqjUj1tphaFuRIzplXQwfgK5ojv6GksvlY=;
        b=mbExeOXWboJjaCa3+MJDNvkDycW3WnS7LAgCFA+ETZWcjDuJUe01dOwfhbqJ8GHTiK
         eUl4AT/2414JLugozU+NuTglKzUQm6h2NJqtadjwqSV/MV+G0BWcnQVfkEyYH5oOl3ad
         jaBQvGr7jBp7Nv+5nIeesKqk5usYZfGNm7+A5skXqQaY1ZgOp+YFR+q3fnzmBMMR8kVf
         fCYeWsH6BuljNTJxUm0Q+7tFKQgSoRjAtd9hKAvkPTlcyYiaD2QG6Dg0Y8zQqmPqfM24
         sDkJVZninY99Nu/F+9dzUbpB5fcS977LehLkc/Ku4PJlgjTgD3Km4QK6Rl8FU7C2wg9M
         1vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710422084; x=1711026884;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkD0KnYDjnqjUj1tphaFuRIzplXQwfgK5ojv6GksvlY=;
        b=BnmarV8IiWJraiqj5kvb0HLizG/7qzULj4l+KGFEeQGqlE9VLnHIYJuwdLq6BMOgb4
         HEwahjrl8hGgYzEzr2F2ki73kNt2wCTJOJyqhZdFCLOUyi22ZazSxmbSk4z7Bjzqbwtz
         kQMNk08nIyLoDWd2v5fW9lAxKSr1xvyJrOeCH+MOZSaNXN2rJD2gBNbapAf37YFHfs5Z
         LqP0Ntt4gzT3mFATZpEDirgmqMFh3FwX9giTnPkJ9DuenoowpCp3Oo3K8wjDlKvzQLWd
         D4MhHy2aRnlJ6l6m08RdRc/gm+EFsCeLNhLHN7PjixhhGLtHDslfaQCoTRT0q5sWRRLH
         +qaA==
X-Forwarded-Encrypted: i=1; AJvYcCVFi4Z6QCDOr9GqKnp1kWhycXuUl1pmjRZl8WSrjnDixQ6NlNrpPtTSgrS5Hya4STQKIy58DRNuNbLCn7hk1J//9ZlkyJ74UmWGaShQ
X-Gm-Message-State: AOJu0YxdOVxe6bv+hUjD9qOU9POxsN/KM/mnYYU/+xZ0jnhJ1QFTbSsi
	6vMHokz5bZPq1v+Mu755r6egdLHO2hUq90EZJ5Q8cRsVAD5//uIVrUXkQ0vPcUY1AlClZtum3em
	TK2VNXaHC5mtYgsndiV5yM//XGZg9ZySUQgtD9Q==
X-Google-Smtp-Source: AGHT+IENdbs25prtdnXfRF19x+3DROxo9WIqwzwvi6gTNh98VdEaATL6yqgmxAYviMYew8QsBjhPAlhRMp6IcmuesAo=
X-Received: by 2002:a05:690c:6f88:b0:60c:d56c:2c38 with SMTP id
 je8-20020a05690c6f8800b0060cd56c2c38mr341959ywb.7.1710422083691; Thu, 14 Mar
 2024 06:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
 <CAFA6WYPh5BS_Fpi6ksAC7bwoFEyqjj1Y3EahyQxCG9Pp=KDw=Q@mail.gmail.com>
 <9dc0415c-4138-4867-861a-38b45b636182@linaro.org> <CAFA6WYPFfL18acdZt6O-_=LWnH7J2MooDuf9cA3JCaQZdoLhVA@mail.gmail.com>
 <CAFA6WYNo73S5ROHCMK0ZQSiU0DDbuDadptmaPL+GPCocE0h-mA@mail.gmail.com>
In-Reply-To: <CAFA6WYNo73S5ROHCMK0ZQSiU0DDbuDadptmaPL+GPCocE0h-mA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 14 Mar 2024 15:14:32 +0200
Message-ID: <CAA8EJpqxb39u=ShpcALa+M8Pj8fE-q2p6WzZA=HPLJ-47UH+qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	stephan@gerhold.net, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
	jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 11:37, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 14 Mar 2024 at 14:47, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > On Thu, 14 Mar 2024 at 14:00, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > >>> +
> > > >>> +             compatible = "gpio-leds";
> > > >>> +             #address-cells = <1>;
> > > >>> +             #size-cells = <0>;
> > > >>
> > > >> That's not a bus.
> > > >>
> > > >> It does not look like you tested the DTS against bindings. Please run
> > > >> `make dtbs_check W=1` (see
> > > >> Documentation/devicetree/bindings/writing-schema.rst or
> > > >> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> > > >> for instructions).
> > > >
> > > > I assumed earlier that W=1 is sufficient for DT schema checks but it
> > >
> > > W=1 as in make? No, it is not. It's flag changing the build process.
> > > dtbs_check is separate target.
> > >
> > > > looks like those are two different entities. However, I added these
> > > > address and size cells properties only to get rid of warnings reported
> > > > by W=1, see below:
> > > >
> > > > $ make qcom/apq8016-schneider-hmibsc.dtb W=1
> > > >   DTC     arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb
> > > > arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:96.9-103.5:
> > > > Warning (unit_address_vs_reg): /leds/led@5: node has a unit name, but
> > > > no reg or ranges property
> > > > arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:105.9-112.5:
> > > > Warning (unit_address_vs_reg): /leds/led@6: node has a unit name, but
> > > > no reg or ranges property
> > >
> > > Wait, so you saw the warnings and ignored them?
> >
> > Sorry but you are ignoring what I am trying to say.
> >
> > > These are legitimate
> > > warnings, although they don't give you full answer.
> > >
> > > > <snip>
> > > >
> > > > So it looks like W=1 is reporting false warnings and we should rather
> > >
> > > Warnings were true.
> > >
> >
> > That's was my initial impression too and I fixed them via following diff:
> >
> > diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > index 8f9cacf8de89..a366d3aff3c5 100644
> > --- a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > +++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
> > @@ -92,8 +92,11 @@ leds {
> >                 pinctrl-0 = <&pm8916_mpps_leds>;
> >
> >                 compatible = "gpio-leds";
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> >
> >                 led@5 {
> > +                       reg = <5>;
> >                         label = "apq8016-hmibsc:green:wlan";
> >                         function = LED_FUNCTION_WLAN;
> >                         color = <LED_COLOR_ID_YELLOW>;
> > @@ -103,6 +106,7 @@ led@5 {
> >                 };
> >
> >                 led@6 {
> > +                       reg = <6>;
> >                         label = "apq8016-hmibsc:yellow:bt";
> >                         function = LED_FUNCTION_BLUETOOTH;
> >                         color = <LED_COLOR_ID_BLUE>;
> >
> > But it then broke dtbs_check.
>
> See following breakage afterwards:
>
> $ make qcom/apq8016-schneider-hmibsc.dtb dtbs_check
> <snip>
> /home/sumit/build/upstream/linux/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb:
> leds: led@5: Unevaluated properties are not allowed ('reg' was
> unexpected)
> from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
> /home/sumit/build/upstream/linux/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb:
> leds: led@6: Unevaluated properties are not allowed ('reg' was
> unexpected)
> from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
> /home/sumit/build/upstream/linux/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb:
> leds: '#address-cells', '#size-cells' do not match any of the regexes:
> '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> <snip>

That's because there is no addressing for gpio-leds. Just use names as
led-5, led-6.

>
> > Are you aware of any other saner way to
> > fix those warnings properly?
> >
>
> -Sumit
>


-- 
With best wishes
Dmitry

