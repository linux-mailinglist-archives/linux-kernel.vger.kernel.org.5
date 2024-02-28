Return-Path: <linux-kernel+bounces-85278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1086B360
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FA31F2A12F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072A815D5C0;
	Wed, 28 Feb 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD8uj449"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B115CD7E;
	Wed, 28 Feb 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134827; cv=none; b=PDQJByYe2owarvYvafbRhda34lEg1PwLDuXCCax7eOOFzP1n3DduxWiPXo3Sah0RZ2TJ7Tf1t94mahiE62eJykDyNTi15zC8it4WcRKBWh1PZleu0ctLSSethoLZDMkMH0gWL0zzCBGJGrydbQ+xP98qr2lBkmrP7N9lkWmy5MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134827; c=relaxed/simple;
	bh=5t9R4GtzeOAZ9GJytBGdPib9VNQ0Jmz73UKo6e5gukI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqXD2qicge7byvKYhkjQIGlhmdbfW1xT8qq2dnpdsQ4a+qqL8e1bve9fda8sgvWc1U8zv7G86OfxD9LSOwSuyunEXGS0kdDQPrPdB0ZjBChtBKZzaxBZGE+0FycRj4fmMzlAvUkaWah9AUnXOfR+OhdqPdO/HGGx0OoeuMj86iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD8uj449; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39BCC433C7;
	Wed, 28 Feb 2024 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134827;
	bh=5t9R4GtzeOAZ9GJytBGdPib9VNQ0Jmz73UKo6e5gukI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZD8uj449X4J1gYSLlSKMtjreRQLhQLSwXmf2Z+qXijTg0jaaDkCNBH4anBF2Chr7t
	 y6bRPr2+3MTnaSblTZ0OIl6revijFTXsqtT8PTidiu8kLnRqT8VQgtph70j6v2xRS4
	 FLFbkcz1NyImVF+dOFp3/ZdyUUoZgGaGMT0ElbFD0HXr9NTOmsLcMNhgXS8OKhOcCQ
	 0RFdt48lbP268MuSWMHHcKx1meYic2MspV62WoQCOzWcRWfRWTzO2xClhQhPBmuZWH
	 QHufrU0PyBpBOX+U0AUZ1063db5skQhgWlCLb66XlIA0TM19V4zR9JXcsQeQtHXtGB
	 31scl2+OTAwgQ==
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
Subject: Re: (subset) [PATCH v7 02/36] drm/tests: helpers: Add atomic helpers
Date: Wed, 28 Feb 2024 16:40:15 +0100
Message-ID: <170913481315.384117.12389631392705299799.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-2-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-2-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:13:48 +0100, Maxime Ripard wrote:
> The mock device we were creating was missing any of the driver-wide
> helpers. That was fine before since we weren't testing the atomic state
> path, but we're going to start, so let's use the default
> implementations.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

