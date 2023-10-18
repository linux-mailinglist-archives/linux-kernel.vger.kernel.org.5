Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E6F7CD4D8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbjJRHDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjJRHDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:03:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C0F100;
        Wed, 18 Oct 2023 00:02:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I4vDju022978;
        Wed, 18 Oct 2023 07:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=i8Se3s0n/KHRd73QipFoyeDw5ZqV+mJMhlUDlsmzk0Q=;
 b=MsCZE1wULtgqO9L3copjLuvjHhHl01ZTxTHha4s3AzLx9BUYgdVOnqB5JfLh75vlciLF
 0NkuKFGXv0Hs5LnYGkIYEIrR0T9c/pFWxuNz8Ga0AUPj7cYEfHCbZLY+ZXzRNR+sDJN/
 WAsd8f6AqW3olBaHjY2quvT81V8fz3LEPOpvCTHbWAsvvXNzU4Wyg1tyzj/d0vJsD8Qe
 4gW9rzgg40l09KvsHvy2a99PpGBkPQxImaxnWEpskBoOY/hOpBaCzN1QxU2rZC8z+7VO
 R3dJKCxW/HokjKRZVGUC5fzK+tJo5lBQ4QlXECWIAdzNYLfcL2EI61hNXfqcux2kO0GH OQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsaf0v46a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 07:02:54 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I72rfD022605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 07:02:53 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 00:02:50 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/5] misc: fastrpc: Add fastrpc multimode invoke request support
Date:   Wed, 18 Oct 2023 12:32:36 +0530
Message-ID: <1697612560-9726-2-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1697612560-9726-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1697612560-9726-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zMMUN8SdGVVQgKo6mTzPbLaS20Dgs2jL
X-Proofpoint-ORIG-GUID: zMMUN8SdGVVQgKo6mTzPbLaS20Dgs2jL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_04,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/misc/fastrpc.c      | 160 ++++++++++++++++++++++++++++++++------------
 include/uapi/misc/fastrpc.h |  26 +++++++
 2 files changed, 145 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a66b7c1..e392e2a 100644
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
 
@@ -1133,12 +1133,12 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
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
@@ -1147,12 +1147,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
 
@@ -1238,6 +1240,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	char *name;
 	int err;
@@ -1246,7 +1249,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
-	u32 sc;
 
 	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1313,10 +1315,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1356,6 +1359,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	struct fastrpc_map *map = NULL;
 	struct fastrpc_buf *imem = NULL;
@@ -1369,7 +1373,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 attrs;
 		u32 siglen;
 	} inbuf;
-	u32 sc;
 	bool unsigned_module = false;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
@@ -1443,12 +1446,13 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
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
 
@@ -1500,17 +1504,19 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
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
@@ -1646,22 +1652,25 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
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
@@ -1683,16 +1692,70 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
@@ -1705,8 +1768,11 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
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
@@ -1793,10 +1859,10 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
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
@@ -1805,9 +1871,11 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
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
@@ -1851,6 +1919,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
@@ -1858,7 +1927,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1901,9 +1969,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1951,10 +2021,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1980,9 +2050,11 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
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
 	fastrpc_map_put(map);
 	if (err)
 		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
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
index f33d914..88194c5 100644
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
+	__u32 reserved[8];	// keeping reserved bits for new requirements
+};
+
+struct fastrpc_ioctl_multimode_invoke {
+	__u32 req;
+	__u32 rsvd;			// padding field
+	__u64 invparam;
+	__u64 size;
+	__u32 reserved[8];	// keeping reserved bits for new requirements
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
2.7.4

