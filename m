Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1A87F4F74
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344418AbjKVSY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344071AbjKVSYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:24:43 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D2410D5;
        Wed, 22 Nov 2023 10:24:36 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so984031fa.2;
        Wed, 22 Nov 2023 10:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700677475; x=1701282275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Du+BFHRvMyqAEjBg6RSkcIbKkpwDLrCm/CbvmyChoXU=;
        b=IruV7NVzKskCqLWX31NWw9KJ9LqADYT1YUG7em2E7u+vp2MnnDrDoh3jelpnQ8/msS
         U88F8/4RrHwgb5T3JtdPF55JsyCNkRgtMVut6OkXz1etB28E3uRGn5TBFoFuZWGbvHj3
         gWcAJRFML2huyZwMEjfT0twK6ywZiomuf+KqQ996BBqLeL8XtgfaRFIWl9k6unXC4O3E
         awP16Xxb/Zpkl/MN7Tsxu9j1OZMrF5GB/sVrjA1uNXkxhYzATM1mlfHeRXAMZiv9vqiC
         Bg2qBY1hOVJCV6cGdnPjYhWhhSI7EaREIpTWSpE52aqiXrLoNa5SL/QfG4W3m72z1295
         8Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700677475; x=1701282275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Du+BFHRvMyqAEjBg6RSkcIbKkpwDLrCm/CbvmyChoXU=;
        b=r5UGVCWDXia5Cxcn/XYt2I+3Bg5HCluctM2GC44d9b2+2beT0iXur15RrylE3+NKkL
         h5ArGAnXUE80zmzEh3iAiCOSP2VEafcgrmQcQE9sB7QkboxsOj2MiMznC3EqDtOLGFc3
         ijrpYlql91rrLS+t6Qg3VbXFrCckcBLyUL8Wic7xE/Iadam/hQEeKevU6CuipTHotcyv
         Pn3PKyw1fxSG/kvaY/h8hsuDT3td8YlN8VICaA7xpVTXdMgSUPlx5tZWbthQysO2cxyr
         2eKYOU8+/E3upAb03bB9dRxM/mbVTMhQYA4/Nb75zFnmOGFsdKgOJT7gwIfOtayWrfk3
         V4Yw==
X-Gm-Message-State: AOJu0YxkrCviWh0Nf1RQ0oGj+yYfG9VRCeFrgXafXwR4+nPpljwDB1wb
        W6nVBRGYY5kUj42jc9nT6z8=
X-Google-Smtp-Source: AGHT+IFKWUisXZgCOFxFmnquMptaMMQFLtq166qNTXQ2pfa0VVlheCvm7EXFGBwSINIn8btqNBHhmQ==
X-Received: by 2002:a2e:86d5:0:b0:2c8:73b7:5a1c with SMTP id n21-20020a2e86d5000000b002c873b75a1cmr2181439ljj.3.1700677474971;
        Wed, 22 Nov 2023 10:24:34 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id n16-20020a05651c001000b002c884919bdfsm12238lja.10.2023.11.22.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 10:24:34 -0800 (PST)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
        Aleksandar Rikalo <arikalo@gmail.com>,
        Dragan Mladjenovic <dragan.mladjenovic@syrmia.com>,
        Chao-ying Fu <cfu@wavecomp.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Yinglu Yang <yangyinglu@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mm/mm_init.c: Append '\n' to the unavailable ranges log-message
Date:   Wed, 22 Nov 2023 21:24:04 +0300
Message-ID: <20231122182419.30633-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231122182419.30633-1-fancer.lancer@gmail.com>
References: <20231122182419.30633-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the init_unavailable_range() method and it's callee semantics no
multi-line info messages are intended to be printed to the console. Thus
append the '\n' symbol to the respective info string.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 mm/mm_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3fa33e2d32ba..db8b91175834 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -827,7 +827,7 @@ static void __init init_unavailable_range(unsigned long spfn,
 	}
 
 	if (pgcnt)
-		pr_info("On node %d, zone %s: %lld pages in unavailable ranges",
+		pr_info("On node %d, zone %s: %lld pages in unavailable ranges\n",
 			node, zone_names[zone], pgcnt);
 }
 
-- 
2.42.1

