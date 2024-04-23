Return-Path: <linux-kernel+bounces-154465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216FA8ADC58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7B2283848
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6F21C6A0;
	Tue, 23 Apr 2024 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NlXl/VP1"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0457C20B20
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713843689; cv=none; b=avoZRemyFE/Efw6nZqSptAmPFEzMj7MpXznpWcVLJOYF3jeRm9huyohHICVdYcal6iq/QUD/F4Eb3neo7X40gn1XcxLuzozC5TIMZa3rscLXH5+lx91ByAQDp/Ebc3CL1tvbsjuZtVaBwhrtKN132dg6NC8hB/Bvempr9fBndz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713843689; c=relaxed/simple;
	bh=+kh9BcjI07go1nGvUEVdhO4Ly9aJPFfeZnFM+8cusGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7QM5w9nVqjmjAswLrlfJVCs+WhdUc0H9ZF2fhF47PVcORb1JiAbnQdXdmX8v8Eq/QzKVbZ8eeasnZKjF+6rhXnskoDKv0vNrf2VCCeCK/uhfkSjamz9pVJJgEtJGR3XQTwCLdgR7RZNqkNDlqLA/oNFsW7xOoe9NrZVASDpEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NlXl/VP1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6eb55942409so2650918a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713843687; x=1714448487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5+no2YCmidvNin275LSwR8pI0Tp0FoxLTpLeIvaXuY=;
        b=NlXl/VP1TLcShJ0LLkVd/JJa8QUjFpTdmVq7jxQAtx90vOJzMhnTlxTUI9gF5ouM6u
         7rwz3/bgDySoqBDXegPdVpkm+pgStxxFeK7qs2FTiezRO8cocHuCu1Id5/46nygOhXRW
         2O/FwYsf33BBF8JbL2beTKjcgfOlWjL+bzJ3bdAKDS/XUTdJKLd7q3uahZ/v7sPRGARi
         xAuKYJQBEvxeEKEcwc8bI09ItKNFOZBRR2ENlorM0z8IPN0vy9R1ONBawKrPIvNzq9Tv
         eLPsmimxP5CAnXzwkkb5okE7CKQ0ZMI0zNQQwtNfb0QbTnVST39cRaJUVMmFOp1ndzRV
         Bqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713843687; x=1714448487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F5+no2YCmidvNin275LSwR8pI0Tp0FoxLTpLeIvaXuY=;
        b=sv+JYNxEVOG7mDTAnrtbFNChx7R+1NZjUitbtimd32o/mJhwYxW4UXhyruAtRZs/fx
         dZnZwdgyY/cGZ+SYN1eT41DjqdH0UDBySyazzfHQz4PDc4fhr0lcubNN7rih4DlUb2qp
         JwQPq+3/LlbpiJLdfQV5wqn/aep+D+Q1XHrKN5SSgCt4LwaiY5DHyk58nLgEAkYB4jfB
         5+hoLUvYghU7x2c5SNot2UfBd4Yp51uZxbUwqxaevhIAKBD2fTmHvR3260i7HwaM2QQS
         pwQ5CvInHTPABN8LAnKk+rVQ7MqplLWm8e7cPLJOm529JIVmEQl++T3Aq9VSFL6u+v1w
         hy4g==
X-Gm-Message-State: AOJu0YzbK02xvYW39MpKEpvVLcjXIhSzbQZSzRXLe15L9DBgxl5vBFAC
	exW001/x+MobquA2zNkXfujlmYfU8usuWLWKRluABZl0JGT+6QW/RuEdt+Vns4iz5wc8x0a/T60
	9
X-Google-Smtp-Source: AGHT+IEk5ynVvllFpoDAECg8nh7BfbCqfpMIzwNakNzM2tHibdMZWatAJwp62coEKbLv8SpF4bdD4A==
X-Received: by 2002:a05:6871:7a11:b0:22a:7899:37c4 with SMTP id pc17-20020a0568717a1100b0022a789937c4mr14499731oac.20.1713843686932;
        Mon, 22 Apr 2024 20:41:26 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id b16-20020a63d810000000b005e438fe702dsm8266980pgh.65.2024.04.22.20.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 20:41:26 -0700 (PDT)
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
Subject: [PATCH v3 3/4] virtio_balloon: introduce memory allocation stall counter
Date: Tue, 23 Apr 2024 11:41:08 +0800
Message-Id: <20240423034109.1552866-4-pizhenwei@bytedance.com>
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

Memory allocation stall counter represents the performance/latency of
memory allocation, expose this counter to the host side by virtio
balloon device via out-of-bound way.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 8 ++++++++
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index f7a47eaa0936..e6229e548832 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -322,6 +322,8 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 {
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	unsigned int idx = 0;
+	unsigned int zid;
+	unsigned long stall = 0;
 
 	all_vm_events(events);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
@@ -332,6 +334,12 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 
+	/* sum all the stall events */
+	for (zid = 0; zid < MAX_NR_ZONES; zid++)
+		stall += events[ALLOCSTALL_NORMAL - ZONE_NORMAL + zid];
+
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index b17bbe033697..487b893a160e 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -72,7 +72,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGALLOC  8  /* Hugetlb page allocations */
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
-#define VIRTIO_BALLOON_S_NR       11
+#define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
+#define VIRTIO_BALLOON_S_NR       12
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -85,7 +86,8 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "disk-caches", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
-	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills" \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


