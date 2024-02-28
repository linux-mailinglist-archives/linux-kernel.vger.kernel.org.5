Return-Path: <linux-kernel+bounces-85277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7852B86B35A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FC501F29DFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9525915B990;
	Wed, 28 Feb 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH+QFfnk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFF15CD60;
	Wed, 28 Feb 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134824; cv=none; b=tcddgFq31/lVNYRrSKHIGK2IspY4C1OtNIB8lCqUP9sbSh6cjbWmnjilCptGYiP9gEro7eYtt2RovcHxeUhM+Wu1qJHUrpCQzCrbyAA+DlHhnyoFxm0n4l5SLwK8rhBIXL+Ppb+pwnNbKJ8tyzMcVIM5vNJVYUjkGW2fV7FiaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134824; c=relaxed/simple;
	bh=hzQVSaBrZkCaB0MO/4h8xfo96VI0B7t/YSfR6AYVxVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYRH4OoZbi0hdeukuC30G24MEUrQq2DnlUSeAJIcwjpqBSiyTSDyMwjATDDqbWLtRcB/18kPmVQCGcXHKMvOE2nckONSIp+PTCrIdEWKIZCo107eXEPaLy5NYGB/yXxwWLSM26RGWE4PNpC2lANcje5VQwQRj6+mwbBOnK2pQys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH+QFfnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2CBC433F1;
	Wed, 28 Feb 2024 15:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134823;
	bh=hzQVSaBrZkCaB0MO/4h8xfo96VI0B7t/YSfR6AYVxVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eH+QFfnkihZ1s1J9W0yFVWJmPH1URmdchPKpUzOsB5WpjpDPnQRRH3yikqF1XO67K
	 AqVjII5+5FAJhEifgKvo1SERrFDsZkyWzmSTx799ksK2wTDTjy/B4l+dTL3ETAxiXE
	 GvrrBAKzI2+elBWHjdkdu2/hMPJ0xfuimg2Vq8ioA4lCwWQQmHUtTF8m2Lcxkb0+bL
	 S9Rns/1U3hLwOTLPPFLoUcGIpfZ9JvAfwwzyXL03FrI8jH312yHOUW1t3GFOYGFn5q
	 2+w2yeiy9ZsVYzwyGVnRS4roW/nZMHDi5Bl406bfOLl496dmrero367vQ+P6TEvZU4
	 qqAfWNCpWv51w==
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
Subject: Re: (subset) [PATCH v7 01/36] drm/tests: helpers: Include missing drm_drv header
Date: Wed, 28 Feb 2024 16:40:14 +0100
Message-ID: <170913481315.384117.18098119230444621224.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-1-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-1-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:13:47 +0100, Maxime Ripard wrote:
> We have a few functions declared in our kunit helpers header, some of
> them dereferencing the struct drm_driver.
> 
> However, we don't include the drm_drv.h header file defining that
> structure, leading to compilation errors if we don't include both
> headers.
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

