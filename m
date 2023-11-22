Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F177F4F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbjKVSYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbjKVSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:31 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423E101;
        Wed, 22 Nov 2023 10:24:26 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c88b7e69dfso1049621fa.0;
        Wed, 22 Nov 2023 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677465; x=1701282265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjHlY+dwgtlGLlPuvunFHNqCcfV7AAmhZsbau9o57nI=;
        b=TFneLshPOYhMYydbFoqoDC0+aUnlWtda4nBQBx89mhakocuYN98Wsh0gTgCf2IbxMA
         CRKoVW1kLaJOQeL6nD/nmRb1MEbJonmA5c14vFrAbJ1si60oFkum8MDFZna+irO0dG02
         d9Os6/Wkj/p/Lrvdc+v2s5W9zhifiKuVT3JuU6PDzvjZPdy8oospaGV7XZVN/kBs0Wz/
         Vk5VAEGN7nTY9RyEA//o81DDtyUdDd5lliM0J2K6BZJdYqQV+teT6AiL1aGkmQONJgA5
         QEt0Qr1LJKATM+B3GyOV1lsWQXLWz1wzRUUmQaYHHByY5SYG1v9ZfDDz+p+Fx7qpLXbI
         lAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677465; x=1701282265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjHlY+dwgtlGLlPuvunFHNqCcfV7AAmhZsbau9o57nI=;
        b=c4p8OUYoHCGolknF9Qiy9QC39xabTSZsDJNcz5f6IXy8h+V7bunF/ak0sHLt+scNWq
         wkzhQBLVhK08B9kyNCjy7ov1+nfowFm18oM/N2xs9yn8AEEIjkVWIvewzsywS88LfAj0
         ClNVZy/ixIxC8znWbO6WMHCEKjbqTj7b0d1oK61tH4g8KiOCPs/gYVwV/p1e2EkJBRV1
         L++EKvsIojDXrNw2J/XxnNjBleJKNhYXLBUb6K9KeHoQGbC14QcWiih/kCe4GLwJMVpy
         lHk5ecbo/VwTUh5aW/DB7DfHxNf+ECa69uSL1+XNttRBkSVffFfE9GD48Kczk4qo9gdT
         N5gA==
X-Gm-Message-State: AOJu0YwVI37vrmoopDY2MJdQrsxjExVhc2V8ARtsgpXWcft2ToEov7R5
        y5NLpar6nl+qHSrd2xB+bfo=
X-Google-Smtp-Source: AGHT+IFXwabmg+qbE103kF3TmOv1sYfzVGr6ur/Y2zlrmwFdEQbij6rj3CZvgc4sXeVNfM5Rzy7XRQ==
X-Received: by 2002:a2e:91c7:0:b0:2c5:24a8:c22d with SMTP id u7-20020a2e91c7000000b002c524a8c22dmr2198720ljg.3.1700677464782;
        Wed, 22 Nov 2023 10:24:24 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f6-20020a2eb5a6000000b002bcbb464a28sm12020ljn.59.2023.11.22.10.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:24:23 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>, Marc Zyngier <maz@kernel.org>,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mips: dmi: Fix early remap on MIPS32
Date:   Wed, 22 Nov 2023 21:23:59 +0300
Message-ID: <20231122182419.30633-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122182419.30633-1-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dmi_early_remap() has been defined as ioremap_cache() which on MIPS32 gets
to be converted to the VM-based mapping. DMI early remapping is performed
at the setup_arch() stage with no VM available. So calling the
dmi_early_remap() for MIPS32 causes the system to crash at the early boot
time. Fix that by converting dmi_early_remap() to the uncached remapping
which is always available on both 32 and 64-bits MIPS systems.

Fixes: be8fa1cb444c ("MIPS: Add support for Desktop Management Interface (DMI)")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/include/asm/dmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dmi.h b/arch/mips/include/asm/dmi.h
index 27415a288adf..525aad1572d1 100644
--- a/arch/mips/include/asm/dmi.h
+++ b/arch/mips/include/asm/dmi.h
@@ -5,7 +5,7 @@
 #include <linux/io.h>
 #include <linux/memblock.h>
 
-#define dmi_early_remap(x, l)		ioremap_cache(x, l)
+#define dmi_early_remap(x, l)		ioremap_uc(x, l)
 #define dmi_early_unmap(x, l)		iounmap(x)
 #define dmi_remap(x, l)			ioremap_cache(x, l)
 #define dmi_unmap(x)			iounmap(x)
-- 
2.42.1

