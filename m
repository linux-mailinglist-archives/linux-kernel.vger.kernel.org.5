Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EBB7D7E54
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344702AbjJZISh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344620AbjJZIS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:18:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F461B2;
        Thu, 26 Oct 2023 01:18:22 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q7QAUT025592;
        Thu, 26 Oct 2023 08:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mSi9WBDCHFP67vFBaZpRzmem1kybzwSSx2XVp/2m/NY=;
 b=N9osCq0OQmCBPs1axmjXylwdXSjynAsnaRNPXHodpGerFXMQNCbAjFP0XEQ/hL7GKg1m
 hUmX48/cEOjhjw0lKgy+VJlHmMpgeoOEuYZ7EE4fP0JReoHdi257KOjndXvJ3HIGxgi5
 BSCJhBnl18fnTWbpgqQI2r7kqHxJJBcpQh1EQxGmPaFM97JTJVCh2u8sBJ0rF1wCfsyA
 VAmW4t4jdxQX5c065olee+lv3mzCS3KR0yKwk4i3YDVlabIlH67PjJpBGPL4oCnrLiZR
 ks3mD0KpaM0uDRnEiuKgqYsramFe+nR+5wtHWMjPBinqNPrOqlR3tc7RP/JVlH8ns0+M 2A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtw1k4ru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:18:20 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q8IJC3023726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:18:19 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 01:18:17 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 5/5] misc: fastrpc: Add support to allocate shared context bank
Date:   Thu, 26 Oct 2023 13:48:02 +0530
Message-ID: <1698308282-8648-6-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698308282-8648-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1698308282-8648-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mkGLnqAYt4bFlAHNRJiP93Pq1evxsIaj
X-Proofpoint-GUID: mkGLnqAYt4bFlAHNRJiP93Pq1evxsIaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context banks could be set as a shared one using a DT propery
"qcom,nsessions". The property takes the number of session to
be created of the context bank. This change provides a control
mechanism for user to use shared context banks for light weight
processes. The session is set as shared while its creation and if
a user requests for shared context bank, the same will be allocated
during process initialization.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 122 ++++++++++++++++++++++++++++++--------------
 include/uapi/misc/fastrpc.h |  12 +++++
 2 files changed, 95 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9a481ac..b6b1884c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -297,6 +297,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool sharedcb;
 };
 
 struct fastrpc_channel_ctx {
@@ -344,12 +345,22 @@ struct fastrpc_user {
 	int tgid;
 	int pd;
 	bool is_secure_dev;
+	bool sharedcb;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
 	struct mutex mutex;
 };
 
+struct fastrpc_ctrl_smmu {
+	u32 sharedcb;	/* Set to SMMU share context bank */
+};
+
+struct fastrpc_internal_control {
+	u32 req;
+	struct fastrpc_ctrl_smmu smmu;
+};
+
 static inline int64_t getnstimediff(struct timespec64 *start)
 {
 	int64_t ns;
@@ -851,6 +862,37 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 	.release = fastrpc_release,
 };
 
+static struct fastrpc_session_ctx *fastrpc_session_alloc(
+					struct fastrpc_channel_ctx *cctx, bool sharedcb)
+{
+	struct fastrpc_session_ctx *session = NULL;
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	for (i = 0; i < cctx->sesscount; i++) {
+		if (!cctx->session[i].used && cctx->session[i].valid &&
+			cctx->session[i].sharedcb == sharedcb) {
+			cctx->session[i].used = true;
+			session = &cctx->session[i];
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	return session;
+}
+
+static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
+				 struct fastrpc_session_ctx *session)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	session->used = false;
+	spin_unlock_irqrestore(&cctx->lock, flags);
+}
+
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
@@ -1449,6 +1491,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1571,6 +1617,10 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	inbuf.pgid = fl->tgid;
 	inbuf.namelen = strlen(current->comm) + 1;
 	inbuf.filelen = init.filelen;
@@ -1645,36 +1695,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	return err;
 }
 
-static struct fastrpc_session_ctx *fastrpc_session_alloc(
-					struct fastrpc_channel_ctx *cctx)
-{
-	struct fastrpc_session_ctx *session = NULL;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&cctx->lock, flags);
-	for (i = 0; i < cctx->sesscount; i++) {
-		if (!cctx->session[i].used && cctx->session[i].valid) {
-			cctx->session[i].used = true;
-			session = &cctx->session[i];
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&cctx->lock, flags);
-
-	return session;
-}
-
-static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
-				 struct fastrpc_session_ctx *session)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&cctx->lock, flags);
-	session->used = false;
-	spin_unlock_irqrestore(&cctx->lock, flags);
-}
-
 static void fastrpc_context_list_free(struct fastrpc_user *fl)
 {
 	struct fastrpc_invoke_ctx *ctx, *n;
@@ -1778,15 +1798,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	fl->cctx = cctx;
 	fl->is_secure_dev = fdevice->secure;
 
-	fl->sctx = fastrpc_session_alloc(cctx);
-	if (!fl->sctx) {
-		dev_err(&cctx->rpdev->dev, "No session available\n");
-		mutex_destroy(&fl->mutex);
-		kfree(fl);
-
-		return -EBUSY;
-	}
-
 	spin_lock_irqsave(&cctx->lock, flags);
 	list_add_tail(&fl->user, &cctx->users);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -1845,6 +1856,10 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = fl->tgid;
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
@@ -1891,11 +1906,33 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static int fastrpc_internal_control(struct fastrpc_user *fl,
+					struct fastrpc_internal_control *cp)
+{
+	int err = 0;
+
+	if (!fl)
+		return -EBADF;
+	if (!cp)
+		return -EINVAL;
+
+	switch (cp->req) {
+	case FASTRPC_CONTROL_SMMU:
+		fl->sharedcb = cp->smmu.sharedcb;
+		break;
+	default:
+		err = -EBADRQC;
+		break;
+	}
+	return err;
+}
+
 static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_enhanced_invoke einv;
 	struct fastrpc_invoke_args *args = NULL;
 	struct fastrpc_ioctl_multimode_invoke invoke;
+	struct fastrpc_internal_control cp = {0};
 	u32 nscalars;
 	u64 *perf_kernel;
 	int err, i;
@@ -1939,6 +1976,12 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
 		break;
+	case FASTRPC_INVOKE_CONTROL:
+		if (copy_from_user(&cp, (void __user *)(uintptr_t)invoke.invparam, sizeof(cp)))
+			return  -EFAULT;
+
+		err = fastrpc_internal_control(fl, &cp);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
@@ -2439,6 +2482,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	if (sessions > 0) {
 		struct fastrpc_session_ctx *dup_sess;
 
+		sess->sharedcb = true;
 		for (i = 1; i < sessions; i++) {
 			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
 				break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 074675e..3dfd8e9 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -166,6 +166,18 @@ struct fastrpc_ioctl_capability {
 	__u32 reserved[4];
 };
 
+enum fastrpc_control_type {
+	FASTRPC_CONTROL_LATENCY		=	1,
+	FASTRPC_CONTROL_SMMU		=	2,
+	FASTRPC_CONTROL_KALLOC		=	3,
+	FASTRPC_CONTROL_WAKELOCK	=	4,
+	FASTRPC_CONTROL_PM		=	5,
+	FASTRPC_CONTROL_DSPPROCESS_CLEAN	=	6,
+	FASTRPC_CONTROL_RPC_POLL	=	7,
+	FASTRPC_CONTROL_ASYNC_WAKE	=	8,
+	FASTRPC_CONTROL_NOTIF_WAKE	=	9,
+};
+
 enum fastrpc_perfkeys {
 	PERF_COUNT = 0,
 	PERF_RESERVED1 = 1,
-- 
2.7.4

