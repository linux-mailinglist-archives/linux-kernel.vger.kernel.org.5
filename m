Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD177719D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjHJHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjHJHkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:40:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BA8268D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:40:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso9116771fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691653232; x=1692258032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPNuwr8BV2crYdR1HSxa9CVFwtJ2x4ORzKRyFk7VJAs=;
        b=jZlUe8GqXYZExHEJdIjbkYCeW5NeDHITr/Fgx1X6BQQzH+TcMTfY7zWzrjCM5fXdGG
         wVTk7Z5VEteWvnFlpVciGAaQ3AQPV68SaDecR70MGUuyh/CB0I1+a2Mh3OtXhPNg0PG8
         k5PuUUHO1Fg4SrMYMiHFsQGRvDsoGXZm3Tj3q/1+SN8ScI9aXbBqbBLCcNi+PkazlbNR
         P2A1myCEQ5zkOwT+1JU6wOcWKJyO7jH0tkOIrRv12LrcEycE1LfXKlqizKt38zylaseU
         FYKYufBLCbLw9IqxbCM54RVW4cddZ6HRGUECzkzvFmiw4Rt5CZNMG6pmOx0ZiDyih0Q9
         YVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691653232; x=1692258032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPNuwr8BV2crYdR1HSxa9CVFwtJ2x4ORzKRyFk7VJAs=;
        b=gNAQdV03Pd/SrPwctg9nWYe7NqDnaRF2C7Gzr8ziRMOwfjEdztfau4SDDOJFBRYJhh
         otaJtdFYMM+lNb/AY++NA1jITDk/0Jwa3gb4ba37OniDy7a0ko7qtSZOe759ehs7Ey8B
         SaeySyGlgtlEx3FGeOz5gwPT+MJy1jf+u01bB6bU2PaKaTF+K8XO1a0pqlvo3KGkZfFI
         rH1PNRetuVhQsOAoSikebZgMv1JBGZbVpNY08/T2BtNSuBabU6BJp3IxTqIue8Q/yrKX
         aTznls7G18zCK8X0IbTQ/AvSrWHcAZDSZn/erQaWY8iD9EcnS6q+eUyHtr0HGCDx38n+
         a1Mw==
X-Gm-Message-State: AOJu0Yxk34Hc6+MNXY5dlWU5MVax4Munqzdk3sj5GLPqHsjF8eo5wItP
        4nTX2r1+vUq3imaOIuFj5DnEAg==
X-Google-Smtp-Source: AGHT+IFlkZYCIiwaDGHbE/zE7M2+pApQbVX+Ao8fS2UH3Jodv3XH3X3vJgnTEUPCTvmpoObHgQzlIA==
X-Received: by 2002:a2e:9b43:0:b0:2b9:b904:74d7 with SMTP id o3-20020a2e9b43000000b002b9b90474d7mr1221973ljj.18.1691653231817;
        Thu, 10 Aug 2023 00:40:31 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id e4-20020a2e9844000000b002b9ff8450aesm234500ljj.91.2023.08.10.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 00:40:31 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Aug 2023 09:40:30 +0200
Subject: [PATCH v3 1/2] csky: Cast argument to virt_to_pfn() to (void *)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230810-csky-virt-to-phys-v3-1-f443cd2fc050@linaro.org>
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

The virt_to_pfn() function takes a (void *) as argument, fix
this up to avoid exploiting the unintended polymorphism of
virt_to_pfn.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index e43fe27ec54d..02b53ad811fb 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -108,7 +108,7 @@ extern int pfn_valid(unsigned long pfn);
 
 #else /* CONFIG_HIGHMEM */
 
-#define ARCH_PFN_OFFSET		virt_to_pfn(CONFIG_LINUX_RAM_BASE)
+#define ARCH_PFN_OFFSET		virt_to_pfn((void *)CONFIG_LINUX_RAM_BASE)
 
 #endif /* CONFIG_HIGHMEM */
 

-- 
2.34.1

