Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F778F143
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346825AbjHaQ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346593AbjHaQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:28:45 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF380E56;
        Thu, 31 Aug 2023 09:28:38 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VBLQn3026710;
        Thu, 31 Aug 2023 16:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=f2xxe08v/bSPU7Buh1A+IhrKRh1d6l13UuA+QofE+ok=;
 b=Lr6uBHSqffQT+PZb4UxxZpfGcU5MHtVf5ZnvRFi7YeX5Z8xcESWiJor+bEEMFEerUvoF
 CvycxHuV2tqN2q9Ot8PpK0WvBmT0RLfFyULX/7hHu41+l4+46hMm1ff0VZ2m/57t8v0h
 gxnXQkVKfoir31VsG5AKMFpG9aE0Vw42dRLpJefZmtffoDaru/KUYn9zlFzsEVg7mPG9
 XBFAsUKXTjZYSu17+zImhgf9m5MeoYqh499EnV90RfMlotuz9SBtTQv0ge7WmdPIhPcj
 zdHfrVvFT2EiBNialqa7hMF2gi/Txx53KE+BwZe0hzm9j7Geo6GcAe7iXRwPopTonWHP BA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st4p3keq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 16:28:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VGSaL4005911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 16:28:36 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 09:28:33 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 5/5] misc: fastrpc: Add support to allocate shared context bank
Date:   Thu, 31 Aug 2023 21:58:12 +0530
Message-ID: <1693499292-19083-6-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1693499292-19083-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1693499292-19083-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _KLg7Bc2j454ofvKivu20ewl0wYMR9Ak
X-Proofpoint-GUID: _KLg7Bc2j454ofvKivu20ewl0wYMR9Ak
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_14,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 clxscore=1015 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310147
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/misc/fastrpc.c | 121 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 82 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1b26718..6ac1403 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -296,6 +296,7 @@ struct fastrpc_session_ctx {
 	int sid;
 	bool used;
 	bool valid;
+	bool sharedcb;
 };
 
 struct fastrpc_channel_ctx {
@@ -343,12 +344,22 @@ struct fastrpc_user {
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
@@ -850,6 +861,37 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
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
@@ -1446,6 +1488,10 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	if (!fl->cctx->remote_heap) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
 						&fl->cctx->remote_heap);
@@ -1563,6 +1609,10 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err;
 	}
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	inbuf.pgid = fl->tgid;
 	inbuf.namelen = strlen(current->comm) + 1;
 	inbuf.filelen = init.filelen;
@@ -1637,36 +1687,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
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
@@ -1771,15 +1791,6 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
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
@@ -1838,6 +1849,10 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = fl->tgid;
 
+	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
+	if (!fl->sctx)
+		return -EBUSY;
+
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
@@ -1884,11 +1899,32 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
 	int err;
@@ -1921,6 +1957,12 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
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
@@ -2421,6 +2463,7 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	if (sessions > 0) {
 		struct fastrpc_session_ctx *dup_sess;
 
+		sess->sharedcb = true;
 		for (i = 1; i < sessions; i++) {
 			if (cctx->sesscount >= FASTRPC_MAX_SESSIONS)
 				break;
-- 
2.7.4

