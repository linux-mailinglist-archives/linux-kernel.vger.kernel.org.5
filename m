Return-Path: <linux-kernel+bounces-49288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A547584683E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87D71C2314E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C453399C;
	Fri,  2 Feb 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ho080c1n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD001B270;
	Fri,  2 Feb 2024 06:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856077; cv=none; b=nVrA6ypHmqRnExqsFhFyS3ejOtwYFlWy9bR6KUzAsNmpxi2ttR8ugcUK66fBe8vpPre7s1PK3DcQAwQsY8kd1AK2PothN2ZEvFNL/c+F1TMBlUoIK6KIXb/ZLi3CXh0lKoPCnXAsm1egtHtaKj9lqUh86guXMIjizGkfcw1hRXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856077; c=relaxed/simple;
	bh=4bnnNMYYYlB/cbIX2lYhws2/CHK4wfi5gAQ7sg8tPt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWt2zagSzo0hOgmMtyjEGwPtf8TnqdAsx3/OTcq9LcWvzP5XKzjDxCKJgtCdQBW9m/oQNbEhHYRcWUlHcHPGQ5/xpAIBQ+dRwr0A3rbeqL8na//+gEcPyntLwf4m1F9sEeInsHU4+SQ6tVm1tg9/ERmOUBd0vJRRgOgwlvqOzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ho080c1n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4125FB4r028624;
	Fri, 2 Feb 2024 06:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=dmmCuWVG2ShrxZrY/6s3
	kX8rD27eOxSyusFWzsvSpqM=; b=Ho080c1njtj3jfqWPBl5+z5kE+RmtpXJYQVl
	aYX3OrYRjvaLteWJPkXtxYXRF27+SWWrv0uwiDywK8rl/+9CPNr+qHMt6IDtMuzH
	TmWOYyHxJUNJdfWLeRvuoWD1S46D6wHjGNFqsR6DiyWKwWtYupeHugegl4iZDWMR
	zuyXjHYhBjAsjZ3cTMbU8W+B9xLhE1Mws9iOJ5jlMjZ7+U6Y5QffFv+zeT1p4L8c
	FB4DzznLO1cBzZek04L49bTXhQnkg9hb8Y1S5g1S8qu8wctT9Py4uj7QBxjNmh94
	jYyot98PJjbUQdUcb+CSg9QLew6vseMl9vURQsakfNQuTAbz9g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1rndv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fDaf002584
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:13 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:11 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 11/16] misc: fastrpc: Add DSP PD notification support
Date: Fri, 2 Feb 2024 12:10:34 +0530
Message-ID: <20240202064039.15505-12-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RCcKHZek-LUR4kHTf-pRE6tjgaAXBH_D
X-Proofpoint-ORIG-GUID: RCcKHZek-LUR4kHTf-pRE6tjgaAXBH_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Current driver design does not provide any notification regarding
the status of used PD on DSP. Only when user makes a FastRPC
invocation, they get to know if the process has been killed on
DSP. Notifying status of user PD can help users to restart the
DSP PD session.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 139 +++++++++++++++++++++++++++++++++++-
 include/uapi/misc/fastrpc.h |  14 ++++
 2 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 296ddae0ef7c..d4a4ad54a5c9 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -122,6 +122,8 @@
 /* CPU feature information to DSP */
 #define FASTRPC_CPUINFO_DEFAULT (0)
 #define FASTRPC_CPUINFO_EARLY_WAKEUP (1)
+/* Process status notifications from DSP will be sent with this unique context */
+#define FASTRPC_NOTIF_CTX_RESERVED 0xABCDABCD
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
@@ -264,6 +266,13 @@ struct fastrpc_invoke_rspv2 {
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
@@ -324,6 +333,21 @@ struct fastrpc_perf {
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
+struct fastrpc_notif_rsp {
+	struct list_head notifn;
+	u32 domain;
+	enum fastrpc_status_flags status;
+};
+
 struct fastrpc_invoke_ctx {
 	int nscalars;
 	int nbufs;
@@ -414,10 +438,13 @@ struct fastrpc_user {
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
@@ -2196,6 +2223,99 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
@@ -2253,6 +2373,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_invoke_args *args = NULL;
 	struct fastrpc_ioctl_multimode_invoke invoke;
 	struct fastrpc_internal_control cp = {0};
+	struct fastrpc_internal_notif_rsp notif;
 	u32 nscalars;
 	u64 *perf_kernel;
 	int err, i;
@@ -2302,6 +2423,10 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 
 		err = fastrpc_internal_control(fl, &cp);
 		break;
+	case FASTRPC_INVOKE_NOTIF:
+		err = fastrpc_get_notif_response(&notif,
+					(void *)invoke.invparam, fl);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
@@ -3278,8 +3403,10 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	cctx->rpdev = NULL;
 	cctx->staticpd_status = false;
 	fastrpc_mmap_remove_ssr(cctx);
-	list_for_each_entry(user, &cctx->users, user)
+	list_for_each_entry(user, &cctx->users, user) {
+		fastrpc_queue_pd_status(user, cctx->domain_id, FASTRPC_DSP_SSR);
 		fastrpc_notify_users(user);
+	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	if (cctx->domain_id == ADSP_DOMAIN_ID) {
@@ -3331,12 +3458,22 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
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
index b4959cc4d254..a3bc6666a653 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -195,6 +195,12 @@ struct fastrpc_internal_control {
 	};
 };
 
+struct fastrpc_internal_notif_rsp {
+	u32 domain;		/* Domain of User PD */
+	u32 session;	/* Session ID of User PD */
+	u32 status;		/* Status of the process */
+};
+
 enum fastrpc_perfkeys {
 	PERF_COUNT = 0,
 	PERF_FLUSH = 1,
@@ -209,4 +215,12 @@ enum fastrpc_perfkeys {
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
2.17.0


