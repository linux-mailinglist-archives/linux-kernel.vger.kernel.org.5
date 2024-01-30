Return-Path: <linux-kernel+bounces-44612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF913842508
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706371F26F96
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FA86A032;
	Tue, 30 Jan 2024 12:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Z6bu652y"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529EF45BE7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618155; cv=none; b=MEkYwr7DeGUpfCSSxo+P6xUNROXIz39YpeCaIQl5aBGH5CKmH11UE3QziPIAeBnQ19NRTeTddXrhdFFCOa9tAShp2cnXsRI3Wg5teIXlgM+7kPsxoposm44Ts8gEk2kA2WWOVwgSXlzT6Hzp4YxwqfS232qWDTRio9hvFHTaQYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618155; c=relaxed/simple;
	bh=Jm2FDGHXPVRHJOF8piPCWJ0CqfEu1McE3XNfHaO8bUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpmSdJk8LdpwwMVKLLN5LjBpm8CAO/u1PcybFvjAAgBF1IcFQVQ5qZx/Li9mkRB5dwb34JfIR5ZbR0Xs1G2ROxKfj4p8iqMitLzMrVhxb7X05S0Q8eQSUl3SqzE1ij6n1HNRirPsKvp4tgMF0Yj5YhfCGz/BZw1GDD2EFYPgvAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Z6bu652y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2266404a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706618154; x=1707222954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm2FDGHXPVRHJOF8piPCWJ0CqfEu1McE3XNfHaO8bUU=;
        b=Z6bu652yHBhhXOTfT6Wvz5u6tJn6ZambO1VRxlZ13o218Fq6+nJ/hDO52WkGU11AIS
         T+1it4IkayEjltyHJQJVh/XVrhDAAQVw8HVs/pgYISClpBexfktEVhxa2XsgiD93EGHK
         KRN4s5aAVdroOMIywhHpAeZ3z7eYeb45A3zgTrSnE/IbD8LJW6U0ous2b5HL7O2+CbZv
         SWniBDS4xzvjG6E7av5cDN2e/DJ9hrhnCl3/7Bg3RH+kQ9oZcr82Z5W2u0jWEtSShO/t
         3rO5QbWTqsGGw8BpBzBkb/bfqmuxmPOHcOZ410817QCyeTQVF3WdouR5CFgoZiyO4Syc
         iV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618154; x=1707222954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm2FDGHXPVRHJOF8piPCWJ0CqfEu1McE3XNfHaO8bUU=;
        b=IdkTfHOTNXBIspdvY2Fbs9ts+/JzAF2M07KxSPVcvjJ2iZgg2dSiZgZLQw4knndWTg
         x2dY7asdXBWR5ng7kayPZ0zrUJdifWcHpLoswqNpn7SALDnvn6VqybyfNAXQkMdevESb
         b9CT4PyYssWos47vbDyIgcuqdc++/9yX2Z+c1EBey4HebrRaG7R78w1KcMs96mpXxRJw
         H/+aTe7Mnekmwl6borfUpzBPGLtIrXCqm49DCYEoXSA1/Yee9amYrpErPJbs94HCR+Sw
         kteANzVePkr8ucK9ZftyjKyYd4zjUyQjT2dk153rYaIDBP7/xJTWk+CwRusgXM6aVDsJ
         cwnw==
X-Gm-Message-State: AOJu0YxeYy/76hWNRg+trrGQ/tCD030/oaP7/is9kQUlnGpE1KWcmkR9
	LIvt0WXY2WVIqGbmSBP5GBPmxle0F6+zF9DcJaZ5M62FJBasw+jcmSiQHbBREIPDEUqWrOENN6x
	rMbCRFD2Ik3tM/cMnqM7xaGVReXJ65Msou6kiJQ==
X-Google-Smtp-Source: AGHT+IGTntxKoODjjTYzwLT4wkEHukDXHu/Nu8uelZIezqzzyxOclRiJPwjXhhWa15k0cE0hIoEazKVknNcv9YOqK+Y=
X-Received: by 2002:a17:90a:ac0d:b0:294:1261:6412 with SMTP id
 o13-20020a17090aac0d00b0029412616412mr5245189pjq.9.1706618153744; Tue, 30 Jan
 2024 04:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130120807.460335-1-naresh.solanki@9elements.com>
 <b305291e-199d-4a0b-b24e-09910f1eed37@linaro.org> <CABqG17in2+0eHMRBvyunWKizgSBpYPq+CGsMO7FQo13pApPvaw@mail.gmail.com>
 <021f3f6f-0aa9-41c2-a220-b1e6efad2880@linaro.org>
In-Reply-To: <021f3f6f-0aa9-41c2-a220-b1e6efad2880@linaro.org>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 30 Jan 2024 18:05:43 +0530
Message-ID: <CABqG17jKri5DL4mTpf-DqueyW28rFk_XpxF3M1gauxYEBvMv-A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pinctrl: cy8x95x0: Minor fix & update
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Patrick Rudolph <patrick.rudolph@9elements.com>, mazziesaccount@gmail.com, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,


On Tue, 30 Jan 2024 at 18:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 30/01/2024 13:26, Naresh Solanki wrote:
> > Hi Krzysztof,
> >
> > On Tue, 30 Jan 2024 at 17:49, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 30/01/2024 13:08, Naresh Solanki wrote:
> >>> Update maxItems to 60 for gpio-reserved-ranges to allow multiple gpio
> >>> reserved ranges.
> >>> Add input-enable property to allow configuring a pin as input.
> >>> Rearrange allOf
> >>
> >> Why?
> > allOf is aligned with other implementations.
>
> Which ones? example-schema and other implementations have it in
> different place. If you align some parts of the code, please align to
> match the correct code, not other incorrect. How to find it?
> example-schema is the reference, recent commits are also sometimes good
> indication.
Yes your right. Will align with example-schema. Thanks.

Regards,
Naresh
>
> Best regards,
> Krzysztof
>

