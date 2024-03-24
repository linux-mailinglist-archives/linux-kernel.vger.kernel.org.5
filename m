Return-Path: <linux-kernel+bounces-114915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A0888C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19C0B2525F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F22D4F13;
	Mon, 25 Mar 2024 00:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFSWwc16"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BA1791EF;
	Sun, 24 Mar 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323584; cv=none; b=nUp/63zVOCxHXOGqulZm3mXQHG/0XYUHzJHgzcln/bWYzPc/M0u/4roN+7YXqGsc5eJRbmBauy2I2BLvNsEGjmbXUwv1PsNnhlCr1jEm2VCMiAZpBbZtcOrWz+AU53Q3BvE6NfglNJeJAa/yJYld4FR1gF6E+jweMf3UH64V1M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323584; c=relaxed/simple;
	bh=s5HspWaj7dTK+BRgN68om3BQp6DLpTeKtLMi07I0tYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvfLxuQ02gD2xCaVXWxuuAVeiOZUKdsIF8iL820QOB2Y6hWl/pwSO8XNcRGuUjraI7Ow6ecc3Il2AqrI9B6+MQq1pGkasPUb4bQTwmquMGw8I+hOJ34pP/6oX438DnFunmooLmLBpw4tZ35+2YqcL9Bf4EZwr6rbFB6BPQXunDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFSWwc16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F1DC433C7;
	Sun, 24 Mar 2024 23:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323582;
	bh=s5HspWaj7dTK+BRgN68om3BQp6DLpTeKtLMi07I0tYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFSWwc16ejukO+zAAw0cFD6O9Q5DV2lFOuPDWG78clTSG35WpQ4xf//mBKBZqfX3x
	 tV1qk23AkVtN7M5zYss3xb6bryvpVq48sfdAQ5Ce+e4jzvj17BTkXKYJCFL+taGb7B
	 kDpq8b8GyxFNbTDIzrbRsbN/RXv6SJu9RVq0V+/MwQsCEvWNkFMUqBqHLnAD///Xlf
	 PBCiX6wltojoLkeK45pEwG4KEtV2/x455h/tpT+LvJb7ObUcKp9CIOzXmBDUoeCWMl
	 JrwGXYwvWYcg6NjizMvPq+9jH87+4uBjswDRqhcB/fPT3OxCUpxZjtFwgHrp6XBzWZ
	 xsg2wlWl93WiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Linu Cherian <lcherian@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 289/317] octeontx2-af: Use matching wake_up API variant in CGX command interface
Date: Sun, 24 Mar 2024 19:34:29 -0400
Message-ID: <20240324233458.1352854-290-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Linu Cherian <lcherian@marvell.com>

[ Upstream commit e642921dfeed1e15e73f78f2c3b6746f72b6deb2 ]

Use wake_up API instead of wake_up_interruptible, since
wait_event_timeout API is used for waiting on command completion.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Signed-off-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 1a269a2e61fdb..3ade1a6e2f1e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -1205,7 +1205,7 @@ static irqreturn_t cgx_fwi_event_handler(int irq, void *data)
 
 		/* Release thread waiting for completion  */
 		lmac->cmd_pend = false;
-		wake_up_interruptible(&lmac->wq_cmd_cmplt);
+		wake_up(&lmac->wq_cmd_cmplt);
 		break;
 	case CGX_EVT_ASYNC:
 		if (cgx_event_is_linkevent(event))
-- 
2.43.0


