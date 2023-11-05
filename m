Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491357E16DD
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjKEVhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKEVhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:37:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D02CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:37:44 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso6367781a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699220262; x=1699825062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diDfHIDfGzS7c9D5uSx32GZFst0D3sZaoS/knnykPTI=;
        b=aD2/r9nXgwm+9xCoRq8kBwt492FoNlaj7r7AGqiuV6bMETq969Sr1i5qjv3RP/WHKo
         iTty/iZ18yEw03/6NubkAL9iMpVxH9Y09SJOqbWfm4oi/hD9eIusJAT8hoqrOooc0Luw
         t0FEefT89M0LRk34JVa3TBisoe4c/m3hbBPu9El4R5uaY65tcolH2MMuvjI1XlpfHs8K
         GelxEleqG/n/TbyXiSVD7Y/waIH24M5VqZXijqIqvXarMKlz368/pWXdUIhIvX36gfcQ
         66x2bsrYXoGqTFptMN1aWJVopMvuVLCrSAXUKCVcUi/VLFghmuDsXuARZ+8h4JYk9PX6
         k/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699220262; x=1699825062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diDfHIDfGzS7c9D5uSx32GZFst0D3sZaoS/knnykPTI=;
        b=kHrx7E5deiGBGRlWS67A5GfzOXpLF2oxXA3Fqty1pDjf/r9suxoKvwuh4G/GEHch7l
         c4Sq5uScR3AGJCwUMBdipYszwkkWiiEGWWJ3LH3vq0pBNmOmvs1tVLXjsmBzwHx/kXph
         4VPPbjCTzxhwBbZt5DlVzHsPxoHNyzGzE21bIm+aEQtwLuEX6e4HxdFze9Nv6dlCsce0
         wd6E7jKYwxKWcE+G882qZd/SH1iBTMXgaj6FpyyMKxlX1atkYql1gImWWhYycPS74Z6E
         G5usL9L12vd2hVB7CA5sWpKv4lvg2jGFMTdAk/II0mDGbMYO2o8+7p210jHFEg1Ou7jQ
         UyIg==
X-Gm-Message-State: AOJu0Yz+azVQ4zc/hXNh0ZN+piGyIjUZcEZcvgEy3zhcTG3LkTps33LV
        Ho6rZBA9kEorYrhLOUsMd4c=
X-Google-Smtp-Source: AGHT+IFVOadnmL/alBy4c8y9RNvZMi65oYx/lDUJpauY31a3sEHQxWYTV3iLLMF7XHncpdkiJR/ZXg==
X-Received: by 2002:a17:907:96a7:b0:9c3:b3cb:29b8 with SMTP id hd39-20020a17090796a700b009c3b3cb29b8mr13422705ejc.0.1699220262378;
        Sun, 05 Nov 2023 13:37:42 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709064e5700b009c5c5c2c5a4sm3386559ejw.219.2023.11.05.13.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 13:37:42 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -tip v2 1/3] x86/percpu: Define PER_CPU_VAR macro also for !__ASSEMBLY__
Date:   Sun,  5 Nov 2023 22:34:35 +0100
Message-ID: <20231105213731.1878100-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231105213731.1878100-1-ubizjak@gmail.com>
References: <20231105213731.1878100-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some C source files define 'asm' statements that use PER_CPU_VAR,
so make PER_CPU_VAR macro available also without __ASSEMBLY__.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Make PER_CPU_VAR macro available in 'asm' statements
    instead of moving 'asm' statements to *.S assembly files.
---
 arch/x86/include/asm/percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b86b27d15e52..0f12b2004b94 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -84,10 +84,15 @@
 })
 #endif /* CONFIG_USE_X86_SEG_SUPPORT */
 
+#define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
+
 #else /* CONFIG_SMP */
 #define __percpu_seg_override
 #define __percpu_prefix		""
 #define __force_percpu_prefix	""
+
+#define PER_CPU_VAR(var)	(var)__percpu_rel
+
 #endif /* CONFIG_SMP */
 
 #define __my_cpu_type(var)	typeof(var) __percpu_seg_override
-- 
2.41.0

