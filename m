Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6459E7FF593
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjK3Q34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjK3Q3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:29:54 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A7C1B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:30:00 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c9b9191722so15872171fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701361799; x=1701966599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IhZ5jzARbi4JOU98K2pKX6kbTUpp01eflM49jLTsDrU=;
        b=hzv7rWRsgzUQNIDdfYbRzxM7/XgKA1m1JPQdAtYmF01QtPJR4KzFQEzcO8n/FRoZrx
         UI0gmx6Wv9R4B3l4+AfHnJ4CrfAUIgTaDY9TME8NKQ4prnyo+LqBBfCl3+xTq7CY0gG0
         iA2bfQ5JsfszYGKvNKSO3/76Dq7neMAnxIbW6v5k2jZtdFZX4WX0krccUtCOEYmG3T0q
         L2vCnZZc6S3GJR2CRXSFXWWP8PRWCWFiDfZlI3XVR8EK/9sbpvlLF+lk1O6aG96lj2m3
         UX+dsN8D8pgjuBQ+8PVRZT5o0i2agU8ZwfHvlQr8QEhrUPwYd0Ssr2VC8C8h6bWwbRZp
         RVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361799; x=1701966599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhZ5jzARbi4JOU98K2pKX6kbTUpp01eflM49jLTsDrU=;
        b=v9pITso9Q7b5Wo6Zj1lB4e9IFstEo3IAJ8YS1g204gEtCG9fqRA+ForBmVGKAbht3U
         omV26KqP2N/qLvQ6pdWsR5g62ir4iCaUC9wzpnWMRLw1CqBVzBS4kP1zDlerBR3AyIfA
         TAGDS3/JhFhHm6lRVzT2+HXhtBzWe++0zd2JudC77BlGd7ufEVad/E7k/Ln8r2GgqXFS
         TM/fYJgher2SFuNHPL1FKStZcl/B0A5za6UL5g+XgnL+J5up9JRyZbnx84woAeKyoRQ6
         MKlaQJzuojJj0hVnvsiWYTCS/GsyeE5ZA5pZlE6gRXAQM93ObbXd5bWlpU7LChYB1qCz
         AmIQ==
X-Gm-Message-State: AOJu0YzSOeo6ss36Xnp8aQCVgRHalCglijdvWEjuJlvEB0pQxpPMov95
        VGt70Gvn9Qb2o4TgSbaABLs=
X-Google-Smtp-Source: AGHT+IEpOOdHQgXOUDJjuJrAF/m1VjSac7Np3I5fWa+nhFDI+uNhCHfQZ9UCSTZtitZU8rhhL77SQw==
X-Received: by 2002:a2e:870b:0:b0:2c9:b88c:e3a7 with SMTP id m11-20020a2e870b000000b002c9b88ce3a7mr36482lji.25.1701361798603;
        Thu, 30 Nov 2023 08:29:58 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id fa10-20020a05600c518a00b00405442edc69sm6164938wmb.14.2023.11.30.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:29:57 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, kernel test robot <lkp@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/percpu: Declare const_pcpu_hot as extern const variable
Date:   Thu, 30 Nov 2023 17:27:35 +0100
Message-ID: <20231130162949.83518-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
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

const_pcpu_hot is aliased by linker to pcpu_hot, so there is no need
to use DECLARE_PER_CPU_ALIGNED macro. Also, declare const_pcpu_hot
as extern to avoid allocating storage space for the aliased structure.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311302257.tSFtZnly-lkp@intel.com/

Fixes: ed2f752e0e0a ("x86/percpu: Introduce const-qualified const_pcpu_hot to micro-optimize code generation")
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/current.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/current.h b/arch/x86/include/asm/current.h
index 0538d2436673..9fbd7cb2dc86 100644
--- a/arch/x86/include/asm/current.h
+++ b/arch/x86/include/asm/current.h
@@ -37,8 +37,7 @@ static_assert(sizeof(struct pcpu_hot) == 64);
 DECLARE_PER_CPU_ALIGNED(struct pcpu_hot, pcpu_hot);
 
 /* const-qualified alias to pcpu_hot, aliased by linker. */
-DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
-			const_pcpu_hot);
+extern const struct pcpu_hot __percpu_seg_override const_pcpu_hot;
 
 static __always_inline struct task_struct *get_current(void)
 {
-- 
2.42.0

