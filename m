Return-Path: <linux-kernel+bounces-49279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABF6846827
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F1AB24392
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CF179AA;
	Fri,  2 Feb 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kB0Pf2cP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39D17597;
	Fri,  2 Feb 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856058; cv=none; b=DaGOMcxU0F9ltKpMfVpaiMLOWub0wTU1vtKLiuwrllBvF68t+JkOdHEUC2a7zG/MQN2lJFRaHM2ps2f32hu9TA/2PLtdzJSCBJ1TwtoOjAtEDGVT8ebLpyvLeLV4Md53utO3kPc7xuO0X2qpS9K04AdtC3Qb3S1S8LQzjq/e/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856058; c=relaxed/simple;
	bh=cGkQjKoIQDiN5Xq6LV6z19OREy/bAcog1FZAPK4hZIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UlspnC1tAzUmHFyVaBX+ISMFSHe579ebOJs2NMyW3jtsfwZgJm3hxVOv2qEcB5PUOJzpyGnnW88Fy38FJh8jGfpf4KpyAE+J20PVzImb5o+Znltv+45j1gQH2GPM8bO8g7aTr7aPhQbGud5v4MCBLXroFKOPKJuLvJFcwf7i9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kB0Pf2cP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4121kC81006539;
	Fri, 2 Feb 2024 06:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=kmJ087AWbTEua6Ah3N05
	woyURUtVhIvftBj2hPjPeWM=; b=kB0Pf2cP75CyEeV5Jc+jECwbs+jsoFputKut
	pWnGvZTu0uXKxfkJDSpJh+ZAX3kchPNHTntDMWyOybNyehJ29/97ADXyq4oYNf/h
	YYkDitBJjHTuL8a+auTLcVe0sDkT2hnwH0N8ZRz0hHw650hkXwyFGCo5nO3YQd0p
	IEPUdd4l8kkwwOd//FONjJiaSnIySYh/+HKLz6qXuqVEwR/MrzkZDB2YL5YWA3lW
	Iln2AUUayx+MFgu1WjrEVh09efGD59oKbglDiJFka2Qz5REq85I4lLRQa15XpQBa
	7qSaJkL6fIOkqbjy3Cvv0OD6hldbq3979FYs0igUQWqMkP2WMg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00n2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:40:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126esaR027209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:40:54 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:40:52 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 02/16] misc: fastrpc: Add support for unsigned PD
Date: Fri, 2 Feb 2024 12:10:25 +0530
Message-ID: <20240202064039.15505-3-quic_ekangupt@quicinc.com>
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
X-Proofpoint-GUID: ip1CSRe35apCOx3u3JmC0ViHFYrSznYg
X-Proofpoint-ORIG-GUID: ip1CSRe35apCOx3u3JmC0ViHFYrSznYg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Unsigned PD requires more initial memory to spawn. Also most of
the memory request are allocated from userspace. Add support for
unsigned PD by increasing init memory size and handling mapping
request for cases other than DSP heap grow requests.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 184 ++++++++++++++++++++++++++---------------
 1 file changed, 118 insertions(+), 66 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f3ef5e194f11..bdce5469de19 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -38,7 +38,7 @@
 #define FASTRPC_INIT_HANDLE	1
 #define FASTRPC_DSP_UTILITIES_HANDLE	2
 #define FASTRPC_CTXID_MASK (0xFF0)
-#define INIT_FILELEN_MAX (2 * 1024 * 1024)
+#define INIT_FILELEN_MAX (5 * 1024 * 1024)
 #define INIT_FILE_NAMELEN_MAX (128)
 #define FASTRPC_DEVICE_NAME	"fastrpc"
 
@@ -303,6 +303,7 @@ struct fastrpc_user {
 	int tgid;
 	int pd;
 	bool is_secure_dev;
+	bool is_unsigned_pd;
 	/* Lock for lists */
 	spinlock_t lock;
 	/* lock for allocations */
@@ -1403,7 +1404,6 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		u32 siglen;
 	} inbuf;
 	u32 sc;
-	bool unsigned_module = false;
 
 	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
 	if (!args)
@@ -1415,9 +1415,9 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 	}
 
 	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
-		unsigned_module = true;
+		fl->is_unsigned_pd = true;
 
-	if (is_session_rejected(fl, unsigned_module)) {
+	if (is_session_rejected(fl, fl->is_unsigned_pd)) {
 		err = -ECONNREFUSED;
 		goto err;
 	}
@@ -1486,6 +1486,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
 		goto err_invoke;
 
 	kfree(args);
+	fastrpc_map_put(map);
 
 	return 0;
 
@@ -1953,98 +1954,149 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	struct fastrpc_mmap_rsp_msg rsp_msg;
 	struct fastrpc_phy_page pages;
 	struct fastrpc_req_mmap req;
+	struct fastrpc_map *map = NULL;
 	struct device *dev = fl->sctx->dev;
 	int err;
 	u32 sc;
+	unsigned long flags;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
-		dev_err(dev, "flag not supported 0x%x\n", req.flags);
+	if (req.flags == ADSP_MMAP_ADD_PAGES || req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) {
+		if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->is_unsigned_pd) {
+			dev_err(dev, "secure memory allocation is not supported in unsigned PD\n");
+			return -EINVAL;
+		}
+		if (req.vaddrin && !fl->is_unsigned_pd) {
+			dev_err(dev, "adding user allocated pages is not supported\n");
+			return -EINVAL;
+		}
 
-		return -EINVAL;
-	}
+		if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
+			err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
+		else
+			err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
 
-	if (req.vaddrin) {
-		dev_err(dev, "adding user allocated pages is not supported\n");
-		return -EINVAL;
-	}
+		if (err) {
+			dev_err(dev, "failed to allocate buffer\n");
+			return err;
+		}
 
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
-		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
-	else
-		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+		req_msg.pgid = fl->tgid;
+		req_msg.flags = req.flags;
+		req_msg.vaddr = req.vaddrin;
+		req_msg.num = sizeof(pages);
 
-	if (err) {
-		dev_err(dev, "failed to allocate buffer\n");
-		return err;
-	}
+		args[0].ptr = (u64) (uintptr_t) &req_msg;
+		args[0].length = sizeof(req_msg);
 
-	req_msg.pgid = fl->tgid;
-	req_msg.flags = req.flags;
-	req_msg.vaddr = req.vaddrin;
-	req_msg.num = sizeof(pages);
+		pages.addr = buf->phys;
+		pages.size = buf->size;
 
-	args[0].ptr = (u64) (uintptr_t) &req_msg;
-	args[0].length = sizeof(req_msg);
+		args[1].ptr = (u64) (uintptr_t) &pages;
+		args[1].length = sizeof(pages);
 
-	pages.addr = buf->phys;
-	pages.size = buf->size;
+		args[2].ptr = (u64) (uintptr_t) &rsp_msg;
+		args[2].length = sizeof(rsp_msg);
 
-	args[1].ptr = (u64) (uintptr_t) &pages;
-	args[1].length = sizeof(pages);
+		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
+					      &args[0]);
+		if (err) {
+			dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
+			goto err_invoke;
+		}
 
-	args[2].ptr = (u64) (uintptr_t) &rsp_msg;
-	args[2].length = sizeof(rsp_msg);
+		/* update the buffer to be able to deallocate the memory on the DSP */
+		buf->raddr = (uintptr_t) rsp_msg.vaddr;
+		buf->flag = req.flags;
 
-	sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
-	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
-				      &args[0]);
-	if (err) {
-		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
-		goto err_invoke;
-	}
+		/* let the client know the address to use */
+		req.vaddrout = rsp_msg.vaddr;
 
-	/* update the buffer to be able to deallocate the memory on the DSP */
-	buf->raddr = (uintptr_t) rsp_msg.vaddr;
-	buf->flag = req.flags;
+		/* Add memory to static PD pool, protection thru hypervisor */
+		if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
+			err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
+				&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
+			if (err) {
+				dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
+						buf->phys, buf->size, err);
+				goto err_assign;
+			}
+		}
 
-	/* let the client know the address to use */
-	req.vaddrout = rsp_msg.vaddr;
+		if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR) {
+			spin_lock_irqsave(&fl->cctx->lock, flags);
+			list_add_tail(&buf->node, &fl->cctx->rmaps);
+			spin_unlock_irqrestore(&fl->cctx->lock, flags);
+		} else {
+			spin_lock(&fl->lock);
+			list_add_tail(&buf->node, &fl->mmaps);
+			spin_unlock(&fl->lock);
+		}
 
-	/* Add memory to static PD pool, protection thru hypervisor */
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
-			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
-		if (err) {
-			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
-					buf->phys, buf->size, err);
+		if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
+			err = -EFAULT;
 			goto err_assign;
 		}
-	}
+	} else {
+		err = fastrpc_map_create(fl, req.fd, req.size, 0, &map);
+		if (err) {
+			dev_err(dev, "failed to map buffer, fd = %d\n", req.fd);
+			return err;
+		}
 
-	spin_lock(&fl->lock);
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
-		list_add_tail(&buf->node, &fl->cctx->rmaps);
-	else
-		list_add_tail(&buf->node, &fl->mmaps);
-	spin_unlock(&fl->lock);
+		req_msg.pgid = fl->tgid;
+		req_msg.flags = req.flags;
+		req_msg.vaddr = req.vaddrin;
+		req_msg.num = sizeof(pages);
 
-	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
-		err = -EFAULT;
-		goto err_assign;
-	}
+		args[0].ptr = (u64) (uintptr_t) &req_msg;
+		args[0].length = sizeof(req_msg);
 
-	dev_dbg(dev, "mmap\t\tpt 0x%09lx OK [len 0x%08llx]\n",
-		buf->raddr, buf->size);
+		pages.addr = map->phys;
+		pages.size = map->size;
 
+		args[1].ptr = (u64) (uintptr_t) &pages;
+		args[1].length = sizeof(pages);
+
+		args[2].ptr = (u64) (uintptr_t) &rsp_msg;
+		args[2].length = sizeof(rsp_msg);
+
+		sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_MMAP, 2, 1);
+
+		err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc,
+					      &args[0]);
+		if (err) {
+			dev_err(dev, "mmap error (len 0x%08llx)\n", map->size);
+			goto err_invoke;
+		}
+
+		/* update the buffer to be able to deallocate the memory on the DSP */
+		map->raddr = (uintptr_t) rsp_msg.vaddr;
+
+		/* let the client know the address to use */
+		req.vaddrout = rsp_msg.vaddr;
+
+		if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
+			err = -EFAULT;
+			goto err_assign;
+		}
+	}
 	return 0;
 
 err_assign:
-	fastrpc_req_munmap_impl(fl, buf);
+	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR)
+		fastrpc_map_put(map);
+	else
+		fastrpc_req_munmap_impl(fl, buf);
+
 err_invoke:
-	fastrpc_buf_free(buf);
+	if (map)
+		fastrpc_map_put(map);
+	if (buf)
+		fastrpc_buf_free(buf);
 
 	return err;
 }
-- 
2.17.0


