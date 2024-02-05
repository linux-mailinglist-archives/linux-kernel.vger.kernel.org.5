Return-Path: <linux-kernel+bounces-52474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41848498A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8C1F285382
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105BC18E1E;
	Mon,  5 Feb 2024 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpAD4X2j"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC7D1864D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707131957; cv=none; b=YodehkooGP27jM1bm8j1PhVpSWhg1oeaDruaOtJYw9Eax5cCiFrImHNXj51y9Viy7ieHKgfIozXW/cRLKRusViMClRXEo8H/STZ5VvkJKUEYqtEf0bmI4R8AX7nNqfu96st5dKmh/4yrvby7hYTGAuh0Rlfcn+MVdqvquiao7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707131957; c=relaxed/simple;
	bh=wdMc6Gt4yynOJWTgrov4wPhG0AC88fDdH68Nn/m7K0s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sc+txelF2E+/MQ3KqWB4k99wj1iQyKE0O/QF9FplNZNbVzyFzKpkTCZK4DITWzo1LuOxho8vF9IJFLSA0KhstdgprA7U2y2honraTzu60sp8rkXglMeLsjwNj6KCSNgefyjVl+JcsTSBzJdzEMLLHy3tmnKWuj99GSmaxCv7WGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GpAD4X2j; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51025cafb51so6431171e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 03:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707131953; x=1707736753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWrtUvWSlugsoEEt7fKRu1nsL3urHay24xs1A+5SB/A=;
        b=GpAD4X2j6sPdeSHlBVR+Blt97jsqnqVUFHGtEXe9Ndam3zEDZW8795hVsugrT2ILNM
         HoWfjHdIhrleZOksDhfVCUUEb5Koe8TPjGyD2/ptN/k1jOrukPugArK1rMEDzmC/WgwY
         i+sJ8aEcwV2aMfD7HbGQmOyWTjJNmqI1TZy660pSAToM0z8JGTOHhi7k4UQKaLLVe8Zi
         tWIKFFQ4sL8hzLrmYxICQ5rrP6k8voxUrrslNhrcYhL6OpTLMfj0jzRjv2VGTLEAyuVo
         4W42EQSdY3DnyaIcKUfUq3ZlqXrddw3ES5OoOTpgA6KBw14WLiTgr4iLL1cWvOhYKGjJ
         fBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707131953; x=1707736753;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWrtUvWSlugsoEEt7fKRu1nsL3urHay24xs1A+5SB/A=;
        b=Jxy6IhGzWea4QgToAkDW0gKgRpl3SEMImyo/8oLYBzRsS7sgXNdpq62L3PftpG8QsU
         OhQt09boCqKwCRnSiZMVWeWAdPD2kFEDXk1yx2ECQol9U86jS7LiiW1AcINmiO7Sooy5
         G+f/CpOhZw5iHHtVVyh/FeTBjJq1+wbN1d3EDn9flWrkDDDWoYZ20pjeROiSCZByw690
         vHoeHEckwtTv89BmXmPb5DQz79oQ9MRyHprfGkLkAJxl2KL/O7RTl9lzMlzg+UEIufS6
         4EXfVI5tAIoxbh+On0Cz7rU8nA37mBrIPZcTmFUyMJex023m8BPqnDuy+VRl18r5+VUc
         hTKQ==
X-Gm-Message-State: AOJu0YxKmiduqFCHBLypVBrYJGY0pbubfTJHLYLmVx8IIjD+MPcWI8hR
	HBYSqqXCm7LFU1HSuehWwYHbRe+AoH3HAekgrmYtkdsnk00mXSenz5fmJXqVmJE=
X-Google-Smtp-Source: AGHT+IFzoCBC7kOvJb/mA4P4aZ5p0ddHh0/TlGGBDTtCoNFLdQMCzEB3AU9o7+iQtSFc1Nkg3MXakg==
X-Received: by 2002:a05:6512:2805:b0:511:5482:398b with SMTP id cf5-20020a056512280500b005115482398bmr789853lfb.15.1707131953432;
        Mon, 05 Feb 2024 03:19:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWsZc7N4uU5lXjNhfpD0pOUfSS4rEtAlUgSBgg3zJgJnXyc8Gjfy+nJ+crVArYn75GqDI5nHUvIY1kDIoAP49aXAmES5XcadzZdz3C0QmDxhPkZKzu5dPo2NHqLywTYZ5ByppsaLtzjwHih7DQhZjXpsSS3NBSjzPeCwdWpolBhJIjw1WpLzsKU2vQdKghpJaeX3R+Y7FU97enUyk77WJo2sYn0+ifW1SyMwkB7KqoGfSpG2XQFhvMF/OcewMqAJfScwqgKz1jPgdETPa7KGbQonbMPJIBV/wMKBb4PXMHPrIrG9hggpTGlTcQka6mlY+C7Eo9vwJrq6RsL8+ayycQehf3wFAky7HK2WffBCwFre4l+EeSmuIqxtBBdFLEjC0g3TL4uiqKyhtuFhy4f11HxdVWwJHDA6/gBD//Mi0IEiQx40Jn1k/gaXlyRoKx4m2qv2aahzmalRklM3/QOr7BiQkqUpRxTUcsIRjgKkTBI7+NJNzQF57I7dKJw+4DhTXiHELVYqKT4zyiNDISLFG0lkfvpMHlV54KaMDKBopoC9qm9aERXSNLLCSwkCsMcO+Qs4lKXQm0hX317NEu3tYSvVehCAnj6/tpCULNrI7VUDyg0ZcIsBgj+3mnyfPP69H1gDawlqDdTg08sThNf0aNRt4DzTIov7vjk6ShTKEn/ydZ9fj7YkmpHu6elDzKwpjxwbNt28FMg9afC3aAk9eY/W4b28HjiNF9Nzwsn01ZG0LZ3hjwXSpT/dnpiRrWX+ZiItVhRzLTZI4eaq1yalb0/2V9jaRNmA3E8cSHUFmnTDxbfavHOkdihcs+0WDCpNZtAyaWIYB7zmEvV4tyBIycTJFLnTaPDfZ5fBzA/+HSNzYz4hL2W/zq/U5EgUw26kYJ2Z9P7GD0XLMS3zgqM2tcyvnQj8Qs1WJV+wvJtCSiXko8l0IwOvQgHqnfnQd4l5AtzPb
 16n8XaO8tc3cD/j+CCJffu+x0SUhUsX4c6g0H9WhXS2VWY+5Xy65fhL312R9Sz7xkXC6XxlHRO8t6JI615jb97Z0G0RynsPeyb7sWpqcpu4pID3YHaZmZjAo9t2SLwXbUMBfSqeaSOe1Ux8Jw/ZNeKwMCQ24IKIZOypVZ3b/h81HEUc1XjPO47bhAgCw==
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i24-20020a05600c481800b0040efb503d58sm8177158wmo.28.2024.02.05.03.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 03:19:12 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Adam Ford <aford173@gmail.com>
Cc: marex@denx.de, alexander.stein@ew.tq-group.com, 
 frieder.schrempf@kontron.de, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Liu Ying <victor.liu@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Lucas Stach <l.stach@pengutronix.de>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Subject: Re: (subset) [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
Message-Id: <170713195198.1366121.9704774035651608603.b4-ty@linaro.org>
Date: Mon, 05 Feb 2024 12:19:11 +0100
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

On Sat, 03 Feb 2024 10:52:40 -0600, Adam Ford wrote:
> The i.MX8M Plus has an HDMI controller, but it depends on two
> other systems, the Parallel Video Interface (PVI) and the
> HDMI PHY from Samsung. The LCDIF controller generates the display
> and routes it to the PVI which converts passes the parallel video
> to the HDMI bridge.  The HDMI system has a corresponding power
> domain controller whose driver was partially written, but the
> device tree for it was never applied, so some changes to the
> power domain should be harmless because they've not really been
> used yet.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[07/12] dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f490d0cb9360466f6df0def3eccc47fabba9775b
[08/12] drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=059c53e877ca6e723e10490c27c1487a63e66efe

-- 
Neil


