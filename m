Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B8D799B4E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjIIVIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjIIVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:08:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD581AC;
        Sat,  9 Sep 2023 14:08:16 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 389KFInn005626;
        Sat, 9 Sep 2023 20:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=DMK/C511hM1u2tmG6bhmvq23jtaITfzFem2Xkn2GCvA=;
 b=g27AkkBdODkJYJhz7dlL27IQaJ4BCxTja09ptF2med+kRXnpDglJue1AMIB662ctRpXa
 aJ60vWxUzh/1mEiLJRymRQvpdNVA/rETWfpyWCFkBrsAfn7ZPtHqUJPMD14A3YaOXj0N
 ENrQXh7M/y3P/YPZFmOYAwlp2gatOWDmtTXnwHrnGsRQl1/nzdWA/8sZKm1vIe/G/BtE
 bnGE79LHmBNZscGbQc3NC2XLCKH8MtjMj/7+W1gwRKpbwg3RHWu3vmAvyUo0luVrBh9W
 kKRXFcsXZ5B4uqePdfg7McRFWPYZtmVFDYM1vJatIaAsaYop8+1WRNoTKHyaST9OGCwP Ew== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0j0fgx5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 09 Sep 2023 20:18:15 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 389KIESK023362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 9 Sep 2023 20:18:14 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sat, 9 Sep 2023 13:18:04 -0700
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>,
        <quic_mojha@quicinc.com>
Subject: [PATCH v5 10/17] pstore: Add pstore_region_defined() helper and export it
Date:   Sun, 10 Sep 2023 01:46:11 +0530
Message-ID: <1694290578-17733-11-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dIWnjtDaYbpMoOmHa-qDFqETXv0l5IcY
X-Proofpoint-GUID: dIWnjtDaYbpMoOmHa-qDFqETXv0l5IcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-09_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309090187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are users like Qualcomm minidump which is interested in
knowing the pstore frontend addresses and sizes from the backend
(ram) to be able to register it with firmware to finally collect
them during crash for debugging.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 fs/pstore/platform.c   | 15 +++++++++++++++
 fs/pstore/ram.c        | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pstore.h |  6 ++++++
 3 files changed, 63 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index cbc0b468c1ab..cb80116a05cb 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -137,6 +137,21 @@ enum pstore_type_id pstore_name_to_type(const char *name)
 }
 EXPORT_SYMBOL_GPL(pstore_name_to_type);
 
+int pstore_region_defined(struct pstore_record *record,
+			  void **virt, phys_addr_t *phys,
+			  size_t *size, unsigned int *max_dump_cnt)
+{
+	if (!psinfo)
+		return -EINVAL;
+
+	record->psi = psinfo;
+
+	return psinfo->region_info ?
+	       psinfo->region_info(record, virt, phys, size, max_dump_cnt) :
+	       -EINVAL;
+}
+EXPORT_SYMBOL_GPL(pstore_region_defined);
+
 static void pstore_timer_kick(void)
 {
 	if (pstore_update_ms < 0)
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index e73fbbc1b5b5..2ebb1f5f6350 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -436,6 +436,47 @@ static int ramoops_pstore_erase(struct pstore_record *record)
 	return 0;
 }
 
+static int ramoops_region_info(struct pstore_record *record,
+			       void **virt, phys_addr_t *phys,
+			       size_t *size, unsigned int *max_dump_cnt)
+{
+	struct ramoops_context *cxt = record->psi->data;
+	struct persistent_ram_zone *prz;
+
+	switch (record->type) {
+	case PSTORE_TYPE_DMESG:
+		if (record->id >= cxt->max_dump_cnt)
+			return -EINVAL;
+		prz = cxt->dprzs[record->id];
+		*max_dump_cnt = cxt->max_dump_cnt;
+		break;
+	case PSTORE_TYPE_CONSOLE:
+		if (!cxt->console_size)
+			return -EINVAL;
+		prz = cxt->cprz;
+		break;
+	case PSTORE_TYPE_FTRACE:
+		if (record->id >= cxt->max_ftrace_cnt)
+			return -EINVAL;
+		prz = cxt->fprzs[record->id];
+		*max_dump_cnt = cxt->max_ftrace_cnt;
+		break;
+	case PSTORE_TYPE_PMSG:
+		if (!cxt->pmsg_size)
+			return -EINVAL;
+		prz = cxt->mprz;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*virt = prz->vaddr;
+	*phys = prz->paddr;
+	*size = prz->size;
+
+	return 0;
+}
+
 static struct ramoops_context oops_cxt = {
 	.pstore = {
 		.owner	= THIS_MODULE,
@@ -445,6 +486,7 @@ static struct ramoops_context oops_cxt = {
 		.write	= ramoops_pstore_write,
 		.write_user	= ramoops_pstore_write_user,
 		.erase	= ramoops_pstore_erase,
+		.region_info = ramoops_region_info,
 	},
 };
 
diff --git a/include/linux/pstore.h b/include/linux/pstore.h
index 638507a3c8ff..a64d866e8711 100644
--- a/include/linux/pstore.h
+++ b/include/linux/pstore.h
@@ -199,6 +199,9 @@ struct pstore_info {
 	int		(*write_user)(struct pstore_record *record,
 				      const char __user *buf);
 	int		(*erase)(struct pstore_record *record);
+	int		(*region_info)(struct pstore_record *record,
+				       void **virt, phys_addr_t *phys,
+				       size_t *size, unsigned int *max_dump_cnt);
 };
 
 /* Supported frontends */
@@ -230,6 +233,9 @@ struct pstore_ftrace_record {
 #define TS_CPU_SHIFT 8
 #define TS_CPU_MASK (BIT(TS_CPU_SHIFT) - 1)
 
+int pstore_region_defined(struct pstore_record *record,
+			  void **virt, phys_addr_t *phys,
+			  size_t *size, unsigned int *max_dump_cnt);
 /*
  * If CPU number can be stored in IP, store it there, otherwise store it in
  * the time stamp. This means more timestamp resolution is available when
-- 
2.7.4

