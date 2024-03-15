Return-Path: <linux-kernel+bounces-104546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 770D587CF8E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC09E1F239BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D52F3C6AB;
	Fri, 15 Mar 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bmeo98tr"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C692E64E;
	Fri, 15 Mar 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514592; cv=fail; b=pbsX+IVhNiLxxXYDg55u7de9CxHeKQM8v/nOXvZSmWy7mww2d3Kfyazx3or+qMZZTf1H0TL+0Y1vTQDnbo+dbmb/qnEyW+QOPCjcvUMOgjU4Aqi1p5+AxTgpR1X5KroF44G80Mif/95bMV4nsSXH8NAoY7XyXU8BVrPH9+zr4mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514592; c=relaxed/simple;
	bh=HKORdv0veWnW/ZdiFzfFjQ/9w2WHkh5orCfQivGov/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aroFcJzE+NeY4oqSp9NoOtbVokmk51lgcfA138JcF0aE3qfyHcpyGXDMeDfXSt6pK/ABcgf2PI11az9e1sCk6YK8aBsycCgvAnAbh8ucl54I21hqtzalYyiIiXGgJ91EMmR6A2pLrTaMnHxOGZobgouHGWYH8YB6Z22kGOqA2gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bmeo98tr; arc=fail smtp.client-ip=40.107.237.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WenyJIrQPJ2sp2pltAbV4emWmUWhPYcFAcxkcuy4bnuTZMhMPvAvyKzNKTOsVQrgeu94fmE9YBAeEkQG/67a7gR6xD1Ylk4E6eG4TGMSZOczWHmdz5oPW7wcoyakhPxVNGBX477xFAeBRGpWRa/ybjsPrPLtcESNH/EYX5ah8DYLhK08EgsLlZ+dmx9npNlDIInEzeVI0MVCG3QDOaW6y8N6V4ndY2gTqr1cijLLOevLEqVYeAnENgTluyKsKxt+BlUBjeV8JDEX53R/Bc8vAG8ygnk5lyjr1MmUeWHWJme3WIpXA0t4qZT9IaAm3Ii8VqsYM7T+osOabadQROHdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRSXQJGO9wY/uHZBeb9vjKXafiIjhRfE0Bl3NzdOCAQ=;
 b=e554iGro9P+yEWAO6xscmA6713i8oGqHqMpSYqtf0mwBsrS8MMtdT43d2CTbRg7tn/P//rpJailCnxiMH9ZYmX0VPfaJU+JBSx9hDtHra5ydVN0yjWt9I8yxncH0hmqnoFMqynNRBAFh0u9gxIlKe8AofcYh/ZuNYS7+SqzKcTTZSYTmiFnqVXf1CbOjXadJIq2x4qLQoHHz3sXiGRlCsHncElBtiXIq/aD3z+CkFENGOUrJdjLdHhy59pG7m19JsmxzBulwwrNCpCTaXzeiQXQ3WVjODLMCu9ffN21ig7hpaqfj8dGS2gdft17dQcVbM32Uc8wlTjZEuhqHzPbmVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRSXQJGO9wY/uHZBeb9vjKXafiIjhRfE0Bl3NzdOCAQ=;
 b=Bmeo98trUNxmJuaJ2HaEaTFxl9MS4WEHCgUE2vISV6dM8HnWPxldqZ6Dq+WwssK/jHKjsfHk5QWqvVDHUyuIvdSrgsjd3JJi8nieNgRB/YAOZl0JJW/ATRY5yFEM1PDWDYNQ0/UIkeKQULD4B2ssjZlIGlLib/b9nIS6TtQwCv5riQLYg579Y+zprndRxfAx0mnlkMbgTzVl02mnbSdzDibQgEqHkxpdiDu19jah4Ek8WfMwNjawXwcWyq5nLsGi/9Q/I3UcqnnE9rOOPVw+TA2ngSab4hR5+bc3kxq+ZxvkN4sJPtzB2lPlLEDNn4vKPiUxMOxidiJyE2hE5aqaDw==
Received: from DM6PR12CA0002.namprd12.prod.outlook.com (2603:10b6:5:1c0::15)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 14:56:27 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::ec) by DM6PR12CA0002.outlook.office365.com
 (2603:10b6:5:1c0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 14:56:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 14:56:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Mar
 2024 07:56:13 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 15 Mar
 2024 07:56:13 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Fri, 15
 Mar 2024 07:56:11 -0700
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <u.kleine-koenig@pengutronix.de>, <leon@kernel.org>
CC: <asmaa@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH net v1] mlxbf_gige: open() should call request_irq() after NAPI init
Date: Fri, 15 Mar 2024 10:56:09 -0400
Message-ID: <20240315145609.23950-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9ffbe5-e978-4b7a-fc08-08dc450016f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LIampGIfNOpGsIpKF1L5A57XqhRLuGmMzp9TuVihFvqXpdrKQdNznPxWZzFqB7vP7BLYtq/OLl5Tt4ZYLjdX/LBTZyBVFX4WUZVCim4joutBL0/CCA8SMCA+keG6HnIRADzuTWYlPvPr3mN1LgDdurcOGoug0OERVjZR8tWsUFwZKQuv8pEsi8TJY9B1jYvkYdX5bJDUgHKBOLFBwMd/j3EHbVYFev8P9dNjyg1uhA4SmwPfmG90NvLDqEJSM4fODfE1H14IT9/nhABZOb+ZpPeQI3CrkMdnpfn2zpf8UQEnIVR5uBk/atDF6UdNrPV+LM2ofMQCf61M8DRzVOjUZW7g72U6w3eRBYufcElfdAraaXOUBEdtd+osO9qGe9vlnCoHlG7siBV8c6O2XTyZyMfqcnSAMEWY4EdIKOPSAdss4v0sVb2w50r8VnDmkL2eYlbRa/cBN3zAlxObmqn6FwpwLyMd/6KcEI5ft7JQLbb3JcExOy2qlGj/szApNLrYINdJCXVeCxwyBN6cg7BwPXOBGeDuHjhF+0jzJ4hDaWL/krs0M+hsfWfo1iVWeWpEGieTcl5oGCwjRO35P9TSGNiCkK9rK1p9lhFs9ed/YrS7Su8bdgPyxWBARLqDeFmeIs7QOPKV4Ju4KC3lXqwdT396O9IsHt1mY+pTPYrhTkaVtSHj93VvIvUi52d417gzvk6zmGXQrKTdCQqQCoaXCUavHzgIsltlvF18IGZXOgggeqzT6IM6gHtQ3GrRHpxv
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 14:56:26.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9ffbe5-e978-4b7a-fc08-08dc450016f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

This patch fixes an exception that occurs during open()
when kdump is enabled.  The sequence to reproduce the
exception is as follows:
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

This patch fixes the issue by re-ordering the logic in mlxbf_gige open()
so that the request_irq() calls execute after NAPI is fully initialized.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Asmaa Mnebhi <asmaa@nvidia.com>
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


