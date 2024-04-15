Return-Path: <linux-kernel+bounces-144735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D9D8A49F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AC81F243D3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF139847;
	Mon, 15 Apr 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnq6zfL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB74383AB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168803; cv=none; b=I50RQc47489JbmXgE6INkdOmlYcwB+KkoEpLAZTvrSY9PBbZa6fPf1L0Dp6LJdXJAi5g3aPFOYfavf2aVDPx4GcjcT9ooYrRoeW/ychI6DY/EB63joh+ihsFlGA8Yx+LcvW9exLuiEEuzcggXzQ3nGtcSazhqP4kRHh5Mj/u80k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168803; c=relaxed/simple;
	bh=yNPyaoE+1YD2n6GMJmfwIULv/0PA81dmRmXg2JvJ6yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=o6pA9Vz81zZEfAf0ZB2gGdA/uNmmbG63noIyhP5tRP6gPXh7qEHglXLYopTGnylj4gQXCma/rPeQKOQfGQOnGjvY7lw5FlwzUo3krHy46dmIyVDfYuLBtYhGusx+ImI2WmGivG8yspW0yHE2YeqnQhNzKlAHSxbUTzWuXVrUlv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnq6zfL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3273C32786;
	Mon, 15 Apr 2024 08:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713168803;
	bh=yNPyaoE+1YD2n6GMJmfwIULv/0PA81dmRmXg2JvJ6yM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gnq6zfL47dW3bC/D+/fHSKBjwzPTKNZVXoSF/k/3LYrKSqevWXQ6zZAmlE9xcF9T6
	 iQG3dwp7oGhtjr/XDAEKcgYR3Tt8vVum9TmQDCGXM0AW8cx2tjYIIMBNhgsMlxBc7i
	 Syc5MhpbougAAjW3MJh3EYfByTz1MHScd+w+Sm5kfns6Q/Pe0OJoMyPAxl/v66PLtv
	 FZ8aX/rbZfK+DXQ/qrfMbKIH7ZJmoXxCyaZq6DW/L6sHt+fcvmpHjeKEZNUlwLZWfc
	 MiL12hlC8QW2TMknwHhn2TM/5dG8rZVee0IKJ33QwwxYx3IzJtRWcLhUzg8r4rYrxd
	 IADiDi6+sTxLg==
From: Maxime Ripard <mripard@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@intel.com>, 
 Lucas De Marchi <lucas.demarchi@intel.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
In-Reply-To: <20240405143531.925589-1-arnd@kernel.org>
References: <20240405143531.925589-1-arnd@kernel.org>
Subject: Re: (subset) [PATCH] drm: fix DRM_DISPLAY_DP_HELPER dependencies,
 part 2
Message-Id: <171316880026.200641.2717784608814103660.b4-ty@kernel.org>
Date: Mon, 15 Apr 2024 10:13:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 05 Apr 2024 16:35:10 +0200, Arnd Bergmann wrote:
> After my fix yesterday, I ran into another problem of the same kind:
> 
> aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `drm_dp_dpcd_readb':
> analogix_dp_core.c:(.text+0x194): undefined reference to `drm_dp_dpcd_read'
> aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `drm_dp_dpcd_writeb':
> analogix_dp_core.c:(.text+0x214): undefined reference to `drm_dp_dpcd_write'
> aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_stop_crc':
> analogix_dp_core.c:(.text+0x4b0): undefined reference to `drm_dp_stop_crc'
> aarch64-linux-ld: drivers/gpu/drm/bridge/analogix/analogix_dp_core.o: in function `analogix_dp_start_crc':
> analogix_dp_core.c:(.text+0xbe8): undefined reference to `drm_dp_start_crc'
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


