Return-Path: <linux-kernel+bounces-44549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1A6842415
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE501F28381
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB10679F6;
	Tue, 30 Jan 2024 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Lze2ElgB"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9526775E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615346; cv=none; b=YT2pQiKwYNYos2N2BfFBfnH+gisb6vKLoswRzEYNuukk9cidm2PaL8yTJNtLNxJLtdajOKOd6PO/eygQUd6Sx8w+sycVUPSxAQk+mFr0+UvlCMB0xNN8Pp6sXrq91F3nmFO8mVk33Mc5W2zmPPtA6zm53NszRs0we5Xxtoo4Oak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615346; c=relaxed/simple;
	bh=djJj9XRuv56D+Yf0tvte/Y0cLXHAVntDU34fYEL78oQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHrHKm4xMDcTT+xeBbuQ+NUt8h6qAAMuUw1mvyqj+50GKNEcVGb2o8GINun8xadm9jqaMhuqkTZTIvosqd3N6B9wV+wV6u8Ds+9rBp27KzgmmJS57Zd7Us57TG1X2wvUWhgMm7k9hBK3b2W9iwOiJ4M61dtuhxQYGrxdzeZwDC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Lze2ElgB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2901ceb0d33so3621344a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706615344; x=1707220144; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/i4SzQBJoQr/W4/YDTog7lCCv9zfgdmkWanXeduZ2I=;
        b=Lze2ElgBX2tXPOvb0d3CaA+Z5+31LuiWq7aoIXScg9+N89zoJ+LRi7iv/cEigbPMgb
         E8bFqKjLQ0BSY0sJ0zg9LRcus2vOfa8VkLXM3ML1zyOzL5AI+JCAZaAE9eqpYtD7G6oJ
         hpKNUKnFliya23fgSerjr0tKCd7KYVZT6C+Qaa3YaRwZVJsszroiDGQe+Q5qPpnEk4gV
         dChpG/MCF3ooP4YczpbZlSTi2LKMsaW5RJc1ulPqkuKR4BnoBGCOF0JshVfs/NtfsuAZ
         CrnnHxx/IDPT6ka1nYM806+bkauCel42Mgqc0Eiy5jE4oIXNqFaBb3b8YKpjzyW8CdYK
         FIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615344; x=1707220144;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/i4SzQBJoQr/W4/YDTog7lCCv9zfgdmkWanXeduZ2I=;
        b=MENSh/hL8nVbC2k6ubEsrWrlwUT4gLZvS8HEcL6onR+8z9c8RJwOCqdEFkaIM8NLEP
         qdI8L320bJkPav2wVR45C5UVoe9Ew6u+5Nsch+DCQibn+FCewnzBc42pfkj5DSrM36uv
         k+Jxr/nRwv0/+O/+lUMVlR0TdViFEu9NO91tJwaMaH3zbEFHB72Fybc9CSSnNM8NA2si
         F4k9V7qIE/mJG7q/jG8CX8SKCvH284qRqrRu16p8oj/VQVaFG6NVdsKYUMEM/JYdZcUh
         cdSwYHXz0fbqALX240xkSwZiM+lc31XQuIqEPbbsVeukuS+1dTSEEeifjoX0Y11Xz2+N
         KVuQ==
X-Gm-Message-State: AOJu0YwMKC8rEOPsfcIon3nxR9VPQBWHr1CpTEZMMNFNtyd2Duz26Jb3
	f+pU0vHrIvoLjQuABBrLTQpLuunzOY8gnNenG/9D1KLPjXRdjRBS9OXxvL+15Y4A37b3o7a18tb
	iXPHVsuSTwFPIaRPQsnG0BhNK60/XV1l0YPmdNg==
X-Google-Smtp-Source: AGHT+IH77ZXfkrGtYR4l5SkakOL1AXdRhX+06Z4lEU8XqFeiImXFjxCQGZeFc+X+5lQM13TrnKG+PTTtrEkaQCnpWRk=
X-Received: by 2002:a17:90a:cc06:b0:295:3d98:68fd with SMTP id
 b6-20020a17090acc0600b002953d9868fdmr1399215pju.28.1706615343870; Tue, 30 Jan
 2024 03:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130111830.4016002-1-naresh.solanki@9elements.com> <49bb7b5b-4186-83cc-7e1e-4892c7e8b6ef@axentia.se>
In-Reply-To: <49bb7b5b-4186-83cc-7e1e-4892c7e8b6ef@axentia.se>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Tue, 30 Jan 2024 17:18:53 +0530
Message-ID: <CABqG17g70GDU3_DbJbEnu4-9a3aJBSFFXuYKBEG8MJpVfOjMGg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: afe: voltage-divider: Add io-channel-cells
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	mazziesaccount@gmail.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Peter,


On Tue, 30 Jan 2024 at 17:12, Peter Rosin <peda@axentia.se> wrote:
>
> Hi!
>
> 2024-01-30 at 12:18, Naresh Solanki wrote:
> > voltage-divider is always an iio consumer at the same time it is
> > optionally an iio provider.
> > Hence add #io-channel-cells
> > Also update example.
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > ---
> >  .../bindings/iio/afe/voltage-divider.yaml          | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > index dddf97b50549..09f10d7c4e02 100644
> > --- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > +++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
> > @@ -39,6 +39,13 @@ properties:
> >      description: |
> >        Channel node of a voltage io-channel.
> >
> > +  '#io-channel-cells':
> > +    description:
> > +      In addition to consuming the measurement services of an ADC,
>
> It doesn't really need to be an ADC. Anything with a voltage output
> channel works (in theory). But sure, normally it would be an ADC...
Ack
>
> > +      the voltage divider can act as an provider of measurement
>
> a provider
Ack

Will update as:
  '#io-channel-cells':
    description:
      In addition to consuming the measurement services of an a voltage output
      channel the voltage divider can act as a provider of measurement
      services to other devices.
    const: 1

Regards,
Naresh
>
> Cheers,
> Peter
>
> > +      services to other devices.
> > +    const: 1
> > +
> >    output-ohms:
> ...

