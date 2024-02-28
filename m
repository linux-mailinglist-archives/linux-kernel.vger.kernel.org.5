Return-Path: <linux-kernel+bounces-85279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE486B365
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F269FB27ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C915DBB6;
	Wed, 28 Feb 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Onus0vDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D25F15D5DB;
	Wed, 28 Feb 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134830; cv=none; b=mOaNxUa4jkwn0hFV6VTz18RBmOnHgnr3DHzyaQYNlPPIGI4zgaGf78HwpSdnZwaO4XYPPItnolO5xuyVJYopYAoGGQFlsGOYCjoRlWk9zu4ikHa1pmTB9yb6uDp5lTSNtTQZx2UsSkMlXNCWZUHAQUPdTxxTWT/YpuyLtSM5vJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134830; c=relaxed/simple;
	bh=O03fJy88SAwwnAExh76BlIaO2MQNOOk831uCTyW6lAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsD7jDvP6GXCd0Mny29Qd2qUdm7XR4g20HZRt1H9XAPdZ/277lNaUslY529jmmk9/hlxFXLqTfRT1Ap2hR5BGPw+9m2YNqSaPRqae7yRJgsRIqvVeVXVpbOTyoU3rNOVadDiJFs31KfKDOUigbN5HrbpKGCV2D91R3iUO6/2UzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Onus0vDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE18C43390;
	Wed, 28 Feb 2024 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134830;
	bh=O03fJy88SAwwnAExh76BlIaO2MQNOOk831uCTyW6lAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Onus0vDwWiOKzvmQccBQ/B7iRCGG5+HbvgGB4a5v4PnW6UsMSNUKjEcj1r4+WtbM2
	 iEqqNYECIA5mnS4gN7xWpYQ11/54TzmPaetXbO2dBwOGrjM2EJ/pfslVMZZjRYaHXD
	 t+KfDCVfzEFpKimEFkkvh7J5T5Eso38JOClJ5GBDBcgLPoNVsqDokVVH4B/d395pi5
	 cwCsWRHzUuswUbsxJ1/nZOjTjU4e6vnFVhZwKQV2j1s7oyCvQocrVTM00D/DeHZ0pf
	 E48Zz6eSdMv7rVYolvjfKkdZ0Lhnp0EjNQdEApBHm3ubaROIQAO4P2mI7sPQrZKNaH
	 uwCE0dhODbV6g==
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
Subject: Re: (subset) [PATCH v7 03/36] drm/tests: Add helper to create mock plane
Date: Wed, 28 Feb 2024 16:40:16 +0100
Message-ID: <170913481316.384117.4001941914188313587.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-3-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-3-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:13:49 +0100, Maxime Ripard wrote:
> We're going to need a full-blown, functional, KMS device to test more
> components of the atomic modesetting infrastructure.
> 
> Let's add a new helper to create a dumb, mocked, primary plane. By
> default, it will create a linear XRGB8888 plane, using the default
> helpers.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

