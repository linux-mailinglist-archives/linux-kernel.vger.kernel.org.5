Return-Path: <linux-kernel+bounces-109992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630B48858B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956461C2183C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AAD7580F;
	Thu, 21 Mar 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE5wj60C"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73F4757EA;
	Thu, 21 Mar 2024 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711022467; cv=none; b=Osfx1CXEa0QCfHO9mBdldra9c3fe7pGRVmxStTHflY750RancN9JLHG9kpF0BvNYGlcnD2W9trnfOshwXMUoDZQhqAWeb8qdcu0D8DRBdHVzNXvWLdXUqbU57pDA2rte1jGZNjo1tKGPn83vd72ZZHeHFIl6bFc4oD433Lqg408=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711022467; c=relaxed/simple;
	bh=jEAcj7FA1xpGcOnT8Yj8QRxI7X6OlOrv2Im+lb/0udY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzdWrq98ieJdJYhW4UXr/odM9cEkwAUx3w3JdI8/ioLW4O8DL5eQUQPcjiRiC6bv3zn25LbXclubPEkRzP0VGa96TQiy28o23/1x/icBYpG/DdGgu5NycrKiEIkMpgRrmNm5dhIWdi3ZIkHd1c4YzXA/+n5XPqqposaA1AqT0iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE5wj60C; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56ba6c83805so1057774a12.0;
        Thu, 21 Mar 2024 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711022464; x=1711627264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5jo2tFjPMb91hTmox9RMKszVECbzxnaqz/EYbUtdrg0=;
        b=FE5wj60Cw3e+U69mMK7vCdzu7vrXoERsOnVJLRyQ+rDm0I8Q9d50Cu4IhwivzTIdDv
         UjWCwMsSVvlhnFO2E/BhR/jOXuSJd9vcsCAORch5wdc0LJ71akG5fiIAA+HEWb7buce4
         A57x+V10EHjJk8VKyJjUR3XZfjLsY4UVz0otJYu0339Q3Mq7LyEpbkuToZ5Oi6+KVSjD
         8M/iSwV/V2GpWr7QrgXr4CUdc96rckCXpvGjI5e39dcETZ6+16VHCmO8ZSS2oX1z3r6Y
         3OSB3wS9/9z1u2wjYyrlRCdVZV8NF/s8BlxILQkWbAnwffeF5LIaCg2wwRzjCWseKOZk
         gSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711022464; x=1711627264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jo2tFjPMb91hTmox9RMKszVECbzxnaqz/EYbUtdrg0=;
        b=GpAfzX7XiUevqQrL4U6X/n2uvhGEOXGIzEY/cLJc+Ex9M2O0943qEPSHtUyiV/5MDD
         mLBrXUnFGIU1zWc9NleU8dShuf03xEEk3y1oy6Fk+c/esEwiTJhT43J1ozQ/G+oQsf+G
         JKyBVR45504TjH39ibSF8HpHJZGY2vAgmVffxIF5cIuQPn4fr8DChmWcW9YUvevgTVWg
         zpoAsp80PrfsCYsBuR8bFvwI6ABSYjV6J2gYFnhWrK01xSOAXR5jtEkq+6PmuqHxG9b4
         JajCXc4W57LytyAXk3sX71oHoOe/gWPi0pHHDb11XS9gfERR8tvQnqRZCQlcOBwTwvnr
         o8mA==
X-Forwarded-Encrypted: i=1; AJvYcCXtVEHNbeqi26XW1jPqbArsTrqlcUkrResJUmwIDDFFtaOHy0C6pfS7/btlaOH6Hz1EcPBnSh953x2sBW5a3KS3WZERwiY+YEIblPHvC78ER7KHQv63AYEvk8RA/0mgk57qQPMRNRhv01GIfGRuinGlF3680s3GHZeUOFnSCeDZ3Q==
X-Gm-Message-State: AOJu0YwczKeFrh91/gQDyO3Lh+X6XjznVOwht3bLemlHDJ6ohwdMLSsi
	LCOFZrfPFP6udmpvn80LvbcpgTRPGoGvCAzCgL2kj+urKVCKbrkUgDYsJfCuLdiCuYu4IsIynSE
	fNFBD6zyq/1saffzy1SnF7zM5m2E=
X-Google-Smtp-Source: AGHT+IEU3tE0383g6xgf9YKDZI5ZO8Hcpp1K70IDdZx5e0isf2fdROf2HUy22Wmea9BNbWw344w2RE7OC+PV0BGI8wA=
X-Received: by 2002:aa7:d591:0:b0:56b:8439:6d91 with SMTP id
 r17-20020aa7d591000000b0056b84396d91mr4802172edq.40.1711022463791; Thu, 21
 Mar 2024 05:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-1-4d9813ce938e@gmail.com> <171011208646.4168843.11425236211455218194.robh@kernel.org>
In-Reply-To: <171011208646.4168843.11425236211455218194.robh@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 Mar 2024 09:00:51 -0300
Message-ID: <CAJq09z76RXiQ4bii5XhA4DA7EShT9JrkGHFRBLAXBAad_=jBPA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: realtek: describe LED usage
To: Rob Herring <robh@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, devicetree@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rob,

> On Sun, 10 Mar 2024 01:51:58 -0300, Luiz Angelo Daros de Luca wrote:
> > Each port can have up to 4 LEDs (3 for current rtl8365mb devices). The
> > LED reg property will indicate its LED group.
> >
> > An example of LED usage was included in an existing switch example.
> >
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> >  .../devicetree/bindings/net/dsa/realtek.yaml       | 46 ++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/net/dsa/realtek.yaml:121:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
> ./Documentation/devicetree/bindings/net/dsa/realtek.yaml:131:23: [error] string value is redundantly quoted with any quotes (quoted-strings)

Thanks for the tip. I just noticed my yamllint got uninstalled,
probably related to a python upgrade, and I missed the warning.

warning: python package 'yamllint' not installed, skipping

Sorry for the fuss.

Regards,

Luiz

