Return-Path: <linux-kernel+bounces-9855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BDC81CC67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3569B285D90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CF241E6;
	Fri, 22 Dec 2023 15:50:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716F23753;
	Fri, 22 Dec 2023 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from luzhipeng.223.5.5.5 (unknown [122.235.244.73])
	by mail-app4 (Coremail) with SMTP id cS_KCgAHfTQtsIVlegLlAA--.3975S2;
	Fri, 22 Dec 2023 23:50:06 +0800 (CST)
From: Zhipeng Lu <alexious@zju.edu.cn>
To: alexious@zju.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] [v2] sfc: fix a double-free bug in efx_probe_filters
Date: Fri, 22 Dec 2023 23:49:52 +0800
Message-Id: <20231222154952.3531636-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cS_KCgAHfTQtsIVlegLlAA--.3975S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFWDZF48ZrWfAFW8Ww1DGFg_yoW8GF4xpa
	yYk3y2gr1rXF15W3WkJ3s7ZF98AayDXa4jgFnIkw4fuw1qyrn8Cw1Sqaya9ryDArW3Aa1a
	v3sYyr1UZ3ZxAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUjLiSJUUUUU==
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/

In efx_probe_filters, the channel->rps_flow_id is freed in a
efx_for_each_channel marco  when success equals to 0.
However, after the following call chain:

ef100_net_open
  |-> efx_probe_filters
  |-> ef100_net_stop
        |-> efx_remove_filters

The channel->rps_flow_id is freed again in the efx_for_each_channel of
efx_remove_filters, triggering a double-free bug.
---
Changelog:

v2: Correct the call-chain description in commit message and change
patch subject.

Fixes: a9dc3d5612ce ("sfc_ef100: RX filter table management and related gubbins")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/rx_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sfc/rx_common.c b/drivers/net/ethernet/sfc/rx_common.c
index d2f35ee15eff..fac227d372db 100644
--- a/drivers/net/ethernet/sfc/rx_common.c
+++ b/drivers/net/ethernet/sfc/rx_common.c
@@ -823,8 +823,10 @@ int efx_probe_filters(struct efx_nic *efx)
 		}
 
 		if (!success) {
-			efx_for_each_channel(channel, efx)
+			efx_for_each_channel(channel, efx) {
 				kfree(channel->rps_flow_id);
+				channel->rps_flow_id = NULL;
+			}
 			efx->type->filter_table_remove(efx);
 			rc = -ENOMEM;
 			goto out_unlock;
-- 
2.34.1


