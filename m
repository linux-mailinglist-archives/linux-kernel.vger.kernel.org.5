Return-Path: <linux-kernel+bounces-81118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7008C86706F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9993A1C27DC6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3618B4DA0D;
	Mon, 26 Feb 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECS+YnwI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6E84D9F4;
	Mon, 26 Feb 2024 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708941332; cv=none; b=lIZQKKxWO+34++CZB5/7gUCnS7xLmIQJwGN8eXnibq+Yuqch36CGClyPUGAz0ZcRY5M5yE93FRcSuOG5WYcjk0WZE5L/WN6U9a37wSW47AanGcQsZHbcUOF/ZDSx6XOjJ0E35DS1Tt+FAm5KBudUYt54sN9rKlIXyn7Q7OZSdZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708941332; c=relaxed/simple;
	bh=MWCY1AF2C8QZmQBIryattpCWG2SaqmPxREoZl4IyA1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpRrD7IVC4FjDx9R+hFetdC1MBVtd/JkrIUR6SwJJvE5OTz32W/qbBSP7FdCKv6k/Ibeb3nKt5iIaUgVO7RnRL7LhG7KVY1pSxkgXrvP/tPFS+6bnpGygsv27ztmASwTw+K4pdK8AePuluCCHphqLVc7rY9wmKf1LZBpOBe8djs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECS+YnwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10FFC433F1;
	Mon, 26 Feb 2024 09:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708941332;
	bh=MWCY1AF2C8QZmQBIryattpCWG2SaqmPxREoZl4IyA1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECS+YnwIUKjEbwzezCsPJUILXSbLH/4qOoa5SU/95gQaBGUspjCf5BJYAdy7NCfw8
	 qToZEJQT8O6XyKSZ5Ux/D5TYdSXBIFqUZkj87RBNhfA6/jRei6hK2iS4JhPqxhioRe
	 Og1KGGMwBmzOGPRGqCilc4MYM4ILsuQn0zcONhreKOibrYOIz1++O7sbG3CmQg31D4
	 aHf6nNoITcLWjoJse43RtS/cHgWMCY8bqJoTa3p0qCP56gHoQVNjhzrD1pwSKgP4ix
	 OFCBLY51YER5/sLPFBCKj3GwGrotsLUmW11HS1YeDR86mFAIsYhj0XUGC6gMqdilCK
	 0cNjoH9gHvQWg==
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
Subject: Re: (subset) [PATCH v7 33/36] drm/sun4i: hdmi: Move mode_set into enable
Date: Mon, 26 Feb 2024 10:55:21 +0100
Message-ID: <170894131837.29486.4668463181897393982.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-33-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-33-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:14:19 +0100, Maxime Ripard wrote:
> We're not doing anything special in atomic_mode_set so we can simply
> merge it into atomic_enable.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

