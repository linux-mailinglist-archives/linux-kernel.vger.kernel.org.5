Return-Path: <linux-kernel+bounces-109815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D76885609
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E230B1F21C83
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A4326287;
	Thu, 21 Mar 2024 08:50:08 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B7C2E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711011008; cv=none; b=dWV0PCjS0zq+9LIvLfSj/ExrJURYDny/vu2CkcZ90p1J1fMcXmJQZWrrb1luT4qlkIzX3nA7gDtVNJv18irCMJ+jOpGvdpJA34A84IOnRZqCRe8pV0jkabD9ez2k29vK/iIcUTUxSd8mmTMzP1MkXfvY2BxOUYrYIimbTc6arAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711011008; c=relaxed/simple;
	bh=fMjckmYYP6yV0RLO6xlSO3RUi89pYPoswTVP0dlylrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VINcTlVwh87yzz8wDR3Ze20HVdwMrWtpG/RdiVglXcvQkbapejFWEVkoGA1zh1nCK2N7F7knc3KdrmcMQfoqcSKn3rAnoV/wt77of2rhET4m4gSMaeVblLE5i3IjUkUHpj5VUV/qLN/GRaRhecBOPTzznMcfYmktUsF2v4mupus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0fKX5QwLz4f3mHg
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:49:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id B12C61A1153
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:50:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RG49Ptl_QV8Hg--.35067S4;
	Thu, 21 Mar 2024 16:50:00 +0800 (CST)
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
Subject: [PATCH -next] mm/slub: remove dummy slabinfo functions
Date: Thu, 21 Mar 2024 08:44:15 +0000
Message-Id: <20240321084415.265643-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RG49Ptl_QV8Hg--.35067S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxJw4fWw1kZw1rWF1xKrg_yoW8uF1xpF
	4fGw1fJa48Kr10gr4DGF48ZrySv3ZIkFW5GrZ2qasavr1UJw1vgrn5t3ykZ398WF95u397
	Xw4v9FyrX34DJrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU189N3UUUUU==
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Slab has been removed since 6.5, so there is no other versions of
slabinfo_show_stats() and slabinfo_write(), then we can remove these
two dummy functions.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
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


