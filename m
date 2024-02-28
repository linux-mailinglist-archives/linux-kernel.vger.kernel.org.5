Return-Path: <linux-kernel+bounces-85280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC786B369
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13991C2615E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62DD15E5A8;
	Wed, 28 Feb 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oc0UR0W5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0D15DBCC;
	Wed, 28 Feb 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134834; cv=none; b=QJVbA5KEYbetG+DjU0d8QJTGy1wZy0rP/EnG9eKGB5719uqQ/Bb6uzQ1lgFaS/mJPCq6yZT/ScDR4fOEHkEEiPt9Mxk0piyczbsCJOfKegw5OR/VK7MfVDzZTZRL7gyosbjCuygt8szq0du7hWq2VGe18knl/18JmhJidC019wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134834; c=relaxed/simple;
	bh=tsYF06O0hUx6z4ZysguYUFGc6hPhoeQDqvJiBqFtdJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k33f4PYWOZsc0eoKVLaGIjpPLqPo7pb1EJEb0i2hcicuPhsV5WYxN2c+5e2bdqYbPmLMxj1BSFULTyg2ALDXhU/EBIP8kF0gPs5Y1+8hMSxsMSzRERyuFZgK0YR3CUHFzOf9Ogbo4AcUQ6WyY/KsphHH8NutjmJQJe0jl4TEqj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oc0UR0W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DA2C433F1;
	Wed, 28 Feb 2024 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134833;
	bh=tsYF06O0hUx6z4ZysguYUFGc6hPhoeQDqvJiBqFtdJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oc0UR0W52EEdg18ChVfUPfTObi+XvVwTxZAZCH0pYpvuH6Rkp35mP2PjYQsFADrls
	 m1ezLLZ7tR5oWqiOAxAQRelAOAltWSIuPcaDMoxN+UVuJdSpvgFp6vwIGR/Vc1l8Ai
	 iRgF4MnYtsQZsdsdcbZFF+LDY6lV5lN4GcHclccBBlheViyEExSKgTtkBQ9q/hisbG
	 586XL4Z+RGP7nn5eE4Mx/B1kOEj/na4QsBOCC/I2odX0ikOs1PHi/kwcoJpH3Y6Z4Q
	 K1rFK8gKXXSvRmcCyP/ctftY0FsQIr+ziGP7tk02F/ENhvL4ANxcDf0BImQmltQlW8
	 RJCXawW2vMoMA==
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: Re: (subset) [PATCH v7 04/36] drm/tests: Add helper to create mock crtc
Date: Wed, 28 Feb 2024 16:40:17 +0100
Message-ID: <170913481316.384117.15338048951068923035.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-4-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-4-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:13:50 +0100, Maxime Ripard wrote:
> We're going to need a full-blown, functional, KMS device to test more
> components of the atomic modesetting infrastructure.
> 
> Let's add a new helper to create a dumb, mocked, CRTC. By default it
> will create a CRTC relying only on the default helpers, but drivers are
> free to deviate from that.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

