Return-Path: <linux-kernel+bounces-27972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0062282F887
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253871C24C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F41125559;
	Tue, 16 Jan 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta+9qciu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6063E7F7D7;
	Tue, 16 Jan 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434723; cv=none; b=KzBK0JTkuNYfBHULwt453dHmqdOmmSvHuI9c+fM71K77Xr/cofiwEZB1woZJGmjwFjQ75PEjVtbYNEp1H7zs24L7Cq67oeYCB0+e7t6e99JbNoVwlkKtE/JUEjPbHFDaJGfuljMrGj9Udnr7QE2X1jVclXZxtvwfve2olFvGrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434723; c=relaxed/simple;
	bh=Vvuo0RRwGPRhxFg6ZiGdSeCAD4+2FBPo3UoMM8YF+nk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=m8pO6XFo+7IHqJ7CPuX7PQa33i38ezrv7qqk+YGPrR6cCfyiesCeSi4CubzSKJXb6OhCRc3g3R6c7jzxTV15+naHvCx1mlc1s38gsfkHsb4AJC/z60EXxlhpGEA+8f2qfILfaMyspcU9D/yRLO2LxyK8QQ/hu/gxM1PhEw0w5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta+9qciu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F7EC433C7;
	Tue, 16 Jan 2024 19:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434723;
	bh=Vvuo0RRwGPRhxFg6ZiGdSeCAD4+2FBPo3UoMM8YF+nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ta+9qciuMEFv7fZeY+eumBUiLln+IXw4ZiKIPi+DIaCRfkXwhCZAbMjJC9ERp2A9W
	 38ln+RxSfwP8zWNs7f8gkxyZ8Gi3q7YrVY6hlQuJ9G8NalsNEB2uepF9MTi0oETYVm
	 p8MSGgpsZ0n88hfP4f8+nGAgnhhakXrfzriBqMKOfBmGbBDl/tRbp0fPFovfohrUE+
	 nYpaDNAe0K2HfZQHUmJa19LPXQYRllW0o2CP9Wz+RJsK7ALYQkNXulKT3s5RKS/8cI
	 7dAp5tF7s+xPDUh0z4hvsMxAFgdIsn72kTAjlaJdJfO6Oc5a8lAB+3iTJ8ehlaebF7
	 quIv9e1oOJnWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	drivers@pensando.io,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	cai.huoqing@linux.dev,
	leon@kernel.org,
	florian.fainelli@broadcom.com,
	nitya.sunkad@amd.com,
	neel.patel@amd.com,
	Julia.Lawall@inria.fr,
	allen.hubbe@amd.com,
	keescook@chromium.org,
	justinstitt@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 061/104] ionic: bypass firmware cmds when stuck in reset
Date: Tue, 16 Jan 2024 14:46:27 -0500
Message-ID: <20240116194908.253437-61-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit ca5fdf9a7c5b65968c718f2be159cda4c13556a1 ]

If the driver or firmware is stuck in reset state, don't bother
trying to use adminq commands.  This speeds up shutdown and
prevents unnecessary timeouts and error messages.

This includes a bit of rework on ionic_adminq_post_wait()
and ionic_adminq_post_wait_nomsg() to both use
__ionic_adminq_post_wait() which can do the checks needed in
both cases.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/pensando/ionic/ionic_bus_pci.c   |  4 ++++
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  3 +++
 .../net/ethernet/pensando/ionic/ionic_main.c  | 20 ++++++++++++-------
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
index d6ce113a4210..fa4237c27e06 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -392,6 +392,10 @@ static void ionic_remove(struct pci_dev *pdev)
 	del_timer_sync(&ionic->watchdog_timer);
 
 	if (ionic->lif) {
+		/* prevent adminq cmds if already known as down */
+		if (test_and_clear_bit(IONIC_LIF_F_FW_RESET, ionic->lif->state))
+			set_bit(IONIC_LIF_F_FW_STOPPING, ionic->lif->state);
+
 		ionic_lif_unregister(ionic->lif);
 		ionic_devlink_unregister(ionic);
 		ionic_lif_deinit(ionic->lif);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index c9bd2c57a37d..adb0f9b01bb1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3238,6 +3238,9 @@ static void ionic_lif_reset(struct ionic_lif *lif)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 
+	if (!ionic_is_fw_running(idev))
+		return;
+
 	mutex_lock(&lif->ionic->dev_cmd_lock);
 	ionic_dev_cmd_lif_reset(idev, lif->index);
 	ionic_dev_cmd_wait(lif->ionic, DEVCMD_TIMEOUT);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index baa865af49ad..f019277fec57 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -410,22 +410,28 @@ int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 				      do_msg);
 }
 
-int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
+static int __ionic_adminq_post_wait(struct ionic_lif *lif,
+				    struct ionic_admin_ctx *ctx,
+				    const bool do_msg)
 {
 	int err;
 
+	if (!ionic_is_fw_running(&lif->ionic->idev))
+		return 0;
+
 	err = ionic_adminq_post(lif, ctx);
 
-	return ionic_adminq_wait(lif, ctx, err, true);
+	return ionic_adminq_wait(lif, ctx, err, do_msg);
 }
 
-int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
+int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 {
-	int err;
-
-	err = ionic_adminq_post(lif, ctx);
+	return __ionic_adminq_post_wait(lif, ctx, true);
+}
 
-	return ionic_adminq_wait(lif, ctx, err, false);
+int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
+{
+	return __ionic_adminq_post_wait(lif, ctx, false);
 }
 
 static void ionic_dev_cmd_clean(struct ionic *ionic)
-- 
2.43.0


