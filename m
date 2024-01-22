Return-Path: <linux-kernel+bounces-33836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B87D836F28
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E8D2936DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADCB405CE;
	Mon, 22 Jan 2024 17:36:59 +0000 (UTC)
Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027FE405C1;
	Mon, 22 Jan 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945018; cv=none; b=ndYPsoc/sU3dn6F6q4RrmxfBN9mCb/wdzS7s54OxtLtajIapNbc6OIWFmEg/6aeFdWyKo9MMwdDzoIjXjEFp2uANjBbTrPK/T0JZVIe6qHuy3aI7tRcuUlS6+my0RjhLAcXk1n5NwnAUd/n6RIgPkDZqRSyEEercna9xVXQYQFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945018; c=relaxed/simple;
	bh=i72cJ4XFiJ0tpwKQAmgnTBVwkuYQVUv9RJhyiyqLK+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qRCi844cvUn1AxLdcHQof2Kb2QDlrveu9FGFD/zmZNIH9MJodScNVewiC1BVx+QRgMrl/boDjxL68ulSUmAX65cAaSooIgkhurEZnPD7tmlt89xP36PNf5bHDTpVEGcsONtCJMIonL0tUQpTB5MIL8sCxrRPInIiCuxYPIenmt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [39.174.92.167])
	by mail-app3 (Coremail) with SMTP id cC_KCgBnSTOlp65lU814AA--.4097S2;
	Tue, 23 Jan 2024 01:36:38 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Piotr Marczak <piotr.marczak@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i40e: fix a memleak in i40e_init_recovery_mode
Date: Tue, 23 Jan 2024 01:36:33 +0800
Message-Id: <20240122173633.3843715-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cC_KCgBnSTOlp65lU814AA--.4097S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWkZr17Zr1xKr45GrWrGrg_yoW8CryDpF
	4DWa4kGry0qr43Was7Gw48CFZ5J3y3tryUWa13Kan5urnYyF1kXFy8tFyUCFy8ArZ3X3Zx
	Jrn7ArWxuryDGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0sjjDUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In i40e_init_recovery_mode, pf->vsi is allocated without free, causing
a memleak. This patch adds deallocation operations for pf->vsi in each
and every error-handling paths after pf->vsi's.

Fixes: 4ff0ee1af016 ("i40e: Introduce recovery mode support")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 1ab8dbe2d880..a2ed6bb3b2dc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -15598,27 +15598,27 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
 	if (v_idx < 0) {
 		err = v_idx;
-		goto err_switch_setup;
+		goto err_vsis;
 	}
 	pf->lan_vsi = v_idx;
 	vsi = pf->vsi[v_idx];
 	if (!vsi) {
 		err = -EFAULT;
-		goto err_switch_setup;
+		goto err_vsis;
 	}
 	vsi->alloc_queue_pairs = 1;
 	err = i40e_config_netdev(vsi);
 	if (err)
-		goto err_switch_setup;
+		goto err_vsis;
 	err = register_netdev(vsi->netdev);
 	if (err)
-		goto err_switch_setup;
+		goto err_vsis;
 	vsi->netdev_registered = true;
 	i40e_dbg_pf_init(pf);
 
 	err = i40e_setup_misc_vector_for_recovery_mode(pf);
 	if (err)
-		goto err_switch_setup;
+		goto err_vsis;
 
 	/* tell the firmware that we're starting */
 	i40e_send_version(pf);
@@ -15628,7 +15628,8 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 		  round_jiffies(jiffies + pf->service_timer_period));
 
 	return 0;
-
+err_vsis:
+	kfree(pf->vsi);
 err_switch_setup:
 	i40e_reset_interrupt_capability(pf);
 	timer_shutdown_sync(&pf->service_timer);
-- 
2.34.1


