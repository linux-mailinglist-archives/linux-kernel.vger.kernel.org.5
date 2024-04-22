Return-Path: <linux-kernel+bounces-152892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CCF8AC5D2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36B9283EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF89B524A5;
	Mon, 22 Apr 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PvONompd"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA7951C4B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771797; cv=none; b=O3imbOQ4gHK9opFc/C1bownQu0YxG95dqfaQ/7WrNwQaSnWPTv+9MyT6EKRI9VU3Hwic3NRnoosBy4DLcWRpsUikBml7KvyVGfJA+DQIe2HnLDdAecVF1GJWcBPbuM3h8ZO/5saA4uKzE1OmZXOQrQEe/jAIydhhpUXMUsoeNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771797; c=relaxed/simple;
	bh=B7vOTsSVYsGFUvhOXvJRAjHPNDIwccqInso5hXY7xSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tVkTzVHBumubVuybBGh1y61aF1DLQvrQWBFiPG+mP02YTh5tg4IB4sJC/WgKnPPFHKWxZUCVB03W4iKqvgQzIdE8K3Tdkp4pdReCANrzDyFE7vKlf6IzmaGy6CJ89pzVFoP1tNH6IRQH8ABqVhUJSHW0mcgXV2pxdAxZQC5I7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PvONompd; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so39389555ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771795; x=1714376595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBFXolLQYa78XCdQIXx8hSsPDNH1h31ohatbB+q7SSA=;
        b=PvONompda1dfJWMA4hcgQXLuxfy8W0c47dT8l4VjtbvsdZMHh1/H+1G77fxzOB/2o4
         sAq4/fuQvArbunkiUxQXvV32zBLQbmjrRuH7UUmfqyUnTHTYVrlM9fBpiAe/BpP3zU3J
         qTN3jnAFsftUmHVUSvuApgN/8DAeM1F/TtMVsSSWTv9iOq9Q8xQmErbsoKZuWq6YzXKQ
         ShfUM8yysTxW39Nr8U6cQxG+DqQvvwlb2mE1Gg/WvZEpiHVqWgvBppN6VwCJWzf/5JmT
         g0kdz4a1U0XPcCvllo+pqq1HYfyukVg04/RKktlngHZ3OSY6jOgG1hr6epIjNr+vGjcH
         N5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771795; x=1714376595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBFXolLQYa78XCdQIXx8hSsPDNH1h31ohatbB+q7SSA=;
        b=SP2fl25YF4Y4uOTOX+e4TYNkTaAEm7pQ3ZBab5pApVxyKVRYNsbhiGTeWGA9QqDxDc
         7Sa7SdaX9yHZidJlMGi0PqG/PmikYHS1RMBhqk4lvHTb+3Y7QTR7qtUV5e2WzFvEbBOr
         pDeboRmH8BAbfNibSENbC9J85F+D26Axh6/eC17rEybFbnoBTHfLYJ+xsF7oyNEg88OG
         hGAxxyiwx4xkdqU5ag/T/YtSJOZQqzNXJWcyFKvDFl9HaP3S4tmhUePMccySgo+Vzf/4
         izcMAXHfA289fxtBS1iIIs7gnYpMneehJ5GUmqP8/ef7uIp5+YxSGjUvQP7KsvXi6Not
         58wA==
X-Gm-Message-State: AOJu0YzV/+2Pct/9PYMH8uJxKEoo4UjbGZpv9Ah554abgpUtf8jXBXn0
	gf6IFn90otHtaNQpNoLOuuP3jeNXsvnaQASVrTzp1dyIT147vhKJwYuSmGuBNlIvS7pFZx+kCzb
	E
X-Google-Smtp-Source: AGHT+IEvHT3XYAnqbJeBRBtYXwHjzJuRWUr3q0IHkM4UWpx7JR4+gVdQqRx7dbo9nSIw0pAVB8jXbw==
X-Received: by 2002:a17:902:784f:b0:1e4:d548:818f with SMTP id e15-20020a170902784f00b001e4d548818fmr9126943pln.58.1713771795591;
        Mon, 22 Apr 2024 00:43:15 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:15 -0700 (PDT)
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
Subject: [PATCH v2 4/4] virtio_balloon: introduce memory scan/reclaim info
Date: Mon, 22 Apr 2024 15:42:54 +0800
Message-Id: <20240422074254.1440457-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422074254.1440457-1-pizhenwei@bytedance.com>
References: <20240422074254.1440457-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose memory scan/reclaim information to the host side via virtio
balloon device.

Now we have a metric to analyze the memory performance:

y: counter increases
n: counter does not changes
h: the rate of counter change is high
l: the rate of counter change is low

OOM: VIRTIO_BALLOON_S_OOM_KILL
STALL: VIRTIO_BALLOON_S_ALLOC_STALL
ASCAN: VIRTIO_BALLOON_S_SCAN_ASYNC
DSCAN: VIRTIO_BALLOON_S_SCAN_DIRECT
ARCLM: VIRTIO_BALLOON_S_RECLAIM_ASYNC
DRCLM: VIRTIO_BALLOON_S_RECLAIM_DIRECT

- OOM[y], STALL[*], ASCAN[*], DSCAN[*], ARCLM[*], DRCLM[*]:
  the guest runs under really critial memory pressure

- OOM[n], STALL[h], ASCAN[*], DSCAN[l], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to cgroup, not the global memory
  pressure.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[h]:
  the memory allocation stalls due to global memory pressure. The
  performance gets hurt a lot. A high ratio between DRCLM/DSCAN shows
  quite effective memory reclaiming.

- OOM[n], STALL[h], ASCAN[*], DSCAN[h], ARCLM[*], DRCLM[l]:
  the memory allocation stalls due to global memory pressure.
  the ratio between DRCLM/DSCAN gets low, the guest OS is thrashing
  heavily, the serious case leads poor performance and difficult
  trouble shooting. Ex, sshd may block on memory allocation when
  accepting new connections, a user can't login a VM by ssh command.

- OOM[n], STALL[n], ASCAN[h], DSCAN[n], ARCLM[l], DRCLM[n]:
  the low ratio between ARCLM/ASCAN shows that the guest tries to
  reclaim more memory, but it can't. Once more memory is required in
  future, it will struggle to reclaim memory.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     |  9 +++++++++
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index ab039e83bc6f..e45146fde164 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -341,6 +341,15 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
 
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
+		    pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
+		    pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
+		    pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
+		    pages_to_bytes(events[PGSTEAL_DIRECT]));
+
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 487b893a160e..ee35a372805d 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -73,7 +73,11 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
 #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
-#define VIRTIO_BALLOON_S_NR       12
+#define VIRTIO_BALLOON_S_ASYNC_SCAN    12 /* Amount of memory scanned asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_SCAN   13 /* Amount of memory scanned directly */
+#define VIRTIO_BALLOON_S_ASYNC_RECLAIM 14 /* Amount of memory reclaimed asynchronously */
+#define VIRTIO_BALLOON_S_DIRECT_RECLAIM 15 /* Amount of memory reclaimed directly */
+#define VIRTIO_BALLOON_S_NR       16
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -87,7 +91,11 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
 	VIRTIO_BALLOON_S_NAMES_prefix "oom-kills", \
-	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls" \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stalls", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-scans", \
+	VIRTIO_BALLOON_S_NAMES_prefix "async-reclaims", \
+	VIRTIO_BALLOON_S_NAMES_prefix "direct-reclaims" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


