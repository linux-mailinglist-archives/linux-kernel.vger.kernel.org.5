Return-Path: <linux-kernel+bounces-116901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7761F88B2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83DD0B64CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E5F1552F2;
	Mon, 25 Mar 2024 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMqgy39u"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D771112B157
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364262; cv=none; b=ZIBUdFa+lOPP8BkGxtnSuW/8fTd/icuGpNfwbSmsp1p+5nLEyRObiLFrmCJFx2IG/oGZVewxes4d45SzmCvCISYzz0lODsGNJABBS6pGwFcfHom9OgFLjYkGByM4/mZryUXy7S8RDmbw2tByTffiSnFPgC/DDkNLe2B+zP72gAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364262; c=relaxed/simple;
	bh=ZNmvTSM9WskoV9jkCverTdK2gmPZbqJ5s1SufnKoohM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gUZ0CCcmpFDJAbEvQm2JmdPKI80AmyPVd1jt5CJANtfC3F2N6yqACNJtheey37bzUlTSBP7RjjCBtkB8qNDgQX0lyZmcmPQqa3t98iWBWKTXaZ+e9lGOVsOc4VI+xaW9wFGOUpA2wUkf/Gv+jrybwe05qn4kmQp3Ir/HOpxe2i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMqgy39u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c1a520659so393421a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364259; x=1711969059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiFPmka/p26FoyLkWS6C+JqzFKTgiIjCyRSd6+v/el4=;
        b=BMqgy39uEh7sUnGf02iT9JL5KwF185CTHioAgmxxmWUwSLFHiVEYF3vrapPRd2xvun
         O9u7GCLJ4iHma50ZwPWkFeGc4P+OF0NMALELljbGWwtlYo7lhZ+0q47FqEINnpyWhWHq
         c+rU6h6aBWJLvb8nWnp0U8fCPHcPflGnhewG3oySoJm5Bd/3rXAh/1k32ohieRFqqapS
         QgkovsCAjUJXY/ulWQyaYFmX8e88KG5vuntQLS+I9VHFnZnePVJV6aG/VUjZ/Ra1hteR
         sI/TyKWXRORaJn1c4GhpE7FaPl5wir20j+VISCBbtMbwkXeQz/hKOk2rt4Kb2rQWL4Xt
         jjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364259; x=1711969059;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiFPmka/p26FoyLkWS6C+JqzFKTgiIjCyRSd6+v/el4=;
        b=XGGB3OBz9K9fxyOC7SSplpTEZZ5xwZ8d5wlhPoLF0bLstiNzPw6iP16Z82gq/SmOec
         9nlTji2pVcbHDep8CoaXEu1AlBq13k0u1idiHFQKviUNGPFhSkvBGtru9QeiYqgiBbyT
         IA0wt/1s8ZoeZy3bT/PQ/bl5QXWHT8y67x3QA59Qv3Lnxcpq+bRMbiYuoXj5ZSLvMKAg
         Kv7CjH2/8tdIWuQVjMDU9es6p5hUhkZnPvsTo/xBnI/1p/drITRtJKZ7wgRUPE0PbNPJ
         px/6lvO9vX2C2RtZCAhN2TdTRMoLpZzLNOAaAFcr6P0/IVCSNzRE2tc+//V8Q2sIxJXa
         jZ0g==
X-Forwarded-Encrypted: i=1; AJvYcCUXfXFVUymT8QU0R8382BnMedjBSqeqZOLMGDCK/RTg3EH5bYVH+Gq0QxwPFW6dq87fJbzHLJI3K7extVqDV1zwe3tzKuIs0V3pXveL
X-Gm-Message-State: AOJu0YwxFPfhn6qNS5NyLXcMORKKchcdGNds43HRmqgw4Ur94PEZ3xPg
	DbbQfgSeVntO0N0l7/onE54VpqecsmDXtAWF1yAziMKlSK9txdFFpvQxpszE1/k=
X-Google-Smtp-Source: AGHT+IHrOea5cReywJ8Vx0WsqRFwU3TXjuY4dSN6EjmPcL/LGoqFHz6R2NYo+nog5F/IjCKcIF4ggA==
X-Received: by 2002:a17:906:4e92:b0:a4d:8481:5ea8 with SMTP id v18-20020a1709064e9200b00a4d84815ea8mr266415eju.73.1711364259238;
        Mon, 25 Mar 2024 03:57:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id c19-20020a1709060fd300b00a45ff5a30cesm2940522ejk.183.2024.03.25.03.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:57:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240313183011.14253-1-krzysztof.kozlowski@linaro.org>
References: <20240313183011.14253-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: samsung: exynos5800-peach-pi: switch to
 undeprecated DP HPD GPIOs
Message-Id: <171136425808.35431.8311696844753821107.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 11:57:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 13 Mar 2024 19:30:11 +0100, Krzysztof Kozlowski wrote:
> 'samsung,hpd-gpio' property is deprecated and uses also deprecated
> 'gpio' suffix which is not matched by dtbs_check:
> 
>   exynos5800-peach-pi.dtb: dp-controller@145b0000: 'samsung,hpd-gpio' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Switch to hpd-gpios property.
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: samsung: exynos5800-peach-pi: switch to undeprecated DP HPD GPIOs
      https://git.kernel.org/krzk/linux/c/75d7fa24772d0d7f78aff9eff013b3e2bcce3335

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


