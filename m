Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7D97D8C43
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJZXjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:39:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8C6187
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:39:16 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b3e13fc1f7so916453b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698363556; x=1698968356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q790Td8gv55CpXw6jh1r5+WUtiBYMYeRT8D2CcfTbo=;
        b=0t70StkM57mDEH5BL/0SDyonh+2YTbDDvRHnjTC0z+l4Uqdv9H5KfuX9XUHQh/igf+
         h69L3TORi+AjhkLA8Mk+aoCU72jGla6Dsh55rdQjgWGXOYEt2gT8A9KsgprYB39HLvwc
         IzG9xPjnn5ugv3VEYu5q7xwDKKhpGSLzWzeq6IicMBFRQtHMFeFm52Dod70/MxWuZjUx
         UDTQeM1ThuA8pOdTDWWuWeIeAIUIL604DOZEd0eISsgwlCbHQTVHpiLCQkHVheWGhh4M
         qBq2JvwB4ybo8x/qAvj9/E7AhZqFc1uSBdPqPDW1+DlSQRhcRPCG06pCYrvliW6wr/xg
         hZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698363556; x=1698968356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q790Td8gv55CpXw6jh1r5+WUtiBYMYeRT8D2CcfTbo=;
        b=QJ6rm6CnOkEFmj1Pws+3YpTqovO7E690Fr3GKzmY9ejYsiA1Dqb9hnP0bILvjwAXTn
         C1Ft6yJWL99U9/TblrJ980qxwZOS5Yf9OF66WBkPGqlCVpQMnH38rnhKrKI72x13/3Yo
         x2NTh3AH8s7+PN+BOxu5+NnNVldxGtsfC3EM3+bft523bNe2L9yl6G1SWplXGU7ROZ1I
         mRmLnLKU8AOI+8OhxHRCDby93QZIoQSHN12Twe6c/xtbmEYCFaksxi06fxa3HJStJ9De
         X1CVeF7yd+5sdcK49J/elH19eqUvaQrlvyqCLAc75aMoeeuOU6UK95I/f6R6gYLVYrhw
         WL0A==
X-Gm-Message-State: AOJu0Yzql92A7YTM29ox/w8zyuc5gaAx+ISUvH60OC66EJUglWZOHxnv
        psxr8lRC3usASF4jybk5scOHeg==
X-Google-Smtp-Source: AGHT+IGspa/NwBVlm7egg/NUIf9wRnx9xFti1J1wWM2v39V48oPOgG67Ph4EfplexaEg3gbCWIy78A==
X-Received: by 2002:a05:6808:1594:b0:3a7:5557:16ba with SMTP id t20-20020a056808159400b003a7555716bamr935245oiw.27.1698363555922;
        Thu, 26 Oct 2023 16:39:15 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n9-20020a05680803a900b003ae51628725sm76809oie.13.2023.10.26.16.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 16:39:15 -0700 (PDT)
From:   Deepak Gupta <debug@rivosinc.com>
Cc:     woodrow.shen@sifive.com, Deepak Gupta <debug@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Glenn Washburn <development@efficientek.com>,
        Jeff Xie <xiehuan09@gmail.com>, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v6] scripts/gdb: add lx_current support for riscv
Date:   Thu, 26 Oct 2023 16:38:23 -0700
Message-ID: <20231026233837.612405-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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

