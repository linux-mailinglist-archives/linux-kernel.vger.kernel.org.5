Return-Path: <linux-kernel+bounces-138245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5189EEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791ED289280
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044BC156C6C;
	Wed, 10 Apr 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOZwytox"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A88155306
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740860; cv=none; b=VGQTLJ22ZR3PPArqVjPCm/nir4Rz60ap2XvYB6aNuJiEUtkjrf+i7UJyeC0pWbeSrUm6SqD3Zp/nZVaYf8bXWNO6ZF5xbbbRL1mNZMVpNWOFhbulzat/0nq34U0XjGqi3rNFsH2dt1HMWDaCug4tZqBq+kt6x52/dtsmiIvq+98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740860; c=relaxed/simple;
	bh=O6XERnHnMwc1UPkJwA7M4dMe8kK/+Z7/oP46jzawayI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eB07NVk1VA8YfEDcFuYMKmkf6cNuABxLJbhNcQlOl7sXf+97REDCpFFdE1lo0Uxuxtq94AK70kq7g20Dw5428ZJIiAZW97dni8lHiCaQF3PS6IT4FKEiXQH6ThHa1WclVheNW9igbNYUaVQcFlEJaTYClYeq0Q3ofhbRiiSWVPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lOZwytox; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so77584461fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712740857; x=1713345657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6XERnHnMwc1UPkJwA7M4dMe8kK/+Z7/oP46jzawayI=;
        b=lOZwytoxyU/pUArKN0fsqC4w3VprMSwPRtA+1E3nCcqB9vASpxZg9ZjMAc9sycmCE+
         CyGqHi0R9pEbPYlNwJ1mP0K3f421voB6BD3sBBUYkHgA82eaeKk/Lh2rbD1+MmW1HKu3
         ABwWcQBSPeNQLgb8Jxt+uPtzGbgU2D2Cv1HdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740857; x=1713345657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6XERnHnMwc1UPkJwA7M4dMe8kK/+Z7/oP46jzawayI=;
        b=NcolE/urRlOk9HE8BnhynmfIdj0ccswde+DDtUANgYb3Jzo44VgT5gPLtavp4/cXDU
         G6Z6nwRZfbHTDrF2eUI0/dZd9uCGhN1xxAuLFaPqHbYpSgE1Lw9ahfBbJFr1AEqQmgBh
         7LMLQry03PWAudoyqCe+9AT3c+bf/nOq2B62P/kAl6klc/RAsmfDFCGvJBTLDTBHc6UT
         0wWpYKBDaqmA59KdWKKKNHjNV9qSq0P45CttHyPcb1/tRC+tFTudRX6s6t/v2tl4uM+M
         rAl8/jNEO32Vc5VaI0wijADi4p95ppJ8nX1jDcsx1TRbhEZLgpdX30kc8kzrusjMQoGW
         My8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx2FpGqwFBrUgL7bXWDpINS61Osyo8vnD1EZOqaGsQWodLPrAw+E35yS8qfwWxufTcTzJalUfl9jVYZP/P/fuRBagadiHjt58ErADZ
X-Gm-Message-State: AOJu0YxAKA+rFajeeL4vnZjIdFbkE3FvfItBl8ToThbP5oOaVg+RetAY
	PzYZifGql0rJ5I3R7pCAwR3eEBbvOKqQL+TrZqEOM19xPQ+ldHvFSw+UFrgjwk29wuM98Nq1XlU
	rx8j0beD572Xjapwk7v4bSQLLvMdH3uEIXrT8Ml3RvoA5Z1FAwQ==
X-Google-Smtp-Source: AGHT+IFL6KPS7uL0x/EtSSqM+BxaTQB6YKxFAO4dVgt7h/JSlGs8pTFg9ELkmasVKscLtesWpTkQnSz+ws7ho1rA6oM=
X-Received: by 2002:a2e:9913:0:b0:2d8:2fea:2e4d with SMTP id
 v19-20020a2e9913000000b002d82fea2e4dmr1821870lji.2.1712740856858; Wed, 10 Apr
 2024 02:20:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240410084405.1389378-1-angelogioacchino.delregno@collabora.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 10 Apr 2024 17:20:45 +0800
Message-ID: <CAGXv+5FJM2_yr0dwD=FhaDi4FJzYn50=jY6fJsFnder2q7TKrw@mail.gmail.com>
Subject: Re: [PATCH] power: supply: mt6360_charger: Fix of_match for
 usb-otg-vbus regulator
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sre@kernel.org, matthias.bgg@gmail.com, mazziesaccount@gmail.com, 
	gene_chen@richtek.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 4:44=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The of_match shall correspond to the name of the regulator subnode,
> or the deprecated `regulator-compatible` property must be used:
> failing to do so, the regulator won't probe (and the driver will
> as well not probe).
>
> Since the devicetree binding for this driver is actually correct
> and wants DTs to use the "usb-otg-vbus-regulator" subnode name,
> fix this driver by aligning the `of_match` string to what the DT
> binding wants.
>
> Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger s=
upport")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

