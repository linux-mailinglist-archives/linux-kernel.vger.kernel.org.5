Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F89762DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjGZHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjGZHiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:38:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE52711;
        Wed, 26 Jul 2023 00:36:14 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q7S8sw012407;
        Wed, 26 Jul 2023 07:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=h+tcYOXfwkkh1sFUAAJhPAiHahQO/q0Lv4FWH2MIlZA=;
 b=p2L8i06wnR8qTQj56UulOURU/4X7I3QrFmndF7g3r/EzweGhR6j9Mi4OAgGIgb5+W+iX
 FR2N3lqgjNTuTP4q97c/35ZG8/GuoC1qYmXdbCSfRTufLD/0IqYJswKISMAYeEX4DUjK
 ZZGP8CrnpUy/Dk7bXpuonyUDbXXcMVruInDSGIUCNfJGZXpfnbJ25Nm+GJRbNUQCOm5B
 QktbITacuGNVjKCH/JvZ7f6vDaOeeMMFhNcj0pA9zM4YPGug5Cy4N//LFms9D8hN4GKH
 tfZ3PLF4F1E28ugFeVJ6Lqqgsiu75sEUhlvHf8JDn4w38ATxfyyf2+QUXFFEwdxFwYHq hQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2daujbv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:36:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q7a96W021529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 07:36:09 GMT
Received: from ekangupt-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 26 Jul 2023 00:36:06 -0700
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
To:     <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <fastrpc.upstream@qti.qualcomm.com>
Subject: [PATCH v1 1/2] misc: fastrpc: Redesign remote heap management
Date:   Wed, 26 Jul 2023 13:05:58 +0530
Message-ID: <1690356959-1968-2-git-send-email-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: 7CRe7pW1MudljXICIVOJYjmif_qTJ_0W
X-Proofpoint-ORIG-GUID: 7CRe7pW1MudljXICIVOJYjmif_qTJ_0W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_01,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current remote heap design comes with problems where all types
of buffers are getting added to interrupted list and also user
unmap request is not handled properly. Add changes to maintain
list in a way that it can be properly managed and used at different
audio PD specific scenarios.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
This patch depends on patch:
https://patchwork.kernel.org/project/linux-arm-msm/patch/1687528664-25235-1-git-send-email-quic_ekangupt@quicinc.com/
https://patchwork.kernel.org/project/linux-arm-msm/patch/1687529062-25988-1-git-send-email-quic_ekangupt@quicinc.com/

 drivers/misc/fastrpc.c | 177 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 141 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 4be84aa..6b2ab49 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -195,6 +195,7 @@ struct fastrpc_buf {
 	struct dma_buf *dmabuf;
 	struct device *dev;
 	void *virt;
+	u32 flag;
 	u64 phys;
 	u64 size;
 	/* Lock for dma buf attachments */
@@ -272,11 +273,11 @@ struct fastrpc_channel_ctx {
 	struct kref refcount;
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
+	bool staticpd_status;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct fastrpc_buf *remote_heap;
-	struct list_head invoke_interrupted_mmaps;
+	struct list_head rhmaps;
 	bool secure;
 	bool unsigned_support;
 	u64 dma_mask;
@@ -1199,13 +1200,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
 		fastrpc_context_put(ctx);
 	}
 
-	if (err == -ERESTARTSYS) {
-		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
-			list_del(&buf->node);
-			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
-		}
-	}
-
 	if (err)
 		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
 
@@ -1230,14 +1224,53 @@ static bool is_session_rejected(struct fastrpc_user *fl, bool unsigned_pd_reques
 	return false;
 }
 
+static int fastrpc_mmap_remove_ssr(struct fastrpc_channel_ctx *cctx)
+{
+	struct fastrpc_buf *buf, *b;
+	int err = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cctx->lock, flags);
+	list_for_each_entry_safe(buf, b, &cctx->rhmaps, node) {
+		if (cctx->vmcount) {
+			u64 src_perms = 0;
+			struct qcom_scm_vmperm dst_perms;
+			u32 i;
+
+			for (i = 0; i < cctx->vmcount; i++)
+				src_perms |= BIT(cctx->vmperms[i].vmid);
+
+			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+			dst_perms.perm = QCOM_SCM_PERM_RWX;
+			spin_unlock_irqrestore(&cctx->lock, flags);
+			err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+				&src_perms, &dst_perms, 1);
+			if (err) {
+				pr_err("%s: Failed to assign memory phys 0x%llx size 0x%llx err %d",
+					__func__, buf->phys, buf->size, err);
+				return err;
+			}
+			spin_lock_irqsave(&cctx->lock, flags);
+		}
+		list_del(&buf->node);
+		fastrpc_buf_free(buf, false);
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
+
+	return 0;
+}
+
 static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 					      char __user *argp)
 {
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
+	struct fastrpc_buf *buf = NULL;
+	u64 phys = 0, size = 0;
 	char *name;
 	int err;
+	bool scm_done = false;
 	struct {
 		int pgid;
 		u32 namelen;
@@ -1270,25 +1303,30 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_name;
 	}
 
-	if (!fl->cctx->remote_heap) {
-		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
-						&fl->cctx->remote_heap);
+	if (!fl->cctx->staticpd_status) {
+		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen, &buf);
 		if (err)
 			goto err_name;
 
+		phys = buf->phys;
+		size = buf->size;
 		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
 		if (fl->cctx->vmcount) {
 			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-							(u64)fl->cctx->remote_heap->size,
-							&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
+			err = qcom_scm_assign_mem(phys, (u64)size,
+				&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
 			if (err) {
 				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
-					fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+					phys, size, err);
 				goto err_map;
 			}
+			scm_done = true;
 		}
+		fl->cctx->staticpd_status = true;
+		spin_lock(&fl->lock);
+		list_add_tail(&buf->node, &fl->cctx->rhmaps);
+		spin_unlock(&fl->lock);
 	}
 
 	inbuf.pgid = fl->tgid;
@@ -1304,8 +1342,8 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->phys;
-	pages[0].size = fl->cctx->remote_heap->size;
+	pages[0].addr = phys;
+	pages[0].size = size;
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1322,7 +1360,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount) {
+	if (fl->cctx->vmcount && scm_done) {
 		u64 src_perms = 0;
 		struct qcom_scm_vmperm dst_perms;
 		u32 i;
@@ -1332,15 +1370,18 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
 		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
-						(u64)fl->cctx->remote_heap->size,
-						&src_perms, &dst_perms, 1);
+		err = qcom_scm_assign_mem(phys, (u64)size,
+			&src_perms, &dst_perms, 1);
 		if (err)
 			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
-				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
+				phys, size, err);
 	}
 err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
+	fl->cctx->staticpd_status = false;
+	spin_lock(&fl->lock);
+	list_del(&buf->node);
+	spin_unlock(&fl->lock);
+	fastrpc_buf_free(buf);
 err_name:
 	kfree(name);
 err:
@@ -1807,6 +1848,26 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
 				      &args[0]);
 	if (!err) {
+		if (buf->flag == ADSP_MMAP_REMOTE_HEAP_ADDR) {
+			if (fl->cctx->vmcount) {
+				u64 src_perms = 0;
+				struct qcom_scm_vmperm dst_perms;
+				u32 i;
+
+				for (i = 0; i < fl->cctx->vmcount; i++)
+					src_perms |= BIT(fl->cctx->vmperms[i].vmid);
+
+				dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+				dst_perms.perm = QCOM_SCM_PERM_RWX;
+				err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+								&src_perms, &dst_perms, 1);
+				if (err) {
+					dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
+						buf->phys, buf->size, err);
+					return err;
+				}
+			}
+		}
 		dev_dbg(dev, "unmmap\tpt 0x%09lx OK\n", buf->raddr);
 		spin_lock(&fl->lock);
 		list_del(&buf->node);
@@ -1823,7 +1884,12 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 {
 	struct fastrpc_buf *buf = NULL, *iter, *b;
 	struct fastrpc_req_munmap req;
+	struct fastrpc_munmap_req_msg req_msg;
+	struct fastrpc_map *map = NULL, *iterm, *m;
 	struct device *dev = fl->sctx->dev;
+	struct fastrpc_invoke_args args[1] = { [0] = { 0 } };
+	int err = 0;
+	u32 sc;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -1837,13 +1903,52 @@ static int fastrpc_req_munmap(struct fastrpc_user *fl, char __user *argp)
 	}
 	spin_unlock(&fl->lock);
 
-	if (!buf) {
-		dev_err(dev, "mmap\t\tpt 0x%09llx [len 0x%08llx] not in list\n",
-			req.vaddrout, req.size);
+	if (buf) {
+		err = fastrpc_req_munmap_impl(fl, buf);
+		return err;
+	}
+
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iter, b, &fl->cctx->rhmaps, node) {
+		if ((iter->raddr == req.vaddrout) && (iter->size == req.size)) {
+			buf = iter;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+	if (buf) {
+		err = fastrpc_req_munmap_impl(fl, buf);
+		return err;
+	}
+	spin_lock(&fl->lock);
+	list_for_each_entry_safe(iterm, m, &fl->maps, node) {
+		if (iterm->raddr == req.vaddrout) {
+			map = iterm;
+			break;
+		}
+	}
+	spin_unlock(&fl->lock);
+	if (!map) {
+		dev_err(dev, "map not in list\n");
 		return -EINVAL;
 	}
 
-	return fastrpc_req_munmap_impl(fl, buf);
+	req_msg.pgid = fl->tgid;
+	req_msg.size = map->size;
+	req_msg.vaddr = map->raddr;
+
+	args[0].ptr = (u64) (uintptr_t) &req_msg;
+	args[0].length = sizeof(req_msg);
+
+	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MUNMAP, 1, 0);
+	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
+				      &args[0]);
+	if (err)
+		dev_err(dev, "unmmap\tpt fd = %d, 0x%09llx error\n",  map->fd, map->raddr);
+	else
+		fastrpc_map_put(map);
+
+	return err;
 }
 
 static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
@@ -1909,6 +2014,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 
 	/* update the buffer to be able to deallocate the memory on the DSP */
 	buf->raddr = (uintptr_t) rsp_msg.vaddr;
+	buf->flag = req.flags;
 
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
@@ -1927,7 +2033,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	}
 
 	spin_lock(&fl->lock);
-	list_add_tail(&buf->node, &fl->mmaps);
+	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+		list_add_tail(&buf->node, &fl->cctx->rhmaps);
+	else
+		list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
 
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
@@ -2332,7 +2441,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
-	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
+	INIT_LIST_HEAD(&data->rhmaps);
 	spin_lock_init(&data->lock);
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
@@ -2370,13 +2479,13 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
 static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 {
 	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
-	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
 	cctx->rpdev = NULL;
+	cctx->staticpd_status = false;
 	list_for_each_entry(user, &cctx->users, user)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
@@ -2387,11 +2496,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	if (cctx->secure_fdevice)
 		misc_deregister(&cctx->secure_fdevice->miscdev);
 
-	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
-		list_del(&buf->node);
-
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	fastrpc_mmap_remove_ssr(cctx);
 
 	of_platform_depopulate(&rpdev->dev);
 
-- 
2.7.4

