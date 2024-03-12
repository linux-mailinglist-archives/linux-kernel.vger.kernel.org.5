Return-Path: <linux-kernel+bounces-100885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B47E879EA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C06C1C22340
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3144CDE0;
	Tue, 12 Mar 2024 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KvjyGu41"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954BA1448EF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282357; cv=none; b=QYckYjZrBbz5eIipEP/PPLQKpfJPTUe9R1v9oAfeuMNFKf5tAPUWiuQfvmtwkqgvHGx2osXqf1FWtyHh/G8BerS2GDyCnaO4ENDX33sDnWqC1PCADvDt9pzAlfxGx6Y2EM9HviW+yLcfeqfSfWPGTS2CcRsia8kRk7wYGy0NxVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282357; c=relaxed/simple;
	bh=NLduQ1qqi8G4d7ARUwsnkK5vON8Crq0A2u8yvVgVLio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VORpUScplCgidpprrOwUtxq8D4uB5yrbNinsQRgBdV2aKwJzq8Y0vzU1aY20SPhv5ya1pVtfO2urwFWstFB4uqXwldJzdykmGTF/KUPwMh3G7DXaMbFO/Z3pndmUd5wnJ33NWXDOnlCpkv4a45sC3EyXCbe3Z4CSPcNN/9PTE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KvjyGu41; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690b24973beso2631026d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710282354; x=1710887154; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OzQZAVQefo3mI7JaOv3i9HOffYntNfvUVWBj/1pTaQU=;
        b=KvjyGu41fyxAaBplH63kSqctY+kOsTiquLwH4ZBvO31IBw7LuQuPPLloV8kQvv5HmA
         5b6bVFPPs2IfNusicO15hXr6S4vGMPAKtK6FjGh+CZ6T1Rm01opWxu2v9nciP+9LBOjp
         vrou5mo/njzUEYnN0Xq0MYopSSPbwak5Bw6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710282354; x=1710887154;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzQZAVQefo3mI7JaOv3i9HOffYntNfvUVWBj/1pTaQU=;
        b=VJ23FWrZC5LRJjRKLLAvPE0o5CdDdUpFvN/YU3Vc7R9EARd6L4Z2sAbZqD1v7ZuU2/
         2l9KgrtC5kCatFgvs/H7Yp4lm5+xgccF7/V7L+5lOFQxdTvm8k2TpFYdG2aIeTPBhQ8e
         zv1ph2ldSITSFsspV0mQ30Irg5ssmW1sqVaNOkFjvr2cmNyWhQz5Ss82qNZllaH7/3yK
         HYVzjiJLZ4ESkV6WH2ru6xmeY0swutnTPRLb7OTHwQH8XU9oNkme5kbBToDbUtO2JjFh
         2E8Guj9EYnDCsY50KbTEdmRp8sB4F661AHdYSQO6r9/hYl+jdHurh3E25zuYsVWKrqrZ
         bQLA==
X-Forwarded-Encrypted: i=1; AJvYcCXkE3QIeP7O5A52ZGmEDxh5n1bHtM+FoVNTpbRFZbyk8koi3H21bzOzOJ9A36R4jFwnyKW7uIkpITl/M1CY4MqmMCeznJnrdyR6AiCE
X-Gm-Message-State: AOJu0Yy47Yxh2vcwXewOIDJ7fbd/F3UAULElnAOeAnClCZKTw5BPeOrm
	A9PyJ5yj9W8zfRtdaWyO0JvGp50K9F/dsNbV4NWAsz95p7s6yrStsrv2bkoVDMsICVD5xyQEIZi
	Af5qoiq7N0vgQYHp5qDvmbVBXGg5GQjmIMe2p
X-Google-Smtp-Source: AGHT+IGmyFqJ7I5OEdlVeWDP4fniRKop5+ziAYZpGgboPbvZWq7MrHq+rtsBULHzzfs4hoNrK7NjvGlYv1SDUXqSk04=
X-Received: by 2002:ad4:5c48:0:b0:68f:dde4:fb12 with SMTP id
 a8-20020ad45c48000000b0068fdde4fb12mr1707180qva.9.1710282354445; Tue, 12 Mar
 2024 15:25:54 -0700 (PDT)
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
 <20240205131755.3462084f@xps-13> <CAFLszTh3t6wPz8PFhFzazTAGaLVpObkjY9qv7MtSkQ21zZFzKA@mail.gmail.com>
 <20240308084212.4aa58761@xps-13>
In-Reply-To: <20240308084212.4aa58761@xps-13>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Mar 2024 11:25:42 +1300
Message-ID: <CAFLszTi8w4gBoa-6uoKUN-Ng07ieA+DXy3gm2cdxfwgAybrgsQ@mail.gmail.com>
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

On Fri, 8 Mar 2024 at 20:42, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Fri, 8 Mar 2024 15:44:25 +1300:
>
> > Hi Miquel,
> >
> > On Tue, 6 Feb 2024 at 01:17, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > > > > > > > > > > > > > +description: |
> > > > > > > > > > > > > > > +  The binman node provides a layout for firmware, used when packaging firmware
> > > > > > > > > > > > > > > +  from multiple projects. It is based on fixed-partitions, with some
> > > > > > > > > > > > > > > +  extensions, but uses 'compatible' to indicate the contents of the node, to
> > > > > > > > > > > > > > > +  avoid perturbing or confusing existing installations which use 'label' for a
> > > > > > > > > > > > > > > +  particular purpose.
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +  Binman supports properties used as inputs to the firmware-packaging process,
> > > > > > > > > > > > > > > +  such as those which control alignment of partitions. This binding addresses
> > > > > > > > > > > > > > > +  these 'input' properties. For example, it is common for the 'reg' property
> > > > > > > > > > > > > > > +  (an 'output' property) to be set by Binman, based on the alignment requested
> > > > > > > > > > > > > > > +  in the input.
> > > > > > > > > > > > > > > +
> > > > > > > > > > > > > > > +  Once processing is complete, input properties have mostly served their
> > > > > > > > > > > > > > > +  purpose, at least until the firmware is repacked later, e.g. due to a
> > > > > > > > > > > > > > > +  firmware update. The 'fixed-partitions' binding should provide enough
> > > > > > > > > > > > > > > +  information to read the firmware at runtime, including decompression if
> > > > > > > > > > > > > > > +  needed.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > How is this going to work exactly? binman reads these nodes and then
> > > > > > > > > > > > > > writes out 'fixed-partitions' nodes. But then you've lost the binman
> > > > > > > > > > > > > > specifc parts needed for repacking.
> > > > > > > > > > > > >
> > > > > > > > > > > > > No, they are the same node. I do want the extra information to stick
> > > > > > > > > > > > > around. So long as it is compatible with fixed-partition as well, this
> > > > > > > > > > > > > should work OK.
> > > > > > > > > > > >
> > > > > > > > > > > > How can it be both? The partitions node compatible can be either
> > > > > > > > > > > > 'fixed-partitions' or 'binman'.
> > > > > > > > > > >
> > > > > > > > > > > Can we not allow it to be both? I have tried to adjust things in
> > > > > > > > > > > response to feedback but perhaps the feedback was leading me down the
> > > > > > > > > > > wrong path?
> > > > > > > > > >
> > > > > > > > > > Sure, but then the schema has to and that means extending
> > > > > > > > > > fixed-partitions.
> > > > > > > > >
> > > > > > > > > Can we cross that bridge later? There might be resistance to it. I'm
> > > > > > > > > not sure. For now, perhaps just a binman compatible works well enough
> > > > > > > > > to make progress.
> > > > > > > >
> > > > > > > > Is there any way to make progress on this? I would like to have
> > > > > > > > software which doesn't understand the binman compatible to at least be
> > > > > > > > able to understand the fixed-partition compatible. Is that acceptable?
> > > > > > >
> > > > > > > There's only 2 ways that it can work. Either binman writes out
> > > > > > > fixed-partition nodes dropping/replacing anything only defined for
> > > > > > > binman or fixed-partition is extended to include what binman needs.
> > > > > >
> > > > > > OK, then I suppose the best way is to add a new binman compatible, as
> > > > > > is done with this v6 series. People then need to choose it instead of
> > > > > > fixed-partition.
> > > > >
> > > > > I'm sorry this is not at all what Rob suggested, or did I totally
> > > > > misunderstand his answer?
> > > > >
> > > > > In both cases the solution is to generate a "fixed-partition" node. Now
> > > > > up to you to decide whether binman should adapt the output to the
> > > > > current schema, or if the current schema should be extended to
> > > > > understand all binman's output.
> > > > >
> > > > > At least that is my understanding and also what I kind of agree with.
> > > >
> > > > I do want to binman schema to include all the features of Binman.
> > > >
> > > > So are you saying that there should not be a 'binman'  schema, but I
> > > > should just add all the binman properties to the fixed-partition
> > > > schema?
> > >
> > > This is my current understanding, yes. But acknowledgment from Rob is
> > > also welcome.
> >
> > I am trying again to wade through all the confusion here.
> >
> > There is not actually a 'fixed-partition' node. So are you saying I
> > should add one? There is already a 'partitions' node. Won't they
> > conflict?
>
> Sorry for the confusion, there is a 'partitions' node indeed. This
> node shall declare it's "programming model" (let's say), ie. how it
> should be parsed. What defines this programming model today is the
> 'fixed-partitions' compatible. I think we (Rob and myself, but again,
> Rob, please confirm) agree on the fact that we don't want to duplicate
> the fixed-partitions compatible/logic and thus the binman compatible
> was rejected.
>
> Hence, in order to move forward, I would definitely appreciate an
> update of the fixed-partitions binding in order to support what binman
> can generate.

OK, so I think my confusion is that I thought you were referring to a
'partitions' compatible. But you are just referring to the name of the
node being 'partitions', with the compatible string being
'fixed-partitions'.

I believe I can make this work by adding a new 'binman.yaml' with the
compatibles that I want to introduce. I cannot change partition.yaml
since it does not itself specify a compatible.

>
> We are here talking about the output of binman, not its input. TBH I
> haven't understood the point in having binman's input parsed by the
> generic yaml binding. I would advise to focus on binman's output first
> because it feels more relevant, at a first glance.

Yes that is fine.

>
> > Would it be possible for you to look at my patches and suggest
> > something? I think at this point, after so many hours of trying
> > different things and trying to understand what is needed, I could
> > really use a little help.
>
> I hope the above details will help.

I think so, thank you. I will send another version.

Regards,
Simon

