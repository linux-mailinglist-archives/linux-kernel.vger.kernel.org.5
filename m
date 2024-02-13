Return-Path: <linux-kernel+bounces-64511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB09A853FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC351C27D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C9F62A01;
	Tue, 13 Feb 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIj0CLI2"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BDB629E3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707865733; cv=none; b=pkgWANOthOQ44zmXqfJds4MzhbweKKzJCb7kcq+JIyu0EsL73N+Qr/TI0n8H6jNHWCvkalO2N5KOmDhXWwDlgXnYhtclPeGbllGBmmCJSv6kdTjYkKBbYHZ8DE/iuFrdqYHsltxgZ+Kj7F5GdGhZ39GaZt/ZVFSB5BDBuU29zHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707865733; c=relaxed/simple;
	bh=tVloHGKUehuApsaPOPySRHcT35thEmrZ6ArHLcRSLjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqPUVi68zZn3SCb14TKr/Z6z4BiBxRAt8M+1Xv3owx1UjviBXpkXjhTrRltfsrr6nmNN7Y/hWnEBJQ9Wxn5OzQYw9EcLVfDye2jmh8DU2Y6HAhuraECbWzGN6b6t3w75bmr0b7tOi6p6SWtgu/d1Nj0MMk1lEoa7I80+ZeXK3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIj0CLI2; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d8bd612dso4814814276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707865730; x=1708470530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVloHGKUehuApsaPOPySRHcT35thEmrZ6ArHLcRSLjU=;
        b=bIj0CLI2rk3m/mXn1xYEKjbm/NdhNO19lFjMy6JWhpx1uRzbk05QMoLGsI+X72P3i0
         wOOcPj/Gdih6N0DdmvZ7xWd+rnqq6hpUUo8gMWjpGDcVR1qMaQWDjLGd5fcQMUYhfEh8
         TabmRU9kNtrmkCJ8yf9hq5yYWXtPSpz/RFd2GZnzbVeBLVIRgWlJeSNK9ngO3EkZZSha
         GIT25PKmLwXT3PYJ864BK8N+TpN4GVM3pswQ5Htr4dvoFyZjD518yznaMAOJG6NhKSyy
         m0yuhcOR+EOCR16FvW4LM87vsLctti8c/tGcY4zO7w82dCebl+bZBSgSrgoDTUVmzdWg
         KBdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707865730; x=1708470530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVloHGKUehuApsaPOPySRHcT35thEmrZ6ArHLcRSLjU=;
        b=sBB9QJFk0HjOUfapvIEOamVSJzZr5/1yMieIkuX3RGxhGV0fcnVPIRaO77WLcMO7Av
         gsN5yNXLVx3K37Pj/pF2HldrlIbAYxlddmCxNA3ekrvOALNVYZjwXDjeI1tmLh/J211u
         TOTYtlHpr7UYuKfhW9XEG/ukmzgzOlpoeRssbHGgsUH//5hseLZ821ys4x5mASczxgjj
         3+OvhlP6B+/TR4EQlXGeNHHrzLpilC4yqqsumEkdQgpeTkuhzS+09CfSszcTio6M52kE
         E+KGAPvC/ne8uXlX+PY43eOHEYCz/mKPsdVju/BfvB5qXTbaqiV+KeHDKLuTTOvILvCV
         6LIg==
X-Forwarded-Encrypted: i=1; AJvYcCUGEmt/IjfGS33wQ6ThLoJ0KzlqdeIdtYP+H3Y685mz/mPmmTIWVmVfxd0H3wgYja09UZESBWCeOTGLhOn7hyZ7z1z+1wEikVKyUwcS
X-Gm-Message-State: AOJu0YxOO7b4P/Cjd4Ka0zyr1gtX76ub+ZSilnDv7MadFvvUdqYpfRfj
	kGuypifGJzHRQw20nfanKRm1CYmfg7DKEg5VuWgZD47qbOWLoPRsDI0IlEat7E6fbE/IJ/nFiBq
	tUOCSiINwsiiA/QHgg7K0sHdcN0exmrKQTbj+KWBYwqI1nB7uGp8sUQ==
X-Google-Smtp-Source: AGHT+IHldCihTNKaP18UJpjk4/sdZtLc1mDrS/RakLJiAv29JiA03nQSoi7wCPuxhOwqi6f7UndIkebfjzz7mXhdkpY=
X-Received: by 2002:a25:684f:0:b0:dcc:8c7d:970d with SMTP id
 d76-20020a25684f000000b00dcc8c7d970dmr534160ybc.47.1707865730573; Tue, 13 Feb
 2024 15:08:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213220331.239031-1-paweldembicki@gmail.com> <20240213220331.239031-6-paweldembicki@gmail.com>
In-Reply-To: <20240213220331.239031-6-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 14 Feb 2024 00:08:39 +0100
Message-ID: <CACRpkdbY+pbU76VpneBC6h4HJ9gjn5YPe7gh9iOcPFJt2FBVkA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 05/15] net: dsa: vsc73xx: add structure descriptions
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:05=E2=80=AFPM Pawel Dembicki <paweldembicki@gmai=
l.com> wrote:

> This commit adds updates to the documentation describing the structures
> used in vsc73xx. This will help prevent kdoc-related issues in the future=
.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

