Return-Path: <linux-kernel+bounces-115945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE500889B52
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5021BB2D7C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22339003B;
	Mon, 25 Mar 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGjqGG+p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6522BBE3;
	Sun, 24 Mar 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322170; cv=none; b=OdMY8mcMJXCYL82I+THkWvZxRcfX0+/khtv63HC6sdMm7wx2QSqO5A4wRoCQoDkcoh+7w1qj8vbC48+Ie5B2AoJxtpVos9dJZg1otbL55lbZHmIcyxjklEeqmHhMl/V8UQZhwikUZLoQlw5pwPIxAXLW62q8mKQ/YgbfdLj8aJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322170; c=relaxed/simple;
	bh=HMi0+x9nx54yQycau/GhhoDRdzUG5BNhX56pSJ+Iofc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMsbnOLKBUNiBRqyyaGafZfNuiEdzZb2rbCmEHx5FDT1RzTMACeNVE+dM70SskWaoxkebZUQkVSo6cpkw/AozBF7pA124rmqu122Idb/3rr3xkS9jGd8duSMYJXuodWI+WRosIlZHMLT4QiBnGWpsM+IbGB8D3SO6zUCAoGh7WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGjqGG+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF35C433C7;
	Sun, 24 Mar 2024 23:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322169;
	bh=HMi0+x9nx54yQycau/GhhoDRdzUG5BNhX56pSJ+Iofc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGjqGG+pQMkGoQXONQ3TDW7JWzjHHdSwndG23SP6v24mDUR1kLlKd5a17ardUkPyX
	 GMaJP8c/gAWseJMiKFb93YVvpTmtW46JyDp2A15rN85zRW5FPqHj/khcGdRSBaNl74
	 D+xzI1eefPwXAt5PAi/MZvOTH7PieV1ChhGZD/ksgLev5yoxZWG2TTcKIU3FbtFtON
	 JOf8kcBDbZYmY1R0lvy2sbYEL52Up+Xo/jM5FnNbMIYSsTDufrYbRQoh5UqNLjdJ3F
	 rT0ORADPPX9HRl+Uc4vxU3prZyzKWnr2Ag86Nkl5Es5t62Qhs2FAE5xcYImPfTfFum
	 /UjrkaJc1zJpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
	Quentin Schulz <foss+kernel@0leil.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 248/451] drm/rockchip: lvds: do not print scary message when probing defer
Date: Sun, 24 Mar 2024 19:08:44 -0400
Message-ID: <20240324231207.1351418-249-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

[ Upstream commit 52d11c863ac92e36a0365249f7f6d27ac48c78bc ]

This scary message can misled the user into thinking something bad has
happened and needs to be fixed, however it could simply be part of a
normal boot process where EPROBE_DEFER is taken into account. Therefore,
let's use dev_err_probe so that this message doesn't get shown (by
default) when the return code is EPROBE_DEFER.

Fixes: 34cc0aa25456 ("drm/rockchip: Add support for Rockchip Soc LVDS")
Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20231120-rk-lvds-defer-msg-v2-2-9c59a5779cf9@theobroma-systems.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 1fde888cdd827..eb4a108c5bd2a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -577,7 +577,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 		ret = -EINVAL;
 		goto err_put_port;
 	} else if (ret) {
-		DRM_DEV_ERROR(dev, "failed to find panel and bridge node\n");
+		dev_err_probe(dev, ret, "failed to find panel and bridge node\n");
 		goto err_put_port;
 	}
 	if (lvds->panel)
-- 
2.43.0


