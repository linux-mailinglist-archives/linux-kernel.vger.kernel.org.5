Return-Path: <linux-kernel+bounces-87586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C1086D632
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1464E289CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85AC6D522;
	Thu, 29 Feb 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i1i5/iVx"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE538DD7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709242227; cv=none; b=t/LKYjiOP9vQ5AhEr33PVruDli4ZT0uSCt25X0vz9EdlsfA/S26nQ57ENBw41gVNY3Rw1gaBZT9WXaUOqIo9/np8ssrzb/8YPxZJ8tf27oLFjDZcGPMmo/9/h0un7GT5taYq2ldg9rWLaqE9JkNnA+rfPgN980OHsDRjsC9I17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709242227; c=relaxed/simple;
	bh=5LI5FhBPLVL/nLqNxgej59M7c5t5lHMIG1duUiMYBxY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dnt26wpWegSkDmXQViCR7ZjMVWXODIQf8u1wdlW/vWaMbWq4xpOUvRhTA71E2Hf6lWpzsqkfnwWaah52b+0cqWcl886z0vlAOmxAa+3YaVrrOIEmRk2n4JcTX8SN+JYudmOUvXtAR0y0trGQqXNAFLmlO1m/OuE6tz11EOjME4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=i1i5/iVx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dca3951ad9so13298455ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709242225; x=1709847025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xh1jcXkILK80WQZmy82e7JGTZm4CDqcJRw4hqrM1eNI=;
        b=i1i5/iVx9iVsAjeABafxswUp5PfGI29P5LbrUgQ6+0DWMXV5bhi7VQ7Ke3c/jE8MTB
         fdiHTen6imxDMkfCA2c8xnXGY/u/+Y4uHyP8gOPZGeT2AfNB9j+W1t4ik/DXO1ncerpJ
         x6sUCy9Qz6HxkN8SxOm1rrg2VfBwY0Tu7y8Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709242225; x=1709847025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xh1jcXkILK80WQZmy82e7JGTZm4CDqcJRw4hqrM1eNI=;
        b=ukd7aFIUB2MjTXL7VRiMmmkWKmtNzTNnYfCFFO0T+EEUcictwXdmZEGYKPJadvf0uN
         5rdCd1J+xZAsKKlMHiczFDjBIwaYKRG73Q5sRng9DdFIsPEnDLOjUVLvIhN5WlrlMlLi
         J3K6U9nN25YeUrxz+9h1AulLe318sa5t/N0KqxtEW+Iy3srZmFHWFCuE8g+YmJUzzUlx
         RAqPZNGarst4PzbpeBdPLFwfudMa+SBR6lDxB54esGiBff5o2emuGG35hEQIDMrJMRcr
         GBSiue8+4FmALGOng02lBEKjr2WFB2uXfHCp5Tci5gGEi6gWryBPCJ5C00f8FCA8h+GO
         TZyw==
X-Forwarded-Encrypted: i=1; AJvYcCXt6UNq/ZElA8yCrIXZHP6U0Fr1xtDRarL9l8ny45DyY12o5eMWDe4PeaT6hY5MtNt+5AY10ZeAsazhkKPo0+7KKa4lTZbnQw/F5e96
X-Gm-Message-State: AOJu0Yz7FnRRUG1wBnUgiwRdiB+qxFw2KqDsthFtebVteifvWxMr3frL
	of/uuP+4PYyaOPj3bCII14cqUv9FdWGgNIrk/riXQrvLZqJrIemJZTGPKbOGjA==
X-Google-Smtp-Source: AGHT+IEUJdpSnWjoA4iBwFvgvTLMvOOcVICf9LGRpOwo2J5JJm3HZ+/auM7yPCFCw7J7d4L7kQA9pQ==
X-Received: by 2002:a17:902:f788:b0:1dc:8ba1:edc3 with SMTP id q8-20020a170902f78800b001dc8ba1edc3mr4091453pln.9.1709242225119;
        Thu, 29 Feb 2024 13:30:25 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001dc38eaa5d1sm2009536plk.181.2024.02.29.13.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:30:24 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Coco Li <lixiaoyan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netdev: Use flexible array for trailing private bytes
Date: Thu, 29 Feb 2024 13:30:22 -0800
Message-Id: <20240229213018.work.556-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=keescook@chromium.org;
 h=from:subject:message-id; bh=5LI5FhBPLVL/nLqNxgej59M7c5t5lHMIG1duUiMYBxY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl4PdtBLrEdX83S23zQRWfwyNlQTw4SUYeca8kr
 GEwg+5/BFaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeD3bQAKCRCJcvTf3G3A
 JsiPD/oCv5q3TrUymiUfaXxnvQvG+kgItEV8NdpjthDQvlVc5gFjmUc9D+F6/sdy2Z2beCQ8TT6
 1iq2lF1444sWUyo4qfJuc9jeITUPTFgbpHKhOg3KQlSXEqSDjB3ToWrqoQtS8YnAFn5niFI1G53
 Pk//UBSoE8BOX7cJ/y6WYB9W2EK7j+orB0bvrkDqXLPy1LHkgql4Su4L0UIVvVOCBmp85SN9sXD
 xOPOg2D3Y0xSgRBgpwe1axJ9jn4DZg1Ja1rCi5QckqvyGh4DeC++ee4w8g9QvWwZV/PH1mvlflw
 uF+VXOjPJzwLagpdDngobUxsFsNIvvCT0WE9mpmMfS6JgsXzZmSEbQKOccW2KoPx45QoCo6rU7N
 DDzmyqSY0KiFDv6jsZFpUAAiY9CmibX+sH6WM+Zq8sDwofihP+RS+eHk3NpLJXkpv6hMxLs6BmY
 SWW4J8sVa7oN0BRzcafpeShZBhjp2vva6nMwyvL/t4zfWR1j/0VqfonrUwd+5H0avBseXrPWceZ
 N/U69cHY7/GqaB4/vuKFXibwBo2wLiS/zjpsjdK6VeXhYBJa2VTOjZU9F8mP2/aRIfAg1748zRF
 fd4i2wBSvunxy+CUPyFuJejP3MDww6QsqNDcYBRmBjF7nkDBtHfhpHzgTRDDXEOPxyyKidzoIz9
 HBzReKg upyNa87w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce a new struct net_device_priv that contains struct net_device
but also accounts for the commonly trailing bytes through the "size" and
"data" members. As many dummy struct net_device instances exist still,
it is non-trivial to but this flexible array inside struct net_device
itself. But we can add a sanity check in netdev_priv() to catch any
attempts to access the private data of a dummy struct.

Adjust allocation logic to use the new full structure.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/netdevice.h | 21 ++++++++++++++++++---
 net/core/dev.c            | 12 ++++--------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..b476809d0bae 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1815,6 +1815,8 @@ enum netdev_stat_type {
 	NETDEV_PCPU_STAT_DSTATS, /* struct pcpu_dstats */
 };
 
+#define	NETDEV_ALIGN		32
+
 /**
  *	struct net_device - The DEVICE structure.
  *
@@ -2476,6 +2478,14 @@ struct net_device {
 	struct hlist_head	page_pools;
 #endif
 };
+
+struct net_device_priv {
+	struct net_device	dev;
+	u32			size;
+	u8			data[] __counted_by(size)
+				       __aligned(NETDEV_ALIGN);
+};
+
 #define to_net_dev(d) container_of(d, struct net_device, dev)
 
 /*
@@ -2496,8 +2506,6 @@ static inline bool netif_elide_gro(const struct net_device *dev)
 	return false;
 }
 
-#define	NETDEV_ALIGN		32
-
 static inline
 int netdev_get_prio_tc_map(const struct net_device *dev, u32 prio)
 {
@@ -2665,7 +2673,14 @@ void dev_net_set(struct net_device *dev, struct net *net)
  */
 static inline void *netdev_priv(const struct net_device *dev)
 {
-	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
+	struct net_device_priv *priv;
+
+	/* Dummy struct net_device have no trailing data. */
+	if (WARN_ON_ONCE(dev->reg_state == NETREG_DUMMY))
+		return NULL;
+
+	priv = container_of(dev, struct net_device_priv, dev);
+	return (u8 *)priv->data;
 }
 
 /* Set the sysfs physical device reference for the network logical device
diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0..0fcaf6ae8486 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10800,7 +10800,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 {
 	struct net_device *dev;
 	unsigned int alloc_size;
-	struct net_device *p;
+	struct net_device_priv *p;
 
 	BUG_ON(strlen(name) >= sizeof(dev->name));
 
@@ -10814,20 +10814,16 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 		return NULL;
 	}
 
-	alloc_size = sizeof(struct net_device);
-	if (sizeof_priv) {
-		/* ensure 32-byte alignment of private area */
-		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
-		alloc_size += sizeof_priv;
-	}
+	alloc_size = struct_size(p, data, sizeof_priv);
 	/* ensure 32-byte alignment of whole construct */
 	alloc_size += NETDEV_ALIGN - 1;
 
 	p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	if (!p)
 		return NULL;
+	p->size = sizeof_priv;
 
-	dev = PTR_ALIGN(p, NETDEV_ALIGN);
+	dev = &PTR_ALIGN(p, NETDEV_ALIGN)->dev;
 	dev->padded = (char *)dev - (char *)p;
 
 	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
-- 
2.34.1


