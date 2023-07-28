Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813C767129
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjG1PyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236969AbjG1PyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:54:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B584203;
        Fri, 28 Jul 2023 08:53:55 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S8IdU5026933;
        Fri, 28 Jul 2023 13:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=RQM1pHsQEs3n66eGzhwxSmT3s/xfK19YPFzMp1huDbw=;
 b=pAWXQY9FnUXOWapWBcQmNY2o3tVVyjUvlVYkb10OQK3Q/sTA7c05gRNSH0pL8f7fh8hb
 5CkaB4z8mTgaXvtwJPWRE5tc96LML/V1pTKpxMHu2rk+G/emUZ8iUoyCy339ZWVqEYcg
 UvBjdw/QUeObs7jEsr8a6Icz+AgxCT6xRFjCCmAs/1TJNt0G+KqXONkLoyWdDAheuHgT
 4y/9pMg1bN7JWOFeKeiycyIFc271RFNa06t0YOBUxcl3ZzxwU8RoFTxfih/fTUj1c1hX
 9aidZ60RV5+Zkpw/JzH7d74WWoet8p468Y4/XrrSqnUksMj7DXVm6s+06Tug6/kSt12O 2g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s468qs15b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:44 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDQi5H003281
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:26:44 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:26:40 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 27/33] iris: variant: add helper functions for register handling
Date:   Fri, 28 Jul 2023 18:53:38 +0530
Message-ID: <1690550624-14642-28-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dfuZQE2NBQfSwAkUgd7g5jc6fTBoOnwl
X-Proofpoint-ORIG-GUID: dfuZQE2NBQfSwAkUgd7g5jc6fTBoOnwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=565
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

This implements the functions to read and write different regsiters.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../iris/variant/common/inc/msm_vidc_variant.h     |  22 +++
 .../iris/variant/common/src/msm_vidc_variant.c     | 163 +++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/variant/common/inc/msm_vidc_variant.h
 create mode 100644 drivers/media/platform/qcom/iris/variant/common/src/msm_vidc_variant.c

diff --git a/drivers/media/platform/qcom/iris/variant/common/inc/msm_vidc_variant.h b/drivers/media/platform/qcom/iris/variant/common/inc/msm_vidc_variant.h
new file mode 100644
index 0000000..58ba276
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/variant/common/inc/msm_vidc_variant.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MSM_VIDC_VARIANT_H_
+#define _MSM_VIDC_VARIANT_H_
+
+#include <linux/types.h>
+
+struct msm_vidc_core;
+
+int __write_register_masked(struct msm_vidc_core *core, u32 reg, u32 value,
+			    u32 mask);
+int __write_register(struct msm_vidc_core *core, u32 reg, u32 value);
+int __read_register(struct msm_vidc_core *core, u32 reg, u32 *value);
+int __read_register_with_poll_timeout(struct msm_vidc_core *core, u32 reg,
+				      u32 mask, u32 exp_val, u32 sleep_us, u32 timeout_us);
+int __set_registers(struct msm_vidc_core *core);
+
+#endif
diff --git a/drivers/media/platform/qcom/iris/variant/common/src/msm_vidc_variant.c b/drivers/media/platform/qcom/iris/variant/common/src/msm_vidc_variant.c
new file mode 100644
index 0000000..4901844
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/variant/common/src/msm_vidc_variant.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+
+#include "msm_vidc_core.h"
+#include "msm_vidc_debug.h"
+#include "msm_vidc_driver.h"
+#include "msm_vidc_platform.h"
+#include "msm_vidc_state.h"
+#include "msm_vidc_variant.h"
+#include "venus_hfi.h"
+
+int __write_register(struct msm_vidc_core *core, u32 reg, u32 value)
+{
+	u32 hwiosymaddr = reg;
+	u8 *base_addr;
+	int rc = 0;
+
+	rc = __strict_check(core, __func__);
+	if (rc)
+		return rc;
+
+	if (!is_core_sub_state(core, CORE_SUBSTATE_POWER_ENABLE)) {
+		d_vpr_e("HFI Write register failed : Power is OFF\n");
+		return -EINVAL;
+	}
+
+	base_addr = core->resource->register_base_addr;
+	d_vpr_l("regwrite(%pK + %#x) = %#x\n", base_addr, hwiosymaddr, value);
+	base_addr += hwiosymaddr;
+	writel_relaxed(value, base_addr);
+
+	/* Memory barrier to make sure value is written into the register */
+	wmb();
+
+	return rc;
+}
+
+/*
+ * Argument mask is used to specify which bits to update. In case mask is 0x11,
+ * only bits 0 & 4 will be updated with corresponding bits from value. To update
+ * entire register with value, set mask = 0xFFFFFFFF.
+ */
+int __write_register_masked(struct msm_vidc_core *core, u32 reg, u32 value,
+			    u32 mask)
+{
+	u32 prev_val, new_val;
+	u8 *base_addr;
+	int rc = 0;
+
+	rc = __strict_check(core, __func__);
+	if (rc)
+		return rc;
+
+	if (!is_core_sub_state(core, CORE_SUBSTATE_POWER_ENABLE)) {
+		d_vpr_e("%s: register write failed, power is off\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	base_addr = core->resource->register_base_addr;
+	base_addr += reg;
+
+	prev_val = readl_relaxed(base_addr);
+	/*
+	 * Memory barrier to ensure register read is correct
+	 */
+	rmb();
+
+	new_val = (prev_val & ~mask) | (value & mask);
+	d_vpr_l("Base addr: %pK, writing to: %#x, mask: %#x\n",
+		base_addr, reg, mask);
+
+	d_vpr_l("previous-value: %#x, value: %#x, new-value: %#x...\n",
+		prev_val, value, new_val);
+	writel_relaxed(new_val, base_addr);
+	/*
+	 * Memory barrier to make sure value is written into the register.
+	 */
+	wmb();
+
+	return rc;
+}
+
+int __read_register(struct msm_vidc_core *core, u32 reg, u32 *value)
+{
+	int rc = 0;
+	u8 *base_addr;
+
+	if (!is_core_sub_state(core, CORE_SUBSTATE_POWER_ENABLE)) {
+		d_vpr_e("HFI Read register failed : Power is OFF\n");
+		return -EINVAL;
+	}
+
+	base_addr = core->resource->register_base_addr;
+
+	*value = readl_relaxed(base_addr + reg);
+	/*
+	 * Memory barrier to make sure value is read correctly from the
+	 * register.
+	 */
+	rmb();
+	d_vpr_l("regread(%pK + %#x) = %#x\n", base_addr, reg, *value);
+
+	return rc;
+}
+
+int __read_register_with_poll_timeout(struct msm_vidc_core *core, u32 reg,
+				      u32 mask, u32 exp_val, u32 sleep_us,
+				      u32 timeout_us)
+{
+	int rc = 0;
+	u32 val = 0;
+	u8 *addr;
+
+	if (!is_core_sub_state(core, CORE_SUBSTATE_POWER_ENABLE)) {
+		d_vpr_e("%s failed: Power is OFF\n", __func__);
+		return -EINVAL;
+	}
+
+	addr = (u8 *)core->resource->register_base_addr + reg;
+
+	rc = readl_relaxed_poll_timeout(addr, val, ((val & mask) == exp_val), sleep_us, timeout_us);
+	/*
+	 * Memory barrier to make sure value is read correctly from the
+	 * register.
+	 */
+	rmb();
+	d_vpr_l("regread(%pK + %#x) = %#x. rc %d, mask %#x, exp_val %#x\n",
+		core->resource->register_base_addr, reg, val, rc, mask, exp_val);
+	d_vpr_l("cond %u, sleep %u, timeout %u\n",
+		((val & mask) == exp_val), sleep_us, timeout_us);
+
+	return rc;
+}
+
+int __set_registers(struct msm_vidc_core *core)
+{
+	const struct reg_preset_table *reg_prst;
+	unsigned int prst_count;
+	int cnt, rc = 0;
+
+	reg_prst = core->platform->data.reg_prst_tbl;
+	prst_count = core->platform->data.reg_prst_tbl_size;
+
+	/* skip if there is no preset reg available */
+	if (!reg_prst || !prst_count)
+		return 0;
+
+	for (cnt = 0; cnt < prst_count; cnt++) {
+		rc = __write_register_masked(core, reg_prst[cnt].reg,
+					     reg_prst[cnt].value, reg_prst[cnt].mask);
+		if (rc)
+			return rc;
+	}
+
+	return rc;
+}
-- 
2.7.4

