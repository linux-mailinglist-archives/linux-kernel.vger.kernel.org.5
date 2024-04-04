Return-Path: <linux-kernel+bounces-131610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE580898A03
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94EA288892
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810F512E1C0;
	Thu,  4 Apr 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBDBAMHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3690129A9A;
	Thu,  4 Apr 2024 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240597; cv=none; b=twbGRZr1R5BQ3Kkv29cTeo1MH4esE0jC/S745rR/v0AX7ThG6oyi5S2qvBi3aVWltOKEHTa+E30rA0r8k/zm/lussqY8/1qHxq0A/42wt+Lk4qTGZfK4cAYOM8aG9pcuXwUdTFZBTUrIVFoiNrmd9FkdLX3XBfOHryF4bEeltOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240597; c=relaxed/simple;
	bh=b3EY+mNSXgIdLMY9ITw3WfxFk9HC0dMLqxJZU09hjE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CNNQfM1pDxYJfFvdfCUe1C6fmmkBB5e1CzFiFHp6q6H7+twuLq+PFvATMg3Z+MGHQzOf/c+QKzgi1uOS7S3UEWWDYy3UhxFNuyG218VFvsj0b+O9QQfQFAJCvxJpfLQgZ+pP2LLBkS8W2kgEb2/txt1xeb5EvDZ4B0K/Y0iiU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBDBAMHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A946EC433C7;
	Thu,  4 Apr 2024 14:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712240597;
	bh=b3EY+mNSXgIdLMY9ITw3WfxFk9HC0dMLqxJZU09hjE8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DBDBAMHM+iUVP8sdLO6xyOXK5QN4LOaKEBdtm96HhyodtSg4mQFfkEzbHYhFfdhPU
	 jWu5uizAHYxisLUzLoDFXQSD3omyacqUGqDFvwlwbumzMxwdZPrI6WsijMaWTi5964
	 AcQypyAXYTaT3fSWw2oNDopr3HQ6uH+bCxXMTQ+fUxVdDfUW83kLQbTC4179qAoqnX
	 YV5epJlTJ8QvH0uJO7VQOwTb0SJJZURvkKkHeZyAqRh0XMQ2kPFdTfRbrCvOtVE0Qf
	 pUFwWJO/y5OXAKcM8geNdbOS2KM3EjNZQCiZCk0KEU6I7moGYRAN33r+qS//XcFs35
	 uders58eF6Fbg==
From: Maxime Ripard <mripard@kernel.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Jani Nikula <jani.nikula@intel.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20240404124101.2988099-1-arnd@kernel.org>
References: <20240404124101.2988099-1-arnd@kernel.org>
Subject: Re: [PATCH] drm: fix DRM_DISPLAY_DP_HELPER dependencies
Message-Id: <171224059404.143870.12869649896294820835.b4-ty@kernel.org>
Date: Thu, 04 Apr 2024 16:23:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 04 Apr 2024 14:40:51 +0200, Arnd Bergmann wrote:
> Both the exynos and rockchip drivers ran into link failures after
> a Kconfig cleanup:
> 
> aarch64-linux-ld: drivers/gpu/drm/exynos/exynos_dp.o: in function `exynos_dp_resume':
> exynos_dp.c:(.text+0xc0): undefined reference to `analogix_dp_resume'
> aarch64-linux-ld: drivers/gpu/drm/exynos/exynos_dp.o: in function `exynos_dp_suspend':
> exynos_dp.c:(.text+0xf4): undefined reference to `analogix_dp_suspend'
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime


