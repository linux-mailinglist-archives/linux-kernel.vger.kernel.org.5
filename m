Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736B578DE68
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241439AbjH3TCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245476AbjH3PQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:16:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14CC1A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52a0856b4fdso7417385a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693408595; x=1694013395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oW9pYlM91CH6rczFdRvlNOM5/TsYTpBNFeuKY78V0hk=;
        b=r0I37HUilkc7Nf/SKu6oJflZOsQ4GvS8H/0iptua3hTYveL7+DNv5YO8oO/L6tlsdt
         jG0IRkKAsEXNN74Otsu4vRnCCtnQ6AMTqSTLlizvVJbiM55ZfOCX7l7H5DsPofj9XX9e
         kD4mThtaMTZ/ALsYMQJZ1R/2T2cOX+QO/ggb4qWSfQ4lqtLCI7To82OVhwtPpUfMqyXE
         oudCfleYd+ZrzvBZq9BPIT4d1Z2MLH8fmnjdHVIfnOq78XiJsQrfFLyIK/uQskxlJ4q6
         qvQZe9blr1kUx/tfwN+sziNQv0AxQOmobJtMsU/BeVIBhLRVmIQPWCAed93/CihPOVhA
         4nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693408595; x=1694013395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oW9pYlM91CH6rczFdRvlNOM5/TsYTpBNFeuKY78V0hk=;
        b=DlHL1/cAjhV/LrmTt44cqmHuCF92IdOPjn9taJjGP2ZCyQfX5gTuB7kGyhQzoCWwTo
         CxrqaLb3FLy6qaYuisel+zFfCWXsqszp8Fty/kXohcqOP4EBJl8gn0cAqhZ6VnFo4/hP
         LrvudTo9jb8WCzi5G8sLzH08Y8beXAOGhZfg+ziaSu9U7r4DwjaVLtA5tsK8LhQqTO1L
         DIKw/YB7jIQSKV2OsN1Y4GpGDUQvv2TUqT7zR8GgvaLpbU2ZF3lpjVeaa6y1dKNRD/cI
         VCy2qhKAQOb/2qGtNcpqp6XpprzUfD0Jw/l99a6mNIEjKeK/rMDlLTsfso2/7IdKLnpg
         /9HA==
X-Gm-Message-State: AOJu0YyMD/lYVfS/fe7mERT4PmZVswuP8F9x36StP3WefHSYghOZTmkv
        amp592aw0tqB1SWwQ58qYM4=
X-Google-Smtp-Source: AGHT+IGg7yKpRNsAQ8mT/HutPWO9Avy1WCmNhDFXrnEXV1fYHNqEg/krALLP5jXb1Kv+R2C4TH9m0g==
X-Received: by 2002:a17:907:7898:b0:9a2:139:f469 with SMTP id ku24-20020a170907789800b009a20139f469mr1938735ejc.69.1693408595175;
        Wed, 30 Aug 2023 08:16:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id k11-20020a1709063e0b00b009a1a653770bsm7241627eji.87.2023.08.30.08.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 08:16:34 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86/percpu: Use raw_cpu_try_cmpxchg in preempt_count_set
Date:   Wed, 30 Aug 2023 17:13:57 +0200
Message-ID: <20230830151623.3900-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830151623.3900-1-ubizjak@gmail.com>
References: <20230830151623.3900-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use raw_cpu_try_cmpxchg instead of raw_cpu_cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, raw_cpu_try_cmpxchg implicitly assigns old *ptr value to "old" when
cmpxchg fails. There is no need to re-read the value in the loop.

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 2d13f25b1bd8..4527e1430c6d 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -31,11 +31,11 @@ static __always_inline void preempt_count_set(int pc)
 {
 	int old, new;
 
+	old = raw_cpu_read_4(pcpu_hot.preempt_count);
 	do {
-		old = raw_cpu_read_4(pcpu_hot.preempt_count);
 		new = (old & PREEMPT_NEED_RESCHED) |
 			(pc & ~PREEMPT_NEED_RESCHED);
-	} while (raw_cpu_cmpxchg_4(pcpu_hot.preempt_count, old, new) != old);
+	} while (!raw_cpu_try_cmpxchg_4(pcpu_hot.preempt_count, &old, new));
 }
 
 /*
-- 
2.41.0

