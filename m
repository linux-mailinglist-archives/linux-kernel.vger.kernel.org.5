Return-Path: <linux-kernel+bounces-118011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251AF88B256
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8064E2E0AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1D46CDA6;
	Mon, 25 Mar 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G8yG7T6E"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3501E33995;
	Mon, 25 Mar 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400992; cv=fail; b=nBe8MD0kzjDMobHEs2bhVp3R7Wma4LE+ZFzLRLoDK3B1Ts3fseb2QjN4sK8yczdPg0X0FZN0H1djV/gzsHdqA85Ci1ks/AM8pNZgNhuAU2ZsjF7pFFLuZFz0s9rTQ8syI3eGB7V6ZhCwoHrMaf6VT7+8xid9N85sTbBGudPahi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400992; c=relaxed/simple;
	bh=W67yBa2jUitWtha1TmKuINUqWQ1xRYIVAZPRjcMNC30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnqKz7ncOpktKOSER/7Oas1AXb6oSHr9Imodn1Fd/jQWuwCZlAi09RX+2q21kxq8Ah0kk214o/G4nYnHLwncATJZywuVcLXk97p5VJtzzarcb2v75by3NL+kr1HxMsZUFIDqGo9EIM4g9UsZBeQxDtkr3o7lSO/M7FqRM87qkBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G8yG7T6E; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeZSA9GofO+uIHmpMRB7FhF/4Ya271Y2P74q5sM0C08lRQcqZv/5uVRwAhYo7vZ/pNqSa7i79qSpnVmSyY20iMYwjB/++mGIBOmMkA7xCacFOyr/XJHJiUHPM7UFkx3CBkG45MggAkzmjyLCe+x7A0Gx7ZLddQwOrUsvL5zk1BRTNHLaO2ymO36Arfm/PT8m7tUtGgJTtIZzwTOhNBYqKgMiDPY+sqBwUZPAoDmpNLZkYJqCsTfiTBBFlR76jjbxuSZqXq+oKcvIhdFOtKxenVl2EJJm7NJGF5OMShym4yXoWMSGzUuYPXtR+Lbt+qrx97FrDQtrLjAepw9kdcoAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWFXUT7GHxQAG1E1a6e7OezUYAmdd9HY8P/mnqwPAV8=;
 b=OV1BuYXe0ebHnxyDYHdVzZbWh0KK3tFPCwSR7HAFmvrs8wIm2fI2AJaN16o6C0Mx7mGK4BVhx8A2SWIGhC/VuDN1dpSc0fxNavbfNbI534GHTJduMcQ7RSfBhUUtIOvx8LS4v5XC29XQhiUtEuQdyOrsZak+nzVvOkVw/nKpm1+HdxnVp54QJ8s3uRvC5xztkh9m+X2N4HIJFIjqYkMkU0mQjkKmV1uv4FqeJb+WDBzVgKC7LtzIsYsEM0dkVSYiRjtZcecKPmZnUuf9+CESsblg/dHeSXH/Ec5/Z0r/RWOPopzVG7H5SKO+9ayEPzSF6QSRM+WLnqC2LTQTDED5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWFXUT7GHxQAG1E1a6e7OezUYAmdd9HY8P/mnqwPAV8=;
 b=G8yG7T6EtHRdhjfiNImnYWbDUw8hr6EfCxPhTPgHzB67fHqQaDmCETrkteofi556/yn/AZvLpAGovtJD+85TlYu7wAlEWdyDUtxAWOQklYfIc/nnzZYiMirEEEizsdx4jSe5EfdEPQC+htEBjHj71iHT7pxYHaNs4tbfSAAac7mxDbbzE8cWpl1z+VALp27mz/S/PU84w8+zZWDclTQ2/Il67bj2HC6e8jCa3i5O+j7SSTxhp2/A35lz3syvEBo0Mz68peQ212O4gMvauvjmajLJIxDrCkazfYWj/oiogTdAy0NMw5M0944xR5QIwl/17OmxpRIrMR7eRr1Gmk6sCQ==
Received: from BYAPR08CA0057.namprd08.prod.outlook.com (2603:10b6:a03:117::34)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 21:09:46 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::6) by BYAPR08CA0057.outlook.office365.com
 (2603:10b6:a03:117::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 21:09:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 21:09:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 14:09:32 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 14:09:32 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Mon, 25
 Mar 2024 14:09:31 -0700
From: David Thompson <davthompson@nvidia.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <u.kleine-koenig@pengutronix.de>, <leon@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net v1] mlxbf_gige: stop interface during shutdown
Date: Mon, 25 Mar 2024 17:09:29 -0400
Message-ID: <20240325210929.25362-1-davthompson@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f80d393-41f7-43b3-102e-08dc4d0fe5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KNXwWE9NYl2YwbXhN9nQukWlCqST3BuTi/9pZO9hKmNDHwBd6DA4yYRQ7odKYiILXN0DNrr0TaW17D0SscWP5KPnOivBQRu+AhUId87B8Psw5SxfkRl0eTTKMDXiyB1zJFRGKunRlftLnjGFFZnOcO5gdHoRUsrkdSuRkyPZK/PbQhQ1SKBYkG9Vj33+H9PrdzKwB3EVF6ZFDVZNtFoRp6RVW+jIdLcsW6ZlC2tqBVE9r7DiWjmi0N8JPAyCNPMMeGHH+ahUaR1+ogYdf4GF0yGHJb/IEEXiFeImTyYsjQAeoFDsPtyl9jiZjHSu8W/yyCSrMFLaqbtzHdlb/Dj/71213kcKpaQBIdoUVz8NHlxUjfNEJlQaB/ZHTJo8Lc7T7EDG78FlTStp1RBibZfuqfNSRPMNUU9TqdcUctrRpFQ/7HcXayhJ958q4IxI1cju3Z/UBmdgi6Dta3V8AW7EmcDox1GsmrZWwrvSh4dJhchRiouVpfBZC4Ud9qlzqzEv2HtqGGwC8Lz6OAnlmdT4J8JDDO0ICFPKlIU+RUnkbDfwfG2dXp3hxUZ0enGgvISQr8S3yMz/slYGq8vY/+QBnh9VTwkTvIC3yQqP7XEt3XH2KjzhjAXxEzSdIybn3/5KeDnwxs8bFLY9UKa0LH69CWV8SQBgJTRz6/lllgNOtw80ac7NRsYH8e5f75aI5e34PqkSnDohYSf6A+p88Z72QSSPX4xxZgxXjGAGOMpMpau0/9nEE5XNP4+FKBo7psX7
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 21:09:45.4458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f80d393-41f7-43b3-102e-08dc4d0fe5dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

The mlxbf_gige driver intermittantly encounters a NULL pointer
exception while the system is shutting down via "reboot" command.
The mlxbf_driver will experience an exception right after executing
its shutdown() method.  One example of this exception is:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000000011d373000
[0000000000000070] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 96000004 [#1] SMP
CPU: 0 PID: 13 Comm: ksoftirqd/0 Tainted: G S         OE     5.15.0-bf.6.gef6992a #1
Hardware name: https://www.mellanox.com BlueField SoC/BlueField SoC, BIOS 4.0.2.12669 Apr 21 2023
pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
lr : mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
sp : ffff8000080d3c10
x29: ffff8000080d3c10 x28: ffffcce72cbb7000 x27: ffff8000080d3d58
x26: ffff0000814e7340 x25: ffff331cd1a05000 x24: ffffcce72c4ea008
x23: ffff0000814e4b40 x22: ffff0000814e4d10 x21: ffff0000814e4128
x20: 0000000000000000 x19: ffff0000814e4a80 x18: ffffffffffffffff
x17: 000000000000001c x16: ffffcce72b4553f4 x15: ffff80008805b8a7
x14: 0000000000000000 x13: 0000000000000030 x12: 0101010101010101
x11: 7f7f7f7f7f7f7f7f x10: c2ac898b17576267 x9 : ffffcce720fa5404
x8 : ffff000080812138 x7 : 0000000000002e9a x6 : 0000000000000080
x5 : ffff00008de3b000 x4 : 0000000000000000 x3 : 0000000000000001
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 mlxbf_gige_handle_tx_complete+0xc8/0x170 [mlxbf_gige]
 mlxbf_gige_poll+0x54/0x160 [mlxbf_gige]
 __napi_poll+0x40/0x1c8
 net_rx_action+0x314/0x3a0
 __do_softirq+0x128/0x334
 run_ksoftirqd+0x54/0x6c
 smpboot_thread_fn+0x14c/0x190
 kthread+0x10c/0x110
 ret_from_fork+0x10/0x20
Code: 8b070000 f9000ea0 f95056c0 f86178a1 (b9407002)
---[ end trace 7cc3941aa0d8e6a4 ]---
Kernel panic - not syncing: Oops: Fatal exception in interrupt
Kernel Offset: 0x4ce722520000 from 0xffff800008000000
PHYS_OFFSET: 0x80000000
CPU features: 0x000005c1,a3330e5a
Memory Limit: none
---[ end Kernel panic - not syncing: Oops: Fatal exception in interrupt ]---

During system shutdown, the mlxbf_gige driver's shutdown() is always executed.
However, the driver's stop() method will only execute if networking interface
configuration logic within the Linux distribution has been setup to do so.

If shutdown() executes but stop() does not execute, NAPI remains enabled
and this can lead to an exception if NAPI is scheduled while the hardware
interface has only been partially deinitialized.

The networking interface managed by the mlxbf_gige driver must be properly
stopped during system shutdown so that IFF_UP is cleared, the hardware
interface is put into a clean state, and NAPI is fully deinitialized.

Fixes: f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 .../net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index cef0e2d3f1a7..455237f3b3a8 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/rtnetlink.h>
 #include <linux/skbuff.h>
 
 #include "mlxbf_gige.h"
@@ -488,8 +489,13 @@ static void mlxbf_gige_shutdown(struct platform_device *pdev)
 {
 	struct mlxbf_gige *priv = platform_get_drvdata(pdev);
 
-	writeq(0, priv->base + MLXBF_GIGE_INT_EN);
-	mlxbf_gige_clean_port(priv);
+	rtnl_lock();
+	netif_device_detach(priv->netdev);
+
+	if (netif_running(priv->netdev))
+		dev_close(priv->netdev);
+
+	rtnl_unlock();
 }
 
 static const struct acpi_device_id __maybe_unused mlxbf_gige_acpi_match[] = {
-- 
2.30.1


