Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E603B7F2D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234502AbjKULZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbjKULZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:25:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0603198;
        Tue, 21 Nov 2023 03:25:17 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALAInRS020652;
        Tue, 21 Nov 2023 11:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4uSpDpqIdJDEdclvtSRtkXQ/2JlMe2Zhe3mSiN9o5Wo=;
 b=G3vUffuVnJ6M6Q2+UQDF+21D0oGmxbY82Z1ZGM3gluGu77FV+hTN+W59PNj0nIN6XBCb
 ds+yObpPXNbFwqhwEO1hw/deyqjvtez2d+PtLi1K8TCZcwFxBqoxq//oUhYsXDLzlUJ+
 wDAqo9GRqgDu+cUiwcpYiUb/lU4xqgOxzwLyc5S0NjlFPgbSYCEYr5bFWMy73OscqWkw
 g9k+XFIoCIW3LxpD2TiYRGN+ZeUJSJFgM1vR7IcHFarGG9nfS+OTY/1pqJjQoqLfUBw2
 oNWZ+aMrt4zinD6DE4N+x4Ub7xmSRON7wV4riLRUIQW2Wi1tPMRq13aVb/D2iN1XiMtM pg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ugk6x17qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:25:16 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3ALBPFRo015851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 11:25:15 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 03:25:13 -0800
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/5] misc: fastrpc: Add wakelock management support
Date:   Tue, 21 Nov 2023 16:54:54 +0530
Message-ID: <20231121112454.12764-6-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: NnGGvhB7nGk8Z8DfTg1MFo-NxGEh-PFM
X-Proofpoint-ORIG-GUID: NnGGvhB7nGk8Z8DfTg1MFo-NxGEh-PFM
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

CPU can go into suspend mode at anytime. Users might have a
requirement to keep the CPU awake until they get a response for
their remote call to DSP. Wakelock management can be used to
achieve this requirement.

Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 104 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 97895fce1228..dcda287cd899 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -120,6 +120,11 @@
 /* CPU feature information to DSP */
 #define FASTRPC_CPUINFO_DEFAULT (0)
 #define FASTRPC_CPUINFO_EARLY_WAKEUP (1)
+
+/* Maximum PM timeout that can be voted through fastrpc */
+#define FASTRPC_MAX_PM_TIMEOUT_MS 50
+#define FASTRPC_NON_SECURE_WAKE_SOURCE_CLIENT_NAME	"fastrpc-non_secure"
+#define FASTRPC_SECURE_WAKE_SOURCE_CLIENT_NAME		"fastrpc-secure"
 /* Process status notifications from DSP will be sent with this unique context */
 #define FASTRPC_NOTIF_CTX_RESERVED 0xABCDABCD
 
@@ -387,6 +392,10 @@ struct fastrpc_channel_ctx {
 	struct fastrpc_device *fdevice;
 	struct fastrpc_buf *remote_heap;
 	struct list_head invoke_interrupted_mmaps;
+	/* Secure subsystems like ADSP/SLPI will use secure client */
+	struct wakeup_source *wake_source_secure;
+	/* Non-secure subsystem like CDSP will use regular client */
+	struct wakeup_source *wake_source;
 	bool secure;
 	bool unsigned_support;
 	bool cpuinfo_status;
@@ -417,6 +426,8 @@ struct fastrpc_user {
 	u32 profile;
 	/* Threads poll for specified timeout and fall back to glink wait */
 	u32 poll_timeout;
+	u32 ws_timeout;
+	u32 wake_enable;
 	int tgid;
 	int pd;
 	bool is_secure_dev;
@@ -438,11 +449,21 @@ struct fastrpc_ctrl_smmu {
 	u32 sharedcb;	/* Set to SMMU share context bank */
 };
 
+struct fastrpc_ctrl_wakelock {
+	u32 enable;	/* wakelock control enable */
+};
+
+struct fastrpc_ctrl_pm {
+	u32 timeout;	/* timeout(in ms) for PM to keep system awake */
+};
+
 struct fastrpc_internal_control {
 	u32 req;
 	union {
 		struct fastrpc_ctrl_latency lp;
 		struct fastrpc_ctrl_smmu smmu;
+		struct fastrpc_ctrl_wakelock wp;
+		struct fastrpc_ctrl_pm pm;
 	};
 };
 
@@ -980,6 +1001,43 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 	spin_unlock_irqrestore(&cctx->lock, flags);
 }
 
+static void fastrpc_pm_awake(struct fastrpc_user *fl,
+					u32 is_secure_channel)
+{
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct wakeup_source *wake_source = NULL;
+
+	/*
+	 * Vote with PM to abort any suspend in progress and
+	 * keep system awake for specified timeout
+	 */
+	if (is_secure_channel)
+		wake_source = cctx->wake_source_secure;
+	else
+		wake_source = cctx->wake_source;
+
+	if (wake_source)
+		pm_wakeup_ws_event(wake_source, fl->ws_timeout, true);
+}
+
+static void fastrpc_pm_relax(struct fastrpc_user *fl,
+					u32 is_secure_channel)
+{
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
+	struct wakeup_source *wake_source = NULL;
+
+	if (!fl->wake_enable)
+		return;
+
+	if (is_secure_channel)
+		wake_source = cctx->wake_source_secure;
+	else
+		wake_source = cctx->wake_source;
+
+	if (wake_source)
+		__pm_relax(wake_source);
+}
+
 static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
@@ -1971,6 +2029,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 		fastrpc_buf_free(buf);
 	}
 
+	fastrpc_pm_relax(fl, cctx->secure);
 	fastrpc_session_free(cctx, fl->sctx);
 	fastrpc_channel_ctx_put(cctx);
 
@@ -2251,6 +2310,24 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	case FASTRPC_CONTROL_SMMU:
 		fl->sharedcb = cp->smmu.sharedcb;
 		break;
+	case FASTRPC_CONTROL_WAKELOCK:
+		if (!fl->is_secure_dev) {
+			dev_err(&fl->cctx->rpdev->dev,
+				"PM voting not allowed for non-secure device node");
+			err = -EPERM;
+			return err;
+		}
+		fl->wake_enable = cp->wp.enable;
+		break;
+	case FASTRPC_CONTROL_PM:
+		if (!fl->wake_enable)
+			return -EACCES;
+		if (cp->pm.timeout > FASTRPC_MAX_PM_TIMEOUT_MS)
+			fl->ws_timeout = FASTRPC_MAX_PM_TIMEOUT_MS;
+		else
+			fl->ws_timeout = cp->pm.timeout;
+		fastrpc_pm_awake(fl, fl->cctx->secure);
+		break;
 	case FASTRPC_CONTROL_RPC_POLL:
 		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
 		break;
@@ -2942,6 +3019,21 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	return err;
 }
 
+static void fastrpc_register_wakeup_source(struct device *dev,
+	const char *client_name, struct wakeup_source **device_wake_source)
+{
+	struct wakeup_source *wake_source = NULL;
+
+	wake_source = wakeup_source_register(dev, client_name);
+	if (IS_ERR_OR_NULL(wake_source)) {
+		dev_err(dev, "wakeup_source_register failed for dev %s, client %s with err %ld\n",
+		dev_name(dev), client_name, PTR_ERR(wake_source));
+		return;
+	}
+
+	*device_wake_source = wake_source;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -3023,6 +3115,13 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		goto fdev_error;
 	}
 
+	if (data->fdevice)
+		fastrpc_register_wakeup_source(data->fdevice->miscdev.this_device,
+			FASTRPC_NON_SECURE_WAKE_SOURCE_CLIENT_NAME, &data->wake_source);
+	if (data->secure_fdevice)
+		fastrpc_register_wakeup_source(data->secure_fdevice->miscdev.this_device,
+			FASTRPC_SECURE_WAKE_SOURCE_CLIENT_NAME, &data->wake_source_secure);
+
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
@@ -3098,6 +3197,11 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->remote_heap)
 		fastrpc_buf_free(cctx->remote_heap);
 
+	if (cctx->wake_source)
+		wakeup_source_unregister(cctx->wake_source);
+	if (cctx->wake_source_secure)
+		wakeup_source_unregister(cctx->wake_source_secure);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
-- 
2.17.1

