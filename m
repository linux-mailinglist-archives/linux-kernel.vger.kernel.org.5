Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C9B7C45B1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbjJJXtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJJXtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:49:23 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011118F;
        Tue, 10 Oct 2023 16:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXleR+1e3K+Trb5AemyPXmM97mPOOGowjz91KT5w6gzqSp81zvxVW8/PJzAyrHj5XMUbVK2PF7I1OhtzVFXz2PJMfNUl5XBQOCYGjAsrwk6FVZ3nDbCaPSJJyNnd3Uf4nfBI7gqv5OCW3+0rWVA0E3yib+2qm0y4n+PInPizaTG/AqQHBVjGCO9EZQjkWvUguD0J2NZ3VCei9OZb/n8EQRbz7DzAOwsK3VLDhPZr1riYZGnqJBikroYL8MgJoBtFiGs4EAsEutuGIZZOf+o2s+BYMScFSCJFnafA7OGEGynD4vbsUOhTaHxbZyE/6QUfeUDzEUiUqfeuB1ygPOv7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2BFvHpNO/SQKof+fxLeTV2u27U9USXwLnEJGRKDhFk=;
 b=A+92ovaTC47eS2X1cTltSFk8lmm76+yJrzQFk863WYU5eu6I8ZKcLhQ5NIrS0W8OS9SVVdAGXMsGO7YGf2MpMzK3CS9ptkNOmO9k0Qg4FQlnF3+/AdNHn51Q8UPenO4KBkRflCm9NptnCscJDPK2Q0MDS1tNFt4C/CmqGIhTV4hKgTlETnpukhDO9iQDFSxlYu9NkMbJU2JEymTYiXOk2ZtOqtGGvfXzfNzHBVu7SHSJ7zbNQmzSFwixYRzEegMv1SlQtn1AnN/x1bcTE227Uc+pL5pZwGaH+caXoV1nyVS/2kx3qlEsXANzq3NZEvBoDOBMq8WR9+JEKr+ArOLT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2BFvHpNO/SQKof+fxLeTV2u27U9USXwLnEJGRKDhFk=;
 b=UMFktYxHWBRn8OAj1M31Xax9TAYTRk/WQ+ig4K9ZSVWEHvhu2Nd72jDvPpJ09sYXd37QCvee7Z8RBcrA4w6SOfIVzQ4fiH2MNHOls3WDahajuYHWkn4BZtLfU5JGCY5Czh/lPaNimIUZ0w9NhkTIWiIVxZ1twsfLnQAAhJgaQ6wumq0OBsAQibxX5Km3O81bzknlShlWzd2KtuZKdS6LVMDprBENMKjBG9uIpOysAoZL/EMXmw9oMT5U6aGnt7xxBmLO5c8bPacHEtuAKkM7klkJUUlgz1KEb1H07JuSohhKNpK342Sy1JnoQ0CJKmp9/HLN1D6A1OxpW98Ze82y4A==
Received: from DS7PR05CA0072.namprd05.prod.outlook.com (2603:10b6:8:57::7) by
 CH0PR12MB5185.namprd12.prod.outlook.com (2603:10b6:610:b8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 23:49:18 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::e9) by DS7PR05CA0072.outlook.office365.com
 (2603:10b6:8:57::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Tue, 10 Oct 2023 23:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 23:49:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 16:49:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 16:49:10 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 16:49:09 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <james.clark@arm.com>, <mike.leach@linaro.org>,
        <suzuki.poulose@arm.com>, <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
        <ywan@nvidia.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH v3] perf cs-etm: Fix incorrect or missing decoder for raw trace
Date:   Tue, 10 Oct 2023 18:48:03 -0500
Message-ID: <20231010234803.5419-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CH0PR12MB5185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de48946-eb65-49d0-8b34-08dbc9eb848e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nELkaZpZ+vYNSkCB4WMFBvSCe1yJkEPod4lj6R05As9ZAh8lUyISbsfbd20qfKbzYUwxkeBxAPFGNVmEU/ZxPwnY8j4VUmn9rHThq42Bzgd4Yl4bxmOldt8TfCr8/6MlSjBsXEjL4CHLZqU+sQj5G4AhWakSb/U/39CIt4RMHvZjyurlEta4OT00+oVNzthl4oMA7606knade+g+tspo5NHcrf7MRSl+ifOWkP6jP4GgfmvZgRwl9yAkqekHmBOveemfYDmrSpDw966DjKIF4NRHhhKWNc0Y+iZpNa3OjMUt7GMiNMnenol6WuF3kR2mW5gbTDOoF+wxCoPySzXRQmcxNtD7ieS31OrBHOF69dO5iLoFQ2nFU4S15L3Mf9G4yVcnFe0C7Qh0zhbC4Dsn8a8+QirEiyOyLjxkgAVKJGaQVzoaecSG4tjJlWMIUTJml4TWth6JEebqnklmC3grHTE0PwLtP57BFb44Xl+uhPTClfzu77c/LrFV/g3nZzBORWJWAVhuJSTG402UhjIG83gYjEDaUxGPmyx5uFpYjbNuwGO4m8ocqzpVPY6qlta0kFfpIDeOmNMAhRsXl77Dy1UCsOUfDqcP140zK1pduWxoPmPRQ6qIvVF19wIeuBsL1bNBe6rQ97KeeJmigiyZ/zvz6rEdVguKMVSha9pQsut/zzWYhAwLD1m6yZpQ/6D+Gk5sdedD4l5j2QuDmIhRXzBNtQhMRG8BznL4Ngy3bsk/GNiH4tb0MI/rSOVHVwwqDht/tS9qeWnpNGbuvdxWlelaKuqFeHqL4vLngYZlLH7LyM4Eh/jSqYsfEdbbIwHk
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(107886003)(1076003)(7696005)(966005)(6666004)(2616005)(26005)(47076005)(2906002)(336012)(426003)(83380400001)(8936002)(5660300002)(70586007)(70206006)(110136005)(316002)(54906003)(8676002)(41300700001)(4326008)(356005)(82740400003)(36860700001)(478600001)(7636003)(36756003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 23:49:18.0082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de48946-eb65-49d0-8b34-08dbc9eb848e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5185
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: James Clark <james.clark@arm.com>
---
Changes from v2:
 * Rebase to perf-tools-next tree
 * Add Reviewed-by from James
v2: https://lore.kernel.org/lkml/20231004003212.31554-1-bwicaksono@nvidia.com/T/#u

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
index 9729d006550d..a9873d14c632 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -283,22 +283,31 @@ static int cs_etm__metadata_set_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
 }
 
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
@@ -641,66 +650,80 @@ static void cs_etm__packet_dump(const char *pkt_string)
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
@@ -1016,7 +1039,7 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
 }
 
 static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
-						bool formatted)
+						bool formatted, int sample_cpu)
 {
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
@@ -1041,7 +1064,7 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	if (cs_etm__init_trace_params(t_params, etm, decoders))
+	if (cs_etm__init_trace_params(t_params, etm, formatted, sample_cpu, decoders))
 		goto out_free;
 
 	/* Set decoder parameters to decode trace packets */
@@ -1081,14 +1104,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
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
@@ -2816,7 +2840,7 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
 		 * formatted in piped mode (true).
 		 */
 		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					  idx, true);
+					  idx, true, -1);
 		if (err)
 			return err;
 
@@ -3022,7 +3046,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
 		idx = auxtrace_event->idx;
 		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
 		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
-					   idx, formatted);
+					   idx, formatted, sample->cpu);
 	}
 
 	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
-- 
2.17.1

