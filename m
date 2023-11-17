Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008327EF81C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjKQUBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjKQUBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:01:18 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247FDD6A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:01:13 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc1e1e74beso21240245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700251272; x=1700856072; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFY9yyw+/EAdIRUxdIlmPfWs3oHbG4Tu++kYGInr8MQ=;
        b=bzFeIzWMPm+/0dMozHI/Kobn4mCLpm09WvAAi72Dj+KYJFOl2rSt1TvrhinPx00785
         h3BTFvsLrfQ3USlKgzj5HXJ0R6eWLcyrvKyhmMhvgDlBU4+CNIrmBb3tXCt5PQsOpU8f
         t6I0OW2wBJHWmo4+KkZlct4Hl94HJT57ZLITdL6Hrb9qIjY0VBK5iA0X0rfrlSb2Us94
         NsZcX+nNbUvp0ieMVFyy9FMImvvR5WrygHlckbny4FQvcAWVM01Ejm6PW6FJGviEptJr
         uIt4Zdv0Vx4D7/2ZzKLvrBrrGiBmT8MRB6BCYGHxxOjZrVGHnMGxu9ylqdBUVNf5RSW0
         sFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700251272; x=1700856072;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFY9yyw+/EAdIRUxdIlmPfWs3oHbG4Tu++kYGInr8MQ=;
        b=pPmybbYSH2Q6+F2N73NdTzxcYcF/2coSfCJjihbv16cqq1lEU2GHyY4123gveTIm3f
         KK8EDmvYp4lqlmdsO4fvylIzT5xkNYabaO0/wUUWR2ECVu5z7wcRQLqT0XHZYFBNSc72
         IjpSoDlVnrlirBXfXhk1f/4lYoIY7DVhfCIfZjtoWWH7RjiqzR3xJ9WERuqF0s3BHbg6
         hU2bNjqGbC1FeF2YspqLzfRvRd2lLYy6Ec7ZgdjvZZF6pLg8ZQXJ9cb3qBxx1tjGdWFl
         aVMcQy1G7tAwv5gmtMglSHDUtHBHJEaSPtUu1sMyFIAlkKATFXUPktthKcXhc9XdmD+J
         J3zg==
X-Gm-Message-State: AOJu0Yz1zgO28xaw5x3iTlRrxhI6/f8Pu/Md6y3l16psc/YdqpY+aGf4
        IAVeLcvHiJPBhepkwWZ3ihWnnQ==
X-Google-Smtp-Source: AGHT+IEZETbP2T/dkEnvQJyicMa++aA+ZLyZ7dyLJO2+XFAKGQHurPfaAZ0f+yK0ANeWCP6Zuh/+bQ==
X-Received: by 2002:a17:902:9687:b0:1cc:431f:55e6 with SMTP id n7-20020a170902968700b001cc431f55e6mr543932plp.63.1700251272659;
        Fri, 17 Nov 2023 12:01:12 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b001b53953f306sm1749737plb.178.2023.11.17.12.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:01:11 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 17 Nov 2023 11:56:11 -0800
Subject: [PATCH 1/2] Support rv32 ULEB128 test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-module_fixup-v1-1-62bb777f6825@rivosinc.com>
References: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
In-Reply-To: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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

-- 
2.34.1

