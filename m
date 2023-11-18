Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B5B7F008A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjKRPwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjKRPv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:51:29 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F89AD5D;
        Sat, 18 Nov 2023 07:51:18 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5afa5dbc378so29842967b3.0;
        Sat, 18 Nov 2023 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322677; x=1700927477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvI9Us0OJutYR180bTDT/eNujgeRZcibPGsiE0LS1nQ=;
        b=LwtggBdJKHWA0eKvQx/VVJwcqd6OcSZTW7/0ktKKrLTEOM8k8fJHzYDM+0nNiWwzzJ
         1gAW3B25oENQteAaOBgDxTMWe2L7Cr21Boc8+PC3//OvpTXTySZn6tj0vMvdreb8ow1K
         2GiMK4zWNp7E+bbL1XJ6OdtcSWr6Vjb+79sEpOscywb3mohFuEhnDk70qlhPgtVJqPky
         EflHGGYAY1Yv06dEIMizyUNKolcsgDFYW7pxb/Zklmq04pYeU3x6sN2R5dxDXma0DJYx
         E6LroP97qdCV1CG+hyo+Nv0lVfM4CLKklSrEbqyQCs//nyQcZWsDOa3h+PtbgVOrg2b7
         VR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322677; x=1700927477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvI9Us0OJutYR180bTDT/eNujgeRZcibPGsiE0LS1nQ=;
        b=m23iT6uu+HE783nV8u4uxISNULCDGnlZs6nGvjJDOdp2CdiCPPXk3nAVInO07LZVZ1
         lixVtdkQJFLP4U1wsy2lncP16uQ686GR0sBcfgdK8VggBYlbiqpDN5HioyAvt4tLOG6p
         KUDfW1hEYUuihIBYsQckFaZMy1hECr6Ub7Uy44xr4Qi8vBERrd09r9pNkIQNfzQCUFZk
         2u849YdzB+YD4C8bbtE7BmA/eMwJgeafZjaYvwM+WUDsTy2NzxU37FrSUwIOCKmNZhxm
         sftaYbLZyD/Wz8qMImbhr6K2heJJmRkEF3h73/cX2lnR7y8l/C3VnqLdG0fA+po9hMaZ
         0Wew==
X-Gm-Message-State: AOJu0YyWJs/z5AGn+OepsJZlSGmxvlx561XmbxobMmIzVV8WBXYXUdD4
        ntShjWSyoEcU/NQmpYhm9Ln0kbQ3uDMPltUd
X-Google-Smtp-Source: AGHT+IGErYx+U9qT7xYRu38M30NlhtAoSrrxl00OOPkiFJvYClCq7ENc2oGaGh6tEIdQb9Ng9H3IPw==
X-Received: by 2002:a25:1346:0:b0:d9a:5220:d6b3 with SMTP id 67-20020a251346000000b00d9a5220d6b3mr1526816ybt.56.1700322677059;
        Sat, 18 Nov 2023 07:51:17 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id x16-20020a25ce10000000b00da034601e2esm1006873ybe.52.2023.11.18.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:16 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yury Norov <yury.norov@gmail.com>, linux-mips@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 05/34] mips: sgi-ip30: rework heart_alloc_int()
Date:   Sat, 18 Nov 2023 07:50:36 -0800
Message-Id: <20231118155105.25678-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
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

heart_alloc_int() opencodes find_and_set_bit(). Switch it to using the
dedicated function, and make an nice one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/mips/sgi-ip30/ip30-irq.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/sgi-ip30/ip30-irq.c b/arch/mips/sgi-ip30/ip30-irq.c
index 423c32cb66ed..3c4d4e947817 100644
--- a/arch/mips/sgi-ip30/ip30-irq.c
+++ b/arch/mips/sgi-ip30/ip30-irq.c
@@ -28,17 +28,9 @@ static DEFINE_PER_CPU(unsigned long, irq_enable_mask);
 
 static inline int heart_alloc_int(void)
 {
-	int bit;
+	int bit = find_and_set_bit(heart_irq_map, HEART_NUM_IRQS);
 
-again:
-	bit = find_first_zero_bit(heart_irq_map, HEART_NUM_IRQS);
-	if (bit >= HEART_NUM_IRQS)
-		return -ENOSPC;
-
-	if (test_and_set_bit(bit, heart_irq_map))
-		goto again;
-
-	return bit;
+	return bit < HEART_NUM_IRQS ? bit : -ENOSPC;
 }
 
 static void ip30_error_irq(struct irq_desc *desc)
-- 
2.39.2

