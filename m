Return-Path: <linux-kernel+bounces-149579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF248A930B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECED1C2095F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A1E7BAF4;
	Thu, 18 Apr 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HOgAFCV7"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A179950
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421582; cv=none; b=tG4x40t26s50c4LyOkyouJqDmBCi5P/M/vh3pbMycSntLB7Lczu/kuYmnIb24ydMCJ+7gAVADiRtkB5AcifdYFT6BomVjT1Gw0LMxc8cuKXA+5ER0+yghC4wxHLqnrQ+QVSALq2mo3KxkB2kUADrKto0D55UG/xFYtt3L2GK0us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421582; c=relaxed/simple;
	bh=iQYgmz5Gef1EaE1UJeXMcgsfVqRfmIwziXDAGoA5Vos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtWdwNPfomOHuFRUHgTmVkJWnSdXC+QQtQbLA4EnQ1JuKzUDVa8xUykd3/it4lsnV7yoHkgboQLzMo3N4qJgqpNPKKj5DcLpUbuPJ1Wc4rkg7W517777EWMhQQTZ4llUxgyikRxEyeSJ7da9E+WijCvApj81MHr+dnMrF1t7igI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HOgAFCV7; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6eb7ee5a776so267976a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713421580; x=1714026380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0vNJuhAwUKc+UYf59Hf5S0kNxOXWBcwSUDB4ktR3Zw=;
        b=HOgAFCV7xMS2sBWA27NyLnfgnQXnoSqCkjeFKJjfVa+5MVvyi9ePkKJulIgEG4CB0h
         g/wsHYnqTBiXk9qtVTXfsg9GLVp+J8KPxT/HJm1oDrfx8v82rhwvb3m+OmOQ+mEIGTA5
         9GMvQLjFe6boofkLv0tTTr8PCNGo17NGbclWgET3b4u9qRpGTnDN1VLtg4cPfwjxwHXl
         WJ5495SFkcrF4FBIQgWx9WMSWDy/ufZNtcbMfF+qCOdHR1R286pprM2bj/bJz9H38arP
         XF+hCgXqnLzgTBiTZxxTASr9Dl+eaztLXB5gc6Eu07VI4z2tbrd7524Lpcyp7NYWvi5X
         PfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421580; x=1714026380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0vNJuhAwUKc+UYf59Hf5S0kNxOXWBcwSUDB4ktR3Zw=;
        b=p9ZvGszBvW6+mQu6e0n8YjV/VhXxMKXTIgk0xVLyf092yNQSZApP9YigNDvdPiEOAV
         tnN5Enhqt+2xVZ577vT7JQgOjk5j4qfLGWPROrMBBx5XELp3DyJXTL/62jkTKB+kQPKZ
         EdNPwfEep3ovxheGBVukfb0kQalMbG4LKguLtHFVrk6bBR6JHab+Kk9jVh8GgsPN89J3
         RJsNWRa6XiZwYpvCwwQ0GQVM2dOyZwqNxV/8aFZkwo5dTygjOQL/H7Jh20EEv9S7XAEu
         Tb7jrK/TcK6dm3pD53e3MWs7Z0SYVg3sXdk23K6fFLfLbsIfTo/BbQ2vzxsuMV9N8P5d
         +V+Q==
X-Gm-Message-State: AOJu0YwsOxOEScCA1dGe0euk2jGLgPad7LztA9mEbJfHyp9dbqm+ouyz
	BHg0zpcIT8XiUXN/3ZYN1wA+jP1Xlw6HB9tcJCC5dnoLPkvkECuqEnwv4xrWzTVJm8f0MCVFuSm
	f
X-Google-Smtp-Source: AGHT+IHHR6Htepai94lycGDse6wf1IdRutz/3r1ea6ZF/gP/tH+hAUh/tHbzPsYdqQF4kLBlWMl4TA==
X-Received: by 2002:a9d:6a90:0:b0:6eb:bbc6:9af0 with SMTP id l16-20020a9d6a90000000b006ebbbc69af0mr2171391otq.12.1713421579905;
        Wed, 17 Apr 2024 23:26:19 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a632155000000b005cd8044c6fesm666392pgm.23.2024.04.17.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:26:19 -0700 (PDT)
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
Subject: [PATCH 3/3] virtio_balloon: introduce memory scan/reclaim info
Date: Thu, 18 Apr 2024 14:26:02 +0800
Message-Id: <20240418062602.1291391-4-pizhenwei@bytedance.com>
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
index e88e6573afa5..bc9332c1ae85 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -356,6 +356,15 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 	stall += events[ALLOCSTALL_MOVABLE];
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_ALLOC_STALL, stall);
 
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_SCAN,
+			pages_to_bytes(events[PGSCAN_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_SCAN,
+			pages_to_bytes(events[PGSCAN_DIRECT]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_ASYNC_RECLAIM,
+			pages_to_bytes(events[PGSTEAL_KSWAPD]));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_DIRECT_RECLAIM,
+			pages_to_bytes(events[PGSTEAL_DIRECT]));
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


