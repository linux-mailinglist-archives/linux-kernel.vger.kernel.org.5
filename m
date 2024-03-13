Return-Path: <linux-kernel+bounces-102020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B487ADA4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D2F1F24A37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BC657A0;
	Wed, 13 Mar 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV98qSgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3452F7A;
	Wed, 13 Mar 2024 16:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348252; cv=none; b=PkplIjy+RmvwSw7t3PAudZ06KliEl8lhSbdcaD4I0cpOsuG6oIbdOxlg5Bew4dbakUj3d8f50W1Qmlh8ksPkbLaRP6ycAcsnITH/0PoKYU0k9utGmYxnoI9wLDr1Qzcc9sNXrtfu7PK/KsGp+SfbVgn9dkzlgq188msHjCC88c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348252; c=relaxed/simple;
	bh=qyHUlnlZHD6ThMTuwTmYi7wuWxF1xwykBrdeqrhso6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTga8KkGzAp/aUIuyKGtHP78Cj0/2EkXX4dPBXqpQL49DM/WsJXDUq06ltyqnqGKGKuXbDObozPKzWm+/Y9jdQHUphL/6GOXCcmiHwMSvJRh8JBsOvywj5nsz6Zowi4pR9EFgp3G1KnebaeY6DiaQ3BZEs11K5Ny4ulzSIv5VYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV98qSgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024D5C43394;
	Wed, 13 Mar 2024 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348252;
	bh=qyHUlnlZHD6ThMTuwTmYi7wuWxF1xwykBrdeqrhso6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WV98qSgT5EpwS3zfY5PwjcpDPq11RqSagwtF1YponA3eRZk9SFceQRttsbz7yG3+L
	 35QszWJuKpvomTlNNIS/DU9qHG17AsuH2TPAfJ8TECI/P/uz/cTSz0UF/T8ofIQrTs
	 BcM7w0jYXTTkUClUHwtobTUcopmsiuae6kPkd9HkXXaor/k3856VjsjIabzA4pCHPs
	 i9J0p/9PYkmrJFuQWTgUaVqpGAfG0IGtJdT0wLcfj5WWl9KiEJWq6BagzFpNqfpfx5
	 sWMgg6PVGNhkS1pF1zQctg2QykHcezsZ2rJd0Ei0xCfIpsaSmEN473XFxLIneBu6PX
	 sx1kYLW3vD3LA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rkRiG-0000000062B-06pu;
	Wed, 13 Mar 2024 17:44:20 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/msm/dp: fix runtime PM leak on disconnect
Date: Wed, 13 Mar 2024 17:43:05 +0100
Message-ID: <20240313164306.23133-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240313164306.23133-1-johan+linaro@kernel.org>
References: <20240313164306.23133-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to put the runtime PM usage count (and suspend) also when
receiving a disconnect event while in the ST_MAINLINK_READY state.

This specifically avoids leaking a runtime PM usage count on every
disconnect with display servers that do not automatically enable
external displays when receiving a hotplug notification.

Fixes: 5814b8bf086a ("drm/msm/dp: incorporate pm_runtime framework into DP driver")
Cc: stable@vger.kernel.org      # 6.8
Cc: Kuogee Hsieh <quic_khsieh@quicinc.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 4c72124ffb5d..8e8cf531da45 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -655,6 +655,7 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 		dp_display_host_phy_exit(dp);
 		dp->hpd_state = ST_DISCONNECTED;
 		dp_display_notify_disconnect(&dp->dp_display.pdev->dev);
+		pm_runtime_put_sync(&pdev->dev);
 		mutex_unlock(&dp->event_mutex);
 		return 0;
 	}
-- 
2.43.2


