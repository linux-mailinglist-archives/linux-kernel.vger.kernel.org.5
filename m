Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8658F8026CD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjLCTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjLCTdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:33:13 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B10BB;
        Sun,  3 Dec 2023 11:33:19 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d2d0661a8dso42510507b3.2;
        Sun, 03 Dec 2023 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701631998; x=1702236798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPrGoOeFU8KozQhYwT/36u1Qawb7qXzv6qzW2zIGltc=;
        b=ayk46PqlvudSLtBPT6YZusas6Uba82E3XyJd5F4m9ygfuOu3wHvZHXfS9UmQRvBXwy
         /BId5YfHrqaxpCCoYs5Ql6XKJMta5iDIAUccfcWZCse6EsxSTrSa5kKC+PpZr7NpB6Os
         LauuzvghQvhU3wTtbA4iDV9mCO8j+weJIB/Pogr4cE8mPY/BGvEyCd52PGIfUjqxV32S
         pwHZKddjqEfJLKjXwmgsDrglWiKhVAAR26Cxx4b1wXeTKNqVqbpr7nu7xTrvTdBtmlTm
         +vd7p05Ihe+LMb9E4QBG4d2okFOcJkv2u9LH+3bnA/icM7iTW6AFUXmxP52+woEqF8iz
         I/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701631998; x=1702236798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPrGoOeFU8KozQhYwT/36u1Qawb7qXzv6qzW2zIGltc=;
        b=a2EsffIPzdo7DYwd/L9L1tnnJ1B+tydAWVaQxVoglPKuQ1t9AO/nFZCwBxxjD15fso
         y2jCIBmpOTF0kc82svQGmX+bkVzq2nJrFj2Vr/j+rWyDYXHNUiqsn7h2tgBoSUiFeeCU
         HPWoK6rEcJS8e6uF4hqeoA8YX/NAPQy8DNvbbMeWk6wkJQVkJYbhQxNIPA/Fkl9BvRtX
         llxwrQhMyNS+8hwOUOmsK3A/GJrLGSlasP88gRHvSJotFKDCsR1glPDSWDMAOznP/CPk
         /Vjw3ySPDrMS2E0umMUFgpAEYrrX9GMDCFrZZpg4BJQL5u9NVIFP81eibYTHSFEkiBPY
         5ioQ==
X-Gm-Message-State: AOJu0YxhcW2ZF2mM3Z0wGokbAOVd3DnAEwGzRbs6a7dgaMNgfRIUyWvE
        vHlGSg68JstFhq0M6bEb9VA9Hv5xbe4MUg==
X-Google-Smtp-Source: AGHT+IFAp5m6uk4XQpTyLhPM7yoGZRWkgPn3E6eH/S2BHFx8qJnuW7oijoxKpTxlyZtVjohBf3IUnA==
X-Received: by 2002:a05:690c:3581:b0:5d8:a45e:3755 with SMTP id fr1-20020a05690c358100b005d8a45e3755mr205998ywb.11.1701631998236;
        Sun, 03 Dec 2023 11:33:18 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id z14-20020a814c0e000000b005d14e254367sm2752210ywa.80.2023.12.03.11.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:17 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 06/35] mips: sgi-ip30: rework heart_alloc_int()
Date:   Sun,  3 Dec 2023 11:32:38 -0800
Message-Id: <20231203193307.542794-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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
2.40.1

