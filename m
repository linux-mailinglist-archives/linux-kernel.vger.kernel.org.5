Return-Path: <linux-kernel+bounces-60730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A98508FA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C37B1F21384
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65C95B5A1;
	Sun, 11 Feb 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QrOoYnZq"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0E44C73
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707654619; cv=none; b=FujtyEa6Pl+zaaTOEfy36qVTfCLv+sxVEMUCkWQOmFpJr9yAL+iAySeC33c0luaMky68IkpbOdllaL1fCV+odPBxJYResstibmTk++vhffAbzvQvsqNispATdv7Kt5JmwY3uOMkL05eYDPRyzup8I9sexWyGZBchwalKBNEbBrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707654619; c=relaxed/simple;
	bh=SghTqgxhqgon/LpOV1LOZnYIRKxGEdDsUDI6nOEWbfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aCOzHuhLGKF1XQgLT2apANq1y0O+Hol775xPklMvGaGvJUVYejZCnfVyz5Pv3cT2bU+nc6RDr9tsErNMAlh14+49Z7nfNd0ZI8/efx46laKMxhcR7fBXHTrn/jN00QDUiCWHvIyMr0nghBHVu53VzUhQebazkCPAGcM0wW82vdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QrOoYnZq; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so3436305a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707654614; x=1708259414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvmxHxgb+P9LM9n9dvePcQ7EPhhjGM1zr1ro0i5QEmI=;
        b=QrOoYnZqwst05KLclhuF0wdkOQxppZQO7V2CP7AZt4O7MP4KvQxG6nDPfPqhKF4097
         DJvaztw22Chjkxpcqxa2eeeDwuA/GLbBQCWndd8KtHx7v/f62/uLgt38ebAKjbdVeCOd
         UPdklEZT0uG7Su0qvQjiObKiYBA1ZGOy2Bp7tHz91BtzBC1xRfdZf/w/Dx5WHuSIbugY
         S3Eba3F2Zs0pfQSOEmGxIb/j6nCmglmqpI6ysv4mPDfKyX7u8CRYZlh9SuU0y3+r5uCq
         sBh6aeodABMFWr/uAA5TOyiKTCeSkI8AiRnea9v6t8lql5mKHXO0EN6yzyGWYRbQbFMX
         0CrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707654614; x=1708259414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvmxHxgb+P9LM9n9dvePcQ7EPhhjGM1zr1ro0i5QEmI=;
        b=olkigWFNnJyIbPG/iHEk8m65fiRWJPoQwaMtU+gBHh0qLOQdJDSlTFXT5tfnyO6oL4
         UrOi1AuGW8VjqCyo2Rq2t7ueS19HXltObWQ6wT3oND2pvV1hdT2Ql3EAKQ4rkZ9gc98c
         F5aPSDAFgk+M4QlSzp0dPMCvovzeiaUa/ySy2LCuDv3yAj3a8x6xMPDLu9oaraQMuDEM
         8Ye1hPB1mAMSma75pivTFc9RNQnBkhTOjQ1uWsrn/a5QRokBNizrns2cX7aKhdMPyF0n
         xE1wz5VrLjdj2MrUHJUr/2fBywOPJ/Xugr8MWqbnhpqt6fVF3ey8W67f20SNQy5TmWeu
         3pJw==
X-Gm-Message-State: AOJu0YzQqF8FnjVvrQ090otKwaLtoaEEPs/DUY4uW3VMy7elXmXT6qfP
	7l2bYGDU244ON//XMUUMdOPZR+Q+9hNNxV2WAz3JtdgC87+Way8sXD2z41bLegewS00zm1o4HU5
	G
X-Google-Smtp-Source: AGHT+IF3gdKqSVIlBIKi0y8mcxDaWbA/Ui52CHdsv0CAJ7EIg3iC+ldLOvSz09q7NuhhgqpHOR35dQ==
X-Received: by 2002:a05:6402:292:b0:561:2711:68cd with SMTP id l18-20020a056402029200b00561271168cdmr2447456edv.3.1707654614102;
        Sun, 11 Feb 2024 04:30:14 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id fj18-20020a0564022b9200b0056187ca4120sm1024611edb.10.2024.02.11.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 04:30:13 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 04/35] workqueue.h: move struct delayed_work to workqueue_types.h
Date: Sun, 11 Feb 2024 13:29:29 +0100
Message-Id: <20240211123000.3359365-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211123000.3359365-1-max.kellermann@ionos.com>
References: <20240211123000.3359365-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows including workqueue_types.h instead of workqueue.h in some
headers.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/can/dev.h              | 2 +-
 include/linux/jump_label_ratelimit.h | 2 +-
 include/linux/kobject.h              | 5 ++++-
 include/linux/workqueue.h            | 9 ---------
 include/linux/workqueue_types.h      | 9 +++++++++
 include/net/netns/ipv6.h             | 2 +-
 include/sound/soc.h                  | 2 +-
 7 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 332ece824fde..91cf56179c13 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -22,7 +22,7 @@
 #include <linux/can/skb.h>
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
-#include <linux/workqueue.h> // for struct delayed_work
+#include <linux/workqueue_types.h> // for struct delayed_work
 
 /*
  * CAN mode
diff --git a/include/linux/jump_label_ratelimit.h b/include/linux/jump_label_ratelimit.h
index 8c3ee291b2d8..2b5095d3dea2 100644
--- a/include/linux/jump_label_ratelimit.h
+++ b/include/linux/jump_label_ratelimit.h
@@ -3,7 +3,7 @@
 #define _LINUX_JUMP_LABEL_RATELIMIT_H
 
 #include <linux/jump_label.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 
 #if defined(CONFIG_JUMP_LABEL)
 struct static_key_deferred {
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index da714992ab38..8890ab7bdbdc 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -24,9 +24,12 @@
 #include <linux/stdarg.h> // for va_list
 #include <linux/kref.h>
 #include <linux/kobject_ns.h>
-#include <linux/workqueue.h>
 #include <linux/uidgid_types.h>
 
+#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
+#include <linux/workqueue_types.h>
+#endif
+
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			64	/* number of env pointers */
 #define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 4ba33cf07f11..0fbc11030ba2 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -99,15 +99,6 @@ enum wq_misc_consts {
 #define WORK_DATA_STATIC_INIT()	\
 	ATOMIC_LONG_INIT((unsigned long)(WORK_STRUCT_NO_POOL | WORK_STRUCT_STATIC))
 
-struct delayed_work {
-	struct work_struct work;
-	struct timer_list timer;
-
-	/* target workqueue and CPU ->timer uses to queue ->work */
-	struct workqueue_struct *wq;
-	int cpu;
-};
-
 struct rcu_work {
 	struct work_struct work;
 	struct rcu_head rcu;
diff --git a/include/linux/workqueue_types.h b/include/linux/workqueue_types.h
index 4c38824f3ab4..e16aaa7a6661 100644
--- a/include/linux/workqueue_types.h
+++ b/include/linux/workqueue_types.h
@@ -22,4 +22,13 @@ struct work_struct {
 #endif
 };
 
+struct delayed_work {
+	struct work_struct work;
+	struct timer_list timer;
+
+	/* target workqueue and CPU ->timer uses to queue ->work */
+	struct workqueue_struct *wq;
+	int cpu;
+};
+
 #endif /* _LINUX_WORKQUEUE_TYPES_H */
diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
index 858ee28e73f9..30a55f462264 100644
--- a/include/net/netns/ipv6.h
+++ b/include/net/netns/ipv6.h
@@ -6,7 +6,7 @@
 #include <linux/list.h>
 #include <linux/spinlock_types.h>
 #include <linux/rwlock_types.h>
-#include <linux/workqueue.h> // for struct delayed_work
+#include <linux/workqueue_types.h> // for struct delayed_work
 #include <net/inet_frag.h>
 
 #ifndef __NETNS_IPV6_H__
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6defc5547ff9..0021d54625da 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/notifier.h>
-#include <linux/workqueue.h>
+#include <linux/workqueue_types.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/regmap.h>
-- 
2.39.2


