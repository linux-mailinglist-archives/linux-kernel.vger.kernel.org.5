Return-Path: <linux-kernel+bounces-89916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6086F746
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 22:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C7FB20BA5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 21:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAD7B3FA;
	Sun,  3 Mar 2024 21:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="tP30Um7+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567727A70E
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 21:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709502440; cv=none; b=qEKVLG8CEPCyXauxkaiAO9BLZb2UuWfBAWTOJ0NmBbIxBUWjDXE9Roj9q5M3DTKqMPZK8FEBHaafejtuc0WuBykstP+ZTF+AEstV45XAXJr3kxf/6XeG+V2tqajFUeXEAJjhLvjtG1/TvbEsIlOfyumS8J+LUHK5wfxVFzAC6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709502440; c=relaxed/simple;
	bh=MCNa9ztFUE2oUlEReP56MHU0MfrXs710iqZ4Zm20fuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+6XZu3VS35E17aAPtacI0y171/0z1eQcc1Hw4dbaH45nc0p89ufaMw5woB3+i9QtHS+eQxGcIaJWUDbWkirFGOcnQgDCjlbY2N6KLp1dvRvjfsewvm17N5uc2xUN+et3X0Vy/9eWU6P1TVk3a+k9nj69hb1WHPpscRSkIAGk9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=tP30Um7+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412de4e7d9cso4914575e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 13:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1709502435; x=1710107235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqqXDHwWxaVlf6JANUXu9UPKsRPCn/ZbiyHMKl1BV6c=;
        b=tP30Um7+YiQQOC4PP+Kx9nr1qP+UACthuC/PrAhG8dIxgg/NoxyQsFltKAuyW1/aTh
         3tnvXu8Xi4EBGvwgMSzXKy6s+ZyKrZebHNx3HFtedSSHsqst8bOQvqWnu5yEhQjuDaRz
         AeBHFhpIxadxpldCvxFuLS9TVTr+xPWsR72MwRQzpUaDAarUXjhXpykJS/XbvPaTFkST
         OaPi0E5t9hEw2p8v7RtqCse58sr3piaEbvYr2KCbxI7hJ1EC8jECvqdeVjhcT6XnwejI
         Yja4degf6M4cKtHFLL3rSasqRcpH8brDC3/6p9JSJG0T3PpflUf1RPf0kGiTkZOD3uoz
         x+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502435; x=1710107235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cqqXDHwWxaVlf6JANUXu9UPKsRPCn/ZbiyHMKl1BV6c=;
        b=o6fwxvvJYtCTFigchInnAro259s+6UEVp3dKJERTsr9sUNiKUKcVb4HSgprEcfxfC/
         yrmAOihabDo1DYu4q/wYJmGrbgZmxglIvNEdZOfU8fm8+RMVBJv1/caRuv6vUDaA9uV7
         zazaeo2tVbFSiwXuoY8cVt6fGjTvWufnp3WqYvMWYWylVy7yFzSYL8iuJQ8LsCyr3+Pf
         HdlanzedgYljivqCRYQszqTSpJc4ZOepAFN7KacFNObP3Ajx2eoefXnlRvJVXLrqbm2a
         ngb+Z/mgWpcCj1/MwdjSrmPyzZsitU81kTpRooQKsGiRnNHpm4hEb64Smy+moVAd8qz+
         fBDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSlWum/KmD8Ae+dyy+lRSaLRKD+SCR3AOFip453k00R+Hnl3VHZIa6eRPoa2xuSsOpD/MmMAJr0oQJgCJGedfuP1u2quzhEfQDh8B8
X-Gm-Message-State: AOJu0YwxFTJ/3YPTH4BONzKJd13a+3kWM3exvLekMYAorUtwrrVHxc8z
	sxAGl+1lgnmKanqU903iT2AppMWliGJck2UC9K5A+Zk+FttsGJoKDJeGduzrVo4=
X-Google-Smtp-Source: AGHT+IHsU9Go1PGnEF0+qHk3RasU+lHfGUIjRLpbGvpRMXmpheJjleZjVndsSqNEb4oFGICOc46gBw==
X-Received: by 2002:a05:600c:34c3:b0:412:de7e:b997 with SMTP id d3-20020a05600c34c300b00412de7eb997mr1679611wmq.11.1709502435707;
        Sun, 03 Mar 2024 13:47:15 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.numericable.fr ([89.159.1.53])
        by smtp.gmail.com with ESMTPSA id bu16-20020a056000079000b0033dc3f3d689sm10525236wrb.93.2024.03.03.13.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:47:15 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>,
	Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v6 2/3] printk: Change type of CONFIG_BASE_SMALL to bool
Date: Sun,  3 Mar 2024 22:46:51 +0100
Message-Id: <20240303214652.727140-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240303214652.727140-1-yoann.congal@smile.fr>
References: <20240303214652.727140-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_BASE_SMALL is currently a type int but is only used as a boolean.

So, change its type to bool and adapt all usages:
CONFIG_BASE_SMALL == 0 becomes !IS_ENABLED(CONFIG_BASE_SMALL) and
CONFIG_BASE_SMALL != 0 becomes  IS_ENABLED(CONFIG_BASE_SMALL).

Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 arch/x86/include/asm/mpspec.h | 6 +++---
 drivers/tty/vt/vc_screen.c    | 2 +-
 include/linux/threads.h       | 4 ++--
 include/linux/udp.h           | 2 +-
 include/linux/xarray.h        | 2 +-
 init/Kconfig                  | 6 ++----
 kernel/futex/core.c           | 2 +-
 kernel/user.c                 | 2 +-
 8 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 4b0f98a8d338d..c01d3105840cf 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -15,10 +15,10 @@ extern int pic_mode;
  * Summit or generic (i.e. installer) kernels need lots of bus entries.
  * Maximum 256 PCI busses, plus 1 ISA bus in each of 4 cabinets.
  */
-#if CONFIG_BASE_SMALL == 0
-# define MAX_MP_BUSSES		260
-#else
+#ifdef CONFIG_BASE_SMALL
 # define MAX_MP_BUSSES		32
+#else
+# define MAX_MP_BUSSES		260
 #endif
 
 #define MAX_IRQ_SOURCES		256
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 67e2cb7c96eec..da33c6c4691c0 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -51,7 +51,7 @@
 #include <asm/unaligned.h>
 
 #define HEADER_SIZE	4u
-#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
+#define CON_BUF_SIZE (IS_ENABLED(CONFIG_BASE_SMALL) ? 256 : PAGE_SIZE)
 
 /*
  * Our minor space:
diff --git a/include/linux/threads.h b/include/linux/threads.h
index c34173e6c5f18..1674a471b0b4c 100644
--- a/include/linux/threads.h
+++ b/include/linux/threads.h
@@ -25,13 +25,13 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
+#define PID_MAX_DEFAULT (IS_ENABLED(CONFIG_BASE_SMALL) ? 0x1000 : 0x8000)
 
 /*
  * A maximum of 4 million PIDs should be enough for a while.
  * [NOTE: PID/TIDs are limited to 2^30 ~= 1 billion, see FUTEX_TID_MASK.]
  */
-#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
+#define PID_MAX_LIMIT (IS_ENABLED(CONFIG_BASE_SMALL) ? PAGE_SIZE * 8 : \
 	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
 
 /*
diff --git a/include/linux/udp.h b/include/linux/udp.h
index d04188714dca1..b456417fb4515 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -24,7 +24,7 @@ static inline struct udphdr *udp_hdr(const struct sk_buff *skb)
 }
 
 #define UDP_HTABLE_SIZE_MIN_PERNET	128
-#define UDP_HTABLE_SIZE_MIN		(CONFIG_BASE_SMALL ? 128 : 256)
+#define UDP_HTABLE_SIZE_MIN		(IS_ENABLED(CONFIG_BASE_SMALL) ? 128 : 256)
 #define UDP_HTABLE_SIZE_MAX		65536
 
 static inline u32 udp_hashfn(const struct net *net, u32 num, u32 mask)
diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b16..3f81ee5f9fb9c 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1141,7 +1141,7 @@ static inline void xa_release(struct xarray *xa, unsigned long index)
  * doubled the number of slots per node, we'd get only 3 nodes per 4kB page.
  */
 #ifndef XA_CHUNK_SHIFT
-#define XA_CHUNK_SHIFT		(CONFIG_BASE_SMALL ? 4 : 6)
+#define XA_CHUNK_SHIFT		(IS_ENABLED(CONFIG_BASE_SMALL) ? 4 : 6)
 #endif
 #define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
 #define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
diff --git a/init/Kconfig b/init/Kconfig
index ad4b6f778d2bd..182f2671a49dd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -743,7 +743,7 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 0 if BASE_SMALL != 0
+	default 0 if BASE_SMALL
 	default 12
 	depends on PRINTK
 	help
@@ -1950,9 +1950,7 @@ config RT_MUTEXES
 	default y if PREEMPT_RT
 
 config BASE_SMALL
-	int
-	default 0 if BASE_FULL
-	default 1 if !BASE_FULL
+	def_bool !BASE_FULL
 
 config MODULE_SIG_FORMAT
 	def_bool n
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1e78ef24321e8..06a1f091be81d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1150,7 +1150,7 @@ static int __init futex_init(void)
 	unsigned int futex_shift;
 	unsigned long i;
 
-#if CONFIG_BASE_SMALL
+#ifdef CONFIG_BASE_SMALL
 	futex_hashsize = 16;
 #else
 	futex_hashsize = roundup_pow_of_two(256 * num_possible_cpus());
diff --git a/kernel/user.c b/kernel/user.c
index 03cedc366dc9e..aa1162deafe49 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL_GPL(init_user_ns);
  * when changing user ID's (ie setuid() and friends).
  */
 
-#define UIDHASH_BITS	(CONFIG_BASE_SMALL ? 3 : 7)
+#define UIDHASH_BITS	(IS_ENABLED(CONFIG_BASE_SMALL) ? 3 : 7)
 #define UIDHASH_SZ	(1 << UIDHASH_BITS)
 #define UIDHASH_MASK		(UIDHASH_SZ - 1)
 #define __uidhashfn(uid)	(((uid >> UIDHASH_BITS) + uid) & UIDHASH_MASK)
-- 
2.39.2


