Return-Path: <linux-kernel+bounces-36020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F9E839A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454B21C23B38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694AB8612C;
	Tue, 23 Jan 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oBa9glMe"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15C60EE4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706041392; cv=none; b=hAzLJAsCTpOvZCtEeuBneaW8Sa8VDTdvK7oEfV9mBTJi3AmeHLSiE6MaN7w7IlIEczrkFUJJKnTodaVmdB3kMBWkh/x91C1Qm+43/Mkdkr6FoRRbCPIyRikkoJHzS7Bo2Ym9tBMc7OzTXx37OcUOJrPeNtJmEPMPmFGfNRB9+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706041392; c=relaxed/simple;
	bh=BqASrS5v3yWPEFqu6y4zqCpxrbcAoTDrMMa4rh9P/3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHO4zPcNScuvL/UrrDkbF2kJ0/lykYIvs1SYGPz04CMT6wHSQkKypOD9gREiJQmNL9ausMo6ou/CuDNyni9DBevZHsEkoBcLyjlhjEkgpv26x5+UiLCfa0mvTSpfpvzkNR7XO0XLVIRTrtqBKgtCvx4DC3TRxaCtLt+8KHjS2Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oBa9glMe; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68183d4e403so27458986d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706041390; x=1706646190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqASrS5v3yWPEFqu6y4zqCpxrbcAoTDrMMa4rh9P/3k=;
        b=oBa9glMehjeCvDo7oZQGymSPQS7/NtdX4hKaU7M34xtkws+Q8TZe15GDIAigIygl8f
         cow+XzyoNsZWOIlusEtfYSVe88AHV33mCpvC4nEWPPQam/HHiMdeUBvCIE5Chut9Qqs+
         U9m5LF+TFtGNL2lyq2pTwmueGgQQkrYLCU1xDVnDessVG7D3hyQVs/iD0VlFyDjtuDzu
         zPUiKdO/eCqyfGAxexBKfK7BX9gXNWLW8iPYOu9278S1cXi2oiNT3W9mExmmUUDy0fGk
         7tdATct7EsOP+tORAp1Np6U/qEMwuyhLpIxHNng7n4KuJI82XjtMSytQJrTrx23pA9kr
         gqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706041390; x=1706646190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqASrS5v3yWPEFqu6y4zqCpxrbcAoTDrMMa4rh9P/3k=;
        b=SjoMt4NhPFzDbicNAJvcvJzzGsVb7vumCWy9RKuRu/sRRi9vIqk6/HW/N7USlxh7v+
         0K7U55xYubmHSw/OKZT0rK1CpFkO1x4jABkuCrBAVhKvZTFRDCq/lDHGyvL9Xf3t96Ev
         LCF1EW29pFPhfAqp8QvPXTw8V2Q5x26FCO7V6LsQskfJ5b2yyePmUJaTMYbPZklkIfVf
         d6HOWu0wgewwrsmW6aArHV+W0mSmVeOEHCHx22ZwnQVokzAhrvcCEN/yff/vkGd4BfcO
         MnXUriyA3/7Ql7XwUSuzLaWvM1JFiuQcbHEgm8i/SABSr/FkhV/sW4l0F1uWiLnCg+d0
         5HNQ==
X-Gm-Message-State: AOJu0YyQfqbHORZEbR0Oig+WbSHfoWa7r38dRzJrGPfVA87vJBXV9qT2
	hIs7SuRQxT6C7B28Wmq8tzFQZYKFVvFY1q50mwqawd6mNk/RajGBdoTdc1h7VRWmU7K2WIKKfx6
	N6hugocRTLQnt9E+wH9pYP9uwhA4JqHkqnv37
X-Google-Smtp-Source: AGHT+IHna79NyELk6+Fcq8hQsna4nxAc71AjuZxgFc8fjxggfR6bowcpQplSGGfvUlte/zTh8cgBUo2A+JI1lpmHDZE=
X-Received: by 2002:a0c:da8d:0:b0:681:80b2:262f with SMTP id
 z13-20020a0cda8d000000b0068180b2262fmr1319326qvj.107.1706041390167; Tue, 23
 Jan 2024 12:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122175810.1942504-1-aahila@google.com> <20240122175810.1942504-2-aahila@google.com>
 <20240122211357.767d4edd@kernel.org>
In-Reply-To: <20240122211357.767d4edd@kernel.org>
From: Aahil Awatramani <aahila@google.com>
Date: Tue, 23 Jan 2024 12:22:58 -0800
Message-ID: <CAGfWUPzuXi+j=JE2Q3ZZ-MCfS84Y9Om5smB9C4Qn9Fq7RLY6=w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] bonding: Add independent control state machine
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Dillow <dave@thedillows.org>, Mahesh Bandewar <maheshb@google.com>, 
	Jay Vosburgh <j.vosburgh@gmail.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The compiler will know what to inline, please drop the "inline"
> use in C sources in this patch. It just hides unused function
> warnings and serves no real purpose.

Understood, done.
I have dropped any inline reference coming from C sources in this patch.

On Mon, Jan 22, 2024 at 9:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 22 Jan 2024 17:58:10 +0000 Aahil Awatramani wrote:
> > +static inline void __disable_distributing_port(struct port *port)
>
> The compiler will know what to inline, please drop the "inline"
> use in C sources in this patch. It just hides unused function
> warnings and serves no real purpose.
> --
> pw-bot: cr

