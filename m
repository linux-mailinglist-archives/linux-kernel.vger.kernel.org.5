Return-Path: <linux-kernel+bounces-137892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF689E90A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B4971F23973
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 04:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8255FD30B;
	Wed, 10 Apr 2024 04:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CG27sSJQ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0E5C8E2
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712723905; cv=none; b=lRB6cqnqiMV3lKJtamqcbtsWrmSsmln+jyPxSiUECqZG4yi6aIAxKbsUyp2F+7XW/hYdT7YIaph1gfQr5ADJDkwx4cjetguFbdcxl1BySWyNX4ZaNgHDLwUaOAOd28UB/XbYa+KLRwXGt2P9F/Q0mjMyBnzpBf6Ynp60FUM/jL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712723905; c=relaxed/simple;
	bh=GhLfFhswyuT6yatVhkdfTmGtXJIemf7JS4rdcw6A2kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owy9bivxxBB2BrlOCUEAyzmW2Azn5dBwgFH+7uQXFgT2t5F4xu8NH65oXrDAwgfn8BjE+0wTum+Q/yYWdXkKKoQVxv4mqpJWNNy7N9XpUahdR5PXSPMZ8tXqEICYECpoEwbOHORFN2+PGC9l+jy4QSJT6ep1AphJG6kCha+7AV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CG27sSJQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso7294778e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 21:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712723902; x=1713328702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TKJkBRRRuNaS92klijTOM4fdg+X+Lbr2orTtPNdiy8=;
        b=CG27sSJQeoQ3cBwZde3cgTHEEf1WZppaVMy/IvFaOL7R/mBCmTojZEk/o89BIzJoxV
         9GAb2/1IN6M3uhPOuL4PTvTvd/taRC/HpYaVyvNE/kBiBYm/TYye3YuF7TrRxT9imniy
         U7SqFhjvKigGtr054+fFGdiTQ3VTJ0M4xG+tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712723902; x=1713328702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TKJkBRRRuNaS92klijTOM4fdg+X+Lbr2orTtPNdiy8=;
        b=t6igAkd7aBEM7RAKIbVMI7u8/b4nhksm/w/iJT19LM0ZjtS+hhjPo/ramNn03AFCUB
         QqdVB4JBneJdvyOMEraCaOwk+ZWdqAZpvN2navyAvk1kinZhPPvjKgNvLSDrJ5cPNu0H
         vKxER/IiaaJVQ4BlSfiQN9958oZOrjcWIpwm0+0xNhKsXVtpxS+Iwk4LuAspp7KgrOff
         z6jJIb0zGx74d021WVTw8Bdh0W6y1NiquZinPrYWaTpWg/Xk/YbAZCatAZxM8BQFEoDk
         2fhmVeCdWo4cPd8PenfxWz7IsjU/+m9b85qLzyLshbMjZIHgloEtqkis2Jgun5Y6s2k3
         +6JA==
X-Forwarded-Encrypted: i=1; AJvYcCVkbyOd2E/xG1BY9Flc/bJi0FVu1ISpyStEJGI+sp3/i7SwN7NrAY1y7vafAQ6ytBLmXBPnSM9jxoQbdE++U5IfdOZRXAY4QGD4jqay
X-Gm-Message-State: AOJu0YxY5iZomyx0ptcOcsQrW1c9Qw4gb9TyAoLAofk3OU8ARkCIEtZM
	YKEKxIY10E7TVnnSm+g87O/jlNGtrcrJ/ZTHI+0sO5D+m0gv9UIL1kdugEH72VicnULvgW/+lFS
	nr6i/LpbmHQn9sFTjAfPbQdkPzil/MzovUuxz
X-Google-Smtp-Source: AGHT+IEfhT9L1lVwha8NF93s8qNR0rQx1xZquNhLUkjAkkjDod/md17HI/TEr2fAp5m3WSO3Hk99DnE+Z0bxhgjxKDo=
X-Received: by 2002:a19:3852:0:b0:516:be41:5092 with SMTP id
 d18-20020a193852000000b00516be415092mr1096245lfj.13.1712723902339; Tue, 09
 Apr 2024 21:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410000730.628043-1-treapking@chromium.org>
In-Reply-To: <20240410000730.628043-1-treapking@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 10 Apr 2024 12:38:11 +0800
Message-ID: <CAGXv+5ETAPVRuWaLDFJChpa55tYDACNzXQdE_-ubSjL=L8tpVg@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Remove redundant
 code in lvts_ctrl_configure
To: Pin-yen Lin <treapking@chromium.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Minjie Du <duminjie@vivo.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Alexandre Mergnat <amergnat@baylibre.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Balsam CHIHI <bchihi@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:07=E2=80=AFAM Pin-yen Lin <treapking@chromium.org=
> wrote:
>
> The removed variable assignment is never written to the register, so it
> has no effect on the device behavior.  Mediatek has confirmed that it
> is not required to initialize this register for current platforms, so
> remove this segment to avoid confusion.
>
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

