Return-Path: <linux-kernel+bounces-116897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABA288A4F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C272E57EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9C417A368;
	Mon, 25 Mar 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mrb5oQqI"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C15319F53C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364118; cv=none; b=o2VyDt4YOm3GnHjBOTqux8yosi+j6ZfibcvfcHQBXBDEOo7/TfkDmHiaPf6FCkAuT2fgJt756bC95nu3d62B/utVTyP78QbZhrU3AsH4stD0w8Joai0Rlbsq6MnEFcV7h3jvaz26vEEovsxnBZOtZN5yRfvNVKZFrI5QQdCrGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364118; c=relaxed/simple;
	bh=4nAd/EAJpokdGGZGpm+JgdUUcm5UsCvxwQ8RcxzoCik=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sBAlGSLVlwx+reukCbkRLA0WePws2dO3Rmrvs2BClTw84X0LKrD15scPoSnr15fPfyGx1nhb8XEeMn90CobQSUV7/qi6PMx/XNKvb0p9aAhaL2AWcKjr78tIc0FxL0xwsPlqMxwNCyVLaeIN0MmhsWqqC4aO1vY4PD4GYcszNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mrb5oQqI; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4a8bddc21so57449241fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711364115; x=1711968915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFcyCCwkrWUNl/vLlM9putmgMzWSgSa5UA8ajqCwlrY=;
        b=Mrb5oQqIyEHZlqTaVGavUTGpvypgvfG5Doqzm1/hJqKkvT8AptTyW+frxr02q0UaGJ
         TFj32Rr4be1ry2GXoPrbNxQcmZ9GQKED/sVuCjQ8GtW7Br1uES4c+uj/VZs070+BKmTM
         VDc2WTzQvvEMBd4UOYMd5zWXvEnB0QWhTarfGdhuRX+Yxion9NZXRrjnqOYt09whXVSM
         Xng8r1B38GlBO/Y4yv/t+R0nvotsRpzbxqMnz3qF/S1rND5ZMT8p1G9gdG5IC6bBumZm
         +kL3Jek50i+KeFzPMdklJacmUs4hZpitMRYRxZFYbzFPgZ4xrTFtHI9KZEu+eagdgJOY
         ZZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711364115; x=1711968915;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFcyCCwkrWUNl/vLlM9putmgMzWSgSa5UA8ajqCwlrY=;
        b=T7ZwMEjarFTYPxgYuWcBFKp62qJAucf6aCeJc2yMC+3B7OXPto9+UHSMGJm+XnXP8C
         Ya8fxJeCY1hscxe5GwLKmMSjVIqvbZN23/bnU8An16S1QJsVmrwH5qpfvbY5uehYiFtF
         ofcuXuhNy7ZHY6E9+9r8t3WmFuByOvxyn6IF+/a/bsavKkwa06NsSVSQgXhoL8fqApWK
         JykIEdxDnpBv1dxp+jgvl7kaUWpLGjPIYNEUyrjZ8A4OC2gGDt2mW60K2fjTG9QnrUJe
         liyHHL9d16ayv2C3VYyQLzTRJHlzgTXt22su1TpSZYSspzkR6uVFe8z5vG9DFJ61BnU6
         +kCA==
X-Forwarded-Encrypted: i=1; AJvYcCXAsCR/MwqBgwp8PLXvJ+L2b+sIYtAxv5aN2Eezzu6xX/O+ZtyTcDBh6mVi9w27agrWClQn7THGbw4J7OSBhkpxSuaXwqrBfJhtUKJl
X-Gm-Message-State: AOJu0YzEGkBxiQTcEBGgHB5ImHyjLAfWNuT1iGDC/JiiHR+12cD0URID
	a5oSWb90W7Vpgc9GXc05gH/VuGXdhy+v2ivdOtAwDg37Y9oa0xomh92zHRI5Oq8=
X-Google-Smtp-Source: AGHT+IFmXAWMmAnpJ15iSitf914lYKTJoX1F/f5dD88N/zLkvlKc9jb1ispcL7LFp4W0fApbWNRYMg==
X-Received: by 2002:a2e:7d18:0:b0:2d4:5c0c:77db with SMTP id y24-20020a2e7d18000000b002d45c0c77dbmr3743878ljc.3.1711364115205;
        Mon, 25 Mar 2024 03:55:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b004146750314csm8161410wms.3.2024.03.25.03.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 03:55:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@somainline.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240325103227.27474-1-krzysztof.kozlowski@linaro.org>
References: <20240325103227.27474-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [RESEND PATCH] dt-bindings: display: sony, td4353-jdi: allow
 width-mm and height-mm
Message-Id: <171136411426.2357652.2521397331384143643.b4-ty@linaro.org>
Date: Mon, 25 Mar 2024 11:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4

Hi,

On Mon, 25 Mar 2024 11:32:27 +0100, Krzysztof Kozlowski wrote:
> Allow width and height properties from panel-common.yaml, already used
> on some boards:
> 
>   sdm845-sony-xperia-tama-apollo.dtb: panel@0: 'height-mm', 'width-mm' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] dt-bindings: display: sony, td4353-jdi: allow width-mm and height-mm
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c8a0970321aeae4a5e807a5b323be9d48c6b5749

-- 
Neil


