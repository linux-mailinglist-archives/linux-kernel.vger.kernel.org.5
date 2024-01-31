Return-Path: <linux-kernel+bounces-46635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7E844237
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174A1290D33
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69C12AAFD;
	Wed, 31 Jan 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="O/MZ69M0"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E112A14D
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712622; cv=none; b=A7iVc1W50D46iZnMznzJ+2Y8xfov9P6z+vGdc6+j0/JJlgLGUKnlOPltVtNskPH+R3oiqc3nDypYGRwJCwT+BquDsAXEs9tKGjpA7tefDi+wj28sh+uB+4OwKMcVW5eDm+YrgyXTzFiTVb8VjJpYyuXl/DQqClwxvPqokIgKKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712622; c=relaxed/simple;
	bh=L0TqMHVhB1UZMNCHBGcvyUW3Lr91Vw7fTlAoYhfqLsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcTbLFWTBIPfg7RkQcGBo79ekvFCGq+Z9+sdjG+rbnUTDmW/V8ObPdp260hw0kLeO3YUj/GC1enXIzrY/uwaAkY4Hzue0j7RgGP8atiYpS6G/a6xdtu0XBkmiCzjAaW1wNh5bN47H0tdFS3aYdgfsmemCsVzUtosaDqh1nrB8Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=O/MZ69M0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so74543f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1706712617; x=1707317417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qemn55lxLnQruxTP84ahmH21akPdk57GONW7XyEb5kI=;
        b=O/MZ69M0UZ2JvYK9uM8bNtFiBa4RtXa3CwphQxVguAK/pGaalPDMcBATXMrJlPnNSI
         RGQFlpoiNYV++0aBSkRTYjP0Kfe5q2CHUfmCpW97zKz17LkPuopw1GSeeWegNbl0pfAX
         SFTAZwHhlfYC/q7A44RO/sPKKL7Z5nE4duF/UI2ahLLlGPNGSmXRZqjmhhmdwqx6f6Lv
         9B0j4mAjVqBtsmPa1A+5PADr+a29qhjBCUCX4BW4oODawCrebCFx1tVLLXYa/d7ZMugS
         W0EqaETnVVlh5xyIpjx/uwN9IWQiDp9CZge3jQL6F6vDZNKRweAXDHLm3vCBITrfd9El
         HogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712617; x=1707317417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qemn55lxLnQruxTP84ahmH21akPdk57GONW7XyEb5kI=;
        b=lq9OaTKZrkT5IbuHltrXw2X+5dD/d+nqK1abGJbSobEkPfssHsTTgom9VVhM+DCAOO
         XESc7B0/JetR8CvHAQee2hoshuHIFHqjKp5ImxxtMLKWZG+Ke5qbqE7L30JwGp3XOuvC
         dY7be3hsvO532j2kHzB/IPbvEh44ZWTcue3wNVXqpPDq/DeyK/v01jpSqdP0Psaj8yK5
         iZkqYgkwNC980h8MI7p+GtjbSDt/l17SPdk5wsbaVps5i2hHLX7b4CEDto2vIjhgpHa+
         BeJzjjMHXCEQGHUoh7VuZCPNpbsLf/4OIEUd5d7pZ3tQ6C4Ox84tCwLNFWYa0yk1CDj7
         /BGg==
X-Gm-Message-State: AOJu0Yxkd++TQWdsW7pZ5zhL815wdJF2kWhefPWvHkNwgajMt6netSju
	8Z7Iv8VqVSFKrEMP55hyk5juVK2xkiWLyJHHW3ioY3gvel1FfukEg7tBjKr4pPRnliOgXVVJ9he
	d
X-Google-Smtp-Source: AGHT+IHHWCQxAb1gPdzAyWuQp8oxqw9JKmp38XbA6v7l1/cwA/IVlMwUPJTDU5vZ4bpSNvjlfmRBLg==
X-Received: by 2002:a5d:694f:0:b0:339:3590:b60a with SMTP id r15-20020a5d694f000000b003393590b60amr1431717wrw.59.1706712617427;
        Wed, 31 Jan 2024 06:50:17 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f2f5c00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2f:5c00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ch15-20020a5d5d0f000000b0033905a60689sm13850173wrb.45.2024.01.31.06.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:13 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 04/28] workqueue.h: move struct delayed_work to workqueue_types.h
Date: Wed, 31 Jan 2024 15:49:44 +0100
Message-Id: <20240131145008.1345531-5-max.kellermann@ionos.com>
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
index 1d58fc9f6ffb..774db9d28800 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -23,9 +23,12 @@
 #include <linux/spinlock_types.h>
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
index 232baea90a1d..0ada28ebbe16 100644
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


