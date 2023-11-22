Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22887F54E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjKVXgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjKVXgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:36:01 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0391AE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:35:57 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ea82246069so213089fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700696156; x=1701300956; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BBUVU5XWyhJgsqywEt/NScpi8dSEdT8JwJyYl8rlEbk=;
        b=bw+wj9S9qTyNHatelFTFhrGP+uGa0RJDZWWmUgFO+2ko66XR8YtRryHsvyew7Y/zzk
         Nq8t3XWmnWB2NcDFyRGRd7ccHe+PbUlPk4oaXhHfPFAoaHZ3VyufJpcSEC/IMJtdcn+y
         Etr3A5AqRR0JiYBG9/UmxKAwPJ0SUIOJ1efkp0vdxM9YHO6OIb+cA5d3Z1XQYU827WR5
         fDX+iOOGzd2YjuMLdHOY3RVHHzGytohF0OPhh7N1tilPnXKfSdp0Kgubv+tD4m/aaZZH
         C32T+AsZBMa/ZrjAXc132udF3iycKlVN4AJ8gfW/0PSkBM0CWxxNCq74jFZqjMCiWvQW
         piqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700696156; x=1701300956;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBUVU5XWyhJgsqywEt/NScpi8dSEdT8JwJyYl8rlEbk=;
        b=DG9fndt90iX4rkW4Oe6vyOmz/m8ow0S6pde9dJKAHfBbRUIgcP7X0rdb+RXPhYRcll
         VC/90ZUfdQulExwPgLXSoIXSRToc5JMMoqxe+2v48/hck0PD4UcADvJfH75UMbY7QJXW
         HoEsObogNgPPxU1Pseh4dG6D/kl78a8sHF51WUN24/QlMnY2148NbH40JEKQogV10yZ2
         UpHS/36nPjvaYe/qmHvjfpwsCepMxC9RNQro7AQQsXhiajb3Jc1Cvl+mM9EUpcYq1xBp
         c33boiHDHYeS16Q4Y0ftKfFL1oRC/wRpbFlcEGareyuWHm+XZMNxptUbAJzAkRHhpvJ4
         FL7w==
X-Gm-Message-State: AOJu0YxJAXHeMkGwiwKWCYpJcYz2Ifba0JYWHN9FIgyR+rUAe1m1C28y
        /ADPkJtN/5wpVUp0jK/+UeJdKw==
X-Google-Smtp-Source: AGHT+IFb8+2tfGIKWFBEvLHG4ZBjLMO4zV3X5f7hGXM1QeplzX7heJsGc7DXVMSbcHGvQcHSTSy2iA==
X-Received: by 2002:a05:6871:e49b:b0:1f9:5536:4125 with SMTP id pz27-20020a056871e49b00b001f955364125mr5139525oac.25.1700696156690;
        Wed, 22 Nov 2023 15:35:56 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 23-20020aca1017000000b003af732a2054sm7476oiq.57.2023.11.22.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:35:56 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Wed, 22 Nov 2023 15:35:54 -0800
Subject: [PATCH v2] Support rv32 ULEB128 test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231122-module_fixup-v2-1-dfb9565e9ea5@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAFmQXmUC/3WMQQ6CMBBFr0JmbQ2toUNdeQ9DjJRBJpGWtNJoS
 O9uZe/y/Z/3NogUmCKcqw0CJY7sXQF1qMBOd/cgwUNhULU6SSlRzH5Yn3Qb+b0uQhuDLQ7GNhq
 hKEugcuy5a1d44vjy4bPXk/ytf0JJilpo1feIOOpWNZfAyUd29mj9DF3O+Qu7atE6qwAAAA==
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ron Economos <re@w6rz.net>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700696155; l=1713;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=WzToCDP5Qw2xTrkNy2aM0wX/cM3k+sRc5gs0EqwGACQ=;
 b=/QBxu58uLtm84zLX3i6W3znwC4jhHOymQSKuIMPwMBboSBZZwItrbTXHjhD9bSPu6MnY6a9DR
 BCKUS7SU7tSBFWE3YZPTqox+oc8IG1crFtsLJgwyocTeOUApIvURJaT
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use opcodes available to both rv32 and rv64 in uleb128 module linking
test.

Fixes: af71bc194916 ("riscv: Add tests for riscv module loading")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/lkml/1d7c71ee-5742-4df4-b8ef-a2aea0a624eb@infradead.org/
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
---
Support module linking tests on rv32 toolchains with uleb128 support.
---
Changes in v2:
- Drop patch covered in different series
- Link to v1: https://lore.kernel.org/r/20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com
---
 arch/riscv/kernel/tests/module_test/test_uleb128.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/tests/module_test/test_uleb128.S b/arch/riscv/kernel/tests/module_test/test_uleb128.S
index 90f22049d553..8515ed7cd8c1 100644
--- a/arch/riscv/kernel/tests/module_test/test_uleb128.S
+++ b/arch/riscv/kernel/tests/module_test/test_uleb128.S
@@ -6,13 +6,13 @@
 .text
 .global test_uleb_basic
 test_uleb_basic:
-	ld	a0, second
+	lw	a0, second
 	addi	a0, a0, -127
 	ret
 
 .global test_uleb_large
 test_uleb_large:
-	ld	a0, fourth
+	lw	a0, fourth
 	addi	a0, a0, -0x07e8
 	ret
 
@@ -22,10 +22,10 @@ first:
 second:
 	.reloc second, R_RISCV_SET_ULEB128, second
 	.reloc second, R_RISCV_SUB_ULEB128, first
-	.dword 0
+	.word 0
 third:
 	.space 1000
 fourth:
 	.reloc fourth, R_RISCV_SET_ULEB128, fourth
 	.reloc fourth, R_RISCV_SUB_ULEB128, third
-	.dword 0
+	.word 0

---
base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
change-id: 20231117-module_fixup-699787d9c567
-- 
- Charlie

