Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D36E76F791
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjHDCLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjHDCL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:11:29 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F2C448F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:10:58 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56ca1eebcd7so1061374eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691115054; x=1691719854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efS36dkbCzja1DEoOkKk5twnSGIQYzSPz7GFgwV0rps=;
        b=sL5L+XGZXxz3uilHLZ9996rABpzv96OCLn70c9kreiKgPg+WH3KJroL9cVLj2fBjI4
         NQe8+w7CLAox+ot9c6Sx0ktR3iYP5P+c8pN85u54Rsy06KDa4GcfJccDlv6X4vB+zHUn
         fOSxh1hOUBlo6UgFcJDC47IQVz1f4EDcD0TlBOGU/8cvax961M2jcrcuGJPlBRjyBApH
         Yr9yABf/BnVF1c20z4GgGSV/40DAWyj5SVhDT+9mC7k6UVziYmYdgL3moyY6QrCvZd73
         4FZ3hUQCNUuO/ok3JHJqIRfA/yxktc+meR9K37rZmH55b5iR6aKlCC4Gg1xr0MwsaNDG
         Pekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115054; x=1691719854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efS36dkbCzja1DEoOkKk5twnSGIQYzSPz7GFgwV0rps=;
        b=JcAli0b57o5S71i7If/LsYIUsdc+XauQ1M9WeRHP49agjextQfpcNMXrB6PZVN9KKA
         o5FTwcM6oLsasNUp/zRxY2m4f5x3cu+rDjI8gIYNldJg3oe6Ey8+tZX4XV+li8vvZW+D
         ZJWYCq0Qn/Ux0J38qwH2mGcTp9GHdBDIqpmHGuq/yH3lqVMOm5cHdqIwn/0UPdiRDDjc
         ovPtbKXrB+vNspLS2515CEURCRjQQ+eM1HFUtQ/wF1MxU4cq9atUNgBcLwhChJ7ki+Cu
         0sCapJaN0XDOl8ojsDqoDY0QQpGRCoNv9cSHMA6PFGeArHGQ+embwW43Y/kjleg7vQUg
         Nozg==
X-Gm-Message-State: AOJu0Yw4jmLlnLQN8JIr2tHlO40Jj3z4eGO/5y5oaKQTEOVdZTjnxZhv
        4CzN3h9EjFq6Jd04b8F7Kj/GXg==
X-Google-Smtp-Source: AGHT+IHkkquc+vtnTAEnaVFOIeS3KymV7yesjBryf/XUZfueFQfWUT4yuX+ZoQdYenvjMp3+aT7A/A==
X-Received: by 2002:a05:6358:c603:b0:134:ded4:294 with SMTP id fd3-20020a056358c60300b00134ded40294mr441125rwb.17.1691115054417;
        Thu, 03 Aug 2023 19:10:54 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g6-20020a655806000000b0055c558ac4edsm369499pgr.46.2023.08.03.19.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:10:53 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 03 Aug 2023 19:10:27 -0700
Subject: [PATCH 02/10] RISC-V: vector: Refactor instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230803-master-refactor-instructions-v4-v1-2-2128e61fa4ff@rivosinc.com>
References: <20230803-master-refactor-instructions-v4-v1-0-2128e61fa4ff@rivosinc.com>
In-Reply-To: <20230803-master-refactor-instructions-v4-v1-0-2128e61fa4ff@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        bpf@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>, Nam Cao <namcaov@gmail.com>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use instructions in insn.h

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/kernel/vector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index d67a60369e02..1433d70abdd7 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -18,7 +18,6 @@
 #include <asm/csr.h>
 #include <asm/elf.h>
 #include <asm/ptrace.h>
-#include <asm/bug.h>
 
 static bool riscv_v_implicit_uacc = IS_ENABLED(CONFIG_RISCV_ISA_V_DEFAULT_ENABLE);
 
@@ -56,7 +55,7 @@ static bool insn_is_vector(u32 insn_buf)
 	 * All V-related instructions, including CSR operations are 4-Byte. So,
 	 * do not handle if the instruction length is not 4-Byte.
 	 */
-	if (unlikely(GET_INSN_LENGTH(insn_buf) != 4))
+	if (unlikely(INSN_LEN(insn_buf) != 4))
 		return false;
 
 	switch (opcode) {

-- 
2.34.1

