Return-Path: <linux-kernel+bounces-49291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE38846845
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E17A31C23793
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E624A47F70;
	Fri,  2 Feb 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TcmBwT3M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596942AB7;
	Fri,  2 Feb 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856084; cv=none; b=sHMScPGXYiEnKJcSxsw3kKHHZg9XkjPxak/CBPMvUjx6MWbyWJe71nn3GNcEdbJPw57HQcDS5TTesdMhrdRYfm9LMW4fFBerOeAVO0Aqg24SpAA7Eil/TAH8hV5HZ84w/NqIqav0jfu3w5iQoHzxgxD60kZP6sy1T6XVRNL0tpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856084; c=relaxed/simple;
	bh=JL0DIv+VF9YRGSN9do61lVc5IDaNIsYbdQOYrCPKYmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNNGubF1qPyqGAnVLn0htpbc4Cf8AR+1kSbtaNH7qwQXubK/npuRNb+ZPOfpUJft5muoHLyGXMh9tA9nBXGXBEvApY+b3gtjbuZbaKu77XO6f5vNlPYO4HnSJA8e5cDE2uvW3msh/GVXe1SukSQDVy2VrXEoVFcUVjL2gG46Cbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TcmBwT3M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124F1FC010830;
	Fri, 2 Feb 2024 06:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Qlbhx7H2XDYQRwGKn2D4
	ycN1Eozp5p4+oSgz4em7FHw=; b=TcmBwT3M40UlJt5SjUkrYNX1BOB0rVrsoAFn
	rLBevsp2FdzkABnV3JcF43ofGpVxPHdLQECJbbNJz3DmyfLe/E4I1ZDe6hSrXgYG
	KSLgZ/jLEoOIkck9u5BRTHUK3xLBWcATB87vitAogrH71rRm+hg0yPgAfqlEY4rS
	4YIBE9J6knLFReJFxYZ4zqIb5z0c5buVPASOqq8iVbh+O7vUu2E2LD9cZzyDjhOc
	uvrSmenk2Z7jzJBsrbhAE6tYcn3dbPFOTPYLvUCAPx4m9rqI4PycweGthCOYUDks
	6AdvDvUypckFnt4PmQkppx+Apppi53/0nxJPhNReRg7mOuqJfQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwjgmjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fJJk027603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:19 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:17 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 14/16] misc: fastrpc: Add DSP signal support
Date: Fri, 2 Feb 2024 12:10:37 +0530
Message-ID: <20240202064039.15505-15-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: YerLg_Qz1V2GIXQjGrs5Gchb4WNgeh4G
X-Proofpoint-ORIG-GUID: YerLg_Qz1V2GIXQjGrs5Gchb4WNgeh4G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 phishscore=0 mlxlogscore=415
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020045

Add a dedicated signaling channel between fastrpc driver and DSP
root PD, with a new dsp signaling interface between the userspace
framework and drivers. This makes dspqueue signaling latency
comparable to or better than synchronous FastRPC calls, and reduces
the processing overhead since the signaling code path is simpler than
synchronous FastRPC calls.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 307 +++++++++++++++++++++++++++++++++++-
 include/uapi/misc/fastrpc.h |  17 ++
 2 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 2b24d1f96978..0308f717456f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -144,6 +144,10 @@
 #define SENSORS_PDR_SLPI_SERVICE_NAME            SENSORS_PDR_ADSP_SERVICE_NAME
 #define SLPI_SENSORPD_NAME                       "msm/slpi/sensor_pd"
 
+#define FASTRPC_DSPSIGNAL_TIMEOUT_NONE 0xffffffff
+#define FASTRPC_DSPSIGNAL_NUM_SIGNALS 1024
+#define FASTRPC_DSPSIGNAL_GROUP_SIZE 256
+
 #define PERF_END ((void)0)
 
 #define PERF(enb, cnt, ff) \
@@ -470,8 +474,25 @@ struct fastrpc_user {
 	char *servloc_name;
 	/* Lock for lists */
 	spinlock_t lock;
+	/* lock for dsp signals */
+	spinlock_t dspsignals_lock;
 	/* lock for allocations */
 	struct mutex mutex;
+	struct mutex signal_create_mutex;
+	/* Completion objects and state for dspsignals */
+	struct fastrpc_dspsignal *signal_groups[FASTRPC_DSPSIGNAL_NUM_SIGNALS / FASTRPC_DSPSIGNAL_GROUP_SIZE];
+};
+
+enum fastrpc_dspsignal_state {
+	DSPSIGNAL_STATE_UNUSED = 0,
+	DSPSIGNAL_STATE_PENDING,
+	DSPSIGNAL_STATE_SIGNALED,
+	DSPSIGNAL_STATE_CANCELED,
+};
+
+struct fastrpc_dspsignal {
+	struct completion comp;
+	int state;
 };
 
 static inline int64_t getnstimediff(struct timespec64 *start)
@@ -2098,6 +2119,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 	unsigned long flags;
+	int i;
 
 	fastrpc_release_current_dsp_process(fl);
 
@@ -2122,6 +2144,10 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	fastrpc_session_free(cctx, fl->sctx);
 	fastrpc_channel_ctx_put(cctx);
 
+	for (i = 0; i < (FASTRPC_DSPSIGNAL_NUM_SIGNALS / FASTRPC_DSPSIGNAL_GROUP_SIZE); i++)
+		kfree(fl->signal_groups[i]);
+
+	mutex_destroy(&fl->signal_create_mutex);
 	mutex_destroy(&fl->mutex);
 	kfree(fl);
 	file->private_data = NULL;
@@ -2149,6 +2175,8 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	filp->private_data = fl;
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
+	spin_lock_init(&fl->dspsignals_lock);
+	mutex_init(&fl->signal_create_mutex);
 	INIT_LIST_HEAD(&fl->pending);
 	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
@@ -2439,12 +2467,235 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	return err;
 }
 
+static int fastrpc_dspsignal_signal(struct fastrpc_user *fl,
+			     struct fastrpc_internal_dspsignal *fsig)
+{
+	int err = 0;
+	struct fastrpc_channel_ctx *cctx = NULL;
+	u64 msg = 0;
+	u32 signal_id = fsig->signal_id;
+
+	cctx = fl->cctx;
+
+	if (!(signal_id < FASTRPC_DSPSIGNAL_NUM_SIGNALS))
+		return -EINVAL;
+
+	msg = (((uint64_t)fl->tgid) << 32) | ((uint64_t)fsig->signal_id);
+	err = rpmsg_send(cctx->rpdev->ept, (void *)&msg, sizeof(msg));
+
+	return err;
+}
+
+static int fastrpc_dspsignal_wait(struct fastrpc_user *fl,
+			     struct fastrpc_internal_dspsignal *fsig)
+{
+	int err = 0;
+	unsigned long timeout = usecs_to_jiffies(fsig->timeout_usec);
+	u32 signal_id = fsig->signal_id;
+	struct fastrpc_dspsignal *s = NULL;
+	long ret = 0;
+	unsigned long irq_flags = 0;
+
+	if (!(signal_id < FASTRPC_DSPSIGNAL_NUM_SIGNALS))
+		return -EINVAL;
+
+	spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+	if (fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE] != NULL) {
+		struct fastrpc_dspsignal *group =
+			fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE];
+
+		s = &group[signal_id % FASTRPC_DSPSIGNAL_GROUP_SIZE];
+	}
+	if ((s == NULL) || (s->state == DSPSIGNAL_STATE_UNUSED)) {
+		spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+		dev_err(&fl->cctx->rpdev->dev, "Unknown signal id %u\n", signal_id);
+		return -ENOENT;
+	}
+	if (s->state != DSPSIGNAL_STATE_PENDING) {
+		if ((s->state == DSPSIGNAL_STATE_CANCELED) || (s->state == DSPSIGNAL_STATE_UNUSED))
+			err = -EINTR;
+		spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+		dev_dbg(&fl->cctx->rpdev->dev, "Signal %u in state %u, complete wait immediately",
+				signal_id, s->state);
+		return err;
+	}
+	spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+
+	if (timeout != 0xffffffff)
+		ret = wait_for_completion_interruptible_timeout(&s->comp, timeout);
+	else
+		ret = wait_for_completion_interruptible(&s->comp);
+
+	if (ret == 0) {
+		dev_dbg(&fl->cctx->rpdev->dev, "Wait for signal %u timed out\n", signal_id);
+		return -ETIMEDOUT;
+	} else if (ret < 0) {
+		dev_err(&fl->cctx->rpdev->dev, "Wait for signal %u failed %d\n", signal_id, (int)ret);
+		return ret;
+	}
+
+	spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+	if (s->state == DSPSIGNAL_STATE_SIGNALED) {
+		s->state = DSPSIGNAL_STATE_PENDING;
+	} else if ((s->state == DSPSIGNAL_STATE_CANCELED) || (s->state == DSPSIGNAL_STATE_UNUSED)) {
+		dev_err(&fl->cctx->rpdev->dev, "Signal %u cancelled or destroyed\n", signal_id);
+		err = -EINTR;
+	}
+	spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+
+	return err;
+}
+
+static int fastrpc_dspsignal_create(struct fastrpc_user *fl,
+			     struct fastrpc_internal_dspsignal *fsig)
+{
+	int err = 0;
+	u32 signal_id = fsig->signal_id;
+	struct fastrpc_dspsignal *group, *sig;
+	unsigned long irq_flags = 0;
+
+	if (!(signal_id < FASTRPC_DSPSIGNAL_NUM_SIGNALS))
+		return -EINVAL;
+
+	mutex_lock(&fl->signal_create_mutex);
+	spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+
+	group = fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE];
+	if (group == NULL) {
+		int i;
+
+		spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+		group = kcalloc(FASTRPC_DSPSIGNAL_GROUP_SIZE, sizeof(*group),
+					     GFP_KERNEL);
+		if (group == NULL) {
+			mutex_unlock(&fl->signal_create_mutex);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < FASTRPC_DSPSIGNAL_GROUP_SIZE; i++) {
+			sig = &group[i];
+			init_completion(&sig->comp);
+			sig->state = DSPSIGNAL_STATE_UNUSED;
+		}
+		spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+		fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE] = group;
+	}
+
+	sig = &group[signal_id % FASTRPC_DSPSIGNAL_GROUP_SIZE];
+	if (sig->state != DSPSIGNAL_STATE_UNUSED) {
+		spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+		mutex_unlock(&fl->signal_create_mutex);
+		dev_err(&fl->cctx->rpdev->dev, "Attempting to create signal %u already in use (state %u)\n",
+			    signal_id, sig->state);
+		return -EBUSY;
+	}
+
+	sig->state = DSPSIGNAL_STATE_PENDING;
+	reinit_completion(&sig->comp);
+
+	spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+	mutex_unlock(&fl->signal_create_mutex);
+
+	return err;
+}
+
+static int fastrpc_dspsignal_destroy(struct fastrpc_user *fl,
+			      struct fastrpc_internal_dspsignal *fsig)
+{
+	u32 signal_id = fsig->signal_id;
+	struct fastrpc_dspsignal *s = NULL;
+	unsigned long irq_flags = 0;
+
+	if (!(signal_id < FASTRPC_DSPSIGNAL_NUM_SIGNALS))
+		return -EINVAL;
+
+	spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+
+	if (fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE] != NULL) {
+		struct fastrpc_dspsignal *group =
+			fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE];
+
+		s = &group[signal_id % FASTRPC_DSPSIGNAL_GROUP_SIZE];
+	}
+	if ((s == NULL) || (s->state == DSPSIGNAL_STATE_UNUSED)) {
+		spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+		dev_err(&fl->cctx->rpdev->dev, "Attempting to destroy unused signal %u\n", signal_id);
+		return -ENOENT;
+	}
+
+	s->state = DSPSIGNAL_STATE_UNUSED;
+	complete_all(&s->comp);
+
+	spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+
+	return 0;
+}
+
+static int fastrpc_dspsignal_cancel_wait(struct fastrpc_user *fl,
+				  struct fastrpc_internal_dspsignal *fsig)
+{
+	u32 signal_id = fsig->signal_id;
+	struct fastrpc_dspsignal *s = NULL;
+	unsigned long irq_flags = 0;
+
+	if (!(signal_id < FASTRPC_DSPSIGNAL_NUM_SIGNALS))
+		return -EINVAL;
+
+	spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+
+	if (fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE] != NULL) {
+		struct fastrpc_dspsignal *group =
+			fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE];
+
+		s = &group[signal_id % FASTRPC_DSPSIGNAL_GROUP_SIZE];
+	}
+	if ((s == NULL) || (s->state == DSPSIGNAL_STATE_UNUSED)) {
+		spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+		dev_err(&fl->cctx->rpdev->dev, "Attempting to cancel unused signal %u\n", signal_id);
+		return -ENOENT;
+	}
+
+	if (s->state != DSPSIGNAL_STATE_CANCELED) {
+		s->state = DSPSIGNAL_STATE_CANCELED;
+		complete_all(&s->comp);
+	}
+
+	spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+
+	return 0;
+}
+
+static int fastrpc_invoke_dspsignal(struct fastrpc_user *fl, struct fastrpc_internal_dspsignal *fsig)
+{
+	int err = 0;
+
+	switch (fsig->req) {
+	case FASTRPC_DSPSIGNAL_SIGNAL:
+		err = fastrpc_dspsignal_signal(fl, fsig);
+		break;
+	case FASTRPC_DSPSIGNAL_WAIT:
+		err = fastrpc_dspsignal_wait(fl, fsig);
+		break;
+	case FASTRPC_DSPSIGNAL_CREATE:
+		err = fastrpc_dspsignal_create(fl, fsig);
+		break;
+	case FASTRPC_DSPSIGNAL_DESTROY:
+		err = fastrpc_dspsignal_destroy(fl, fsig);
+		break;
+	case FASTRPC_DSPSIGNAL_CANCEL_WAIT:
+		err = fastrpc_dspsignal_cancel_wait(fl, fsig);
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
 	struct fastrpc_internal_control cp = {0};
+	struct fastrpc_internal_dspsignal *fsig = NULL;
 	struct fastrpc_internal_notif_rsp notif;
 	u32 nscalars;
 	u64 *perf_kernel;
@@ -2465,7 +2716,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 	case FASTRPC_INVOKE_ENHANCED:
 		/* nscalars is truncated here to max supported value */
 		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
-				   invoke.size))
+				   sizeof(struct fastrpc_enhanced_invoke)))
 			return -EFAULT;
 		for (i = 0; i < 8; i++) {
 			if (einv.reserved[i] != 0)
@@ -2495,6 +2746,19 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 
 		err = fastrpc_internal_control(fl, &cp);
 		break;
+	case FASTRPC_INVOKE_DSPSIGNAL:
+		if (invoke.size > sizeof(*fsig))
+			return -EINVAL;
+		fsig = kzalloc(invoke.size, GFP_KERNEL);
+		if (!fsig)
+			return -ENOMEM;
+		if (copy_from_user(fsig, (void __user *)(uintptr_t)invoke.invparam,
+				sizeof(*fsig))) {
+			kfree(fsig);
+			return -EFAULT;
+		}
+		err = fastrpc_invoke_dspsignal(fl, fsig);
+		break;
 	case FASTRPC_INVOKE_NOTIF:
 		err = fastrpc_get_notif_response(&notif,
 					(void *)invoke.invparam, fl);
@@ -3526,6 +3790,42 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	fastrpc_channel_ctx_put(cctx);
 }
 
+static void fastrpc_handle_signal_rpmsg(uint64_t msg, struct fastrpc_channel_ctx *cctx)
+{
+	u32 pid = msg >> 32;
+	u32 signal_id = msg & 0xffffffff;
+	struct fastrpc_user *fl;
+	unsigned long irq_flags = 0;
+
+	if (signal_id >= FASTRPC_DSPSIGNAL_NUM_SIGNALS)
+		return;
+
+	list_for_each_entry(fl, &cctx->users, user) {
+		if (fl->tgid == pid)
+			break;
+	}
+
+	spin_lock_irqsave(&fl->dspsignals_lock, irq_flags);
+	if (fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE]) {
+		struct fastrpc_dspsignal *group =
+			fl->signal_groups[signal_id / FASTRPC_DSPSIGNAL_GROUP_SIZE];
+		struct fastrpc_dspsignal *sig =
+			&group[signal_id % FASTRPC_DSPSIGNAL_GROUP_SIZE];
+		if ((sig->state == DSPSIGNAL_STATE_PENDING) ||
+			(sig->state == DSPSIGNAL_STATE_SIGNALED)) {
+			complete(&sig->comp);
+			sig->state = DSPSIGNAL_STATE_SIGNALED;
+		} else if (sig->state == DSPSIGNAL_STATE_UNUSED) {
+			pr_err("Received unknown signal %u for PID %u\n",
+					signal_id, pid);
+		}
+	} else {
+		pr_err("Received unknown signal %u for PID %u\n",
+				signal_id, pid);
+	}
+	spin_unlock_irqrestore(&fl->dspsignals_lock, irq_flags);
+}
+
 static void fastrpc_notify_user_ctx(struct fastrpc_invoke_ctx *ctx, int retval,
 		u32 rsp_flags, u32 early_wake_time)
 {
@@ -3564,6 +3864,11 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	u32 rsp_flags = 0;
 	u32 early_wake_time = 0;
 
+	if (len == sizeof(uint64_t)) {
+		fastrpc_handle_signal_rpmsg(*((uint64_t *)data), cctx);
+		return 0;
+	}
+
 	if (notif->ctx == FASTRPC_NOTIF_CTX_RESERVED) {
 		if (notif->type == STATUS_RESPONSE && len >= sizeof(*notif)) {
 			fastrpc_notif_find_process(cctx->domain_id, cctx, notif);
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f4c73f6774f7..7053a5b6b16b 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -211,6 +211,15 @@ struct fastrpc_internal_notif_rsp {
 	u32 status;		/* Status of the process */
 };
 
+struct fastrpc_internal_dspsignal {
+	u32 req;
+	u32 signal_id;
+	union {
+		u32 flags;
+		u32 timeout_usec;
+	};
+};
+
 enum fastrpc_perfkeys {
 	PERF_COUNT = 0,
 	PERF_FLUSH = 1,
@@ -225,6 +234,14 @@ enum fastrpc_perfkeys {
 	PERF_KEY_MAX = 10,
 };
 
+enum fastrpc_dspsignal_type {
+	FASTRPC_DSPSIGNAL_SIGNAL = 1,
+	FASTRPC_DSPSIGNAL_WAIT = 2,
+	FASTRPC_DSPSIGNAL_CREATE = 3,
+	FASTRPC_DSPSIGNAL_DESTROY = 4,
+	FASTRPC_DSPSIGNAL_CANCEL_WAIT = 5,
+};
+
 enum fastrpc_status_flags {
 	FASTRPC_USERPD_UP			= 0,
 	FASTRPC_USERPD_EXIT			= 1,
-- 
2.17.0


