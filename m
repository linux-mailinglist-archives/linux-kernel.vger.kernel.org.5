Return-Path: <linux-kernel+bounces-46660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2E844254
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7252294E07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5765C13B7BF;
	Wed, 31 Jan 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Qdk5gU19"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0012CDA9
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712649; cv=none; b=BmN1/jbuwkb2HB3C5GAmDW9no+vfK56oTsohaX4t74hRyEBQNlFeZ0Dkn3cAAMgOMBNfWqy8VNE+VFgQAR4doOhBwJbWW5lfR1zP2Y/s9D6Fr90qHkR/vudcO0jSD7FhkzUd6EbCHMZX1acOQynZ9Ga1x3eQDg3OVFOzvRtjHXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712649; c=relaxed/simple;
	bh=k0CWYvaaB/gYg4+a4TXJ9LeyRASwAqQNiIxSmINjJE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GjULeREby4UCzDCyuBNHgjTbUH3GByA3Sr2ZWH9oZnJGM87UrcnBhyxQqtDj04JNTJqt0i9T4or3JE69QX6/vFpLBMGiooUjVcU9cupl4ThcK6p+Qq6JFJ6UAgH5ZEqh8ESj/J2lZYMXcw4eXx6jdzttrXziC5Sh8LRFyVmZmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Qdk5gU19; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b01484cd7so685211f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712637; x=1707317437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=Qdk5gU19rqACw5ykNFC6HMcct2v76SnWMBc53AYy4R9XzvO3O0bhVaASl3UTg+y24v
         P3RCMRzqjftx08lg6eNNxbu9hFA9UWjMeCwMLCqQMGPWdFcSfcFkFvTGFK0gs84gDSZ7
         9U83AwlAw8Or8vbebdZIkwazfM9nbLYbGK4URDnpTeZmzLVHJ7NXty7mh1omZ9yrGhI5
         fiZJYHV5hy8cQUL95pFtllGaeFk0GdKGDgmMrGw0Yf+jtNfHZDHF8OItIuEj/TWjOPSB
         Q1zJt1tECl9Zu7rvmyFWfL9vFnrI7us/esejUzk00JAHHBsBAn27L2rOBQ8JnjZ9su17
         RyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712637; x=1707317437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocDV0xt8N038gP+DLg6dR5T/0PL4+pEI/kg00OQd02E=;
        b=gsj4lyUKRlbRDSaIHQyrkdmAH6zsPsqM+RCzC5guciCYFPXuPuzDXV0rDrdAam4tqn
         3pyn4O6bMWsBFTEKwvQjN2DAHMka6oROfMZ6sCylJq5cSOFz+6TGOnYeMnyjXOfFPomW
         zjetQrnsbQ3+jgQP3RlZ3F6djC5Fa1ss0luPMeslcOS2NheEaM5v2mVEXyclsJXTZl0N
         5wtxRh27ePitbvEdG6jq554ze/k09eD0zs+F4QZA2RVFjdNYUJy9j3dB2q4WwDg9WqC7
         PQde0Chv4CmAU/pV7jJ3dYeoehKc+hno3LosfZHf1Tl7s0uFsMTL8R6fVFlUucHgpcp6
         eaMA==
X-Gm-Message-State: AOJu0YwuPUmT9wY0rBJooAZhHdUkbthQ6YrQpvJiI/iS0cRu1IjQQdPh
	W/qfkemHOo6SrLUBxoQZ9c/SOvzJGMJYg+kZ1CTpQzWA3iJbF0O28VN7f58f/k0G4aBXT5peF/s
	3
X-Google-Smtp-Source: AGHT+IFHpAqV3YiyyDgkY0Hr/Q1YkamRAGW9whPNPxSyh+n2nMl3rQcHS7kAXrgx+qhKxyvx0wCVTw==
X-Received: by 2002:adf:b313:0:b0:33b:32b:92a2 with SMTP id j19-20020adfb313000000b0033b032b92a2mr1089820wrd.68.1706712636925;
        Wed, 31 Jan 2024 06:50:36 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:36 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 26/28] percpu-rwsem.h: move declarations to percpu-rwsem_types.h
Date: Wed, 31 Jan 2024 15:50:06 +0100
Message-Id: <20240131145008.1345531-27-max.kellermann@ionos.com>
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
 include/linux/cgroup-defs.h        |  2 +-
 include/linux/percpu-rwsem.h       | 15 +--------------
 include/linux/percpu-rwsem_types.h | 24 ++++++++++++++++++++++++
 3 files changed, 26 insertions(+), 15 deletions(-)
 create mode 100644 include/linux/percpu-rwsem_types.h

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 878deefba0e1..691c50aeafae 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -16,7 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/refcount_types.h>
 #include <linux/percpu-refcount_types.h>
-#include <linux/percpu-rwsem.h>
+#include <linux/percpu-rwsem_types.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup-defs.h>
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 36b942b67b7d..0f427bd5217a 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -2,24 +2,11 @@
 #ifndef _LINUX_PERCPU_RWSEM_H
 #define _LINUX_PERCPU_RWSEM_H
 
+#include <linux/percpu-rwsem_types.h>
 #include <linux/atomic.h>
 #include <linux/percpu.h>
-#include <linux/rcuwait.h>
-#include <linux/wait.h>
-#include <linux/rcu_sync.h>
 #include <linux/lockdep.h>
 
-struct percpu_rw_semaphore {
-	struct rcu_sync		rss;
-	unsigned int __percpu	*read_count;
-	struct rcuwait		writer;
-	wait_queue_head_t	waiters;
-	atomic_t		block;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
 #else
diff --git a/include/linux/percpu-rwsem_types.h b/include/linux/percpu-rwsem_types.h
new file mode 100644
index 000000000000..0716d08b758b
--- /dev/null
+++ b/include/linux/percpu-rwsem_types.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PERCPU_RWSEM_TYPES_H
+#define _LINUX_PERCPU_RWSEM_TYPES_H
+
+#include <linux/rcu_sync.h>
+#include <linux/rcuwait.h>
+#include <linux/types.h>
+#include <linux/wait_types.h>
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#include <linux/lockdep_types.h>
+#endif
+
+struct percpu_rw_semaphore {
+	struct rcu_sync		rss;
+	unsigned int __percpu	*read_count;
+	struct rcuwait		writer;
+	wait_queue_head_t	waiters;
+	atomic_t		block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#endif
-- 
2.39.2


