Return-Path: <linux-kernel+bounces-28056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 169AB82F9A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F27E1F2174E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC19605CA;
	Tue, 16 Jan 2024 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLa1iQl9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F8605BC;
	Tue, 16 Jan 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435007; cv=none; b=Q/70gLDbL+xyT5LH6HyLbNnoTqfBwEGLcKsRzLju4FUW0XgwPcadKbdWrmM2/pd2CBqzlGbuEoUisWu08HPACj2MSGGkh27CD+bm2e+JBcM7JVA1Eu2zfCqHRuNAq9pppxoHHcQghmapbUrYF+femcUTp4t6EYDbNhwvRHDtm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435007; c=relaxed/simple;
	bh=hvevmGzEaPB9cvbNccc4O3pHnrpm7Ujp3QzaMBZty7Q=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ABGsLkWA8D55+JXAbmlRrmBzQFfdAJhDbvpBZ9ZKr6ADmrAgsTEjbCAvOQ2Gb6X7m+PdAzl1uHKkLYv0+o2wGGbBqp8fdi6hJInHSj5yEyQZa9ABjgLD2wAnNJrRkyUFUxwobRfCWBLlcj4c7CD15j4Zyca8UeYwIAb8Yx+q+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLa1iQl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D148DC433F1;
	Tue, 16 Jan 2024 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435007;
	bh=hvevmGzEaPB9cvbNccc4O3pHnrpm7Ujp3QzaMBZty7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bLa1iQl9Xc2DnFZOFmsVG1cwgwGgp83HNd+8UGJ29QdpVe9JqfO/lyuqC2v42PIlT
	 ZGYeGfxTuOpJn6gNsO3HEf6DvZr3P9NrXtaZMqNCDUFA6ndaYLLpsgc0/rD9VexQ03
	 RIGE0E6WFZ7eAkT2NtlrNE6tzjXfTaUB55ohcB90wbqVAEi9/caDQwrUGC2xOWfeV5
	 PK007uqNL2jECMNinACJ2f1mniZ5dAFVM1ote8bCqvTmfeOdcfs9fV3aJwpfhVzYke
	 0BR/GmyCGfN+TgBiiebm5X3gstijjg3Dcgq26qirS/zsHKdQhM28E9LwiQJxxM5wdX
	 iY6Zhy4UsmGug==
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
	leon@kernel.org,
	cai.huoqing@linux.dev,
	florian.fainelli@broadcom.com,
	nitya.sunkad@amd.com,
	allen.hubbe@amd.com,
	Julia.Lawall@inria.fr,
	justinstitt@google.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 38/68] ionic: bypass firmware cmds when stuck in reset
Date: Tue, 16 Jan 2024 14:53:37 -0500
Message-ID: <20240116195511.255854-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index ce436e97324a..4b9caec6eb9b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
@@ -380,6 +380,10 @@ static void ionic_remove(struct pci_dev *pdev)
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
index f7634884c750..fcc3faecb060 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3008,6 +3008,9 @@ static void ionic_lif_reset(struct ionic_lif *lif)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 
+	if (!ionic_is_fw_running(idev))
+		return;
+
 	mutex_lock(&lif->ionic->dev_cmd_lock);
 	ionic_dev_cmd_lif_reset(idev, lif->index);
 	ionic_dev_cmd_wait(lif->ionic, DEVCMD_TIMEOUT);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 9ecbbe7a02ec..d2038ff316ca 100644
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


