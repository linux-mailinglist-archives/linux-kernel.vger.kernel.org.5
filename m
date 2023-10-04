Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9977B75E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbjJDAcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:32:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C249B;
        Tue,  3 Oct 2023 17:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEp2SEMlpnKfPtoqd3E4D9AidXgKqEMF+DM4ml07qpikb489j8RgK2sZZ8La9f5vh0LUmKUYy6HrPjMVujqRZ8NIMTolbMeg0SiYNgpLdYANk82hzy0QdvtKHsnCLBM+oBSSN+NoFrq8w71nNxYA0+ITIwlniYFMTXs1d6RLqfspz2HXLppfkY9T5Me4yCdo9tkdGdbjwoLPXWMKWu2+FV/fHwaAn0Qm+vnTjKw5kWSe5X8YYH/vsxNjGOeUq9928GyLzhsTTsmTPPMTvBdvVM2BpZ+qW1hlFTQKvwmYQAPySOvQhbKL5d8SuMsumUDa/CocyjAMKF5ZPOBa6S3Yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joTq1NIMLOzcdOcR0eyhwmr+ZZgQ5STAJvJqG/qlEGU=;
 b=N8Yra9NdXRKxauMIhrtXOZOWqEkId6j/QGU7vCVHWsHujuAM2ldelJzB8fYyzT7wVjHrzl8bhmgDoh9K8APFzLcicWhJRg69uRv+d44zEVC2kCQ5uxr2vms/HI/7LYS6CHI+oZyROfbeJjZacgqWY9rtPyHS8BLZLrdoA/sWByWhTuHRX+vigWO2Ww0zX3phwnq3+RU+b7JeMzTP5Sl0j3j7n+iI4uuGpFAfpX5ilcVe7buKBNg9FKiNpe7gzoyqo9iAqEW2fDmEN4Xte4c7muGGxzy3zfSVW1Be2IbXV6HSdyKoojn9myLiqMyejS2lmYyA4xQ43QN2NClpWAmbLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joTq1NIMLOzcdOcR0eyhwmr+ZZgQ5STAJvJqG/qlEGU=;
 b=ivY0qijrh11etiTHgzgWFO/1O6pCr/isQEu7Kr9ne61gn6ZY0Oj77309gIABP6YCDy6FGaLCnCYIT3Wv+aAphIU0P7KsdsdI6FOtr7kx6Yajie45WdpSTjVDqybta2t4Y3XfeW2pY3sNqsor2lgYExAOek0HT6OfRTBvJ2EoGS/gpK03nECDS+IUa+p3NwE5lObr4Cd9HIE338GVqGAPx85bTNFXRylZFyxYZEvdpL0kT7ZmLMfmTR7oCiAH3aKaPP/LZk0kjUqruuRzaaolaa46DqG0cDKSnyq80sfhLGWFSmW1OIVOZRMA/YtY12vGneDBDD0lLaH9b//8XcjotA==
Received: from SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 00:32:31 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::25) by SN7PR04CA0215.outlook.office365.com
 (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 00:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:32:30 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 17:32:17 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 3 Oct 2023
 17:32:16 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 3 Oct 2023 17:32:15 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <james.clark@arm.com>, <mike.leach@linaro.org>,
        <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
        <ywan@nvidia.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v2] perf cs-etm: Fix incorrect or missing decoder for raw trace
Date:   Tue, 3 Oct 2023 19:32:12 -0500
Message-ID: <20231004003212.31554-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 94074bcc-29e5-4ad2-070e-08dbc4716507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qHrhJ/2l0mZjEdbACEipFKp2gMBAQYyEMIMbBCV2GRem9r9ZmuNTjG73aT/984mk82Gi/ZMmY/Skc8coPOddzZGVlfn/qOjWV9aGW3+t1CbL2jhRKxV+99YKOXhyT1cb8pxyX7/jYXDMQA3ZXxRyZGXaDJf9cqHvf3rxbjohr/nnB8iEA6rsTaxXphk1GQsUfZfXH+iZia2uYxrsCTSjy1zoW4gehxzAVo1L+4gJLdq14bFUK8Xtp288w4x5qbhscE6QtU56Tkmxx98CFko1Nhvdoz6aQxrQ+A5m6Rx9RD0RSwIz2IaxkhkznDQn+zfIisQgyxnbGJEaz9beDhCIF801l9wQMLjl82zYORchL1fZNJhV3a7QUeyUyT0g+thbTrlk2GX5MKpplB/a5x/fKe1NcKRmO/VfGsD9SawDEm2TPigJr2bw/FpqZZhvH92cL8QaSUFrdI2j9xgF62V3OlIyBSOYPlTdUvV3cl3uwy+pS0ZsWLoIhQ0ygbuWxS7GTGUfbhAE6yP42IYIRN/sI8adSEYMZ7osXHUq0h5faoHxMKbR5pqDM642Fl5IJE5O6V140ngTX1Y4/ZR96tJ9jxdOOD4m2jIweIxDySI9KnQjJGhGI+H6216ON7EtL7QczN1Fwn4og9ZmYmE/Lh82qu1uGuJFv8oR8q1zkwWi6r/aUaMjlzu7tjVO+3NhA0qQnyyAy3DoQCci1GXd5pqCH3Ll7OPOxJVhFVopSfYXcq12dY8PPeSn6TFNN65V5zGJptlTTVoTz6gMU1D8lJn301/XHc3dmxCJJjqlkoYjlZk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(46966006)(36840700001)(83380400001)(1076003)(26005)(336012)(4326008)(356005)(2616005)(426003)(5660300002)(8936002)(8676002)(82740400003)(7636003)(7696005)(36860700001)(47076005)(107886003)(478600001)(41300700001)(966005)(70206006)(70586007)(6666004)(40480700001)(316002)(110136005)(54906003)(2906002)(40460700003)(86362001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:32:30.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94074bcc-29e5-4ad2-070e-08dbc4716507
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder creation for raw trace uses metadata from the first CPU.
On per-cpu mode, this metadata is incorrectly used for every decoder.
On per-process/per-thread traces, the first CPU is CPU0. If CPU0 trace
is not enabled, its metadata will be marked unused and the decoder is
not created. Perf report dump skips the decoding part because the
decoder is missing.

To fix this, use metadata of the CPU associated with sample object.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

Changes from v1:
 * Update commit message
 * Add fallback to CPU-0 metadata if sample CPU id is not available
 * Preserve cs_etm__set_trace_param_* arguments and just breakdown the index
   parameter into trace-param and metadata indexes
Thanks to Mike and James for the feedback.
v1: https://lore.kernel.org/lkml/20230919224553.1658-1-bwicaksono@nvidia.com/T/#u

---
 tools/perf/util/cs-etm.c | 106 ++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1419b40dfbe8..3abe68a9981e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -293,22 +293,31 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 	})
 
 /*
- * Get a metadata for a specific cpu from an array.
+ * Get a metadata index for a specific cpu from an array.
  *
  */
-static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
+static int get_cpu_data_idx(struct cs_etm_auxtrace *etm, int cpu)
 {
 	int i;
-	u64 *metadata = NULL;
 
 	for (i = 0; i < etm->num_cpu; i++) {
 		if (etm->metadata[i][CS_ETM_CPU] == (u64)cpu) {
-			metadata = etm->metadata[i];
-			break;
+			return i;
 		}
 	}
 
-	return metadata;
+	return -1;
+}
+
+/*
+ * Get a metadata for a specific cpu from an array.
+ *
+ */
+static u64 *get_cpu_data(struct cs_etm_auxtrace *etm, int cpu)
+{
+	int idx = get_cpu_data_idx(etm, cpu);
+
+	return (idx != -1) ? etm->metadata[idx] : NULL;
 }
 
 /*
@@ -651,66 +660,80 @@ static void cs_etm__packet_dump(const char *pkt_string)
 }
 
 static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int idx,
-					  u32 etmidr)
+					  struct cs_etm_auxtrace *etm, int t_idx,
+					  int m_idx, u32 etmidr)
 {
 	u64 **metadata = etm->metadata;
 
-	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
-	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
-	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
+	t_params[t_idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params[t_idx].etmv3.reg_ctrl = metadata[m_idx][CS_ETM_ETMCR];
+	t_params[t_idx].etmv3.reg_trc_id = metadata[m_idx][CS_ETM_ETMTRACEIDR];
 }
 
 static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int idx)
+					  struct cs_etm_auxtrace *etm, int t_idx,
+					  int m_idx)
 {
 	u64 **metadata = etm->metadata;
 
-	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
-	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
-	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
-	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
-	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
-	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
-	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+	t_params[t_idx].protocol = CS_ETM_PROTO_ETMV4i;
+	t_params[t_idx].etmv4.reg_idr0 = metadata[m_idx][CS_ETMV4_TRCIDR0];
+	t_params[t_idx].etmv4.reg_idr1 = metadata[m_idx][CS_ETMV4_TRCIDR1];
+	t_params[t_idx].etmv4.reg_idr2 = metadata[m_idx][CS_ETMV4_TRCIDR2];
+	t_params[t_idx].etmv4.reg_idr8 = metadata[m_idx][CS_ETMV4_TRCIDR8];
+	t_params[t_idx].etmv4.reg_configr = metadata[m_idx][CS_ETMV4_TRCCONFIGR];
+	t_params[t_idx].etmv4.reg_traceidr = metadata[m_idx][CS_ETMV4_TRCTRACEIDR];
 }
 
 static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int idx)
+					  struct cs_etm_auxtrace *etm, int t_idx,
+					  int m_idx)
 {
 	u64 **metadata = etm->metadata;
 
-	t_params[idx].protocol = CS_ETM_PROTO_ETE;
-	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETE_TRCIDR0];
-	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETE_TRCIDR1];
-	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETE_TRCIDR2];
-	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETE_TRCIDR8];
-	t_params[idx].ete.reg_configr = metadata[idx][CS_ETE_TRCCONFIGR];
-	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETE_TRCTRACEIDR];
-	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
+	t_params[t_idx].protocol = CS_ETM_PROTO_ETE;
+	t_params[t_idx].ete.reg_idr0 = metadata[m_idx][CS_ETE_TRCIDR0];
+	t_params[t_idx].ete.reg_idr1 = metadata[m_idx][CS_ETE_TRCIDR1];
+	t_params[t_idx].ete.reg_idr2 = metadata[m_idx][CS_ETE_TRCIDR2];
+	t_params[t_idx].ete.reg_idr8 = metadata[m_idx][CS_ETE_TRCIDR8];
+	t_params[t_idx].ete.reg_configr = metadata[m_idx][CS_ETE_TRCCONFIGR];
+	t_params[t_idx].ete.reg_traceidr = metadata[m_idx][CS_ETE_TRCTRACEIDR];
+	t_params[t_idx].ete.reg_devarch = metadata[m_idx][CS_ETE_TRCDEVARCH];
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 				     struct cs_etm_auxtrace *etm,
+				     bool formatted,
+				     int sample_cpu,
 				     int decoders)
 {
-	int i;
+	int t_idx, m_idx;
 	u32 etmidr;
 	u64 architecture;
 
-	for (i = 0; i < decoders; i++) {
-		architecture = etm->metadata[i][CS_ETM_MAGIC];
+	for (t_idx = 0; t_idx < decoders; t_idx++) {
+		if (formatted)
+			m_idx = t_idx;
+		else {
+			m_idx = get_cpu_data_idx(etm, sample_cpu);
+			if (m_idx == -1) {
+				pr_warning("CS_ETM: unknown CPU, falling back to first metadata\n");
+				m_idx = 0;
+			}
+		}
+
+		architecture = etm->metadata[m_idx][CS_ETM_MAGIC];
 
 		switch (architecture) {
 		case __perf_cs_etmv3_magic:
-			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
+			etmidr = etm->metadata[m_idx][CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params, etm, t_idx, m_idx, etmidr);
 			break;
 		case __perf_cs_etmv4_magic:
-			cs_etm__set_trace_param_etmv4(t_params, etm, i);
+			cs_etm__set_trace_param_etmv4(t_params, etm, t_idx, m_idx);
 			break;
 		case __perf_cs_ete_magic:
-			cs_etm__set_trace_param_ete(t_params, etm, i);
+			cs_etm__set_trace_param_ete(t_params, etm, t_idx, m_idx);
 			break;
 		default:
 			return -EINVAL;
@@ -1026,7 +1049,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 }
 
 static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						bool formatted)
+						bool formatted, int sample_cpu)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
@@ -1051,7 +1074,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etm, decoders))
+	if (cs_etm__init_trace_params(t_params, etm, formatted, sample_cpu, decoders))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
@@ -1091,14 +1114,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_queue *queue,
 			       unsigned int queue_nr,
-			       bool formatted)
+			       bool formatted,
+			       int sample_cpu)
 {
 	struct cs_etm_queue *etmq = queue->priv;
 
 	if (list_empty(&queue->head) || etmq)
 		return 0;
 
-	etmq = cs_etm__alloc_queue(etm, formatted);
+	etmq = cs_etm__alloc_queue(etm, formatted, sample_cpu);
 
 	if (!etmq)
 		return -ENOMEM;
@@ -2826,7 +2850,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		 * formatted in piped mode (true).
 		 */
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx, true);
+					  idx, true, -1);
 		if (err)
 			return err;
 
@@ -3032,7 +3056,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		idx = auxtrace_event->idx;
 		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
 		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					   idx, formatted);
+					   idx, formatted, sample->cpu);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
-- 
2.17.1

