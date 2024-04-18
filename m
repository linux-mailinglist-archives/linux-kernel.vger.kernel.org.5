Return-Path: <linux-kernel+bounces-149577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9C18A9307
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4E0281750
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FB16A356;
	Thu, 18 Apr 2024 06:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iVHKHLCY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D36BFA7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421576; cv=none; b=nLlvO4DPjOpeaZsBkBg99DbkOsdyNeRP0cNKxxkoMhJc7GkoFLRCJkoqOrhVodsOAxpisjt0nB9wUhvVjd/S/ASfHA4bDHmqj2MWFIc4LzrZVF4tU8g0A77sXz6/AMS4X7tInV2z2kXoC4gVr9eJvfl5cZ6VI9gFV0jPsu14ACs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421576; c=relaxed/simple;
	bh=ohLO789sHfFgMKSOwGDlzSy99Mj1iOqRNgRJnS8QIiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LRj3oRExa2/6+aGvub5WoMDpjG7WO1tb86sYzWI7zib+rozh/ZeRORva5bJYNPnaGIKvZX/ouAixWQxInlVl/Q++bkPw4CNSf0HIqbx2BUZbn2zwd/DJjegCY80ggz/uKoTr3OJzxwVxa7pg12BDunQSA/LuhNTXuqeWO2q2kDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iVHKHLCY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so341274a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421573; x=1714026373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbU6FsIuncluFPwH7VPsX/cWOPAMxIJmhU49fecmUC4=;
        b=iVHKHLCYAvsLjb3uq33ZkepPxXPC5fT3FM8HR/8c0UsUNAEy5A38yVI29GcvI6CUB7
         n033q8L9UM0McygOxv0pi5WCHl0o+VCpUuqeBVZsIbmSN57JMc6do5kjLbQ5jL1ylsdL
         6KqfBD9RniKoU+NnURrLW3agiM40XVWRpw6C7MFgZ3PpAqmnlLlPYaquwIdlSRA52aC5
         QUlGqaUQCqIScdiDIxKBef2ph8Psgaa0NnzHxGHfO8/sMZdvONQ8D5mSN9TdSGrR3CJU
         06X+Su3KHqV73cO4FUDUklbPk7SC5mq/R40USFNgvxcHdk+DohK6P1Y7VOv7EuWSSg2I
         5dDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421573; x=1714026373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbU6FsIuncluFPwH7VPsX/cWOPAMxIJmhU49fecmUC4=;
        b=o4O7rpC+E+cOCBl7zPevtj9RuouuxNsFMC6kyCfQFfqyzSuwoz9b0+80Pqekc8hVLw
         qlUfREitbjA7zRVAUGRqVp5ziKQBB6oHnGDxgqZ1xGLiPgfWUKhpiN9buOPIZDHsb3uE
         mc9dAFclO/qFxbqLHeLPyGMPfzIRJxJeYXFmitUH5GQsZSIZ8hIbCNPvgxmKGnxs0864
         X7H11NXFVsO++7zJAQfUjRYmQzzP9mzfvU4z2V51QU/MxGvGJHRvgDyOBui1V93ZztpP
         EeX52PqFTPRrAKFWo62yXhMNorjYvRBzAR8fzSMImHqctrdvjEv4eslGUNgTS1OkN6qz
         7OWA==
X-Gm-Message-State: AOJu0YxrpWUIqAN1AqKY9QRwNW8HbDvpm3sHLQHzrGlyzPH8/1jdOLmU
	rTGSNVwTj04xSIT8feH23+sesbGUsmh6aY8q1PtvyK3B24o0y6eLFSUAyetqvmcFkF7javXlWUV
	1
X-Google-Smtp-Source: AGHT+IG8KbPnW3d1OwSGwOGuRvAB4kzTNDzAERiB9f7OxYdoLKYRlUD9DImfcrUf+Wr56E8/G1LSNw==
X-Received: by 2002:a05:6a21:2709:b0:1a3:5c61:5ec2 with SMTP id rm9-20020a056a21270900b001a35c615ec2mr2398878pzb.16.1713421573195;
        Wed, 17 Apr 2024 23:26:13 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:12 -0700 (PDT)
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
Subject: [PATCH 1/3] virtio_balloon: introduce oom-kill invocations
Date: Thu, 18 Apr 2024 14:26:00 +0800
Message-Id: <20240418062602.1291391-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418062602.1291391-1-pizhenwei@bytedance.com>
References: <20240418062602.1291391-1-pizhenwei@bytedance.com>
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/virtio/virtio_balloon.c     | 1 +
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..fd19934a847f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -337,6 +337,7 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(events[PSWPOUT]));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MAJFLT, events[PGMAJFAULT]);
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_MINFLT, events[PGFAULT]);
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL, events[OOM_KILL]);
 #ifdef CONFIG_HUGETLB_PAGE
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_HTLB_PGALLOC,
 		    events[HTLB_BUDDY_PGALLOC]);
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


