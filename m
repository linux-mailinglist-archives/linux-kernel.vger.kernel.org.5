Return-Path: <linux-kernel+bounces-54477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 966DF84AFB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48EA4286551
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA6512B142;
	Tue,  6 Feb 2024 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SifXzZME"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836BB12AADF
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207314; cv=none; b=dMDRMEXpho8BnnL38dmjR9q/mzVt4tkYQ/PomsO8MxslZqo3hkWHpAuEAU5lZE2y4kr4W11HnO7oJLFWlZBKvEX0ME57TDuTM/37zn7pF0qG6MMQC/KHoLZbANTzwrgeokREwjVd170iImJ7SZgOW409HY2bFR5T0Yr1bIZeuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207314; c=relaxed/simple;
	bh=k80mLjIvTze9I4g8rX1exSAm7QAJel1Yb7apaCxak3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TURWj/iMSJODtoU9lf8vAnIv2920OgziaJbgBVoa+i++AMTpanpsGij0EBwzWH9dAgTZzVye93shhWq2GPhfHKjmpaTn11yI9ASSbC1zUgQzylvsZycHFRPVBtDSBJbG2ocK9US+OHr0NQ8wFPkYIHvCydKrs3SriGmp/esHHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SifXzZME; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso41381345e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 00:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707207309; x=1707812109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btHhwGxbZA6ve4BPec76cdv8nujipODBvqRCy/GsxP0=;
        b=SifXzZMEgqsxESslbijXO52LSFbWRVYOQI4KGhtAki2cc/Rln9YkJTH3Izke976QCq
         bVpGTQMhnWgGfUug2BvBYglrY5V5udpdI13x08Lzne/nh1CFxUfWHmcIdkv9RPRgxOYQ
         2nnRLH1VmZPNhz8QDPMO8z30MfIC1tNBRwj9AkQcE6eKgx8XH/3Zibg+Xzi46lX7I6oM
         gXaJNcYpaPbkxxHTQKJExUzGCU0fKAXUDN7eSUD1VrELI7hyl2lfElGHJ+2LPaxlYsCs
         mTjjfrx063k0zMfAunY4+dIg+gqGCzICemTz9q0j+xNmSgnPpQt+Vxe6MVvgyurItn81
         JTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207309; x=1707812109;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btHhwGxbZA6ve4BPec76cdv8nujipODBvqRCy/GsxP0=;
        b=Kb+kMCcGviMjPOdgHD40YsQfHD2EE2SjnahktOdRMoDCrnKT1f2rOSXboYXD3ZwAsn
         MmX3dkkmsyMB4maNNAb6mbbSeMjRo269wNREzZmgC7aTqz1Xcl3cIE1/1g0hIC2Cjm0u
         /plKSFPxdlGSAMRoCwBirRqD4hE4umXwRKQXthvXHq1Krt8C8Sga3vBrM2TXCfdSwLn9
         1WkE+Rpmh529hEFK1Pz+voCobwmiG0omti6sefZ9PRUkzQv6ijc++xToXY7/b5Pb/P3Q
         V683qNzZ0TH/vn2WJghH9QfL/N3rSmw+VJOTPdwTqCA2LZW/X5tF0YjUBwoBxSMqIEN2
         EUgQ==
X-Gm-Message-State: AOJu0YynWgvmFo6rnQmF5Q6OfZLVwPuTsd2yE84lYPshkxgKFGVduLyX
	3ShLKhDjtNa6cLdXCgJH+5DdjmiUDMnTGRwRQc9ugKPJmMEWS53iLCZJ5K/z+0M=
X-Google-Smtp-Source: AGHT+IHAY0id2rUAFIshnMoMYXgfIfqBfIbwnjGvIxqn8bUK+f7tCiKlPakrEgJpmh+5BOErZSPgrA==
X-Received: by 2002:a05:600c:5117:b0:40f:de5c:d283 with SMTP id o23-20020a05600c511700b0040fde5cd283mr957164wms.26.1707207308987;
        Tue, 06 Feb 2024 00:15:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1hmKw70FzD7bJf7uUXsOKOKjCezkhFYawWz6xg07SYsxhvKv3q3I7MdZBhoJFAtFibPiY+lppQGWokiuhvJpriSDPCGWWvg9GaF5G7QtZAswh1dEJFg8W8CcMgLw1dSmZ7sXXdA/IfouRf7ndIcKbhlB1R8nIejdD7QFT2AuLEXE3QDRtu4Oi4rYDYAk4k0IDcxox5bzKqjI0HOIviksCiIkJYLHVrSo3nhX4vS6IVy1fKzFtFNMSlXsoM56I4rvi+O2xbGRj9kz3KHgEnYGW7BG/cV3dB8Ev9PwSfbQRIl9P27ThziXC2FZVj3+Jlge2Usk9R5sB807bUlqWsXWwVSOiA+sMVqobqtncNIZ7tlODknzocIf9K4Pin07cszcfsLJbcYxqSbHzjY0c2KXCuCElKyD5DbvxRvQth5ycDvE7GscwUWLpoMiCXYRVIqAsx9h1v5Y/xqvcGNdkra6z/tLvTUAGvo+QyfPCuxycSdJTyS8AYc47n3pa0WWh3uDgkfnfNC/HwE59mKN/BA33LBuxc+QNqaNaSnoPU7V56hOr9I8kkJbvLbZgJsa5Cqxe2jlspVAv1UUyjfXZIKAcaOCxtYPOtLxrfQATN8KauuCbNdn3Cm2rIgvzQ79N+KRpG/pYVbHUBQJPMN930iVtdqPu6BgzQo/5vadtYiABOIaTkDm9dxEWzDQ9gc/+UldTJhR77/lR/ab3nMd0CMaqhfoUDxpEm9UR5ywWQkLRcxzPNG9XG+Dtxoc1rqzY2HrQO0GkQQSoccVqaT2mSKOcmKsTnK5UAjicWvXQ+5nzh43HHTJVmXkmCgTn1Jh02bViz58Zh5/ZRwyEZ0FVR+dxOBpX3MuMDv2oTrc9nQullGCLh4UceAncr2COOFpejrRnrvdtoVdbEHEtkwBT9/T1eKNSQFZM9EvfufhNl9ATj7yb93zB3NW1ktFAneBRykJD1w
 huBWIWIirQQa/D77hagZ/LhIx3be1dMivkRxQWPWPFYjSmgBBx4KXysvRNuq0bi2acJDpi+BTqzK+7e5ufYEtNI1pXT54aVeY3fWAnDBMYVlXw1jxRAVFS3xEjM4URX69Ievl8tEmPTD5waLJpGY+w5LuYeqi+2NGkJ0XJkgDLdQY55mg7/dIs0m9u3A==
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id o28-20020adfa11c000000b0033b3ceda5dbsm1440140wro.44.2024.02.06.00.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 00:15:08 -0800 (PST)
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
Message-Id: <170720730748.2682504.5723443718654255772.b4-ty@linaro.org>
Date: Tue, 06 Feb 2024 09:15:07 +0100
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

[09/12] dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=8933d29e7703f6f905bc84186b915b0ab4fe03bb
[10/12] drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
        https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1f36d634670d8001a45fe2f2dcae546819f9c7d8

-- 
Neil


