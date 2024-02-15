Return-Path: <linux-kernel+bounces-66174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F40785581F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0124281569
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C067ECE;
	Thu, 15 Feb 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fQff7ErD"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35913391
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955668; cv=none; b=bFkkxVu5bjTUdYMrgqqAbP1GFbA/6uqZoM0S7jIVuygo7n/RFWGW+86F4zaOyNxHOjiEfj+UXivjEQ2yV7TZv9ZTgKP+nwOwIcSDDzIk8eFQqysF8gDM0rAooaxJXtBw8a8wZ//nfQpEEuxmunQK4BVblfIrOKQvBAN1V8v3ONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955668; c=relaxed/simple;
	bh=mqihVnhqmNxSJUbv/RGxqZmC0xVgRGexMSCP0Ns7bYU=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIr4qiAOsBp6mj/v4YBC/zglGrZJLojIse6Q6gkWJIrjXRreDLaBgZoHL7haKQPYiZMUJtM4SWMkGzNsnf9SV/aadv7ECHCRklpNJDIYn3GVx34m1uZhcfxUYtCuR4QUpgYtbiYti+CrM6jCVqkD4NPT5KSadQGYMvxRl87AYmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fQff7ErD; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so360103e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707955664; x=1708560464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Er+ESEKbgXvc1t5qmUg/dKRx14VLf4dPpeD7i9BwE5I=;
        b=fQff7ErDYFXHPoXlCcp/lvCOR3Te7xvdHQXRtCT/rId6rLQMyHpA9vn3Gz9WEg9UfU
         fON4MwJPefDvY37/bIhw3ej3KJicuaNxTv52zYf+ggnZS+MNlAZr/14y1phKF57NI9wL
         qKZ8Tj/ROM+48yVbFjN2fGizHornGEHZtW9w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955664; x=1708560464;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Er+ESEKbgXvc1t5qmUg/dKRx14VLf4dPpeD7i9BwE5I=;
        b=OJfGqfpS4Rn5mT5Vn0PKgpmYaBRl1TLX8tG+9CTIE2HjCXw/issZ22/0Rgb3cJqOz6
         vR7Xx3riUlfcLz9WKLAO4MAaGCfZAfiWZ/KinIOXS+G4q6dXJKnac76fhG1IyLQLrBbu
         QFI7veUC/foKlE28gKnSi2020ERvjr+uTlbwqc+vLyYaU0x6RZyyPjdJHyQaa2hi0Ixj
         tJ0t8ZEr4kldRitCheayCmEh680CMvUDqobbh77vSXwy3Ae013SHOggcEnJzW7DU0jFD
         Z9qmDV8AtypoM/gEoy+iWt6371W485H6doHZhArRi4/WNzgLn6eiABHvQlcXdFYQwoE8
         xkQA==
X-Gm-Message-State: AOJu0Yxb+iJADgrve2LAC5jl1asFJBoXnCagpwNd9VsieOZ2SrhUH0Ij
	ffAqubvA7D9q+uS749DPi380mtWCQUNqB62TZGaz+1WV2f6zgLMmD3QIFro1GMdTQ5yP5HZ1znJ
	WxzEi8543PosoSDL4Lk3NyPt1rlWoSHHSYeIQ
X-Google-Smtp-Source: AGHT+IFV146fri/yEai625WOmmn4P92hjYL0lv0BuNrjWlIcprz/viy3Rv+xCRbYoWq6nvQJZDmqN9KcjzHIR0bVyZk=
X-Received: by 2002:a05:6512:77:b0:511:7292:c4db with SMTP id
 i23-20020a056512007700b005117292c4dbmr243676lfo.12.1707955664213; Wed, 14 Feb
 2024 16:07:44 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Feb 2024 16:07:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <18ac05fb-a78d-4e95-a73d-461f509cdc5f@linaro.org>
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-19-swboyd@chromium.org>
 <18ac05fb-a78d-4e95-a73d-461f509cdc5f@linaro.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 14 Feb 2024 16:07:43 -0800
Message-ID: <CAE-0n50Y_GRMt8km=XjGC5Zm5dvb2t4gccznJn9HEFS4p7y8fQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] dt-bindings: chrome: Add binding for ChromeOS Pogo
 pin connector
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Pin-yen Lin <treapking@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Krzysztof Kozlowski (2024-02-11 05:39:36)
> On 10/02/2024 08:09, Stephen Boyd wrote:
> > diff --git a/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml b/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
> > new file mode 100644
> > index 000000000000..5ba68fd95fcd
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/chrome/google,pogo-pin-connector.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
[...]
>
> > +properties:
> > +  compatible:
> > +    const: google,pogo-pin-connector
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: Connection to USB2 port providing USB signals
> > +    required:
> > +      - endpoint
>
> Drop required.

Why? I'd like to make it so you can't have the node defined without
connecting it up to the rest of the system. Is that bad?

>
>
> > +
> > +patternProperties:
> > +  "^keyboard@[0-9a-f]{1,2}$":
> > +    description: The detachable keyboard
>
> If this is detachable why do you define it in DT? Only hard-wired USB
> devices, which need some sort of special handling. are described in DT.

From the commit text:

 We expect to find a keyboard on the other side of this connector with a
 specific vid/pid, so describe that as a child device at the port of the
 usb device connected upstream.

ChromeOS userspace is checking that the connected device downstream of
this port has the expected vid/pid to quickly rule out USB keyboards
that aren't the detachable keyboard. I wanted to express this in DT so
that it didn't live in ChromeOS userspace forever.

