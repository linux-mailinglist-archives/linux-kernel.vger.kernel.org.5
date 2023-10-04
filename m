Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B551D7B82B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbjJDOwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjJDOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:52:01 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70308C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:51:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9a645e54806so406386166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 07:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696431113; x=1697035913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPTU87oTEk7NeTsAm+0ZteUkCkrJ8u07q+xpjbSH+r0=;
        b=LJCH3Qx6PTDv6w+psOenJpB3IqyKGfV8sKXbONQeqjMwm2gg7d++Db6CtQlwJhuLMw
         yVGqpHwe0k79BQCouD0EuQhdrEwaULxnyYGHkhy7/rTm4BZWj1zIR6MObGKUVHtJiHwm
         xYVGcq8M0pNvSq8RC+ZssXNKAX4r2ejrGR2R899xNm0T5eYlGJ7jIYhhCNY/TJyaiXNg
         IYZRb0aejQsBbCcbTLSB/HbpWYJuPzh77f6Ifa4wpFh3zynFm58PyGuDIBxkCmeKjfan
         /+tw5toTuO46YaNG6v4yDWaEOZ4G98l6In4QaEMyFZKz0YMvQeE5XTNCobfYTFCYJzXS
         71hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696431113; x=1697035913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPTU87oTEk7NeTsAm+0ZteUkCkrJ8u07q+xpjbSH+r0=;
        b=u/4/XuXBeCCAcdbUwMw8oA3Se0Kl4b8xNewgw5r2cLiI8hrIPU0aNSQLAssK5i6uEx
         2m4NZt7Vt93ejr6+eItl8G0Gh+pG4CjjXNOzIS0TF8AZsHKgrHXngQTjqVIqJ+vZ45Vs
         JQv4yi4AT7EeYMw2pEUzvKe8SqoJK7E857gGEbfAvpKd9XZfTDQ/oodMKQwp3VrRp70d
         RAJoKFvVtUFudRl5RER9aPwzqDQPHtwSgD7cV6PHzv2apUxb4Yf6Vy6C3ABDiW7NIdcF
         6+e8y4oDWL4gjXTg5decbq4iTHs7FrXAEXUozQayyeIDDkC+SstCpCUZ2eGBUqaQ38D3
         PnsA==
X-Gm-Message-State: AOJu0YzNjRRUL3oUzSFRq393UiasqCENL0ryGswPahGKYthyqlmIMdDz
        4JznyoXcvsvcaXX6a/WDRAs=
X-Google-Smtp-Source: AGHT+IHasxx/eOa/cGvSMgjXT0UOfMcRpmNa0X0PQ2rfKcFxwtIwA520SvFJpFKfeSy81MIpsHGUcw==
X-Received: by 2002:a17:906:144:b0:9ae:54c3:c627 with SMTP id 4-20020a170906014400b009ae54c3c627mr1923713ejh.71.1696431112895;
        Wed, 04 Oct 2023 07:51:52 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id j26-20020a1709064b5a00b009a16975ee5asm2906307ejv.169.2023.10.04.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:51:52 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Nadav Amit <namit@vmware.com>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 2/4] x86/percpu: Enable named address spaces with known compiler version
Date:   Wed,  4 Oct 2023 16:49:42 +0200
Message-ID: <20231004145137.86537-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004145137.86537-1-ubizjak@gmail.com>
References: <20231004145137.86537-1-ubizjak@gmail.com>
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

Enable named address spaces with known compiler version
(GCC 13.1 and later) in order to avoid possible issues with named
address spaces with older compilers. Set CC_HAS_NAMED_AS when the
compiler satisfies version requirements and set USE_X86_SEG_SUPPORT
to signal when segment qualifiers could be used.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
v1: Enable support with known compiler version
---
 arch/x86/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 66bfabae8814..3aa73f50dc05 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2388,6 +2388,13 @@ source "kernel/livepatch/Kconfig"
 
 endmenu
 
+config CC_HAS_NAMED_AS
+	def_bool CC_IS_GCC && GCC_VERSION >= 130100
+
+config USE_X86_SEG_SUPPORT
+	def_bool y
+	depends on CC_HAS_NAMED_AS && SMP
+
 config CC_HAS_SLS
 	def_bool $(cc-option,-mharden-sls=all)
 
-- 
2.41.0

