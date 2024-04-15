Return-Path: <linux-kernel+bounces-144773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6C8A4A90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31DD1C21CB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D73BBCA;
	Mon, 15 Apr 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UWvTNBwq"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2A39AC9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170494; cv=none; b=HTAiHgPoX0U5uuRdNWXQhTwf1UrJcmFL7Nx0BnEKdbc6sEpjGB1hwhTJx6nGq+jFXgWGp0l0OCwmrNdVeNXJYuk8opTgtD3UvBCCmE/wAHPlG7NZeh/NgJUpe5yumTFnI2hdKHzwV3Sz5zYchJYFnatNGEebzjEkU+h67SbJ4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170494; c=relaxed/simple;
	bh=7/Cb3EbaM1UDAA5Kb72FztigJLQVxjyacKvxcUVA7Ks=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PEqfT/DhuD9lN/IwaPK9UcEgZmeDRpQ7IVK4gCoTXqPX7DoSXcQxYqKHE9KNWHplwUqN7xuO1yXET6AlD9v7V+ixfgI2D2+IhS761vkT7i1uH/5TGpg6XOoTQge0SBoIIVB0e1e7VRUyLx+StyfxzvY/syC1/zIOjfw4CgwZcF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UWvTNBwq; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36a38c13550so15206985ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1713170491; x=1713775291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12B6L10PsA9Jh230IG9uEJXqT+JXXSEjbmkq482lFPs=;
        b=UWvTNBwqEb30LmbkpjtvpeM+m7Wza2dUY909RQ9/cP8cXG879IXd1UUcYM6HI7QtBp
         6MtFOura1H6LLbuXDiyTFiwIilD8qBoFkgQrvMHVVP3J6PKgQuezISQi+kKtirNDTePR
         CS7k0CzY9SJH+fQbayXr4dMarh38Lmsi8zBbEKv6tPQnBdbX+ySLgrEQyjNb8tMi8e8Q
         oX2F84MdRJNZFz1Oz422jPfqmcTuofy9ZBePBnGSVhYmAXxRUyAXnARj/uv/U7FAobrX
         yZSfOBUU2EUEeD3l9+/pjVSg8Ha1q8HIH8Vpt/mAE88yChuleqS5vzD8PxGZmiedVZBe
         AxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170491; x=1713775291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12B6L10PsA9Jh230IG9uEJXqT+JXXSEjbmkq482lFPs=;
        b=EPCubo31DU9p2jwoQ5KfnI1gjyCO++Y0YeyutS7cgzyE+NXekZO/hDDpHxUaKUsitU
         yu7SsxpaBr3WfeycntLeGxSLqeSo0UL3mTgZeohkVq7E3mLQvKC4ERDcP2//XN3pFDkK
         CYFEhnrxK3t/QWH52gkn1fYhTOQ371ii7NlqXQWzz1P/AYiVsISM3AdrBK1DG0fVtiMJ
         irbVh+XFMdCsnS9c8oe73/GvokrJTpphl2v2bT4FdRvIW7esrfUwvwoToFOCY9sItwY/
         a9sb5YH+6YPLLbMgA7h3vsn3hvFfVSJDuSHWxltT8xw/BhDcx0cXkyDEV3mXh3DdBX58
         hANA==
X-Gm-Message-State: AOJu0Yy+j8NKuqXGYdVyMqLgAbsCNh3ziw2gSHyynYOyLZZxOlhazVoM
	g21Ab8sJjLEvurr6u91h1VkC1Dkh4s/7OAw2mwqnsS8bjRlPhErROkqsYLZimtfsZ9xB+EDIUBW
	T
X-Google-Smtp-Source: AGHT+IHu3Id3boHE0EmOQ8pWwfFovlaejeViuBMnTD/yfIQaRW2940ghQ6qCZwrhul6FRmwhdLfOtQ==
X-Received: by 2002:a92:cd81:0:b0:36b:214:bb21 with SMTP id r1-20020a92cd81000000b0036b0214bb21mr11364794ilb.25.1713170490833;
        Mon, 15 Apr 2024 01:41:30 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id k187-20020a636fc4000000b005d6a0b2efb3sm6575685pgc.21.2024.04.15.01.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 01:41:30 -0700 (PDT)
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
Subject: [RFC 1/3] virtio_balloon: introduce oom-kill invocations
Date: Mon, 15 Apr 2024 16:41:11 +0800
Message-Id: <20240415084113.1203428-2-pizhenwei@bytedance.com>
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
 drivers/virtio/virtio_balloon.c     | 2 ++
 include/uapi/linux/virtio_balloon.h | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..fd8daa742734 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -352,6 +352,8 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(available));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
 				pages_to_bytes(caches));
+	update_stat(vb, idx++, VIRTIO_BALLOON_S_OOM_KILL,
+				events[OOM_KILL]);
 
 	return idx;
 }
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..cde5547e64a7 100644
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
+	VIRTIO_BALLOON_S_NAMES_prefix "oom-kill" \
 }
 
 #define VIRTIO_BALLOON_S_NAMES VIRTIO_BALLOON_S_NAMES_WITH_PREFIX("")
-- 
2.34.1


