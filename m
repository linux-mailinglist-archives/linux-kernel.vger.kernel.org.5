Return-Path: <linux-kernel+bounces-140372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0FA8A1378
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86B6B28A9EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866814D43B;
	Thu, 11 Apr 2024 11:45:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D50B147C9D;
	Thu, 11 Apr 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835909; cv=none; b=lY4OCIuidVC5t1NpUxci22PgececBhEv6XZTnC06SP+3NEpFa/Ni20DZnzozASefhgwnXG7cjArMgBn+81U9/j82tRarHVwfkROVg2B6uMNYb2Y6aXD17ElaVipHrQZzQ1MU7T8ha/QDuHmjqtJiQd+SNxY6RFrIIMqOLaT2p84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835909; c=relaxed/simple;
	bh=vnqWqqap9+fQ4BzCnsXTPQ93EcTt8RJgBFAXaAY6kT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fhmv1usktw67TyYezozZcxud25gJ18T7kNoa+5df+zMg2IA5dKgvxqbUyPst0Vr2nlt8a0zaGFhwd4GcERyMXSPzOvCKNtDoJYFpjgTiAsoclGcJRtIPDAcwuAPFV6vZk1ptwlfvo8oOJngmLJN9JE/6i7tFraaux00hac7L8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.07,193,1708354800"; 
   d="scan'208";a="201123388"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2024 20:45:07 +0900
Received: from renesas-deb12.cephei.uk (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B5E0D4202AC3;
	Thu, 11 Apr 2024 20:45:03 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/4] net: ravb: Fix GbEth jumbo packet RX checksum handling
Date: Thu, 11 Apr 2024 12:44:32 +0100
Message-Id: <20240411114434.26186-4-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
References: <20240411114434.26186-1-paul.barker.ct@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sending a 7kB ping packet to the RZ/G2L in Linux v6.9-rc2 causes the
following backtrace:

	WARNING: CPU: 0 PID: 0 at include/linux/skbuff.h:3127 skb_trim+0x30/0x38
	Modules linked in:
	CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W          6.9.0-rc1-00222-gde11614025b1 #3
	Hardware name: Renesas SMARC EVK based on r9a07g044l2 (DT)
	pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
	pc : skb_trim+0x30/0x38
	lr : ravb_rx_csum_gbeth+0x40/0x90
	sp : ffff800080003d40
	x29: ffff800080003d40 x28: 0000000000000400 x27: ffff00000d0f0000
	x26: 0000000000000001 x25: ffff800080003e84 x24: 0000000000000e52
	x23: 0000000000000000 x22: ffff00000d0f0960 x21: 000000000000ffff
	x20: 000000000000f6ff x19: ffff00000cf4cb00 x18: 0000000000000000
	x17: ffff7ffffdd4f000 x16: ffff800080000000 x15: e7e6e5e4e3e2e1e0
	x14: dfdedddcdbdad9d8 x13: 0000131211100f0e x12: 0d0c0b0a09080706
	x11: 0000000013121110 x10: 0000000000000000 x9 : 0000000000000001
	x8 : ffff800080003cf0 x7 : 0000000000000000 x6 : ffff00007faf4590
	x5 : 000000000010000b x4 : a1a8362deecb53ea x3 : 0000000000000080
	x2 : 00000000ffff0000 x1 : 000000000cf4ccfc x0 : ffff00000cf4cb00
	Call trace:
	 skb_trim+0x30/0x38
	 ravb_rx_gbeth+0x56c/0x5cc
	 ravb_poll+0xa0/0x204
	 __napi_poll+0x38/0x17c
	 net_rx_action+0x124/0x268
	 __do_softirq+0x100/0x26c
	 ____do_softirq+0x10/0x1c
	 call_on_irq_stack+0x24/0x4c
	 do_softirq_own_stack+0x1c/0x2c
	 irq_exit_rcu+0xbc/0xd8
	 el1_interrupt+0x38/0x68
	 el1h_64_irq_handler+0x18/0x24
	 el1h_64_irq+0x64/0x68
	 default_idle_call+0x28/0x3c
	 do_idle+0x204/0x25c
	 cpu_startup_entry+0x38/0x3c
	 kernel_init+0x0/0x1d8
	 start_kernel+0x504/0x5f0
	 __primary_switched+0x80/0x88
	---[ end trace 0000000000000000 ]---

This is caused by ravb_rx_gbeth() calling ravb_rx_csum_gbeth() with the
wrong skb for a packet which spans multiple descriptors. To fix this,
use the correct skb.

Fixes: c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 028ab5c6aaf7..e1e39f65224c 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -843,7 +843,7 @@ static bool ravb_rx_gbeth(struct net_device *ndev, int *quota, int q)
 				priv->rx_1st_skb->protocol =
 					eth_type_trans(priv->rx_1st_skb, ndev);
 				if (ndev->features & NETIF_F_RXCSUM)
-					ravb_rx_csum_gbeth(skb);
+					ravb_rx_csum_gbeth(priv->rx_1st_skb);
 				napi_gro_receive(&priv->napi[q],
 						 priv->rx_1st_skb);
 				rx_packets++;
-- 
2.39.2


