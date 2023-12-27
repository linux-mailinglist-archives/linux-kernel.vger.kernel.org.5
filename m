Return-Path: <linux-kernel+bounces-11872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FC81ECC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73601F21802
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A895396;
	Wed, 27 Dec 2023 07:03:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zju.edu.cn (spam.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2293C6105;
	Wed, 27 Dec 2023 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [10.190.69.69])
	by mail-app3 (Coremail) with SMTP id cC_KCgDX3_IezItlmZCLAQ--.17434S4;
	Wed, 27 Dec 2023 15:03:01 +0800 (CST)
From: Dinghao Liu <dinghao.liu@zju.edu.cn>
To: dinghao.liu@zju.edu.cn
Cc: GR-Linux-NIC-Dev@marvell.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ron Mercer <ron.mercer@qlogic.com>,
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues
Date: Wed, 27 Dec 2023 15:02:27 +0800
Message-Id: <20231227070227.10527-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgDX3_IezItlmZCLAQ--.17434S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw4DAr1xKr15JF1UCrWfZrb_yoWkArcEgr
	1fZryxWayDGFWYkrW7tr4UA34Yyrn8Z3WruF4fKFW3Xr4DXasIvryUXFykXay7Gw1fCrWD
	t347WrWfCw1rtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwPBmWCupcTBwAdsE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

When dma_alloc_coherent() fails, we should free qdev->lrg_buf
to prevent potential memleak.

Fixes: 1357bfcf7106 ("qla3xxx: Dynamically size the rx buffer queue based on the MTU.")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 0d57ffcedf0c..fc78bc959ded 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -2591,6 +2591,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 
 	if (qdev->lrg_buf_q_alloc_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "lBufQ failed\n");
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 	qdev->lrg_buf_q_virt_addr = qdev->lrg_buf_q_alloc_virt_addr;
@@ -2615,6 +2616,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 				  qdev->lrg_buf_q_alloc_size,
 				  qdev->lrg_buf_q_alloc_virt_addr,
 				  qdev->lrg_buf_q_alloc_phy_addr);
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 
-- 
2.17.1


