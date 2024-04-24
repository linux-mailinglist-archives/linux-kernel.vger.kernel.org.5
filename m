Return-Path: <linux-kernel+bounces-156438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC718B02CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8091F23583
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715ED157A6F;
	Wed, 24 Apr 2024 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BFYqd0YS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21D15686B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941997; cv=none; b=UpRWIoYpsWVD2Iu+P/yqVojCKW1GmJzq51/PCPZSAv0yZyGeR0vhhB7Eg5BFCIDApzSr0Z5UmZlHE+dzB7RWL8KjabjWzIH72hWbwFg9Kp37KL8yiZ6LO/KAIOKifpgi7iRty6X7OBSvgDC6vUXaYC5q/7dP6Zptt+nlJF4Ew9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941997; c=relaxed/simple;
	bh=Na6/FinPyJlS63WHMxmkk33TuqOVQ/i6h4VW4xVxaWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hHm1SQrl0GINZqyjI9rErBfBNpzuU1NRRv0Adz7AmMls1YAt5Qn/NAJ2RwK4bnYmmStNvPrwXSCOFiTNMckpP23paJP5mgHGs+yOymhMvsv3KV7CKSvgcvhmKQLgUXY9mVx4upoIUm6T5ltcfnLbkjb2GAKD8KJ7EBzPE2QP57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BFYqd0YS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8b194341eso65362341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941994; x=1714546794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn3zv77j+I/km22hX1hF/bl6YKQ/ohkjehGzLRwZ1C0=;
        b=BFYqd0YSJ64NCts/lAHOst2DFEx6t+aoqFZvZ6amSMuTKn1ELubumlx3BqpIhMLs+C
         t6pWJ4rHjv0ufICil528WQJe0BViZYcXr17f5da3WJsxZDvyGtk+HsxGiwwV+hWuqzbz
         NIL/Tl4dBmPvl3Mimtkg9I/xhc7IMLdx/sZ/zvNst0lddXbzzNbRAuj8K1YcClPtf0+i
         yY5GLCpIf+krV4hhpbhc3DxEd0OYUNjEe7owZXVbUKNsfB57/4/vtfQzvRb5LxNThmLd
         1K+YUx3QORCuqDl8Zz4WfVJiv0NuO6tKNhWJL6WJkS8ZvCl4rfc3mQ1+cr5iOv+p0eV6
         YU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941994; x=1714546794;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn3zv77j+I/km22hX1hF/bl6YKQ/ohkjehGzLRwZ1C0=;
        b=UhUEvyYGH3FPtdB2Xzw2V4wnY22t1+VQWnrLS9xAmqwEMrzyk7aK/FHkkvabcsEzfq
         rD0Fcr4YjXlpyJEsxy+8V3kBzGYoZiAtC0n8zutljbS9i8qfEHmiW2EyY4fzQ3OITO9o
         jGTguPO4SdwA6pPRKDB7QH/eLM72eXvcblj6m0897BTz1XATW+W1+8lBT7WvYLLFtIFM
         CnAHN3/sZEUonhtkX710hPxkV9S7jXvsUV6PAfQrS1mfSL1lW45cVcKcunvXPnIti6qO
         phO65yPjPFielc4CVUJ3Q5GTOAk6KO3wq0rpLrhAgcEs26v3Y5vEa7uDWtArtNQClywg
         sUfg==
X-Forwarded-Encrypted: i=1; AJvYcCX3+0+9B8tVh/D95QNr4BiWKBlPhdsdDxTu/j20HiZp52qT/ibQ/WtmiGP8N8mvdPxwLQNAnYWlyVZ6GtiDYVC7A0QJwQDZX6QxFgrG
X-Gm-Message-State: AOJu0YwsfvBLdCl2iJFPy7hcI3J23WSVP3Fq74OOHxp4EeNYBbeO3kC7
	8p8QtsbSbKj9/HDZb+tgjVu8ASlrNGYNqHKaoWQMOw/OUQhRhf/edVtUgYHXw10BQoP9NRP9CIy
	Tzkc=
X-Google-Smtp-Source: AGHT+IEAhGdMSIV0cWqzcYj35a9RYOZoMLrNeJQoRvlbbFbkFKLDaeGMDWu5e67JHg+V6aliWQcsNg==
X-Received: by 2002:a2e:9456:0:b0:2d8:df61:9c6c with SMTP id o22-20020a2e9456000000b002d8df619c6cmr799462ljh.20.1713941993879;
        Tue, 23 Apr 2024 23:59:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b004186c58a9b5sm22465392wmb.44.2024.04.23.23.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 23:59:53 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Matthias Kaehlcke <mka@chromium.org>, 
 Harigovindan P <harigovi@codeaurora.org>, 
 Ritesh Kumar <quic_riteshk@quicinc.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
Subject: Re: (subset) [PATCH 0/6] drm/panel: small fixes for visionox and
 novatek panel drivers
Message-Id: <171394199276.1308236.5206485375489277476.b4-ty@linaro.org>
Date: Wed, 24 Apr 2024 08:59:52 +0200
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

On Thu, 04 Apr 2024 13:07:58 +0300, Dmitry Baryshkov wrote:
> While taking a glance at the novatek-nt36672e driver I stumbled upon a
> call to unregister the DSI device for the panel, although it was not the
> panel driver that registered the device.
> 
> Remove this call and a similar call from the visionox-rm69299 driver.
> While we are at it, also optimize regulator API calls in these two
> drivers and in the novatek-nt36672a driver.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[3/6] drm/panel: novatek-nt36672e: stop setting register load before disable
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/302aeb946731923c4ff7cca093868e4148ebc701
[4/6] drm/panel: novatek-nt36672e: stop calling regulator_set_load manually
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/9dab1af1e7592d9317bf3857e8cf019120973053
[5/6] drm/panel: novatek-nt36672a: stop calling regulator_set_load manually
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a8ee5f50a9d87f35ca80d6ea74ac07ae97d5a21b
[6/6] drm/panel: visionox-rm69299: stop calling regulator_set_load manually
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/251e3c1fe15cb8bf71a834f863f6225b8164f7b8

-- 
Neil


