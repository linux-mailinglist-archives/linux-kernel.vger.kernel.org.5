Return-Path: <linux-kernel+bounces-96453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7EC875C64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD6CB211FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16F28DD8;
	Fri,  8 Mar 2024 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dLdTOEbp"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6F288B0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709865879; cv=none; b=O4/D/gPJ8KkNwWJSSRSiugt05e/w/K0e1HE/RWmPJD87fHxqvSMkhjDExnC3jL421K0j37/WhoU1fEVCZ/kLDciYaaHywz+LRmXLAP+8oOMMeLRgQ2P8gD7QhBleCpu2RZm/1OfOsQeC8Cs9uSgckMvoIMnXk66RB6MmYpvZ3FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709865879; c=relaxed/simple;
	bh=fSQs6edR7FFIscZnvuVJJSuwUJjidAWISLuv00JfLLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQWIQA/9t+RZC7zEKkg4WcdYkc4EKT3h5v7isGud7ulQoimOl6Uhi0cv210SI4k5xSIe2Ttv/B5dVsCb2D+6XwW6z6rEMmy5aZ0aeVNpdROgLA0GGURBMnB3wF2rZ/B0vFknkQm9jb/h7L1YQSmVh+5WW8sOUvy21E689WwfWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dLdTOEbp; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6908b540cdbso7248886d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 18:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709865877; x=1710470677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxG3C1fNlHZOl1qKhga4bIFtxN+IbPgWY3WbkNFh0bI=;
        b=dLdTOEbp2ObpxZMn65sla/kwZo6SneJwaBY+SudLypUyHvMOSCEeN4xn4YWfHFBd4N
         yTIlUFeOilOHkSzLYd0Mx/LAuT0UaxY6A3u25gaWYJtiWRt0WyjSGCbPMJv7RmQ3p8kC
         faLO6wPkQ9o+Vafd/0NPgBdXI1yPEQVFxKEhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709865877; x=1710470677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxG3C1fNlHZOl1qKhga4bIFtxN+IbPgWY3WbkNFh0bI=;
        b=nRo+8LORPb7ik9nk5DpBYHULWbgYM36DfS4IUDtLmocOQRfZ6olGOMCxreLCC8vh1f
         /DupFDxoxw9YcvQNG+Hf8oZmsBjnam0LS1C1fvbMXE+o2iEQJvLkdxUpfWIkRWB+19Ns
         A/NfeYbSnpOwdDCc8ZOjFha4dHbyzpxYxpFy4Y8/UDaCDhk3gMiolP8XSjHMh3OAsHws
         iCX9O7fA0iSwFaNXDzXW2PhxaQPn6vpFbb+SEwKyTsgL3NRVI/fYbmwcjTo9umAf1TRz
         JYX/GKs5qJafguPxtHO0J2CE7fngU/jT8iOLqRE/wj8qgJR8t+Qmm6mqCxp/IXJYPfep
         ysXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAV8XGPbbC0G3oS+YbfMcJAgBTVgBLxFQSRnmkPssJacto3nEMeMtmPP9mgJk2ikldHc0qElHjozBnwrc4ZvVS/5Cr2hVsMGivKai6
X-Gm-Message-State: AOJu0YyHP3wykeX/96bRu2NDgkUvDZXCE8D52uoPpG5nsO+M4PYaTBjp
	re1gYcgAl9JQoGaSsFiAkfGg2c0T42YrYAzyAjDRWRlM32MfK1RGDiCVKlsm2bO5BYEXXUl2P33
	uYW8IB5ELYsAaMID1eAy57h/iBWtVPKQnI1v6
X-Google-Smtp-Source: AGHT+IHLOplxAthwVDMa5iIYXqMD2Wnv9EgNG65kksgNcwXIp1Hft/8lhsMRr2JKI0egPut76qGLphqo65qwRyxwU6g=
X-Received: by 2002:a0c:ec47:0:b0:690:aaa8:a019 with SMTP id
 n7-20020a0cec47000000b00690aaa8a019mr2720578qvq.47.1709865876833; Thu, 07 Mar
 2024 18:44:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116172859.393744-1-sjg@chromium.org> <20231208150042.GA1278773-robh@kernel.org>
 <CAPnjgZ2i4gvgiUeHPOfHuOdBooV4e=QQEq6iMo0JbDwOS6dCwA@mail.gmail.com>
 <CAL_Jsq+xMZ8yz4H9D59uCSyX4h5W+4ruGF++=wVA=msXz+Y01A@mail.gmail.com>
 <CAPnjgZ1uW8T6woXSqFUNm301=W3zBYOrADREkrz=DuwSW87qZg@mail.gmail.com>
 <20231214172702.GA617226-robh@kernel.org> <CAPnjgZ2oJSGPO91Y_aLbe+v250WFrND4n3T0mOvhERYidVu=eQ@mail.gmail.com>
 <CAFLszTizRRVbRO6_ygE2X-Lp5dENWSc4uMGL5GPJAFGAbRdCyQ@mail.gmail.com>
 <CAL_Jsq+j7_KZtQ2ENq9+vsw0LOZF=spu293_G=AxOmBM+m_f-g@mail.gmail.com>
 <CAFLszTimaFw9sf=JKvQXG4fS6V_2T=2n+pfvYLCiuG1o+7cHPA@mail.gmail.com>
 <20240205085056.44278f2c@xps-13> <CAFLszTi+8ygXOidnhxj7sdJwc6X5i+++QvnUyfe-kde5eSts_w@mail.gmail.com>
 <20240205131755.3462084f@xps-13>
In-Reply-To: <20240205131755.3462084f@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 Mar 2024 15:44:25 +1300
Message-ID: <CAFLszTh3t6wPz8PFhFzazTAGaLVpObkjY9qv7MtSkQ21zZFzKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: mtd: partitions: Add binman compatible
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>, 
	Michael Walle <mwalle@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Pratyush Yadav <ptyadav@amazon.de>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Miquel,

On Tue, 6 Feb 2024 at 01:17, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> > > > > > > > > > > > > +description: |
> > > > > > > > > > > > > +  The binman node provides a layout for firmware, used when packaging firmware
> > > > > > > > > > > > > +  from multiple projects. It is based on fixed-partitions, with some
> > > > > > > > > > > > > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > > > > > > > > > > > > +  avoid perturbing or confusing existing installations which use 'label' for a
> > > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  Binman supports properties used as inputs to the firmware-packaging process,
> > > > > > > > > > > > > +  such as those which control alignment of partitions. This binding addresses
> > > > > > > > > > > > > +  these 'input' properties. For example, it is common for the 'reg' property
> > > > > > > > > > > > > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +  Once processing is complete, input properties have mostly served their
> > > > > > > > > > > > > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > > > > > > > > > > > > +  firmware update. The 'fixed-partitions' binding should provide enough
> > > > > > > > > > > > > +  information to read the firmware at runtime, including decompression if
> > > > > > > > > > > > > +  needed.
> > > > > > > > > > > >
> > > > > > > > > > > > How is this going to work exactly? binman reads these nodes and then
> > > > > > > > > > > > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > > > > > > > > > > > specifc parts needed for repacking.
> > > > > > > > > > >
> > > > > > > > > > > No, they are the same node. I do want the extra information to stick
> > > > > > > > > > > around. So long as it is compatible with fixed-partition as well, this
> > > > > > > > > > > should work OK.
> > > > > > > > > >
> > > > > > > > > > How can it be both? The partitions node compatible can be either
> > > > > > > > > > 'fixed-partitions' or 'binman'.
> > > > > > > > >
> > > > > > > > > Can we not allow it to be both? I have tried to adjust things in
> > > > > > > > > response to feedback but perhaps the feedback was leading me down the
> > > > > > > > > wrong path?
> > > > > > > >
> > > > > > > > Sure, but then the schema has to and that means extending
> > > > > > > > fixed-partitions.
> > > > > > >
> > > > > > > Can we cross that bridge later? There might be resistance to it. I'm
> > > > > > > not sure. For now, perhaps just a binman compatible works well enough
> > > > > > > to make progress.
> > > > > >
> > > > > > Is there any way to make progress on this? I would like to have
> > > > > > software which doesn't understand the binman compatible to at least be
> > > > > > able to understand the fixed-partition compatible. Is that acceptable?
> > > > >
> > > > > There's only 2 ways that it can work. Either binman writes out
> > > > > fixed-partition nodes dropping/replacing anything only defined for
> > > > > binman or fixed-partition is extended to include what binman needs.
> > > >
> > > > OK, then I suppose the best way is to add a new binman compatible, as
> > > > is done with this v6 series. People then need to choose it instead of
> > > > fixed-partition.
> > >
> > > I'm sorry this is not at all what Rob suggested, or did I totally
> > > misunderstand his answer?
> > >
> > > In both cases the solution is to generate a "fixed-partition" node. Now
> > > up to you to decide whether binman should adapt the output to the
> > > current schema, or if the current schema should be extended to
> > > understand all binman's output.
> > >
> > > At least that is my understanding and also what I kind of agree with.
> >
> > I do want to binman schema to include all the features of Binman.
> >
> > So are you saying that there should not be a 'binman'  schema, but I
> > should just add all the binman properties to the fixed-partition
> > schema?
>
> This is my current understanding, yes. But acknowledgment from Rob is
> also welcome.

I am trying again to wade through all the confusion here.

There is not actually a 'fixed-partition' node. So are you saying I
should add one? There is already a 'partitions' node. Won't they
conflict?

Would it be possible for you to look at my patches and suggest
something? I think at this point, after so many hours of trying
different things and trying to understand what is needed, I could
really use a little help.

Thank you,
Simon

