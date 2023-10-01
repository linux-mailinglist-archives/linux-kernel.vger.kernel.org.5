Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE517B46F5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 12:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbjJAKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 06:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjJAKlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 06:41:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EE3D8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 03:41:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso2083930466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 03:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696156865; x=1696761665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6ur2qb0x8q/rSGOpgVJ8elvvt/Yb95eKWrvLo4QZJM=;
        b=SRZTzufybb59sLBRK0iUyxVx7xAiQgevkkCFnk8hkiF8CzuZLZG5kQBcy8/jCwQBsk
         3oyG69TVR7Vcnx0BkTJbEZ4Awf4s1gYxj3sYUqBS/dw/AgsHJBxPQ/y2rjGJZna5lsnV
         3ZrEgmpoP2ZFyDA3SfrVtw1HqjBzYBKH1Q1Fnj89i1r3swuAtnU2Bi6pDtw13Fs0QCs2
         6NTJ7KP3OlyJ07YeHsLUlAiVnCue7QQ9Cxb7aNcVh8YK/tUaUR8jMjj99ktnm0bu7cLK
         Rp31QqYWT5k905sCdylWtQO2nNgWhM4ukxp6ZNxdZYf4o+l32ObNJj6SUK7f9YxjCBCJ
         U0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696156865; x=1696761665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w6ur2qb0x8q/rSGOpgVJ8elvvt/Yb95eKWrvLo4QZJM=;
        b=WoSZV2Rv9md/k61lYAMcjOD12sHRsGvOmmLtD3f2CqoskzoMeLiSY61DqVAjVLyK6i
         ljgQJ3EdqM6HfGz4mJvEq3ZEhVfxHleiniLE3lUUvpOzm6y6ovbVOuosK1zF/Xl11ud7
         aLrnun8MzqWWL/GQ8kqbJm87WQ4gMbzPaDatG/vzyZX4U5qbhTAV0hNlF8CkU62sFjqn
         D4cmQcVVOvyqr3cG+sqnx4axWHkwAx9qOlb/VY5ONaggcxq5g+AidFl5r/Vv9XVzopvc
         XdHslGHy9Tjkno3JDJlZweXsKI7pPHktkPIBp78QY2chBQwhnXec2CMO4kf//G1ZfxvE
         jxyQ==
X-Gm-Message-State: AOJu0YzToiknfivjYV0qudrji6/fiamrz9eJmpMPskkodUqhXFFPFx96
        vFLHFM8Z2IP9dQGzszEJJM0BMPn9XqeJ0Q==
X-Google-Smtp-Source: AGHT+IHiSe0AHyaEO3R17ZhQDfsCes5+q/9A9cLMJMLgBfw1ghBgw9I+0cdDupifN0wboisrAnr7BQ==
X-Received: by 2002:a17:906:51d5:b0:9a2:26d8:f184 with SMTP id v21-20020a17090651d500b009a226d8f184mr7068105ejk.51.1696156864627;
        Sun, 01 Oct 2023 03:41:04 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b0099caf5bed64sm15333657ejb.57.2023.10.01.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 03:41:04 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/3] locking/x86: Introduce arch_sync_try_cmpxchg
Date:   Sun,  1 Oct 2023 12:39:10 +0200
Message-ID: <20231001104053.9644-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231001104053.9644-1-ubizjak@gmail.com>
References: <20231001104053.9644-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce arch_sync_try_cmpxchg macro to improve code using
sync_try_cmpxchg locking primitive. The new definitions use existing
__raw_try_cmpxchg macros, but use its own "lock; " prefix.

The new macros improve assembly of the cmpxchg loop in
evtchn_fifo_unmask() from drivers/xen/events/events_fifo.c from:

 57a:	85 c0                	test   %eax,%eax
 57c:	78 52                	js     5d0 <...>
 57e:	89 c1                	mov    %eax,%ecx
 580:	25 ff ff ff af       	and    $0xafffffff,%eax
 585:	c7 04 24 00 00 00 00 	movl   $0x0,(%rsp)
 58c:	81 e1 ff ff ff ef    	and    $0xefffffff,%ecx
 592:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
 596:	89 44 24 08          	mov    %eax,0x8(%rsp)
 59a:	8b 74 24 08          	mov    0x8(%rsp),%esi
 59e:	8b 44 24 04          	mov    0x4(%rsp),%eax
 5a2:	f0 0f b1 32          	lock cmpxchg %esi,(%rdx)
 5a6:	89 04 24             	mov    %eax,(%rsp)
 5a9:	8b 04 24             	mov    (%rsp),%eax
 5ac:	39 c1                	cmp    %eax,%ecx
 5ae:	74 07                	je     5b7 <...>
 5b0:	a9 00 00 00 40       	test   $0x40000000,%eax
 5b5:	75 c3                	jne    57a <...>
 <...>

to:

 578:	a9 00 00 00 40       	test   $0x40000000,%eax
 57d:	74 2b                	je     5aa <...>
 57f:	85 c0                	test   %eax,%eax
 581:	78 40                	js     5c3 <...>
 583:	89 c1                	mov    %eax,%ecx
 585:	25 ff ff ff af       	and    $0xafffffff,%eax
 58a:	81 e1 ff ff ff ef    	and    $0xefffffff,%ecx
 590:	89 4c 24 04          	mov    %ecx,0x4(%rsp)
 594:	89 44 24 08          	mov    %eax,0x8(%rsp)
 598:	8b 4c 24 08          	mov    0x8(%rsp),%ecx
 59c:	8b 44 24 04          	mov    0x4(%rsp),%eax
 5a0:	f0 0f b1 0a          	lock cmpxchg %ecx,(%rdx)
 5a4:	89 44 24 04          	mov    %eax,0x4(%rsp)
 5a8:	75 30                	jne    5da <...>
 <...>
 5da:	8b 44 24 04          	mov    0x4(%rsp),%eax
 5de:	eb 98                	jmp    578 <...>

The new code removes move instructions from 585: 5a6: and 5a9:
and the compare from 5ac:. Additionally, the compiler assumes that
cmpxchg success is more probable and optimizes code flow accordingly.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v2: Improve commit description.
---
 arch/x86/include/asm/cmpxchg.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index d53636506134..5612648b0202 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -221,12 +221,18 @@ extern void __add_wrong_size(void)
 #define __try_cmpxchg(ptr, pold, new, size)				\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
 
+#define __sync_try_cmpxchg(ptr, pold, new, size)			\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), "lock; ")
+
 #define __try_cmpxchg_local(ptr, pold, new, size)			\
 	__raw_try_cmpxchg((ptr), (pold), (new), (size), "")
 
 #define arch_try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+#define arch_sync_try_cmpxchg(ptr, pold, new) 				\
+	__sync_try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
+
 #define arch_try_cmpxchg_local(ptr, pold, new)				\
 	__try_cmpxchg_local((ptr), (pold), (new), sizeof(*(ptr)))
 
-- 
2.41.0

