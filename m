Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303907A2D63
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbjIPCTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjIPCSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:18:48 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2449EFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:18:43 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1728274a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694830722; x=1695435522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lNAcEM45JnuCfTSJI3E/dx3IgazeK//Dr+dUsENW/9I=;
        b=dErwtPH2G7abDL5kB5qiGhpulzgA5oK2y0zkfp9GNJk4LH2sASgp46k9IgrS/USCvW
         o314qKE6fVK4/+0TrC7RogNKAno77k86WiE1r30sveWDMrNlrsYdbWQ7FGvXKTdhJ7pq
         9WqeFwo3BBWBE6YLyYcn3/2H4u8e8GWwI9LL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694830722; x=1695435522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lNAcEM45JnuCfTSJI3E/dx3IgazeK//Dr+dUsENW/9I=;
        b=JhsOuCuFnh2RXbmh+VYsOIca4rVRyBCqWBzjbQUmyNFq3hNey5dDIIOAOQi7B6xy4W
         y6yNu1HgGwYR9xDWmJ94KTH7uQozW4FNXgcM4guKSfQag5M4h+g7MiNWbSC5rB714Aiq
         rVGnBhyt8WlTATkYhcMQhHq+JNV7XkdWx69aksXsgF7uty/cESOQDeIMAcvEalGhSzn+
         fHz4RrUnIY+//acmPxvYRXDnRFm1OYkyk+mHlUDs+4tR6Khs9g1lZO7kGerDfU4fa1RI
         v8buE/CrXRpU5NZGNUVyqPLV0BMgY8lxn8rWBgEMweChfTIH9eEls5kyot6SsS6XyLjX
         ZDLQ==
X-Gm-Message-State: AOJu0YwrrVdZkqLPaD76b5tTE+PJeFaFqm8Y3xGPUChCc1h+Fy/otuhc
        kXQH3pcnHCwu8q8VGQLXF6XX5w==
X-Google-Smtp-Source: AGHT+IHGflPojIWFVtfNOoBI/mmU5yo4NTnIHWbhbq4XOzjG2hmoFQfv/CUSUlzb4Q2BjUy9ltgeBw==
X-Received: by 2002:a05:6a20:3206:b0:15a:58c8:b10f with SMTP id hl6-20020a056a20320600b0015a58c8b10fmr2994151pzc.43.1694830722637;
        Fri, 15 Sep 2023 19:18:42 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902a40400b001b03a1a3151sm4116061plq.70.2023.09.15.19.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 19:18:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/mm/dump_pagetables: Add SLAB_VIRTUAL knowledge
Date:   Fri, 15 Sep 2023 19:18:39 -0700
Message-Id: <20230916021835.never.147-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869; i=keescook@chromium.org;
 h=from:subject:message-id; bh=HmsovkvkpuwppfIJaKsY4lAxAF0+pyYONDwvgfgBOPE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBRB/T8jhFzJbx6o5pyHiafrDVYrG9hl2ENXaj
 1vL0IdviLGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQUQfwAKCRCJcvTf3G3A
 JmvID/9kiQNsFcjzH+6NwX2OKRtQtlFTPX4yZBTLdnCSlSxoiZOn1Um7n4ushYsTSH9QPZ2ddwb
 ZO0VP2CD4+wb17Lra8vU4oBGVa7Qou3CMDgsmY29UzQAgJMybMY2IA7PK6tsbotWnW9A0fD50ux
 yzmULaSqemZOWBFAe7ahP5HoWMdrmi45KP/vnhSAJbiTrIYUBueQQectsRg2UEufA3kpMGFpyRc
 vuRQVGyTzX6c/w7jLd9IP06ww2nvV9deNlrTD0khFfDrR40jbKZ4YkHRuiS7DD9fDvuRKMAU0QX
 FkOWDs7Mvx/UO44vjmmLT6g9/T/temLWY4ud/DGWD2mZm7FD6wmCKCxFTgzKQSD/P90lhr9o217
 rOulVz8VirrktInFxsA3t0ODzZpdyyMk3w48IOt+uXWi/Z3Ql8D3303wxw5XbNpSiFk9AwGhagg
 vx238fBXuPczyRGAzINKeLr/5u5vt8ErQmw1Tzij2Ph1UOVzGUwyDTTFTd9FP0HMDN+XqFG8T3B
 kE4REF5HqLOMJLVDOJjHJLpRnDkuO6gOMeLnoX+JEpJByYJex8wltdRkjYGRjh14psEpBsZaAU5
 MCc6f8enuWqjL04mNW/SYQfAfq8gqQ/h/i1Pz8/vZB3hAMqTbLsopoZ2D7u1Mx7xr2jlhk/qqJh
 lchwYnO C2pRB0MQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the markings for the SLAB_VIRTUAL area.

Cc: Matteo Rizzo <matteorizzo@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is on top of the SLAB_VIRTUAL series:
https://lore.kernel.org/all/20230915105933.495735-11-matteorizzo@google.com/

Feel free to collapse this into the x86 patch from the above series.

FYI, as expected, the kernel page table entries get way longer with
SLAB_VIRTUAL. :)

Without SLAB_VIRTUAL:

# wc -l /sys/kernel/debug/page_tables/kernel
1501 /sys/kernel/debug/page_tables/kernel

With SLAB_VIRTUAL:

# wc -l /sys/kernel/debug/page_tables/kernel
7549 /sys/kernel/debug/page_tables/kernel
---
 arch/x86/mm/dump_pagetables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index e1b599ecbbc2..b1fa68669e61 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -64,6 +64,9 @@ enum address_markers_idx {
 	KASAN_SHADOW_END_NR,
 #endif
 	CPU_ENTRY_AREA_NR,
+#ifdef CONFIG_SLAB_VIRTUAL
+	SLAB_AREA_NR,
+#endif
 #ifdef CONFIG_X86_ESPFIX64
 	ESPFIX_START_NR,
 #endif
@@ -95,6 +98,9 @@ static struct addr_marker address_markers[] = {
 	[LDT_NR]		= { 0UL,		"LDT remap" },
 #endif
 	[CPU_ENTRY_AREA_NR]	= { CPU_ENTRY_AREA_BASE,"CPU entry Area" },
+#ifdef CONFIG_SLAB_VIRTUAL
+	[SLAB_AREA_NR]		= { SLAB_BASE_ADDR,	"Slab Area" },
+#endif
 #ifdef CONFIG_X86_ESPFIX64
 	[ESPFIX_START_NR]	= { ESPFIX_BASE_ADDR,	"ESPfix Area", 16 },
 #endif
-- 
2.34.1

