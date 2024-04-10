Return-Path: <linux-kernel+bounces-139148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8802889FF21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FEA2843B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CA917F38F;
	Wed, 10 Apr 2024 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwvKEMZz"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4BB17F37A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771516; cv=none; b=JZ92j+/64Ysag7JG7yUdU3RoRwQVbWERrEhD3VFm8C8BFjdmF8qQr1KEwFnMmXGu/x6CfEHeX19F2+iZqggGB+iT/q3bSWhU9ZNEmHeLuf+/OcrIx2a2cmjEbzICfL7VtxJj3m99Imebw+DOaIadzXocjJDbzEycBms0qpw8FtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771516; c=relaxed/simple;
	bh=GNGxTomVe9SYi6ouodd8VfUTWpqqNdcbzrmwqYTTm0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c+qGJEfnOBIARVsAoG3ICpe+vmFVyrYXoSBOw+aHw9gkWjUlPu6WhCssHfIc4syAOviE4WlB7G+vvPLj1dj9Pegd4uzSCLJFPGZFy5Y7FD9Fx4Qme4bpbQTMIC3bW/e5YbsJ+XkDOcik1d8y712+LlN5e3kuFW9GNblstdSi9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwvKEMZz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d3a470d5so6838275e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771512; x=1713376312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EH9Pxm+MZUB9uIJB2EAX8UISWeLkvrbIq4NwMfK/no=;
        b=TwvKEMZzvaej4/7dArmY+TRR7tNwYYqBIaRp05CW+n1xIxIOqui6lNhZzKoEktymrM
         4iarcIuKo1dl1dtmroiK4L5P73E1tPVEaN3mCNBD7mXOpXHT8cHzYKUAOuV7/DA1VIWP
         1N+OZSqq3WsxnAlIcGOlZeFE2qNQLOo5r7iYFP+MBBWDH6aapxlSZPwVG+YSipUyHAmo
         h6wcarnlpgPJfzy9zanZDrOQ94mNou3Ae43FQ6jGdZMLg+PUtM+qEbSgtbZ5B6A2zvAV
         zQ6Ual/O4kPwBs4ifG0N3LtjRwh9qN++i0tXKZs+yasiBElrWDVvtZRsCIaC+ueMHQb6
         zC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771512; x=1713376312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EH9Pxm+MZUB9uIJB2EAX8UISWeLkvrbIq4NwMfK/no=;
        b=C3aw/HoRcEq2s3Hqwfy8htUKlIkPcZyDMnPyKQdaYfmdifDHPeX7cQNWxSF3F9lgZX
         v8mBEl+xt/Y+ra2Oy4i41zRX8TMiBXpyWZtqPq5IJM/7QSiqumIu/7avKiJVaOeSOGY+
         f/MkXIQwQO6j/8jRg7d5A78ck1aC2lR30D2VoK4Nio3J1ubqquS0MtUNU6LnBH32EbUd
         G/nkPXYr2BE3ucPTzuNotGFj9OkGPxaZjw7xNCXujyYBtSuj3DK65tVCX8vx0esqC+BX
         fsqEh6j7DXrJPjTfr/hgmJAkVMncjQY4LgOHzAHI6dukMmacdSiXc1AldM3g8KFHyiyT
         sSVA==
X-Forwarded-Encrypted: i=1; AJvYcCV7AjgL3OEV1reObyU/rMxHPc/1Yq/IeMrF6Wrq3PDtNjRmUf6XqvvhsQsbrJwySTia+m37MaM96XuehZOHp0XlIsYPELy9dRLLAuoF
X-Gm-Message-State: AOJu0YyDe7ZNIfWgaU1VWG68E5RC7Wjm3+7YwD1oP0+TerYIIZ2t+PN4
	QtJncfqz8U5VgKSU2Kg3NVE5B9oU07AljKigcbz6g0UVftQViNk7K2V4/QV3bbs=
X-Google-Smtp-Source: AGHT+IFEmuU/yIHrAY8NuucyCaQFKu+VnZxGulNdN7KpD4j1m+7zPUv7hS0ZitZBToM3exxMIntetw==
X-Received: by 2002:a05:6512:2c95:b0:516:c600:64e8 with SMTP id dw21-20020a0565122c9500b00516c60064e8mr2674529lfb.1.1712771512162;
        Wed, 10 Apr 2024 10:51:52 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x26-20020a19e01a000000b00515a87668a1sm1905343lfg.77.2024.04.10.10.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:51:51 -0700 (PDT)
Message-ID: <3ae3891c-32cf-450c-a68d-0f80f9192bea@linaro.org>
Date: Wed, 10 Apr 2024 19:51:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] pinctrl: qcom: sm7150: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>, Dong Aisheng
 <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Sean Wang <sean.wang@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 zhanghongchen <zhanghongchen@loongson.cn>, Yinbo Zhu <zhuyinbo@loongson.cn>,
 Bjorn Andersson <andersson@kernel.org>, linux-gpio@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
References: <20240410170150.248428-1-krzk@kernel.org>
 <20240410170150.248428-4-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410170150.248428-4-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 19:01, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
> based on the alias from of_device_id table.  Pin controllers are
> considered core components, so usually they are built-in, however these
> can be built and used as modules on some generic kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

