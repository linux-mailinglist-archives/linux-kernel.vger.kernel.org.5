Return-Path: <linux-kernel+bounces-110090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C98859EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 854BB1F2175F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA95584A37;
	Thu, 21 Mar 2024 13:23:28 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC92758AA8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027408; cv=none; b=hzWu2xnNTgWhqCZd1jwe2KPYxXMfCTiYRKI2xj6IyNNrowPSxbRkSJv0G9nhBD6Q2+PTkTpb5BaCmhGbZcIScCjXlDL41Oyl4PYc/Tf4rlTNN8CEfHoLqEt2u7tSE/kP23VJjiiJMgyXgWGYaFgihYaM0FhIwbPMjOKxml8QZO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027408; c=relaxed/simple;
	bh=q7+HFeVPV5wCPZnCZJ1tlU5gT8zKONBd02F6Aa8xQY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rV/ZGWQi81vmPFDDLrl/z4Ot/VSpUEnw5XXVkiUTpoiXHAW9edjBdeFvdkxA99M5agBY8CWI/X7S8sMd8YCYyPHGmXy655JcYxBBrdHJZpaEOTnLgIuP7+uGmpwF4pdp5vkqP2BsBZWGDhoClDYeJxhABhha+ECf8ugBXc7C29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0mNx3ShVz4f3mJM
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:23:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6FD881A0175
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:23:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHINPxlPY+PHg--.33576S4;
	Thu, 21 Mar 2024 21:23:21 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH v2 -next] mm/slub: remove dummy slabinfo functions
Date: Thu, 21 Mar 2024 13:17:33 +0000
Message-Id: <20240321131733.268615-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHINPxlPY+PHg--.33576S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyrCrW3Wr43Gw4UWw47twb_yoW8uw1DpF
	4fKw1fGa48Kr1vgr4DGF48Z34Sg3ZFkFW5GrZ2qasavr1UJw1vgrn5t3ykZ3y5WFyku397
	Xw4v9FyrX34DJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

The SLAB implementation has been removed since 6.8, so there is no
other version of slabinfo_show_stats() and slabinfo_write(), then we
can remove these two dummy functions.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
v2: correct removed version
---
 mm/slab.h        |  3 ---
 mm/slab_common.c |  2 --
 mm/slub.c        | 10 ----------
 3 files changed, 15 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index d2bc9b191222..78e205b46e19 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -496,9 +496,6 @@ struct slabinfo {
 };
 
 void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo);
-void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s);
-ssize_t slabinfo_write(struct file *file, const char __user *buffer,
-		       size_t count, loff_t *ppos);
 
 #ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f5234672f03c..67c03d6bd26c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1078,7 +1078,6 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
 		   sinfo.limit, sinfo.batchcount, sinfo.shared);
 	seq_printf(m, " : slabdata %6lu %6lu %6lu",
 		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
-	slabinfo_show_stats(m, s);
 	seq_putc(m, '\n');
 }
 
@@ -1155,7 +1154,6 @@ static const struct proc_ops slabinfo_proc_ops = {
 	.proc_flags	= PROC_ENTRY_PERMANENT,
 	.proc_open	= slabinfo_open,
 	.proc_read	= seq_read,
-	.proc_write	= slabinfo_write,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= seq_release,
 };
diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..cc7e68fbdbba 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7099,14 +7099,4 @@ void get_slabinfo(struct kmem_cache *s, struct slabinfo *sinfo)
 	sinfo->objects_per_slab = oo_objects(s->oo);
 	sinfo->cache_order = oo_order(s->oo);
 }
-
-void slabinfo_show_stats(struct seq_file *m, struct kmem_cache *s)
-{
-}
-
-ssize_t slabinfo_write(struct file *file, const char __user *buffer,
-		       size_t count, loff_t *ppos)
-{
-	return -EIO;
-}
 #endif /* CONFIG_SLUB_DEBUG */
-- 
2.34.1


