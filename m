Return-Path: <linux-kernel+bounces-42815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DF7840724
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D431C208D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA7651B1;
	Mon, 29 Jan 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXWVf8IL"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7580663127
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706535426; cv=none; b=PesIh9DVMaeMn3iCESoRjDPHr0yFN35Y60BOQuErP9eqDtbly8Do5fCF4IQLsbdg24NExFRzZ+P334yif69OcumsbiWwPPliIA/t0pHJtg1Bytch5XXYNkMb96508qhL7Kv5pNdrgIgCXFtVS6p8Dp2caeS4OtiLvIMKxOQSi/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706535426; c=relaxed/simple;
	bh=ZCsj/za7RaBNkGKT7kYWtyXABqM1HFsxCWGwnZwyws0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBUh/W0vsCkTphYldbxjhHZ3gPN7gejvUjlnH2eUo3BOoC1djWHdS1nB5DB0QR6U1caCYKmKy5bHeZ+4FTsAdmpckE3h9EDl9OKbzDmjj1dJjRrboBDxj4HYin0fghPm/JeK6uUPisWMLR3maKXKuzOzW1ZAraulgRrPxrR8Xos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXWVf8IL; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5ff7dc53ce0so21004837b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706535423; x=1707140223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCsj/za7RaBNkGKT7kYWtyXABqM1HFsxCWGwnZwyws0=;
        b=OXWVf8IL7ZqMV2ci5Jwg9lVK1Ybj6KfFHqZ34kNHNtNln6/fZBs/LeHdX0bghc1W+U
         6QscO7l0tJCcUzy7a0rYNnZEdpkD9bMomaEPsi45cNK7qBRChA83dLoGndFcwGWU7/qT
         GRN5EvDlC4y/Tvf8bFMlwIfhq0jRCAoHX7HkBtoJIUuLETKsZslhQod7PUIfwknvNQ/+
         eVAwJUnaRIFa92t3zWkIW2+k4aMF8hPFDaGMAt+MaarnTNvML2hqEbuP5rV/Vh2WtVkG
         2Kmj6/U5InXuo6XfUXy19KY7oBQtbNkk71cQHjmynmT3Pd/QtL6aNn4CX9+UYcg/M97I
         z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706535423; x=1707140223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCsj/za7RaBNkGKT7kYWtyXABqM1HFsxCWGwnZwyws0=;
        b=iVymGy44vwx87ru2MAad/jLKWmBxaYtvkipBE8ZzRTyj1/sEvsIvwON3SLWmBJayt+
         VR7H5JWRC5jhDug8NvNxgf1pb48qKdgB+jXUlbWgE8Ka7UwZZ4VLSEbnDAzM1e0kxF8r
         /n2qss5OoJqYAU3oeHZPZ3hjlRZMqXQxfAvbKma46xBXYKzhvR5o21uR+nOsrx7jurqc
         2zLfHPXa3rN7Um4g6h9JQ2DV1HFv8+KJc6YYJqOi1ZPgrdmCprHZPQ90vh+SHgYZsqcc
         H2fuL7AiwHf4/gyrDRS54NqoMbk3yJF/LOimx8le52/BTZGNe6RF/mp/YEfy9ErT80iu
         yfkg==
X-Gm-Message-State: AOJu0YwOuQMe8oBmOS9ELlr7aRaDbwr9tM4zHWfu1PaqUHkPTE0UVmXH
	efGxeaLRaNK9k5RrVWIPvrCHjXLu4+74FDXAbFkl1Ty452wB4zeO4HZO8ObPuwFjEK7IfjQxZf2
	khUyig12eSruVdJFkdP1ona1HUaJE6C03hjxUMw==
X-Google-Smtp-Source: AGHT+IHZ7ppV7Ra7ON9UtE6bhsWl2QM45AmHugXBrqcS6qRScJO5m5BM8d0Bu6WpG6iGltf56g+QXH1UdhgEs2wGbiI=
X-Received: by 2002:a81:b61e:0:b0:5ff:e530:eebd with SMTP id
 u30-20020a81b61e000000b005ffe530eebdmr3227907ywh.19.1706535423411; Mon, 29
 Jan 2024 05:37:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com> <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
In-Reply-To: <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 29 Jan 2024 14:36:52 +0100
Message-ID: <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:37=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wro=
te:

> And for i.MX95 OEM extenstion, do you have any suggestions?
> I have two points:
> 1. use vendor compatible. This would also benefit when supporting vendor
> protocol.
> 2. Introduce a property saying supporting-generic-pinconf
>
> How do you think?

While I don't know how OEM extensions to SCMI were designed,
the pin control subsystem has the philosophy that extensions are
for minor fringe stuff, such as a pin config option that no other
silicon is using and thus have no use for anyone else. Well that
is actually all the custom extensions we have.
(This notion is even carried over to SCMI pinctrl.)

The i.MX95 OEM extension is really odd to me, it looks like a
reimplementation of the core aspects of SCMI pin control, and
looks much more like the old i.MX drivers than like the SCMI driver.

But I sure cannot speak of what is allowed in SCMI OEM
extensions or not.

Yours,
Linus Walleij

