Return-Path: <linux-kernel+bounces-81120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60C48670C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0297B2768B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71F4F618;
	Mon, 26 Feb 2024 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKOoR+ZB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F0C4F213;
	Mon, 26 Feb 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941338; cv=none; b=s5nCwNgq6WzjcF27WSUgnpytj+PasUpS7Eg6xXraU0cPgxAWyrYwt+3BrLPo2dHl1IvsZHaROTH2Zy8FG+Wd0EzHQDoy8Ooe5IUXDZY1wNF49fDQWLqOydwB7O0TlsTX1UqFQPKWdNLwtRYpV9Bc7BhwT/NyoMrrGSUvtMS2Tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941338; c=relaxed/simple;
	bh=4dRXifSdQjscvfLmqYmq24fqEGlLnuN4Zc0Ty+/Cqmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwvQe0AXbDMwbqXTx19Plyq5xxG/n4x9Mrohgrz8LyHCQPc0SAEYqW476sJS5LjZc6nGWcO89QKUZ8q6IeffzKTbVe0VVhL4+WYTtn++a9sI7BfV0E6wZJRbXWwkR1hu8dlwwOtT5ugjHSbpKlYjSmbzhXGeNkfWq+ztRaCWst0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKOoR+ZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A503C43390;
	Mon, 26 Feb 2024 09:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708941338;
	bh=4dRXifSdQjscvfLmqYmq24fqEGlLnuN4Zc0Ty+/Cqmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AKOoR+ZBcLmKp+ldEEnw32sKLbEiPsihkWbr/DdXjQshwve9EmlZ69CX+EtAkkxn8
	 sQyUpyavmYWBTPZNE/bkt+gnQ3uFPqH+u/QwATZ7pQo5CzC5/8+zZ/J1KqdQifIHps
	 I26x1edA2wGFDQ4aU+Ki4WkTXZ2qkMSkmiOdmA1Pk1Ks/66+cM5AH1KxrUW8RIWSoP
	 l+iFWriLMKYWviwdLxb+6q7mZOwty3yMCEPJlroxdpULY/+EFw7B0FUcvms7UrnF2f
	 Q9/VRqle1CfyJD7lHbpkYzrh+6xjfUJR9+1Y9E2AxKz6+vSJzpJIqfuMtAMatoQwCp
	 7z7aYRZ7g/25A==
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
	linux-sunxi@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: (subset) [PATCH v7 35/36] drm/sun4i: hdmi: Consolidate atomic_check and mode_valid
Date: Mon, 26 Feb 2024 10:55:23 +0100
Message-ID: <170894131837.29486.11894124011939274293.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-35-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-35-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:14:21 +0100, Maxime Ripard wrote:
> atomic_check and mode_valid do not check for the same things which can
> lead to surprising result if the userspace commits a mode that didn't go
> through mode_valid. Let's merge the two implementations into a function
> called by both.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

