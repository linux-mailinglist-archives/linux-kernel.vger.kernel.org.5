Return-Path: <linux-kernel+bounces-66192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3D855866
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2336286F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A641367;
	Thu, 15 Feb 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rpg3YnKi"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB194EC7
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957897; cv=none; b=Jg2r8j1r41EC0iZKeQb/+smsqjOI6tA0HTRkj0B9zNkCrmWjxjq4gyMvacXLvyMGo8iw4mrWS+kEr+Brj8KvJf456Zvr6yn6YCblmW9G4fQG5YnZedQHiAK8kSbUeFh4Y4lSM/h06RkBSbnYUo4WCfl6CcBEGq1aPdowP+ga06k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957897; c=relaxed/simple;
	bh=wP/opWg4NPPj3Q1TJjBcRMLyLYuk3vBq7WguCOVgHEk=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADjzzsxa8UQysgsjR8pycBiAtfhjTeH95hYA+sR8SmlspWrMtZZTqUJMabJoFhpJuKnfNfttn4sB543QsWDFuu38IWFB6wXNsPbHDrCztKm7rIa+NHH/IS2BWf40FDE5AT5sY6zzzGqGe0/+/ukLOxJUEGojq4eAqNurTn6o1x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rpg3YnKi; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0e520362cso3195431fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707957894; x=1708562694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK7IS77/W7TToczCQpY2GYKtvK4AuoqqptX1LvYKQRA=;
        b=Rpg3YnKikda5gYTI6t8tbb4u9HLoOhCMrJam+9AqefCcRhKc5xaqBssE9mqyS/zg4/
         GwRGAq3O4XcrcMMpxkOH5C5NO+gZ//wiak4RQxfiGSCWTev1ibSgBbhbq7hmXPUT+2eu
         Z5c7DbL3lslmiGnvieKcjWmJZexhgLZxb1zTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707957894; x=1708562694;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK7IS77/W7TToczCQpY2GYKtvK4AuoqqptX1LvYKQRA=;
        b=QykMd0S+8fhfYS8d4461iTBe43EBh1VsB+SwkLb6oBHuZYW4QMnwVWaWySAiO+MMgu
         O3/l3Ij1URbBrHaLYBqFDQGXs4BvIwO3N1/cEdSlmLyN0Izj6vln9+RDV2mD5ng6fG89
         XXoZhBux3qwwaqqqrgA4qtigV6Z87Rqcqrq8Vr9wpW2q5shGwrrldRm3G5lELf6i7F4N
         Gb6cluWJuc/+7fjtdhqIK/14Apv2y8Puyq7b2Lo0EKx8qV40KSQNdF0f78mVxHxh7O1Y
         0aNzvH4i2LBSgoSqi3CDCSOkuMMeIDlT28sILQiM4DNcrhTaLHZ6hW7gbtPZyxkw5/3D
         KL1A==
X-Gm-Message-State: AOJu0Yyu65kRM3kphlE50/m5MVpBuRpAMkVjjLh4EUIhUEQtBFeV5TyA
	xfDXvNsrioEfWi6x42SVIFQ6MSv06i4vFgxGLQKPwa0JnMCmmfd4Jpa+hGjah2+DhcdQBmh7kcs
	EElv3LNqzi73zqYW/2aTDSJh+wMkttjM55qUp
X-Google-Smtp-Source: AGHT+IGKsNObiv5/sSxZv6aITBScisJn3oLmwBXS+yX42z/wkWCduLTcJnTn4E24I+pmYo583/8HG2h1y512aeNzcHg=
X-Received: by 2002:a05:6512:3487:b0:511:5c98:acd2 with SMTP id
 v7-20020a056512348700b005115c98acd2mr193884lfr.37.1707957893979; Wed, 14 Feb
 2024 16:44:53 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Feb 2024 16:44:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a6ce4811-2a3d-4df6-aad3-9942a1bcfedd@linaro.org>
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-2-swboyd@chromium.org>
 <a6ce4811-2a3d-4df6-aad3-9942a1bcfedd@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 14 Feb 2024 16:44:53 -0800
Message-ID: <CAE-0n50Ms_QcscgGrFe55O-j5j+GA+GvvDmp=Qo60bcSD9VxUQ@mail.gmail.com>
Subject: Re: [PATCH 01/22] dt-bindings: gpio: Add binding for ChromeOS EC GPIO controller
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Pin-yen Lin <treapking@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Krzysztof Kozlowski (2024-02-11 05:26:33)
> On 10/02/2024 08:09, Stephen Boyd wrote:
> > The ChromeOS embedded controller (EC) supports setting the state of
> > GPIOs when the system is unlocked, and getting the state of GPIOs in all
> > cases. The GPIOs are on the EC itself, so the EC acts similar to a GPIO
> > expander. Add a binding to describe these GPIOs in DT so that other
> > devices described in DT can read the GPIOs on the EC.
>
> ...
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +      #address-cells = <1>;
> > +      #size-cells = <0>;
> > +
> > +      cros-ec@0 {
> > +        compatible = "google,cros-ec-spi";
> > +        reg = <0>;
> > +        interrupts = <101 0>;
>
> This is should be proper define but then are you sure interrupt is type
> NONE? Does not look right.
>

I copied this from cros-ec-typec.yaml so I'll have to fix them all!

