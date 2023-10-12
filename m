Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E797C6BEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377894AbjJLLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbjJLLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:08:37 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C750E90;
        Thu, 12 Oct 2023 04:08:35 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9rbgv001164;
        Thu, 12 Oct 2023 11:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bJotzytAWkF9t8Y0naHSXGLqJBuRemHVtr6oKmxO9w4=;
 b=IUPxutQwbx8JIfCghffvGEXD8Qa6yzZeoG1UKz2tNuxPZesDRIh9rzJMHm5r6OqvSsis
 9rvEPmggHe4grARTQFYQIRS0dWIJTeEaMM8pwYVTex2kZV7eUbSRwbsIVlKfZFg0258U
 p2fNa14F6f7mTU9Lme5Vm9+IRq08+RGpOZ/M3WvCgseusAl7VO8f0dL0rZ5XDs8epnP2
 EK/PIghz3jaSRnAZkb7s/rpMNQ9gRN+GD5RF+nD/DrofNLIwnr3NJTY5gipCTsh7ndHi
 0A8t5Us16KuLw0YDDS4T+rAqGswGAfFjdr4MW4yFYnGd5l+f61IHT8TCrB4jt4REoTpj 7w== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tp0vw9uwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:08:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39CB8FqC006472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 11:08:15 GMT
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 12 Oct 2023 04:08:12 -0700
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
Subject: [PATCH] coresight-tmc-etr: Fix busy error when enable multiple sources
Date:   Thu, 12 Oct 2023 19:07:54 +0800
Message-ID: <20231012110754.32635-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tfBzX98pawDRluVK1aJ1l0wIJdHA3E6Y
X-Proofpoint-ORIG-GUID: tfBzX98pawDRluVK1aJ1l0wIJdHA3E6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 mlxlogscore=485
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In enable sink sysfs function, when etr is enabled, it doesn't need
to call enable hw function again.

[   91.057233] ------------[ cut here ]------------
[   91.061983] WARNING: CPU: 6 PID: 145 at drivers/hwtracing/coresight/coresight-tmc-etr.c:1038 tmc_etr_enable_hw+0xc4/0xd0
[   91.073153] Modules linked in:
[   91.076302] CPU: 6 PID: 145 Comm: sh Tainted: G S      W          6.5.0-rc3-g66d5eaa9e5a7 #111
[   91.085149] Hardware name: Qualcomm Technologies, Inc. SM8450 QRD (DT)
[   91.091847] pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   91.099000] pc : tmc_etr_enable_hw+0xc4/0xd0
[   91.103389] lr : tmc_enable_etr_sink+0x13c/0x294
[   91.108130] sp : ffff8000815cbb30
[   91.111537] x29: ffff8000815cbb30 x28: ffff68ce4352a800 x27: 0000000000000000
[   91.118868] x26: ffff68ce414cc040 x25: ffff68ce414a82e0 x24: 0000000000000000
[   91.126199] x23: ffff68ce423a1ee0 x22: ffff68ce423a1e80 x21: ffff68ce4352a800
[   91.133527] x20: 0000000000000001 x19: ffff68ce414aa500 x18: fffffda31cf9c008
[   91.140857] x17: 0000000000000040 x16: 0000000000000001 x15: fffffc0000000000
[   91.148188] x14: 00000000f0000080 x13: 0000000000000000 x12: ffff9739c0000000
[   91.155516] x11: ffffbe9cdf71e400 x10: 0000000000001000 x9 : ffff68d0b29e3b28
[   91.162845] x8 : fffffda31cf983c8 x7 : fffffda31cf98388 x6 : 00000000ffffffd0
[   91.170174] x5 : ffff68ce435d8ec0 x4 : ffff68d0b29e2610 x3 : ffff68ce435d8ec0
[   91.177502] x2 : ffff68ce414aa500 x1 : ffff68ce414aa500 x0 : ffff68ce423a1e80
[   91.184833] Call trace:
[   91.187349]  tmc_etr_enable_hw+0xc4/0xd0
[   91.191388]  tmc_enable_etr_sink+0x13c/0x294
[   91.195777]  coresight_enable_path+0x21c/0x24c
[   91.200347]  coresight_enable+0x9c/0x204
[   91.204379]  enable_source_store+0x58/0xa0
[   91.208595]  dev_attr_store+0x18/0x2c
[   91.212361]  sysfs_kf_write+0x40/0x54
[   91.216126]  kernfs_fop_write_iter+0x164/0x1dc
[   91.220692]  vfs_write+0x3a8/0x460
[   91.224191]  ksys_write+0x6c/0x100
[   91.227690]  __arm64_sys_write+0x1c/0x28
[   91.231728]  invoke_syscall+0x44/0x100
[   91.235586]  el0_svc_common.constprop.1+0x6c/0xe4
[   91.240418]  do_el0_svc+0x38/0x94
[   91.243833]  el0_svc+0x28/0x74
[   91.246981]  el0t_64_sync_handler+0xa0/0xc4
[   91.251282]  el0t_64_sync+0x174/0x178
[   91.255045] ---[ end trace 0000000000000000 ]---
sh: write error: Device or resource busy

Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 66dc5f97a009..e1c7bae9f6ee 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1204,7 +1204,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
@@ -1213,12 +1213,16 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		return PTR_ERR(sysfs_buf);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->mode == CS_MODE_SYSFS)
+		goto out;
+
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
 		drvdata->mode = CS_MODE_SYSFS;
 		atomic_inc(&csdev->refcnt);
 	}
 
+out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
-- 
2.17.1

