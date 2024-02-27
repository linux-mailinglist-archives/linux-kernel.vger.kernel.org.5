Return-Path: <linux-kernel+bounces-83900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE4E86A047
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B65B23408
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A47A51009;
	Tue, 27 Feb 2024 19:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sTzif/MS"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE34E1DC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061044; cv=none; b=o1VCD0NtE4YFuoYxKm4NGrZNVg6QqhFlBL3dHy8StcKhw5HgrwloqG/Vp/tnB8UqV/FSEm26UZLDvXVN8Rs/gVSIJCeh2QIA8+Roh3lkJB7qdydjQV8Yt8IS0kZt5wVZSu84cM3ozG1T0bWO2KnEr9Nr2FZfkHIxq3bvsoiRnl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061044; c=relaxed/simple;
	bh=3qEYpQVEQQyEhmIlwWXIEf3W8r2LJW7QkiNvHIxXCrI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=us3WBlDYCkby1GwL0lgD68eNMx9xkUFd67RscmMhaP2nbGiubNV1yuOa/UHHbNChG+xR27+DVGGOmvHsGfFoZFWrRwbBF/uzbBzezin1dt+KhzL3Ch76KPAng8MwJv+JpJ4286L++lnXzbAQPrHC16KmyACCPFx9ujQllknaEwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sTzif/MS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from apais-vm1.0synte4vioeebbvidf5q0vz2ua.xx.internal.cloudapp.net (unknown [52.183.86.224])
	by linux.microsoft.com (Postfix) with ESMTPSA id 40FFA20B74C0;
	Tue, 27 Feb 2024 11:10:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 40FFA20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709061043;
	bh=dHXV9Ly1sQdf88TxoYBnR+fTtJ69EeUYd8QJVu9nB3c=;
	h=From:To:Cc:Subject:Date:From;
	b=sTzif/MSkVNv8hfb34KLtstgLFoccFhLMRoDXk/yZE5pvXTry6feyZkczkwJtaWvu
	 ncpE62+t9eMoOR7SqoK8Cj36Iz68+nnABl2HN5ONUG8D+cM2TomaEwFj6HpqeBdxla
	 s5yrQZrXcIKNHr25Nk0B3EuNEAoSQrIbP0iEb0Pg=
From: Allen Pais <apais@linux.microsoft.com>
To: tj@kernel.org
Cc: jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: Introduce from_work() helper for cleaner callback declarations
Date: Tue, 27 Feb 2024 19:10:37 +0000
Message-Id: <20240227191037.5839-1-apais@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

To streamline the transition from tasklets to worqueues, a new helper
function, from_work(), is introduced. This helper, inspired by existing
from_() patterns, utilizes container_of() and eliminates the redundancy
of declaring variable types, leading to more concise and readable code.

The modified code snippet demonstrates the enhanced clarity achieved
with from_wq():

  void callback(struct work_struct *w)
   {
     - struct some_data_structure *local = container_of(w,
						       struct some_data_structure,
						       work);
     + struct some_data_structure *local = from_work(local, w, work);

This change aims to facilitate a smoother transition and uphold code
quality standards.

Based on:
  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v3

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 include/linux/workqueue.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7710cd52f7f0..aedfb81f9c49 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -527,6 +527,9 @@ alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 #define create_singlethread_workqueue(name)				\
 	alloc_ordered_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, name)
 
+#define from_work(var, callback_work, work_fieldname)	\
+	container_of(callback_work, typeof(*var), work_fieldname)
+
 extern void destroy_workqueue(struct workqueue_struct *wq);
 
 struct workqueue_attrs *alloc_workqueue_attrs(void);
-- 
2.17.1


