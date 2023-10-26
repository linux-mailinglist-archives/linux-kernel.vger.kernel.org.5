Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AD47D7E52
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344572AbjJZISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344603AbjJZISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:18:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D17128;
        Thu, 26 Oct 2023 01:18:20 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39Q7PX2b025292;
        Thu, 26 Oct 2023 08:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=rx6FW+24Mo6NqWGgS2mDznpnkXHuFSOKE1VD33tTvpQ=;
 b=ZS3fbeV0mDgTq34d/zS0MuPfyrF8546aHHHiixEwe1SbeAH5/GEp31LbHqSOmU9x7GGn
 nGInP22fih1vfxqDYoo8P8a5T3Wxd6OYCcOe2wAQnrlUpoLJwqrMMasSHARK7QJtThot
 N0doZTzQVhrgHQBdi4GIrsZoj2PVkN0ZJSCSIcT0RS3T1geU9T4lEHM9vEaEk/J2b1AN
 mCzoV+LqGzZfy4o4f/RlguLR2yYSNpU5ZKg7gMeA18Onj1frIuXrspbjAstb8DM/UC/z
 izKQZnWI2i1C74XTC4pRH8jQr8DyGJXtCt/Q9mEm+j5WHupr5iPES4dSorlZzBcFjC0X pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txtw1k4rp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:18:18 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39Q8IHx7017883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Oct 2023 08:18:17 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 26 Oct 2023 01:18:15 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/5] misc: fastrpc: Add support to save and restore interrupted
Date:   Thu, 26 Oct 2023 13:48:01 +0530
Message-ID: <1698308282-8648-5-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1698308282-8648-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1698308282-8648-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wXL9ImVyilZaYdRYGh3_ar0_m3NFvkMB
X-Proofpoint-GUID: wXL9ImVyilZaYdRYGh3_ar0_m3NFvkMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
---
Changes in v2:
  - Fixed missing definition
  - Fixes compile time issue
Changes in v5:
  - Removed Change-Id tag

 drivers/misc/fastrpc.c | 99 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index b9822c1..9a481ac 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -333,6 +333,7 @@ struct fastrpc_user {
 	struct list_head user;
 	struct list_head maps;
 	struct list_head pending;
+	struct list_head interrupted;
 	struct list_head mmaps;
 
 	struct fastrpc_channel_ctx *cctx;
@@ -712,6 +713,40 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
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
@@ -1264,6 +1299,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
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
@@ -1287,6 +1330,7 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		goto bail;
 	PERF_END);
 
+wait:
 	if (kernel) {
 		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
 			err = -ETIMEDOUT;
@@ -1323,6 +1367,9 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	}
 
 	if (err == -ERESTARTSYS) {
+		if (ctx)
+			fastrpc_context_save_interrupted(ctx);
+
 		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
 			list_del(&buf->node);
 			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
@@ -1444,7 +1491,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_STATIC, 3, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
@@ -1577,7 +1624,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
 	if (init.attrs)
 		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err)
@@ -1628,6 +1675,25 @@ static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
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
@@ -1641,7 +1707,7 @@ static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_RELEASE, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1650,7 +1716,6 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 {
 	struct fastrpc_user *fl = (struct fastrpc_user *)file->private_data;
 	struct fastrpc_channel_ctx *cctx = fl->cctx;
-	struct fastrpc_invoke_ctx *ctx, *n;
 	struct fastrpc_map *map, *m;
 	struct fastrpc_buf *buf, *b;
 	unsigned long flags;
@@ -1664,10 +1729,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 	if (fl->init_mem)
 		fastrpc_buf_free(fl->init_mem);
 
-	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
-		list_del(&ctx->node);
-		fastrpc_context_put(ctx);
-	}
+	fastrpc_context_list_free(fl);
 
 	list_for_each_entry_safe(map, m, &fl->maps, node)
 		fastrpc_map_put(map);
@@ -1708,6 +1770,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
 	spin_lock_init(&fl->lock);
 	mutex_init(&fl->mutex);
 	INIT_LIST_HEAD(&fl->pending);
+	INIT_LIST_HEAD(&fl->interrupted);
 	INIT_LIST_HEAD(&fl->maps);
 	INIT_LIST_HEAD(&fl->mmaps);
 	INIT_LIST_HEAD(&fl->user);
@@ -1789,7 +1852,7 @@ static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_ATTACH, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -1820,7 +1883,7 @@ static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
 	}
 
 	ioctl.inv = inv;
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, false, &ioctl);
 	kfree(args);
@@ -1872,7 +1935,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 		perf_kernel = (u64 *)(uintptr_t)einv.perf_kernel;
 		if (perf_kernel)
 			fl->profile = true;
-		einv.inv.args = (__u64)args;
+		einv.inv.args = (u64)args;
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
 		break;
@@ -1902,7 +1965,7 @@ static int fastrpc_get_info_from_dsp(struct fastrpc_user *fl, uint32_t *dsp_attr
 
 	ioctl.inv.handle = FASTRPC_DSP_UTILITIES_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(0, 1, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	return fastrpc_internal_invoke(fl, true, &ioctl);
 }
@@ -2005,7 +2068,7 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (!err) {
@@ -2103,7 +2166,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
@@ -2184,7 +2247,7 @@ static int fastrpc_req_mem_unmap_impl(struct fastrpc_user *fl, struct fastrpc_me
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_UNMAP, 1, 0);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	fastrpc_map_put(map);
@@ -2253,7 +2316,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 
 	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
 	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MEM_MAP, 3, 1);
-	ioctl.inv.args = (__u64)args;
+	ioctl.inv.args = (u64)args;
 
 	err = fastrpc_internal_invoke(fl, true, &ioctl);
 	if (err) {
@@ -2574,6 +2637,10 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
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

