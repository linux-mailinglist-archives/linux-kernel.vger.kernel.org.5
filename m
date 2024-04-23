Return-Path: <linux-kernel+bounces-154464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EFF8ADC56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2431F228B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7EF208A7;
	Tue, 23 Apr 2024 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E2iiYPuH"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEC1F934
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843686; cv=none; b=OsVIvCatpOjA7PcNwAYykjQS0CJtva3n8GMf/OAZQBZJX2Rx1fiaP+rnPStwytq6O3Xs5j53u/BelzzWfH5W+6CGBeoQnd1SITGYcn+90u0LtcrMAHE45+vgd39mWHJkP8buvJFGZxSBBDYJO0vN+Wssxlf9MuCe5MhxYdqA6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843686; c=relaxed/simple;
	bh=og/1Bh1HmmM5su2/my/Vew9YvJYFlLIPs0D6nqUUBV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eqo+9DfKT/z2kEfyQIbqcPICAwaCx+r+k4YIiLu0vVvtdPzLTNau0i0rzM5k8RNPjtJveF97JEgjCfOekRCYdVGHvYRdc12N0IyspLoLIasqkvNrFevJ2UP6JISeQv03RTcFQUSTCgAuVbDDmcLQ8d4NfmTaMEXRWy2ZVdso5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E2iiYPuH; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7da37436e36so204082139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843683; x=1714448483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zk8sHHlFZ5yMas0e7wt0QxJKNRueI84ut/8EKgUk1gU=;
        b=E2iiYPuHOseBUVaZBchysHsQOOYWR5njICBeqjKVeriE3PjZql5ialdTz8bcnINDo1
         tjnwHTDcqZg9dMAq8g7S7UBVno4o2cc+I7XjsB77+x8lMlNpR0fR/yByjEozrT48GR4f
         CZf9zVV1aeNa+86l5sGAecCg6hc7zf8X5LqVTVDinUjLucteG8pyvWk3ai7QeJguop3c
         0W3XX90KIM3abb5/eiW7B9hjHnu3tcyAXGJXDmR//cWEWthqSmHwPHCL3XQ2actqPe19
         M3gs37Opg1rgoDVm6quTzcfnraZiCJikRQ/vi3EzKJiF1BEo1PQS7lWXSbS6tdJbyW+s
         S/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843683; x=1714448483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zk8sHHlFZ5yMas0e7wt0QxJKNRueI84ut/8EKgUk1gU=;
        b=sfSSq8/MRHuW/cUvbNDSDFRNYskVApr2gDIZf4FjUFjDLpQ0vnPeVBufOCAG2JTpu1
         BF3rsFyyRtYTBFU6rou3kqQuuWJklx4Z6L3Fq1G9HU19E7bgSS9Vme3IaJ/EmlJnl3+P
         ka3CbUyDJ7eHIwNVt8GdL2hBbZwZ3mRWZVr96/ywpDzv7bDdsZBX3PTg+RzDX5s2RYIT
         4UVrmN2VnUsaMqi2WLGEAEzrk9+xXEf52lI96aiiuUmJR24vd16c9q5GkHFmWMvk7gJC
         IIn/cvSnGqa/qb4ffTkbgj4+z0E65NK1bDz5mDTDKmBAk5BEq7aRV9dra3BTMb7mVuXe
         EovA==
X-Gm-Message-State: AOJu0Yzz+gQG+3Sc/A+GY1DcpGSLYnXTlg7dHZ5T7UX2iXaqq+oUvQsT
	uAY5UmMwaGYRHL70K6e6dib8X/3ly6geEftflRVgAP7sO6utQQ1aOVnoklgg7NHibE2NI2u9/mt
	H
X-Google-Smtp-Source: AGHT+IGK5wXI7LkTDRk5nDef0rXFGK962Vq/MSDSyQakfWBHz0PVFwhhTJdfJ5JmoY+i8cpaYiedhg==
X-Received: by 2002:a92:c267:0:b0:36a:fe86:5fcc with SMTP id h7-20020a92c267000000b0036afe865fccmr16168240ild.0.1713843683557;
        Mon, 22 Apr 2024 20:41:23 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:23 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: mst@redhat.com,
	david@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	akpm@linux-foundation.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 2/4] virtio_balloon: introduce oom-kill invocations
Date: Tue, 23 Apr 2024 11:41:07 +0800
Message-Id: <20240423034109.1552866-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423034109.1552866-1-pizhenwei@bytedance.com>
References: <20240423034109.1552866-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the guest OS runs under critical memory pressure, the guest
starts to kill processes. A guest monitor agent may scan 'oom_kill'
from /proc/vmstat, and reports the OOM KILL event. However, the agent
may be killed and we will loss this critical event(and the later
events).

For now we can also grep for magic words in guest kernel log from host
side. Rather than this unstable way, virtio balloon reports OOM-KILL
invocations instead.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 1 +
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1710e3098ecd..f7a47eaa0936 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -330,6 +330,7 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 		    pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..b17bbe033697 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -71,7 +71,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
-#define VIRTIO_BALLOON_S_NR       10
+#define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
+#define VIRTIO_BALLOON_S_NR       11
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -83,7 +84,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "available-memory", \
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
-	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures" \
+	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


