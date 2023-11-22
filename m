Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045697F483B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344246AbjKVNwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343568AbjKVNwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:52:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C93101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:52:03 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so1483701a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700661123; x=1701265923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7husD+9d3F1Gv9OOp27OuBbyYe5n6sJHNp6uS06FL8=;
        b=GITl4jk+oxBwXrszNoXyNcJPHcH1PiihIC+kFMtYKY1TIJeJ3VzrN3KN5d6LeQjFif
         tExWUi+U2pwYjMov1dcxUPENVTsLO7IzBD/EnVq8rygWNZxerP+JkgahMiUwc1QUtIAL
         eN/GyZyViieWG0hKyLqM4xXVFePPqrvAXbqZZCML8k9yO05genOr4ux4JG52eLX3C03j
         LSR7rT1mU3k2kRsbgXDQDZEdvu1RL6iGPE2cBQqBITPCdbl5pE29XmJ6ZzRkzxTQDpLe
         nSjYZmDcvzxcWZGHVvzmWbVMjv+RJoU1gA68CIbvBkzdx3TSLK+G9ooNN5++iAywFki9
         3WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700661123; x=1701265923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7husD+9d3F1Gv9OOp27OuBbyYe5n6sJHNp6uS06FL8=;
        b=cJaZ1EZjwxoTHD4we3ZmBdiTjLg6DMQR0Dt9LcDtJtkPHCdLKfFAFDJppdTbGX6M1q
         JTpYxGoNCvgkg+U2TshEnQa7tGTGm8duuDpfk7yWK/dhzZg9fPj1UwQYFwhV7PiD8pfw
         s6KKbNwWnHdr+mP74uG8QO4nUK37XBAPEHAg6PvtKF+dSYZcumYExTG8uItXQupY/FQ1
         cxBMMTIP1QXG3PJBHYDz4O9orEyG+AGpD+wC7NMiaa3JlqopkuW4LgZbp9wjmvpNcaa/
         9xQdM0cxu7ZNpXfLqw38x6M7WwGojc0tsbjfxlPuYsbL+xasHVjV3EJS+0gZ6bSbRRac
         SHmw==
X-Gm-Message-State: AOJu0YwvJCMdhiq7J/3eai4IjoINximZilwA/w2IBGevJKqRJ77HsfAQ
        FCDh1FFS8ndg1CQipH2agbirpA==
X-Google-Smtp-Source: AGHT+IE5Dg+TMXVzZNn0mFXompSbIgWw4KFeIm5Q5UstyfAp14qFST/CkbxoGCVx/IGuAn9WPK835w==
X-Received: by 2002:a17:90b:d8a:b0:285:e55:68b8 with SMTP id bg10-20020a17090b0d8a00b002850e5568b8mr2374428pjb.1.1700661122833;
        Wed, 22 Nov 2023 05:52:02 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:edca:1f11:8726:b116])
        by smtp.gmail.com with ESMTPSA id rj1-20020a17090b3e8100b0028031e87660sm1387947pjb.16.2023.11.22.05.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 05:52:02 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: fix incorrect use of __user pointer
Date:   Wed, 22 Nov 2023 14:51:41 +0100
Message-ID: <20231122135141.2936663-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These warnings were reported by sparse and were due to lack of __user
annotation as well as dereferencing such pointer. Fix this by adding
__user cast were needed (load_u8()/store_u8()) and move the __user
annotation in __read_insn() into the if() branch that uses __get_user()
with this pointer.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311160606.obGOOwB3-lkp@intel.com/
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 5eba37147caa..02abb6616873 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -319,7 +319,7 @@ static inline int get_insn(struct pt_regs *regs, ulong mepc, ulong *r_insn)
 static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 {
 	if (user_mode(regs)) {
-		return __get_user(*r_val, addr);
+		return __get_user(*r_val, (u8 __user *)addr);
 	} else {
 		*r_val = *addr;
 		return 0;
@@ -329,7 +329,7 @@ static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
 {
 	if (user_mode(regs)) {
-		return __put_user(val, addr);
+		return __put_user(val, (u8 __user *)addr);
 	} else {
 		*addr = val;
 		return 0;
@@ -341,7 +341,7 @@ static inline int store_u8(struct pt_regs *regs, u8 *addr, u8 val)
 	int __ret;					\
 							\
 	if (user_mode(regs)) {				\
-		__ret = __get_user(insn, insn_addr);	\
+		__ret = __get_user(insn, (typeof(*insn_addr) __user *) insn_addr); \
 	} else {					\
 		insn = *insn_addr;			\
 		__ret = 0;				\
@@ -356,7 +356,7 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 
 	if (epc & 0x2) {
 		ulong tmp = 0;
-		u16 __user *insn_addr = (u16 __user *)epc;
+		u16 *insn_addr = (u16 *)epc;
 
 		if (__read_insn(regs, insn, insn_addr))
 			return -EFAULT;
@@ -376,7 +376,7 @@ static inline int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 
 		return 0;
 	} else {
-		u32 __user *insn_addr = (u32 __user *)epc;
+		u32 *insn_addr = (u32 *)epc;
 
 		if (__read_insn(regs, insn, insn_addr))
 			return -EFAULT;
-- 
2.42.0

