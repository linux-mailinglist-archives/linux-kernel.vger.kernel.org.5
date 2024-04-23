Return-Path: <linux-kernel+bounces-154608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339B78ADE47
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AA9283464
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C534778B;
	Tue, 23 Apr 2024 07:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7wU7B1d"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AF4654E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857519; cv=none; b=aY5yG1tVeHi+4yZev0INTJeqlNthMIUXFF8xTwSuGrfqDiH21G51ipqADn7LdTmHKLmjxWOJCllkEhr7q/uy1PdoH7Tr00Yn0Ookm5IWN47adX06/unIsQ8l99hVjz8gEIV0hHHv9DGSxq9CDLkQKraYA1X/mrWYDcgKgHaDHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857519; c=relaxed/simple;
	bh=vFg0PnW0QQak5o0PgV9TFPerX7uBdhytKIDhd+Oc0Js=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ilNkGlgwV9fFDEF4G5wph5BL5z9zjhoIBIxDgTzrkmnKGeEm+Ww2EoHn60JKkFTvKi6G6JaFGPn0NyL81fwi5W/S9NWOLWP4hZnzqHiS4WW5Phg30o2kfpcml1ZZbywhnfWg4ZUfaE8O7Ppy5J9rWkBzQJ3CvMNm86j2UFH6yBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h7wU7B1d; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41aa21b06b3so8463555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713857516; x=1714462316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Sg65QOPtcQZrOuYCGKYckpDE7YmJS9IWjjcvkkY/64=;
        b=h7wU7B1dk2TRw+AF0FnrcJfGZFhGOZwB4Erv3X9W0ivtDEUKJRvAUlS+XjknzAjnsl
         cMB57NH7UjqXGsmMi7rCKOY6jvnod5a54ShOTwcrSy8FEze5R5Omb7REWKJeqEGFHIYD
         ryVJUan+LGTaxxIHC2IbyLywU4KN+Bd9h36z9uhWe8BmJfpXe41FFlwxld7XbpO/5BN+
         KRcPxei7Lx6RBnY9beumflFGt28/iTyHMw3TkgCUQzfoDqV9f8kyfUth9nk+yTu+/01u
         npk9bKeM+AMWbXqYC7TFKF0bYaYiwmznxdDcBvyvIIHd7xXcQOpA3Y9JynNSRQICdPkJ
         nwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713857516; x=1714462316;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sg65QOPtcQZrOuYCGKYckpDE7YmJS9IWjjcvkkY/64=;
        b=lnJeA5Y0YWYFUH/Ot53lbsOgwmFb66l9nF1oQUY1lo7hInw+y6lgHBQ85YUApkUNa5
         EFZQGqjSA0PKbTQQiSmmGgfk8qBWK+0lYen42Pn04kw4vqFDL/Vg8hA2ISiIPWvIscJa
         0AJlHImnwsLLzI0vzWuFV4xNk2ergKrHlRTJEUd90ymd8bNqy4aAKcg6BGkX+5Gsp+8y
         zuwS/RwkVSxg+ZFlAjNGiRUHlb0st8PIxfO5HL+UkEXld2p1nBmHhvQ2ZEn0MGAWbP+8
         +b+fOIY3KQy4RSSdfEb/7c3oaH6a8GXIymnceVBxp5XGGwHbcFWmtbX4VehMgnDicHsM
         sWzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOVsQ2X9Ep/ul2+0NpQ8Wh8aYStW7XQo+XAmd+ls2cIxGjfERYeIZDkEO/fyZ9pImgldtei7HYKOLIljUmizMZdEWaX+3jdLz01Bq5
X-Gm-Message-State: AOJu0YwJ6PycHOYEj/strYRY44F73BzcGB+EXESlfUofUJO/DzwnD6xy
	tgQuB8d2cT3EuS8vlkkol7x9NX33hp71+GfRYC8N6d8vovcZ3ilQI4HXYVMQd54=
X-Google-Smtp-Source: AGHT+IEjX6XmY23ztXbTm1qHkzpcVPy7yUfnvurNDsfJDLw/qOQdKczcN+j324+ogboWYhVA1mtzgA==
X-Received: by 2002:a05:600c:4689:b0:418:f308:7fa2 with SMTP id p9-20020a05600c468900b00418f3087fa2mr11273273wmo.14.1713857515759;
        Tue, 23 Apr 2024 00:31:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b0041a9fc2a6b5sm2456064wmo.20.2024.04.23.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 00:31:55 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: "dmitry . baryshkov @ linaro . org" <dmitry.baryshkov@linaro.org>, 
 "andrzej . hajda @ intel . com" <andrzej.hajda@intel.com>, 
 "rfoss @ kernel . org" <rfoss@kernel.org>, 
 "Laurent . pinchart @ ideasonboard . com" <Laurent.pinchart@ideasonboard.com>, 
 "jonas @ kwiboo . se" <jonas@kwiboo.se>, 
 "jernej . skrabec @ gmail . com" <jernej.skrabec@gmail.com>, 
 "maarten . lankhorst @ linux . intel . com" <maarten.lankhorst@linux.intel.com>, 
 "mripard @ kernel . org" <mripard@kernel.org>, 
 "tzimmermann @ suse . de" <tzimmermann@suse.de>, 
 "airlied @ gmail . com" <airlied@gmail.com>, 
 "daniel @ ffwll . ch" <daniel@ffwll.ch>, 
 "robh+dt @ kernel . org" <robh+dt@kernel.org>, 
 "krzysztof . kozlowski+dt @ linaro . org" <krzysztof.kozlowski+dt@linaro.org>, 
 "conor+dt @ kernel . org" <conor+dt@kernel.org>, 
 "linux @ armlinux . org . uk" <linux@armlinux.org.uk>, 
 "Nicolas . Ferre @ microchip . com" <Nicolas.Ferre@microchip.com>, 
 "alexandre . belloni @ bootlin . com" <alexandre.belloni@bootlin.com>, 
 "claudiu . beznea @ tuxon . dev" <claudiu.beznea@tuxon.dev>, 
 "Manikandan . M @ microchip . com" <Manikandan.M@microchip.com>, 
 "arnd @ arndb . de" <arnd@arndb.de>, 
 "geert+renesas @ glider . be" <geert+renesas@glider.be>, 
 "Jason @ zx2c4 . com" <Jason@zx2c4.com>, 
 "mpe @ ellerman . id . au" <mpe@ellerman.id.au>, 
 "gerg @ linux-m68k . org" <gerg@linux-m68k.org>, 
 "rdunlap @ infradead . org" <rdunlap@infradead.org>, 
 "vbabka @ suse . cz" <vbabka@suse.cz>, 
 "dri-devel @ lists . freedesktop . org" <dri-devel@lists.freedesktop.org>, 
 "devicetree @ vger . kernel . org" <devicetree@vger.kernel.org>, 
 "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>, 
 "oe-kbuild-all @ lists . linux . dev" <oe-kbuild-all@lists.linux.dev>, 
 "Hari . PrasathGE @ microchip . com" <Hari.PrasathGE@microchip.com>, 
 Dharma Balasubiramani <dharma.b@microchip.com>
In-Reply-To: <20240421011050.43265-1-dharma.b@microchip.com>
References: <20240421011050.43265-1-dharma.b@microchip.com>
Subject: Re: (subset) [PATCH v8 0/4] LVDS Controller Support for SAM9X75
 SoC
Message-Id: <171385751450.47981.16261973588553752989.b4-ty@linaro.org>
Date: Tue, 23 Apr 2024 09:31:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Sun, 21 Apr 2024 06:40:46 +0530, Dharma Balasubiramani wrote:
> This patch series introduces LVDS controller support for the SAM9X75 SoC. The
> LVDS controller is designed to work with Microchip's sam9x7 series
> System-on-Chip (SoC) devices, providing Low Voltage Differential Signaling
> capabilities.
> 
> Patch series Changelog:
> - Include configs: at91: Enable LVDS serializer
> - include all necessary To/Cc entries.
> The Individual Changelogs are available on the respective patches.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/4] dt-bindings: display: bridge: add sam9x75-lvds binding
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c24177ca3b27e5a7ddaab8d330cedecd7eb9244a
[2/4] drm/bridge: add lvds controller support for sam9x7
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/179b0769fc5fc193d7837bdcb6ddee118a0fa9b8
[3/4] MAINTAINERS: add SAM9X7 SoC's LVDS controller
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/e95752752eaf06c860811ac5ddf9badf6c1b43ca

-- 
Neil


