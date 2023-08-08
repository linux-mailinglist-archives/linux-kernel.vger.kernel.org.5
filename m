Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F557747E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjHHTVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbjHHTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:20:44 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1509D59C7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:44:07 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe1a17f983so50053705e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513045; x=1692117845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6m3K/inEtRmdGEBBt/pEMpMfJWtxVrjJEBC47w+pHA=;
        b=Q66y5OsqazL/NZP2PQHViU2OkzU5RD4Gz4TC2r1C2MSl5aRgpQ7mAowcG2C/sJYMnd
         NxiFGQZCB1GL0dTMMLRlnr4A/MkxQnf0BbJz6d6Naa8LQEMwcxD3Lky9torH292+rpcv
         O7dpfE8eNeEJJt1U02MDJIfZhj9uJgxtLMepu5FAFSebfHsNYpt7rZQ7bK9X/6Qds7mg
         XLIDNi1Jt9E1zZHg9NE4T0XlLXqPFvoMWit7w85sKkf2MTxxs4Se3+AUu7Phy1KejlAb
         Sx5TEyzWqzdxMQSvuaM9FwMMTgh84dNS+2CNnAsY8nbi3RTwUCJ/gbwcP1rRdTnZ1Z1j
         Dnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513045; x=1692117845;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6m3K/inEtRmdGEBBt/pEMpMfJWtxVrjJEBC47w+pHA=;
        b=HJRea8AleOU0cEbR8oGynHd3pdYBIlg2ILfxLrUutPLXIj1FHDvJ5rtLhcCDNujQYY
         hWKZZ5rQYifQg7gx/ZOdyjc5eegQLaYGSMVeIxMhkKZVXePv0nyn9UsRWf8X3IJnMarq
         uYCUvTemXcMSmsxCdedHxOk753BOQF2LhmEvhseL9VB+0g/uFmguk8pBIyHZKSyhxIMP
         IkUvMD/AscR7DQ11fMcbAshE5ZiuhkOfkjIjrrTkF8nX3N7iBoBKBL8UqTGHbHu2CAeH
         tP1VrjumIs1n+qGf8I+p/ngMcr6DpwT3twnL6PN83IL6ja6TLUWVp6NaI9zRHhBKrhvj
         3hfg==
X-Gm-Message-State: AOJu0YySWSfBWnpSXOUZylxV6DBIAhs5viJt6EuvxR5DVjRnH/lg2FQK
        tvwBw0fu94Qm+V8OFMmMYwixLzT+LAKsE8c7zNE=
X-Google-Smtp-Source: AGHT+IHxDCh1uiQfUmmrydV7nAhXgfZ1Kwvcz0RMY0OKmPWNtnQhD201bB37ZY0n1WH7gHW98TyYVg==
X-Received: by 2002:a05:6512:ad5:b0:4fb:9050:1d92 with SMTP id n21-20020a0565120ad500b004fb90501d92mr8131994lfu.51.1691483163361;
        Tue, 08 Aug 2023 01:26:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fbae18984dsm1787087lfc.255.2023.08.08.01.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 10:25:55 +0200
Subject: [PATCH 1/2] csky: Cast argument to virt_to_pfn() to (void *)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-csky-virt-to-phys-v1-1-ac727f8def2f@linaro.org>
References: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
In-Reply-To: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virt_to_pfn() function takes a (void *) as argument, fix
this up to avoid exploiting the unintended polymorphism of
virt_to_pfn.

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

