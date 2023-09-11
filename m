Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8104B79AD22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359598AbjIKWSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbjIKK4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:56:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4BF3;
        Mon, 11 Sep 2023 03:56:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38BAmZOB029187;
        Mon, 11 Sep 2023 10:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4gOSVhCipTQhqe7KQujCKS59XbGovpmGhKA4BrqGRG4=;
 b=EoobLeUT13AVt3PTwJqXJwFoFY711k/p9kBdt8sNyDx2SYQiL2+AlkP3xxwlsm4ADRKL
 +CzLEZHmHgE2tbzMTwJIg01wXHipHedMIRBYX64gw0cpiwnoQ0m8KJZ+30IWYBj7ls68
 O4B6FJ6tr5X16QUK15HuMSBPqsZyVw+PPXXXx6cjegZDhcGpXAU4QQc+yJDv9VxJVABk
 uHmq+CbUt6d/izNUgnDhZT4krttKpKCPF18dXXSMYOK9dEqV1UCY1RdxDgpFJh4tWW5v
 csaOh3NHadUqNs2Wdu7Rg2hP7Q3vXSKunSAhJqi/948dEUQt0c7M/c9lIo0ipGPJSY7i lQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t0j0fkfm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:56:13 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38BAuCVt006051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 10:56:13 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 11 Sep 2023 03:55:37 -0700
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
Subject: [REBASE PATCH v5 10/17] pstore: Add pstore_region_defined() helper and export it
Date:   Mon, 11 Sep 2023 16:23:52 +0530
Message-ID: <1694429639-21484-11-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XyQCjwjHOG0scL4SF1euCldLbQ6NjV_y
X-Proofpoint-GUID: XyQCjwjHOG0scL4SF1euCldLbQ6NjV_y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309110099
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
index e5bca9a004cc..fdac951059c1 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -139,6 +139,21 @@ enum pstore_type_id pstore_name_to_type(const char *name)
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
index ab551caa1d2a..62202f3ddf63 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -437,6 +437,47 @@ static int ramoops_pstore_erase(struct pstore_record *record)
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
@@ -446,6 +487,7 @@ static struct ramoops_context oops_cxt = {
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

