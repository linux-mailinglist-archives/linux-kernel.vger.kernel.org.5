Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61B78F13B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245252AbjHaQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjHaQ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:28:30 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61F9B0;
        Thu, 31 Aug 2023 09:28:26 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VCkN3v013518;
        Thu, 31 Aug 2023 16:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=PxMnWkVJROPqpJMzz4V9iL9sbw56arNIB5MuqBpNJRM=;
 b=C2uSEmPRPC2zlYSsi+dOeBb+Aqpj/WQcookwNXmDo2jct1r9l45fhUcP3cDr47qXa9Is
 lHekBlyWvFSBDHJ+62ZXr7UZfYM/c9t0qfS5K2WdcMSAq4PeSiz8kntCWU+gWx1pvQ5M
 a5GD4bCBKmW9jthASzw8F/S7vH4T8tjHag0RLNw1HrcC4O68RNHqqkWU/d/mE5MvEdFo
 3C45Yu/YcHD/dVEFWZBbdD/iEST5FhgYwXTSySgyVgZkrLDYZcyC9jgFQo3HKQ62yx1E
 9gTDReX1U/vU4M36ToAb6GfE72jkb5485FXXf3yeeWndNzlR+BVXaF3123AxvC6f/sG6 Dw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3st3whugeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 16:28:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VGSNEZ005845
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 16:28:23 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 09:28:20 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 1/5] misc: fastrpc: Add fastrpc multimode invoke request support
Date:   Thu, 31 Aug 2023 21:58:08 +0530
Message-ID: <1693499292-19083-2-git-send-email-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: PM0JEoVEVbYvHI0jvWmjiuBS7MGmVygM
X-Proofpoint-ORIG-GUID: PM0JEoVEVbYvHI0jvWmjiuBS7MGmVygM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_14,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 drivers/misc/fastrpc.c      | 149 ++++++++++++++++++++++++++++++++------------
 include/uapi/misc/fastrpc.h |  25 ++++++++
 2 files changed, 133 insertions(+), 41 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 9666d28..04eaf6c 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -572,7 +572,7 @@ static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
 
 static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			struct fastrpc_user *user, u32 kernel, u32 sc,
-			struct fastrpc_invoke_args *args)
+			struct fastrpc_enhanced_invoke *invoke)
 {
 	struct fastrpc_channel_ctx *cctx = user->cctx;
 	struct fastrpc_invoke_ctx *ctx = NULL;
@@ -603,7 +603,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 			kfree(ctx);
 			return ERR_PTR(-ENOMEM);
 		}
-		ctx->args = args;
+		ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
 		fastrpc_get_buff_overlaps(ctx);
 	}
 
@@ -1130,12 +1130,12 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
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
@@ -1144,12 +1144,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
 
@@ -1235,6 +1237,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	char *name;
 	int err;
@@ -1243,7 +1246,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
-	u32 sc;
 
 	args = kcalloc(FASTRPC_CREATE_STATIC_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1310,10 +1312,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1348,6 +1351,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 {
 	struct fastrpc_init_create init;
 	struct fastrpc_invoke_args *args;
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_phy_page pages[1];
 	struct fastrpc_map *map = NULL;
 	struct fastrpc_buf *imem = NULL;
@@ -1361,7 +1365,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 attrs;
 		u32 siglen;
 	} inbuf;
-	u32 sc;
 	bool unsigned_module = false;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
@@ -1435,12 +1438,13 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
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
 
@@ -1492,17 +1496,19 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
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
@@ -1638,22 +1644,25 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
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
@@ -1675,16 +1684,59 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
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
+	int err;
+
+	if (copy_from_user(&invoke, argp, sizeof(invoke)))
+		return -EFAULT;
+
+	switch (invoke.req) {
+	case FASTRPC_INVOKE:
+		/* nscalars is truncated here to max supported value */
+		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
+				   invoke.size))
+			return -EFAULT;
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
@@ -1697,8 +1749,11 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
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
@@ -1785,10 +1840,10 @@ static int fastrpc_get_dsp_info(struct fastrpc_user *fl, char __user *argp)
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
@@ -1797,9 +1852,11 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
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
@@ -1843,6 +1900,7 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[3] = { [0 ... 2] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_buf *buf = NULL;
 	struct fastrpc_mmap_req_msg req_msg;
 	struct fastrpc_mmap_rsp_msg rsp_msg;
@@ -1850,7 +1908,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_req_mmap req;
 	struct device *dev = fl->sctx->dev;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1889,9 +1946,11 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1943,10 +2002,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -1972,9 +2031,11 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
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
@@ -1995,6 +2056,7 @@ static int fastrpc_req_mem_unmap(struct fastrpc_user *fl, char __user *argp)
 static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_invoke_args args[4] = { [0 ... 3] = { 0 } };
+	struct fastrpc_enhanced_invoke ioctl;
 	struct fastrpc_mem_map_req_msg req_msg = { 0 };
 	struct fastrpc_mmap_rsp_msg rsp_msg = { 0 };
 	struct fastrpc_mem_unmap req_unmap = { 0 };
@@ -2003,7 +2065,6 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	struct device *dev = fl->sctx->dev;
 	struct fastrpc_map *map = NULL;
 	int err;
-	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -2039,8 +2100,11 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
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
@@ -2080,6 +2144,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
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
index f33d914..36694fb 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -16,6 +16,7 @@
 #define FASTRPC_IOCTL_INIT_CREATE_STATIC _IOWR('R', 9, struct fastrpc_init_create_static)
 #define FASTRPC_IOCTL_MEM_MAP		_IOWR('R', 10, struct fastrpc_mem_map)
 #define FASTRPC_IOCTL_MEM_UNMAP		_IOWR('R', 11, struct fastrpc_mem_unmap)
+#define FASTRPC_IOCTL_MULTIMODE_INVOKE	_IOWR('R', 12, struct fastrpc_ioctl_multimode_invoke)
 #define FASTRPC_IOCTL_GET_DSP_INFO	_IOWR('R', 13, struct fastrpc_ioctl_capability)
 
 /**
@@ -80,6 +81,30 @@ struct fastrpc_invoke {
 	__u64 args;
 };
 
+struct fastrpc_enhanced_invoke {
+	struct fastrpc_invoke inv;
+	__u64 crc;
+	__u64 perf_kernel;
+	__u64 perf_dsp;
+	__u32 reserved[8];
+};
+
+struct fastrpc_ioctl_multimode_invoke {
+	__u32 req;
+	__u64 invparam;
+	__u64 size;
+	__u32 reserved[8];
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

