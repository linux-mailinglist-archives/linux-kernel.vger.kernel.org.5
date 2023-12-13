Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D698811326
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjLMNmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjLMNmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:42:37 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1901695
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:42:44 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40c236624edso68565785e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702474962; x=1703079762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB+51HnZ1EhLqxZjb5NMil26fuA19Nyv7p+UCHztgCI=;
        b=XjtPyqXajYNJFRAYFLLQcIDg+K/zRzkddvXWVyWin6SoI1e6HSj5mfVYtiyhL3xiXb
         EC/eTzMe9ZsY2BHfkKGKX9URtdDJffx/jJjonm9hI4lAiDBKMKO3W+wOWvCks+SmmNHr
         ofJqcteN+B4r6su1mchbS4z6xzhltDtvtjxai5yYDWZ8Uk1cacjef58Ycyjha92p0OQ8
         TeKQ+643v/H9iRc9JExiKIGHQwLzszqcAiHStR5jwtNI0vto19jghmLa5iXoeu69z+Qv
         2w37LUQP8jxjN/4//Cflw3AdGRs6DiVE4aWTsjQbBKy9IaDbyuuyzo4EuuqjsHs5uco4
         TXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474962; x=1703079762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB+51HnZ1EhLqxZjb5NMil26fuA19Nyv7p+UCHztgCI=;
        b=IAqw1Ua/Iwww+tVFTwZd5vru3eQ2+VCRahJNsQoUbIK7NuMjeAS3WpGbVvyn1ScNzu
         Wsl8mExfPRO4y9w2rQQJb21JsLZ7dagrzYgPwC/JmObJA23z5c7Usmjxn1hF+Bjts9FQ
         fZzMpPk2IGvNRyTOeuUMPwNpCM5ueWLV3fdx2Mqg2W6ZgoFnrOusmSa0suSSeOrAr1F/
         6BdkG6pJ4VHNEvmssCR+Vgh7YyRYmdZtsIznkAyUkRVM832d9e8oRj2s4gIV8lMKgnO0
         5rKwd2W+htoH6nP/KutN/up9yVXYdMaKVygZWLJEqhdNlZYA7tEfUZVB9cZhCQKIHysE
         Yqyg==
X-Gm-Message-State: AOJu0YwNzYYcrIayVwifTPtmBZImCLUm/wzl0Ccvq7LGlSG15b9PY2Cs
        Zsy0mJyHBeppy15uadJE0XyslQ==
X-Google-Smtp-Source: AGHT+IETI3kyqEYJ/qlZfh0+NlonQyfI339qGsyMbMK4dWWwNoP12b0YuZDoOk4QRJyA0AaWi9ozAQ==
X-Received: by 2002:a05:600c:35d6:b0:40b:5e21:cc40 with SMTP id r22-20020a05600c35d600b0040b5e21cc40mr4337934wmq.107.1702474962563;
        Wed, 13 Dec 2023 05:42:42 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040c4620b9fasm11988105wmq.11.2023.12.13.05.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:42:42 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 2/2] riscv: Fix set_direct_map_default_noflush() to reset _PAGE_EXEC
Date:   Wed, 13 Dec 2023 14:40:27 +0100
Message-Id: <20231213134027.155327-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213134027.155327-1-alexghiti@rivosinc.com>
References: <20231213134027.155327-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When resetting the linear mapping permissions, we must make sure that we
clear the X bit so that do not end up with WX mappings (since we set
PAGE_KERNEL).

Fixes: 395a21ff859c ("riscv: add ARCH_HAS_SET_DIRECT_MAP support")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/pageattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 96cbda683936..01398fee5cf8 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -383,7 +383,7 @@ int set_direct_map_invalid_noflush(struct page *page)
 int set_direct_map_default_noflush(struct page *page)
 {
 	return __set_memory((unsigned long)page_address(page), 1,
-			    PAGE_KERNEL, __pgprot(0));
+			    PAGE_KERNEL, __pgprot(_PAGE_EXEC));
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-- 
2.39.2

