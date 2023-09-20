Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE097A79A9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjITKsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjITKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:47:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB061B6;
        Wed, 20 Sep 2023 03:47:36 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K2JAq0011695;
        Wed, 20 Sep 2023 10:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=9WrfjcivopfCHnGzIPN6fIAn43POGv9kaG8vsb/GTEk=;
 b=SZKUBLGm1UvGVEIbZgmpIsZEoOExch4dUH/8P4Vk7P1MAn0SUkIGQrlYfBtQx3bH1ZfN
 TuU2kpq24X8Xws4X6xqF7w8VFdRhpoQkB4vbupf0++uZi2wYDLguAJUL6Fps9pKc66wS
 R7xelQ+Kn+mNdFlBppPwK/1xNc+YuKULpkVhBK2ERJqcsyw9vIxd1nJ+DPwVeq6qu3rG
 zYCJWWNg7EHaOknzwBsecZ2trkr5b55D6fHyYAAmU+hloZOg7ORiTEiExXa1bBnP4gH+
 Lk9NaDCjSNoOtcUXwKcIR9YEfOyODfPb1lElUEuzRhVIiUz+8uM4xkwSXS2DeldFn89j sQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t78upjwfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 10:47:31 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38KAlVOH000664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 10:47:31 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Wed, 20 Sep 2023 03:47:28 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v3 4/5] misc: fastrpc: Add support to save and restore interrupted
Date:   Wed, 20 Sep 2023 16:17:06 +0530
Message-ID: <1695206827-29446-5-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1695206827-29446-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1695206827-29446-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _Fgg8FvamAhwrPV2d5AyLJLylokRNCe3
X-Proofpoint-ORIG-GUID: _Fgg8FvamAhwrPV2d5AyLJLylokRNCe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_05,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For any remote call, driver sends a message to DSP using RPMSG
framework. After message is sent, there is a wait on a completion
object at driver which is completed when DSP response is received.

There is a possibility that a signal is received while waiting
causing the wait function to return -ERESTARTSYS. In this case
the context should be saved and it should get restored for the
next invocation for the thread.

Adding changes to support saving and restoring of interrupted
fastrpc contexts.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>

misc: fastrpc: Add support to save and restore interrupted

For any remote call, driver sends a message to DSP using RPMSG
framework. After message is sent, there is a wait on a completion
object at driver which is completed when DSP response is received.

There is a possibility that a signal is received while waiting
causing the wait function to return -ERESTARTSYS. In this case
the context should be saved and it should get restored for the
next invocation for the thread.

Adding changes to support saving and restoring of interrupted
fastrpc contexts.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v2:
  - Fixed compile time warnings
Changes in v3:
  - Squashed commits to get proper patch series

 drivers/misc/fastrpc.c | 99 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f8c1c381..1c625571 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -332,6 +332,7 @@ struct fastrpc_user {
 	struct list_head user;
 	struct list_head maps;
 	struct list_head pending;
+	struct list_head interrupted;
 	struct list_head mmaps;
 
 	struct fastrpc_channel_ctx *cctx;
@@ -711,6 +712,40 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	return ERR_PTR(ret);
 }
 
+static struct fastrpc_invoke_ctx *fastrpc_context_restore_interrupted(
+			struct fastrpc_user *fl, struct fastrpc_invoke *inv)
+{
+	struct fastrpc_invoke_ctx *ctx = NULL, *ictx = NULL, *n;
+
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(ictx, n, &fl->interrupted, node) {
+		if (ictx->pid == current->pid) {
+			if (inv->sc != ictx->sc || ictx->fl != fl) {
+				dev_err(ictx->fl->sctx->dev,
+					"interrupted sc (0x%x) or fl (%pK) does not match with invoke sc (0x%x) or fl (%pK)\n",
+					ictx->sc, ictx->fl, inv->sc, fl);
+				spin_unlock(&fl->lock);
+				return ERR_PTR(-EINVAL);
+			}
+			ctx = ictx;
+			list_del(&ctx->node);
+			list_add_tail(&ctx->node, &fl->pending);
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+	return ctx;
+}
+
+static void fastrpc_context_save_interrupted(
+			struct fastrpc_invoke_ctx *ctx)
+{
+	spin_lock(&ctx->fl->lock);
+	list_del(&ctx->node);
+	list_add_tail(&ctx->node, &ctx->fl->interrupted);
+	spin_unlock(&ctx->fl->lock);
+}
+
 static struct sg_table *
 fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
 		    enum dma_data_direction dir)
@@ -1261,6 +1296,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		return -EPERM;
 	}
 
+	if (!kernel) {
+		ctx = fastrpc_context_restore_interrupted(fl, inv);
+		if (IS_ERR(ctx))
+			return PTR_ERR(ctx);
+		if (ctx)
+			goto wait;
+	}
+
 	ctx = fastrpc_context_alloc(fl, kernel, sc, invoke);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
@@ -1284,6 +1327,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 	PERF_END);
 
+wait:
 	if (kernel) {
 		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
 			err = -ETIMEDOUT;
@@ -1320,6 +1364,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	}
 
 	if (err == -ERESTARTSYS) {
+		if (ctx)
+			fastrpc_context_save_interrupted(ctx);
+
 		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 			list_del(&buf->node);
 			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
@@ -1441,7 +1488,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
@@ -1569,7 +1616,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
 		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
@@ -1620,6 +1667,25 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
 	spin_unlock_irqrestore(&cctx->lock, flags);
 }
 
+static void fastrpc_context_list_free(struct fastrpc_user *fl)
+{
+	struct fastrpc_invoke_ctx *ctx, *n;
+
+	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
+		spin_lock(&fl->lock);
+		list_del(&ctx->node);
+		spin_unlock(&fl->lock);
+		fastrpc_context_put(ctx);
+	}
+
+	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
+		spin_lock(&fl->lock);
+		list_del(&ctx->node);
+		spin_unlock(&fl->lock);
+		fastrpc_context_put(ctx);
+	}
+}
+
 static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 {
 	struct fastrpc_invoke_args args[1];
@@ -1633,7 +1699,7 @@ static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1642,7 +1708,6 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
-	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 	unsigned long flags;
@@ -1656,10 +1721,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	if (fl->init_mem)
 		fastrpc_buf_free(fl->init_mem);
 
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
+	fastrpc_context_list_free(fl);
 
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
@@ -1700,6 +1762,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
@@ -1781,7 +1844,7 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1812,7 +1875,7 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	}
 
 	ioctl.inv = inv;
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, false, &ioctl);
 	kfree(args);
@@ -1853,7 +1916,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 		perf_kernel = (u64 *)(uintptr_t)einv.perf_kernel;
 		if (perf_kernel)
 			fl->profile = true;
-		einv.inv.args = (__u64)args;
+		einv.inv.args = (u64)args;
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
 		break;
@@ -1883,7 +1946,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 
 	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(0, 1, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1986,7 +2049,7 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (!err) {
@@ -2080,7 +2143,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
@@ -2165,7 +2228,7 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	fastrpc_map_put(map);
@@ -2234,7 +2297,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
@@ -2555,6 +2618,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 		ctx->retval = -EPIPE;
 		complete(&ctx->work);
 	}
+	list_for_each_entry(ctx, &user->interrupted, node) {
+		ctx->retval = -EPIPE;
+		complete(&ctx->work);
+	}
 	spin_unlock(&user->lock);
 }
 
-- 
2.7.4

