Return-Path: <linux-kernel+bounces-109887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB088575F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4EA2839CA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F2A56763;
	Thu, 21 Mar 2024 10:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="FLvH+Y2h"
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C056448;
	Thu, 21 Mar 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016516; cv=none; b=KZXKV/spNQghW+qs13sZrOZlJjZu3RGSctsmEjZBpcxnl3/ZRb5M7HQn2ibiUQDG41INjEPdXcPzV72ANsNkZaFoBS9841swWEUV/j3CbMnIa/5s+KnYPMLyLcjfkZAauOPHN8j75gYy/Ja6F8TdDTkXF50RtbBy5NKJf7IETQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016516; c=relaxed/simple;
	bh=i0+PV72/2dFaK31wvWPoX0d6bxJSY6XBCsINwakqKcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f0ry7c/86e4Lemt7VPRtMNdPte6bEg4liB80GjieBiBmx9dXCUh7AN9PDkvI7iwFpuxoW/olcEjC48N03RA0Xl3FG8ObVp4SQebXIJ9EUlGFIh80qZFnjrMrHdwfojlPv+niQI3rP+4XpB+ktXQfbWj8+iqKkB2ogFxCfA7wqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=FLvH+Y2h; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=FLvH+Y2h76AlDPjOD9msC4pT2xE4BWTFOguXgNsDgjOA9zfDgm9rtxIFllbE3G/ylIra5kBR+bVFpYUpYYimNX1hSCOjOYl4mF6F3mq7ysdonnY3l2mlGClPUuwb0PGatTcRH269fp6X1Bk6vXcYYht/S7zwiEvgbrxRFTn6APY=;
	s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ktnsnF64wj/H5bwoeAclYjmtYjAzqxy2pnWppwBZrP8=;
	h=date:mime-version:subject:message-id:from;
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C897B7E033F;
	Thu, 21 Mar 2024 18:21:02 +0800 (CST)
From: Ye Zhang <ye.zhang@rock-chips.com>
To: ye.zhang@rock-chips.com,
	finley.xiao@rock-chips.com,
	heiko@sntech.de,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	rafael@kernel.org
Cc: tao.huang@rock-chips.com,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] thermal: devfreq_cooling: Fix perf state when calculate dfc res_util
Date: Thu, 21 Mar 2024 18:21:00 +0800
Message-Id: <20240321102100.2401340-1-ye.zhang@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh4fGlYZQkoeSkwZQ00aTUJVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
	kG
X-HM-Tid: 0a8e60874c5309cfkunmc897b7e033f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46Fxw*ITMKEhVNMgIJITYd
	NiJPCR9VSlVKTEpKS0pNT01IQ0xMVTMWGhIXVQIeVQETGhUcOwkUGBBWGBMSCwhVGBQWRVlXWRIL
	WUFZTkNVSUlVTFVKSk9ZV1kIAVlBSU9PSTcG

The issue occurs when the devfreq cooling device uses the EM power model
and the get_real_power() callback is provided by the driver.

The EM power table is sorted ascending，can't index the table by cooling
device state，so convert cooling state to performance state by
dfc->max_state - dfc->capped_state.

Fixes: 615510fe13bd ("thermal: devfreq_cooling: remove old power model and use EM")
Cc: 5.11+ <stable@vger.kernel.org> # 5.11+
Signed-off-by: Ye Zhang <ye.zhang@rock-chips.com>
---
v1 -> v2:
  - Update the commit message.

 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 50dec24e967a..8fd7cf1932cd 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -214,7 +214,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 
 		res = dfc->power_ops->get_real_power(df, power, freq, voltage);
 		if (!res) {
-			state = dfc->capped_state;
+			state = dfc->max_state - dfc->capped_state;
 
 			/* Convert EM power into milli-Watts first */
 			rcu_read_lock();
-- 
2.34.1


