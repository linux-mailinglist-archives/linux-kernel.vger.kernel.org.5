Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD881801C65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 12:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjLBLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 06:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjLBLOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 06:14:45 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A6197;
        Sat,  2 Dec 2023 03:14:51 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bd8efb765so2280969e87.1;
        Sat, 02 Dec 2023 03:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701515689; x=1702120489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4UHd4uT25TxSUzWPqsFRoZZNpRl4b4/7589i+JJ+rU=;
        b=HfZFF7nN/oDW4wix+atLctYMRShwcmwalhtabQ9cZATlVxB4WAgWsV9+TiFCSHbuFv
         ACUiiH5ol6NAIK8jI9ak/uBkf47n2TyfMrJIZMYI9E3K1kiQZ0Kk7XNkIDV+keeT2Rfn
         SWmztovrDAcAZ6gI6PqmxXchUplEyyzZMmrjeB2+kPLuym4iOHqTpmBBW8OexEHLiF46
         ItDckB54zXmycUXLaj92EE1O8yDAergFxGFs8Cym17KNreMn+SO8YPNGRJNOTnMaWjOL
         FH+fEVdol9uxzx/4mG9mFuWlNi3FVaUQqNMThsJVFyWe6LmLU+v3lQNvPq8BTM1+bIrz
         ynyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701515689; x=1702120489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4UHd4uT25TxSUzWPqsFRoZZNpRl4b4/7589i+JJ+rU=;
        b=nW6NltFONyARU5kc7AkU8yM7Ajykvm+STK4Q/VI2jpcgLyl6BMxB1Bj81umdrqoSUm
         FxEXzzOuPq+7WhGfBsnMCmCkGI8NRZ6murZZZQqvetGXHhph4nKtS03MMDJsdtsYL+Bd
         DbCCkXyQC+8nAxvaRDYNa5T2d5pEt+2wdI/ijhWkdg+KSGNjLHooBst1Y4dFFkBVY87H
         4Uw3BBHPPZ00/EPveF1ZKM2gnNDT+4fRnEq/RsUb46641cNRAhXdzeYl62vY+iQ74pxF
         zTkXHVIHj+5x/kIpgWKcFrlzyvAyUnjwPae/vQLsO5d5uxQVfbeox5qH164BLgfH5g1U
         mt4w==
X-Gm-Message-State: AOJu0Ywx4O3m++gIMOld3b9kqfHhTZP8yPcyHSB8rqK3GXHGgwe8oM/b
        aDnkTE5qAhAWhbgJkO09Frs=
X-Google-Smtp-Source: AGHT+IFfdPNpiwefBvmuORgudPwNl6+kLbXV7fHeB560V9AMzknQFD1jotIAw/L6yW8iedkhemVsqg==
X-Received: by 2002:a05:6512:110c:b0:50b:d764:969d with SMTP id l12-20020a056512110c00b0050bd764969dmr1786496lfg.129.1701515689264;
        Sat, 02 Dec 2023 03:14:49 -0800 (PST)
Received: from localhost ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id c6-20020ac25f66000000b0050bed336e0csm66231lfc.162.2023.12.02.03.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 03:14:48 -0800 (PST)
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
Subject: [PATCH v2 4/6] mips: Optimize max_mapnr init procedure
Date:   Sat,  2 Dec 2023 14:14:21 +0300
Message-ID: <20231202111430.18059-5-fancer.lancer@gmail.com>
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

max_mapnr defines the upper boundary of the pages space in the system.
Currently in case if HIGHMEM is available it's calculated based on the
upper high memory PFN limit value. Seeing there is a case when it isn't
fully correct let's optimize out the max_mapnr variable initialization
procedure to cover all the handled in the paging_init() method cases:
1. If CPU has DC-aliases, then high memory is unavailable so the PFNs
upper boundary is determined by max_low_pfn.
2. Otherwise if high memory is available, use highend_pfn value
representing the upper high memory PFNs limit.
3. Otherwise no high memory is available so set max_mapnr with the
low-memory upper limit.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Since I haven't seen any problem with the denoted misconfiguration on my
setup, the patch isn't marked as fixes, but is supposed to be considered
as an optimization.
---
 arch/mips/mm/init.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index 6e368a4658b5..b2dce07116e8 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -421,9 +421,13 @@ void __init paging_init(void)
 		       " %ldk highmem ignored\n",
 		       (highend_pfn - max_low_pfn) << (PAGE_SHIFT - 10));
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
-	}
 
-	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
+		max_mapnr = max_low_pfn;
+	} else if (highend_pfn) {
+		max_mapnr = highend_pfn;
+	} else {
+		max_mapnr = max_low_pfn;
+	}
 #else
 	max_mapnr = max_low_pfn;
 #endif
-- 
2.42.1

