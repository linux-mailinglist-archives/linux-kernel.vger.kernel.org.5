Return-Path: <linux-kernel+bounces-61462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8CF8512B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7ECD1C21FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDF039ADD;
	Mon, 12 Feb 2024 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e+sFRlJM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0339AC9
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738920; cv=none; b=k1VnIvprW0vwL5EVFgd1dNepmzh/YwghYFU4qyRg5YY27bfDa7/X36Ba76U44RCthNLUI71YLMSm52Ae0frq1f8yldMQBu15JYj0irh9vKGx7TFaCqRTP2LUFjkZfEVAkEohtlEwaMM6tW5AQJ1A3SJhxeBFI/HL0ZLU3ba1eI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738920; c=relaxed/simple;
	bh=kAYtCIIcQFYGP20Bueq7Q2euwuW3ISubaywlVMF9Oo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mz+YPm+ZIl/YSjxsh3GkA3Tgw7CTHzxP9oKooc2pR1K3dTQpEl6wOGTK/RRvL7ilrYHmwm/QJZsh6ak/cI+1OyBUk4d3rTnwTH7cq7700fSLpp1JK59qAic1aK0nHsh6sNMwnaG0Zs/Kpza6Pmk1Y63ow3VRzp4alrzwS/W5ilg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e+sFRlJM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso398885966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 03:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707738916; x=1708343716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXSVW+f0L20MyFlW669ysmJ9vw4awzPJrxZU1jMKLXw=;
        b=e+sFRlJMVcpLFf/BnnhNhP215kxYRaNJYEFUla169f05AHuelZ/8VSHBrjoUTlGVw1
         9rYieN+D4fKe3EzjZmygSKvV0DcqM9PTVXoiGIxbjsNFiU/VasvK83rCF/7HMB/hkR9h
         3yRR7OoUQNX9Hd1Tj/BASa1aazjQsTVSsjz/omuspDH9zz6gF9laAqhUWByqMMSdnhVV
         mR+KuzeM2TkeU6elU4c1u/SR0I6/ouQnDMs+Sl+6pT7nw6kYbZrd1sF37bc7tHRm/LMW
         R4u/2i8lQB/c9o0DOpsMVe1ZX/D/cz88t0Z24CkTttTcgqGaa7vC8MhKZnoXKN6TWNab
         mszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707738916; x=1708343716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXSVW+f0L20MyFlW669ysmJ9vw4awzPJrxZU1jMKLXw=;
        b=FGGZLlxgRIhjs2sBm6/79u2qWTxtXkXVJ09jEQ8om/avzlpeB1CbGYq9LYFMZ8ysd+
         JfX+kSd3AwisnyUceEAW2GbI4OnFCocG3YwIuZOuxjr+MGRv6BfP9QqXt392bozTCnfw
         NhDI+ERZT6DkI7d4Xtm/sBopQ57ddKrK9gfDbT16Jn7dmjh/y4el55xISoAYSactufol
         X8QPxfOFabpYYbT+8Kc1jcBVZwRTs5dmKzKee6EN1UOaD2qrNHSqME1sPlPjTyGB69Ka
         //n+FINZJJd4hDAjwipbs0tIYBkCSTcrx0GHDM4fEvzI0g3bEcVhWTvs4uzrA7aO6myb
         fMqA==
X-Gm-Message-State: AOJu0YwD2uIjS5Xc9wffhmj5dNbnDHerwMdA9wt2LaH/DGehoz5M6WOm
	I9t9NYYmDwQJUmP8u6/CUR0OJVklXnNVTYEZo8TH0vEmgg41gX1pDdDH8lQLAUzAzUXIxnNVNGN
	o
X-Google-Smtp-Source: AGHT+IHEDl/7PuNXK+1Av3nslepU/Ur8qKGGC+m+k7OQKjAFxaINZTd8cqbNMUxsg3S/sV+CZwySzA==
X-Received: by 2002:a17:906:6b86:b0:a3c:c54d:2a95 with SMTP id l6-20020a1709066b8600b00a3cc54d2a95mr902397ejr.37.1707738916500;
        Mon, 12 Feb 2024 03:55:16 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090607c100b00a36c3e2e52dsm139203ejc.61.2024.02.12.03.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 03:55:14 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 04/35] workqueue.h: move struct delayed_work to workqueue_types.h
Date: Mon, 12 Feb 2024 12:54:29 +0100
Message-Id: <20240212115500.2078463-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212115500.2078463-1-max.kellermann@ionos.com>
References: <20240212115500.2078463-1-max.kellermann@ionos.com>
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
index 1565bab9edc8..f09fef276b77 100644
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


