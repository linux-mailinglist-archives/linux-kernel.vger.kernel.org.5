Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DB67F2940
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbjKUJtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjKUJtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:49:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91791110;
        Tue, 21 Nov 2023 01:48:59 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL9AicS028624;
        Tue, 21 Nov 2023 09:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=LM3AWdZb9LnRiU5dC9D12rHA7MbMDVaV8DYkrP7l2O4=;
 b=Te4WHhZFarXUFbpOFsey8Hq0E6yOFnMp/vIYC6EBSWUrwKoZbC5XqEdrgIwy2a7RqUaU
 kl+UIwlWq3OxZkMOot0a8sprU601ansrzs3VFUkk7tR2XY1luy+zp+LyIhyclSy0DTpq
 EVW1TMnjCIu3TYieM9zHUYYGBX1BpxZIqo6UQmOhvmFZoU+BdQ5ymKDs+1vvGY6lMYcG
 CTcmrNIhjeX1X64iaI3gQrtJKG5YAL0HdURHoV8vP10q2Wpn+G1tBaPwTmNOOiwvpktZ
 3362OMYMdvDhxHE92SUJYi5s0XsJ2tW7POvHMhLFhAHjKRZHtdQvjMzMDLzD3U7pG6mb ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uge001ght-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 09:48:57 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL9mupE007247
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 09:48:56 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 21 Nov 2023 01:48:54 -0800
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/5] misc: fastrpc: Add fastrpc multimode invoke request support
Date:   Tue, 21 Nov 2023 15:18:40 +0530
Message-ID: <20231121094844.5764-2-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: vsUv4qNYgJK8GE93LzrsIaUCXB0RdSOZ
X-Proofpoint-ORIG-GUID: vsUv4qNYgJK8GE93LzrsIaUCXB0RdSOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_03,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Changes in v4:
  - Added padding member to IOCTL structure
  - Added checks for reserved members
Changes in v6:
  - Added correct format of comments
Changes in v7:
  - Rebase the patch to latest kernel version

 drivers/misc/fastrpc.c      | 160 +++++++++++++++++++++++++++---------
 include/uapi/misc/fastrpc.h |  26 ++++++
 2 files changed, 145 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1c6c62a7f7f5..265e34f53c4e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -573,7 +573,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			struct fastrpc_user *user, u32 kernel, u32 sc,
-			struct fastrpc_invoke_args *args)
+			struct fastrpc_enhanced_invoke *invoke)
 {
 	struct fastrpc_channel_ctx *cctx = user->cctx;
 	struct fastrpc_invoke_ctx *ctx = NULL;
@@ -604,7 +604,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			kfree(ctx);
 			return ERR_PTR(-ENOMEM);
 		}
-		ctx->args = args;
+		ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
 		fastrpc_get_buff_overlaps(ctx);
 	}
 
@@ -1135,12 +1135,12 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 }
 
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
-				   u32 handle, u32 sc,
-				   struct fastrpc_invoke_args *args)
+				   struct fastrpc_enhanced_invoke *invoke)
 {
 	struct fastrpc_invoke_ctx *ctx = NULL;
 	struct fastrpc_buf *buf, *b;
-
+	struct fastrpc_invoke *inv = &invoke->inv;
+	u32 handle, sc;
 	int err = 0;
 
 	if (!fl->sctx)
@@ -1149,12 +1149,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
 
@@ -1236,6 +1238,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	char *name;
 	int err;
@@ -1244,7 +1247,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
-	u32 sc;
 
 	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1311,10 +1313,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[2].length = sizeof(*pages);
 	args[2].fd = -1;
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
+	ioctl.inv.args = (__u64)args;
 
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				      sc, args);
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
 		goto err_invoke;
 
@@ -1354,6 +1357,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	struct fastrpc_map *map = NULL;
 	struct fastrpc_buf *imem = NULL;
@@ -1367,7 +1371,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 attrs;
 		u32 siglen;
 	} inbuf;
-	u32 sc;
 	bool unsigned_module = false;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
@@ -1441,12 +1444,13 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	args[5].length = sizeof(inbuf.siglen);
 	args[5].fd = -1;
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
-		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
+		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
+	ioctl.inv.args = (__u64)args;
 
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				      sc, args);
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
 		goto err_invoke;
 
@@ -1498,17 +1502,19 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
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
+	ioctl.inv.args = (__u64)args;
+
+	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
 
 static int fastrpc_device_release(struct inode *inode, struct file *file)
@@ -1644,22 +1650,25 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
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
 
-	return fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE,
-				       sc, &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
+	ioctl.inv.args = (__u64)args;
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
@@ -1681,16 +1690,70 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 		}
 	}
 
-	err = fastrpc_internal_invoke(fl, false, inv.handle, inv.sc, args);
+	ioctl.inv = inv;
+	ioctl.inv.args = (__u64)args;
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
+		einv.inv.args = (__u64)args;
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
@@ -1703,8 +1766,11 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 	args[1].fd = -1;
 	fl->pd = USER_PD;
 
-	return fastrpc_internal_invoke(fl, true, FASTRPC_DSP_UTILITIES_HANDLE,
-				       FASTRPC_SCALARS(0, 1, 1), args);
+	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(0, 1, 1);
+	ioctl.inv.args = (__u64)args;
+
+	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
 
 static int fastrpc_get_info_from_kernel(struct fastrpc_ioctl_capability *cap,
@@ -1791,10 +1857,10 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
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
@@ -1803,9 +1869,11 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
+	ioctl.inv.args = (__u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (!err) {
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
 		spin_lock(&fl->lock);
@@ -1849,6 +1917,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
@@ -1856,7 +1925,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1899,9 +1967,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	args[2].ptr = (u64) (uintptr_t) &rsp_msg;
 	args[2].length = sizeof(rsp_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+	ioctl.inv.args = (__u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
 		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
 		goto err_invoke;
@@ -1949,10 +2019,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1978,9 +2048,11 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 	args[0].ptr = (u64) (uintptr_t) &req_msg;
 	args[0].length = sizeof(req_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
+	ioctl.inv.args = (__u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
 		return err;
@@ -2003,6 +2075,7 @@ static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_mem_map_req_msg req_msg = { 0 };
 	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
 	struct fastrpc_mem_unmap req_unmap = { 0 };
@@ -2011,7 +2084,6 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	struct device *dev = fl->sctx->dev;
 	struct fastrpc_map *map = NULL;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -2047,8 +2119,11 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	args[3].ptr = (u64) (uintptr_t) &rsp_msg;
 	args[3].length = sizeof(rsp_msg);
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
+	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
+	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
+	ioctl.inv.args = (__u64)args;
+
+	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
 		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
 			req.fd, req.vaddrin, map->size);
@@ -2088,6 +2163,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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
2.17.1

