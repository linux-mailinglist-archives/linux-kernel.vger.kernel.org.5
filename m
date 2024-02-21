Return-Path: <linux-kernel+bounces-75114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474C85E368
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B5D2841FA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78313E495;
	Wed, 21 Feb 2024 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fBsfzKu3"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4533282D7E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533070; cv=none; b=d3sXyJY5jhskuxZ/azXf08Ykk607T+GZkgHF8EYrDSqkIo+xXmIKGZBAmEo0wUcEqDTnbGqKUfZSDh/LtqOGc+Dtqyf4dFlcBZT5+JjEm1GpCAJR/JxaiUeGHnk4tlM8mKVctRh1kadVwxIkcWqF9dcIoxLqC9ii2COAVv50VL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533070; c=relaxed/simple;
	bh=KmRZ5uM+dkyrD3VVMo8Sn7/Dfsa+I57DS/ua1TzZ4rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F/6xo15OkKtWF1iuttanFHcv3ikWM4rhLE9CBq3foDkVcKt55zqFjQeo4zfrtcZo3fUZVN+Wq1DEk0CgPrgkzsuFl8FAz2QpNg6xNFCnCakt4YARUARKGy/G/0/vr20s0cXzim9Ruh1KLSzxqKoRw0S4SOZlAZZT0YxDGt4ylmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fBsfzKu3; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c4949661a2so266073539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708533068; x=1709137868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAe7/3QZg7F6kt4OXJPb9Y6Tm7Pxl+pIe4bnMQYzmYI=;
        b=fBsfzKu3mIHYWcs9ZEh4jbg6e+MAkgvKPOscrCgveo5JHStqkEJefFzBUGkL6CLyIV
         3MwxgiUSSDPrPJ6GW7m7/GqtDHbLLu4ld8+MGAoJF5b58dBnJRNVFfkI2xAz/imxE+g0
         +eBUqGS316BCKlKhrFFhJbvbvsYG6vgFjAasjd4fwMN/k910erUbNOk5+yXU5UTRvy9X
         o0RsDPu7t25Nc96obN1136F/gH6koc8KWOwXjj0TDaqPnprfNVwwQL8T7aELV8qDvr/m
         agqzH7DFg1RhmBrZJsCxkwYGFGEF5PPqt40vDkI7kUZJAuWe++EOMdByPgLvUUVLCttA
         mMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708533068; x=1709137868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAe7/3QZg7F6kt4OXJPb9Y6Tm7Pxl+pIe4bnMQYzmYI=;
        b=q2IaNtXqTIFWjfN9Df062LE+50sTMrQJ4SUjq8fjuN0JU34bqan6IRBtwIs/0iantz
         toyK4jVLmQ7e+Sq33XBvrrS+3LgD6j8hL6yqlqU7H7JLwLLKcxzD4oUIH3bCWAQhEqXd
         uDHWVwIp8je4eU2Zz+RnWybIbUMcXGz0qG8q7vFhGeI5fA27AH5yCIwLmETByjdZfAHo
         Fl7sl7o3ow18edoaffNaZeJ+0uqnyWnh4IzP8o779MOa1H7A9zjtvjb+JAcbiDoTtWZk
         mbJz+dwomKxRqH3oRBsDAHYpf10PYtYgqaQzEVHaoTRwO2fpeuuvgI+y+iQ0SZstUkLY
         XL6w==
X-Forwarded-Encrypted: i=1; AJvYcCX6Yuw/u1IrXRkdqHA5NcE4mVo0cUSIOlAdxPvkgdnjEa0gevuGvrMhXlooCdUIAWBv8zZ9Jw2sDY49fIHEeYWYn8daoKE+TyWqFvO8
X-Gm-Message-State: AOJu0Yzpk4BuocedyDRYyyCD6ODYQkc/H+naYWaPK4gPFKG2+DiO7rJ4
	0fSScw/fvfAwoICwxBIY1NNfoOVjDLXwXU1Rld7yirI+O0AV3jbx66LtHP2WYXXl5LCsM9ndaXO
	jjjjtay2+lt9x6p3fpsI3zcQjpP5H5+4h5ccB
X-Google-Smtp-Source: AGHT+IHA0I/TkMUo4dpT97MXiRqq1ZaBo3fcCy2GY6tK6iHF1Ly9jSiVekMtxHcZsLqU2Vr0uhsnEHV83fGJqZ4TBIA=
X-Received: by 2002:a05:6602:e17:b0:7c7:466b:f315 with SMTP id
 gp23-20020a0566020e1700b007c7466bf315mr9936019iob.3.1708533068049; Wed, 21
 Feb 2024 08:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212131323.2162161-1-panikiel@google.com> <20240212131323.2162161-9-panikiel@google.com>
 <20240215-moodiness-concert-0050a16f644c@spud>
In-Reply-To: <20240215-moodiness-concert-0050a16f644c@spud>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Wed, 21 Feb 2024 17:30:57 +0100
Message-ID: <CAM5zL5psgAKmxW_nAL8J+Bvu27R8POmvhJYkM6524zXRZrbP0A@mail.gmail.com>
Subject: Re: [PATCH 8/9] media: dt-bindings: Add Intel Displayport RX IP
To: Conor Dooley <conor@kernel.org>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com, 
	ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> Yo,
>
> On Mon, Feb 12, 2024 at 01:13:22PM +0000, Pawe=C5=82 Anikiel wrote:
> > The Intel Displayport RX IP is a part of the DisplayPort Intel FPGA IP
> > Core. It implements a DisplayPort 1.4 receiver capable of HBR3 video
> > capture and Multi-Stream Transport. The user guide can be found here:
> >
> > https://www.intel.com/programmable/technical-pdfs/683273.pdf
> >
> > Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
> > ---
> >  .../devicetree/bindings/media/intel,dprx.yaml | 125 ++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/intel,dprx.=
yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/intel,dprx.yaml b/=
Documentation/devicetree/bindings/media/intel,dprx.yaml
> > new file mode 100644
> > index 000000000000..3ed37e0a4a94
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/intel,dprx.yaml
> > @@ -0,0 +1,125 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/intel,dprx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Intel DisplayPort RX IP
> > +
> > +maintainers:
> > +  - Pawe=C5=82 Anikiel <panikiel@google.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: intel,dprx
>
> Please version this compatible, given that is it for an FPGA IP.
> I could not find an example of another intel IP that had versioning, but
> there's plenty of xilinx stuff you can get inspiration from.

The IP has had a few different revisions, so I decided to just use the
"IP version" which is 20.0.1 for the version this driver is targeting.

>
> > +  reg:
> > +    items:
> > +      - description: core registers
> > +      - description: irq registers
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  intel,has-mst:
>
> Mostly this looks fine, but this property drew my eye.
> Firstly, I'd probably call this "intel,multi-stream-support" rather than
> "intel,has-mst".

Sure,

>
> > +    type: boolean
> > +    description: The device supports Multi-Stream Transport
>
> Secondly, there are many many configuration parameters for this IP,
> but you have chosen to document just one.
> Are all other configuration parameters currently in their default
> states or ignored by the driver? If not, please at least document all
> configuration settings that you rely on - for example the max stream
> count or audio packet encoding.

I looked at all the parameters listed in the user guide, and most of
them don't affect the driver. I listed the ones which are required,
and added support for the remaining ones in v2.

>
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: SST main link
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: MST virtual channel 0 or SST main link
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: MST virtual channel 1
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: MST virtual channel 2
> > +
> > +      port@3:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: MST virtual channel 3
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +allOf:
> > +  - if:
> > +      required:
> > +        - intel,has-mst
> > +    then:
> > +      required:
> > +        - ports
> > +    else:
> > +      required:
> > +        - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dprx@c0062000 {
>
> "dprx" isn't a class of device, please try to use a generic node name
> here.

I couldn't find anything in the DT spec or any other similar examples,
so I chose dp-receiver.

