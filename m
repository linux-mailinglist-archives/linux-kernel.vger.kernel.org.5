Return-Path: <linux-kernel+bounces-89228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3792A86ECF9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F2B284D77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2755F47E;
	Fri,  1 Mar 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VTm+zJzX"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3B3A28E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336361; cv=none; b=EsozqtuM6Nq//w2ZFcGJwqlSC11t/Wc/Jb7FAgWJ0+NUqOEQJ35TpQye/C2ExKQ60hqA6/Ev8NpGbhcqLZMXXh2q/3/TxOyQjwMBAnYzxg+Koa6RqU5PBP7QUD62n4e/JMR+4XG54PMMPeoZkDeQr8nzMVPxRfdstq9WHbJilaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336361; c=relaxed/simple;
	bh=F5BGi56UFoN3qVYxdYvohQcplCXdZ2ZAGQX5Knd7kmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9Xg4Db5Rn54z+75DhybdAm/d+voKkSbItv5IAMs1dh6o5i21NZpVNQUAtmkvJ8Kehst1jajsbxbYBFFMW3Ymx/IgiBTp5cXCWC1Rzsd1HDHPNLutXvB3Hh5mON8sSRMbghbDytalQgfWPeSsAjpKw/fIixGK4rmwv4hyX0CUGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VTm+zJzX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-608959cfcbfso31328637b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709336359; x=1709941159; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5BGi56UFoN3qVYxdYvohQcplCXdZ2ZAGQX5Knd7kmo=;
        b=VTm+zJzXqQkYQOiBLSFiu+/Uvf1NN5hR8Czl7HYRHyKqTewI4qhTvf20XI57x6y5p9
         YVlPhjP4ktAyoU9ZcREOIsSxL8zyxkqJ9w02uz8FeuKwGZSKbEYYi2bEc9qfn1X7XcSb
         wzVD4hhkSMmsyNP+bvgBVdxy7ohKJ8HljTpDvwgHG1uBFTu4KjeoWlrmcVX0e2bT099s
         l3JkeWzn4L7VSSF/liSX+iwKadiTzb3rviX3bX3s/wtNIHp/8vn+p1s3T8Z9y4xUx+K9
         4bKzatERJrismA1SAx8/uDWeh34PmC/FJeG7Vgy8Hjgtgx9EufeSPR4E7CxU3R8Qqfrb
         TqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336359; x=1709941159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5BGi56UFoN3qVYxdYvohQcplCXdZ2ZAGQX5Knd7kmo=;
        b=ksEMqMP5/RDO2U7YYeLofV7q8fJuadL00DLaR/w2Cmkys9V0plbRNn+/tnhF6b6Yqg
         8+4rrd6GdbICUL6SRvVujJE4LsXhHa6wWdCfxpCg5uhi1HM2bEK+knFf4pw6NbOS0vf7
         WutlcQinUXKEe8PYeWdGPyHZ/rQQw4TNL1BURrF+4VAbotqxJDS+6WHJnLeC0T0I/CmF
         gmP8HoFo6rftzCtUSyjgJLc1BoU7d1ZD59AhvlC7gjQ/kwama9TW6FrN3bVmm9WUrxLG
         dbAB/pGI+7P9xtiB2e4iIgY+y4jLhhVA8H7b9fp9vZJCUJPXE/dFGm6Dbl3AjMyX/6CQ
         IfqA==
X-Forwarded-Encrypted: i=1; AJvYcCV3ExpCSO4T7B4vXVAxTTSf15wnXplMxFZXDc3rRhJ7vOtnqFR2RsaCpJq1oSvt2shFGEQGsZ0/ABq/tW3zotTnVDi0o9xLglzCNMw+
X-Gm-Message-State: AOJu0Yy/jbTvigJOJfYJNtZzDw2rE+tMc+MMVVd+wOkkJJj3qtwpZsL2
	QiIGix7rlwMcdeIHrdWTebj7f7PDVCvgzgAVwAGKiELguEpf8OBLqqejAe2IDuGjprmclv7gGZa
	xQIt6xj64WLVjBoXfWoITbyqwBhd6vw5c8+wvPQ==
X-Google-Smtp-Source: AGHT+IG1wAYpSPeLNV9qhViKFblGzTcZfh1NqTOn+pWqUaXBHkulKIKxW9+v6flCOX17DqHUQ/imyBkcESFu5xOm+Dk=
X-Received: by 2002:a5b:ec8:0:b0:dd0:702:577a with SMTP id a8-20020a5b0ec8000000b00dd00702577amr957219ybs.35.1709336359325;
 Fri, 01 Mar 2024 15:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-5-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-5-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 2 Mar 2024 00:39:08 +0100
Message-ID: <CACRpkdbbR-AyCn19C8-uBVmfTJoYL9c3m8Med+aQJfC6HmGb9w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/16] net: dsa: vsc73xx: Add define for max
 num of ports
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> This patch introduces a new define: VSC73XX_MAX_NUM_PORTS, which can be
> used in the future instead of a hardcoded value.
>
> Currently, the only hardcoded value is vsc->ds->num_ports. It is being
> replaced with the new define.
>
> Suggested-by: Vladimir Oltean <olteanv@gmail.com>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

