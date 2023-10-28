Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7FC7DA528
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 06:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjJ1E6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 00:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJ1E6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 00:58:33 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD790119
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:58:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b3f938331fso1368718b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 21:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698469110; x=1699073910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q790Td8gv55CpXw6jh1r5+WUtiBYMYeRT8D2CcfTbo=;
        b=Gimxlkxv4ucXVM3PXcTTGFaF4z8adZA2Nh/yTWxeBV83ua9tdQe7cjVleruGt3SLWj
         aIAQ6S+iT9Q+JgrTRM0yF8ajQ8W2KORySlFdtTjqkM/4/bFhF34NBaKE6Htw2VH6570R
         FFzXwuIeruMEN9weRyAQC5rk9O4jdIqbuoafXbBmagX+Wv8XT2PJfLb2E9qH0V/J37XF
         foPxjEMEJYnZil/vxilEelxpjZ+KdmBH2LGC9nbwKLWb9TGh2iaxb/4KYYH1P0y1m9nT
         QnmUWmUSgFbwAazPIfNNWJMKewtCQcUxcJrIZS9eJVmMoSsIUK9FOibrxiHY4WjY199q
         HstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698469110; x=1699073910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q790Td8gv55CpXw6jh1r5+WUtiBYMYeRT8D2CcfTbo=;
        b=QyXK6cgg6FeKEySap+TD6wW77/r6pox3TKsOw0wqj568Kd89HwJPADAgupmzedTLKR
         PoMoA3QGA2JWvwqDdxVU3RKdK1E8IiQMmI5yDxLJMcKu2k8VrRYJFEvgMzhTIPjJ/i2h
         k7PCD6wMvXXmCnuvjxcExDAUl3KDCDNOdZB13/vlF34KErRosP33YJKxbDP8r1LB+Jkt
         40Xjr7Z8eXZ8kkmEM8PREjIJMXhWvNZ2hNV/u1CA2+WaZicx+ykJs5dL+ne4edXeLR04
         PQwe9zt8E/P0WlBHfYnjh/OrlGcO9NDLlnKPgVc/i7csRElqEqAm/xwxhi8NL5mRnH0P
         F4PQ==
X-Gm-Message-State: AOJu0YyHWaiIHgMs188VJPlleZnlIwMYbkBSmfpYA27CReGIKP2gZNcw
        9q7tRs6QZ577X2Nnaze5/MHCewMyAg8RD7vLOIBjYw==
X-Google-Smtp-Source: AGHT+IGGDClxKSdOLWZbDJlUZVr8MpnEslR+RWKEakq84qXtJFW68KEQ5ZSFt7C+jjhQC2mgYYoflQ==
X-Received: by 2002:a05:6808:6d5:b0:3a7:5d6e:dcfb with SMTP id m21-20020a05680806d500b003a75d6edcfbmr2757787oih.8.1698469109750;
        Fri, 27 Oct 2023 21:58:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k16-20020a544710000000b003a8560a9d34sm567488oik.25.2023.10.27.21.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 21:58:29 -0700 (PDT)
From:   Deepak Gupta <debug@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Deepak Gupta <debug@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Hsieh-Tseng Shen <woodrow.shen@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Glenn Washburn <development@efficientek.com>,
        Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v6] scripts/gdb: add lx_current support for riscv
Date:   Fri, 27 Oct 2023 21:58:00 -0700
Message-ID: <20231028045813.685389-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

csr_sscratch CSR holds current task_struct address when hart is in
user space. Trap handler on entry spills csr_sscratch into "tp" (x2)
register and zeroes out csr_sscratch CSR. Trap handler on exit reloads
"tp" with expected user mode value and place current task_struct address
again in csr_sscratch CSR.

This patch assumes "tp" is pointing to task_struct. If value in
csr_sscratch is numerically greater than "tp" then it assumes csr_sscratch
is correct address of current task_struct. This logic holds when
   - hart is in user space, "tp" will be less than csr_sscratch.
   - hart is in kernel space but not in trap handler, "tp" will be more
     than csr_sscratch (csr_sscratch being equal to 0).
   - hart is executing trap handler
       - "tp" is still pointing to user mode but csr_sscratch contains
          ptr to task_struct. Thus numerically higher.
       - "tp" is  pointing to task_struct but csr_sscratch now contains
          either 0 or numerically smaller value (transiently holds
          user mode tp)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Tested-by: Hsieh-Tseng Shen <woodrow.shen@sifive.com>

---
Since patch has changed a little bit from v1 and I didn't include
changelog earlier, here it is.

v1 --> v2:
 - added logic to locate task_struct irrespective of priv
 - made locating task_struct agnostic to bitness(32 vs 64).
 - added caching of ulong type in scripts/gdb/linux/utils.py
 - added more descriptive commit message

v2 --> v3:
 - amended commit message and source line to fit column width

v3 --> v4:
 - amended commit message and remove whitespace in source
 - added Reviewed-by for reviewers

v4 --> v5:
 - changing the order of changelog and sign off/review tags in commit

v5 --> v6:
 - rebased on 6.6-rc5. dropped changes in utils.py as they're upstream
---
 scripts/gdb/linux/cpus.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
index 255dc18cb9da..cba589e5b57d 100644
--- a/scripts/gdb/linux/cpus.py
+++ b/scripts/gdb/linux/cpus.py
@@ -179,6 +179,21 @@ def get_current_task(cpu):
         else:
             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
                                "while running in userspace(EL0)")
+    elif utils.is_target_arch("riscv"):
+        current_tp = gdb.parse_and_eval("$tp")
+        scratch_reg = gdb.parse_and_eval("$sscratch")
+
+        # by default tp points to current task
+        current_task = current_tp.cast(task_ptr_type)
+
+        # scratch register is set 0 in trap handler after entering kernel.
+        # When hart is in user mode, scratch register is pointing to task_struct.
+        # and tp is used by user mode. So when scratch register holds larger value
+        # (negative address as ulong is larger value) than tp, then use scratch register.
+        if (scratch_reg.cast(utils.get_ulong_type()) > current_tp.cast(utils.get_ulong_type())):
+            current_task = scratch_reg.cast(task_ptr_type)
+
+        return current_task.dereference()
     else:
         raise gdb.GdbError("Sorry, obtaining the current task is not yet "
                            "supported with this arch")
-- 
2.42.0

