Return-Path: <linux-kernel+bounces-40448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A94D83E09C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46DBE287D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83337208D2;
	Fri, 26 Jan 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="IfoXomhK"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBBA208AF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290849; cv=none; b=TScx5SlYcu+1dNopotoQUU/EZ5KhZQ1N9+HqoDP+ZRDHB42s6YqHqHzHkAKstFboWEGhEQDuxOCwfr4gx/0+/RwZhGVlIK3bb1Cv03Lb3N5iEV3GlWxph+zZuio2GSmhQPYQ5kOXYnp5rxyjJ6ce6aD7fouVO9EB/HHlYuODxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290849; c=relaxed/simple;
	bh=LYAUFYI3PPskX/K+nNIULnwnwvRLyCKhmBoErZbeIEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqtHVKhW30XqkRLMuqc9g0Q7D/ve84Sa5KdzdHBkqfu0xQQDsKMQCLFyqaq+gnBRrGTET2LCnt/flVxRvK+Fykf28p2AEzdCYeIz+2ZS/lXhyP4NFYCwJUfvyqZLDqVBENcrOuPP8HJa4gVQ/1cLFcLv7WLzioykhaKTkyUEMKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=IfoXomhK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6daa89a6452so448813b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706290847; x=1706895647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nW/G1leX3fQbY5zUt2hlw0gvCqeqoiW1Fa0PytKdtZg=;
        b=IfoXomhKI9nWITFaj3yLc3TfO1vrHGAyjGDpvtIj1witwUaQ3bsEkYxeA0FXYewT0z
         7f5CssJaQAxKG8JsgukzTMQ5RuUQh8xo5pZ5z6I6IBtvs2o7BeTpIUQINvgNBWII7uod
         PqXD4ZLX1TCE4HLYp+PLARaDOWRlbC4LvMX0hdKD4h87v2arLUz9mxAJuW3yCFDv+llb
         MaUyz2pMRsOaeSJpI9pRGZo9C+hq5EAfepa+FnE86y8HODOCUZiePoOwP8xs1/BbOwGN
         R1zAzW30H/k+wdGMLy68VyBtRAknO4M+fVY0XP/gbsz2BpFQ2O8PhVUqCO0q7cO/D9yh
         0lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290847; x=1706895647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nW/G1leX3fQbY5zUt2hlw0gvCqeqoiW1Fa0PytKdtZg=;
        b=KdrgihNDbK9y4GTDZ8TNvcYtTiMu7x0EmaYUdnEUesu80j0DgNJVpvwYcqW687y4U8
         zwT6KHVgjhhMWVgyZJMHa3v4FIvCT/48JsoKvOW/sYgpFOAN/vmAugNjbzXwJ5QtSr3t
         zIjJahPBKrxxuC2L+Q914CnqMWquA21i4M+UWQ+AEMyzolczw0Gj5cKOfWmJYmicdPdh
         wBGnZLmZSZJEMaRi6Wb23jLbBB5ic6+DzcAiKeYcPhQpTa6O+4YvqiV2YkHyEN6M/yso
         5U5bz1D9M/pVTv6O7YMZlaR25E0KfWK4iE5/1mJilrpdZydLZMb6nFBb99K34Hlfa1uE
         pLVw==
X-Gm-Message-State: AOJu0YznllSSvCu54gDu1aBs2BeE/hzWXwJ7d7aw1fPLOTD/CQYm0Q8g
	CjohuSpn+WqIMpR5mkL4Z3VaI4gag6TtIs+TAUCaI9PU9lNAGAfNfwyO4F7gGQncWM8tXfa4Nql
	5XUVPSHCwvdBu4eSyfwVV+BudE+f2gk9ZVLi2eA==
X-Google-Smtp-Source: AGHT+IEcSrQaMAvEaXVvHb7l4qcln7TODr9I1zAzX1B7RypHiTg+jJOTUgiHySRU59MmQB9TqZwYmHPyouHWF5zed9A=
X-Received: by 2002:aa7:8886:0:b0:6db:de89:d0f1 with SMTP id
 z6-20020aa78886000000b006dbde89d0f1mr175972pfe.28.1706290847494; Fri, 26 Jan
 2024 09:40:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126115509.1459425-1-naresh.solanki@9elements.com>
 <20240126-cinnamon-flatware-e042b5773f17@spud> <CABqG17hzZf2mme0v7hALhpd6-N3ZHqxdH-AhFg5eF9sbLSC2gw@mail.gmail.com>
 <20240126-scale-serrated-33686467d91b@spud>
In-Reply-To: <20240126-scale-serrated-33686467d91b@spud>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 26 Jan 2024 23:10:36 +0530
Message-ID: <CABqG17jp6YRGyTmNitz-xDdyhWOPgfT_XpXxw-OJLnXQ777vAA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
To: Conor Dooley <conor@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Conor,


On Fri, 26 Jan 2024 at 22:22, Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jan 26, 2024 at 09:55:20PM +0530, Naresh Solanki wrote:
> > On Fri, 26 Jan 2024 at 21:47, Conor Dooley <conor@kernel.org> wrote:
> > > On Fri, Jan 26, 2024 at 05:25:08PM +0530, Naresh Solanki wrote:
> > > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > index dddf97b50549..b4b5489ad98e 100644
> > > > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > > > @@ -39,6 +39,9 @@ properties:
> > > >      description: |
> > > >        Channel node of a voltage io-channel.
> > > >
> > > > +  '#io-channel-cells':
> > > > +    const: 1
> > >
> > > The example in this binding looks like the voltage-divider is intended
> > > to be an "IIO consumer" but "#io-channels-cells" is an "IIO provider"
> > > property.
> > >
> > > Are you sure this is correct?
> > I'm not aware that #io-channels-cells is only for IIO provider.
>
> #foo-cells properties are always for resource providers
>
> > But I do get some kernel message as mention in commit messages
> > if this is specified in DT.
>
> Can you please share the DT in question? Or at least, the section that
> describes the IIO provider and consumer?
Below is link to complete DT:
https://github.com/torvalds/linux/commit/522bf7f2d6b085f69d4538535bfc1eb965632f54
>
> It should look like the example:
I reference the below example previously but didn't help.
If io-channel-cell isn't provided then there is print in kernel dmesg as:
OF: /iio-hwmon: could not get #io-channel-cells for /voltage_divider1

Thanks,
Naresh
>
>     spi {
>         #address-cells = <1>;
>         #size-cells = <0>;
>         adc@0 {
>             compatible = "maxim,max1027";
>             reg = <0>;
>             #io-channel-cells = <1>;
>             interrupt-parent = <&gpio5>;
>             interrupts = <15 IRQ_TYPE_EDGE_RISING>;
>             spi-max-frequency = <1000000>;
>         };
>     };
>
>     sysv {
>         compatible = "voltage-divider";
>         io-channels = <&maxadc 1>;
>
>         /* Scale the system voltage by 22/222 to fit the ADC range. */
>         output-ohms = <22>;
>         full-ohms = <222>; /* 200 + 22 */
>     };
>
> Thanks,
> Conor.

