Return-Path: <linux-kernel+bounces-61007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C415850C42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 226CC282306
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC9739AF6;
	Sun, 11 Feb 2024 23:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="P9kTQrsy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC920310
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693362; cv=none; b=f0mdV29JHhAoii7RDBUPwZcg4fMuEYNyjsLp7rv1spo0k2l57gubhUtqh+KGjkJ8tCZ3yBWUuysKmsTkB8+Z4Ii/bjAqS3FRC/nQo+BLTXtP3RJ4Lbbtjl8dMEb8oPvCfJk9i1JsXU8GKBet+mJb4xIe42G86UK5mIvzZvWy+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693362; c=relaxed/simple;
	bh=VSrPFDVdzLC5KglvVyGoKnESxlS/kGrz7MitlkFgb3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=em9HBAGHvqIaSige5I8aQbSWn4iptn+KdlqyJTDXerSGqydGvDweKqxZjRiGFR0WZqt2DfY+RI0GL9gHuKcUhcliHPAR0FN9ySRRjNUnINTAVv2txfjvcTiF1hS5aMXxXM7gTmNQfLc25cxJ/kqV2xAljEWiwQuuKz10w7ddIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=P9kTQrsy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so3187442a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693357; x=1708298157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=P9kTQrsyxSPKz6bKFX4cb7GeAdMXMozHyJuS920EZJr6qPjADrXEzmE6slnslYO0IQ
         1nFjWXl3Z0wZcpZSsVlQjhSA9EA6zQRyUrfpbnzxcNA08SSrVi5nsUPDwkdA+TfhBeQd
         JUz54xqjaPX2EyIyPngHO/nTr61JqRZ0z8Fl5eAgoSNe9IyXiIXCTrQOEn99I11TCp/Q
         ZpF535dicfSt+C9mbeRsJaeO7J0HY3SaJdrm4pYO9cLraxWhBauXowIuaR9Gd2HMyeYE
         lzo9mjA9tKCJAkPKIaJInCs4Y0ET1ZWcRezxuFeX4p5kJGwkMN1bi7Li6XA98HcobP2H
         sVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693357; x=1708298157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XATNuKhlyKBqSR95XEzaIUlSWNysrBVPmJ96j3W9lpU=;
        b=fTB3S/061jG6geKUdOrvrtkr2qNJYz7hKqoXOpSoBMpSCVUON9+abISJSgM5FxD+Mm
         S1OfF5Bmv+G+QQrAjawwhuZ7GXztvWguyIZ73szG69tJUIszCiyC+va31sBTFXfxJTqB
         wUk7UXt9L2jsdS1Vnt32fsr/8C9UuB122kCkToFHxwSuCd2ZDzTIrsZmdS5gZvpKCu0k
         j+JA6om5y0KyrcSxKk9r9UK9ExY888/9cEE/XVvsalUWCvXU0T8i0A6Ec3fyKb4a4zNp
         Pw8yDTdafnimC9TbkNe67ashrgAYKKfsE8qljIOX9TxIV+q78HN/qIaDPFXOBbXDj71f
         msxQ==
X-Gm-Message-State: AOJu0YyPYKAsuMjSQChmuTn+v671P2l5k3N4kxbnOhiVB2qcw5wiMU64
	CxwLcInLLnxjYVMoeQCPz1BZwKYy7QM5uDP2aaWt/hWROjDPbma94ZHAvCj/I0ADbJo9aLVoEjV
	R
X-Google-Smtp-Source: AGHT+IGOZmXkH9XPJSaWUuomcmTQVXethFIo20uhVb91PcVj2dke32pbs1C4BhYos9A3Z/Yk0eYTVw==
X-Received: by 2002:aa7:d5c6:0:b0:55f:e493:33b4 with SMTP id d6-20020aa7d5c6000000b0055fe49333b4mr4250303eds.15.1707693357206;
        Sun, 11 Feb 2024 15:15:57 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:56 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 25/35] list_bl.h: move declarations to list_bl_types.h
Date: Mon, 12 Feb 2024 00:15:08 +0100
Message-Id: <20240211231518.349442-26-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
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


