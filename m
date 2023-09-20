Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39527A7952
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjITKca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjITKcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:32:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC2100;
        Wed, 20 Sep 2023 03:31:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K8gsM9004743;
        Wed, 20 Sep 2023 10:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=SdJdZ2rab+xJbVYuA5s1NwgP+xAGqrY6ooUDsB83ueo=;
 b=J5oz58OHSrNoB8YewwpSoJrOL2hjnx0katJuREF1oNyVDMsiiNSr98Nuj3DGKLXMcDve
 qYofHDcI51kwqy6Fkr7tl6eBJHp/Cx7mfUDuBl/zipS0Zpme3fOmYokGwRp2Qk7BTTG4
 pd/KKoIN/dpzOqw42nBj20gAMPeh8BGmc5+IGNw2NTPp2lwvQPvWvVSaqgS9WQFCqz1t
 dB3QZbExqhq6wvg7h2jcHueIMxL2dDk8DdhYnCDUPp24zW5+DGlEPHMgz1UG86wTwwz4
 J2zvakXSmsrk8o6uhGOq0d4+eB5Syj3x+qB48c9E99QkzTIRlaSwFoi0fMeZc0hpDoG6 OA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t7rhuruf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 10:31:53 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KAVqev013800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 10:31:52 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 03:31:49 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v2 4/5] misc: fastrpc: Add support to save and restore interrupted
Date:   Wed, 20 Sep 2023 16:01:29 +0530
Message-ID: <1695205890-21018-5-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695205890-21018-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1695205890-21018-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: r0vsqXKSJ8K2pQb4CMPeYHxaZ4VwrDRz
X-Proofpoint-GUID: r0vsqXKSJ8K2pQb4CMPeYHxaZ4VwrDRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200083
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For any remote call, driver sends a message to DSP using RPMSG
framework. After message is sent, there is a wait on a completion
object at driver which is completed when DSP response is received.

There is a possibility that a signal is received while waiting
causing the wait function to return -ERESTARTSYS. In this case
the context should be saved and it should get restored for the
next invocation for the thread.

Adding changes to support saving and restoring of interrupted
fastrpc contexts.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v2:
  - Fixed compile time warnings

 drivers/misc/fastrpc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1b26718..1c625571 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1488,7 +1488,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
@@ -1616,7 +1616,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
 		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
@@ -1699,7 +1699,7 @@ static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1708,7 +1708,6 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
-	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 	unsigned long flags;
@@ -1845,7 +1844,7 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1876,7 +1875,7 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	}
 
 	ioctl.inv = inv;
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, false, &ioctl);
 	kfree(args);
@@ -1917,7 +1916,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 		perf_kernel = (u64 *)(uintptr_t)einv.perf_kernel;
 		if (perf_kernel)
 			fl->profile = true;
-		einv.inv.args = (__u64)args;
+		einv.inv.args = (u64)args;
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
 		break;
@@ -1947,7 +1946,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 
 	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(0, 1, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -2050,7 +2049,7 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (!err) {
@@ -2144,7 +2143,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
@@ -2229,7 +2228,7 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	fastrpc_map_put(map);
@@ -2298,7 +2297,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
-- 
2.7.4

