Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8F07D7EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZIyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbjJZIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:53:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F167D40;
        Thu, 26 Oct 2023 01:53:35 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q68Tlj018118;
        Thu, 26 Oct 2023 08:53:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=YYg37Z+HWnxd5NbFU77UTDKZHVf/xL6hkbxOk4xI+Ec=;
 b=aJcm8a/lCRwgLNvjOxfOMrobny2ikEbdkCc+jHdzw1d/vNoPQRQ8uDZiCL0yeayt1eje
 vz55OD47vUhQn+lLSHLj+QZW0+4dAD4+YO57O6LUQpUA/at5g7D3XCHHFV26V7+bsv5O
 0TmZFfWEx15DkePlHdnDcn66MqhqKTd8Wi2JZhWaV96Qh8d+ODXHk+iAcJSpq/CpWSnE
 mSfa5I1aAxjdyQi/420ljZGVvnXPWcOB0U4mc4HCtPbdpg9I77TWHBJAxvchikP+zcXO
 NqNZ8qSiKUifLGrcVOdEYKVaq9/btGhLFsKYVfdnrFgCT/VUizqOk2iK2mYw7gtYlztP Kg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyhqngeyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:53:32 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q8rWq6022798
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:53:32 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 01:53:30 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] misc: fastrpc: Add DSP PD notification support
Date:   Thu, 26 Oct 2023 14:23:19 +0530
Message-ID: <1698310400-5601-4-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698310400-5601-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1698310400-5601-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JB7RP50xqOimKSzUeA4TXfFIc54w0YAl
X-Proofpoint-GUID: JB7RP50xqOimKSzUeA4TXfFIc54w0YAl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_06,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310260074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver design does not provide any notification regarding
the status of used PD on DSP. Only when user makes a FastRPC
invocation, they get to know if the process has been killed on
DSP. Notifying status of user PD can help users to restart the
DSP PD session.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v2:
  - Added Co-developer tag

 drivers/misc/fastrpc.c      | 145 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/misc/fastrpc.h |   8 +++
 2 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 45373bf..e012ff25 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -120,6 +120,8 @@
 /* CPU feature information to DSP */
 #define FASTRPC_CPUINFO_DEFAULT (0)
 #define FASTRPC_CPUINFO_EARLY_WAKEUP (1)
+/* Process status notifications from DSP will be sent with this unique context */
+#define FASTRPC_NOTIF_CTX_RESERVED 0xABCDABCD
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
@@ -238,6 +240,13 @@ struct fastrpc_invoke_rspv2 {
 	u32 version;		/* version number */
 };
 
+struct dsp_notif_rsp {
+	u64 ctx;		/* response context */
+	u32 type;		/* Notification type */
+	int pid;		/* user process pid */
+	u32 status;		/* userpd status notification */
+};
+
 struct fastrpc_buf_overlap {
 	u64 start;
 	u64 end;
@@ -297,6 +306,27 @@ struct fastrpc_perf {
 	u64 tid;
 };
 
+struct fastrpc_notif_queue {
+	/* Number of pending status notifications in queue */
+	atomic_t notif_queue_count;
+	/* Wait queue to synchronize notifier thread and response */
+	wait_queue_head_t notif_wait_queue;
+	/* IRQ safe spin lock for protecting notif queue */
+	spinlock_t nqlock;
+};
+
+struct fastrpc_internal_notif_rsp {
+	u32 domain;		/* Domain of User PD */
+	u32 session;	/* Session ID of User PD */
+	u32 status;		/* Status of the process */
+};
+
+struct fastrpc_notif_rsp {
+	struct list_head notifn;
+	u32 domain;
+	enum fastrpc_status_flags status;
+};
+
 struct fastrpc_invoke_ctx {
 	int nscalars;
 	int nbufs;
@@ -376,10 +406,13 @@ struct fastrpc_user {
 	struct list_head pending;
 	struct list_head interrupted;
 	struct list_head mmaps;
+	struct list_head notif_queue;
 
 	struct fastrpc_channel_ctx *cctx;
 	struct fastrpc_session_ctx *sctx;
 	struct fastrpc_buf *init_mem;
+	/* Process status notification queue */
+	struct fastrpc_notif_queue proc_state_notif;
 
 	u32 profile;
 	/* Threads poll for specified timeout and fall back to glink wait */
@@ -2085,6 +2118,99 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	return err;
 }
 
+static void fastrpc_queue_pd_status(struct fastrpc_user *fl, int domain, int status)
+{
+	struct fastrpc_notif_rsp *notif_rsp = NULL;
+	unsigned long flags;
+
+	notif_rsp = kzalloc(sizeof(*notif_rsp), GFP_ATOMIC);
+	if (!notif_rsp)
+		return;
+
+	notif_rsp->status = status;
+	notif_rsp->domain = domain;
+
+	spin_lock_irqsave(&fl->proc_state_notif.nqlock, flags);
+	list_add_tail(&notif_rsp->notifn, &fl->notif_queue);
+	atomic_add(1, &fl->proc_state_notif.notif_queue_count);
+	wake_up_interruptible(&fl->proc_state_notif.notif_wait_queue);
+	spin_unlock_irqrestore(&fl->proc_state_notif.nqlock, flags);
+}
+
+static void fastrpc_notif_find_process(int domain, struct fastrpc_channel_ctx *cctx, struct dsp_notif_rsp *notif)
+{
+	bool is_process_found = false;
+	unsigned long irq_flags = 0;
+	struct fastrpc_user *user;
+
+	spin_lock_irqsave(&cctx->lock, irq_flags);
+	list_for_each_entry(user, &cctx->users, user) {
+		if (user->tgid == notif->pid) {
+			is_process_found = true;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&cctx->lock, irq_flags);
+
+	if (!is_process_found)
+		return;
+	fastrpc_queue_pd_status(user, domain, notif->status);
+}
+
+static int fastrpc_wait_on_notif_queue(
+			struct fastrpc_internal_notif_rsp *notif_rsp,
+			struct fastrpc_user *fl)
+{
+	int err = 0;
+	unsigned long flags;
+	struct fastrpc_notif_rsp *notif, *inotif, *n;
+
+read_notif_status:
+	err = wait_event_interruptible(fl->proc_state_notif.notif_wait_queue,
+				atomic_read(&fl->proc_state_notif.notif_queue_count));
+	if (err) {
+		kfree(notif);
+		return err;
+	}
+
+	spin_lock_irqsave(&fl->proc_state_notif.nqlock, flags);
+	list_for_each_entry_safe(inotif, n, &fl->notif_queue, notifn) {
+		list_del(&inotif->notifn);
+		atomic_sub(1, &fl->proc_state_notif.notif_queue_count);
+		notif = inotif;
+		break;
+	}
+	spin_unlock_irqrestore(&fl->proc_state_notif.nqlock, flags);
+
+	if (notif) {
+		notif_rsp->status = notif->status;
+		notif_rsp->domain = notif->domain;
+	} else {// Go back to wait if ctx is invalid
+		dev_err(fl->sctx->dev, "Invalid status notification response\n");
+		goto read_notif_status;
+	}
+
+	kfree(notif);
+	return err;
+}
+
+static int fastrpc_get_notif_response(
+			struct fastrpc_internal_notif_rsp *notif,
+			void *param, struct fastrpc_user *fl)
+{
+	int err = 0;
+
+	err = fastrpc_wait_on_notif_queue(notif, fl);
+	if (err)
+		return err;
+
+	if (copy_to_user((void __user *)param, notif,
+			sizeof(struct fastrpc_internal_notif_rsp)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int fastrpc_manage_poll_mode(struct fastrpc_user *fl, u32 enable, u32 timeout)
 {
 	const unsigned int MAX_POLL_TIMEOUT_US = 10000;
@@ -2141,6 +2267,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_invoke_args *args = NULL;
 	struct fastrpc_ioctl_multimode_invoke invoke;
 	struct fastrpc_internal_control cp = {0};
+	struct fastrpc_internal_notif_rsp notif;
 	u32 nscalars;
 	u64 *perf_kernel;
 	int err, i;
@@ -2190,6 +2317,10 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 
 		err = fastrpc_internal_control(fl, &cp);
 		break;
+	case FASTRPC_INVOKE_NOTIF:
+		err = fastrpc_get_notif_response(&notif,
+					(void *)invoke.invparam, fl);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
@@ -2942,8 +3073,10 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
-	list_for_each_entry(user, &cctx->users, user)
+	list_for_each_entry(user, &cctx->users, user) {
+		fastrpc_queue_pd_status(user, cctx->domain_id, FASTRPC_DSP_SSR);
 		fastrpc_notify_users(user);
+	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (cctx->fdevice)
@@ -2994,12 +3127,22 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
 	struct fastrpc_invoke_rsp *rsp = data;
 	struct fastrpc_invoke_rspv2 *rspv2 = NULL;
+	struct dsp_notif_rsp *notif = (struct dsp_notif_rsp *)data;
 	struct fastrpc_invoke_ctx *ctx;
 	unsigned long flags;
 	unsigned long ctxid;
 	u32 rsp_flags = 0;
 	u32 early_wake_time = 0;
 
+	if (notif->ctx == FASTRPC_NOTIF_CTX_RESERVED) {
+		if (notif->type == STATUS_RESPONSE && len >= sizeof(*notif)) {
+			fastrpc_notif_find_process(cctx->domain_id, cctx, notif);
+			return 0;
+		} else {
+			return -ENOENT;
+		}
+	}
+
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 3dfd8e9..1f544a3 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -192,4 +192,12 @@ enum fastrpc_perfkeys {
 	PERF_KEY_MAX = 10,
 };
 
+enum fastrpc_status_flags {
+	FASTRPC_USERPD_UP			= 0,
+	FASTRPC_USERPD_EXIT			= 1,
+	FASTRPC_USERPD_FORCE_KILL	= 2,
+	FASTRPC_USERPD_EXCEPTION	= 3,
+	FASTRPC_DSP_SSR				= 4,
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.7.4

