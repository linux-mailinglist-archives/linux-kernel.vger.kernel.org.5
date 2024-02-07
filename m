Return-Path: <linux-kernel+bounces-55800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6280084C1E7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA586B21DCB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02780D2EE;
	Wed,  7 Feb 2024 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLwcyKEi"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2194D27E
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269537; cv=none; b=o7YXK0vW2IReALInf3/9KMb+us7pxuTo1/kBexKc5cPu1yhtxt/mNcGfmFytADgbzenhEsAptDl6kE11R+Ye4vWmupa1Q8z/oWWksU/AIzeSRAo20t37sbwcbR8RPb+Kbs8WJJSP5/NjxaZXvUHgdZPKTarLOAVfKBqMHczFZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269537; c=relaxed/simple;
	bh=kTyLhTinDOUD2dILnzoYkknmbWfY6CzsPssz5k9zVgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RjpACk1N+n4gPYwIXe3vonsJFwqmn1bvqWrCNcRcxTeax1vyBKF5HQjTtQ5clihVKHd3+sGL1dxw/ispUsv1DLrhHwRoqlBj+3pzzYtrF70Uf3C60+Q1becRGWJcRIj8zsJJAptpP/YUbWYgteCYFCXUwReqVXl/uNmIZbMy9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLwcyKEi; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6049165bc6eso679127b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 17:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707269534; x=1707874334; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UR5w5w3nYNrMr4t2252rxJ6poSbTDfrSVSynZ45Rb38=;
        b=OLwcyKEiUNBZZE52AOMT5StOIXxyZRIZnl0PmR08K2+1wZzuuchgCCiI8mJW8NvnFW
         XZGmAqh8oPJu17Xm41UNvYYR5Kpjn+kEs4H3oeRbHn2f+UmHuaoOu/KbRo+6DZpVmn1h
         e/uWjFPR8h2eaeDUW58gE9zXKC3S3HyMRJy67RmzN2kbkcHIlBf4fvQ8P3D93Y1D2B2f
         cob1Zwi5mrLkecjJ4N2od1Eakw/51qveFI2zjj6ftggQ6RnIn7xQte9XSmHRTJay81UE
         ESyd0el46yN2ddJp4eeSdX8r0nnHQg/lxDVDvonAI8v6CeYofMUiDBa6+VNRJp3hUlwq
         OI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269534; x=1707874334;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UR5w5w3nYNrMr4t2252rxJ6poSbTDfrSVSynZ45Rb38=;
        b=CgVhnxSKHCw3v8A9W9roLx32Dp5lxSF7u70sdjx9wLiRCiWzrsIhKKXYny+oMfCl6D
         GGiC30tMiIsIaptt0NOX8JxCU7pcnqqQDuvFK3Z/Uqb/ISm+hwKFVcp7k211xGWgeyG9
         pPt+x0UUWSKTdnxdjwoxsFmmm/607wlLLxtimJBy9bR3YwK2GDhvnPbkaZ6XkTc/OfPQ
         aIV19PRMBIoqBRjieB/59W2vdqLD38ngM6iNJas8unXDhk+hft3YJBMa++76ykpbx4G+
         JRnBOMX9Wyb+b48rrojhDgE1fEnUJZtPGmNI0yIfMkrj+rX4oZTs0R5cy9n0a/nJcF6R
         uEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgHbZftWk+USKPzl2FUBQfarKgc3/l2vQb9rLjNJ9WlJdBxoznVZiBIXRNP3KtSr4PdO64FdE9yw6elJg/snrbyAqfcr7gA4CWgpqv
X-Gm-Message-State: AOJu0YwPQRs5dzloHXbL247rZ7JlMJR7KKao2VZxYtXLtNeghXauJ+3I
	+3dzCEYlMq4AYg/RcY516Cm+2HTImc8kJLLkUQpi7zqm+YaHlPM6+SrkWmr3ksFlzkxk5Qx8aV7
	uUU1SZcdydXjmtOMjbv2RM762IyfphIxKxwFaFg==
X-Google-Smtp-Source: AGHT+IE6HJChHEBK7iL2zfT9AySXYjwDAtbcfV2QOrHxvxPI3SzOJrJMh8q1Ex5CYOpYBW9Bgsv+IarM+lEcpeNr/wM=
X-Received: by 2002:a81:a193:0:b0:5ff:6028:99f5 with SMTP id
 y141-20020a81a193000000b005ff602899f5mr3377783ywg.41.1707269533799; Tue, 06
 Feb 2024 17:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206114745.1388491-1-quic_kriskura@quicinc.com>
 <20240206114745.1388491-4-quic_kriskura@quicinc.com> <23824242-1b37-4544-ae9a-0a5a0582580e@linaro.org>
 <CAA8EJpqbXvKMQktGsxMFJnR+fXoOz8hFmm+E3ROPTjjiD0QLvg@mail.gmail.com> <6q2ocvrujbli42rjddflyol74xianr7j47jwcgdnnmwjanv25d@uw2da7zulqqd>
In-Reply-To: <6q2ocvrujbli42rjddflyol74xianr7j47jwcgdnnmwjanv25d@uw2da7zulqqd>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 03:32:03 +0200
Message-ID: <CAA8EJpr6k8c5C54S9xxQgZvd9NYFoxi5qQrOTz2AMrp0xeZZpw@mail.gmail.com>
Subject: Re: Re: [PATCH 3/3] arm64: dts: qcom: sa8540-ride: Enable first port
 of tertiary usb controller
To: Andrew Halaney <ahalaney@redhat.com>
Cc: neil.armstrong@linaro.org, Krishna Kurapati <quic_kriskura@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_ppratap@quicinc.com, quic_jackp@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 02:10, Andrew Halaney <ahalaney@redhat.com> wrote:
>
> On Tue, Feb 06, 2024 at 03:30:32PM +0200, Dmitry Baryshkov wrote:
> > On Tue, 6 Feb 2024 at 15:28, <neil.armstrong@linaro.org> wrote:
> > >
> > > On 06/02/2024 12:47, Krishna Kurapati wrote:
> > > > From: Andrew Halaney <ahalaney@redhat.com>
> > > >
> > > > There is now support for the multiport USB controller this uses so
> > > > enable it.
> > > >
> > > > The board only has a single port hooked up (despite it being wired up to
> > > > the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
> > > > which by default on boot is selected to mux properly. Grab the gpio
> > > > controlling that and ensure it stays in the right position so USB 2.0
> > > > continues to be routed from the external port to the SoC.
> >
> > What is connected to the other port of the MUX?
>
> /me blows off the dust on the schematic
>
> It's a 1:2 mux, and one option is the out the board, the other
> is a test point I believe if I'm reading things right, although its not
> labeled so I'm not sure anyone would actually find it on the board.

Ack, this definitely looks like a static configuration.

>
> >
> > > >
> > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > Co-developed-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > ---
> > > >   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 21 +++++++++++++++++++++
> > > >   1 file changed, 21 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > > > index b04f72ec097c..eed1ddc29bc1 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > > > +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> > > > @@ -503,6 +503,18 @@ &usb_2_qmpphy0 {
> > > >       status = "okay";
> > > >   };
> > > >
> > > > +&usb_2 {
> > > > +     pinctrl-0 = <&usb2_en>;
> > > > +     pinctrl-names = "default";
> > > > +
> > > > +     status = "okay";
> > > > +};
> > > > +
> > > > +&usb_2_dwc3 {
> > > > +     phy-names = "usb2-port0", "usb3-port0";
> > > > +     phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
> > > > +};
> > > > +
> > > >   &xo_board_clk {
> > > >       clock-frequency = <38400000>;
> > > >   };
> > > > @@ -655,4 +667,13 @@ wake-pins {
> > > >                       bias-pull-up;
> > > >               };
> > > >       };
> > > > +
> > > > +     usb2_en: usb2-en-state {
> > > > +             /* TS3USB221A USB2.0 mux select */
> > > > +             pins = "gpio24";
> > > > +             function = "gpio";
> > > > +             drive-strength = <2>;
> > > > +             bias-disable;
> > > > +             output-low;
> > > > +     };
> > > >   };
> > >
> > > Isn't gpio-hog the preferred way to describe that ?
> >
> > That depends. As this pinctrl describes board configuration, I'd agree
> > with Neil.
>
> I unfortunately don't have the experience with gpio-hog to weigh in
> here, but wouldn't be opposed to Krishna switching it if that's what's
> recommended for this type of thing.

Quoting gpio.txt:

The GPIO chip may contain GPIO hog definitions. GPIO hogging is a mechanism
providing automatic GPIO request and configuration as part of the
gpio-controller's driver probe function.

See sdm845-pinctrl.yaml for an example of the gpio-hog node.

>
> >
> >
> > --
> > With best wishes
> > Dmitry
> >
>


-- 
With best wishes
Dmitry

