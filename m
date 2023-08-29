Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6078CB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbjH2RpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238140AbjH2Ros (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:44:48 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EBF19F;
        Tue, 29 Aug 2023 10:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EohqE+gkFzItXm3riAtjO01ZrAQvLTLLiqiVDaESz1pTIaDe+0PSFLRPP4UR4lH29431QU3C33Ghh6Tc6f6TKEUXeCyj9nEC6dXc/ATgUHbVfzp+hcvV8MEiU+Sn2T/xRZAoL50uWw/EA/+eoB2j2cHK9lTHOW/+8GEGF/p+gh6eRVoIY+hzXj9BABO+euQfdpZaKE1wzrfQHbQw21PLwEaWj7hBLlJVrxebzH2yApqj1rBB3HFX95AXEuJjPqg+9HpQKuSSw+PpY1fUrGeXRLogYeVKD4TgRdC0T6tbz16ltcP1PbOXuxoBV899Q9Y7SeFj61IocPB2n60Dq7/sAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiA8x5vTlBv7QNsd0iCrrpyIeg5V+3DHQvtJYNWPHwQ=;
 b=Htln7U78j20BtZLn4Kp/hEKwqJ3OdMms/lYQ04LihpQPmhObn7mAcdeoEn0seBdaD9JXy2Ds3d7yViR7UoOGNePH3vNrphZ1Ymr4MPHJy8+q9pyw2uU8JCLC/C3C1RLAmU8qSZz/+HAFE5XKLkWVg4zT94BZxIw0c28shEZ6Zfc8kkMlimVHHTCkDX4ifHgdbtTuSgrQTLdg/Zma+o5zYjZqLZ7RUvm0N1DtTJ62a6qvgJN2O3JcMmKy23UJpHOOMSLMM/obkGlN5uqCz+i+oDozwK+A/FynQhJKd9u2sUe+rWqAuggsdVSnMXSEnqbzXDjElBDJIUv86xPeUcn8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiA8x5vTlBv7QNsd0iCrrpyIeg5V+3DHQvtJYNWPHwQ=;
 b=YkpnnRub5hawoKilPHneIkSDBb7gzPcsV9w0hjI7aFJ32KRte/YEmpcF2ghMSXzBPGrnOdgE9MKHMNKtDPpGhq56MXblcBD1g3yGPQG0iHy5ocyHmAFxGTe6uUp9t+lkioN8QCNGloHG/51MMaV4C8ealHGntxnO/urSh6y0Ej3stBxcmlAjk1DugGeUMSvIXEuQGSUkCUzxz+Wxw43jadtQu+ucZUpVibq7BN8yo/zHWm7Vsh2KhZQ9oHn5L6OEZBTtNMHfn/1hUcIX7tT3khfyhQypOqnlp6QwHoOSrCP+mhB3riVH9gI8E4E+qkyPLzX/X6ocXOPckuPqUtVQnQ==
Received: from SN6PR16CA0064.namprd16.prod.outlook.com (2603:10b6:805:ca::41)
 by SJ0PR12MB5502.namprd12.prod.outlook.com (2603:10b6:a03:300::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Tue, 29 Aug
 2023 17:44:42 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:ca:cafe::e8) by SN6PR16CA0064.outlook.office365.com
 (2603:10b6:805:ca::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 17:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 17:44:41 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 10:44:23 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 29 Aug 2023 10:44:23 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 10:44:22 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/2] mlxbf-tmfifo: Drop the Rx packet if no more descriptors
Date:   Tue, 29 Aug 2023 13:42:59 -0400
Message-ID: <8c0177dc938ae03f52ff7e0b62dbeee74b7bec09.1693322547.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693322547.git.limings@nvidia.com>
References: <cover.1693322547.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|SJ0PR12MB5502:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f64220c-a253-4400-c220-08dba8b79fe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnVBv0c3l/JpZ8q3+6Ex6qRP7t/mXZ3GNBw67ZUUWAdGksQeurpIJcaQ7UUU5Y4IqdEUVB59C9k50yAX/5wTFmNYiXNFKfrQ/Dt+i3YNwsnzuHSVuTYiv0T7AoAnpEaoYyn0tE19mKJF0SDpg+xVuFiFGZK7Q4tlNRGuWUI21E+W59uzkQ5KkGRnk/byXxmyGntRsNwc7OBK9VTPEFmPCYbXXynUdb21j3Lud1K0BkNpV0onEzJE/MCQKLjWhciZ6BL79EJ+E2zNNiHPJWfwifYApNPRQGlS050RKFkMHfiXZBPtqhe5pD8b4YeDAbHU1COqjanrv4ykQYB2pJKjAIm+n01zCZfUU1fJiDNmP/b4IH/UO834qMnc/WNppgZcC/d5HWG6g6GpSu7ZsimFNsoiRj8xU6sIGslSvWlRItI8pLYZ0vRBEbBuYiDztWyleoDCT1RO7+EgvIAHdY59jbwXdZo32kloaBZCOb9eB+cyo88vp+hZybZPNtu8fDqmVEae2X9Amv2/CFjpa21sbO+bDlQD4scpDgshJ1sQhSMr4cnAh7O2fkYlYl6Qt9O702GVbch4w9c79XG5qtCnK6Vw4Z9IVua1+um+E2H9bVpP2m1oIJrF9FPuvoQNQxO01siydnIK/c6iSRY+ZiEZLRbeMBpNtshp9ONDX2BwkmD//cnjpWCes0cN2W5swIopzG7xBChNCneKtiNyABqZpOjCWB6GAf2kKH0eerzENmTumfbGHvKDLAFlbeDvElY8vqT3ucMsO1/L3iptjLN2xg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(6666004)(7696005)(478600001)(83380400001)(2616005)(336012)(426003)(26005)(2906002)(41300700001)(54906003)(316002)(70206006)(110136005)(70586007)(5660300002)(8936002)(8676002)(4326008)(36756003)(40460700003)(40480700001)(47076005)(36860700001)(86362001)(7636003)(356005)(82740400003)(29513003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:44:41.6570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f64220c-a253-4400-c220-08dba8b79fe2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5502
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes tmfifo console stuck issue when the virtual
networking interface is in down state. In such case, the network
Rx descriptors runs out and causes the Rx network packet staying
in the head of the tmfifo thus blocking the console packets. The
fix is to drop the Rx network packet when no more Rx descriptors.
Function name mlxbf_tmfifo_release_pending_pkt() is also renamed
to mlxbf_tmfifo_release_pkt() to be more approperiate.

Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc ")
Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 66 ++++++++++++++++++------
 1 file changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index b600b77d91ef..5c1f859b682a 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -59,6 +59,7 @@ struct mlxbf_tmfifo;
  * @vq: pointer to the virtio virtqueue
  * @desc: current descriptor of the pending packet
  * @desc_head: head descriptor of the pending packet
+ * @drop_desc: dummy desc for packet dropping
  * @cur_len: processed length of the current descriptor
  * @rem_len: remaining length of the pending packet
  * @pkt_len: total length of the pending packet
@@ -75,6 +76,7 @@ struct mlxbf_tmfifo_vring {
 	struct virtqueue *vq;
 	struct vring_desc *desc;
 	struct vring_desc *desc_head;
+	struct vring_desc drop_desc;
 	int cur_len;
 	int rem_len;
 	u32 pkt_len;
@@ -86,6 +88,14 @@ struct mlxbf_tmfifo_vring {
 	struct mlxbf_tmfifo *fifo;
 };
 
+/* Check whether vring is in drop mode. */
+#define IS_VRING_DROP(_r) ({ \
+	typeof(_r) (r) = (_r); \
+	(r->desc_head == &r->drop_desc ? true : false); })
+
+/* A stub length to drop maximum length packet. */
+#define VRING_DROP_DESC_MAX_LEN		GENMASK(15, 0)
+
 /* Interrupt types. */
 enum {
 	MLXBF_TM_RX_LWM_IRQ,
@@ -262,6 +272,7 @@ static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
 		vring->align = SMP_CACHE_BYTES;
 		vring->index = i;
 		vring->vdev_id = tm_vdev->vdev.id.device;
+		vring->drop_desc.len = VRING_DROP_DESC_MAX_LEN;
 		dev = &tm_vdev->vdev.dev;
 
 		size = vring_size(vring->num, vring->align);
@@ -367,7 +378,7 @@ static u32 mlxbf_tmfifo_get_pkt_len(struct mlxbf_tmfifo_vring *vring,
 	return len;
 }
 
-static void mlxbf_tmfifo_release_pending_pkt(struct mlxbf_tmfifo_vring *vring)
+static void mlxbf_tmfifo_release_pkt(struct mlxbf_tmfifo_vring *vring)
 {
 	struct vring_desc *desc_head;
 	u32 len = 0;
@@ -596,19 +607,25 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
 
 	if (vring->cur_len + sizeof(u64) <= len) {
 		/* The whole word. */
-		if (is_rx)
-			memcpy(addr + vring->cur_len, &data, sizeof(u64));
-		else
-			memcpy(&data, addr + vring->cur_len, sizeof(u64));
+		if (!IS_VRING_DROP(vring)) {
+			if (is_rx)
+				memcpy(addr + vring->cur_len, &data,
+				       sizeof(u64));
+			else
+				memcpy(&data, addr + vring->cur_len,
+				       sizeof(u64));
+		}
 		vring->cur_len += sizeof(u64);
 	} else {
 		/* Leftover bytes. */
-		if (is_rx)
-			memcpy(addr + vring->cur_len, &data,
-			       len - vring->cur_len);
-		else
-			memcpy(&data, addr + vring->cur_len,
-			       len - vring->cur_len);
+		if (!IS_VRING_DROP(vring)) {
+			if (is_rx)
+				memcpy(addr + vring->cur_len, &data,
+				       len - vring->cur_len);
+			else
+				memcpy(&data, addr + vring->cur_len,
+				       len - vring->cur_len);
+		}
 		vring->cur_len = len;
 	}
 
@@ -709,8 +726,16 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 	/* Get the descriptor of the next packet. */
 	if (!vring->desc) {
 		desc = mlxbf_tmfifo_get_next_pkt(vring, is_rx);
-		if (!desc)
-			return false;
+		if (!desc) {
+			/* Drop next Rx packet to avoid stuck. */
+			if (is_rx) {
+				desc = &vring->drop_desc;
+				vring->desc_head = desc;
+				vring->desc = desc;
+			} else {
+				return false;
+			}
+		}
 	} else {
 		desc = vring->desc;
 	}
@@ -743,17 +768,24 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 		vring->rem_len -= len;
 
 		/* Get the next desc on the chain. */
-		if (vring->rem_len > 0 &&
+		if (!IS_VRING_DROP(vring) && vring->rem_len > 0 &&
 		    (virtio16_to_cpu(vdev, desc->flags) & VRING_DESC_F_NEXT)) {
 			idx = virtio16_to_cpu(vdev, desc->next);
 			desc = &vr->desc[idx];
 			goto mlxbf_tmfifo_desc_done;
 		}
 
-		/* Done and release the pending packet. */
-		mlxbf_tmfifo_release_pending_pkt(vring);
+		/* Done and release the packet. */
 		desc = NULL;
 		fifo->vring[is_rx] = NULL;
+		if (!IS_VRING_DROP(vring)) {
+			mlxbf_tmfifo_release_pkt(vring);
+		} else {
+			vring->pkt_len = 0;
+			vring->desc_head = NULL;
+			vring->desc = NULL;
+			return false;
+		}
 
 		/*
 		 * Make sure the load/store are in order before
@@ -933,7 +965,7 @@ static void mlxbf_tmfifo_virtio_del_vqs(struct virtio_device *vdev)
 
 		/* Release the pending packet. */
 		if (vring->desc)
-			mlxbf_tmfifo_release_pending_pkt(vring);
+			mlxbf_tmfifo_release_pkt(vring);
 		vq = vring->vq;
 		if (vq) {
 			vring->vq = NULL;
-- 
2.30.1

