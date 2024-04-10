Return-Path: <linux-kernel+bounces-138248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5E489EEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2AE1F240DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0E155396;
	Wed, 10 Apr 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6JDi3vc"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5D1552FB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741012; cv=none; b=ZMUHfZCzwVLx2zUAVwO6dpabdPCNgpOrXpqwgWVjiA29a2CQEsF1ZJjIiH8nFF+YxkbDLLkIyXwaheCat/CxesfBEfvFRRxg1DyNxtn9k914CQYBfeFZNgyHMfsWaB0/9ToxML4uoeaIiHLa/ERdh9oLmORHPl5E92BlXzSqRas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741012; c=relaxed/simple;
	bh=1dJzgv7gstQ/rUrx8GEvorTXHkgctjla3Zt8plI3ASI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iJlofSL59zYgfdoyJ1og/X/fB5Z5J9rOkL0kWPdEyHTsMQfl994iuEcRfSL5G6dfA7lH2VeVqPvikYTOSFzt8N18CAOcGki+jfzP/SRsg4jo/SFe2GiKAN8jogMKYB81YHx0CP8SviLjEtHn7OXgdzWHAFrO3MxHVzgfJHCJY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6JDi3vc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2a536b08d63so1930792a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712741010; x=1713345810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKpQ/L+90YOrIxKPpVkHyeppvZjvg0QRhX3flaz/X3Q=;
        b=Y6JDi3vc74vdD5wTLc5Qrdkp5vKd/pURTUur1aj/HoP1DbH68KK24s9q5O7KK62oh1
         5i1hLzahcoCR2L+5ipIvI178yGstWdCp2gUhLISFLT2wEE53NfrXZRvgGZIkUUVr4fXW
         1p2U0gt01D+RtvatO5ust/1z23mv5eZSGlJ8cTEuXXJVmqKBeIg6tMIIRwtwwEdAajDI
         ubX3iFH9Jndu2jCWDwFkycZTq05K/dhNBUQLvx2/NKWVnYExicRIoIi3LyV9niDrrNal
         WrRFcia7xC7TaMD33YOJJKpnp63etVWF1bUtvxuGkz+KIo6WBrU85hb1rCW4PGyqCN4q
         L6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741010; x=1713345810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKpQ/L+90YOrIxKPpVkHyeppvZjvg0QRhX3flaz/X3Q=;
        b=af1UBosQrkhD8K03E4OLcEt5kgfUg7dXH63wOq65qr8oIfXzrx7RnKfQ1y61j82an2
         +HujilSgrbNEf0W7NbKmb8CcBZe+R+i5XU9ZhqkNZFqQaCeHKgV+lv82/2anRqgnsMXC
         5Aq7T0tIEnDGCGRjF2FdwwlVC7rgPHibrIhXvijT/zk83R2HPR3R/gQhdVXnvVh59X0F
         kiDYg9AmQ13bo811r8H1eI5It7JogK3joq6LbNOEI5QQnKkxOYZgPfyjpckKmIowrH2Q
         j9t6winYOAcSPkwI8rCx1Z78WbV6GMIGUQzSfvaIEFwkTsKEMX6TGopR19NpOpcKkvtf
         7Jig==
X-Forwarded-Encrypted: i=1; AJvYcCWbRtGFKH4znNIG7I6mShl+71eu4tYhxIVigypZbciSHjRzKcAtJR/AjGZY9L6MjB83UeFmqRSh/Wqc8O9xXsYdVOHQIjmYcMwmabRV
X-Gm-Message-State: AOJu0Yyu2o+j6NtXbtpsNOJKdpxndj4XqFNgQzwL1XtoTFk7Pg0DEw1Q
	UfIvlUqEGjDBnbO3Ec1pA/+tEsASw520abNw7bI0w2f6nri28CH/iUT2D5a7xiih/IdIT4QR+GQ
	fUyte2Nw7nU0yLQiKtrUZZ2tpnWL2ozqm4AKaCQ==
X-Google-Smtp-Source: AGHT+IElz4DqrpJ78tcUJP8vBVt1F3CCqpzdboJS4Xw/zdtxyKv3r/O2V8DOVdDDoRjGh/Au6/LTGURoB0u7Q1jOkAo=
X-Received: by 2002:a17:90b:1b08:b0:2a2:1900:493 with SMTP id
 nu8-20020a17090b1b0800b002a219000493mr1789164pjb.40.1712741009799; Wed, 10
 Apr 2024 02:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410071439.2152588-1-yangcong5@huaqin.corp-partner.google.com>
 <20240410071439.2152588-2-yangcong5@huaqin.corp-partner.google.com> <0eed83f0-5f5e-41b3-a66c-f46845ddc3a3@linaro.org>
In-Reply-To: <0eed83f0-5f5e-41b3-a66c-f46845ddc3a3@linaro.org>
From: cong yang <yangcong5@huaqin.corp-partner.google.com>
Date: Wed, 10 Apr 2024 17:23:18 +0800
Message-ID: <CAHwB_N+X5v3nFhtWTH8TRv8to2tcBTu8hn1guGXa7T-MuV3L6A@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: display: panel: Add compatible for
 BOE nv110wum-l60
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	dianders@chromium.org, airlied@gmail.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi=EF=BC=8C

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2024=E5=B9=B4=
4=E6=9C=8810=E6=97=A5=E5=91=A8=E4=B8=89 16:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On 10/04/2024 09:14, Cong Yang wrote:
> > The BOE nv110wum-l60 is a 11.0" WUXGA TFT LCD panel, which fits in nice=
ly
> > with the existing panel-boe-tv101wum-nl6 driver. Hence, we add a new
> > compatible with panel specific config.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  .../devicetree/bindings/display/panel/boe,tv101wum-nl6.yaml     | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/boe,tv101w=
um-nl6.yaml b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-=
nl6.yaml
> > index 906ef62709b8..50351dd3d6e5 100644
> > --- a/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.=
yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/boe,tv101wum-nl6.=
yaml
> > @@ -36,6 +36,8 @@ properties:
> >        - starry,himax83102-j02
> >          # STARRY ili9882t 10.51" WUXGA TFT LCD panel
> >        - starry,ili9882t
> > +        # Boe nv110wum-l60 11.0" WUXGA TFT LCD panel
> > +      - boe,nv110wum-l60
>
> Isn't the list ordered?

Sorry, will be fix in V2 patch . Thanks.
>
> Best regards,
> Krzysztof
>

