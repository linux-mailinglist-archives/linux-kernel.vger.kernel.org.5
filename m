Return-Path: <linux-kernel+bounces-67203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4D18567FE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C211C236FA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93946134730;
	Thu, 15 Feb 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CRUEGZFA"
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F01133413;
	Thu, 15 Feb 2024 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708011408; cv=none; b=Tgmo59HoFSX85eqaDajWjBNaABrB+NuZO+iw3NEfkWrSQvcRuESCAf8zzT2vzHUnZHOSZFRoN/zlsfbUK+21vfGsxBpZ+l15l1C4/64GbVtRxlKb831MESCc4ZuwojWleBX/7YgMUI5olSR0YRLSwyewV8JMMLcXIzAOW6tF1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708011408; c=relaxed/simple;
	bh=8WF6UR9eF6nZvmRireCrz2oeCtLoHCVzVebIRGr2RAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YOdY2rjouqBXcUQm9q23JgWBTsYvY0XXUHgFfJbh6zPmVody05P5VE+K2fHYLlYGhcqQJ8Zls1FZre2/CXJ5Oa+fKKY0y3zTmn1M1oEs23vwcQIzPf7o4imJ4Y2VI4Qp9QkvCA4eoq5UXWiWxGKdJSgm2nK44xz3iFO1yvFlcY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CRUEGZFA; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 28449C8768;
	Thu, 15 Feb 2024 15:36:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2AD1FF809;
	Thu, 15 Feb 2024 15:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708011391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+VdOMGdhUfnRqC84Ds5qac0THeFNjbkMbQFO9qc5HW0=;
	b=CRUEGZFAXDgeTHu5kecJXNIKhz+bUdJmbxnNGF5IbvVOjnsmfTe46lk6qelri2fgmCdKq+
	2Jh6vqUVAIrheNpl12a3Dj7k+iabPy6JR1FZJG8FhvJ83X3CPI+UjhYbx/nbWIxdcpDbOO
	aL2znWcb6ADFHg82PPNcN3cplGUcwcfFjli+xinRpHFGoADaoDSOxAXhqyoCvy9aODs6o1
	0u9ltZK/fg0pzqJL39yt7+dFVzMkx6SwlJZgKgK8AikZIRIb2KZ7Z4k7Wh8UzptJjcB3SJ
	3/p4WQP2ABd7a2rUQUDGRfJCkchtZSeL+gcSPb/ImFH8j1aMuNqmbeivhCUPfw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 15 Feb 2024 16:36:18 +0100
Subject: [PATCH 1/4] wifi: wilc1000: split deeply nested RCU list traversal
 in dedicated helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240215-wilc_fix_rcu_usage-v1-1-f610e46c6f82@bootlin.com>
References: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
In-Reply-To: <20240215-wilc_fix_rcu_usage-v1-0-f610e46c6f82@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: alexis.lothore@bootlin.com

Move netif_wake_queue and its surrounding RCU operations in a dedicated
function to clarify wilc_txq_task and ease refactoring

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 25 +++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 22f461f477f1..62414ab8846e 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -140,6 +140,19 @@ int wilc_wlan_get_num_conn_ifcs(struct wilc *wilc)
 	return ret_val;
 }
 
+static void wilc_wake_tx_queues(struct wilc *wl)
+{
+	int srcu_idx;
+	struct wilc_vif *ifc;
+
+	srcu_idx = srcu_read_lock(&wl->srcu);
+	list_for_each_entry_rcu(ifc, &wl->vif_list, list) {
+		if (ifc->mac_opened && netif_queue_stopped(ifc->ndev))
+			netif_wake_queue(ifc->ndev);
+	}
+	srcu_read_unlock(&wl->srcu, srcu_idx);
+}
+
 static int wilc_txq_task(void *vp)
 {
 	int ret;
@@ -160,17 +173,7 @@ static int wilc_txq_task(void *vp)
 		do {
 			ret = wilc_wlan_handle_txq(wl, &txq_count);
 			if (txq_count < FLOW_CONTROL_LOWER_THRESHOLD) {
-				int srcu_idx;
-				struct wilc_vif *ifc;
-
-				srcu_idx = srcu_read_lock(&wl->srcu);
-				list_for_each_entry_rcu(ifc, &wl->vif_list,
-							list) {
-					if (ifc->mac_opened &&
-					    netif_queue_stopped(ifc->ndev))
-						netif_wake_queue(ifc->ndev);
-				}
-				srcu_read_unlock(&wl->srcu, srcu_idx);
+				wilc_wake_tx_queues(wl);
 			}
 			if (ret != WILC_VMM_ENTRY_FULL_RETRY)
 				break;

-- 
2.43.0


