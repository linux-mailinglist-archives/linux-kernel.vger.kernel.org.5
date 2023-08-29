Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0259B78CB7D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjH2RpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbjH2Rol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:44:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A8A103;
        Tue, 29 Aug 2023 10:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luvT+sUmTMbZDE+tLnZofDfLvBvS8EEWAB4rwH61RxXDNCh7QjdifUwEBY5zt/0HgHRJt7rkduh21LMsI/kfMhOmEpoYRUaQfwGO450MH2BDsgRJ1p6kqP6xjaoe8fAq+BT3fmTUrEiK0ODlcM0t+dhRTabiUkGmb7d5lmFXiYiVNBl6d1Kx2F9I/TS4BW33LZMHCduO2NZbnRP+Ob1DtY9v7H1fXXqxwguzYcQbCukJOCU8fM3FmimIyMBhzdDvc/kl3yYNKnTDw+oiOu/NiX24eK+EMrQb89NL2U4v2TndTZCm5E7elfH/k61hnxyEWIhF4/YAhuI3smA4QvKaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5F3TqRKthPItUGQfpO2ly4j1liLdluzb2zylll912M=;
 b=ZeXgWZ+b7kYGNdmgc4lbOi56CKDnwHvuvxF77nZiqR3SuGkxaVR06ZLqZqUk1Mz3Cpaaqkpecy3tU3+DSfRXbeC4Dc1uyaow3u9P/TKvwIzGGmg0GePEIBlCe6CuHOb1YbskP8hDwJV/NerGgEdx3wnAZgCjwFFgm0hovCerLwP6Dcpa1I0Gqz1isb6pql9y2HpjllXtS9tlowTqHjlEsAS6k3d5RSZXx2xZ/dmPL+CUVkOyKDq4n4s++5n8SBN4qzO/KOvQhmCWksoAL3T/d+HMiq33I7CANKaK3gWgdQYCf+A3aDbBTO8hEnRKy90ZnFTuMUSsDDUTvY/RzhhiCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5F3TqRKthPItUGQfpO2ly4j1liLdluzb2zylll912M=;
 b=UG3eDVOTbqxEP1rUzyQnTaVWF5wKykU6PhtyP/PosTEVL1xIxEDRA2T4xYOrhI34vKt85s/LkP13HFCerueNHx8r4CKIEM8Lrm1831XFypO7p/ojt0+XIFFcWu1Dnow2evRloqfYUCX+P9IWwxWvGdg/+1notBlwd9KQWbf19VHb87924lhmJOx+snrdw6uRJRdpQFdrPJm15rWG5nA0oMcedgwZ8p8RmXLrJjmpDV32h5mRmpETvDFSTyN4G9PRd4cyGYDIOi3rpKD27Qx9IiyStpreSX/WpuFMr5+8dWUyfXGEiseoZFMv1hf5iiJPnJ0S/g2PIwBVS68l25KR1w==
Received: from MW4P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::23)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 17:44:37 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::f0) by MW4P221CA0018.outlook.office365.com
 (2603:10b6:303:8b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36 via Frontend
 Transport; Tue, 29 Aug 2023 17:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.2 via Frontend Transport; Tue, 29 Aug 2023 17:44:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 29 Aug 2023
 10:44:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 29 Aug 2023 10:44:26 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 29 Aug 2023 10:44:25 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
CC:     Liming Sun <limings@nvidia.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] mlxbf-tmfifo: Drop jumbo frames
Date:   Tue, 29 Aug 2023 13:43:00 -0400
Message-ID: <9318936c2447f76db475c985ca6d91f057efcd41.1693322547.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1693322547.git.limings@nvidia.com>
References: <cover.1693322547.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1c7a10-e771-46a1-9cf1-08dba8b79d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nsMOfaEF+OZBlMHRH3jQoLLyJK3pHQjHL70KQIDxHjjUK4EHS8swXEyFFlIJnn8WDqIs+WcaJ4LIXEO0mqM+lKPoIPkgrYARASdwbbFXEjDBDBPMb1OFUjeibvOEai5OPmpsz+cKK8/D4vMlWgvgn2t8dxhIjhgZqySjrG/P/EPm1NNCz22FX2Wt2JT/Vvm249rTnzmWoHihzQZyUqxBPI0/aqZ1EQB8FnUpm+L6vppb8mXXUWNR3BMvhzyotGWWZDyJjYnGgf1T3LjYTFVLMqoYlYOxIOAsADUQvdRILIyYMaGp3YSDF66tWKxSnK6nuchC731XmKT1WPmVPc6pBhSmi0AIgGESE+WjCffy4Mu2PgPnTyrsOQ4WSt9F0GiHKmtWYMx7ivPAzMpApDagKYR+1Rd642dogOgSOx6J615a+EAO7qKWzM/93X1zCLRoa+fcfVWjJZ+G2c5CIP99QVK+D1EAPm/+s3x0zW1M8LpWDzcKNao+tfhCBKp6vgjZdiPko2ej9nBnlHZA7fSodEVxRMAUUu3Zj5MC83Y7/Ii0zEx0tLreqzyxxcn/uX69tOGb48eu3lnjVGC5kB0FrK1u3+CVya6ZacKVjAImrgAX7M/tsQkj3eHs0GpGbpTUY6M+etWFHGgFcoj4sOmpAfKRfurEAvRvC3mRdZsUgYc4o75HmCe/PcKqQJjyMEgtULc4hfChOLASCHQOdJHSynVL6fUY70sDwfEGzW1hc6NlNF67mB3QqjY5CmgLC2z
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(2616005)(86362001)(110136005)(6666004)(478600001)(83380400001)(47076005)(426003)(336012)(36860700001)(7636003)(26005)(82740400003)(356005)(40460700003)(36756003)(4326008)(8936002)(8676002)(5660300002)(316002)(70206006)(54906003)(70586007)(41300700001)(40480700001)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 17:44:36.8729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1c7a10-e771-46a1-9cf1-08dba8b79d01
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit drops over-sized network packets to avoid tmfifo
queue stuck.

Fixes: 1357dfd7261f ("platform/mellanox: Add TmFifo driver for Mellanox BlueField Soc ")
Signed-off-by: Liming Sun <limings@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5c1f859b682a..f3696a54a2bd 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -224,7 +224,7 @@ static u8 mlxbf_tmfifo_net_default_mac[ETH_ALEN] = {
 static efi_char16_t mlxbf_tmfifo_efi_name[] = L"RshimMacAddr";
 
 /* Maximum L2 header length. */
-#define MLXBF_TMFIFO_NET_L2_OVERHEAD	36
+#define MLXBF_TMFIFO_NET_L2_OVERHEAD	(ETH_HLEN + VLAN_HLEN)
 
 /* Supported virtio-net features. */
 #define MLXBF_TMFIFO_NET_FEATURES \
@@ -642,13 +642,14 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
  * flag is set.
  */
 static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
-				     struct vring_desc *desc,
+				     struct vring_desc **desc,
 				     bool is_rx, bool *vring_change)
 {
 	struct mlxbf_tmfifo *fifo = vring->fifo;
 	struct virtio_net_config *config;
 	struct mlxbf_tmfifo_msg_hdr hdr;
 	int vdev_id, hdr_len;
+	bool drop_rx = false;
 
 	/* Read/Write packet header. */
 	if (is_rx) {
@@ -668,8 +669,8 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 			if (ntohs(hdr.len) >
 			    __virtio16_to_cpu(virtio_legacy_is_little_endian(),
 					      config->mtu) +
-			    MLXBF_TMFIFO_NET_L2_OVERHEAD)
-				return;
+					      MLXBF_TMFIFO_NET_L2_OVERHEAD)
+				drop_rx = true;
 		} else {
 			vdev_id = VIRTIO_ID_CONSOLE;
 			hdr_len = 0;
@@ -684,16 +685,25 @@ static void mlxbf_tmfifo_rxtx_header(struct mlxbf_tmfifo_vring *vring,
 
 			if (!tm_dev2)
 				return;
-			vring->desc = desc;
+			vring->desc = *desc;
 			vring = &tm_dev2->vrings[MLXBF_TMFIFO_VRING_RX];
 			*vring_change = true;
 		}
+
+		if (drop_rx && !IS_VRING_DROP(vring)) {
+			if (vring->desc_head)
+				mlxbf_tmfifo_release_pkt(vring);
+			*desc = &vring->drop_desc;
+			vring->desc_head = *desc;
+			vring->desc = *desc;
+		}
+
 		vring->pkt_len = ntohs(hdr.len) + hdr_len;
 	} else {
 		/* Network virtio has an extra header. */
 		hdr_len = (vring->vdev_id == VIRTIO_ID_NET) ?
 			   sizeof(struct virtio_net_hdr) : 0;
-		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vring, desc);
+		vring->pkt_len = mlxbf_tmfifo_get_pkt_len(vring, *desc);
 		hdr.type = (vring->vdev_id == VIRTIO_ID_NET) ?
 			    VIRTIO_ID_NET : VIRTIO_ID_CONSOLE;
 		hdr.len = htons(vring->pkt_len - hdr_len);
@@ -742,7 +752,7 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
 
 	/* Beginning of a packet. Start to Rx/Tx packet header. */
 	if (vring->pkt_len == 0) {
-		mlxbf_tmfifo_rxtx_header(vring, desc, is_rx, &vring_change);
+		mlxbf_tmfifo_rxtx_header(vring, &desc, is_rx, &vring_change);
 		(*avail)--;
 
 		/* Return if new packet is for another ring. */
-- 
2.30.1

