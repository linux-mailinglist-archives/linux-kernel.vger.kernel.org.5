Return-Path: <linux-kernel+bounces-72918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B5F85BAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB38E1F213FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B1867C45;
	Tue, 20 Feb 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N/0phye1"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932567754
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429013; cv=none; b=ZkGRQ0qxaQPnJKsnCVAeMsQoURJxXntiDg9uMDESYsg4lk3oVZpGA856IOea1x9ljBoG8SfbmKU9MXTPShEzc1w0ZZX69yiVjr/XnU+c12M03ZRXak/J/8jKOt2oamY2prNECSQyLeHyeYdl0Cbym4rfr0OoKUfCikPdvZ76Y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429013; c=relaxed/simple;
	bh=Rie2nYgu8JzBJQRtAAIUzOuOpCt4K1gxCq29ozAESw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJVZegFr1RkvN7RZw8inR+8pXQSpJgML/w8tJlSKB5ki7hpxr8X3U+P3r9JbgI2SRLIec3MS+qgpMiF7RM9nHY1RAG9wAMgUYQ2/8iTYcLiNocjG428/yAulgpTw1oOn1Aw26S/1xjUq+O4jCQc2irrZDuF95nf/ny7gMRxjuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N/0phye1; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708429002; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RBOoxvuwLWFkRyLKl1klmLDhYCLGEFN4RBXhRrClOKs=;
	b=N/0phye1KMu7lcFiw1rSxdcMCj0o0YMoVYzXOC1Oh14JIB0xgHjWBdWQUUcmtQgs6YQFVVxIXzAr0mbVNkCgCjacFjGehIV5RfhJ8gfywLyQp/WgxihkRyU59Tl6fq6q4Sn5mVQ9ahY2BifOTr7x2HyXoc1wUlOG1Ppo6pYL6Tc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0wabr5_1708429001;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0W0wabr5_1708429001)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 19:36:41 +0800
From: Rongwei Wang <rongwei.wang@linux.alibaba.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	pierre.gondois@arm.com,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	teng.ma@linux.alibaba.com
Subject: [PATCH v1 1/2] arch_numa: remove __init for early_cpu_to_node
Date: Tue, 20 Feb 2024 19:36:01 +0800
Message-Id: <20240220113602.6943-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
References: <20231012024842.99703-1-rongwei.wang@linux.alibaba.com>
 <20240220113602.6943-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Next, in order to support other arch, early_cpu_to_node()
will be called in a general function. We have to delete
'__init' to avoid warning messages during compiling.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
Signed-off-by: Teng Ma <teng.ma@linux.alibaba.com>
---
 drivers/base/arch_numa.c   | 2 +-
 include/asm-generic/numa.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 5b59d133b6af..90519d981471 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -144,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
 
-int __init early_cpu_to_node(int cpu)
+int early_cpu_to_node(int cpu)
 {
 	return cpu_to_node_map[cpu];
 }
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index c32e0cf23c90..16073111bffc 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -35,7 +35,7 @@ int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_free_distance(void);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
-int __init early_cpu_to_node(int cpu);
+int early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
-- 
2.32.0.3.gf3a3e56d6


