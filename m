Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9377719E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHJHk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjHJHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:40:47 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7835C2697
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:40:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so9274031fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691653232; x=1692258032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JE+tuaEjTOobPVuUoR018Dq94fxPMbAMe7BcedomcTI=;
        b=WnmBDlQNs2BhfbzgpjkxvyonZEj2KENAKRPJCd6GxuoNAbLIb/BsmV45oj5T2IzBwu
         efwKJ+BHHwpYOXdX9wtBsU0r6j00Y4rFnM1DNNd8g+8J7KfnJhVetrbExXYhBvpDftIc
         P+jlxgZDoevp5MpQCxV99jQU7N3UGViCeW8VeuCpwI5W8Lxg8JQSIRgouBbOMu2cVWlZ
         qVzbGHLyD4hcTKwGmY5CxC8JVdhSV00OZyt7JqD9WNu4BES5SrPRKmZInUsKVgvcmyzq
         j/bjj3XjtQqB/qtaaPkLSVbIGaSZarxdbquiowkUuRzIAZpPddxnpZla5MuIdu3VFkrt
         EdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653232; x=1692258032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE+tuaEjTOobPVuUoR018Dq94fxPMbAMe7BcedomcTI=;
        b=iRNITyEM724pYCWDc1nIAkl3tqXceMmVUAD0YGimuE22Lb1tIlwV3YDbB4E14lF6px
         frVGIv8tNEqe4b4kXz9tcnSHuNP51ILPfYF1NIz6O2wSzoyPa6FhQIoG+PgWCW0l97kx
         5BFFNoDhrceTB0SyRQdsPDs4/q38RAd8knm48d6qEwfurjQmv2chQzWrWbFbY3u2IBzu
         uYKyXhb1bzKtAHvMuraDm683u1Ym/WcJOOzyX9Sdb0P+VrgHK1YrMhL63WebioRo/qpe
         LjA3BCNHOfqTvu5VLGjdOxLAXK9Az23myEU0j93lss0INmYOKN+FNc7arg7UcBGm+WLV
         uD1w==
X-Gm-Message-State: AOJu0Yy9urqIWeqgUx5jV4G/5MC5qPmfbwYzowGeI4uINwF/bzzEZeej
        nDkVqxG2V4fEXcLo0FdH5xlT4g==
X-Google-Smtp-Source: AGHT+IGTCkUJ2WjN0231+Tnp6zfFH1j+DrdjHXon19Cy+1wCYY/UtmjxyKbtrGQCc+k6kJZn6bv71Q==
X-Received: by 2002:a2e:9f4b:0:b0:2b7:3656:c594 with SMTP id v11-20020a2e9f4b000000b002b73656c594mr1272196ljk.3.1691653232743;
        Thu, 10 Aug 2023 00:40:32 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id e4-20020a2e9844000000b002b9ff8450aesm234500ljj.91.2023.08.10.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 00:40:32 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 09:40:31 +0200
Subject: [PATCH v3 2/2] csky: Make pfn accessors static inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-csky-virt-to-phys-v3-2-f443cd2fc050@linaro.org>
References: <20230810-csky-virt-to-phys-v3-0-f443cd2fc050@linaro.org>
In-Reply-To: <20230810-csky-virt-to-phys-v3-0-f443cd2fc050@linaro.org>
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry to the same thing with pfn_to_virt().

In order to do this we move the virt_to_phys() and
phys_to_virt() below the definitions of the __pa()
and __va() macros so it compiles. The macro version was also
able to do recursive symbol resolution.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/csky/include/asm/page.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index b23e3006a9e0..4a0502e324a6 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -34,9 +34,6 @@
 
 #include <linux/pfn.h>
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
-
 #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
 			(void *)(kaddr) < high_memory)
 
@@ -80,6 +77,16 @@ extern unsigned long va_pa_offset;
 
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
 
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void * pfn_to_virt(unsigned long pfn)
+{
+	return (void *)((unsigned long)__va(pfn) << PAGE_SHIFT);
+}
+
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
 				 PHYS_OFFSET_OFFSET)
 #define virt_to_page(x)	(mem_map + MAP_NR(x))

-- 
2.34.1

