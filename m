Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE27801C66
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjLBLO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjLBLOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:14:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4184198;
        Sat,  2 Dec 2023 03:14:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50be9e6427dso261994e87.1;
        Sat, 02 Dec 2023 03:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701515691; x=1702120491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1T4NHCKaEUJcD00hRH2cGzkJVzfRK4nR9CtS9DswDWw=;
        b=ZLWynJYZqs1lHeaNgkBKy4vWVZ0nmHjrnx/qKSxjxNzIdYwgwg/Xxz6lM/+WbrtVi2
         OFnCFdmhD0bjMvM0WR8Rc2+Fl4/OlHz4Jcb3NCq0XEq41xU6/U0vDQIAqpSAJLlOKwyo
         p445N2Kv/3o8zgsLSBMtp1rt08G+fR56EBssOxmkjEieKKG2ESFkX1g2P3jaDwKl8fEj
         p3YZnw0jdlSET/DBPIwcQPkvmFTG0Jb0um45otdW2qP70I5hIG2lyCiaqiHMqHiFHLUx
         qJkKykUY+gzslby3cUyamaBYRixsq5DSJT23rh2W6LKBRA2VqRl7El6H5TwODuM7p4W/
         HMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701515691; x=1702120491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1T4NHCKaEUJcD00hRH2cGzkJVzfRK4nR9CtS9DswDWw=;
        b=CRxRjgZhO+qDHjKueDqgjcT7/dy9HS/DNz0clSwnllVCdSNHwYhlxC7dl4JjubvUcP
         gqn/aRHiCthu5IfgbMA5PqLENX3shSaEReMK6WqVYoSIvoP98td7A5hljDey5ovfGdDn
         3L46RyJgiq/tcFqRVkFeIMG0aTTwZefhenDBJ2AaZyCvoC0WUbXtvdA9pjSWbi/to8vy
         aL0U7EotBwB8i4pUSJ46r/leDjTaAGD8A4QB8G71weZ1aTySYwq4yNqQf/Y5H3TxA5Ai
         D9IEIuCd8GpW7Bji7TyqOcZ3sYZUDZYNKT+h4IPswqy9uEFJWLHPBx9KtoLHdnrM3i+g
         rxRQ==
X-Gm-Message-State: AOJu0YyNqEGM7IsVnMCK3X79HkNk8oN0UNwmmsHOrFKJYlWUVGhgX8r8
        ntUZUIsE/l8LmJEVpGbwea0=
X-Google-Smtp-Source: AGHT+IGCOXEU6dk6EGZWe/MP0XMGJO+yiD5xEQj5BjaTp5rOtf5nyoi67HG1zxO63b1IPn8ZI6EKlA==
X-Received: by 2002:a05:6512:2316:b0:50b:d764:801d with SMTP id o22-20020a056512231600b0050bd764801dmr1888678lfu.80.1701515691032;
        Sat, 02 Dec 2023 03:14:51 -0800 (PST)
Received: from localhost ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id b27-20020a0565120b9b00b0050aab07eb9fsm200142lfv.139.2023.12.02.03.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 03:14:50 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Baoquan He <bhe@redhat.com>, Chao-ying Fu <cfu@wavecomp.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] mips: mm: add slab availability checking in ioremap_prot
Date:   Sat,  2 Dec 2023 14:14:22 +0300
Message-ID: <20231202111430.18059-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231202111430.18059-1-fancer.lancer@gmail.com>
References: <20231202111430.18059-1-fancer.lancer@gmail.com>
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

Recent commit a5f616483110 ("mm/ioremap: add slab availability checking in
ioremap_prot") added the slab availability check to the generic
ioremap_prot() implementation. It is reasonable to be done for the
MIPS32-specific method too since it also relies on the
get_vm_area_caller() function (by means of get_vm_area()) which requires
the slab allocator being up and running before being called.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/mm/ioremap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index b6dad2fd5575..d8243d61ef32 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -72,6 +72,10 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, unsigned long size,
 	    flags == _CACHE_UNCACHED)
 		return (void __iomem *) CKSEG1ADDR(phys_addr);
 
+	/* Early remaps should use the unmapped regions til' VM is available */
+	if (WARN_ON_ONCE(!slab_is_available()))
+		return NULL;
+
 	/*
 	 * Don't allow anybody to remap RAM that may be allocated by the page
 	 * allocator, since that could lead to races & data clobbering.
-- 
2.42.1

