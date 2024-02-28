Return-Path: <linux-kernel+bounces-85281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6391E86B36B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F57628856C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE3615E5CD;
	Wed, 28 Feb 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyAvpgaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989BE15CD76;
	Wed, 28 Feb 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134836; cv=none; b=jB9WXKpdbIyylCVp4476ko8g6hdH9+/+ecP4fe/NrQGuFDOy04muko23fOul9gjU+gegb4N0u2ZWtdbHVCb+2XMwRR5yf9M95sFgex4SqVJYgheJm3NUNAheTYoZGfFW7jIIjZnm8NOj3J+3UbquVioG5u1R9HQ9CNFAKRVkDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134836; c=relaxed/simple;
	bh=EdBXZWWZuhFQ2tBqeSWmQW8C9/3C6rfZGCgEINTeNPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPGfT2mQTZSqiUSmdjEKwNodAGgRze+bSuRLCZ1eTJCUlFAQepD1bNMZpy1hmIYP6appAezi/IP/bt7cD9huKNayMWnhcL1jhYcckMe8TtPivGCi0S7soZ7Pb38LQYfhUDzKtHgJ1KotCHykYgU5QxYRP09xpKA4++EgrgF6bK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyAvpgaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE28C43394;
	Wed, 28 Feb 2024 15:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709134836;
	bh=EdBXZWWZuhFQ2tBqeSWmQW8C9/3C6rfZGCgEINTeNPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyAvpgawbjRhXN3/idGsieliKuBer1VZ4n5wUriSTJKwJKF5v4z6qteLWf9kwTt7S
	 S3pjYTZZFoTyyx8U4OocIU5RbG8rpPhLwp3kEOnjggislmg9b8efSUJGaV0sOUmQUE
	 hBYeEokykF1BjV5uWDsOYwM9UK0Ke1Mgr5TLXBeHwIgm37Wu+My+P/jWWcAOe/wlUx
	 LkmgGkwW1txkgcjGcVCJEfNpUE3OPIr2DdJYtcCpIJY/fGzXsA+yKhGJurXVk6g/fk
	 umk/ws+Zn43pmDM6KDbw6GKW8eof6L/aeqfuY/wwWb4TKxYekwi3QzvBappQ2F+nMR
	 Nxkvw138GytBg==
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
Subject: Re: (subset) [PATCH v7 05/36] drm/tests: connector: Add tests for drmm_connector_init
Date: Wed, 28 Feb 2024 16:40:18 +0100
Message-ID: <170913481316.384117.11464006515273994691.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240222-kms-hdmi-connector-state-v7-5-8f4af575fce2@kernel.org>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org> <20240222-kms-hdmi-connector-state-v7-5-8f4af575fce2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 22 Feb 2024 19:13:51 +0100, Maxime Ripard wrote:
> drmm_connector_init is the preferred function to initialize a
> drm_connector structure. Let's add a bunch of unit tests for it.
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime

