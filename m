Return-Path: <linux-kernel+bounces-46656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBD844252
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E894EB2D2AC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEC912DDAF;
	Wed, 31 Jan 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RUlcw2u/"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C5C12F591
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712643; cv=none; b=snrERZ1Y/8x3KkeiD6rojZGHGoLhjpIrOrVUOm3UZqgoyay+EAIB2OhXcHYGMW3SjO7VY/Z7VwgyyqonT6/kEqEgLAw9I3hbqU6NA0GGG3AMyWh3yRI78MzomyIocvD3Z2WnrfTdv7TVjDqy6bN42BY/VRuWo19s/kwyIcoONG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712643; c=relaxed/simple;
	bh=VSrPFDVdzLC5KglvVyGoKnESxlS/kGrz7MitlkFgb3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmYwc4WUceJq51GL0GNiw271GgCUc942Kdj9JgsbrfoCSSX8vhMwYLYrLUny5pcIF17+mLDvvqyz0t50Tm0oiv+nEelJog+WohrZNIyi18i8ScVUWrMdJ6gra+2UkmujXaRTOlvaVvsn8vM8ypeOTd6hxUfoG/C5WMayUv689lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RUlcw2u/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3392b045e0aso3564231f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712636; x=1707317436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=RUlcw2u/m40ieeRQa1NCSXVbP/F7uGcnMSZuoVYBXifV11u2Cnix+5n/6kzkj+nmJd
         hMGVzPgJCI1eauUjEwpd7Ds2rELyRwMjZyY0jKcANuMbiN8bD53whRQcA4LWp2HDRfm9
         ky0Tg6hhovd+wufM5EbPyCIPOQTswz6G4CDlXW+umgBpcOQ0LhEocgpwhPpsczY+uCt3
         T0xDvH16f2+lW1D6ZFfo2dm+LhwnsjmfDtd6n1I96N+WDzJZNlKLx0/zpI0dZM8X8cI4
         Qv4wmcshEQNHqk32aZdBLbpESHrsCGl+rZeTBbgjHVg0UO3lqH+VBU3669GOWOdSZHXq
         Cwmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712636; x=1707317436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=O8UWLcHHTgYNFDGCLGlcUBewUJYBrQfW4EKzCt6Xd17CgWmNZuCTnXb0ATtyxFwxHE
         opUFdwFuU77NPeSl31eXDVBeEKa1FLKwlvLKIXllkE2ikXBYdQQZPEotPXNJxM0YuPLy
         +Q1qT+TG2ypqwu3E9iveC6F+1h0Wq1mqKRuVmuBtcVUtuj56kgXon1JQ2L0AWrcMKSBW
         XD9qpt/q3sglNd7GlvRpPGr+k3EEOF+MqSvfnL0tQlkhl69xT27o5FG0soPmVLSPY4ZE
         peS2xkMxfG2FwhpEs7+q6VyuYppbv+w6sTmmHTPFHA1EVNOmRSboUYaKXq/ReP5Nwuyl
         P7zg==
X-Gm-Message-State: AOJu0Yx4yM9oy0DqdfI7gHxPU8f7O5MQ/Xr7H8qgeO2k79zujoO4cdn1
	rkijnu6ubLzHVfcltsc13123tYahwHAvAuOe5ZzoJOw0bSE1TCU0PJb/66P5TtXWx/C77debBbT
	L
X-Google-Smtp-Source: AGHT+IGRAoPXKj3lmVnJuyqc/G/XXy84PZUU3OuvIBUUuCEJRG8er+6UniDrUjod/+pTB9WPxnBntg==
X-Received: by 2002:adf:ef44:0:b0:33a:e911:1ec0 with SMTP id c4-20020adfef44000000b0033ae9111ec0mr1286443wrp.44.1706712636275;
        Wed, 31 Jan 2024 06:50:36 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:35 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 25/28] list_bl.h: move declarations to list_bl_types.h
Date: Wed, 31 Jan 2024 15:50:05 +0100
Message-Id: <20240131145008.1345531-26-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131145008.1345531-1-max.kellermann@ionos.com>
References: <20240131145008.1345531-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By providing declarations in a lean header, we can reduce header
dependencies.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/list_bl.h       | 19 +-----------------
 include/linux/list_bl_types.h | 36 +++++++++++++++++++++++++++++++++++
 include/linux/mbcache.h       |  2 +-
 3 files changed, 38 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/list_bl_types.h

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..39c14b6bad71 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_LIST_BL_H
 #define _LINUX_LIST_BL_H
 
-#include <linux/list.h>
+#include <linux/list_bl_types.h>
 #include <linux/bit_spinlock.h>
 
 /*
@@ -30,23 +30,6 @@
 #define LIST_BL_BUG_ON(x)
 #endif
 
-
-struct hlist_bl_head {
-	struct hlist_bl_node *first;
-};
-
-struct hlist_bl_node {
-	struct hlist_bl_node *next, **pprev;
-};
-#define INIT_HLIST_BL_HEAD(ptr) \
-	((ptr)->first = NULL)
-
-static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
-{
-	h->next = NULL;
-	h->pprev = NULL;
-}
-
 #define hlist_bl_entry(ptr, type, member) container_of(ptr,type,member)
 
 static inline bool  hlist_bl_unhashed(const struct hlist_bl_node *h)
diff --git a/include/linux/list_bl_types.h b/include/linux/list_bl_types.h
new file mode 100644
index 000000000000..84229bb7bd02
--- /dev/null
+++ b/include/linux/list_bl_types.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIST_BL_TYPES_H
+#define _LINUX_LIST_BL_TYPES_H
+
+#include <linux/list.h>
+
+/*
+ * Special version of lists, where head of the list has a lock in the lowest
+ * bit. This is useful for scalable hash tables without increasing memory
+ * footprint overhead.
+ *
+ * For modification operations, the 0 bit of hlist_bl_head->first
+ * pointer must be set.
+ *
+ * With some small modifications, this can easily be adapted to store several
+ * arbitrary bits (not just a single lock bit), if the need arises to store
+ * some fast and compact auxiliary data.
+ */
+
+struct hlist_bl_head {
+	struct hlist_bl_node *first;
+};
+
+struct hlist_bl_node {
+	struct hlist_bl_node *next, **pprev;
+};
+#define INIT_HLIST_BL_HEAD(ptr) \
+	((ptr)->first = NULL)
+
+static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
+{
+	h->next = NULL;
+	h->pprev = NULL;
+}
+
+#endif
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 97e64184767d..32ebbb428053 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -3,7 +3,7 @@
 #define _LINUX_MBCACHE_H
 
 #include <linux/hash.h>
-#include <linux/list_bl.h>
+#include <linux/list_bl_types.h>
 #include <linux/list.h>
 #include <linux/atomic.h>
 #include <linux/fs.h>
-- 
2.39.2


