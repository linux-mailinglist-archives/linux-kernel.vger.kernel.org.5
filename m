Return-Path: <linux-kernel+bounces-106290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A187EC07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659BF1F21CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80364F1F2;
	Mon, 18 Mar 2024 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSxH6qYY"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D74F1F6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775384; cv=none; b=cqTIiQXcXL9CJ4omhn5rqoApQSUFgDSvW/PcPzx3E4i4mnx0UAqxgib5APJA7niAjuDpSHXOL+MK2YsfIsvv2gL6TT2pJBRJsWrV+u4cmpj9CFzXGOoP3zkybgQII+5RTG8/LzabG6tCm5JsoEbAdDGwkkCE6dOtEA5M5IrHjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775384; c=relaxed/simple;
	bh=MChX38X33+qCYxehnqOCzQXAVNjcuSCivllsMiwyntQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Bpywp+/lEYoEfGpgjXZa7SjnjLPhd0maPnxG1f7XvI8gwN/vApB4DSqgrID850D9mTt5UTCZ6kNuCHCRCFC0sQYc25rMHdZEsBBkXToTKEQEIhVhyP8P1sf40ODE8VVnMVv7UMqlNVTryoQgnlZtEDu/2Of2nXHwMtXjn7eiNig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iSxH6qYY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41400a9844aso16414305e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710775381; x=1711380181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM5Vyp4val6gHlW4UCse9Nuq31PUAHMp+cCr8q2taE0=;
        b=iSxH6qYYppBbIIm6hBr0J1R5051YnzDvSpRQez0gJA00LdxiH3rCPBuNjTeFjHil0j
         jq0tZRR73H8NOiaaSgtBTbqoCL1DQjBEph+fsIyU5fRoJ2PotgXZt8AMu97WT8gnOAUK
         PgDhEoAjm91E1Qg7qwxFBH4QycS//g7vO/i7jJ01qSPsV+/pk8xHCtssrZtafP6dpn1z
         a4rMCpNwQcBBc35AEX1sXk+uPMtsDYacr0uJdJGAfBsSgJ4xZ1tOhRs1YY2PpD2SEcoC
         nMKzzTT5BonYGR2i/qm8EvnUzBYhzjEET5q/RiXLO4p5K0mfREqSU9FySUvZ6+E6frGf
         Veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775381; x=1711380181;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM5Vyp4val6gHlW4UCse9Nuq31PUAHMp+cCr8q2taE0=;
        b=kOrPFxkDa5j/Mg6oHC9h3WD+nM119QRfK+g1ZQVzlVyEQd3SedTwtR7S4wiYlZTYoy
         0Pzfe4CeJzdYmYg/X7csyN7HRRT32cwqu0yscu9xlR/QQRhqNJRmi0Aa5ZUMf/gFuM9j
         vyCMNosMGwclDjpXzOXCyXmrT4GvU4ZqxxG8MiP/ZMnZsVdAjv/8M/acgVwfAnymGT+t
         dRH0wBETTadXhXkWKFPc8F/h7RT+d/aIabchgLeX5u/nNxjW/3sxAnGaHCuTAJFEqWiI
         xRbvkuyjv99AunRG6LncRTcsi6/rRY3rykCcaA9rN/uqfSl9Iq6X14B+rNkO4SUQoHuY
         zDaw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Uz/6R3sQuDQ7Hhwe8rlCifETXmNKEfqUXoyNGSdacdBeqYeve6zPhqXyvN7C1p5oXtKef1f/kaL+CEZJl2ba1ZjDfIfaM8HocENA
X-Gm-Message-State: AOJu0YwXm3yo81k1OT0FBr9kkEGpbK4Ae1CLDOQgTP/OJxQuxfVPZkpW
	hIUpvmeosLiRJTtLyiy5MUbJLaXfdi1+8czOE6gjb4zuwN8rpVNIE3DkniFmevA=
X-Google-Smtp-Source: AGHT+IHoIC01uPMLs6tirF+4ySOyl4RckmNhZ1au3ma150he5IpBM7GCFHMdYmG14h8iY7QX2EY+Lg==
X-Received: by 2002:adf:f68e:0:b0:33e:9f16:33c with SMTP id v14-20020adff68e000000b0033e9f16033cmr10363269wrp.18.1710775380663;
        Mon, 18 Mar 2024 08:23:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c310600b00413294ddb72sm15047500wmo.20.2024.03.18.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:23:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Phong LE <ple@baylibre.com>, Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240316160536.1051513-1-sui.jingfeng@linux.dev>
References: <20240316160536.1051513-1-sui.jingfeng@linux.dev>
Subject: Re: [PATCH] drm/bridge: ite66121: Register HPD interrupt handler
 only when 'client->irq > 0'
Message-Id: <171077537978.2168000.7565900207355472778.b4-ty@linaro.org>
Date: Mon, 18 Mar 2024 16:22:59 +0100
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

On Sun, 17 Mar 2024 00:05:36 +0800, Sui Jingfeng wrote:
> If a specific design doesn't wire IT66121's interrupt signal output pin up
> to the display controller side, then we should not register the interrupt
> handler. Such a decision is valid usage, as we can fall back to polling
> mode. So, don't make the assumption that a specific board always supports
> HPD. Carry out a sanity check on 'client->irq' before using it, fall back
> to polling mode if client->irq < 0 is true. Such a design increases the
> overall flexibility.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/bridge: ite66121: Register HPD interrupt handler only when 'client->irq > 0'
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/ba2d3e6709681b6c16ba8d65a23d72c706d82b5c

-- 
Neil


