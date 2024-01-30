Return-Path: <linux-kernel+bounces-44579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335984247B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F8D1C26D84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411756A35D;
	Tue, 30 Jan 2024 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EitumZmA"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BCD6A33E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616436; cv=none; b=RgOlwWvf63YWCf4uvIYZY4/WofdbkasErvlDE9+sp5Ul0UdBUUzmDTYerzbYZ8HroNYaPcWDq+dNzX4F7jKwpGlkNJY/FSYJzxtVN56iYi5BuIMDKh8XaunKeQh3XYVJ6Wk7/4yYSdLoKzpo9C0y71iJls0+iT+2wumtXc8B6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616436; c=relaxed/simple;
	bh=aqLoaLelYrZ0pN6J3JgWRUokx2Qipds2wpILb+2lTaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cboCCMJgtek/66yBQ9UkFWJqgEavaxVjQlNjZH8mUOv+EponENF1yQUTXDdpeMrG6sMCyaOufrk1e3HlqSBlqWvtWDywtmyW0PC9Ld4R/zPSsZZyzurIXBotBd1KXqX+DnkEUCyPJ/af0GPEqIaBSXp5sT8qwru3+xD634/sb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EitumZmA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-602d0126e80so36033777b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706616434; x=1707221234; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ni+AcgcmH5VfHuLV4vej2dAUosTsEP3zAXkh9xNEVJs=;
        b=EitumZmASj/hbXlDHVOV3rvfDO7KKwP8PDgm9mUi9TbNQlMWYDUoUVGffSjJfJkcPZ
         sEe6JQGAH+NQZGQlI1bo3PKB40tGz5HZ433Z/VEoA2g99SBcHN6JHvJHRgU7HH3yEIio
         Vwu9lRu6tefLfQtNAsQ5ER2VIPphcVtEsN9neCJMPOO/z5Ruw+n+Hj5TblpfbRwKGAoO
         Oi46lKcT4s1655AHTC0xh3Vx4Ul4ZdiejYL80eWsstlTDdcDtEG1MFYhflCQwoNZUOcq
         wlUqR2b/3B074v7js67FLbJfKkyQzDjMria5EzCNLB2rnzKJo4Ae10PHC9YNuUikxxmh
         RF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616434; x=1707221234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ni+AcgcmH5VfHuLV4vej2dAUosTsEP3zAXkh9xNEVJs=;
        b=E2b+Ik3BzyaH7DOn4vW7Ejjb7cMRsF2hXdXieiovZrpKkphZumIK7KZVv5jCv85Orw
         qENLhMVuoHJEetTpzx17eUmqwr2o/Eezsiwko8/eTabwRTB1vTVRgV29PvP5agT1PMvN
         DVi4SHyouZFMg0iGmHBFomUE0ZvkEVwreaK23ToeyZCZWBjtDUyXlqG0lHL/JqwnPf74
         Zk+qMgP0S9GyfbW4LDjOFtrjJCN8TM2hKmXOHmcA4QArtwKoiBz508BrGnaA6ZGpL4w7
         Yb9LOVflHUQTS+NcGvFGZz73OOnOTHnZyO7F5M9OvP1CrFKVjKk7pEqvDUXNq+Xl4xyz
         1nDw==
X-Gm-Message-State: AOJu0YzgH/fH2nQScbEMIB3TPKAXLe5GQ1WvUePvq//HnI8ITTFCT4EQ
	o9VP+HSDG7k/soqsh6MmQq6Xl6pXJ8s1OmyEKH65yhzh64mw8DRLluNtOqjemwjsU2UyEKi2cGo
	1LITkRcHd5CYN68ZLU0dOBPTxJD3Q4CasK9KIbQ==
X-Google-Smtp-Source: AGHT+IF97Y3Zh8rHlO3hLK/Mjk8VaO1x02zLVeiWpylwm29cwlDJIb7s0wmiWbNu9aGN2bxJSqi6HG5P+NxiatS5//4=
X-Received: by 2002:a05:690c:fc8:b0:602:b21e:876f with SMTP id
 dg8-20020a05690c0fc800b00602b21e876fmr6088229ywb.0.1706616434091; Tue, 30 Jan
 2024 04:07:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122091623.2078089-1-peng.fan@oss.nxp.com>
In-Reply-To: <20240122091623.2078089-1-peng.fan@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Jan 2024 13:06:38 +0100
Message-ID: <CAPDyKFoBPpXTakO0wBXrW0nqZb_xbonqrVH9xQX+pSRWt18ZHQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add i.MX95 compatible string
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 10:12, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Same as i.MX93, add i.MX95 SDHC which is compatible with i.MX8MM USDHC.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 82eb7a24c857..f3c5aa64affc 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -55,8 +55,9 @@ properties:
>            - enum:
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc
> -              - fsl,imx93-usdhc
>                - fsl,imx8ulp-usdhc
> +              - fsl,imx93-usdhc
> +              - fsl,imx95-usdhc
>            - const: fsl,imx8mm-usdhc
>        - items:
>            - enum:
> --
> 2.37.1
>

