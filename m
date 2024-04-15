Return-Path: <linux-kernel+bounces-144775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDF8A4A94
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805641C23602
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AC63E49E;
	Mon, 15 Apr 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hwbUmXLu"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304A383A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170500; cv=none; b=ip1RgmUIrQ7pxjjoQsLeFRlAIVh3PmXVmT072hpHpqRZTXtxHxQ4bfpYQE8X/w0S9zvboQDVtV18hn0tk5R5Xi4OtxOpnzuAAFvKfsdzGLZ338nY+g9BtQYrW4L10LVAIzazUTDTLi2db07IGTb47TGbzyvlCq7cAF+RE5MjNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170500; c=relaxed/simple;
	bh=NFrR2exu6d6NexTbth3nKYMeBa96W+PF0xe/+85rGTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4C/HOkGXgGaSBA/YF2h6HXF6m7U4PbUmDmoGo1OYywsB398SAxB8nKIOTjOwNDCGqABmeZ2DpmvgsLsiDr1r/uZ0AhTTlP7ZsiMvvGU58NmJpDGH+Ow9FHqQMYxtH8Xa/JFpzfyrs+qtPiQ6CfxksO6Vto8oJUH1lyh9JQDU64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hwbUmXLu; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22efc6b8dc5so2148666fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170497; x=1713775297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVSyUCsRBJHReEwHJLY9AUjYGa31t9M8IXFXE6DP2gA=;
        b=hwbUmXLuxKWfRKiLajsyQk/42oJOZ3pFvBzHhnQrGgREV5//YBvTikDu3JTmS+2o58
         61Sd+s5DQNlNTIVpBzwhTzPDKaY4QWJ6Rj5ZtRxndLyQFMZj+zJcJ+rowQHY3VTkyK2Y
         P9IA97lHYPJeE+fj3Evk9o7QvwwjubrRlIV+ZA8SsiNVUGlHLTg0ITBVgIl5PP7RLjhO
         ULVUYp3dXhyZErE5P1f6Z/PEEIxAlMnwPyfAgzKWbtGJ6/FSyjxfVBEiG4I8BMFZI7QB
         aj+CgJaU+2sCw47xasqjx5RWBHEwsSMK94u5a650QdcPIUhXMQ4AvcyBEJH3c9VajH5S
         2wQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170497; x=1713775297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVSyUCsRBJHReEwHJLY9AUjYGa31t9M8IXFXE6DP2gA=;
        b=iZND8gVHbu2XJyt3wPJVmvl+LibhWNwdWJU/xde7ahsMYhQap3+cyX8I5Yg/C2//zX
         0b4BSqwZ4zQx9GpE4kWkbMk7Vob6FeRCXo3Y0HBd+dDSaabk77BDHp2fnDWhbodltTVX
         VzHhPpYBmCLGs6BcgNkb0UY0J3yxzCV4TLNdBh/OpwXPgtQVt89hdEC08z8oPy1CnHqS
         JnAuT4F1eVsZj4+/ANf/UPP+ItuP1xNzF349ZOF3ZbsaPVhEubHO2BHVg7DDkQYK70HU
         lvN6kFJfCvTGhf0LI/PXKU87435lPtXnZxd4kA4nSgOSZMbws0inegQHswJ8Irs+usv/
         ujzA==
X-Gm-Message-State: AOJu0Yzi4dVS27eNON7rST6MWlx9Yxllwk+OrrjarBoCzKEBTzGyUtul
	83IJy17MX2ind5sltKevg4GhM65oAJzj9SQE60AnVZicjXpQP8eCDyx53CiQtx+xl/r7eZoPHdj
	q
X-Google-Smtp-Source: AGHT+IFLEEPCt9VyzH/L1QCrMmvcBH5qldAmYAh+iqUObe92I/ilLOhZ5GsT6F60/+szU0KPLSFuSA==
X-Received: by 2002:a05:6870:9113:b0:22f:7513:f20a with SMTP id o19-20020a056870911300b0022f7513f20amr11633580oae.55.1713170497684;
        Mon, 15 Apr 2024 01:41:37 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:37 -0700 (PDT)
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
Subject: [RFC 3/3] virtio_balloon: introduce memory scan/reclaim info
Date: Mon, 15 Apr 2024 16:41:13 +0800
Message-Id: <20240415084113.1203428-4-pizhenwei@bytedance.com>
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     |  9 +++++++++
 include/uapi/linux/virtio_balloon.h | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4b9c9569f6e5..7b86514e99d4 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -372,6 +372,15 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	stall += events[ALLOCSTALL_MOVABLE];
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_SCAN_ASYNC,
+				pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_SCAN_DIRECT,
+				pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_RECLAIM_ASYNC,
+				pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_RECLAIM_DIRECT,
+				pages_to_bytes(events[PGSTEAL_DIRECT]));
+
 	return idx;
 }
 
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index 13d0c32ba27c..0875a9cccb01 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -73,7 +73,11 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_HTLB_PGFAIL   9  /* Hugetlb page allocation failures */
 #define VIRTIO_BALLOON_S_OOM_KILL      10 /* OOM killer invocations */
 #define VIRTIO_BALLOON_S_ALLOC_STALL   11 /* Stall count of memory allocatoin */
-#define VIRTIO_BALLOON_S_NR       12
+#define VIRTIO_BALLOON_S_SCAN_ASYNC    12 /* Amount of memory scanned asynchronously */
+#define VIRTIO_BALLOON_S_SCAN_DIRECT   13 /* Amount of memory scanned directly */
+#define VIRTIO_BALLOON_S_RECLAIM_ASYNC 14 /* Amount of memory reclaimed asynchronously */
+#define VIRTIO_BALLOON_S_RECLAIM_DIRECT 15 /* Amount of memory reclaimed directly */
+#define VIRTIO_BALLOON_S_NR       16
 
 #define VIRTIO_BALLOON_S_NAMES_WITH_PREFIX(VIRTIO_BALLOON_S_NAMES_prefix) { \
 	VIRTIO_BALLOON_S_NAMES_prefix "swap-in", \
@@ -87,7 +91,11 @@ struct virtio_balloon_config {
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-allocations", \
 	VIRTIO_BALLOON_S_NAMES_prefix "hugetlb-failures", \
 	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill", \
-	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall" \
+	VIRTIO_BALLOON_S_NAMES_prefix "alloc-stall", \
+	VIRTIO_BALLOON_S_NAMES_prefix "scan-async", \
+	VIRTIO_BALLOON_S_NAMES_prefix "scan-direct", \
+	VIRTIO_BALLOON_S_NAMES_prefix "reclaim-async", \
+	VIRTIO_BALLOON_S_NAMES_prefix "reclaim-direct" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


