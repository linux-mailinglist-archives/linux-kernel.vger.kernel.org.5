Return-Path: <linux-kernel+bounces-25486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637082D103
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659861F2168C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1733C257A;
	Sun, 14 Jan 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDgeIL6Z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD277E;
	Sun, 14 Jan 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-557e76e1bd6so7421150a12.1;
        Sun, 14 Jan 2024 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705243662; x=1705848462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RfostFqAU3snM+2/TDPgHKNO1Hh0ApprqGF2zbs6XU=;
        b=nDgeIL6ZPFRH/dZivnrIppXtvjaNObADdO7r4Fy9W7SK8BsE0BbOCIS7YK/0x+LTBw
         feY6xSP91vyBATYy5Z3Rj/TkQQWGxLH9bEF9kabsTvUsgTWt2/kwKrfYDHfBD9iiHxjr
         4RB3ELyy2QH/q2u0+26yeVtIctyIXuMJjGh5NdNbRwMjrjXXmmXmpQ8LEbWD5QG9BUKp
         AmowEQQfFNcUakYjOXJgcpB+QQ47UE7d195fJXi8u6tPHh1fhpJX2c2ScIyMUYPP1bh8
         ciYjzlhTZDgyynC+rxQ2bhTkjfWma4VWfb222rN9mlPHDAdmMr6lHb6JOgBzTMGXwmvQ
         BcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705243662; x=1705848462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RfostFqAU3snM+2/TDPgHKNO1Hh0ApprqGF2zbs6XU=;
        b=vCEC0jtmZIjl5tLRdmRtByoEqDIT2AKr23LHYj7k7l63h+7h7cxLtsuJm+0xttqqQL
         VbyV0a/4XJYLdfR6hZ+kq+fO4E8Jm/QGffWYnxTK6TycEPnxkWHEOWqA4zllU3ETzF/k
         VqBjvc5IiDJUBCbwVu2Zev8PcL1au685Hy1vDf+KH2tIz+khtTcvQoT6qnkzU7kcOc2I
         ofxJ5rkHglPHkYjU3GemV5b/MFWNtb+0/h8VWTHaEWBo6tLci08S0qN0Tc8QM1ywMgWC
         owkcUejZPNaEO3CfoGQDNUcmMjGQJlMZTu2BBLc1WLT4PBShU7LC45kmCZMQ0KqmADxH
         oWQQ==
X-Gm-Message-State: AOJu0YzuuQHlFnjpDzyy0GbwYIqsj5af16ARHorrqx0nemw1rMm0aGFC
	gyMAG0nYHoBZoACVspQK8Ro=
X-Google-Smtp-Source: AGHT+IH9UZ1+n5ZCs7ReOFk6TPU1hUkEpzbyghVF9cxiQkRcSiFP9zDO3FJCuATydcDAsoHDhv4a7A==
X-Received: by 2002:a05:6402:40c3:b0:558:ce1e:f5f1 with SMTP id z3-20020a05640240c300b00558ce1ef5f1mr2330271edb.71.1705243661734;
        Sun, 14 Jan 2024 06:47:41 -0800 (PST)
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056402530900b00557b0f8d906sm4261982edb.70.2024.01.14.06.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 06:47:41 -0800 (PST)
Date: Sun, 14 Jan 2024 15:47:38 +0100
From: Christoph Winklhofer <cj.winklhofer@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: w1: UART 1-Wire bus
Message-ID: <ZaP0CoCYLQxrT3VD@cjw-notebook>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-1-7fe1378a8b3e@gmail.com>
 <20240113013917.GA3795949-robh@kernel.org>
 <ZaLQxGjjmA_iKOv2@cjw-notebook>
 <81c79939-56cc-4d78-9552-56568999df09@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81c79939-56cc-4d78-9552-56568999df09@linaro.org>

On Sun, Jan 14, 2024 at 11:54:48AM +0100, Krzysztof Kozlowski wrote:
> On 13/01/2024 19:04, Christoph Winklhofer wrote:
> > On Fri, Jan 12, 2024 at 07:39:17PM -0600, Rob Herring wrote:
> >> On Sat, Jan 06, 2024 at 05:02:24PM +0100, Christoph Winklhofer wrote:
> >>> Add device tree binding for UART 1-Wire bus.
> >>>
> >>> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/w1/w1-uart.yaml | 62 +++++++++++++++++++++++
> >>>  1 file changed, 62 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> >>> new file mode 100644
> >>> index 000000000000..6b90693b2ca0
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> >>> @@ -0,0 +1,62 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > ...
> >>> +properties:
> >>> +  compatible:
> >>> +    const: w1-uart
> >>> +
> >>> +  reset-speed:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    default: 9600
> >>> +    description: |
> >>
> >> Don't need '|' if no formatting
> >>
> > 
> > Ok.
> > 
> >>> +      The baud rate for the 1-Wire reset and presence detect.
> >>> +
> >>> +  touch_0-speed:
> >>
> >> Don't use '_' in property names.
> >>
> >> I'm somewhat familar with 1-wire, but I don't get what 'touch' means 
> >> here. I assume these are low and high times which are a function of the 
> >> baudrate.
> >>
> > 
> > I change the name to 'write-0-speed' and 'write-1-speed'. The function
> > in the w1-framework is named 'touch_bit' - therefore the previous
> > naming. 
> > 
> > It is the baud-rate used in the 1-Wire cycle to write a 0-Bit
> > (write-0-speed) and to perform a 1-Wire cycle that writes a 1-Bit and
> > reads a 0-Bit or 1-Bit (write-1-speed).
> 
> 
> Then probably -bps:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

The serial.yaml uses prefix -speed for the baud rate but I can change it
to -bps.

> 
> > 
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    default: 115200
> >>> +    description: |
> >>> +      The baud rate for the 1-Wire write-0 cycle (touch bit 0).
> >>> +
> >>> +  touch_1-speed:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    default: 115200
> >>> +    description: |
> >>> +      The baud rate for the 1-Wire write-1 and read cycle (touch bit 1).
> >>> +
> >>> +required:
> >>> +  - compatible
> >>> +
> >>> +additionalProperties: false
> >>
> >> w1.txt says there can be a child node for the 1-wire device. You need 
> >> 'type: object'. Or w1.txt needs to be converted to schema and referenced 
> >> here (along with using unevaluatedProperties here instead).
> >>
> >> Rob
> > 
> > Will change it to type object. However, I also tried to convert w1.txt
> > to w1.yaml - I am not quite sure, so I add an excerpt of my attempt.
> > The example in w1.txt builds fine. Is oneOf allowed as a top-level
> > property, the documentation only mentions allOf?
> > Only one child should be allowed, but I did not find a way to restrict
> > this.
> > 
> > # w1-uart.yaml:
> > unevaluatedProperties:
> >   $ref: w1.yaml
> > 
> > # w1.yaml:
> > properties:
> >   compatible:
> >     enum:
> >       - maxim,ds2760
> 
> w1 describes entire class of the devices, so it should not have
> compatibles. Look how other buses do it.

Thanks for the hint, looked at serial.yaml and usb.yaml. Hence w1.yaml
should describe the properties common to all w1 bus controllers
(property for child device) and w1-uart.yaml references it in allOf,
like:

# w1.yaml
patternProperties:
  ".*":
    if:
      type: object
    then:
      description: Devices are listed...
      properties:
	compatible:
      required:
	- compatible
additionalProperties: true

# w1-uart.yaml
allOf:
 - $ref: w1.yaml#
unevaluatedProperties: false

Kind regards,
Christoph

