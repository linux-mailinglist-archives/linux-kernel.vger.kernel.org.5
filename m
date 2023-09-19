Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8AD7A6ED3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 00:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjISWre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 18:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjISWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 18:47:31 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C9EBF;
        Tue, 19 Sep 2023 15:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Um/V/09nVGOLFF4oJTCDr89kjrWF9a3knxx3pU0ppSQt2e5TnpRSz4XRqvofFCo/Kki/ughprU6nvy9zKW2m5dWpyza5EowIQVk4gxJpZhxMRS7WMDLucB8B1ci0KmyNARwG/Ep5oiy3lMUiMuQPzvxCUJdjl9WL5LIZiOq2kFO1IhVKTgJY2EyNmTXnO0NVOWHzuxjd5Eu+Y2sQvryKDO0m6hOMCiV5kzdnMgEnL6puiIurAgnDGo0SKnqI54vQ0NocBpqFVrQyDQLhGYZv7f6jujOrM7G6ZyyviWv5rwKM6NjyJThTF2g2r6vFsRNcD3UNx4lvsvLMRENVPcxAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpW9TPyfQooHmaoPEEmYVGGjfw7sUoJs7bANEef4YXs=;
 b=ciQ+GSvhodAR+HgpyLquxDIp609IVBLFfHB3D1HKPLCc0ECUi3dWPElP8/iL86sj7iw8i7dyJifQJBin6DZdyufkfNP3buD7SUzDDziRsajI5og6StZkotoEDphT+cejMUZYJRI7tyuDyMlctnIPGp/RWOoAVMCvX1xcYo9Wgeb7J05NcWIcjmZJrZz2gmVk8Ec1xe4vE3n/yAD5+gS3ZZIygYD2m6tR+NmZL1MrOYozSt8kjF4kMglwFREAiHO0NetAawp3IHtnH4KzOfKJW2xzwQ5X8Ysop+L7wNZTi8Mw6PIBMf3u9SZlp5Ls/LkWiVVbwbqAeMIVwmpVtQjRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpW9TPyfQooHmaoPEEmYVGGjfw7sUoJs7bANEef4YXs=;
 b=li8cGAuf3ShxzzCblso0sG+7p8zqIkwkdb7weZm4dxVLtlCq4xdHAVm6Q9TQzfYdP9lRU2zqfGmsh0cyXpN/+4lAQmZg4tBUOHTCOsjGKSltfT7We5hUKf9ugX//QIRYfdE7hV9aKDHkVI8CJTFfcnyus4O0A57+HvZ6qHeaRXGxzc/svnDFhY356VKwpupZVUWpu7Q7kQHrKGEk4PSYwc5H9tEIHqU05sleNs2P0/wrdLes+lEb8DTL3W0ZFmdD4dKVaDQDfG2omntmc/0f4eF4tQEXMew3bks4lu/02o7L+ECq5Lp7kSxKYboE8G0trdQ0i20JFxGG8m3S8DpCdw==
Received: from MW4PR03CA0058.namprd03.prod.outlook.com (2603:10b6:303:8e::33)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 22:47:18 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8e:cafe::91) by MW4PR03CA0058.outlook.office365.com
 (2603:10b6:303:8e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Tue, 19 Sep 2023 22:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Tue, 19 Sep 2023 22:47:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 15:47:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Sep
 2023 15:47:05 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 19 Sep 2023 15:47:04 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <james.clark@arm.com>, <mike.leach@linaro.org>,
        <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>, <rwiley@nvidia.com>,
        <ywan@nvidia.com>, Besar Wicaksono <bwicaksono@nvidia.com>
Subject: [PATCH] perf cs-etm: Fix missing decoder for per-process trace
Date:   Tue, 19 Sep 2023 17:45:53 -0500
Message-ID: <20230919224553.1658-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: c75578e1-4b71-4fcd-6374-08dbb96260b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jjmvPppSMbDORE+Oe8Nd37XAsg6DU9lMVlt5Nhu7xRLORyWoer0PJaaVA7pVLJSeij8rSN46wy94ISvsob0Y7JSA7t25H7E8QDhhuy6SlnBGcUisNOCB2E16EKaSTNo8qA8aaW1TJ7g+mRm37gM1PdfigVQnxxapm3+Qmk/QO/uwv/RuKO/VLetkqZAsoLQRY+q5QGicr/3DFIIJMG6ic0aE8WuhEe37eyWptu6rvtumWRyX49VM891jF9fiy1vS96jdl7CW1FzeF7+BUDGXEQKfiSmTnQrdTijikUg87o0jfeXmMIeOWPTEn+4PCCxGRGRQKbFoxRDpOGfz6v4yUZ7VBSVrhUx1i9XBN9jf9zAVR5P71TR2Irg0lIR3kUzPmdI5+SOndcgGWFOOTfPta/dvoytz6PIT1UqHaUqce6uU3vogQ11RzeHz1oBK6cuyRxIKEyudzawf6nLFGbb2M8bBHU/M4kjE+NWnRjpz4UUvdYEB7Ar+jhtuKADSQZgcIdNH5qJdQQ1GUiLVGCEEuDxMSW4EThvJC2ywU3qcHyojwK9YxyNvdnnYWiHw8OgL0BO2Yb3xgzlco73cVZqtj4QFwqHh3h0t3BM5NST4Y8eS/nDJ7NNfwHM9TNILWj9n59VIAwUTEJ34znC9C/t81Hwvtoj5n+D3YtGnnCZNk3mzV+FoaMs866Fh3hYXoxC5nt89wti96MX5lGEgHmsc06gjujGrPQZkT80nmRqQoxc+06z9fY8ofJvw/6rGdLA
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(186009)(82310400011)(451199024)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(4326008)(54906003)(316002)(110136005)(478600001)(70206006)(70586007)(2906002)(8676002)(8936002)(41300700001)(86362001)(7636003)(5660300002)(83380400001)(36860700001)(2616005)(47076005)(7696005)(6666004)(356005)(82740400003)(1076003)(426003)(336012)(107886003)(26005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 22:47:18.1600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c75578e1-4b71-4fcd-6374-08dbb96260b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoder creation for raw trace uses metadata from the first CPU.
On per-process/per-thread traces, the first CPU is CPU0. If CPU0 trace
is not enabled, its metadata will be marked unused and the decoder is
not created. Perf report dump skips the decoding part because the
decoder is missing.

To fix this, use metadata of the CPU associated with sample object.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 tools/perf/util/cs-etm.c | 130 +++++++++++++++++++++++----------------
 1 file changed, 77 insertions(+), 53 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9729d006550d..3c3179a5eac6 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -640,71 +640,94 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
-static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int idx,
-					  u32 etmidr)
+static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_param,
+					  u64 *metadata, u32 etmidr)
 {
-	u64 **metadata = etm->metadata;
-
-	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
-	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
-	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
+	t_param->protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_param->etmv3.reg_ctrl = metadata[CS_ETM_ETMCR];
+	t_param->etmv3.reg_trc_id = metadata[CS_ETM_ETMTRACEIDR];
 }
 
-static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int idx)
+static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_param,
+					  u64 *metadata)
 {
-	u64 **metadata = etm->metadata;
+	t_param->protocol = CS_ETM_PROTO_ETMV4i;
+	t_param->etmv4.reg_idr0 = metadata[CS_ETMV4_TRCIDR0];
+	t_param->etmv4.reg_idr1 = metadata[CS_ETMV4_TRCIDR1];
+	t_param->etmv4.reg_idr2 = metadata[CS_ETMV4_TRCIDR2];
+	t_param->etmv4.reg_idr8 = metadata[CS_ETMV4_TRCIDR8];
+	t_param->etmv4.reg_configr = metadata[CS_ETMV4_TRCCONFIGR];
+	t_param->etmv4.reg_traceidr = metadata[CS_ETMV4_TRCTRACEIDR];
+}
 
-	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
-	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
-	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
-	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
-	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
-	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
-	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_param,
+					u64 *metadata)
+{
+	t_param->protocol = CS_ETM_PROTO_ETE;
+	t_param->ete.reg_idr0 = metadata[CS_ETE_TRCIDR0];
+	t_param->ete.reg_idr1 = metadata[CS_ETE_TRCIDR1];
+	t_param->ete.reg_idr2 = metadata[CS_ETE_TRCIDR2];
+	t_param->ete.reg_idr8 = metadata[CS_ETE_TRCIDR8];
+	t_param->ete.reg_configr = metadata[CS_ETE_TRCCONFIGR];
+	t_param->ete.reg_traceidr = metadata[CS_ETE_TRCTRACEIDR];
+	t_param->ete.reg_devarch = metadata[CS_ETE_TRCDEVARCH];
 }
 
-static void cs_etm__set_trace_param_ete(struct cs_etm_trace_params *t_params,
-					  struct cs_etm_auxtrace *etm, int idx)
+static int cs_etm__set_trace_param(struct cs_etm_trace_params *t_param,
+				   u64 *metadata)
 {
-	u64 **metadata = etm->metadata;
+	u32 etmidr;
+	u64 architecture = metadata[CS_ETM_MAGIC];
+
+	switch (architecture) {
+	case __perf_cs_etmv3_magic:
+		etmidr = metadata[CS_ETM_ETMIDR];
+		cs_etm__set_trace_param_etmv3(t_param, metadata, etmidr);
+		break;
+	case __perf_cs_etmv4_magic:
+		cs_etm__set_trace_param_etmv4(t_param, metadata);
+		break;
+	case __perf_cs_ete_magic:
+		cs_etm__set_trace_param_ete(t_param, metadata);
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	t_params[idx].protocol = CS_ETM_PROTO_ETE;
-	t_params[idx].ete.reg_idr0 = metadata[idx][CS_ETE_TRCIDR0];
-	t_params[idx].ete.reg_idr1 = metadata[idx][CS_ETE_TRCIDR1];
-	t_params[idx].ete.reg_idr2 = metadata[idx][CS_ETE_TRCIDR2];
-	t_params[idx].ete.reg_idr8 = metadata[idx][CS_ETE_TRCIDR8];
-	t_params[idx].ete.reg_configr = metadata[idx][CS_ETE_TRCCONFIGR];
-	t_params[idx].ete.reg_traceidr = metadata[idx][CS_ETE_TRCTRACEIDR];
-	t_params[idx].ete.reg_devarch = metadata[idx][CS_ETE_TRCDEVARCH];
+	return 0;
 }
 
 static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
 				     struct cs_etm_auxtrace *etm,
+				     bool formatted,
+				     int sample_cpu,
 				     int decoders)
 {
-	int i;
-	u32 etmidr;
-	u64 architecture;
-
-	for (i = 0; i < decoders; i++) {
-		architecture = etm->metadata[i][CS_ETM_MAGIC];
+	int i, ret;
+	struct cs_etm_trace_params *t_param;
+	u64 *metadata;
 
-		switch (architecture) {
-		case __perf_cs_etmv3_magic:
-			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
-			break;
-		case __perf_cs_etmv4_magic:
-			cs_etm__set_trace_param_etmv4(t_params, etm, i);
-			break;
-		case __perf_cs_ete_magic:
-			cs_etm__set_trace_param_ete(t_params, etm, i);
-			break;
-		default:
+	if (!formatted) {
+		/*
+		 * There is only one decoder when unformatted. Use metadata of
+		 * sample AUX cpu.
+		 */
+		t_param = t_params;
+		metadata = get_cpu_data(etm, sample_cpu);
+		if (!metadata) {
+			pr_err("CS_ETM: invalid sample CPU: %d\n", sample_cpu);
 			return -EINVAL;
 		}
+
+		return cs_etm__set_trace_param(t_param, metadata);
+	}
+
+	for (i = 0; i < decoders; i++) {
+		t_param = &t_params[i];
+		metadata = etm->metadata[i];
+		ret = cs_etm__set_trace_param(t_param, metadata);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
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
2.34.1

