Return-Path: <linux-kernel+bounces-107992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1CF880493
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84C11F24182
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9981136120;
	Tue, 19 Mar 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GKaLwTF9"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A12E64F;
	Tue, 19 Mar 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872277; cv=fail; b=aEMXwBlBpB56wi6ibNfe5L7vrswMZvUeGE8K5j6aJP4DESDr9wrhMa9MvEOOZqDHADuImwvRyV4hI86gW9IeA2tEEZuBasZkYz3aym5CTGjWuc27W+mjW13n8ymeDRLGggChATXwk6TT1fR0FWYq1pqOyYbPLUIVmZPEaVm4umU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872277; c=relaxed/simple;
	bh=h4Krzm1+TNELF4M9dY0bs5QajCD+Q+64XYwzs09GLPA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jw8Bd2KGjMFQR0LcZy3mGwQsp1ZbNDxJQ1VWuhQZZgXeNOVH15bMn5/PsMzsijIbvLbFZeAKedkJEf7gTEcm+2ddvc37EAjbX5WxmWPyEMJWNvQ4F1Lb1tVIuS4O+ffCnpKwjaUQp/hOAbdBhLjohyvFhTn6blvRsLIP912Ou24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GKaLwTF9; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIlwHrpD+RRj6oOdUFeVN11h+8ps7MnZedfnPMhn+D/vYZteYfO8RyJEmKfcujRzgZmkdyEAdMqJKrXlLRN9RuLWtwpytCAb/EDpfpK2CBKX2kaDiJsZe9QbYmClQG5/dMcWyaZ960dlh9GxCO+TcMv04rVi8LYWhAHVD+UooG60A+z/gd8E5/9M/UxpC2Xei7LldTU09woUEsn2c1CynT7kS2zayLtdr0qj9qaak+hFT/93w4qc3LIYYe9SifGCENPEVNd0kxrzF9ZSauX66WD6y046Js6aoPuaX42gmMqyz3WDr3f7jY87Q5oZh7DygeDNXQU4quDlboS/W5UhbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6nkhFPhzqBVe5rhqTVNK5BrMMJOm93N4h46BtjjUrM=;
 b=ZSKYTGPVbOrA0Qo20aTE4vp6bs45fgCHpWWQK1G/n5TQqEDwkegpK5GY7FnmoqL8QSbIjrFwtFcoDROxFXUzkMvrHSG8G4Vc+yg6pqgXkAGpCi04Oq6zNv9IuVDBxYBvB0WcJUX2PBSx3MmypuEIemMVBCXdXfMVV9qSMK6Cxe1z3jAVJZfNDw+nG3EZDtQS/gNPIQwuFfH/L/OMZptGE23fdCiSDMhUJcP30UFWO2Y8LXFzWIdxyLz76BVfuOks+nBYHkWMBb1KnhgobGUShNnOqPV7RLjE1b8CKZUzjM0zL7kPJw93t2JodDQDqLNBJsietvXtxG4gkky8oTacDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6nkhFPhzqBVe5rhqTVNK5BrMMJOm93N4h46BtjjUrM=;
 b=GKaLwTF9OijTwQuCz6h1+/IAzzthcAZNqOsPD7EBqIRTJ6uEd7ZKrPzYZax6DsVVPNUviHjDULuWkvwy8LzUH36gLfXD3zLJDDj2KyI9DYxdJ8uUvZVJbKgbk9srNKqLaQv/rsDGfH5yrBZzHpoZIxHR9HEmQwQBnTOZFylWF6X6eKb66icvZNUAW5m1kJkn+41txZi3qr3E7LeAGp2V6ifI/0QFODnOeD8BlFVb72qhJvvYj4ATUhted0+rqWjI827aqOBnl5W68L/V1q1fbuJ+5vvFzuzae6CbRYldC1pPpVhRd5LMTU3LtBB6i8GJF2IhsY193WSZ/cDt3x522A==
Received: from CH0P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::23)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 18:17:47 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::a3) by CH0P221CA0007.outlook.office365.com
 (2603:10b6:610:11c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Tue, 19 Mar 2024 18:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 18:17:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Mar
 2024 11:17:35 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 19 Mar 2024 11:17:34 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 19
 Mar 2024 11:17:33 -0700
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <u.kleine-koenig@pengutronix.de>, <leon@kernel.org>
CC: <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v2] mlxbf_gige: call request_irq() after NAPI initialized
Date: Tue, 19 Mar 2024 14:17:32 -0400
Message-ID: <20240319181732.12878-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b57108-a52b-4fa2-1d3a-08dc4840e12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iJSjf7I5SaCU+kdPO0EUTtm3iV+QR9ko8EQnXT5KqIp2NiYORp5nl9he1R/t2n0QcB8ZijWaNPMmjKYLUjWCIOncBzYk5OKcE/ZjhNTSZ2C7s4C5zLfUXUJeoscbrqtBTOo09+2qD8bxONMpZQfnK8i4wMj1RYZ9M7lRmr5Qk00HT3COoMl5taxOFWgjS6MEhqnkgx+BNqj/jvttjtDRPVc3EGwk00+0xPZ4ZDMNuDsrdBhEb04q+EIom0NjB+XLz8uSE0wEcd3JJXO7KAICkQKt8pwgYZxNgcEiXnPAzlMYBT8VPBRP3YRbFSKtD991fQXy/ttEBsH+acXxoLQlA6m6/5p+Iw9Cu9ls0XTyqauauM7d2LyNNOwkbRhI6vwlg2JQ+7bo9wUpmCphADAomki8Ho1ed2HlLUVZz2NV5+fwLQl5LcOzHI5k8De7X9WOgFcg4U//XL5S2pNTxoWFavqCCOMdfnVZru5rethMLI7CLKgi1T7NKVmpWoTBgBJqxP/e3ZyEHZURKhLSAn8gdAm+Cjwe3qOvjQRI4YsCjcv6tj6/uaQXlCL8jYXfTIPoLWrM3Gsy3nQb0ZkUgX4VeO1JqKPFP1omRl97yR4EipMkUkMnXketPS7jZjxw8SKy4q72B34nU1GGyL+GMF5u9yfk7iysbP5eCQhLuqVDcLn5ujEVfax6RqOiQiDJKt4PKSXL059EgJqMIg/ztcKZT28s66aJSXExTJCQHbPbthCqAFqaNKWzzHNh87QFqZw5
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:17:47.1273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b57108-a52b-4fa2-1d3a-08dc4840e12f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152

The mlxbf_gige driver encounters a NULL pointer exception in
mlxbf_gige_open() when kdump is enabled.  The sequence to reproduce
the exception is as follows:
a) enable kdump
b) trigger kdump via "echo c > /proc/sysrq-trigger"
c) kdump kernel executes
d) kdump kernel loads mlxbf_gige module
e) the mlxbf_gige module runs its open() as the
   the "oob_net0" interface is brought up
f) mlxbf_gige module will experience an exception
   during its open(), something like:

     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
     Mem abort info:
       ESR = 0x0000000086000004
       EC = 0x21: IABT (current EL), IL = 32 bits
       SET = 0, FnV = 0
       EA = 0, S1PTW = 0
       FSC = 0x04: level 0 translation fault
     user pgtable: 4k pages, 48-bit VAs, pgdp=00000000e29a4000
     [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
     Internal error: Oops: 0000000086000004 [#1] SMP
     CPU: 0 PID: 812 Comm: NetworkManager Tainted: G           OE     5.15.0-1035-bluefield #37-Ubuntu
     Hardware name: https://www.mellanox.com BlueField-3 SmartNIC Main Card/BlueField-3 SmartNIC Main Card, BIOS 4.6.0.13024 Jan 19 2024
     pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
     pc : 0x0
     lr : __napi_poll+0x40/0x230
     sp : ffff800008003e00
     x29: ffff800008003e00 x28: 0000000000000000 x27: 00000000ffffffff
     x26: ffff000066027238 x25: ffff00007cedec00 x24: ffff800008003ec8
     x23: 000000000000012c x22: ffff800008003eb7 x21: 0000000000000000
     x20: 0000000000000001 x19: ffff000066027238 x18: 0000000000000000
     x17: ffff578fcb450000 x16: ffffa870b083c7c0 x15: 0000aaab010441d0
     x14: 0000000000000001 x13: 00726f7272655f65 x12: 6769675f6662786c
     x11: 0000000000000000 x10: 0000000000000000 x9 : ffffa870b0842398
     x8 : 0000000000000004 x7 : fe5a48b9069706ea x6 : 17fdb11fc84ae0d2
     x5 : d94a82549d594f35 x4 : 0000000000000000 x3 : 0000000000400100
     x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000066027238
     Call trace:
      0x0
      net_rx_action+0x178/0x360
      __do_softirq+0x15c/0x428
      __irq_exit_rcu+0xac/0xec
      irq_exit+0x18/0x2c
      handle_domain_irq+0x6c/0xa0
      gic_handle_irq+0xec/0x1b0
      call_on_irq_stack+0x20/0x2c
      do_interrupt_handler+0x5c/0x70
      el1_interrupt+0x30/0x50
      el1h_64_irq_handler+0x18/0x2c
      el1h_64_irq+0x7c/0x80
      __setup_irq+0x4c0/0x950
      request_threaded_irq+0xf4/0x1bc
      mlxbf_gige_request_irqs+0x68/0x110 [mlxbf_gige]
      mlxbf_gige_open+0x5c/0x170 [mlxbf_gige]
      __dev_open+0x100/0x220
      __dev_change_flags+0x16c/0x1f0
      dev_change_flags+0x2c/0x70
      do_setlink+0x220/0xa40
      __rtnl_newlink+0x56c/0x8a0
      rtnl_newlink+0x58/0x84
      rtnetlink_rcv_msg+0x138/0x3c4
      netlink_rcv_skb+0x64/0x130
      rtnetlink_rcv+0x20/0x30
      netlink_unicast+0x2ec/0x360
      netlink_sendmsg+0x278/0x490
      __sock_sendmsg+0x5c/0x6c
      ____sys_sendmsg+0x290/0x2d4
      ___sys_sendmsg+0x84/0xd0
      __sys_sendmsg+0x70/0xd0
      __arm64_sys_sendmsg+0x2c/0x40
      invoke_syscall+0x78/0x100
      el0_svc_common.constprop.0+0x54/0x184
      do_el0_svc+0x30/0xac
      el0_svc+0x48/0x160
      el0t_64_sync_handler+0xa4/0x12c
      el0t_64_sync+0x1a4/0x1a8
     Code: bad PC value
     ---[ end trace 7d1c3f3bf9d81885 ]---
     Kernel panic - not syncing: Oops: Fatal exception in interrupt
     Kernel Offset: 0x2870a7a00000 from 0xffff800008000000
     PHYS_OFFSET: 0x80000000
     CPU features: 0x0,000005c1,a3332a5a
     Memory Limit: none
     ---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

The exception happens because there is a pending RX interrupt before the
call to request_irq(RX IRQ) executes.  Then, the RX IRQ handler fires
immediately after this request_irq() completes. The RX IRQ handler runs
"napi_schedule()" before NAPI is fully initialized via "netif_napi_add()"
and "napi_enable()", both which happen later in the open() logic.

The logic in mlxbf_gige_open() has been re-ordered so that the
request_irq() calls execute after NAPI is fully initialized.

Also, the logic in mlxbf_gige_open() was missing a call to phy_stop()
in the error path, so that has been added.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
v2
- re-worded commit message and subject for clarity
- updated commit message to mention that phy_stop() was added
  to the error path in mlxbf_gige_open()
---
 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index 3d09fa54598f..77134ca92938 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -139,13 +139,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	control |= MLXBF_GIGE_CONTROL_PORT_EN;
 	writeq(control, priv->base + MLXBF_GIGE_CONTROL);
 
-	err = mlxbf_gige_request_irqs(priv);
-	if (err)
-		return err;
 	mlxbf_gige_cache_stats(priv);
 	err = mlxbf_gige_clean_port(priv);
 	if (err)
-		goto free_irqs;
+		return err;
 
 	/* Clear driver's valid_polarity to match hardware,
 	 * since the above call to clean_port() resets the
@@ -157,7 +154,7 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	err = mlxbf_gige_tx_init(priv);
 	if (err)
-		goto free_irqs;
+		goto phy_deinit;
 	err = mlxbf_gige_rx_init(priv);
 	if (err)
 		goto tx_deinit;
@@ -166,6 +163,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	napi_enable(&priv->napi);
 	netif_start_queue(netdev);
 
+	err = mlxbf_gige_request_irqs(priv);
+	if (err)
+		goto napi_deinit;
+
 	/* Set bits in INT_EN that we care about */
 	int_en = MLXBF_GIGE_INT_EN_HW_ACCESS_ERROR |
 		 MLXBF_GIGE_INT_EN_TX_CHECKSUM_INPUTS |
@@ -182,11 +183,17 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	return 0;
 
+napi_deinit:
+	netif_stop_queue(netdev);
+	napi_disable(&priv->napi);
+	netif_napi_del(&priv->napi);
+	mlxbf_gige_rx_deinit(priv);
+
 tx_deinit:
 	mlxbf_gige_tx_deinit(priv);
 
-free_irqs:
-	mlxbf_gige_free_irqs(priv);
+phy_deinit:
+	phy_stop(phydev);
 	return err;
 }
 
-- 
2.30.1


