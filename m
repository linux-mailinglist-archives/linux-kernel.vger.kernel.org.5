Return-Path: <linux-kernel+bounces-167414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEF08BA93C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08C61F21B84
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667914A601;
	Fri,  3 May 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HCrXgZ1E"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FFD1474AA
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714726281; cv=none; b=IdjFwBPiAYhMOmWNZ5mPMYJPdA9TiHRsr3GCchQu9cc9u4qvnCLCUk2VxtnaoV2AQD44ZC7J796TTrI88gXgXreAabPaZQhQ3JfrrdyzERvCVPakhjIbydra5CPKVt9rclOTQNp4GytKIvaGGvmxFqQ5aG7k5aQl0SnmI5EyPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714726281; c=relaxed/simple;
	bh=IEjd9yHeRN2jxLghIr0Q/jIHE64VNvDXmfQrbY/lmKM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KyaUsxTmEvfatMhp8hQrdy8MA1228SS8jvHR/d5skNcLSxm8qI+CAJaVxnFCwvl1sjjQ8zrv1073L4CRiEKhNJdWUTdj4+UoO1tQSWlj2GgBa4aXqPqGyFDvEf9TPyJbYW7PBhBv2kqtI2UV4thUV+tzWglp7nLTCb4urNabKeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HCrXgZ1E; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e271acb015so1638971fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714726278; x=1715331078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWk/psw7Jn7h8F9Bpz9pTT51OJv92Z7OG1gjIzaGghI=;
        b=HCrXgZ1EX0CBIZ7mbj3uk+1mDN13w1okTDa8Y/rgCmAPRi0/bOG913P6prd1wdWIt6
         aqEXgzerEWWyWmk8K/WpxcrWynH6PSvSpj5teKdFzj56bJtlpmcib7jKJc3llm/1aiMh
         d8QUWW68QgTHqVU6Z0DMqyHZtiqTIyju40ud8kQ4fYum7vSk9xBb31WT5kLIFnEG/OJ2
         1b9HnK7T42e7c6hwf09untSlj6RMPsuMtKXwpBgyuyH8AAcYN3TtJKN8cnuDO6svdZy7
         EBYowrzKn6YR5jNOBDdhBZm+aUTU1ykNcKmL/wfpr10dL/y3fO6LrYZEG4ICRKYDtrnP
         akgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714726278; x=1715331078;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWk/psw7Jn7h8F9Bpz9pTT51OJv92Z7OG1gjIzaGghI=;
        b=J6Kxn4c0/609mjMFe9mQqsdPrBniMiFq8gLX8nrwAaBJgB5+IjzonZx3pzeJxAc0B0
         J1btZn9mondlPhhwLZJkT/KKDoIUGt/H83Aezaz9HqNWIvAhbc21sbCFRvirOlInRSbM
         dnvhdgjdJPmE7VgQ6Syp1koz+tuu2yhNUaPtUPV8INCML41oVFUh/wT1Hl0Hp/Q1DtVq
         N3z6ma8VkGY5HacNTD+6P0Rd9k2CpTc+v+GUGkiAiuw7bByebhNb8Rrw9fHdLLss4dBo
         5mKABPUBlqyGYQuEY8Zj/wcWB78lHo256ITGAJAO+KYS5TVo0TgIu1HvL83mJtbG9Xvq
         L9Eg==
X-Forwarded-Encrypted: i=1; AJvYcCX1IXW/GpiB4fsmJVFXfwBJZn/YyzMBwDYRsJYWsja4h8IH6bz7g/bRF9glguwECmnQo/G4CaQW6HcuvGF9Kzu0KCBzcrKXRpAqOcYm
X-Gm-Message-State: AOJu0YwqdEQwmqz5Skmmtmgvu6VLFSJqfLMAoOYqpewTf3zUfYf5SYJX
	ANovNlGOmhQx3cPx3OgykH0Ha9SRfMEbdvlXn1ODxOXHrFLp1eJTvtkNNHwm/LdWWoJqJbvZMTa
	uqZ0=
X-Google-Smtp-Source: AGHT+IHcI2LurCc2hKenAfI5jjKmPmOLR9ME3lIwcmztZCp99vEXqtLskwgBUgkpuv4Q6SUOsRVoww==
X-Received: by 2002:a05:6512:2eb:b0:51d:70d9:ece0 with SMTP id m11-20020a05651202eb00b0051d70d9ece0mr1451847lfq.6.1714726277628;
        Fri, 03 May 2024 01:51:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i15-20020adfb64f000000b0034af40b2efdsm3204178wre.108.2024.05.03.01.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:51:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240426160256.3089978-1-jbrunet@baylibre.com>
References: <20240426160256.3089978-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/2] drm/meson: fix hdmi auxiliary system operation
 without display
Message-Id: <171472627680.386161.1617857178874394298.b4-ty@linaro.org>
Date: Fri, 03 May 2024 10:51:16 +0200
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

On Fri, 26 Apr 2024 18:02:52 +0200, Jerome Brunet wrote:
> CEC and ARC should work even when HDMI is not actively used for the
> display but it is not the case with Amlogic HDMI.
> 
> This is important for devices such as sound bars which may use DSI
> to display a UI and HDMI for CEC/ARC. A display is not required for these
> functions
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/2] drm/meson: dw-hdmi: power up phy on device init
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/04703bfd7f99c016a823c74712b97f8b5590ce87
[2/2] drm/meson: dw-hdmi: add bandgap setting for g12
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/08001033121dd92b8297a5b7333636b466c30f13

-- 
Neil


