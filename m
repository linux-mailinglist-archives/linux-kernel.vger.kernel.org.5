Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773467F2948
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbjKUJtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbjKUJtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:49:12 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775C5136;
        Tue, 21 Nov 2023 01:49:07 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL9HEmP031563;
        Tue, 21 Nov 2023 09:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=vEltVJinW3eU8qaHD9E2kOlua4I5vuIh5vyOxB/sHS0=;
 b=KS9Mh2sM+FEKgyJ5cW0kKczoCO6LrB1R/9kmhIT1lBJadnxgN9+lEc39E8DF2gOnlO4I
 Belao7v+paiLnPIlYg4akOMBaX9EzVDNqFGW16AoThBlGJ9n2SeJc4EO9R6IdVXUPeCP
 5YfDw2LvkfKYXDjDg9QYyBiW+PPl5m+kQ/UaF2DulhKr3c7ZUlTl+973o4ucleypzqZx
 Bf7rMgPo4tUAKNlejLXS3DUAch85aHPa1RPN4UNOtokNY9DRC6r8UBCt0wb1UMvwmYfS
 MKnUhjZ8hOpMlloruCV8Q5ItTWZ9qs2v2uI9FDm2ijnO0j66+eQNPbnVYD8vOdgeHaV3 AA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugsskr1wq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 09:49:05 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL9n4Nl017525
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 09:49:04 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 01:49:02 -0800
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 5/5] misc: fastrpc: Add support to allocate shared context bank
Date:   Tue, 21 Nov 2023 15:18:44 +0530
Message-ID: <20231121094844.5764-6-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121094844.5764-1-quic_ekangupt@quicinc.com>
References: <20231121094844.5764-1-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qQScA2cp1K-fA-DDSQEvE9FFFOp2SETq
X-Proofpoint-ORIG-GUID: qQScA2cp1K-fA-DDSQEvE9FFFOp2SETq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=995
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v7:
  - Rebase the patch to latest kernel version

 drivers/misc/fastrpc.c      | 122 ++++++++++++++++++++++++------------
 include/uapi/misc/fastrpc.h |  12 ++++
 2 files changed, 95 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index aa0695f9576e..8e77beb3a693 100644
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
@@ -1448,6 +1490,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1570,6 +1616,10 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	inbuf.pgid = fl->tgid;
 	inbuf.namelen = strlen(current->comm) + 1;
 	inbuf.filelen = init.filelen;
@@ -1644,36 +1694,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
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
@@ -1777,15 +1797,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
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
@@ -1844,6 +1855,10 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = fl->tgid;
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
@@ -1890,11 +1905,33 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
@@ -1938,6 +1975,12 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
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
@@ -2440,6 +2483,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	if (sessions > 0) {
 		struct fastrpc_session_ctx *dup_sess;
 
+		sess->sharedcb = true;
 		for (i = 1; i < sessions; i++) {
 			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
 				break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 074675ee646f..3dfd8e95eda8 100644
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
2.17.1

