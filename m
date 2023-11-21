Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB07F2BB2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjKULZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbjKULZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:25:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E5CB;
        Tue, 21 Nov 2023 03:25:09 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALADlv8009338;
        Tue, 21 Nov 2023 11:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=hXqBWHYV6ydgL5DHeA5wPXVIA1ckcOxqeCpk/WOpPLI=;
 b=RWUmjOWSA/VUAEWhIboXzhTn5d+MLR6vIurx2xySZFVKJCpLOOiRYLkD+9pg7Sssvt85
 JbziITow/k7zM+q6G80AEFCPjzIRBssOPskan+Mu7q7qQ+Fl82g+U0jSJSiCBooBGToE
 uMNt4epvmnDRzhKTmC/9tZQidCn67reNDpSZoeEFp65igllHdSf7a9uzxA7qGXrQyk11
 k84x9NelcRCFgk3l0xlKq1Wayoh5TCVfjuFVCYBCBsNGyLmUN0OZzXDD2ePAIjsTmvE3
 Scbh1q4H9KHyDYIATFgoiKyc3KHe2yv5yYObynzBZMRPH3Yk/XGfQVKCXESF2LYyrGto iQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugk6x17qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:25:07 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALBP6KC006518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:25:06 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 03:25:04 -0800
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/5] misc: fastrpc: Add early wakeup support for fastRPC driver
Date:   Tue, 21 Nov 2023 16:54:50 +0530
Message-ID: <20231121112454.12764-2-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121112454.12764-1-quic_ekangupt@quicinc.com>
References: <20231121112454.12764-1-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hK7O_6cegwvMyfduVgZuqqsXvBX6JnHO
X-Proofpoint-ORIG-GUID: hK7O_6cegwvMyfduVgZuqqsXvBX6JnHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_04,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU wake up and context switch latency are significant in FastRPC
overhead for remote calls. As part of this change, DSP sends early
signal of completion to CPU and FastRPC driver detects early signal
on the given context and starts polling on a memory for actual
completion. Multiple different response flags are added to support
DSP user early hint of approximate time of completion, early response
from DSP user to wake up CPU and poll on memory for actual completion.
Complete signal is also added which is sent by DSP user in case of
timeout after early response is sent.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v3:
  - Rebase the patch to latest kernel version

 drivers/misc/fastrpc.c | 265 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 252 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8e77beb3a693..6b6ac3e3328d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -106,6 +106,19 @@
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
+#define FASTRPC_RSP_VERSION2 2
+/* Early wake up poll completion number received from remoteproc */
+#define FASTRPC_EARLY_WAKEUP_POLL (0xabbccdde)
+/* timeout in us for polling until memory barrier */
+#define FASTRPC_POLL_TIME_MEM_UPDATE (500)
+/* timeout in us for busy polling after early response from remoteproc */
+#define FASTRPC_POLL_TIME (4000)
+/* timeout in us for polling completion signal after user early hint */
+#define FASTRPC_USER_EARLY_HINT_TIMEOUT (500)
+/* CPU feature information to DSP */
+#define FASTRPC_CPUINFO_DEFAULT (0)
+#define FASTRPC_CPUINFO_EARLY_WAKEUP (1)
+
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 #define PERF_END ((void)0)
@@ -129,6 +142,15 @@
 			(uint64_t *)(perf_ptr + offset)\
 				: (uint64_t *)NULL) : (uint64_t *)NULL)
 
+enum fastrpc_response_flags {
+	NORMAL_RESPONSE = 0,
+	EARLY_RESPONSE = 1,
+	USER_EARLY_SIGNAL = 2,
+	COMPLETE_SIGNAL = 3,
+	STATUS_RESPONSE = 4,
+	POLL_MODE = 5,
+};
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -206,6 +228,14 @@ struct fastrpc_invoke_rsp {
 	int retval;		/* invoke return value */
 };
 
+struct fastrpc_invoke_rspv2 {
+	u64 ctx;		/* invoke caller context */
+	int retval;		/* invoke return value */
+	u32 flags;		/* early response flags */
+	u32 early_wake_time;	/* user hint in us */
+	u32 version;		/* version number */
+};
+
 struct fastrpc_buf_overlap {
 	u64 start;
 	u64 end;
@@ -272,11 +302,17 @@ struct fastrpc_invoke_ctx {
 	int pid;
 	int tgid;
 	u32 sc;
+	/* user hint of completion time in us */
+	u32 early_wake_time;
 	u32 *crc;
 	u64 *perf_kernel;
 	u64 *perf_dsp;
 	u64 ctxid;
 	u64 msg_sz;
+	/* work done status flag */
+	bool is_work_done;
+	/* response flags from remote processor */
+	enum fastrpc_response_flags rsp_flags;
 	struct kref refcount;
 	struct list_head node; /* list of ctxs */
 	struct completion work;
@@ -321,7 +357,9 @@ struct fastrpc_channel_ctx {
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
+	bool cpuinfo_status;
 	u64 dma_mask;
+	u64 cpuinfo_todsp;
 };
 
 struct fastrpc_device {
@@ -352,13 +390,21 @@ struct fastrpc_user {
 	struct mutex mutex;
 };
 
+struct fastrpc_ctrl_latency {
+	u32 enable;	/* latency control enable */
+	u32 latency;	/* latency request in us */
+};
+
 struct fastrpc_ctrl_smmu {
 	u32 sharedcb;	/* Set to SMMU share context bank */
 };
 
 struct fastrpc_internal_control {
 	u32 req;
-	struct fastrpc_ctrl_smmu smmu;
+	union {
+		struct fastrpc_ctrl_latency lp;
+		struct fastrpc_ctrl_smmu smmu;
+	};
 };
 
 static inline int64_t getnstimediff(struct timespec64 *start)
@@ -692,6 +738,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	ctx->pid = current->pid;
 	ctx->tgid = user->tgid;
 	ctx->cctx = cctx;
+	ctx->rsp_flags = NORMAL_RESPONSE;
+	ctx->is_work_done = false;
 	init_completion(&ctx->work);
 	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
 
@@ -1302,6 +1350,115 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx, u32 timeout)
+{
+	int err = -EIO, ii = 0, jj = 0;
+	u32 sc = ctx->sc;
+	struct fastrpc_invoke_buf *list;
+	struct fastrpc_phy_page *pages;
+	u64 *fdlist = NULL;
+	u32 *crclist = NULL, *poll = NULL;
+	unsigned int inbufs, outbufs, handles;
+
+	/* calculate poll memory location */
+	inbufs = REMOTE_SCALARS_INBUFS(sc);
+	outbufs = REMOTE_SCALARS_OUTBUFS(sc);
+	handles = REMOTE_SCALARS_INHANDLES(sc) + REMOTE_SCALARS_OUTHANDLES(sc);
+	list = fastrpc_invoke_buf_start(ctx->rpra, ctx->nscalars);
+	pages = fastrpc_phy_page_start(list, ctx->nscalars);
+	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
+	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
+	poll = (u32 *)(crclist + FASTRPC_MAX_CRCLIST);
+
+	/* poll on memory for DSP response. Return failure on timeout */
+	for (ii = 0, jj = 0; ii < timeout; ii++, jj++) {
+		if (*poll == FASTRPC_EARLY_WAKEUP_POLL) {
+			/* Remote processor sent early response */
+			err = 0;
+			break;
+		}
+		if (jj == FASTRPC_POLL_TIME_MEM_UPDATE) {
+			/* Wait for DSP to finish updating poll memory */
+			rmb();
+			jj = 0;
+		}
+		udelay(1);
+	}
+	return err;
+}
+
+static inline int fastrpc_wait_for_response(struct fastrpc_invoke_ctx *ctx,
+						u32 kernel)
+{
+	int interrupted = 0;
+
+	if (kernel)
+		wait_for_completion(&ctx->work);
+	else
+		interrupted = wait_for_completion_interruptible(&ctx->work);
+
+	return interrupted;
+}
+
+static void fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
+			int *ptr_interrupted, u32 kernel)
+{
+	int err = 0, jj = 0;
+	bool wait_resp = false;
+	u32 wTimeout = FASTRPC_USER_EARLY_HINT_TIMEOUT;
+	u32 wakeTime = ctx->early_wake_time;
+
+	do {
+		switch (ctx->rsp_flags) {
+		/* try polling on completion with timeout */
+		case USER_EARLY_SIGNAL:
+			/* try wait if completion time is less than timeout */
+			/* disable preempt to avoid context switch latency */
+			preempt_disable();
+			jj = 0;
+			wait_resp = false;
+			for (; wakeTime < wTimeout && jj < wTimeout; jj++) {
+				wait_resp = try_wait_for_completion(&ctx->work);
+				if (wait_resp)
+					break;
+				udelay(1);
+			}
+			preempt_enable();
+			if (!wait_resp) {
+				*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
+				if (*ptr_interrupted || ctx->is_work_done)
+					return;
+			}
+			break;
+		/* busy poll on memory for actual job done */
+		case EARLY_RESPONSE:
+			err = poll_for_remote_response(ctx, FASTRPC_POLL_TIME);
+			/* Mark job done if poll on memory successful */
+			/* Wait for completion if poll on memory timeout */
+			if (!err) {
+				ctx->is_work_done = true;
+				return;
+			}
+			if (!ctx->is_work_done) {
+				*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
+				if (*ptr_interrupted || ctx->is_work_done)
+					return;
+			}
+			break;
+		case COMPLETE_SIGNAL:
+		case NORMAL_RESPONSE:
+			*ptr_interrupted = fastrpc_wait_for_response(ctx, kernel);
+			if (*ptr_interrupted || ctx->is_work_done)
+				return;
+			break;
+		default:
+			*ptr_interrupted = -EBADR;
+			dev_err(ctx->fl->sctx->dev, "unsupported response type:0x%x\n", ctx->rsp_flags);
+			break;
+		}
+	} while (!ctx->is_work_done);
+}
+
 static void fastrpc_update_invoke_count(u32 handle, u64 *perf_counter,
 					struct timespec64 *invoket)
 {
@@ -1325,7 +1482,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	struct fastrpc_invoke *inv = &invoke->inv;
 	u32 handle, sc;
 	u64 *perf_counter = NULL;
-	int err = 0, perferr = 0;
+	int err = 0, perferr = 0, interrupted = 0;
 	struct timespec64 invoket = {0};
 
 	if (fl->profile)
@@ -1374,15 +1531,18 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	PERF_END);
 
 wait:
-	if (kernel) {
-		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
-			err = -ETIMEDOUT;
-	} else {
-		err = wait_for_completion_interruptible(&ctx->work);
+	fastrpc_wait_for_completion(ctx, &interrupted, kernel);
+	if (interrupted != 0) {
+		err = interrupted;
+		goto bail;
 	}
 
-	if (err)
+	if (!ctx->is_work_done) {
+		err = -ETIMEDOUT;
+		dev_err(fl->sctx->dev, "Error: Invalid workdone state for handle 0x%x, sc 0x%x\n",
+			handle, sc);
 		goto bail;
+	}
 
 	/* make sure that all memory writes by DSP are seen by CPU */
 	dma_rmb();
@@ -2056,6 +2216,36 @@ static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
 	return 0;
 }
 
+static int fastrpc_send_cpuinfo_to_dsp(struct fastrpc_user *fl)
+{
+	int err = 0;
+	u64 cpuinfo = 0;
+	struct fastrpc_invoke_args args[1];
+	struct fastrpc_enhanced_invoke ioctl;
+
+	if (!fl)
+		return -EBADF;
+
+	cpuinfo = fl->cctx->cpuinfo_todsp;
+	/* return success if already updated to remote processor */
+	if (fl->cctx->cpuinfo_status)
+		return 0;
+
+	args[0].ptr = (u64)(uintptr_t)&cpuinfo;
+	args[0].length = sizeof(cpuinfo);
+	args[0].fd = -1;
+
+	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(1, 1, 0);
+	ioctl.inv.args = (__u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
+	if (!err)
+		fl->cctx->cpuinfo_status = true;
+
+	return err;
+}
+
 static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_ioctl_capability cap = {0};
@@ -2407,6 +2597,8 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
 		err = fastrpc_init_attach(fl, ROOT_PD);
+		if (!err)
+			fastrpc_send_cpuinfo_to_dsp(fl);
 		break;
 	case FASTRPC_IOCTL_INIT_ATTACH_SNS:
 		err = fastrpc_init_attach(fl, SENSORS_PD);
@@ -2627,6 +2819,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		err = fastrpc_device_register(rdev, data, secure_dsp, domains[domain_id]);
 		if (err)
 			goto fdev_error;
+		data->cpuinfo_todsp = FASTRPC_CPUINFO_DEFAULT;
 		break;
 	case CDSP_DOMAIN_ID:
 		data->unsigned_support = true;
@@ -2638,6 +2831,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		err = fastrpc_device_register(rdev, data, false, domains[domain_id]);
 		if (err)
 			goto fdev_error;
+		data->cpuinfo_todsp = FASTRPC_CPUINFO_EARLY_WAKEUP;
 		break;
 	default:
 		err = -EINVAL;
@@ -2680,10 +2874,12 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 	spin_lock(&user->lock);
 	list_for_each_entry(ctx, &user->pending, node) {
 		ctx->retval = -EPIPE;
+		ctx->is_work_done = true;
 		complete(&ctx->work);
 	}
 	list_for_each_entry(ctx, &user->interrupted, node) {
 		ctx->retval = -EPIPE;
+		ctx->is_work_done = true;
 		complete(&ctx->work);
 	}
 	spin_unlock(&user->lock);
@@ -2720,31 +2916,74 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	fastrpc_channel_ctx_put(cctx);
 }
 
+static void fastrpc_notify_user_ctx(struct fastrpc_invoke_ctx *ctx, int retval,
+		u32 rsp_flags, u32 early_wake_time)
+{
+	ctx->retval = retval;
+	ctx->rsp_flags = (enum fastrpc_response_flags)rsp_flags;
+	switch (rsp_flags) {
+	case NORMAL_RESPONSE:
+	case COMPLETE_SIGNAL:
+		/* normal and complete response with return value */
+		ctx->is_work_done = true;
+		complete(&ctx->work);
+		break;
+	case USER_EARLY_SIGNAL:
+		/* user hint of approximate time of completion */
+		ctx->early_wake_time = early_wake_time;
+		break;
+	case EARLY_RESPONSE:
+		/* rpc framework early response with return value */
+		complete(&ctx->work);
+		break;
+	default:
+		break;
+	}
+}
+
 static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 				  int len, void *priv, u32 addr)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
 	struct fastrpc_invoke_rsp *rsp = data;
+	struct fastrpc_invoke_rspv2 *rspv2 = NULL;
 	struct fastrpc_invoke_ctx *ctx;
 	unsigned long flags;
 	unsigned long ctxid;
+	u32 rsp_flags = 0;
+	u32 early_wake_time = 0;
 
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (len >= sizeof(*rspv2)) {
+		rspv2 = data;
+		if (rspv2) {
+			early_wake_time = rspv2->early_wake_time;
+			rsp_flags = rspv2->flags;
+		}
+	}
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
 	ctx = idr_find(&cctx->ctx_idr, ctxid);
-	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (!ctx) {
-		dev_err(&rpdev->dev, "No context ID matches response\n");
-		return -ENOENT;
+		dev_info(&cctx->rpdev->dev, "Warning: No context ID matches response\n");
+		spin_unlock_irqrestore(&cctx->lock, flags);
+		return 0;
 	}
 
-	ctx->retval = rsp->retval;
-	complete(&ctx->work);
+	if (rspv2) {
+		if (rspv2->version != FASTRPC_RSP_VERSION2) {
+			dev_err(&cctx->rpdev->dev, "Incorrect response version %d\n", rspv2->version);
+			spin_unlock_irqrestore(&cctx->lock, flags);
+			return -EINVAL;
+		}
+	}
+	fastrpc_notify_user_ctx(ctx, rsp->retval, rsp_flags, early_wake_time);
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	/*
 	 * The DMA buffer associated with the context cannot be freed in
-- 
2.17.1

