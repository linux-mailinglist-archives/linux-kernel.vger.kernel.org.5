Return-Path: <linux-kernel+bounces-151361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2778AAD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C891F22141
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1443681730;
	Fri, 19 Apr 2024 11:19:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749FC81723
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713525547; cv=none; b=ZKU7Ox9leoc1q7rNn32AflXd/KbGCyoCWRHNlR5Fm5VFlG67RMSuVCDC8/bVoIZzPSgFlHvzzkrzFlH9q38dOcSO3Fz9SOCbGXv1dINKprpzQrX6LTAJ6taO+H70BD0dtE37rNqLDghArFJ2SkIbPk2fy+WCKuNjyfKGfPxqpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713525547; c=relaxed/simple;
	bh=/RbDCic49ng2Um4ApQG3NcBcpAriDbz9ePCJIO7XwmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWGXcuGkdiOdmKjytkNGsMtBjl9+0eVHC+RX+Uv/qgnaPI8TrYOzJnG/pOpELRrEqA6ma2UoxFzt7XgetbIPNyAuNATb65gZFCZdeRe2ly1fxfr7bQTIDJAzA9fp+XFkS9TaVRkmYUvEZmg0jjshjKtfiyOjinD/9qi2U6/CEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from [213.70.33.226] (helo=phil.intern)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rxmGk-0000RL-88; Fri, 19 Apr 2024 13:19:02 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Detlev Casanova <detlev.casanova@collabora.com>,
	linux-kernel@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	Maxime Ripard <mripard@kernel.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	Sandy Huang <hjc@rock-chips.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm: vop2: Do not divide height twice for YUV
Date: Fri, 19 Apr 2024 13:18:56 +0200
Message-Id: <171352551020.2525344.5153295478231203220.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240414182706.655270-1-detlev.casanova@collabora.com>
References: <20240414182706.655270-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 14 Apr 2024 14:27:06 -0400, Detlev Casanova wrote:
> For the cbcr format, gt2 and gt4 are computed again after src_h has been
> divided by vsub.
> 
> As src_h as already been divided by 2 before, introduce cbcr_src_h and
> cbcr_src_w to keep a copy of those values to be used for cbcr gt2 and
> gt4 computation.
> 
> [...]

Applied, thanks!

[1/1] drm: vop2: Do not divide height twice for YUV
      commit: e80c219f52861e756181d7f88b0d341116daac2b

But changed the subject to
    drm/rockchip: vop2: .....


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

