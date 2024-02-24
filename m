Return-Path: <linux-kernel+bounces-79430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2510C86221A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E0D1C24EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB4ED52A;
	Sat, 24 Feb 2024 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38R61QQb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E18BA2D
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708739887; cv=none; b=qgCoS8CZkIkVFfaJAtU9wK3DbkMmHT/bIngRe2mUtsqZyKcqZ4ZFWlj7BWbKssMTSmDc6vBPCXXAnuGJSfJG3FCw3mITC/tzZS8vmazHz3aGF5+/b8PqllplJJbUnSUsDm8sD7nqJSiIlku8kXZzZpKVDEJO8/313LQUd+fFm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708739887; c=relaxed/simple;
	bh=N6DyOMTvel8vbAFMjgcPbdhcWu1jczGqyPQOF1LJJKQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IwfYA2o/XDW/6LxRr4kcZX3WFGUQzcwau42PefBrlc+aWAAVRVqXBVFXEMJS7mzJEZ1uBqXl6x9d+aFpwEJKL73orwDY8y7S4MMF8B6R7YiUN1oBfSLUT7ugcd3auWBVMfY4ktwgbYSIvBVMyI4o/1G1VJ9aEVMrKHH0Mb6051w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38R61QQb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d2cffc7eso1685397b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708739885; x=1709344685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxJAE1uSiuAHKlkfqA5vMwgno+A6UVTMYqvcjH6/eSk=;
        b=38R61QQbnd3A69HdlIOrSe5OzLKU59RjRJHKp6814X22WrgVGb6Zd4SIAv3wE/rpXo
         a4d4bUQUeTJ4mn0Y8OB1eJP1J64Yt8ipxpFiHo+oMaZHVS9y28/Sw8E4vKGKr9IKhgdm
         +AA/gnDtlHhEqjzS0z70nCjyC7auJmDZaR7kG2GDHz/qQMht9FEe5cMHQYb+0BT3557J
         Zr7NOACBbRBA5m4uUnf5Swed600s1SgbHWZlB6/NQZEeZddV2LKJ3XmWfkOuwsxo6EQR
         qVMTlH8xEYNOjrcYNXHOX6NBqrlhQt0OjLlkihn0/0+YGBjI0gHiyVjwMYpogKr5Eds9
         2v5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708739885; x=1709344685;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxJAE1uSiuAHKlkfqA5vMwgno+A6UVTMYqvcjH6/eSk=;
        b=r0lvZA5CfdyyEg8wCpb6xcWvKAh5S9NWHP1Yayp04xDVHnwmjus/bOuREHBrLUDElr
         dIwb+utF8NRInd2+SsZa+rhVExMILlhQqtwiWuFTNPhrxqIDpFfeke6PM0yo3Svm5WBP
         xh8COY0JVsqtTxl6eT/gBtw+wPEQpHrJJQcNUxIGo/Qf5HPukcu6IcXZCrA+XaImujh3
         TbUmTGkiL5MucyC4+5/B9fXLlZVx1Q/WsX6gL5fuaNCFjshGyg1Ff9vYZQ/ps/N2iKdE
         DbVDCik6DMIIbdGLHmeIOU/XqSTyVG+krp7IrMdBsXFP+I1mbdYzdcyucsIiaaA4TIsI
         ACTg==
X-Forwarded-Encrypted: i=1; AJvYcCVIR8f1asG+Dv1X/KILguGRZG8PoHlJ9keyDx1WR7ZMT7jbScIHYKBsjf69J+8/KgPyg5whHD+xzvTh3m7L+xfpzk+L+KB3D2EE6dQc
X-Gm-Message-State: AOJu0Yyjfv0CoDiya+lk9f8rpAuN6TuxVnRM4jk1Z6PLLM979uOTDgDs
	jCSUWdNSq+OHayesOSzemOnNScdlD+JGdxNRtRxilLsK1PSc6x7jzEWQ9Xn7cuZwHSPJOhiSabh
	/+A==
X-Google-Smtp-Source: AGHT+IGtBbMVCifF1ia9ZEGs0SLu3LluxNX6gDLjJVev8hxlcSexXU2441mZZZig36JIPLE066jJNPvrMc0=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:77e1:98cf:e33c:dd99])
 (user=surenb job=sendgmr) by 2002:a0d:d98f:0:b0:607:b85e:5a92 with SMTP id
 b137-20020a0dd98f000000b00607b85e5a92mr335723ywe.5.1708739884991; Fri, 23 Feb
 2024 17:58:04 -0800 (PST)
Date: Fri, 23 Feb 2024 17:58:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240224015800.2569851-1-surenb@google.com>
Subject: [PATCH v5 1/1] mm: enumerate all gfp flags
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, petr@tesarici.cz, keescook@chromium.org, 
	pasha.tatashin@soleen.com, mhocko@suse.com, surenb@google.com, 
	kernel-team@android.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Introduce GFP bits enumeration to let compiler track the number of used
bits (which depends on the config options) instead of hardcoding them.
That simplifies __GFP_BITS_SHIFT calculation.

Suggested-by: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changes from v4 [1]:
- Split from the series [2] as a stand-alone patch, per Michal Hocko
- Added Reviewed-by, per Pasha Tatashin
- Added Acked-by, per Michal Hocko

[1] https://lore.kernel.org/all/20240221194052.927623-7-surenb@google.com/
[2] https://lore.kernel.org/all/20240221194052.927623-1-surenb@google.com/

 include/linux/gfp_types.h | 90 +++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 28 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 1b6053da8754..868c8fb1bbc1 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -21,44 +21,78 @@ typedef unsigned int __bitwise gfp_t;
  * include/trace/events/mmflags.h and tools/perf/builtin-kmem.c
  */
=20
+enum {
+	___GFP_DMA_BIT,
+	___GFP_HIGHMEM_BIT,
+	___GFP_DMA32_BIT,
+	___GFP_MOVABLE_BIT,
+	___GFP_RECLAIMABLE_BIT,
+	___GFP_HIGH_BIT,
+	___GFP_IO_BIT,
+	___GFP_FS_BIT,
+	___GFP_ZERO_BIT,
+	___GFP_UNUSED_BIT,	/* 0x200u unused */
+	___GFP_DIRECT_RECLAIM_BIT,
+	___GFP_KSWAPD_RECLAIM_BIT,
+	___GFP_WRITE_BIT,
+	___GFP_NOWARN_BIT,
+	___GFP_RETRY_MAYFAIL_BIT,
+	___GFP_NOFAIL_BIT,
+	___GFP_NORETRY_BIT,
+	___GFP_MEMALLOC_BIT,
+	___GFP_COMP_BIT,
+	___GFP_NOMEMALLOC_BIT,
+	___GFP_HARDWALL_BIT,
+	___GFP_THISNODE_BIT,
+	___GFP_ACCOUNT_BIT,
+	___GFP_ZEROTAGS_BIT,
+#ifdef CONFIG_KASAN_HW_TAGS
+	___GFP_SKIP_ZERO_BIT,
+	___GFP_SKIP_KASAN_BIT,
+#endif
+#ifdef CONFIG_LOCKDEP
+	___GFP_NOLOCKDEP_BIT,
+#endif
+	___GFP_LAST_BIT
+};
+
 /* Plain integer GFP bitmasks. Do not use this directly. */
-#define ___GFP_DMA		0x01u
-#define ___GFP_HIGHMEM		0x02u
-#define ___GFP_DMA32		0x04u
-#define ___GFP_MOVABLE		0x08u
-#define ___GFP_RECLAIMABLE	0x10u
-#define ___GFP_HIGH		0x20u
-#define ___GFP_IO		0x40u
-#define ___GFP_FS		0x80u
-#define ___GFP_ZERO		0x100u
+#define ___GFP_DMA		BIT(___GFP_DMA_BIT)
+#define ___GFP_HIGHMEM		BIT(___GFP_HIGHMEM_BIT)
+#define ___GFP_DMA32		BIT(___GFP_DMA32_BIT)
+#define ___GFP_MOVABLE		BIT(___GFP_MOVABLE_BIT)
+#define ___GFP_RECLAIMABLE	BIT(___GFP_RECLAIMABLE_BIT)
+#define ___GFP_HIGH		BIT(___GFP_HIGH_BIT)
+#define ___GFP_IO		BIT(___GFP_IO_BIT)
+#define ___GFP_FS		BIT(___GFP_FS_BIT)
+#define ___GFP_ZERO		BIT(___GFP_ZERO_BIT)
 /* 0x200u unused */
-#define ___GFP_DIRECT_RECLAIM	0x400u
-#define ___GFP_KSWAPD_RECLAIM	0x800u
-#define ___GFP_WRITE		0x1000u
-#define ___GFP_NOWARN		0x2000u
-#define ___GFP_RETRY_MAYFAIL	0x4000u
-#define ___GFP_NOFAIL		0x8000u
-#define ___GFP_NORETRY		0x10000u
-#define ___GFP_MEMALLOC		0x20000u
-#define ___GFP_COMP		0x40000u
-#define ___GFP_NOMEMALLOC	0x80000u
-#define ___GFP_HARDWALL		0x100000u
-#define ___GFP_THISNODE		0x200000u
-#define ___GFP_ACCOUNT		0x400000u
-#define ___GFP_ZEROTAGS		0x800000u
+#define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
+#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
+#define ___GFP_WRITE		BIT(___GFP_WRITE_BIT)
+#define ___GFP_NOWARN		BIT(___GFP_NOWARN_BIT)
+#define ___GFP_RETRY_MAYFAIL	BIT(___GFP_RETRY_MAYFAIL_BIT)
+#define ___GFP_NOFAIL		BIT(___GFP_NOFAIL_BIT)
+#define ___GFP_NORETRY		BIT(___GFP_NORETRY_BIT)
+#define ___GFP_MEMALLOC		BIT(___GFP_MEMALLOC_BIT)
+#define ___GFP_COMP		BIT(___GFP_COMP_BIT)
+#define ___GFP_NOMEMALLOC	BIT(___GFP_NOMEMALLOC_BIT)
+#define ___GFP_HARDWALL		BIT(___GFP_HARDWALL_BIT)
+#define ___GFP_THISNODE		BIT(___GFP_THISNODE_BIT)
+#define ___GFP_ACCOUNT		BIT(___GFP_ACCOUNT_BIT)
+#define ___GFP_ZEROTAGS		BIT(___GFP_ZEROTAGS_BIT)
 #ifdef CONFIG_KASAN_HW_TAGS
-#define ___GFP_SKIP_ZERO	0x1000000u
-#define ___GFP_SKIP_KASAN	0x2000000u
+#define ___GFP_SKIP_ZERO	BIT(___GFP_SKIP_ZERO_BIT)
+#define ___GFP_SKIP_KASAN	BIT(___GFP_SKIP_KASAN_BIT)
 #else
 #define ___GFP_SKIP_ZERO	0
 #define ___GFP_SKIP_KASAN	0
 #endif
 #ifdef CONFIG_LOCKDEP
-#define ___GFP_NOLOCKDEP	0x4000000u
+#define ___GFP_NOLOCKDEP	BIT(___GFP_NOLOCKDEP_BIT)
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
-/* If the above are modified, __GFP_BITS_SHIFT may need updating */
=20
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -249,7 +283,7 @@ typedef unsigned int __bitwise gfp_t;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
=20
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT ___GFP_LAST_BIT
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
=20
 /**

base-commit: 603c04e27c3e9891ce7afa5cd6b496bfacff4206
--=20
2.44.0.rc0.258.g7320e95886-goog


