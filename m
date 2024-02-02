Return-Path: <linux-kernel+bounces-49281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A568584682D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2361F228F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF351755A;
	Fri,  2 Feb 2024 06:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lgnjqB8u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD917BC4;
	Fri,  2 Feb 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856063; cv=none; b=f0VxZs0klDxXGkBDD3t0cfN5WdeKueicLenArp8vmP6c+nSR9Uv1dkm/rlbG0H9+c/j4rx7/tMojz5OL0YUfV/lZN8tEQYrtSJbi/Y3vTLqCO/8KMhC0sTIFa3dnoJHj95Maevdy9eHwr2lF5rxJxAbi6j8RZrqkpUj12onAl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856063; c=relaxed/simple;
	bh=z8Hl4Row7jHBjKpjUgB/iPmEhZlIT54bqwO6dLRmvnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKriK/XirGgt6ijgm9JvfqhJpBckguAvyKzWU0y8GjWASKHCQsRuy7ACJ9OU7v/MUPJ4hloKNKzXy+WvK+BDXEbZun+ltbwSK0euUJuS+5BkjeBxOuy1MgvM24GWRisVEahWdX+fIgRa7kyXLsAw/Xp2O8XoePws6MWRZsBCXqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lgnjqB8u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121WpWI016165;
	Fri, 2 Feb 2024 06:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=Sl3W08GaQhaM1wUGx42U
	K2YbK6VW2S43yYXRozc45pc=; b=lgnjqB8ugRoegAcwKB0xxljzbK3TB3aFVJO3
	frYTTRdR8fmW536i6WK6Q+zKOmfBmoXd0wmzoa6QQ6oenvJNlhtzWoRkPqF7Jyft
	Tkzrgqsn110nspJyz/DTLnIGObWV+RtiCd0Y2A49lJl4T2RVFvFZaGon3E8dWapn
	c45DQKuubIuHZ2HMEUWUlpsZ9irAw9Zc5ouCMt7ExhBFTANZbVMOKgJXQ/KR6rs7
	+p9X6pJtoPS8EmPJjET2LfNY2APAAH2dnbgPtYZHKDC218VWd00BdbecpQujBc1W
	nWnUbrwtAVoYbJlDL0mHYibHG2yGC/ewwIS8XdRXMZYUQ8V4cw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00n2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:40:59 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126ewgP014145
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:40:58 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:40:56 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 04/16] misc: fastrpc: Add fastrpc multimode invoke request support
Date: Fri, 2 Feb 2024 12:10:27 +0530
Message-ID: <20240202064039.15505-5-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: ekeOz-716vevabMD4LsO6s20ESLzsJUV
X-Proofpoint-ORIG-GUID: ekeOz-716vevabMD4LsO6s20ESLzsJUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Multimode invocation request is intended to support multiple
different type of requests. This will include enhanced invoke
request to support CRC check and performance counter enablement.
This will also support few driver level user controllable
mechanisms like usage of shared context banks, wakelock support,
etc. This IOCTL is also added with the aim to support few
new fastrpc features like DSP PD notification framework,
DSP Signalling mechanism etc.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c      | 176 ++++++++++++++++++++++++++----------
 include/uapi/misc/fastrpc.h |  26 ++++++
 2 files changed, 154 insertions(+), 48 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e9b3b3b00aed..a7e959beabd4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -601,7 +601,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			struct fastrpc_user *user, u32 kernel, u32 sc,
-			struct fastrpc_invoke_args *args)
+			struct fastrpc_enhanced_invoke *invoke)
 {
 	struct fastrpc_channel_ctx *cctx = user->cctx;
 	struct fastrpc_invoke_ctx *ctx = NULL;
@@ -632,7 +632,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			kfree(ctx);
 			return ERR_PTR(-ENOMEM);
 		}
-		ctx->args = args;
+		ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
 		fastrpc_get_buff_overlaps(ctx);
 	}
 
@@ -1163,11 +1163,11 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 }
 
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
-				   u32 handle, u32 sc,
-				   struct fastrpc_invoke_args *args)
+				   struct fastrpc_enhanced_invoke *invoke)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
-
+	struct fastrpc_invoke *inv = &invoke->inv;
+	u32 handle, sc;
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1176,12 +1176,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (!fl->cctx->rpdev)
 		return -EPIPE;
 
+	handle = inv->handle;
+	sc = inv->sc;
 	if (handle == FASTRPC_INIT_HANDLE && !kernel) {
 		dev_warn_ratelimited(fl->sctx->dev, "user app trying to send a kernel RPC message (%d)\n",  handle);
 		return -EPERM;
 	}
 
-	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
+	ctx = fastrpc_context_alloc(fl, kernel, sc, invoke);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
@@ -1322,6 +1324,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	struct fastrpc_buf *buf = NULL;
 	u64 phys = 0, size = 0;
@@ -1333,7 +1336,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
-	u32 sc;
 
 	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1417,10 +1419,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[2].length = sizeof(*pages);
 	args[2].fd = -1;
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
+	ioctl.inv.args = (u64)args;
 
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				      sc, args);
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
 		goto err_invoke;
 
@@ -1463,6 +1466,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	struct fastrpc_map *map = NULL;
 	struct fastrpc_buf *imem = NULL;
@@ -1476,7 +1480,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 attrs;
 		u32 siglen;
 	} inbuf;
-	u32 sc;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1549,12 +1552,13 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	args[5].length = sizeof(inbuf.siglen);
 	args[5].fd = -1;
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
+		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
+	ioctl.inv.args = (u64)args;
 
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				      sc, args);
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
 		goto err_invoke;
 
@@ -1607,17 +1611,19 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 {
 	struct fastrpc_invoke_args args[1];
+	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = 0;
-	u32 sc;
 
 	tgid = fl->tgid;
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
 
-	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				       sc, &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
+	ioctl.inv.args = (u64)args;
+
+	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
 
 static int fastrpc_device_release(struct inode *inode, struct file *file)
@@ -1753,13 +1759,12 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 {
 	struct fastrpc_invoke_args args[1];
+	struct fastrpc_enhanced_invoke ioctl;
 	int tgid = fl->tgid;
-	u32 sc;
 
 	args[0].ptr = (u64)(uintptr_t) &tgid;
 	args[0].length = sizeof(tgid);
 	args[0].fd = -1;
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
 	fl->pd = pd;
 	if (pd == SENSORS_PD) {
 		if (fl->cctx->domain_id == ADSP_DOMAIN_ID)
@@ -1768,13 +1773,17 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 			fl->servloc_name = SENSORS_PDR_SLPI_SERVICE_LOCATION_CLIENT_NAME;
 	}
 
-	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				       sc, &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
+	ioctl.inv.args = (u64)args;
+
+	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
 
 static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args *args = NULL;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_invoke inv;
 	u32 nscalars;
 	int err;
@@ -1796,16 +1805,70 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 		}
 	}
 
-	err = fastrpc_internal_invoke(fl, false, inv.handle, inv.sc, args);
+	ioctl.inv = inv;
+	ioctl.inv.args = (u64)args;
+
+	err = fastrpc_internal_invoke(fl, false, &ioctl);
 	kfree(args);
 
 	return err;
 }
 
+static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
+{
+	struct fastrpc_enhanced_invoke einv;
+	struct fastrpc_invoke_args *args = NULL;
+	struct fastrpc_ioctl_multimode_invoke invoke;
+	u32 nscalars;
+	int err, i;
+
+	if (copy_from_user(&invoke, argp, sizeof(invoke)))
+		return -EFAULT;
+
+	for (i = 0; i < 8; i++) {
+		if (invoke.reserved[i] != 0)
+			return -EINVAL;
+	}
+	if (invoke.rsvd != 0)
+		return -EINVAL;
+
+	switch (invoke.req) {
+	case FASTRPC_INVOKE:
+		/* nscalars is truncated here to max supported value */
+		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
+				   invoke.size))
+			return -EFAULT;
+		for (i = 0; i < 8; i++) {
+			if (einv.reserved[i] != 0)
+				return -EINVAL;
+		}
+		nscalars = REMOTE_SCALARS_LENGTH(einv.inv.sc);
+		if (nscalars) {
+			args = kcalloc(nscalars, sizeof(*args), GFP_KERNEL);
+			if (!args)
+				return -ENOMEM;
+			if (copy_from_user(args, (void __user *)(uintptr_t)einv.inv.args,
+					   nscalars * sizeof(*args))) {
+				kfree(args);
+				return -EFAULT;
+			}
+		}
+		einv.inv.args = (u64)args;
+		err = fastrpc_internal_invoke(fl, false, &einv);
+		kfree(args);
+		break;
+	default:
+		err = -ENOTTY;
+		break;
+	}
+	return err;
+}
+
 static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr_buf,
 				     uint32_t dsp_attr_buf_len)
 {
 	struct fastrpc_invoke_args args[2] = { 0 };
+	struct fastrpc_enhanced_invoke ioctl;
 
 	/* Capability filled in userspace */
 	dsp_attr_buf[0] = 0;
@@ -1818,8 +1881,11 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 	args[1].fd = -1;
 	fl->pd = USER_PD;
 
-	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
-				       FASTRPC_SCALARS(0, 1, 1), args);
+	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(0, 1, 1);
+	ioctl.inv.args = (u64)args;
+
+	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
 
 static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
@@ -1906,10 +1972,10 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *buf)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_munmap_req_msg req_msg;
 	struct device *dev = fl->sctx->dev;
 	int err;
-	u32 sc;
 
 	req_msg.pgid = fl->tgid;
 	req_msg.size = buf->size;
@@ -1918,9 +1984,11 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
+	ioctl.inv.args = (u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (!err) {
 		if (buf->flag == ADSP_MMAP_REMOTE_HEAP_ADDR) {
 			if (fl->cctx->vmcount) {
@@ -1962,8 +2030,8 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_map *map = NULL, *iterm, *m;
 	struct device *dev = fl->sctx->dev;
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	int err = 0;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -2014,9 +2082,10 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
+	ioctl.inv.args = (u64)args;
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
 	else
@@ -2028,6 +2097,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
@@ -2036,7 +2106,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_map *map = NULL;
 	struct device *dev = fl->sctx->dev;
 	int err;
-	u32 sc;
 	unsigned long flags;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
@@ -2079,9 +2148,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		args[2].ptr = (u64) (uintptr_t) &rsp_msg;
 		args[2].length = sizeof(rsp_msg);
 
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
-		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-					      &args[0]);
+		ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+		ioctl.inv.args = (u64)args;
+
+		err = fastrpc_internal_invoke(fl, true, &ioctl);
 		if (err) {
 			dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
 			goto err_invoke;
@@ -2143,10 +2214,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		args[2].ptr = (u64) (uintptr_t) &rsp_msg;
 		args[2].length = sizeof(rsp_msg);
 
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+		ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+		ioctl.inv.args = (u64)args;
 
-		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-					      &args[0]);
+		err = fastrpc_internal_invoke(fl, true, &ioctl);
 		if (err) {
 			dev_err(dev, "mmap error (len 0x%08llx)\n", map->size);
 			goto err_invoke;
@@ -2183,10 +2255,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_mem_unmap *req)
 {
 	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_map *map = NULL, *iter, *m;
 	struct fastrpc_mem_unmap_req_msg req_msg = { 0 };
 	int err = 0;
-	u32 sc;
 	struct device *dev = fl->sctx->dev;
 
 	spin_lock(&fl->lock);
@@ -2212,9 +2284,11 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
+	ioctl.inv.args = (u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
 		return err;
@@ -2237,6 +2311,7 @@ static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_mem_map_req_msg req_msg = { 0 };
 	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
 	struct fastrpc_mem_unmap req_unmap = { 0 };
@@ -2245,7 +2320,6 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	struct device *dev = fl->sctx->dev;
 	struct fastrpc_map *map = NULL;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -2281,8 +2355,11 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	args[3].ptr = (u64) (uintptr_t) &rsp_msg;
 	args[3].length = sizeof(rsp_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
+	ioctl.inv.args = (u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
 		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
 			req.fd, req.vaddrin, map->size);
@@ -2322,6 +2399,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 	case FASTRPC_IOCTL_INVOKE:
 		err = fastrpc_invoke(fl, argp);
 		break;
+	case FASTRPC_IOCTL_MULTIMODE_INVOKE:
+		err = fastrpc_multimode_invoke(fl, argp);
+		break;
 	case FASTRPC_IOCTL_INIT_ATTACH:
 		err = fastrpc_init_attach(fl, ROOT_PD);
 		break;
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index f33d914d8f46..45c15be1de58 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -16,6 +16,7 @@
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_MULTIMODE_INVOKE	_IOWR('R', 12, struct fastrpc_ioctl_multimode_invoke)
 #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
@@ -80,6 +81,31 @@ struct fastrpc_invoke {
 	__u64 args;
 };
 
+struct fastrpc_enhanced_invoke {
+	struct fastrpc_invoke inv;
+	__u64 crc;
+	__u64 perf_kernel;
+	__u64 perf_dsp;
+	__u32 reserved[8];	/* keeping reserved bits for new requirements */
+};
+
+struct fastrpc_ioctl_multimode_invoke {
+	__u32 req;
+	__u32 rsvd;		/* padding field */
+	__u64 invparam;
+	__u64 size;
+	__u32 reserved[8];	/* keeping reserved bits for new requirements */
+};
+
+enum fastrpc_multimode_invoke_type {
+	FASTRPC_INVOKE			= 1,
+	FASTRPC_INVOKE_ENHANCED	= 2,
+	FASTRPC_INVOKE_CONTROL = 3,
+	FASTRPC_INVOKE_DSPSIGNAL = 4,
+	FASTRPC_INVOKE_NOTIF = 5,
+	FASTRPC_INVOKE_MULTISESSION = 6,
+};
+
 struct fastrpc_init_create {
 	__u32 filelen;	/* elf file length */
 	__s32 filefd;	/* fd for the file */
-- 
2.17.0


