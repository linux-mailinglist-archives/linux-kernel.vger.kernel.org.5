Return-Path: <linux-kernel+bounces-108364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752D8809AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FF8B22EE8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B8711724;
	Wed, 20 Mar 2024 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="LjTcULmh"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524E2904
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902546; cv=none; b=OTBFeBnR2yB2CKM/Io9/ZpDwz2w0C2K3/MtPdyCuFAj2UIm17x011rDlMTycV6zD7Q/3IuodYQfvQbQzCTEKnJc5SFEGMW1hKbu3/1+ptikGMfYU4n3YoOOVyMl4oYIHKkYQK/dsD9M8ZCcvn6mK7wB0gDsCzsxoP8t5VFDRJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902546; c=relaxed/simple;
	bh=bfxKiZ2Bpuz4dSJFBwllmbdyHFW8D4nedhUWJ4eIxpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6KVruLs+gvIa6T09CrEWSiNIPsKgrA05QBN5L936OpDudjv4KtZM4bTiNrwaYbOq1sbEziN1u/gXZ5SYYRUEZZx1U6ZEjCm/OIfFZjDeoAQwZYMEeKvofEtu+Ztg8e2s0FMT8pNrrwTBRoO6bWJ8GW7l3FYaba3kiI9NB9kvVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=LjTcULmh; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-430c4d0408eso19373171cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1710902541; x=1711507341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iqOS+o0oT1l/HNw34tsU/JsvphKmYASr0yvHH9hC1Ss=;
        b=LjTcULmhjpKAL5THoapSzirOjowk90jWVYzNP011ANH3Dwm9/G6h9g8Tp03ULfyYH8
         TyC33xyfqSHfzPOnQBiK1y9653WESNrmXQqZsR0GO8PSEJBwhLUjlRy16PoFYx4bSj+P
         tHdIUMwf4lShVopKCwGthTT3QkYHCN3oPRjrVw7YDU8kaYDVpDn6Ad0kes93p15N+bO+
         XRZEZWchH2ZsWo+e950cjobgKSggUVMjP4S2sSeBLbDPqFlB12cwTtW2lLjx3wwGWmpn
         uuVjAwEDC9K7dCvErZ0aYu8BmAKJ+lLdfjbXvzQ1beMSNkd/q15dJxeoBcql+kBH/zI4
         Ft6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902541; x=1711507341;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iqOS+o0oT1l/HNw34tsU/JsvphKmYASr0yvHH9hC1Ss=;
        b=uzove2Mn79yvI7Sda6aq2jqz4HNVVGXoK6YMFZgzhwvtjqeSd2PVJ2Axt4gPImGdhO
         1+hfQxNPeLPjFd/HtfhBLnfjWz49I8UtVBlrMwyV1v40X9Oc4JGdWQ8spatOW1i8Yznw
         Yi7Fl8qjG484cKRXssDRdA9W4DfNnai/vjyzJEinxeoQIyj5Ijw5jzE5Z8xaSLjpNeUu
         6pYxHTKkXcGPs2ckSeCuCgGk5yr+oldwZOD1pMQSox1sOG3AphXgX6rXomnAXIsrB4r5
         3rb+WDsY/e+oERcUG6LfTnoC8Al7MNj5lz3X/yQczNJWDB7qnI5F8Iu9SaUQ6eE4rZDU
         0TTQ==
X-Forwarded-Encrypted: i=1; AJvYcCULhMKabHNB8Cleu+eMo0mxQQx9uHZTl7k/SsA12RDe+TncbB4zfraVvCx9/l7nH0k3zHy7oqzCHvgU4P+okPpd6I8MZcgzxMER9XOn
X-Gm-Message-State: AOJu0YwtXqbUz7oZN8PqQWhOcQf6ftKMZXMvAEGYOXvyw0tXGcBSFqJp
	psd4hYP7ft3q9A38HghChqyH//gb8W8I1++Rkq4SeuIdgQ6FShAgGnNVNO3jvA==
X-Google-Smtp-Source: AGHT+IFk+lAGf3V5CLYbVG5wQXqw/ssb09CFDjYho2uIfDPdBFEW3or4buauRl9+pxp4i58SExaXDQ==
X-Received: by 2002:a05:622a:1896:b0:430:d8c9:b523 with SMTP id v22-20020a05622a189600b00430d8c9b523mr5159062qtc.8.1710902540913;
        Tue, 19 Mar 2024 19:42:20 -0700 (PDT)
Received: from localhost (pool-74-98-221-57.pitbpa.fios.verizon.net. [74.98.221.57])
        by smtp.gmail.com with UTF8SMTPSA id hb4-20020a05622a2b4400b0042f0008b8b7sm4428856qtb.35.2024.03.19.19.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 19:42:20 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	dskarlat@cs.cmu.edu
Subject: [RFC PATCH 1/7] sysfs interface for the boundary of movable zone
Date: Wed, 20 Mar 2024 02:42:12 +0000
Message-Id: <20240320024218.203491-2-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
References: <20240320024218.203491-1-kaiyang2@cs.cmu.edu>
Reply-To: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Exports the pfn and memory block id for boundary

Signed-off-by: Kaiyang Zhao <zh_kaiyang@hotmail.com>
---
 drivers/base/memory.c  |  2 +-
 drivers/base/node.c    | 32 ++++++++++++++++++++++++++++++++
 include/linux/memory.h |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..281b229d7019 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -55,7 +55,7 @@ static inline unsigned long memory_block_id(unsigned long section_nr)
 	return section_nr / sections_per_block;
 }
 
-static inline unsigned long pfn_to_block_id(unsigned long pfn)
+unsigned long pfn_to_block_id(unsigned long pfn)
 {
 	return memory_block_id(pfn_to_section_nr(pfn));
 }
diff --git a/drivers/base/node.c b/drivers/base/node.c
index b46db17124f3..f29ce07565ba 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -486,6 +486,37 @@ static ssize_t node_read_meminfo(struct device *dev,
 #undef K
 static DEVICE_ATTR(meminfo, 0444, node_read_meminfo, NULL);
 
+static ssize_t node_read_movable_zone(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	int len = 0;
+	struct zone *unmovable_zone;
+	unsigned long movable_start_pfn, unmovable_end_pfn;
+	unsigned long movable_start_block_id, unmovable_end_block_id;
+
+	movable_start_pfn = NODE_DATA(dev->id)->node_zones[ZONE_MOVABLE].zone_start_pfn;
+	movable_start_block_id = pfn_to_block_id(movable_start_pfn);
+
+	if (populated_zone(&(NODE_DATA(dev->id)->node_zones[ZONE_NORMAL])))
+		unmovable_zone = &(NODE_DATA(dev->id)->node_zones[ZONE_NORMAL]);
+	else
+		unmovable_zone = &(NODE_DATA(dev->id)->node_zones[ZONE_DMA32]);
+
+	unmovable_end_pfn = zone_end_pfn(unmovable_zone);
+	unmovable_end_block_id = pfn_to_block_id(unmovable_end_pfn);
+
+	len = sysfs_emit_at(buf, len,
+			    "movable_zone_start_pfn %lu\n"
+				"movable_zone_start_block_id %lu\n"
+				"unmovable_zone_end_pfn %lu\n"
+				"unmovable_zone_end_block_id %lu\n",
+			    movable_start_pfn, movable_start_block_id,
+				unmovable_end_pfn, unmovable_end_block_id);
+
+	return len;
+}
+static DEVICE_ATTR(movable_zone, 0444, node_read_movable_zone, NULL);
+
 static ssize_t node_read_numastat(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -565,6 +596,7 @@ static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
+	&dev_attr_movable_zone.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 31343566c221..17a92a5c1ae5 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -92,6 +92,7 @@ struct memory_block {
 int arch_get_memory_phys_device(unsigned long start_pfn);
 unsigned long memory_block_size_bytes(void);
 int set_memory_block_size_order(unsigned int order);
+unsigned long pfn_to_block_id(unsigned long pfn);
 
 /* These states are exposed to userspace as text strings in sysfs */
 #define	MEM_ONLINE		(1<<0) /* exposed to userspace */
-- 
2.40.1


