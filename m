Return-Path: <linux-kernel+bounces-118383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81388B9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 06:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3CA2E383A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 05:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FA12AAD1;
	Tue, 26 Mar 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FfQkN8w8"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6084128374;
	Tue, 26 Mar 2024 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711432440; cv=fail; b=b7fU+wHBHYtOMfQZsrNQTP87kLYvc89PyU39pkqmF0Yw066zK8NNxz5MG1d40HUAExTVSL04JXrhkZ08M0KMB+9p04t3oDNnEk8Vn2vW+kefqnrAyM/ZkGaCWsmCUyHrFDsr8qH6wpmHLzWtG6fkPOLKOseKIaMqO6J9hAw3gQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711432440; c=relaxed/simple;
	bh=S/1f5Z+De33MMJMXzN0DQR1w+1Dz+G6QI5DzmuT0vwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GCXEAOV5rwdjQMJnipnokCeB4tqJVHBhLRBH9/1EG8VIvCVCTPUE0OngcZuelBtzoWoMitWQQU93t9WJsYgEaT7gv/FAmpkuy2bE3TobMfxvl4ShOeDv+A0XwYDOPOxqPtxnauRjm/RlsZ+iaxaMXjWLrnSL5P1GLRkQ0vJ5RGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FfQkN8w8; arc=fail smtp.client-ip=40.107.92.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjhJIAytFsArFVHae/coZY4yDdN0aUtgzDBygadINxWGrhEphIIKbANWE7+N968bmr4lt2VFz3wlPzVMPSBtehmxM2GbyDT0EqIVWKisuiyCvjOf8Yqro8/REF+5kE9qHlB4sYCRuZ6RHCP/8glveG8uOFEzp69hrzAiYF85Rn2rRf/229uR6w56ZdDAYg5CMxSm0NRYqUKhUyCYulVekywHvUp6M0FoXIj2/96LndLZkGZabPN2TnclG7kneTxGZKgIP4w6XeOyagjjSovgaeOyOFdtYwz2zVMvKhCiEafbyzwfkXSqQt01Md/rqj7LlUnItgQ30adLyQtK+MBZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8xy+cElUI/sumFl8lrjg3num1YC82Q9/Au76HHatiY=;
 b=L3tRnJsyCbkny7wsm+Tri+WjQsLDsVzj7TlQYfugsDtuhllBc40Jxl6fHSZWVz11OmyqE6/x522Er+eUTynQcoSICpvVsK9VqUt+pOa31Wev3gFH0Lw6lmCPcOpbO8xWaWweCZZQzSyWFfOZIm67465zpIth9eTIM+0c2y9QF6w8Y4M3Adt8Veis4c2iAHBzkOuH2Y2ceUd3teCsAS2ESq/XTPtMUC4GLzpfoF+Obo1X6DN+KbaidrWEOLXePPKubLEiP7NV7bArTb1vQNEM8lChe2owgiKLDaDklzdS/pSh6yVUuOdIF15/ENfVtRIDtB7o0Y/Gmul3UKNMwFhMbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8xy+cElUI/sumFl8lrjg3num1YC82Q9/Au76HHatiY=;
 b=FfQkN8w8/ScRg1bIT3N1ZwalovNaVHTA+J7LRYBGx+suxgt5y7wqiwKelZZ1Xrv5JzzN8SB/VnpDLyBQOmc7Hrj/sLN8wEWtVcC8Fu9vhA+78KQtIFkAQeJw7aP0CAQNvgOSjapus7qWpoT3CTtDnQFSxuJdRuOWWtsmG3/TVQ8=
Received: from MN2PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:c0::14)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 05:53:56 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::87) by MN2PR05CA0001.outlook.office365.com
 (2603:10b6:208:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Tue, 26 Mar 2024 05:53:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 05:53:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 26 Mar
 2024 00:53:54 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 26 Mar 2024 00:53:51 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.simek@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>,
	<suraj.gupta2@amd.com>
Subject: [PATCH net-next RESEND] net: axienet: Fix kernel doc warnings
Date: Tue, 26 Mar 2024 11:23:47 +0530
Message-ID: <20240326055347.8919-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: dfc230bf-beb0-431c-0c63-08dc4d591f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oQCMIcWu1ganWBm15H3RjHefQposBMHNb1yx/fwV0s7AVdXYLnqwEiExcxWAGlEQLXNpvBi0m5kYv637kGLiE5FWg83shAKhMPWcRGIAcPtDA6kSR6V/Z66Qwcgmb7UY/ZGSXNVgTCgzgQUsuZVFWY0aEy4MBc9Nf3rlwBqV105Lj+DF6KY/q0Ly8YzAq8OIIiWM/5Z8AgjbQPtvkzKq4YYiCckgn9UXKf6oX84Et/WJFbfrrSR2ajv3VJ4vM9c0bk5ZzqrLJYIhmxt5jTTsWo6HdJlY+xuUr+/WuWlTnoEm8nz0aeXy7G7Ffh0CHF0j6vVbGjXiTBeXSTfNt2Dt+n2cKcjMz43673RdOOjCU6m6nkBkrnOnlcIV2FNnD1jyLRgcTTGgFZ3fwpMw7rn/n+WtlQLITw1jiIQ4sFdbRe4dLKwHzPXG+ESxkqQTldKPLQzdRVypmbbj/ky3WgJ8OTOcuoFWe0MWSlC0/81S4MwmXDVbDNMsb0ufnqjQ22fp20j7WLg6QbYXqjXOTjQJSKPc8lObVXunn3ySzJuISbpuHAkXr7hqWe9hwtGFLm+L3qmPeTaHbsRf6dfh4NulqhRWlFn3VXsmR3JAjdKXRlvqRsMRAPlEJYCBzySdzVs5e+FWay/A7uDBpZRCBYusdAf3rn5D0amEC+9dQa2jTx1E8P9VF0mPBn9ecG6/ip8FzMLNZ31RLwg/cdm8n9yXHszT7FBnglds10MowSbzDLpkLmPK2+cFB268oupSRdSS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 05:53:55.4753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc230bf-beb0-431c-0c63-08dc4d591f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495

Add description of mdio enable, mdio disable and mdio wait functions.
Add description of skb pointer in axidma_bd data structure.
Remove 'phy_node' description in axienet local data structure since
it is not a valid struct member.
Correct description of struct axienet_option.

Fix below kernel-doc warnings in drivers/net/ethernet/xilinx/:
1) xilinx_axienet_mdio.c:1: warning: no structured comments found
2) xilinx_axienet.h:379: warning: Function parameter or struct member
'skb' not described in 'axidma_bd'
3) xilinx_axienet.h:538: warning: Excess struct member 'phy_node'
description in 'axienet_local'
4) xilinx_axienet.h:1002: warning: expecting prototype for struct
axiethernet_option. Prototype was for struct axienet_option instead

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

---
Note: Earlier version didn't reached to mainline due to my email
configuration issues. So again sending out with resend tag.


 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 ++--
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 23 ++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 807ead678551..d0d1ae3b4e2c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -359,6 +359,7 @@
  * @app2:         MM2S/S2MM User Application Field 2.
  * @app3:         MM2S/S2MM User Application Field 3.
  * @app4:         MM2S/S2MM User Application Field 4.
+ * @skb:	  Pointer to SKB transferred using DMA
  */
 struct axidma_bd {
 	u32 next;	/* Physical address of next buffer descriptor */
@@ -399,7 +400,6 @@ struct skbuf_dma_descriptor {
  * struct axienet_local - axienet private per device data
  * @ndev:	Pointer for net_device to which it will be attached.
  * @dev:	Pointer to device structure
- * @phy_node:	Pointer to device node structure
  * @phylink:	Pointer to phylink instance
  * @phylink_config: phylink configuration settings
  * @pcs_phy:	Reference to PCS/PMA PHY if used
@@ -537,7 +537,7 @@ struct axienet_local {
 };
 
 /**
- * struct axiethernet_option - Used to set axi ethernet hardware options
+ * struct axienet_option - Used to set axi ethernet hardware options
  * @opt:	Option to be set.
  * @reg:	Register offset to be written for setting the option
  * @m_or:	Mask to be ORed for setting the option in the register
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 2f07fde361aa..9ca2643c921e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -20,7 +20,14 @@
 #define DEFAULT_MDIO_FREQ	2500000 /* 2.5 MHz */
 #define DEFAULT_HOST_CLOCK	150000000 /* 150 MHz */
 
-/* Wait till MDIO interface is ready to accept a new transaction.*/
+/**
+ * axienet_mdio_wait_until_ready - MDIO wait function
+ * @lp:	Pointer to axienet local data structure.
+ *
+ * Return :	0 on success, Negative value on errors
+ *
+ * Wait till MDIO interface is ready to accept a new transaction.
+ */
 static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
 	u32 val;
@@ -30,14 +37,24 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 				  1, 20000);
 }
 
-/* Enable the MDIO MDC. Called prior to a read/write operation */
+/**
+ * axienet_mdio_mdc_enable - MDIO MDC enable function
+ * @lp:	Pointer to axienet local data structure.
+ *
+ * Enable the MDIO MDC. Called prior to a read/write operation
+ */
 static void axienet_mdio_mdc_enable(struct axienet_local *lp)
 {
 	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
 		    ((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK));
 }
 
-/* Disable the MDIO MDC. Called after a read/write operation*/
+/**
+ * axienet_mdio_mdc_disable - MDIO MDC disable function
+ * @lp:	Pointer to axienet local data structure.
+ *
+ * Disable the MDIO MDC. Called after a read/write operation
+ */
 static void axienet_mdio_mdc_disable(struct axienet_local *lp)
 {
 	u32 mc_reg;
-- 
2.43.0


