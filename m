Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9631C762DF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjGZHjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjGZHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:38:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70BD2721;
        Wed, 26 Jul 2023 00:36:15 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6Rvfj015908;
        Wed, 26 Jul 2023 07:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=69Iq3c5TiRJFMJ0zpMo9gou1Y8e26f9YaLrHuGzoVGc=;
 b=NEdkZ0Wfn7JENEMoMi0YgZKkl5ojGBsZFAC5u7dQUMe/61gxDXv1T/bCXEirUpTDO6Zm
 vf7awK3mxI/8k5GU4ZtyBlCpAbF2z9B5/qRfaFD5IBtITwCIUeFKz7ei57w9rZ/bioKc
 UWHAznMMrOoFMWPEU/ojyvorTU3bb7mF3aDRZYmfJr/6WWgGWTLaBs22Vp0NfZm5BXQI
 u08KgYye5s8gNlommE0aVlY9XusdoX7kTKzQR9Ix5wQQunO/3/miVDp75Ke/njLy/jFn
 S5YHlp8Vfp0DS26+QJJwDNrZXAmFA1iCYBm3u6zAKCN7xx6xXaVjUMtYMBSqbPap/FyR bw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2dqaj8ug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:36:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q7aCqV025332
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:36:12 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 00:36:09 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 2/2] misc: fastrpc: Add static PD restart support
Date:   Wed, 26 Jul 2023 13:05:59 +0530
Message-ID: <1690356959-1968-3-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690356959-1968-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1690356959-1968-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MeXFFzSivbcN5oODMtDjCSLFQt35jZbK
X-Proofpoint-ORIG-GUID: MeXFFzSivbcN5oODMtDjCSLFQt35jZbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static PDs on the audio and sensor domains are expected to support
PD restart. The kernel resource handling for the PDs are expected
to be handled by fastrpc driver. For this, there is a requirement
of PD service locator to get the event notifications for static
PD services. Also when events are received, the driver needs to
handle based on PD states. Added changes to add service locator
for audio and sensor domain static PDs and handle the PD restart
sequence.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
This patch depends on patch:
https://patchwork.kernel.org/project/linux-arm-msm/patch/1687528664-25235-1-git-send-email-quic_ekangupt@quicinc.com/
https://patchwork.kernel.org/project/linux-arm-msm/patch/1687529062-25988-1-git-send-email-quic_ekangupt@quicinc.com/

 drivers/misc/fastrpc.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 197 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 6b2ab49..8ae2f09 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -21,6 +21,7 @@
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/soc/qcom/pdr.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -28,6 +29,7 @@
 #define CDSP_DOMAIN_ID (3)
 #define FASTRPC_DEV_MAX		4 /* adsp, mdsp, slpi, cdsp*/
 #define FASTRPC_MAX_SESSIONS	14
+#define FASTRPC_MAX_SPD		4
 #define FASTRPC_MAX_VMIDS	16
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
@@ -104,6 +106,18 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+#define AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME   "audio_pdr_adsp"
+#define AUDIO_PDR_ADSP_SERVICE_NAME              "avs/audio"
+#define ADSP_AUDIOPD_NAME                        "msm/adsp/audio_pd"
+
+#define SENSORS_PDR_ADSP_SERVICE_LOCATION_CLIENT_NAME   "sensors_pdr_adsp"
+#define SENSORS_PDR_ADSP_SERVICE_NAME              "tms/servreg"
+#define ADSP_SENSORPD_NAME                       "msm/adsp/sensor_pd"
+
+#define SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME "sensors_pdr_slpi"
+#define SENSORS_PDR_SLPI_SERVICE_NAME            SENSORS_PDR_ADSP_SERVICE_NAME
+#define SLPI_SENSORPD_NAME                       "msm/slpi/sensor_pd"
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -259,6 +273,17 @@ struct fastrpc_session_ctx {
 	bool valid;
 };
 
+struct fastrpc_static_pd {
+	char *servloc_name;
+	char *spdname;
+	void *pdrhandle;
+	u64 pdrcount;
+	u64 prevpdrcount;
+	atomic_t ispdup;
+	int domain;
+	struct fastrpc_channel_ctx *cctx;
+};
+
 struct fastrpc_channel_ctx {
 	int domain_id;
 	int sesscount;
@@ -267,6 +292,7 @@ struct fastrpc_channel_ctx {
 	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
 	struct rpmsg_device *rpdev;
 	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
+	struct fastrpc_static_pd spd[FASTRPC_MAX_SPD];
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
@@ -302,6 +328,7 @@ struct fastrpc_user {
 	int tgid;
 	int pd;
 	bool is_secure_dev;
+	char *servloc_name;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -1260,6 +1287,41 @@ static int fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
 	return 0;
 }
 
+static int fastrpc_mmap_remove_pdr(struct fastrpc_user *fl)
+{
+	int i, err = 0, session = -1;
+
+	if (!fl)
+		return -EBADF;
+
+	for (i = 0; i < FASTRPC_MAX_SPD ; i++) {
+		if (!fl->cctx->spd[i].servloc_name)
+			continue;
+		if (!strcmp(fl->servloc_name, fl->cctx->spd[i].servloc_name)) {
+			session = i;
+			break;
+		}
+	}
+
+	if (i >= FASTRPC_MAX_SPD)
+		return -EUSERS;
+
+	if (atomic_read(&fl->cctx->spd[session].ispdup) == 0)
+		return -ENOTCONN;
+
+	if (fl->cctx->spd[session].pdrcount !=
+		fl->cctx->spd[session].prevpdrcount) {
+		err = fastrpc_mmap_remove_ssr(fl->cctx);
+		if (err)
+			dev_info(&fl->cctx->rpdev->dev,
+				"failed to unmap remote heap (err %d)\n", err);
+		fl->cctx->spd[session].prevpdrcount =
+				fl->cctx->spd[session].pdrcount;
+	}
+
+	return err;
+}
+
 static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					      char __user *argp)
 {
@@ -1303,6 +1365,19 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
+
+	fl->servloc_name = AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME;
+
+	if (!strcmp(name, "audiopd")) {
+		/*
+		 * Remove any previous mappings in case process is trying
+		 * to reconnect after a PD restart on remote subsystem.
+		 */
+		err = fastrpc_mmap_remove_pdr(fl);
+		if (err)
+			goto err_name;
+	}
+
 	if (!fl->cctx->staticpd_status) {
 		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
 		if (err)
@@ -1693,6 +1768,12 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 	args[0].fd = -1;
 	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
 	fl->pd = pd;
+	if (pd == SENSORS_PD) {
+		if (fl->cctx->domain_id == ADSP_DOMAIN_ID)
+			fl->servloc_name = SENSORS_PDR_ADSP_SERVICE_LOCATION_CLIENT_NAME;
+		else if (fl->cctx->domain_id == SDSP_DOMAIN_ID)
+			fl->servloc_name = SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME;
+	}
 
 	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
 				       sc, &args[0]);
@@ -2235,6 +2316,71 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	return err;
 }
 
+static void fastrpc_notify_users(struct fastrpc_user *user)
+{
+	struct fastrpc_invoke_ctx *ctx;
+
+	spin_lock(&user->lock);
+	list_for_each_entry(ctx, &user->pending, node) {
+		ctx->retval = -EPIPE;
+		ctx->is_work_done = true;
+		complete(&ctx->work);
+	}
+	spin_unlock(&user->lock);
+}
+
+static void fastrpc_notify_pdr_drivers(struct fastrpc_channel_ctx *cctx,
+		char *servloc_name)
+{
+	struct fastrpc_user *fl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	list_for_each_entry(fl, &cctx->users, user) {
+		if (fl->servloc_name && !strcmp(servloc_name, fl->servloc_name))
+			fastrpc_notify_users(fl);
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
+}
+
+static void fastrpc_pdr_cb(int state, char *service_path, void *priv)
+{
+	struct fastrpc_static_pd *spd = (struct fastrpc_static_pd *)priv;
+	unsigned long flags;
+
+	if (!spd)
+		return;
+
+	switch (state) {
+	case SERVREG_SERVICE_STATE_DOWN:
+		dev_info(&spd->cctx->rpdev->dev,
+			"%s: %s (%s) is down for PDR on %s\n",
+			__func__, spd->spdname,
+			spd->servloc_name,
+			domains[spd->domain]);
+		spin_lock_irqsave(&spd->cctx->lock, flags);
+		spd->pdrcount++;
+		atomic_set(&spd->ispdup, 0);
+		spin_unlock_irqrestore(&spd->cctx->lock, flags);
+		if (!strcmp(spd->servloc_name,
+				AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME))
+			spd->cctx->staticpd_status = false;
+
+		fastrpc_notify_pdr_drivers(spd->cctx, spd->servloc_name);
+		break;
+	case SERVREG_SERVICE_STATE_UP:
+		dev_info(&spd->cctx->rpdev->dev,
+			"%s: %s (%s) is up for PDR on %s\n",
+			__func__, spd->spdname,
+			spd->servloc_name,
+			domains[spd->domain]);
+		atomic_set(&spd->ispdup, 1);
+		break;
+	default:
+		break;
+	}
+}
+
 static const struct file_operations fastrpc_fops = {
 	.open = fastrpc_device_open,
 	.release = fastrpc_device_release,
@@ -2356,6 +2502,40 @@ static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ct
 	return err;
 }
 
+static int fastrpc_setup_service_locator(struct fastrpc_channel_ctx *cctx, char *client_name,
+					char *service_name, char *service_path, int domain, int spd_session)
+{
+	int err = 0;
+	struct pdr_handle *handle = NULL;
+	struct pdr_service *service = NULL;
+
+	/* Register the service locator's callback function */
+	handle = pdr_handle_alloc(fastrpc_pdr_cb, &cctx->spd[spd_session]);
+	if (IS_ERR(handle)) {
+		err = PTR_ERR(handle);
+		goto bail;
+	}
+	cctx->spd[spd_session].domain = domain;
+	cctx->spd[spd_session].pdrhandle = handle;
+	cctx->spd[spd_session].servloc_name = client_name;
+	cctx->spd[spd_session].spdname = service_path;
+	cctx->spd[spd_session].cctx = cctx;
+	service = pdr_add_lookup(handle, service_name, service_path);
+	if (IS_ERR(service)) {
+		err = PTR_ERR(service);
+		goto bail;
+	}
+	pr_info("fastrpc: %s: pdr_add_lookup enabled for %s (%s, %s)\n",
+		__func__, service_name, client_name, service_path);
+
+bail:
+	if (err) {
+		pr_warn("fastrpc: %s: failed for %s (%s, %s)with err %d\n",
+				__func__, service_name, client_name, service_path, err);
+	}
+	return err;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2435,6 +2615,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		goto fdev_error;
 	}
 
+	if (domain_id == ADSP_DOMAIN_ID) {
+		err = fastrpc_setup_service_locator(data, AUDIO_PDR_SERVICE_LOCATION_CLIENT_NAME,
+			AUDIO_PDR_ADSP_SERVICE_NAME, ADSP_AUDIOPD_NAME, domain_id, 0);
+		if (err)
+			return err;
+
+		err = fastrpc_setup_service_locator(data, SENSORS_PDR_ADSP_SERVICE_LOCATION_CLIENT_NAME,
+			SENSORS_PDR_ADSP_SERVICE_NAME, ADSP_SENSORPD_NAME, domain_id, 1);
+		if (err)
+			return err;
+	} else if (domain_id == SDSP_DOMAIN_ID) {
+		err = fastrpc_setup_service_locator(data, SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME,
+			SENSORS_PDR_SLPI_SERVICE_NAME, SLPI_SENSORPD_NAME, domain_id, 0);
+		if (err)
+			return err;
+	}
+
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);
@@ -2464,18 +2661,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	return err;
 }
 
-static void fastrpc_notify_users(struct fastrpc_user *user)
-{
-	struct fastrpc_invoke_ctx *ctx;
-
-	spin_lock(&user->lock);
-	list_for_each_entry(ctx, &user->pending, node) {
-		ctx->retval = -EPIPE;
-		complete(&ctx->work);
-	}
-	spin_unlock(&user->lock);
-}
-
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-- 
2.7.4

