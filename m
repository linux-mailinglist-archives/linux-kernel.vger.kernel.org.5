Return-Path: <linux-kernel+bounces-139959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F08A099B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A181CB245A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F315B13DDD2;
	Thu, 11 Apr 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="ZIuRE8mM"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E313D258
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712820231; cv=none; b=P5sjDXOj7pUARwKTcTHrZEu/XOdxpFUhZmk+0nLiGsfQpTLlpgu22cvN9AshuochOtLWIIZNG6ISwmM36ZQ7laxA64Pwvu5Kr6tpgGtqHmTRBpzNvZxR6kwGVlhhCFBKzPgIhjpDNAkYpsRxfFQXsJ3+qVBYbsLYieyyVGxeIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712820231; c=relaxed/simple;
	bh=gGeW9R0z/8e8cHc5xDnZttqxGEuV/KvsYGHiztgMhTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZBeDpZS0nPVua6pXXwCllc3WiRvDJfhZ7rC7U5KB6y1fQHBCjqmRfbJmv2N1p+cfAkxGeXEpBCVJqb2K3Ur6nErVhMtfxaqJYYR+k3uVR685JcYz2zllKehfSQMKzHVmv0MKi1JAwhM1eanHemgwxRF9yhU0saVuz5s86GbD0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=ZIuRE8mM; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516d756eb74so7062238e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1712820227; x=1713425027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkOVgTaaGrXLtVM87ktxrc8mZTfhRT2o4/E/F6KN6Bk=;
        b=ZIuRE8mMVj95qNAJ+4JMQjCiskC8DYJcoS7RvE/RZhRzzXicB7E8OJjIupVoq9b6Ob
         DDGQENAO7Ec9Ma/gqm5Tv4i9yRl8MUrQeTu3kNJATJpQ2Tt0a34rkyCPeLdyb07R2Mam
         0W2ohISkv1uFb8oSRvZzcKsDXb41kYCoHzP2JsoG7Uz+T4CSJOi4ZFab5NORH8uxod8j
         3ViwcjafBqOwg8S56tpULmiX+BClJp1SepH9XNQoHwD1KKO0kawVmM5sVu6abdbO/oDi
         d9LNDQbJELk228BYO7GzxoOx1ggZ00CEwYBhkM90d3PRGgu7jItcwvC5yzENgC/CSPxE
         4JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712820227; x=1713425027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkOVgTaaGrXLtVM87ktxrc8mZTfhRT2o4/E/F6KN6Bk=;
        b=uNIrR1tRuPUzy0bmrg9aQ+ymALKrzqeHB+PDbDoRQ8y5HwzVnC0FyitT6LqzApPYFZ
         Fs0FzSF/SQFdaKPQi5oqpERh0tlJt+JI3q0NIVi6KvpBBPbmyu4khAhi5TA4gygUltYG
         xZOmSs6feSKC3j+V6MyLwMMt8rZS4cKiNRHw+FY/Ia+rJGChCbDqAWDZvg4JaeJmSMkL
         pW72gfeGIab5KO6Olze6zPc9RSstZ6jfopwkGqGnn2EcPV245CiWyJAHVwDjv7GBo2Pm
         ZmrzxSz7fcLw/0z00qTgHCc3ads3QXOiizgZASBxdWiSm1apqZnbchtnIKS4L/54tVQw
         BO0w==
X-Gm-Message-State: AOJu0YxnafOxHKX+yII40IiT1Q7OW/HKRzv7CoY8ZxA/CtKtMCpK375u
	kJ8F910URKJuou+n/NLR0oT5yQkAb54yXyihFiBDb3XDARIxgfbur+OQsNlNinNfVGudONU2m4E
	K2C+EVeoOCuYIF0kClzruFnRY7Cf+YkqRHRmxxg==
X-Google-Smtp-Source: AGHT+IFZZUKJ4M2JhpqzsUa3DBvNjlIu3bgNrsSmIxv09/CKGpbc9Zg/QoI/y4VRWj7pcSaPz1WFPMmYuLejmaOVLVY=
X-Received: by 2002:a19:f70b:0:b0:513:b90f:f4dd with SMTP id
 z11-20020a19f70b000000b00513b90ff4ddmr2683370lfe.49.1712820226865; Thu, 11
 Apr 2024 00:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402105925.905144-1-alex@shruggie.ro> <20240402105925.905144-2-alex@shruggie.ro>
 <dxm3js6qpcw3n4duid4vmhnkxacmzgq4rnvpbdx62pcn34ybzc@q57pst7lyumf>
In-Reply-To: <dxm3js6qpcw3n4duid4vmhnkxacmzgq4rnvpbdx62pcn34ybzc@q57pst7lyumf>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Thu, 11 Apr 2024 10:23:35 +0300
Message-ID: <CAH3L5QosgOBTYgyHUcstNqh+JMBW93j+dk2JuDhdz1=Sfj8i_Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: display: bridge: lt8912b: document
 'lontium, pn-swap' property
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, adrien.grassein@gmail.com, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com, 
	marius.muresan@mxt.ro, irina.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 11:31=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, Apr 02, 2024 at 01:59:25PM +0300, Alexandru Ardelean wrote:
> > On some HW designs, it's easier for the layout if the P/N pins are swap=
ped.
> > The driver currently has a DT property to do that.
> >
> > This change documents the 'lontium,pn-swap' property.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  .../devicetree/bindings/display/bridge/lontium,lt8912b.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,l=
t8912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt89=
12b.yaml
> > index 2cef252157985..3a804926b288a 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.=
yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.=
yaml
> > @@ -24,6 +24,12 @@ properties:
> >      maxItems: 1
> >      description: GPIO connected to active high RESET pin.
> >
> > +  lontium,pn-swap:
> > +    description: Swap the polarities of the P/N pins in software.
> > +      On some HW designs, the layout is simplified if the P/N pins
> > +      are inverted.
> > +    type: boolean
> > +
>
> I'd like to point out the standard `lane-polarities` property defined at
> Documentation/devicetree/bindings/media/video-interfaces.yaml. You can
> define and use it for the corresponding endpoint in the lt8912b schema.
>

Ohhh.
Interesting :)
Many thanks for pointing this out.
This will make things much easier.
Will do a V2 with this in a week or two.
I'm traveling now.

Thanks
Alex



> >    ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >
> > --
> > 2.44.0
> >
>
> --
> With best wishes
> Dmitry

