Return-Path: <linux-kernel+bounces-111978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A16887397
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25879285C24
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46E77763C;
	Fri, 22 Mar 2024 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wagbyasr"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833577627
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134512; cv=none; b=avFJnhfP4PMa4rTbM70G7Z5zW8V1ylc4x/+wdLMFnvyW3s+9ZEz2vIGYifW/z9oz1pLTeQqUHlOryv13p7fJ7/YpGQZQh6pfLwvog9ZvPsvwSK5HIml5wuGEex5x5zaS94tu1T0GNXkStaKOIgPZLsMOQ6TfA0OmbbWo7N6LmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134512; c=relaxed/simple;
	bh=7tv2zMAE82ezQsYqnS0npGm1aElk4sDoy3NbkK1C2Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC6aQNzz7elTmjmgx+NxPYND1QeCkS9bwC+Lukt/uOAHa/qEk5wdqGwq+ZIVD4FxtTHJyP2V6nPeKuCemG8u+XRnMhQC3tECOfrwt9SgKEcgmWBG/NBX/CM5YMRa37JH0lfAQge/MtGbDFEoJ6fYT+wKXV1YddBVD/wFt+E/bww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wagbyasr; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbed0710c74so2208301276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711134509; x=1711739309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JOSis4J/jTYd9KPD730zR82omawpL2+qFPu0+K6rrvY=;
        b=WagbyasrPSXP858JXsqg74haxQfqwDusqz0CG0pP9b5w+acNnlvS53o7p2FLzBIw9I
         owFhHjACWnr2qcYPVds7ZQVUZqdfBzPA+T1SwDpiW7nIljcZIbQ1ZS8+UXOYZ2jNIRPd
         jLO7rhg4wmZo0Rpc69ngZyjXBNdLgA3+zgiNTwQ2V5jFEB5oa3KuP1WrQVyhgji+3Y7Q
         x5aFXfGJPj+JVs3dkn96E1TJ8COGbQ9hyVFlIjlgHc1XCTH55BwDsXIJphjefbN44Gia
         QjWetQn0q1rUYgNTMCe1j3DA6MlGqu7SRdbyrNmgi2wy2mNtMRD/Ji7YLv+qC0Eu9hWw
         7UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711134509; x=1711739309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOSis4J/jTYd9KPD730zR82omawpL2+qFPu0+K6rrvY=;
        b=XmQpeIzxVf4QMpk83JFH3EeZG3FW2gsBmgNAbG6/17Uaqxs0ZH/tV6uj7Ka0CdjNKF
         bHax9r5XYrY+itr17fYKiK3IU+8r9S0LWgsipea8zEAfrn1/F4ciK0z5Pt3upr/mI+FX
         7YVFmMOaDpeE7ZbQhrGkOcHq/uon5e6K1Knabmdyzor22jj4vBK6vPaXTKwrIyimTFz1
         3vKS6qBmIliRMnlFE3KMJ57CN7c2IQnbbJsaHZ+3mWePKmUKPG+qy9Rxuu7cCNxyfPA5
         xGnR9ml34h9qrQr/5l8o8kNA/ETBFZLvDvcllbOUstDUl+xklwzwUOxVrmPp/glipH4p
         t8sg==
X-Forwarded-Encrypted: i=1; AJvYcCUh2wK9huWV7SbuVacQCOnSLI7EAlRFl8SffLwOqLmGZ5dauys52D70nwgA60fcb5k5HV6zbsvn6vVL+xvjoz9l5GqokuRBwgIAyVUd
X-Gm-Message-State: AOJu0Yyd8xjRG2xhO0z2S27uyZAttcs5ytBYKW4tso2MJFL8i2xh1C9p
	VMLrv3Udz8+XA0sUqB5kGoFoUeMtNW0tryfhIu/IcZ+nhNNde0rucHTd1lubwC19r6QX4BBvB8v
	dJPXuUu5dQvVk2FpyeBnnVJXsG+yhFqkR0TKU2A==
X-Google-Smtp-Source: AGHT+IHJres2UW+dc9iaBZt9RklyrtN8tIibgWIXxhVLlO4n5w4VIiiRorRwyk4xVvQo6afUHmIdwuYnclv5fseAmBM=
X-Received: by 2002:a25:3621:0:b0:dc6:dd80:430e with SMTP id
 d33-20020a253621000000b00dc6dd80430emr262357yba.27.1711134509456; Fri, 22 Mar
 2024 12:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
 <20240322-typec-fix-example-v1-1-6b01c347419e@linaro.org> <230eab52-9751-43fd-8e47-fbfe12410e44@linaro.org>
 <CAA8EJprD3fM966pLV4QXPUu=bFTn24fvPMKOaGqtqkAbdz7sOQ@mail.gmail.com>
 <5ea4a187-1971-4970-a289-826d96c0351a@linaro.org> <c0f1e898-7638-4b7b-a938-9e31e5b57e57@linaro.org>
 <0b091595-1587-421d-bb00-c00ef729d143@linaro.org> <CAA8EJpqvwhafFoD_=GO4E93JBQA2A+xY0rG14pgPm=xgJ9Yz_Q@mail.gmail.com>
 <20240322183614.GA1233803-robh@kernel.org>
In-Reply-To: <20240322183614.GA1233803-robh@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 22 Mar 2024 21:08:18 +0200
Message-ID: <CAA8EJppgbsa3bmCo5jbWZW7FgUtyBFS_0zBfvcRjuvjLdv7YkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: usb: qcom,pmic-typec: drop port description
To: Rob Herring <robh@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, neil.armstrong@linaro.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 Mar 2024 at 20:36, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Mar 22, 2024 at 05:49:00PM +0200, Dmitry Baryshkov wrote:
> > On Fri, 22 Mar 2024 at 17:23, Bryan O'Donoghue
> > <bryan.odonoghue@linaro.org> wrote:
> > >
> > > On 22/03/2024 15:09, neil.armstrong@linaro.org wrote:
> > > >> TBH I think we should drop this HS, SS stuff from the connector
> > > >> definition - there's nothing to say in a h/w definition anywhere HS
> > > >> must be a port or indeed SS - not all hardware knows or cares about
> > > >> different HS/SS signalling.
> > > >
> > > > It matches the USB-C connector electrical characteristics, which by spec
> > > > has, at least:
> > > > - High-Speed USB Line
> > > > - up to 4 differential high-speed lanes that can be switched to DP, USB2
> > > > or PCIe
> > > > - SideBand line (SBU)
> > > >
> > > > And those 3 components can be handled by 3 different HW in the SoC, so
> > > > each one has a dedicated port.
> > > >
> > > > Remember DT describes the HW, not the SW implementation.
> > > >
> > > > Neil
> > >
> > > Yes, you're right about that.
> > >
> > > I suppose
> > >
> > > 1. Orientation switches should be defined as coming from a port on the
> > >     connector associated with the CC pins.
> > >     port@3:
> > >     orientation-switch port name goes here
> > >
> > > 2. Data-role switches...
> > >     Again the CC pins
> > >
> > > https://community.silabs.com/s/article/what-s-the-role-of-cc-pin-in-type-c-solution?language=en_US
> > >
> > > Maybe the right-thing-to-do is to add another port for the CC pins -
> > > which would still describe the hardware characteristics but would
> > > _accurately_ name the thing which does the data-role/orientation switching
> >
> > It's true that we don't describe CC lines. However In most of the
> > cases CC lines are handled by the Type-C port manager directly. So
> > there will be a connection from usb-c-connector to the pmic-typec
> > itself (which looks pretty redundant).
>
> The thought at the time this was designed was that would be the parent
> node of the connector. That's perhaps too simple.

Yep. In both our cases the TCPM is a parent of the usb-c-connector.


-- 
With best wishes
Dmitry

