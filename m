Return-Path: <linux-kernel+bounces-60984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA81E850C25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEAB2B21977
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605A51755B;
	Sun, 11 Feb 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DXfPZc1y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C06E17546
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693338; cv=none; b=p5XaPKNq+GcozwEHHa9Mydxi4FgvyVX8fjBG0D7MCs0UJwjB7K/MfrU0E1EsYB95t10jKLO17HE0OesdoOvBnigC6Z6r3FAXddGc6WWxYbg10FjUjai/MkftKyXHob40Vy0seqKXKhIZ9bVqoBX2zRv6asPnbTzAm8yC5YA6cVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693338; c=relaxed/simple;
	bh=SghTqgxhqgon/LpOV1LOZnYIRKxGEdDsUDI6nOEWbfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNs8mMg+0IOcVfbr50Qo1bGdZImrE7w9BbLhDzRCRMdaIuUCiCvcN3rNlm7cebR8ucnXNd6JVvJ531trhViIyAY2Sk76j6TgSX+6jnUECqTLxFLmnNEqIiVOVqXtv3eK/QeNaDzO31RP1N71j1FVfS8x54StIpQjWLYw7xvMIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DXfPZc1y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5116063585aso3179535e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693333; x=1708298133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvmxHxgb+P9LM9n9dvePcQ7EPhhjGM1zr1ro0i5QEmI=;
        b=DXfPZc1yYFm1+3G2G6OaPfLi8Ot1Wbtwcgi8+oGkymN51Czdi7oX/xNwGGAn+rxTpn
         bzvJjo+cchpIya0g8WB8s+xAJSYve54mEszphvUw8eVujLcki3eG44c90L00oIzSpUvF
         x3EpqDdgHrPAC3Gusv+htDuIGi67Kgci3UT5fHj2WnT+gMiO7wu1dgIyNRTZ6NSmFflK
         Lbxl8k4oyL6UO0qDg4E/CYLvVfaByt/Cv+RLBLgxcS6jXRLNXCY3//02Bd/noFURzW3+
         BsOLYSw6r6k1O5cp8b/DQGRnLWhR0nqk2+QYht9RLg0p2ICRbqljA3p6MUr5kRgXhos8
         BhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693333; x=1708298133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvmxHxgb+P9LM9n9dvePcQ7EPhhjGM1zr1ro0i5QEmI=;
        b=M+SkiuJggwTnsVhN1JOZtTyZD6sny9LqUKJLTtrQfvnBtXvQLXDRv2whAdQPsn90oF
         LXWVqWvFzgEP5PkT0jXiV/tr9lKO3RIRcqzs9nCjmbUZBpoFOEVU7Nv+6EpgiTrmD+c3
         vLlO3u4McUm5DDmqiN9l73+NMQ3WWmlPwOidQtPbzDmCv83i8PaSrfk+OoHHIMlarU1E
         fYU1vwU05a6Bh0gNKdPeFqEhnZ9PJYzkipI7jknb7ASVooosSZ4MlzkGNieYPG7ZIR2h
         y2KcsFKN+G0G6dLoZgBLDUJw9d+rX0KaQTpeAI+crUzViM9mzlYgUnD6tAoyLq1XixlY
         BMgA==
X-Gm-Message-State: AOJu0YzJ4H33qkzGApRnmCnGVkIO0lwVju8eml4jqnkKAafDS4HlG/hO
	vEVaI90JCgP+74WoVwfy5VIIXVP+9L7EQyE57GuM3guIgtT/ci+OLf9xrS1zNZXTR0RCBnqxIYk
	F
X-Google-Smtp-Source: AGHT+IFZbsPpEeP+ukpW+/tu6LLZeqnvcaEw/KKHUB30NN+OPhnDCrl3tlnnJNCP8/VpSeFX0BjQEg==
X-Received: by 2002:a05:6512:12c2:b0:511:758f:4d5c with SMTP id p2-20020a05651212c200b00511758f4d5cmr3525753lfg.21.1707693332933;
        Sun, 11 Feb 2024 15:15:32 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:15:32 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 04/35] workqueue.h: move struct delayed_work to workqueue_types.h
Date: Mon, 12 Feb 2024 00:14:47 +0100
Message-Id: <20240211231518.349442-5-max.kellermann@ionos.com>
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


