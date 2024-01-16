Return-Path: <linux-kernel+bounces-27833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E382182F687
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8767CB243DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973B2032E;
	Tue, 16 Jan 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlyZy1al"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D461DA26;
	Tue, 16 Jan 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434321; cv=none; b=haCimAZU39wbObgcKjAG6R7BNPvE7waK4cP4Il6swsPQDfJKbwdhrBVUyYbJepxwE37TV75Ltgut1y26sysKbDTsTAvVpfo2xkz+dsMxCr9wtpe5qzjlb9RUt5jJRsZV0gHl2OoZk27BShDapWeuTNhQMFU2VbxCAG8oJjrqlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434321; c=relaxed/simple;
	bh=UAx8o4uieITWwemApbn071yaC0dHde0zkkm5N+ZPpHs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=XTEKonmC/x1qb8x7ajkke5Ygy1Dur5NjT/ApG9FA1wl8lh7cIVvZlc39kHKIMOQ1fTtG3hzleCjDpjnAUEKGfIMWLysKqjYLot3dQ7DXHvCGz6M/NgH/w54IDkdhULvlAPH+5/h1c+u+WfMWaxrVAZCZgcQHsrvUgNVeccULjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlyZy1al; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED56EC433C7;
	Tue, 16 Jan 2024 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434320;
	bh=UAx8o4uieITWwemApbn071yaC0dHde0zkkm5N+ZPpHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JlyZy1alLa719r7pAceS2PgFq/Qes11evFAk4FbeqfM4rdDgRiqtl9+jWiOvhxMMC
	 NDXPEXKdjRVJQiNPbPGX6aQpk7MTJjTASUWh+s6fUa3o4mjvSJlPFx2BT5RRK+tQ75
	 31BZ7r9RUGem+aUP1ucI5pE5sJa0vwohDQ8ecirIJpeAiVJ4d3JbnhAcR19kGV9NBb
	 De9wktSr6H7+Brx5XRKgcIf13ZQBMy4g80BxDKPnRamX4Ye642Odbz8Fbd1zAEew0b
	 2eXhUub2ibUbgu7giheLbIY9QmEt3EcVkjFpMqlpfjcZrUmyQgo3Aw4INmSeMpSWqT
	 SQkI0MgWKqjjg==
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
	allen.hubbe@amd.com,
	Julia.Lawall@inria.fr,
	justinstitt@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 062/108] ionic: bypass firmware cmds when stuck in reset
Date: Tue, 16 Jan 2024 14:39:28 -0500
Message-ID: <20240116194225.250921-62-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index bad919343180..075e0e3fc2ea 100644
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
index 1b547acfd8e9..83c413a10f79 100644
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


