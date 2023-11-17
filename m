Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAED37EF81B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKQUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQUBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:01:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3110D68
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:01:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ce675e45f9so1016605ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700251271; x=1700856071; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5N8jhPC2zAZdLSZQNFglxA0EJk3ILNqkyKhBDD9MOWg=;
        b=nrCl0MXY2inaY8kWB2sZ2ebZf+1eXzzWmoYzHKriBii5HMT47OJChvwOnixrDgrZFl
         owI37n4EDGDnhlsmDxGUYxb3rMd38ICUkoYH5JXlHt0M7oE6WPcqaXjoFZz4yGYXC35r
         sKunIiF7Jf9bBDNt3yKwpm+gGnM4QIg6NKIt6rPpg6NtnLeM2mOMQ9zlIAlTvATrKZaY
         3UsP6PnA2Hi7dz32754Qh3J8P6d8JVkE8GzUFqp+xp47mLcU0+QsvpeXRIkBiXGp53TF
         pjlyOWkYgqMjZvdj6FhpXGSbgdG5UAGLx7/Uh/TyJ2Wag0LloJy47roQt4fovRFeNSrY
         KmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700251271; x=1700856071;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5N8jhPC2zAZdLSZQNFglxA0EJk3ILNqkyKhBDD9MOWg=;
        b=vnBu5+U0/fcNObKLwWhLDp7obhouWhhMQKPjWcU61XYsrVSY7EsDneAHlGfCIdGvdc
         3ynQ3Ttn8+I+WF/XWxOg6rarp4FghRynI/1AXjXotO1BuF51N17fC8dySkrz4aQ60h5g
         szrKNYocpso8e0ohgKtltmuDD/FdsXqPG4gQGZ4jkKU7kHiv2fhCEfJ0BEvsd9K9VKzY
         RG8249DNMe6+6oC1peA+a8dElULOkdKLCeXUlS1gDD16QELKivoYShgLww3hzitOG0N1
         ywnIjQriqPjk2LgH9JcuZAjzg/a1HnXCPaQGO94WKT3eFYPlA8XkHqDdL2LMpAqKmasf
         DyfA==
X-Gm-Message-State: AOJu0YxLB0ouGsn2oTgLrNqUILFtKEpMdQICl/bHtL0VmNwgWhVg+9G+
        /2VJ+aqueCZ7N49BXTD5MINP5POP20bUy7pYG0s=
X-Google-Smtp-Source: AGHT+IEtyI1dEot9h2n/T0d1ycxinXg8zY/heVfpoPKEeMwwX12IT+/3OVGyAeHlGjsRBtdvsTxuNg==
X-Received: by 2002:a17:902:ce81:b0:1cc:6d2c:fb59 with SMTP id f1-20020a170902ce8100b001cc6d2cfb59mr855254plg.28.1700251271032;
        Fri, 17 Nov 2023 12:01:11 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b001b53953f306sm1749737plb.178.2023.11.17.12.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:01:10 -0800 (PST)
From:   Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH 0/2] riscv: Resolve module loading issues
Date:   Fri, 17 Nov 2023 11:56:10 -0800
Message-Id: <20231117-module_fixup-v1-0-62bb777f6825@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFrFV2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQ0Nz3dz8lNKc1Pi0zIrSAl0zS0tzC/MUy2RTM3MloJaColSgBNi46Nj
 aWgBtf/pqXgAAAA==
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous commits caused compilation of module linking tests to
fail on rv32 toolchains with uleb128 support. The first patch resolves
that issue. The second patch resolves the type issues pointed out by
sparse.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Charlie Jenkins (2):
      Support rv32 ULEB128 test
      Correct type casting in module loading

 arch/riscv/kernel/module.c                         | 8 ++++----
 arch/riscv/kernel/tests/module_test/test_uleb128.S | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 9bacdd8996c77c42ca004440be610692275ff9d0
change-id: 20231117-module_fixup-699787d9c567
-- 
- Charlie

