Return-Path: <linux-kernel+bounces-103036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDA787BA34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 397ECB21CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852416CDB2;
	Thu, 14 Mar 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2Hy8y9I"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777B4D9F9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407841; cv=none; b=tI4C9MdXCNB6W49WNHeoltBCQvbxxH/c/RvZmYsB6gmSbd9Cr1gUBWrlbgWMSk/jN00PEJ+blD+aWvBiOoVjaIpUW9E+OPrGgOsO2VdPSm+703q5xFPMIut6qd74iEy3if1p9VUsNuwm7M+guMrZtXaSTbXDo6mgATPcdB3TOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407841; c=relaxed/simple;
	bh=qep5NbVdm4qe88UZ31aM1yYAlnMDcjEZfqmlKMPlOGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBWj+LGO/rJMwEH5IML003h01Um4DPXohTLSICVMF0BfCaw8UnvfOFn+B9wR0FtZ/MAYw8YVfJsiIpuHhjpAGy4wgHqFWpEZKu7GXxBwQzrCXIGH5cE7RApNW35GFjhhUBAh6+MvnEI+xHcVntYIe6irBRJTGK1qr6swMI3Z330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2Hy8y9I; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7de1f4be3f1so74755241.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710407838; x=1711012638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WfWk4XBcHwwmI2jSyNvJBltXJUJKtcGlGvyxd2OQIgg=;
        b=b2Hy8y9IryrN26x/oLEekdVWI+uawX+kzilXm3bH92KxiGvP+X588GGmzCDP3tffkf
         Bv+JCM55M/mmIEobEG2MxQOn20A7JEfHBTDXVjlEDTCnhDrzE6vozfS4NytVFYvAkZHv
         L+j1WpJiEjjdBh6pV5St4o0h4k93su0FRlJq5YhejAkKgoh5JBSOhxZxpI9L1imrS8IC
         8PepUGXjAG9pOv2DNrIT/1oAHkJSUUTYyM/u5OxmvrN0/cfEJoOrZEKqSeoMSskqV4Wx
         0iK6dLxApWEsYhC8G9LJmN3r28TjkoPkOGFKC190joblep3pFOQWlXw1hLreoU50KjU3
         kp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710407838; x=1711012638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WfWk4XBcHwwmI2jSyNvJBltXJUJKtcGlGvyxd2OQIgg=;
        b=GANl6ob1BtfE4EhNWnOrN3KoTQuce2nd/DiwtAMlSTcvKNwrjhjHD22/x5Z5Rokhkj
         k5rnjcWYIUTD5wkJJcxczlF12hW88Q6E0Z9am9ZmwCSPjMBDXTmgL6IhUPkteWkMLYPv
         umHF3eSy6JTgN7PBlWXfUwARA6SSf6WVVoqMaKMcEjSrwPTvSP1lCHOgRIScYw+fwNuF
         3rKiLt7h7yho0uxjXCIf+jZtEmePuu/frs/8NCbMZwGTuQrI3fXquwVpepByEU97wnuf
         sjb5Ft37zw/fVbnflBL5FM8gSDP3Sa8kH8rAXjIlVztuMvs6SO6+pC0hJ7jYDkKfhvfU
         oLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/7GZ9hy4Jvh0GqPpZ7EOuBpmQhMB5fo5HGw9KQEbKy6xt762DH0qL7Qnl/8ufTfUFe576QKrvH0m+VZ4lGckY+uGZ/cFYAVgtRPXK
X-Gm-Message-State: AOJu0YyEK4W8H0AZf0goOz5gfvJPYTGUPQuxeaDj5Hp2zPZh+jdCO30U
	UXd0oJyu7wtdhG58DQYKnagpvh6D/qkDs8pExBP0IF9tJ48i7g6ncISPn0PZiKdfevKk5NhmXzc
	yn74gMzYUvoOPfUErhq/cNw+BmdZiWsXJXpfnvA==
X-Google-Smtp-Source: AGHT+IFNl86r9tdRvDh3d9GOhvSzjR8EGjk4VwLCaym+oXbnvKq96IBsanfAza3ULOpO83eEVlkgJqVd9pv1bcCZRbI=
X-Received: by 2002:a05:6102:54a4:b0:473:15d8:9209 with SMTP id
 bk36-20020a05610254a400b0047315d89209mr1715777vsb.28.1710407838314; Thu, 14
 Mar 2024 02:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
 <CAFA6WYPh5BS_Fpi6ksAC7bwoFEyqjj1Y3EahyQxCG9Pp=KDw=Q@mail.gmail.com> <9dc0415c-4138-4867-861a-38b45b636182@linaro.org>
In-Reply-To: <9dc0415c-4138-4867-861a-38b45b636182@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 14:47:06 +0530
Message-ID: <CAFA6WYPFfL18acdZt6O-_=LWnH7J2MooDuf9cA3JCaQZdoLhVA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
	jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 14:00, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> >>> +
> >>> +             compatible = "gpio-leds";
> >>> +             #address-cells = <1>;
> >>> +             #size-cells = <0>;
> >>
> >> That's not a bus.
> >>
> >> It does not look like you tested the DTS against bindings. Please run
> >> `make dtbs_check W=1` (see
> >> Documentation/devicetree/bindings/writing-schema.rst or
> >> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> >> for instructions).
> >
> > I assumed earlier that W=1 is sufficient for DT schema checks but it
>
> W=1 as in make? No, it is not. It's flag changing the build process.
> dtbs_check is separate target.
>
> > looks like those are two different entities. However, I added these
> > address and size cells properties only to get rid of warnings reported
> > by W=1, see below:
> >
> > $ make qcom/apq8016-schneider-hmibsc.dtb W=1
> >   DTC     arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb
> > arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:96.9-103.5:
> > Warning (unit_address_vs_reg): /leds/led@5: node has a unit name, but
> > no reg or ranges property
> > arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts:105.9-112.5:
> > Warning (unit_address_vs_reg): /leds/led@6: node has a unit name, but
> > no reg or ranges property
>
> Wait, so you saw the warnings and ignored them?

Sorry but you are ignoring what I am trying to say.

> These are legitimate
> warnings, although they don't give you full answer.
>
> > <snip>
> >
> > So it looks like W=1 is reporting false warnings and we should rather
>
> Warnings were true.
>

That's was my initial impression too and I fixed them via following diff:

diff --git a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
index 8f9cacf8de89..a366d3aff3c5 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dts
@@ -92,8 +92,11 @@ leds {
                pinctrl-0 = <&pm8916_mpps_leds>;

                compatible = "gpio-leds";
+               #address-cells = <1>;
+               #size-cells = <0>;

                led@5 {
+                       reg = <5>;
                        label = "apq8016-hmibsc:green:wlan";
                        function = LED_FUNCTION_WLAN;
                        color = <LED_COLOR_ID_YELLOW>;
@@ -103,6 +106,7 @@ led@5 {
                };

                led@6 {
+                       reg = <6>;
                        label = "apq8016-hmibsc:yellow:bt";
                        function = LED_FUNCTION_BLUETOOTH;
                        color = <LED_COLOR_ID_BLUE>;

But it then broke dtbs_check. Are you aware of any other saner way to
fix those warnings properly?

-Sumit

