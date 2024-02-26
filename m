Return-Path: <linux-kernel+bounces-81117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E594386706C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F43D1F25FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529904D5A2;
	Mon, 26 Feb 2024 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuC46VIE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CB44D106;
	Mon, 26 Feb 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941329; cv=none; b=AAMI507xvm9CEnH6yGQ2dnWzs0Zz3g+TuL8yGo8X/szYAckX07Qgh9qy43KtwYfLLJDjx0a5X6e6NRX1H9aJEITtUqV3NtLz2fvdgmz0xySj571Y2GJkTlDxqKURf3Q/t86EA29Y8s5zdW/B6bbT4DtW1E9fM4KVpNhapbxuxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941329; c=relaxed/simple;
	bh=jmpj4xXZsykOFpzL4YNYLixtN3pv5TP8q5jAmFydjwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=juDgUCIbrTyHhbFatNkaX3T4L9xsaKPpM033VxxTpEfSfQGbXF0m5uhORfc09vzVG3B2KvF8bKO2FX0LhMCrEjHDahWlkRBWbrQLOQmC7VKtH/HM4/vJnHNXWT/+9cW1/I6ZbN9yUYgEFHXjt8o81Y482rPNrLzGjdkx7Cp4kxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuC46VIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93379C433C7;
	Mon, 26 Feb 2024 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708941329;
	bh=jmpj4xXZsykOFpzL4YNYLixtN3pv5TP8q5jAmFydjwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuC46VIEmdA1w/aBqbZfhleIh+F23ezvwXu03qYhqvqgZnKXUOtY2me40FRWEU2RW
	 wNw/82G4NwP9IQpR2B7pSCHbEP7OBLpYz7o/p3r5UljCiW9vZBSXdRbHCJl/ObU47w
	 h8cBodBXjHd9sVZntKnu7eAbbM23xjpF+GADlRKNfZIQO74kUWfBnyli5Aac7VJHp/
	 NUZlPOcczzmL1N8tOkhfeqfHFtqDQcCu4VJGW/3jt5MWYb9AfcawjLInRqQiK3QdCd
	 0zf/dI/IhxHETo2Tdjaqgdt/lxmz1GKMLS9j84N4f557h6ty5Us6RIcVGlYole6lWg
	 49EHl8rKziN1g==
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
Subject: Re: (subset) [PATCH v7 32/36] drm/sun4i: hdmi: Convert encoder to atomic
Date: Mon, 26 Feb 2024 10:55:20 +0100
Message-ID: <170894131837.29486.10568875108218671603.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-32-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-32-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:14:18 +0100, Maxime Ripard wrote:
> The sun4i_hdmi driver still uses the non-atomic variants of the encoder
> hooks, so let's convert to their atomic equivalents.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

