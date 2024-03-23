Return-Path: <linux-kernel+bounces-112484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9E8887A68
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 22:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEF6A1F21710
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B74757315;
	Sat, 23 Mar 2024 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dfit5m+P"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48B1A38FC
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711228345; cv=none; b=MJxPErtCAGoTr4kTgUcWj0VLO4hCYeE8kEoT5NKUDpTJMZGeTCHjKuMKiqANt3Il+Gp2RjdR16CPDjY59COR5WWkcKQIXpXKcOabsyFnhne2Z9bIe+umTqtJqobfnuzvsxVX8MB/pXTEDPlNpG6y5NFsoaCqAdyHa1FuTUuw7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711228345; c=relaxed/simple;
	bh=8KR4aIuTObNMIZnYJHEp/oGzvWujJwiW9zUrN00Y0aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NotVMcBd+VkbOgVoES8CGtUMzJRZ2GIZDZg497LR5stkayr6i+NH4BEfEkRsdhSAo/aVRXrcdVKfgPdN92c2GiCdc03YY3YlAZiQMP3IzKqN3Gj38JZRWA5kc+rvQWYAZ+g2XNQY/qRHyjvHBJ0e0mjSSIUhvSpx+wtvgKDQVzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Dfit5m+P; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60a0599f647so30256227b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 14:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711228343; x=1711833143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Y3ciYm0VxZfrPijrgMTJyMdjg8ZrAzLnw8EK162/0c=;
        b=Dfit5m+Pmr3dpiSh9d2JXKJRXjte4Y6efZAXVNdneO3ljOmWNifAjRBLxexUC4ZpJ7
         vCXVhw8xH5hCTIPt+KH79RqvTJLhBefHdGSLl1A/gOfix9SgH/jvH65aPsnISuQ7cK8U
         U9ozo86o8OgJVb22J3Rav3u3SPUIk1YaQTa0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711228343; x=1711833143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Y3ciYm0VxZfrPijrgMTJyMdjg8ZrAzLnw8EK162/0c=;
        b=TyjnDUs5RGwDuE1TEGvWj/r+xeibmgOd0v1I8gIuyTqd1GdeRx8MDQCstWCX3yJ9Uu
         faVw9ITNYPX/AASUpT1G9QctX8mcBHoA1VypgEwp3ck3X9Qw41It3SwGpzWdcdSTDjS0
         mPQtd+tb+skDTFZ+8Ev/kwMt2pSw8qpaWogSuyrGY8UXhgSNJqczF/NX26ygPKA3ZXs+
         Wf3FWR2UNNNCqeOxc0aldfLpDAAK5+gOobDGCx5BElvpk6hlrITFQOQSnxoMOc/0+YjU
         PXf3jNN/pdwDteFMuA8irnNW1aPYrZd50Bg5gW69W2p22XlQkQ9aHNLja2sMumGPkVZq
         x8MA==
X-Forwarded-Encrypted: i=1; AJvYcCXoYWvl7iqYIFx6Je3FRtrUpR8BLsyRiHt88mXiAnAqdK7j0+tH2v2ZdnMcxi0g1JZ/Cvff+9DYdUWc/VYuOy/v6IU2fsZz75AiyIPh
X-Gm-Message-State: AOJu0YzN/dEVcwYDZrY+UCSMkMaptovVUpF471k3qUgSwGAoMaKRAEuD
	QjLQA9au26wYwKxQWOiMe92rlE02Clb+K9Hyi1ZHdbyQ9GQeauytexZTEVqBJcaYpuFS5ZY8T5J
	XHkJ4seSftbjUpdxbO9/zBNF4Mnw2b+4akA+H
X-Google-Smtp-Source: AGHT+IEDJszqpW1tP+cv5jXC4Oabaq1P2MqF2oGnuJi80CpG95eHJKzJDW7qqZ8SP+4LnF8HV/fDKJZxwXd9lg8KfQI=
X-Received: by 2002:a81:8404:0:b0:609:f898:9832 with SMTP id
 u4-20020a818404000000b00609f8989832mr2972227ywf.23.1711228343188; Sat, 23 Mar
 2024 14:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320052449.175786-1-sjg@chromium.org> <20240321133905.GA1622174-robh@kernel.org>
In-Reply-To: <20240321133905.GA1622174-robh@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 24 Mar 2024 10:12:12 +1300
Message-ID: <CAFLszTg4UUhcs_oG=vq6ZuiyGfAGn015Usn58gYtGqKqLvNWUg@mail.gmail.com>
Subject: Re: [PATCH v9 1/2] dt-bindings: mtd: fixed-partitions: Add alignment properties
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
	Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

On Fri, 22 Mar 2024 at 02:39, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Mar 20, 2024 at 06:24:48PM +1300, Simon Glass wrote:
> > Add three properties for controlling alignment of partitions, aka
> > 'entries' in fixed-partition.
> >
> > For now there is no explicit mention of hierarchy, so a 'section' is
> > just the 'fixed-partitions' node.
> >
> > These new properties are inputs to the Binman packaging process, but are
> > also needed if the firmware is repacked, to ensure that alignment
> > constraints are not violated. Therefore they are provided as part of
> > the schema.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v9:
> > - Move binding example to next batch to avoid build error
> >
> > Changes in v7:
> > - Drop patch 'Add binman compatible'
> > - Put the alignment properties into the fixed-partition binding
> >
> > Changes in v6:
> > - Correct schema-validation errors missed due to older dt-schema
> >   (enum fix and reg addition)
> >
> > Changes in v5:
> > - Add value ranges
> > - Consistently mention alignment must be power-of-2
> > - Mention that alignment refers to bytes
> >
> > Changes in v2:
> > - Fix 'a' typo in commit message
> >
> >  .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > index 1ebe9e2347ea..39c7d7672783 100644
> > --- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
> > @@ -57,6 +57,57 @@ properties:
> >        user space from
> >      type: boolean
> >
> > +  align:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
>
> Shouldn't this and the others be 2?

It could be, but 1 means that there is no alignment and is a valid
value. I don't mind changing it if you like.

>
> Otherwise,
>
> Reviewed-by: Rob Herring <robh@kernel.org>

