Return-Path: <linux-kernel+bounces-166117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5458B9670
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3BC1F23DBC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B0B45C04;
	Thu,  2 May 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="fosqzzER"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61C200C7;
	Thu,  2 May 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714638610; cv=none; b=FsqLyPZjXpJly8d2uxoCAMg4sqOqsiRl+JJNbPDKen2sXUrTDAFkVyapQcP1S4HyFAcQvXeCq1wU798QWrZCoThLIelkW2kY8yb1FnkCzvjEz9MlmmhIDm8hkFTccEmNP4FJN1kYcKt/+aiR/rgIX8xrTppjjro/5MfLABMs8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714638610; c=relaxed/simple;
	bh=IKHhctVrpWhcOboSLMZaryI2v9hhTEGATCQRIQX0hq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwZMy4FRBGe6MDtgnvHYzT29dLxVGRhkjerlvpkfC0YkqudxR5ZJtcknpWjLoLxVIs1BmUAGhTIiqBXUwW6qE79Kk0r9DYoCuRWuxcbSOR74R4eSAS0pb5YT844y5rROpd7+EMIKg3vGJiXOxx2QnRbl0NZquUQJksVTG2ftfAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=fosqzzER; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572babec735so874804a12.0;
        Thu, 02 May 2024 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1714638604; x=1715243404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcS37ofGtSGOaqbMmyUYN9nLzJNBzaZA8qq8/HQQjPU=;
        b=fosqzzERnc/xEzPWjlcsxQo3nnWtAQlvc3HYfPteSUN/03iZNUZWKdNbto5GggDoGL
         nX24qq77SicHLCd9VphqfActfnG9Qq2RF5GGDccpXNTlnMijIhvK8d43mexa0Woj2lxn
         QIrhbifsyuKMOMw0NV+gVLMuJ7U/jTkFJaKaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714638604; x=1715243404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcS37ofGtSGOaqbMmyUYN9nLzJNBzaZA8qq8/HQQjPU=;
        b=M39Iyw4+V639i7S5D87AIWvzWEavzD1P09SJM1glVhApTgySGvgyGvsxvoFOyI70u8
         AjO7DAkkLe8CwOtlgpkr6JKzutwlQIJmWpMUqpjrVceHtroY1Fq1iySn/m1CW9cmkyXR
         zwNgv6dUVpj1Q/m9mMe1NQFPwl+BuWs/07wytwX/u/8SSn5eSAMMrsMhHkyoRxcjscdk
         TIaMbvrkRHMHXwCuF0/7jTf9ewCS2RVTn4tBt9Y1ct2hebSsQqYWxxEE8adqWS/xr46V
         Cae5bRKGlgmzipKKu5pbvZnjiX0Br05LZvXFgsfgcgGm0V4W6CiUYHZ1kLYupv0q9RPj
         XLaA==
X-Forwarded-Encrypted: i=1; AJvYcCX18mP0+9fcbH+KKnkUf1NVzwTs1gEvUjvR2LdsamQUCZe2gMtiTa/YsV7szKtWxcei9nZUL23e48R/efUXU08buhFO2s/JrwIUX3R+jyzSzl7WezOPicK0CVe63wsm8R3tW4mdRj2f+w==
X-Gm-Message-State: AOJu0Yx5i4IKTu2luMMdh1drlCtqDAo+QTa1eadwt7/lJj9cLkApM2WP
	v5saVSXuLTYoKBtJjskwCepys4XeHcou3mH2burkFr+f11N29WrkPwJv1pRPrzJJaTs51WcA45i
	fVzwVCAXjf/NBMdCqmlGa4od5Lxw=
X-Google-Smtp-Source: AGHT+IE7PXs7Cu+sBWPGxvQ8zk0DGcZNvv6VeR1g/mLA+ZLjmhg+6Kp84MHM3XAzW8rbbeT+KWPAZfh1Yj4u2YTFJBU=
X-Received: by 2002:a17:906:3b4b:b0:a58:f186:229 with SMTP id
 h11-20020a1709063b4b00b00a58f1860229mr1782860ejf.0.1714638604139; Thu, 02 May
 2024 01:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502002836.17862-5-zev@bewilderbeest.net>
In-Reply-To: <20240502002836.17862-5-zev@bewilderbeest.net>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 2 May 2024 17:59:50 +0930
Message-ID: <CACPK8Xe9BcFziQTKA2FrQq6GT1aWeSirDrWTNBh8b+HwcZzctg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ARM: dts: aspeed: Add ASRock E3C256D4I BMC
To: Zev Weiss <zev@bewilderbeest.net>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 May 2024 at 09:59, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hello,
>
> These patches add a device-tree (and a couple tiny bindings updates)
> for the Aspeed BMC on the ASRock E3C256D4I, so that it can be added as
> a supported OpenBMC platform.

Thanks! Applied and pushed out.

>
> Changes since v2 [1]:
>  - Added patch 1 adding isl69269 to trivial-devices.yml
>  - Adjusted isl69269 compat string to use isil vendor prefix instead
>    of renesas, dropped unprefixed entry
>
> Changes since v1 [0]:
>  - Removed bootargs [Krzysztof]
>  - Renamed LED nodes [Krzysztof]
>  - Added function & color properties to LED nodes
>  - Added #address-cells and #size-cells to FRU eeprom node
>
> [0] https://lore.kernel.org/lkml/20231114112722.28506-4-zev@bewilderbeest.net/
> [1] https://lore.kernel.org/lkml/20231120121954.19926-4-zev@bewilderbeest.net/
>
> Thanks,
> Zev
>
>
> Zev Weiss (3):
>   dt-bindings: trivial-devices: add isil,isl69269
>   dt-bindings: arm: aspeed: document ASRock E3C256D4I
>   ARM: dts: aspeed: Add ASRock E3C256D4I BMC
>
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  .../devicetree/bindings/trivial-devices.yaml  |   2 +
>  arch/arm/boot/dts/aspeed/Makefile             |   1 +
>  .../aspeed/aspeed-bmc-asrock-e3c256d4i.dts    | 322 ++++++++++++++++++
>  4 files changed, 326 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c256d4i.dts
>
> --
> 2.44.0
>

