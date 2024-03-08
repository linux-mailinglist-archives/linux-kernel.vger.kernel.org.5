Return-Path: <linux-kernel+bounces-97570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22B876C03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F1B1C2109F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF945E087;
	Fri,  8 Mar 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sy7SruOe"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD522B9A0
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930882; cv=none; b=OuHsj7c+G+gNTTzYtzJW7qOqsELkO3nxSfm6JzR47Lq1Cooe/9J+NNK0coIGB2xG147KWglFfm8oQSHXjOoxG5QlSqaizO3TsBW56It7hzg0mvRfJMjyf0RNe/RvhSDpHQ05q6jS/sDhJCPgs0LnEBH+30UmcbelBwue7pk4/Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930882; c=relaxed/simple;
	bh=KQkJiQ27BNNXeY443RrdvvABsZjrDEt8NFwQ/s2GJaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L2T7jxndfhWLg/M2hWase8JTEj4/Y6usTz0TFDNrZGipDM82zywBL/bvAEcnlf0XiUKz1+dZLB0gGhP8onNcc7fswdbxNMhAIFwvqLnz7ddz/kzdqgdRmeCQlixgI7hHWHoVQYYVyWwfJa8vTSgm+XFuJJvmRmg6WCHhb4DqIG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sy7SruOe; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709930878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RTlqUWoUc9ZLVeM/ETNgNqbyS2JTmHEkN+ChXJ5zV38=;
	b=sy7SruOe6bb27LV7crHdNDZYkpoUxXB/gIh9XGfi0eITgE9GRWpRMVIwCXjQLNMnezGgEu
	eiuZymZCCqPHaTg7Ttmes1O0zHSwjp5kmXIdVmXSSbLYsA6l9JuPBU4FPClPPgdnn52ov5
	JL6hK4ujLq875dJgjETmTME7hgoRzDE=
From: Sean Anderson <sean.anderson@linux.dev>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] drm: zynqmp_dpsub: Always register bridge
Date: Fri,  8 Mar 2024 15:47:41 -0500
Message-Id: <20240308204741.3631919-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

We must always register the DRM bridge, since zynqmp_dp_hpd_work_func
calls drm_bridge_hpd_notify, which in turn expects hpd_mutex to be
initialized. We do this before zynqmp_dpsub_drm_init since that calls
drm_bridge_attach. This fixes the following lockdep warning:

[   19.217084] ------------[ cut here ]------------
[   19.227530] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[   19.227768] WARNING: CPU: 0 PID: 140 at kernel/locking/mutex.c:582 __mutex_lock+0x4bc/0x550
[   19.241696] Modules linked in:
[   19.244937] CPU: 0 PID: 140 Comm: kworker/0:4 Not tainted 6.6.20+ #96
[   19.252046] Hardware name: xlnx,zynqmp (DT)
[   19.256421] Workqueue: events zynqmp_dp_hpd_work_func
[   19.261795] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   19.269104] pc : __mutex_lock+0x4bc/0x550
[   19.273364] lr : __mutex_lock+0x4bc/0x550
[   19.277592] sp : ffffffc085c5bbe0
[   19.281066] x29: ffffffc085c5bbe0 x28: 0000000000000000 x27: ffffff88009417f8
[   19.288624] x26: ffffff8800941788 x25: ffffff8800020008 x24: ffffffc082aa3000
[   19.296227] x23: ffffffc080d90e3c x22: 0000000000000002 x21: 0000000000000000
[   19.303744] x20: 0000000000000000 x19: ffffff88002f5210 x18: 0000000000000000
[   19.311295] x17: 6c707369642e3030 x16: 3030613464662072 x15: 0720072007200720
[   19.318922] x14: 0000000000000000 x13: 284e4f5f4e524157 x12: 0000000000000001
[   19.326442] x11: 0001ffc085c5b940 x10: 0001ff88003f388b x9 : 0001ff88003f3888
[   19.334003] x8 : 0001ff88003f3888 x7 : 0000000000000000 x6 : 0000000000000000
[   19.341537] x5 : 0000000000000000 x4 : 0000000000001668 x3 : 0000000000000000
[   19.349054] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff88003f3880
[   19.356581] Call trace:
[   19.359160]  __mutex_lock+0x4bc/0x550
[   19.363032]  mutex_lock_nested+0x24/0x30
[   19.367187]  drm_bridge_hpd_notify+0x2c/0x6c
[   19.371698]  zynqmp_dp_hpd_work_func+0x44/0x54
[   19.376364]  process_one_work+0x3ac/0x988
[   19.380660]  worker_thread+0x398/0x694
[   19.384736]  kthread+0x1bc/0x1c0
[   19.388241]  ret_from_fork+0x10/0x20
[   19.392031] irq event stamp: 183
[   19.395450] hardirqs last  enabled at (183): [<ffffffc0800b9278>] finish_task_switch.isra.0+0xa8/0x2d4
[   19.405140] hardirqs last disabled at (182): [<ffffffc081ad3754>] __schedule+0x714/0xd04
[   19.413612] softirqs last  enabled at (114): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
[   19.423128] softirqs last disabled at (110): [<ffffffc080133de8>] srcu_invoke_callbacks+0x158/0x23c
[   19.432614] ---[ end trace 0000000000000000 ]---

Fixes: eb2d64bfcc17 ("drm: xlnx: zynqmp_dpsub: Report HPD through the bridge")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/gpu/drm/xlnx/zynqmp_dpsub.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 88eb33acd5f0..639fff2c693f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -256,12 +256,11 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dp;
 
+	drm_bridge_add(dpsub->bridge);
 	if (dpsub->dma_enabled) {
 		ret = zynqmp_dpsub_drm_init(dpsub);
 		if (ret)
 			goto err_disp;
-	} else {
-		drm_bridge_add(dpsub->bridge);
 	}
 
 	dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
@@ -288,9 +287,8 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
 
 	if (dpsub->drm)
 		zynqmp_dpsub_drm_cleanup(dpsub);
-	else
-		drm_bridge_remove(dpsub->bridge);
 
+	drm_bridge_remove(dpsub->bridge);
 	zynqmp_disp_remove(dpsub);
 	zynqmp_dp_remove(dpsub);
 
-- 
2.35.1.1320.gc452695387.dirty


