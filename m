Return-Path: <linux-kernel+bounces-59620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2738384F9C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1021287C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F797B3FF;
	Fri,  9 Feb 2024 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cBLxjTkg"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539FE7B3D2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496851; cv=none; b=Rg7Z1Mk6RSEIH6VvE1FVBYX9bG2XVtq2+WfaHyjkzjc9HUQspT9qe78Hb2PstbprlMcrcV2vwHUJ0Naz9dolceTo6UpIqXnX+m8zqjTo3ImImmFqbyqwjqD0/gL+MhwdViP3Xu/W3uo6Z8uYVAOSmx7ffe4KNtV0dpDZyIcMk7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496851; c=relaxed/simple;
	bh=SghTqgxhqgon/LpOV1LOZnYIRKxGEdDsUDI6nOEWbfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YY8aqyIgaVsBKBGgKf5ds/VnT7ALGxkTpKUYLMWi3EpT5hSlHcCMniln9Xt4I7M1QhvHJCKCxKOBoEUYi7+02GNSiJyL9ke56WWUVG4VnKHFl7AHyCbJRjjn4ORfTrZxgJ+IJvG6bWfNuJRkKvPH/IRx0M04bsEHlOAGmLGu0EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cBLxjTkg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so14715021fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 08:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707496845; x=1708101645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvmxHxgb+P9LM9n9dvePcQ7EPhhjGM1zr1ro0i5QEmI=;
        b=cBLxjTkgi/dLSGah3V99danmEsDhd36/NsmiE3XSZSwhgy2nU4f4FQo8FBXRqxyo3C
         VNudAzQo9u9rQMVQlxtof2RSSwmNQap1CEoAsLJ0mVFcDpHEWPw+wYqobmnlv6uAp/7f
         bi/vAajKAAz+tcyzgSiFVXBxgohmBzLCdLbIPP3xUMi2dyNpj3DXIk+/bP7cFaY+lTAM
         6wnXF1BaSvQnbN8EaqqAXwjTKSSAXZ7/Ro1+1BodMXxK/gcUWdOyeG1pD6GqqmzybU+R
         iyrdh6iJ26Q0vbNv8Mf5YAPlmhle04Z+Sp63g4azJF/Bhr6WAyedN8fZm9oAGOg2KUo2
         F6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707496845; x=1708101645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvmxHxgb+P9LM9n9dvePcQ7EPhhjGM1zr1ro0i5QEmI=;
        b=ncuQEzto+kucg0fAyHy63yU6kKVhWF1l/18G1daVDVVYpUWNvzFBOutCuycW3z9DAH
         BMV36hy9RpVDt5MlU3UpP1uZWL7X877ziHWp/QSyY3V1h8HVqFGOp9iYIO2Ao/+eIFmp
         2I1CkfvYXFJTqSdKgI5e+DcJGJ6Dh6hj988fsSJInLPDjFf686av8BUpdNSvTWbhk74L
         LRY31IAR/UalrKyvc3p1PMl405XaJD8t9+vym+cjsRRd4csai+PyJC23P3GTCWjwDlR1
         9eF1jRv54lxCT2uA2CGI8UDUvYESYmvFPGHVbkLYvk9n2rqqQ1cnH4a/cqKoYAX0bSKb
         8uaA==
X-Gm-Message-State: AOJu0YzGUrWK5aJrS9UGlzopkhZ5rxWFtOM5JG0NzAzNrV/M5bPHfwvl
	nhpD6Ckij4ASFTIgxTTSuMkaKU6uxDCKfACae1MCwsGkJwA2RUz+cDSz5ILTu0i75Dr23/xooe6
	L
X-Google-Smtp-Source: AGHT+IHa/C2tmOSyiJq2eOw8Un8gK58mD7rdH9WDe7gQodQ65jZXO5SYYuJSU9YtlYYKbAHF9oozNQ==
X-Received: by 2002:a05:651c:11c7:b0:2d0:d05a:2135 with SMTP id z7-20020a05651c11c700b002d0d05a2135mr1400563ljo.31.1707496845016;
        Fri, 09 Feb 2024 08:40:45 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id tl27-20020a170907c31b00b00a3bfe97fe27sm477724ejc.218.2024.02.09.08.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:40:44 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 04/35] workqueue.h: move struct delayed_work to workqueue_types.h
Date: Fri,  9 Feb 2024 17:39:56 +0100
Message-Id: <20240209164027.2582906-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
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


