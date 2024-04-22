Return-Path: <linux-kernel+bounces-152889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E0A8AC5CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C631C21009
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4E5028F;
	Mon, 22 Apr 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Wey4fnN9"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B107B4F890
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771791; cv=none; b=hpCvvty7XTifWHR5T4GGSVehX31IegoWLKwvm6gA0CzV6KRXmtEya3UdaboPrEt5zbl/WqBa7qW51Qocbvb4oN7MFcq81wRMYHjXgBB1Oa4rzAFpCWSa+YGeYPJ+O1hRhvPQjKQqE8jRCKyZ4qPeyAhV7OElP0xbexRnAWag7NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771791; c=relaxed/simple;
	bh=ITAI70NjeaKrkJrIc+02MfHU2bt8vzw+2K++tUngTyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BE9MTo4VdcgN2Xdp0YHiLVFxZsopP1TaXs3ZEvj6F3dE7Y5EgFV3VC7za0wTuYZme5+NlYLFT9yzZZJyQ964MFgrYBCvwUx49muGXnUSwXLXVCEgFKXXbJKmXBucoGzCGW3wbpZLu5HUwsHKEleKeTI2iTI/UJ+1NTtzj+NOw3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Wey4fnN9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so4069007b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 00:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713771789; x=1714376589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/EWE7HosrBQLSJgBRmTeatXRmpZ6JVLuxoFHN85xXc=;
        b=Wey4fnN9UJ3PL6Ytmz+UWu5Il3DHOpmr76m4jpQeXlHpUyZa7ZOCFaRKdAgGQu7li8
         n/5vdnL1Y5+fFaRmcrK/1nBn5/KycTEZTu36oi++kuT7i6feRYBRYSf7BcK5N+4QItBT
         l5RbzRu/QmZxZBTICZcqtksFlVMMpWgQDNcjfW/dUVEu8nwofLNfdz/hnt45o53jNLMc
         Nn6CYnmDMXXixtP/uBiV8mK7hMN0ZMTkMgxXmAaXPu/1q6kC/FblqfW8OMDs23J/uKzM
         Hwt7R6i0eT1BQLe10n1NsUK2UL6Iwlm5p25+h0jsRxUHt//efRx0dNCFG+RXBAPNy9Ga
         t9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771789; x=1714376589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/EWE7HosrBQLSJgBRmTeatXRmpZ6JVLuxoFHN85xXc=;
        b=PTF3X/Zom2kEVNw0II+pHB6ADImLBLHhke56HPH0BLF7sM8UE9HQqd5uInExucKGPD
         yUzlDaMqfdmmR2SprGokXkdiLUSP9C2teoEQrIlT/OUqsWqw3iynLfW8Rw0NBEEcr5Qo
         h0US6xTrHQmSCA3jXgRyrGc4PEVO8dOKVZWyYdmzfYKJwg78B9TG25dITbsz5PlOn2KC
         Xx97ZLmaGDWFKwmj4hxN2co67ga2xZkIyPOxXTTk2l5QdvpHQr8L0nV4YSrLT5mUZCVW
         qnZPPnSizgzbgJyUOUUGJM1yAzonv/udgtgEFiVD1Nr9URZIXsyssWqPa/ZNk0NzMItV
         kYXQ==
X-Gm-Message-State: AOJu0YzEPgSJ9gVmqPGwWwW1x6+JdY9riePBxALxQcBTiJnN1uPXtmk9
	WEJ3TVq2kAlxjrDTAjhMZk8l7NnDJ4AD342rd48BQxvpa0LQF56BvAOT1iX3Sr6dcgWe1QI7l2i
	X
X-Google-Smtp-Source: AGHT+IE2E7bgMyLmnmQSu1kHHGwGpjyE4p40kY0+jyTlKg2yf/aOeq6zrS4zsbnrUiBWDAWUZBb4Rw==
X-Received: by 2002:a05:6a21:348b:b0:1ac:3a2c:b42 with SMTP id yo11-20020a056a21348b00b001ac3a2c0b42mr12591466pzb.9.1713771788742;
        Mon, 22 Apr 2024 00:43:08 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm7595634pln.154.2024.04.22.00.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 00:43:08 -0700 (PDT)
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
Subject: [PATCH v2 2/4] virtio_balloon: introduce oom-kill invocations
Date: Mon, 22 Apr 2024 15:42:52 +0800
Message-Id: <20240422074254.1440457-3-pizhenwei@bytedance.com>
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
index 59fe157e5722..87a1d6fa77fb 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -331,6 +331,7 @@ static inline unsigned int update_balloon_vm_stats(struct virtio_balloon *vb,
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


