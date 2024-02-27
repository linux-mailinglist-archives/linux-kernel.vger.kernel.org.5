Return-Path: <linux-kernel+bounces-83873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 479EC869FAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD31D1F2E2F7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE8A524BE;
	Tue, 27 Feb 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jXlmAAsc"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10651E894
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060195; cv=none; b=qz4Rj+tvQSnhy2Upq1nTJYp8LGLQasCoaAScwUx3xkKR2KNm4tRaenRePrj6iFH9fMsA+1yKLFL9YzEx6CWHGZ4lMTkwpYvBeXQT8TMA7r9nT/FkUho0ZnIa4Ei6NS623FAb/d/adXtz1Wbv5g3ZxDHKDMyY+qenVt4XBOg1BAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060195; c=relaxed/simple;
	bh=UXncBGwnse3Lf/ZpvQhF29fpzY+ggkT8z673ohmk6vw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Lg6GRMj3muvD2qIWfVTokCflL5mzYs2PUa55LuolzGpHutgrLMx5Jk1svtVe9eWN5xJfO3805eaojMQH+Ni3Ln+70feeTHjTWKGnIoRG3D/ni56N3PSD2QIpKz9g3gTF5BRz1yZL5fd5BJvubALb3rIfc42t83KcXZKazMc/plQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jXlmAAsc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 633D220B74C0;
	Tue, 27 Feb 2024 10:56:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 633D220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709060193;
	bh=hjIha+4EvMKgXzvaM61LnapsbtfyQREDPod4KbKYY3E=;
	h=From:To:Cc:Subject:Date:From;
	b=jXlmAAsc8rO+0m1Ed3UVOii7tOupyq550Yt5fAA42MAj6EK0+p8J43rMSITZPd6Fv
	 zPnJZiLnk8dfkFF90Iujali54ySZzgdCigcvrBkWrKF31pWggyqpjH32XB+QLBhfIx
	 84A7i3CRhqx0LBJfqdqkwXE8SO6A9xKGVZ6cPU9g=
From: Allen Pais <apais@linux.microsoft.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Introduce from_wq() helper for cleaner callback declarations
Date: Tue, 27 Feb 2024 18:56:28 +0000
Message-Id: <20240227185628.5336-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To streamline the transition from tasklets to worqueues, a new helper
function, from_wq(), is introduced. This helper, inspired by existing
from_() patterns, utilizes container_of() and eliminates the redundancy
of declaring variable types, leading to more concise and readable code.

The modified code snippet demonstrates the enhanced clarity achieved
with from_wq():

  void callback(struct work_struct *w)
   {
     - struct some_data_structure *local = container_of(w,
						       struct some_data_structure,
						       work);
     + struct some_data_structure *local = from_wq(local, w, work);

This change aims to facilitate a smoother transition and uphold code
quality standards.

Based on:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v3

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 include/linux/workqueue.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7710cd52f7f0..aa61009c6fd6 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -527,6 +527,9 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 #define create_singlethread_workqueue(name)				\
 	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
 
+#define from_wq(var, callback_work, work_fieldname)	\
+	container_of(callback_work, typeof(*var), work_fieldname)
+
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
 struct workqueue_attrs *alloc_workqueue_attrs(void);
-- 
2.17.1


