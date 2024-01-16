Return-Path: <linux-kernel+bounces-27057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074182E9CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD202285118
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CD210A34;
	Tue, 16 Jan 2024 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPN7CH13"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA111197;
	Tue, 16 Jan 2024 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55818b733f7so8494459a12.3;
        Mon, 15 Jan 2024 23:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705389042; x=1705993842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx3ONPFhW1k+rJs1ik8VVxCBMTNuNbUGLXWbqa0i6nY=;
        b=bPN7CH13BCtQaIYt6qv9zYFuOyxGuL3MxPFMEnw1fxOKl2N+2V/err3XljyMr4ORzO
         eEPG9KppjTkRbET6ff0Kfb4GVyGMrNYfhrcPItvv04fMyLdPPRFKBJXE9ZphapJkZWYD
         8u73ODyx4t6h7VD/0TEv3l/h0qsLTHkM0418m9vjBVBqhBzNGVZpa/rqUatbPwUyZY/i
         5NX0z6EnrKUvPJllaCayIg1uzYr8edDrrYNFcA1R+zP7zo27/gyVnwb1ti/fWgejtNQQ
         l15tfFq1jRXWw2ntGrmIJgQykAPoMueCZSKm5FPfGCc2w6QYx+L4XtfPhxwXXfLbrcDv
         59LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705389042; x=1705993842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sx3ONPFhW1k+rJs1ik8VVxCBMTNuNbUGLXWbqa0i6nY=;
        b=Y+LSkn8o8zFVyZqvxMoKnByYaZ3Rk7t9w84fdUGNKQLBSCi9ZmjgAj6rmyk20b9euS
         9qLscjOL1t01X6yN0+WkqLMcayH1ADsb/Hy3FcJh+mUISC0y9nUAqOrmSeZV4b/SEWW0
         RuxQPJOBm6z3YyCeZiaWcGLoxGRHn+BY3a2+XwxGkz7au4oF8ZalaGS9HAciLnXDhbHq
         QX6AK2H5MjbBz4djXZxsw6EHQ858DtFTCEOozXHFMQwys8dC/hL4Xm9xkWwuCit3N8fF
         eSKBqA/L6KLgK/SRHpvP1M/N88y9BpJL4o70iQ7QnGYlSDFSPCsYfQVSGyjuGbugU4Bg
         7i/w==
X-Gm-Message-State: AOJu0YwJtA/zLeHdTlpZTkcB/qBOWX6+ZIkLMllHTMXyPERAxNmkUhn0
	2V94N0oSIcFXZHOdXfWu2m4=
X-Google-Smtp-Source: AGHT+IGjntI5qvKBjyx/xSzbYUzMxvRTXUY452vrAD0k/Xd5oD4pdJGB3KF9BprhwfnlYKxX9xbwsg==
X-Received: by 2002:a05:6402:c90:b0:558:856a:806b with SMTP id cm16-20020a0564020c9000b00558856a806bmr3324595edb.49.1705389041964;
        Mon, 15 Jan 2024 23:10:41 -0800 (PST)
Received: from cjw-notebook (2a02-8388-0502-f480-6c32-186a-368b-d6a9.cable.dynamic.v6.surfer.at. [2a02:8388:502:f480:6c32:186a:368b:d6a9])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c9d0000000b005582b9d551csm6386033edt.30.2024.01.15.23.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 23:10:41 -0800 (PST)
Date: Tue, 16 Jan 2024 08:10:38 +0100
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
Message-ID: <ZaYr7jdxoKMqjnO1@cjw-notebook>
References: <20240106-w1-uart-v4-0-7fe1378a8b3e@gmail.com>
 <20240106-w1-uart-v4-1-7fe1378a8b3e@gmail.com>
 <20240113013917.GA3795949-robh@kernel.org>
 <ZaLQxGjjmA_iKOv2@cjw-notebook>
 <81c79939-56cc-4d78-9552-56568999df09@linaro.org>
 <ZaP0CoCYLQxrT3VD@cjw-notebook>
 <1b8cb3ba-6727-45ab-acaa-c727a0a7ad85@linaro.org>
 <ZaVtNmvRjPAn9bph@cjw-notebook>
 <7035daa6-e654-4e77-be55-60f8e8c6639f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7035daa6-e654-4e77-be55-60f8e8c6639f@linaro.org>

On Mon, Jan 15, 2024 at 07:02:55PM +0100, Krzysztof Kozlowski wrote:
> On 15/01/2024 18:36, Christoph Winklhofer wrote:
> > On Sun, Jan 14, 2024 at 04:55:42PM +0100, Krzysztof Kozlowski wrote:
> >> On 14/01/2024 15:47, Christoph Winklhofer wrote:
> >>> On Sun, Jan 14, 2024 at 11:54:48AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 13/01/2024 19:04, Christoph Winklhofer wrote:
> >>>>> On Fri, Jan 12, 2024 at 07:39:17PM -0600, Rob Herring wrote:
> >>>>>> On Sat, Jan 06, 2024 at 05:02:24PM +0100, Christoph Winklhofer wrote:
> >>>>>>> Add device tree binding for UART 1-Wire bus.
> >>>>>>>
> >>>>>>> Signed-off-by: Christoph Winklhofer <cj.winklhofer@gmail.com>
> >>>>>>> ---
> >>>>>>>  Documentation/devicetree/bindings/w1/w1-uart.yaml | 62 +++++++++++++++++++++++
> >>>>>>>  1 file changed, 62 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/w1/w1-uart.yaml b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> >>>>>>> new file mode 100644
> >>>>>>> index 000000000000..6b90693b2ca0
> >>>>>>> --- /dev/null
> >>>>>>> +++ b/Documentation/devicetree/bindings/w1/w1-uart.yaml
> >>>>>>> @@ -0,0 +1,62 @@
> >>>>>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>>>>>> +%YAML 1.2
> >>>>>>> +---
> >>>>>>> +$id: http://devicetree.org/schemas/w1/w1-uart.yaml#
> >>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>>> ...
> >>>>>>> +properties:
> >>>>>>> +  compatible:
> >>>>>>> +    const: w1-uart
> >>>>>>> +
> >>>>>>> +  reset-speed:
> >>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>>>>> +    default: 9600
> >>>>>>> +    description: |
> >>>>>>
> >>>>>> Don't need '|' if no formatting
> >>>>>>
> >>>>>
> >>>>> Ok.
> >>>>>
> >>>>>>> +      The baud rate for the 1-Wire reset and presence detect.
> >>>>>>> +
> >>>>>>> +  touch_0-speed:
> >>>>>>
> >>>>>> Don't use '_' in property names.
> >>>>>>
> >>>>>> I'm somewhat familar with 1-wire, but I don't get what 'touch' means 
> >>>>>> here. I assume these are low and high times which are a function of the 
> >>>>>> baudrate.
> >>>>>>
> >>>>>
> >>>>> I change the name to 'write-0-speed' and 'write-1-speed'. The function
> >>>>> in the w1-framework is named 'touch_bit' - therefore the previous
> >>>>> naming. 
> >>>>>
> >>>>> It is the baud-rate used in the 1-Wire cycle to write a 0-Bit
> >>>>> (write-0-speed) and to perform a 1-Wire cycle that writes a 1-Bit and
> >>>>> reads a 0-Bit or 1-Bit (write-1-speed).
> >>>>
> >>>>
> >>>> Then probably -bps:
> >>>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> >>>
> >>> The serial.yaml uses prefix -speed for the baud rate but I can change it
> >>> to -bps.
> >>
> >> Do you reference serial.yaml?
> >>
> > 
> > No, serial.yaml is not referenced but 'onewire' will be a child-node of
> > a serial-device which already defines baud rate related properties
> > with -speed (e.g. max-speed although not used in w1-uart). Hence, I
> > thought -speed is typically used for baud rates.
> 
> Ah, it defines max-speed for childre, so for onewire. Re-using that
> property would make sense, but since you are defining completely new
> properties, let's use proper (-bps) naming.
> 

Ok.

> I still wonder, why would you use different baud rates for these three
> different operations?

The timing for the pulse on the 1-Wire bus, to perform a 1-Wire reset or
read/write is too different to use the same baud rate for them. The
pulse can only be generated with the transmission of a single byte (to
initiate the operation and to evaluate the response), since every UART
packet starts low and ends high, only a limited set of baud rates are
possible.

Read-0/1 and Write-1 have the same low-time and therefore share the same
baud rate setting, actually this baud could be higher. Otherwise, for
Write-0 the maximum baud-rate is somewhere near 115200.

The table lists the low-time range for the 1-Wire standard speed
(overdrive is currently not implemented by the driver):

  Operation | Low-Time (usec) | Baud rate (default)
  ----------+-----------------+--------------------
  Reset     | 480 - 640       | 9600
  Read-0/1  |   5 -  15       | 115200
  Write-1   |   5 -  15       | 115200
  Write-0   |  60 - 120       | 115200

I thought it makes sense to have the option to overwrite the default
baud rates. Alternatively, the driver could probe a fixed set of
different baud rates that are able to generate the timing patterns.
Initially, the driver always used 9600 and 115200 - however some UART
devices may not support these bauds. Now the driver requests a baud rate
and checks if it can create the timing pattern with the returned one.

Kind regards,
Christoph

