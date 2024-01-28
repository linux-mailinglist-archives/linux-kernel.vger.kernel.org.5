Return-Path: <linux-kernel+bounces-41478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DC83F281
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA42CB22B0C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 00:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F9ECE;
	Sun, 28 Jan 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pdtjoKed"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6637FD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706401437; cv=none; b=qckbFRuFhsqXIX7YQDhcr+3wPf0xW6W+EW3K/PZ1kjisvjSgM1vwQUOL4IotVYGjK98Ebm9cPLq5WhlFReQ+eAsLVbbdeRWNCNYcYd0cFB83YHj3l/fwJpRbJXYWBgXEqFIorzC5MEjwUQO3INcZn8e8eSKWAYvPYrgxX0CCgUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706401437; c=relaxed/simple;
	bh=6cn79PSQbiyI9xUwGkC6M8lExc7caTDC3ieGKYceHIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFaq1+8mPubHTxLdUz8BULKLrXbJPMUJaqB3NMIYIVCUR0T7FCCWfnFn1sl6wAeJJ6Iq3sbDvkWDvWrrvQaeqFQK7cajjS9DkycOZVthRxWUwsKHHGoUyqQzxDEAPW4MZKfbog7wasyOBQtIPuqVSNYQspDcL0FHeikSqzUAvJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pdtjoKed; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ffa694d8e5so25118677b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 16:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706401434; x=1707006234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cn79PSQbiyI9xUwGkC6M8lExc7caTDC3ieGKYceHIo=;
        b=pdtjoKedXq/i0hoRXYEL7/m1j1vNYsia6iT0aTuIO15IbwV2TboSvIB4KhOZtQElUg
         MmKMTL0LpR06MQMB0CXjWeX2hUXPCT/ni1qXcbhwanUSLg/M5y6AgDo5+/X5yisrN2KI
         26dv3QjL4Kpfpe0W7rm3AVP8JpLltu5Z5BIejUzhfZuncK0fktZ0AGGpBUqyz1ZtuqAA
         jUBoizHq1QJqPh2Aidz54MJHTvEJwVZZhpVMXEHJoIEftKSaMgbufMNPnH6RIAW1fTDX
         RitWZCsMmGi7hV7qriifxfOamODgPEIfTcA8UwGilP6yFAdGw5YK4PF2/1nmW3PxWg0O
         NkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706401434; x=1707006234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cn79PSQbiyI9xUwGkC6M8lExc7caTDC3ieGKYceHIo=;
        b=jQg9X8ovlhvk46P6o2OPtqXrDg4tmnv0qgvrpkAVz83EoH32Vs6APXgbZMRQmx5eUa
         aidHz2lrLeJ5EEJ38ygpojD5lg65bQtgniXkUAt1+bq0ycEX3Vq62Gd32p9gTcTFOo2w
         74wAQ4l+ouaOgjhm8btFvKiZ+vdWtk+oJMvCzlAKqezIrPSNwJTpOalWD7CFVF3gSitV
         kN1et5tuIkAo3Pc9JpphLAy4oWhBaaTl3YseXdbxZkliLtHyGIeUnNnDyedIczCiZLvB
         5XsIeQMJ9BnY0618KURoV8iVf/uWfDC9YY2tK/AqFWu1iqc0OEM5nKqBQ8ygSqZO/LVI
         zxWg==
X-Gm-Message-State: AOJu0YyloMPLVvJsvJYxZFRYaIPB+UGrw+LwY2cOfihYYqh/+I2b6OKH
	SK46A04pdmEv26Og5ALnfcjduVwk+lCNECN0SrZGtfjocSwYKrvh/2t9B5TABb/hvqnj/QLAXDn
	DRJku0jrF7VMGlVo3SSuIJyvPO5jWbmCmQZ9tag==
X-Google-Smtp-Source: AGHT+IEiAcddPom2zSdcKLSz2KQ9LcFV0Se/lfGWYnEXGFBLo7dxZ9PmZdCWe9Qpx+Hy1YBmF6FetdQek17ztLkE6fg=
X-Received: by 2002:a81:6005:0:b0:603:cbb8:cb64 with SMTP id
 u5-20020a816005000000b00603cbb8cb64mr42786ywb.19.1706401434728; Sat, 27 Jan
 2024 16:23:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com> <20240121-pinctrl-scmi-v3-3-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-3-8d94ba79dca8@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 28 Jan 2024 01:23:43 +0100
Message-ID: <CACRpkdYVYSNscfUDSMobHS+EXdxaT_YC9iOwyPmK-pAZJXr38g@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 11:18=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:

> From: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
>
> Add basic implementation of the SCMI v3.2 pincontrol protocol.
>
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> Co-developed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

