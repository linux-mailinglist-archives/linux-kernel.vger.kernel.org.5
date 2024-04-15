Return-Path: <linux-kernel+bounces-144774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9CF8A4A92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A9CB2216C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685153D56D;
	Mon, 15 Apr 2024 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FEMyBWQV"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294F3BBDC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170496; cv=none; b=kovKBfCHwVZuYUsN4/VkTOEAswYu0E4v9ZCVBiOrnGQ/868EMr3XGiWfjQdwiULPVWhqj2IGG4MqUghT3QBC1Z+eQbnsiRjUewBeIIbeYUiYOcO0KknuNKcHDM/odznYOrzdEM7l4PUPxUOxJIh9l129Wm6N9dSl6Cl+pnZIe+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170496; c=relaxed/simple;
	bh=vZqUoc3gYd+I/LHSXlUpLfccZsnhlmnxJYwDUfMYSzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8JEGKGYMpXmw8LGxYdwpEhZGlFjU8lqqvz8xte1d07vzyZoG4GAFqhiCd0YoYL70nqrKuF9ptgNIwqgK7DJlKmA5vEXhx9b4KLrDnXnA14Tz75g/fcRduXESyaOhAgBD62LMa7lU+mCSKIsTVMCIZUPlyjPURBcKGhUsJZjuE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FEMyBWQV; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5aa3af24775so2267153eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170494; x=1713775294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gn/fmyyLOBGP9D7Ah7/te94Cqx4P0YQuEb1tR3Gfsk4=;
        b=FEMyBWQV2FrEQgQLSm8cNDYj8TnCQPIUWlJjso6vLNXBGGzGA8CueFFl6sE0DdsLLH
         rSoK1RFxMX9b6f5YWfVWREGxq3hRBwqgC1OR69ZOPhTd8fP9re6lkNCqrULsjWX+4h3a
         xMyJM1GCOBgKGmriMUgDcgyuujV9VfnEznnBA1Y2H8eTDIxtkevpsgZ82y0ZNaD9Wb+l
         AXWFs4SWAz9cnnuh/vsbIuePzDCHroX7+R4udDcSxpP8nTh6Bxwqry7lROUvdTCFr+Iw
         6KTmDyO+qowVOZIez5+jyuDsmm7iKeVQVt4FeJWHHX7FKF/aEEVNLsqVgzLbXacPmhtg
         pePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170494; x=1713775294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gn/fmyyLOBGP9D7Ah7/te94Cqx4P0YQuEb1tR3Gfsk4=;
        b=mvxcBhoL5GgOQnZSoxVvk5EjWnUpk9Rud3Vjx94W3iESSokseVbLaAckCNncrjJTEJ
         9v9ao6ISsWyOxDL7WAcc8T7UuNaxuh8KFpnqWYSWYSJK2tyGB/J2NPVgaMru9F3jhNeM
         sDLtpxUmGelKGKnGK5YHRzWtf9iLJmwAbcam+i6k9W19sUMusp7EdDGxHbfgXegp2hAV
         C6XYa2afOqTXVI5eH+ZEKiT//WP/FkcntZrXARoMKtde4yfYzuIJYnTiPKl739/nEd7O
         iEpVQypIycfoMBlNNjubt01fu1qRmyP8hlAyw0/YV/VdywAGTX8/vQEh+PeUHDpiHcrD
         KdLw==
X-Gm-Message-State: AOJu0YzE5Btb/2i1V/L8bXTwjblMhhe7iSlHZhsgPN38IcOpHCFD8KPA
	L/15XIxTO8R2f3ujhijiKizXRnos1DG5suht81U9jPE5SDt4GzFdWaXmRBxuAYXEVL3qkfIbk9I
	B
X-Google-Smtp-Source: AGHT+IETdp6r2QsgZsbcC8cYUyAoKu02zRWiFTX/N1oYt3Eg7GPbdngrRxjNkXqYCiCkcAyLjTOyFg==
X-Received: by 2002:a05:6358:1396:b0:183:6427:10b6 with SMTP id n22-20020a056358139600b00183642710b6mr10637354rwi.19.1713170494297;
        Mon, 15 Apr 2024 01:41:34 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:33 -0700 (PDT)
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
Subject: [RFC 2/3] virtio_balloon: introduce memory allocation stall counter
Date: Mon, 15 Apr 2024 16:41:12 +0800
Message-Id: <20240415084113.1203428-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415084113.1203428-1-pizhenwei@bytedance.com>
References: <20240415084113.1203428-1-pizhenwei@bytedance.com>
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 19 ++++++++++++++++++-
 include/uapi/linux/virtio_balloon.h |  6 ++++--
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index fd8daa742734..4b9c9569f6e5 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -321,7 +321,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	struct sysinfo i;
 	unsigned int idx = 0;
-	long available;
+	long available, stall = 0;
 	unsigned long caches;
 
 	all_vm_events(events);
@@ -355,6 +355,23 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL,
 				events[OOM_KILL]);
 
+	/* sum all the stall event */
+#ifdef CONFIG_ZONE_DMA
+	stall += events[ALLOCSTALL_DMA];
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	stall += events[ALLOCSTALL_DMA32];
+#endif
+#ifdef CONFIG_HIGHMEM
+	stall += events[ALLOCSTALL_HIGH];
+#endif
+#ifdef CONFIG_ZONE_DEVICE
+	stall += events[ALLOCSTALL_DEVICE];
+#endif
+	stall += events[ALLOCSTALL_NORMAL];
+	stall += events[ALLOCSTALL_MOVABLE];
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
+
 	return idx;
 }
 
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index cde5547e64a7..13d0c32ba27c 100644
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
-	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill" \
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill", \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


