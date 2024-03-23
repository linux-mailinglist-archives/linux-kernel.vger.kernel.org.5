Return-Path: <linux-kernel+bounces-112172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF453887688
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14C11C22A47
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76331C06;
	Sat, 23 Mar 2024 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrO3NjeB"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD7DEC2
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711159246; cv=none; b=AAcg2q/I7cwW0VNJv601IXwdQJFVFpAKJ+60h6+U2ph6+yhM2fjZPrPURsrIBg5rbO+v8iPimkRfaiGBXDCSPFLByj6sEqOjplTU6mvQKfHTJbqEyEH9779C486AhjNl38GwDHgJ/ERcdMEw7ZofG5lSql1SWEuKRtMJYtaEK0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711159246; c=relaxed/simple;
	bh=x+FdX9DQdTFaHf4AamxvgZg5mk3QbFF5nbQKe4Tw0Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZVu1nd/3biECcIRn6iYDZDYaxT2bKISEBb+glMSDNsbiJaSdB7wtOuFHnq0cVh/hq/ZdmP+Mh6+l8ogqr+q8KI85jBswLL8ME6ipL6PEtmHRiG+YBUznrmSTTbK6N3obFEe+/z3LYe2LTImMN2Q/EX6nd8kYZ3d1c1LeYabceQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrO3NjeB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ee0c326e8so67771cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711159243; x=1711764043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+FdX9DQdTFaHf4AamxvgZg5mk3QbFF5nbQKe4Tw0Hg=;
        b=FrO3NjeB1p3HNQ7n3aAwsjvbCZYdBqLycBLD1KhKgeBahgxAdugvWqpKS0O16MFlBE
         m5TA6QyHm7dzZ9+abrCQjRWy+wDOOUCUpxoujnCkxhDbo/rMecG6bNLYihZWErrah9t4
         frSTx2wt6393IX/JZWngN78P0cCGJmY+GRXUuADHYqZKIUPiabLUyk+lwG4Rmy1xPF8h
         y/YFeV9zsJo9eAI4DjlGmYYY7x16urD2Q5HtvStYAPI8egl4FFScYRdE+A6q7m2+0FTf
         +3CKkwU7dl2Wqx9jghR0vMLkmIJxf8cZNRLzlCWMsRTfYkoeEZSpLg9+jzABoTtbQaLJ
         jEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711159243; x=1711764043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+FdX9DQdTFaHf4AamxvgZg5mk3QbFF5nbQKe4Tw0Hg=;
        b=i4CwI18K5eWRP/qXaDtCAsLG67B77HhZEfx0OD3Ug32zGMRssIbyP3fQDeFcM+iTsB
         rDNZFJ8GQsOLl1+ukloQyDio4YYiJW7fb3F90Sv3V5yhxLL2MYETtF5Hq8KCeK0zjqR0
         ajEFNUZyG8Plzhqj1MfjmMOJ3s8RQsaTqpxnYDAhtz85JoOfvC0vvPRrNUbxwiq3kOOZ
         5Dlns6OagINotoZjM7OEBeOjYCuXdd+rWMNjpPg57pHyiP4ScFp9mj2I8C4Pl2hBbU5l
         pIG4pEUwr8VepKuRvN00cAVwgOR31VQ24lpa9/vKuPVImdNZzMr1Z2sgVq731qd00ny0
         qkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX946IXGn8zCpJwhRxO3pGPaiP9NxOYveOGbM/tFPnxr+jX9JNTApKJ1WQVo+RxYpiBdbfwtwzN9xlxXELic8mKbeaxsKAdrxWovyCz
X-Gm-Message-State: AOJu0YxWs0xFREu7sjbgSQS6IbcCKGaRdB0D4y7fC3Qrd06xjI2EYQ9J
	RdIipcRGqNHogOSFGN1pnF1ass5PFvmsHZxIGoTNOAVAVTcrmXIPI5/VZEc/HsKKZCNt4lI5H2G
	0n3j+5JDezQvkQGbQuVI5/fz2zJA9EhUtBQT5
X-Google-Smtp-Source: AGHT+IHEu5RsydW1nGrf112JXAAobeSfXYgjaT18QBQKEPz/AjPpVseTu9jTurdFvMxJjea4j9qTo3T86+aT+MmmskM=
X-Received: by 2002:a05:622a:5cb:b0:430:ed37:bad0 with SMTP id
 d11-20020a05622a05cb00b00430ed37bad0mr663579qtb.13.1711159243461; Fri, 22 Mar
 2024 19:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220111044.133776-1-herve.codina@bootlin.com>
 <20240220111044.133776-3-herve.codina@bootlin.com> <CAGETcx_xkVJn1NvCmztAv13N-7ZGqZ+KfkFg-Xn__skEBiYtHw@mail.gmail.com>
 <20240221095137.616d2aaa@bootlin.com> <CAGETcx9eFuqwJTSrGz9Or8nfHCN3=kNO5KpXwdUxQ4Z7FxHZug@mail.gmail.com>
 <20240321125904.3ed99eb5@bootlin.com>
In-Reply-To: <20240321125904.3ed99eb5@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 22 Mar 2024 19:00:03 -0700
Message-ID: <CAGETcx-oMbjtgW-sqzP6GPuM9BwgQrYJawpui3QMf1A-ETHpvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] of: property: fw_devlink: Fix links to supplier when
 created from phandles
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, 
	Shawn Guo <shawnguo@kernel.org>, Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org, 
	Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:59=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Saravana,
>
> On Mon, 4 Mar 2024 23:14:13 -0800
> Saravana Kannan <saravanak@google.com> wrote:
>
> ...
> >
> > Thanks for the example. Let me think about this a bit on how we could
> > fix this and get back to you.
> >
> > Please do ping me if I don't get back in a week or two.
> >
>
> This is my ping.
> Do you move forward ?

Thanks for the ping. I thought about it a bit. I think the right fix
it to undo the overlay fix I had suggested to Geert and then make the
overlay code call __fw_devlink_pickup_dangling_consumers() on the
parent device of the top level overlay nodes that get added that don't
have a device created for them.

I'll try to wrap up a patch for this on Monday. But if you want to
take a shot at this, that's ok too.

-Saravana


-Saravana

