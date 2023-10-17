Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC87CBF18
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjJQJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343509AbjJQJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:01 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21C6F5;
        Tue, 17 Oct 2023 02:26:58 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39H8qVm5006691;
        Tue, 17 Oct 2023 09:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tqqvxSf2BwZDIBBLod89GS6mURAg1BSoG2iU12URJk0=;
 b=Fr7h2LadsDvcJkRO+jUpnPilo1/eipQ2tUiUpUeGtd9xwlwXlz4RjtOKF6xyhuJGlP0t
 TnOJl5QoRQMNRJFyVh5L4bFWaR5RDhTOeE97ZkksHjfOvreG0q9PaqKaGf0TTe0Cwpbv
 +gZDkU49JtQIlVkU7NeKC+kjb38RUG9O7V5CyEgK0pGrmPYh50DcOoKvtDNqkTibeP1l
 PyADpQJeg8Be6BPU0XxW2sfjwZy9Ld3a03AnqiJFbrlZ8vIMsN+uqRS6i3x/RY3oYz7u
 GJL0BYkgjp+D8zl37dvbQov+kzsMNWon6R2u+5Q0x8TvCFhu7QYrriDILCeeTti4U8a0 +g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsnej8akn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:26:56 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39H9QtJW018079
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Oct 2023 09:26:55 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 17 Oct 2023 02:26:52 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v4 3/5] misc: fastrpc: Capture kernel and DSP performance counters
Date:   Tue, 17 Oct 2023 14:56:37 +0530
Message-ID: <1697534799-5124-4-git-send-email-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1697534799-5124-1-git-send-email-quic_ekangupt@quicinc.com>
References: <1697534799-5124-1-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J4pQrFMzXUkkO3QPzbLLlYa_KHWF7cjA
X-Proofpoint-ORIG-GUID: J4pQrFMzXUkkO3QPzbLLlYa_KHWF7cjA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170078
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to capture kernel performance counters for different
kernel level operations. These counters collects the information
for remote call and copies the information to a buffer shared
by user.

Collection of DSP performance counters is also added as part of
this change. DSP updates the performance information in the
metadata which is then copied to a buffer passed by the user.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
Changes in v2:
  - Fixed compile time warnings
Changes in v3:
  - Squashed commits to get proper patch series

 drivers/misc/fastrpc.c      | 140 +++++++++++++++++++++++++++++++++++++++++---
 include/uapi/misc/fastrpc.h |  14 +++++
 2 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 825ff91..b9822c1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -19,6 +19,7 @@
 #include <linux/rpmsg.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
 #include <linux/of_reserved_mem.h>
@@ -33,6 +34,8 @@
 #define FASTRPC_ALIGN		128
 #define FASTRPC_MAX_FDLIST	16
 #define FASTRPC_MAX_CRCLIST	64
+#define FASTRPC_KERNEL_PERF_LIST (PERF_KEY_MAX)
+#define FASTRPC_DSP_PERF_LIST 12
 #define FASTRPC_PHYS(p)	((p) & 0xffffffff)
 #define FASTRPC_CTX_MAX (256)
 #define FASTRPC_INIT_HANDLE	1
@@ -105,6 +108,27 @@
 
 #define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
+#define PERF_END ((void)0)
+
+#define PERF(enb, cnt, ff) \
+	{\
+		struct timespec64 startT = {0};\
+		uint64_t *counter = cnt;\
+		if (enb && counter) {\
+			ktime_get_real_ts64(&startT);\
+		} \
+		ff ;\
+		if (enb && counter) {\
+			*counter += getnstimediff(&startT);\
+		} \
+	}
+
+#define GET_COUNTER(perf_ptr, offset)  \
+	(perf_ptr != NULL ?\
+		(((offset >= 0) && (offset < PERF_KEY_MAX)) ?\
+			(uint64_t *)(perf_ptr + offset)\
+				: (uint64_t *)NULL) : (uint64_t *)NULL)
+
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
 struct fastrpc_phy_page {
@@ -228,6 +252,19 @@ struct fastrpc_map {
 	struct kref refcount;
 };
 
+struct fastrpc_perf {
+	u64 count;
+	u64 flush;
+	u64 map;
+	u64 copy;
+	u64 link;
+	u64 getargs;
+	u64 putargs;
+	u64 invargs;
+	u64 invoke;
+	u64 tid;
+};
+
 struct fastrpc_invoke_ctx {
 	int nscalars;
 	int nbufs;
@@ -236,6 +273,8 @@ struct fastrpc_invoke_ctx {
 	int tgid;
 	u32 sc;
 	u32 *crc;
+	u64 *perf_kernel;
+	u64 *perf_dsp;
 	u64 ctxid;
 	u64 msg_sz;
 	struct kref refcount;
@@ -250,6 +289,7 @@ struct fastrpc_invoke_ctx {
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_buf_overlap *olaps;
 	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_perf *perf;
 };
 
 struct fastrpc_session_ctx {
@@ -299,6 +339,7 @@ struct fastrpc_user {
 	struct fastrpc_session_ctx *sctx;
 	struct fastrpc_buf *init_mem;
 
+	u32 profile;
 	int tgid;
 	int pd;
 	bool is_secure_dev;
@@ -308,6 +349,17 @@ struct fastrpc_user {
 	struct mutex mutex;
 };
 
+static inline int64_t getnstimediff(struct timespec64 *start)
+{
+	int64_t ns;
+	struct timespec64 ts, b;
+
+	ktime_get_real_ts64(&ts);
+	b = timespec64_sub(ts, *start);
+	ns = timespec64_to_ns(&b);
+	return ns;
+}
+
 static void fastrpc_free_map(struct kref *ref)
 {
 	struct fastrpc_map *map;
@@ -493,6 +545,9 @@ static void fastrpc_context_free(struct kref *ref)
 	if (ctx->buf)
 		fastrpc_buf_free(ctx->buf);
 
+	if (ctx->fl->profile)
+		kfree(ctx->perf);
+
 	spin_lock_irqsave(&cctx->lock, flags);
 	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -612,6 +667,14 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	fastrpc_channel_ctx_get(cctx);
 
 	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
+	ctx->perf_dsp = (u64 *)(uintptr_t)invoke->perf_dsp;
+	ctx->perf_kernel = (u64 *)(uintptr_t)invoke->perf_kernel;
+	if (ctx->fl->profile) {
+		ctx->perf = kzalloc(sizeof(*(ctx->perf)), GFP_KERNEL);
+		if (!ctx->perf)
+			return ERR_PTR(-ENOMEM);
+		ctx->perf->tid = ctx->fl->tgid;
+	}
 	ctx->sc = sc;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
@@ -875,7 +938,8 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 		sizeof(struct fastrpc_invoke_buf) +
 		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
 		sizeof(u64) * FASTRPC_MAX_FDLIST +
-		sizeof(u32) * FASTRPC_MAX_CRCLIST;
+		sizeof(u32) * FASTRPC_MAX_CRCLIST +
+		sizeof(u32) + sizeof(u64) * FASTRPC_DSP_PERF_LIST;
 
 	return size;
 }
@@ -942,16 +1006,22 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 	int inbufs, i, oix, err = 0;
 	u64 len, rlen, pkt_size;
 	u64 pg_start, pg_end;
+	u64 *perf_counter = NULL;
 	uintptr_t args;
 	int metalen;
 
+	if (ctx->fl->profile)
+		perf_counter = (u64 *)ctx->perf + PERF_COUNT;
+
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	metalen = fastrpc_get_meta_size(ctx);
 	pkt_size = fastrpc_get_payload_size(ctx, metalen);
 
+	PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_MAP),
 	err = fastrpc_create_maps(ctx);
 	if (err)
 		return err;
+	PERF_END);
 
 	ctx->msg_sz = pkt_size;
 
@@ -983,6 +1053,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 		if (ctx->maps[i]) {
 			struct vm_area_struct *vma = NULL;
 
+			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_MAP),
 			rpra[i].buf.pv = (u64) ctx->args[i].ptr;
 			pages[i].addr = ctx->maps[i]->phys;
 
@@ -997,9 +1068,9 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pg_end = ((ctx->args[i].ptr + len - 1) & PAGE_MASK) >>
 				  PAGE_SHIFT;
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
-
+			PERF_END);
 		} else {
-
+			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_COPY),
 			if (ctx->olaps[oix].offset == 0) {
 				rlen -= ALIGN(args, FASTRPC_ALIGN) - args;
 				args = ALIGN(args, FASTRPC_ALIGN);
@@ -1021,12 +1092,14 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			pages[i].size = (pg_end - pg_start + 1) * PAGE_SIZE;
 			args = args + mlen;
 			rlen -= mlen;
+			PERF_END);
 		}
 
 		if (i < inbufs && !ctx->maps[i]) {
 			void *dst = (void *)(uintptr_t)rpra[i].buf.pv;
 			void *src = (void *)(uintptr_t)ctx->args[i].ptr;
 
+			PERF(ctx->fl->profile, GET_COUNTER(perf_counter, PERF_COPY),
 			if (!kernel) {
 				if (copy_from_user(dst, (void __user *)src,
 						   len)) {
@@ -1036,6 +1109,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
 			} else {
 				memcpy(dst, src, len);
 			}
+			PERF_END);
 		}
 	}
 
@@ -1066,9 +1140,9 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_map *mmap = NULL;
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
-	u64 *fdlist;
-	u32 *crclist;
-	int i, inbufs, outbufs, handles;
+	u64 *fdlist, *perf_dsp_list;
+	u32 *crclist, *poll;
+	int i, inbufs, outbufs, handles, perferr;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
@@ -1077,6 +1151,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
 	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
 	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
+	poll = (u32 *)(crclist + FASTRPC_MAX_CRCLIST);
+	perf_dsp_list = (u64 *)(poll + 1);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
@@ -1101,8 +1177,16 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	}
 
 	if (ctx->crc && crclist && rpra) {
-		if (copy_to_user((void __user *)ctx->crc, crclist, FASTRPC_MAX_CRCLIST * sizeof(u32)))
+		if (copy_to_user((void __user *)ctx->crc, crclist,
+					FASTRPC_MAX_CRCLIST * sizeof(u32))) {
 			return -EFAULT;
+		}
+	}
+	if (ctx->perf_dsp && perf_dsp_list) {
+		perferr = copy_to_user((void __user *)ctx->perf_dsp,
+				perf_dsp_list, FASTRPC_DSP_PERF_LIST * sizeof(u64));
+		if (perferr)
+			dev_info(fl->sctx->dev, "Warning: failed to copy perf data %d\n", perferr);
 	}
 	return 0;
 }
@@ -1139,6 +1223,20 @@ static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
 
 }
 
+static void fastrpc_update_invoke_count(u32 handle, u64 *perf_counter,
+					struct timespec64 *invoket)
+{
+	u64 *invcount, *count;
+
+	invcount = GET_COUNTER(perf_counter, PERF_INVOKE);
+	if (invcount)
+		*invcount += getnstimediff(invoket);
+
+	count = GET_COUNTER(perf_counter, PERF_COUNT);
+	if (count)
+		*count += 1;
+}
+
 static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 				   struct fastrpc_enhanced_invoke *invoke)
 {
@@ -1146,7 +1244,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_invoke *inv = &invoke->inv;
 	u32 handle, sc;
-	int err = 0;
+	u64 *perf_counter = NULL;
+	int err = 0, perferr = 0;
+	struct timespec64 invoket = {0};
+
+	if (fl->profile)
+		ktime_get_real_ts64(&invoket);
 
 	if (!fl->sctx)
 		return -EINVAL;
@@ -1165,18 +1268,24 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	if (fl->profile)
+		perf_counter = (u64 *)ctx->perf + PERF_COUNT;
+	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_GETARGS),
 	if (ctx->nscalars) {
 		err = fastrpc_get_args(kernel, ctx);
 		if (err)
 			goto bail;
 	}
+	PERF_END);
 
 	/* make sure that all CPU memory writes are seen by DSP */
 	dma_wmb();
+	PERF(fl->profile, GET_COUNTER(perf_counter, PERF_LINK),
 	/* Send invoke buffer to remote dsp */
 	err = fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
 	if (err)
 		goto bail;
+	PERF_END);
 
 	if (kernel) {
 		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
@@ -1196,10 +1305,12 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 	if (ctx->nscalars) {
 		/* make sure that all memory writes by DSP are seen by CPU */
 		dma_rmb();
+		PERF(fl->profile, GET_COUNTER(perf_counter, PERF_PUTARGS),
 		/* populate all the output buffers with results */
 		err = fastrpc_put_args(ctx, kernel);
 		if (err)
 			goto bail;
+		PERF_END);
 	}
 
 bail:
@@ -1216,6 +1327,15 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 			list_del(&buf->node);
 			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
 		}
+	} else if (ctx) {
+		if (fl->profile && !err)
+			fastrpc_update_invoke_count(handle, perf_counter, &invoket);
+		if (fl->profile && ctx->perf && ctx->perf_kernel) {
+			perferr = copy_to_user((void __user *)ctx->perf_kernel,
+						ctx->perf, FASTRPC_KERNEL_PERF_LIST * sizeof(u64));
+			if (perferr)
+				dev_info(fl->sctx->dev, "Warning: failed to copy perf data %d\n", perferr);
+		}
 	}
 
 	if (err)
@@ -1714,6 +1834,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_invoke_args *args = NULL;
 	struct fastrpc_ioctl_multimode_invoke invoke;
 	u32 nscalars;
+	u64 *perf_kernel;
 	int err, i;
 
 	if (copy_from_user(&invoke, argp, sizeof(invoke)))
@@ -1748,6 +1869,9 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 				return -EFAULT;
 			}
 		}
+		perf_kernel = (u64 *)(uintptr_t)einv.perf_kernel;
+		if (perf_kernel)
+			fl->profile = true;
 		einv.inv.args = (__u64)args;
 		err = fastrpc_internal_invoke(fl, false, &einv);
 		kfree(args);
diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 88194c5..3a2ba59 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -166,4 +166,18 @@ struct fastrpc_ioctl_capability {
 	__u32 reserved[4];
 };
 
+enum fastrpc_perfkeys {
+	PERF_COUNT = 0,
+	PERF_RESERVED1 = 1,
+	PERF_MAP = 2,
+	PERF_COPY = 3,
+	PERF_LINK = 4,
+	PERF_GETARGS = 5,
+	PERF_PUTARGS = 6,
+	PERF_RESERVED2 = 7,
+	PERF_INVOKE = 8,
+	PERF_RESERVED3 = 9,
+	PERF_KEY_MAX = 10,
+};
+
 #endif /* __QCOM_FASTRPC_H__ */
-- 
2.7.4

