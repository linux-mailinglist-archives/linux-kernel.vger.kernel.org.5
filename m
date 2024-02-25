Return-Path: <linux-kernel+bounces-79917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC958628AC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 145CAB213D1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031BC1C01;
	Sun, 25 Feb 2024 01:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwmR2GuD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9210E4;
	Sun, 25 Feb 2024 01:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708823133; cv=none; b=KeqGrPNVD0vWtKrhH5mg/dQrF02Iiyi0Ujr62bmA0kqLoTkbONmHthW4xzN+XNvz3D3DAO/ILn9fWzh3uw80sjL6n9osvMmRQKGX35GeEkTEAMiiQBAjTkeDEtp/nWe6T4UcZrFyipFl1WVQSGLrPiwy8OOFMXI7Rl8Mb4mpdQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708823133; c=relaxed/simple;
	bh=3mg6oqaF+cg0vcIgqQTwqzEvgh0PL7v3ce82MF0gHA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mnOa/dwte2f/EM8YqELkav6EwTsCS7sEGoLIzyU5dTHeJvjlrlPa4bXVCJ/lHzDJ/d0UI757DCJxWZtrQZr1DAy42bxwTzqpZaS+BjPRd1PK2JMt4QIjBMAoex0BY3UkWtHqWm68JLkozU37CO2M8cmvuK+qGf7hMa1hZ253NLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwmR2GuD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc42f5efso869327a12.0;
        Sat, 24 Feb 2024 17:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708823131; x=1709427931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mg6oqaF+cg0vcIgqQTwqzEvgh0PL7v3ce82MF0gHA4=;
        b=kwmR2GuDYwEOXJ72A3rYE/8LmqHxz0uJUjESp95SVXjobSg1DYYQvlNU3FhRkbePfh
         UJnLx94u20gbPEoW9fE66dUCAig2k2Cn6ktQdd+lh5ZilBiRc7ZRUKoahqTeCjUDTocr
         EmrG99Yq8PuwlyrqVcb4JVcplhuvc17l26m6obqU6+mf+06T4PcYIPbKERJipzgrmeIs
         4GNDA7VqOMEkD8xtpTN7pxV/NA17QcYO0G2I3Cu4CELObkA+atBii0hDYZlSW033W3C8
         LbfjHLx7zuMIUXWSnKPo0KV/XQ5o9o2hMEhODDhJddRk6OhHc/ZumDKkaSoS+oJAV3GB
         KZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708823131; x=1709427931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mg6oqaF+cg0vcIgqQTwqzEvgh0PL7v3ce82MF0gHA4=;
        b=QNYYxD4fljDwP28U7KVGrOq3KKwd4U7+mUwE9jLZyZ3c4TGFgVDXUkltm1Sm95nEKF
         2DbtRmfUJiQFYPhaTe3LDlPgwm3fZLztQLrpZlxn+ZW9cU0xTOvi0nfSHokwRP/emJLa
         shn3Fhjg8AbFETcsS3qux1eSdFhycvssfTWX9zLdZxfyI5d/UNISzIPWPOK+Ezn0SJjz
         4oAzPxB4Zw+XKUz5ZqG71barzeJUgxtKpaFk6Vcnadb4Flpy8uo7oUAK1p699Nof2gJB
         cQ3D03qfhBD1r4HDeepoEMQ7NPBl038oHFgN6B0ZYJHbfuR4Htrcfz3XmSVT4hq2OUuP
         zVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbLjt7SHlmniOJLUe40Mb05Tn63hq9ubjOXG8GDcAf8/T7NvGxIhX3L8uJ/+allOKuwXEFj0q9uGquuCWWzazqhRwJHsetU7QJIi70+f5Cm9CrI/+/aGq+W8sx9UhfhSEJ6JL7ulmYtA==
X-Gm-Message-State: AOJu0YwLoN9AyC4d6Jv/RL4dL68hgmp5f0hOf0DVzAY6Z8scoIpm2nKy
	5tNBnltTKrNA8OzxM+F1q9enEr/VNtIgJVONHWkJM0p9Gub5rALUL4cRgHMBbP4B8ZYp5p+c271
	TEnM0fXbhgfmf9PhY55Ak8eJFDco=
X-Google-Smtp-Source: AGHT+IGQCQdhFodiFWxk2gb0PFOlODxMSrWoLoLFpzNAU0iFEroef3QVx+ioI4ImPbd24yKml28l4GQpLjTUERlsV6Y=
X-Received: by 2002:a05:6a20:1602:b0:1a0:ead1:de78 with SMTP id
 l2-20020a056a20160200b001a0ead1de78mr4243116pzj.6.1708823130761; Sat, 24 Feb
 2024 17:05:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240224213240.1854709-1-sre@kernel.org> <20240224213240.1854709-7-sre@kernel.org>
In-Reply-To: <20240224213240.1854709-7-sre@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 24 Feb 2024 22:05:18 -0300
Message-ID: <CAOMZO5DWVaAp0sENeC0DoJvxfA-fCx3sjQW4Jjr5DJBb7AeuGw@mail.gmail.com>
Subject: Re: [PATCH v4 06/16] dt-bindings: lcdif: Do not require power-domains
 for i.MX6ULL
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 6:33=E2=80=AFPM Sebastian Reichel <sre@kernel.org> =
wrote:
>
> i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
> but has only very lightweight DISPLAY power domain. Its DISPLAY
> power domain is not supported by the binding / Linux kernel at
> the moment. Since the current setup is working, let's remove the
> power-domain from being required for that platform to fix the warning
> printed by CHECK_DTBS=3Dy.

Thanks, this also fixes the following imx8mq warnings:

imx8mq-evk.dtb: lcd-controller@30320000: 'power-domains' is a required prop=
erty
from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#

Reviewed-by: Fabio Estevam <festevam@gmail.com>

