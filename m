Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74618026FA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjLCTfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbjLCTee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:34 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E4E114;
        Sun,  3 Dec 2023 11:34:11 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cd81e76164so41280007b3.1;
        Sun, 03 Dec 2023 11:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632050; x=1702236850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDQ4TbM0XahyYNXKtKolVVF+ns22YUcdG8yY0a8mQfw=;
        b=lLVN2nEsNLvmiKqSnhpTeraa/UzvF4iaevilv8uNpq3wNGxTGcSuhJlSUSvUG00v3/
         t3ai2x+2JShocrXNB7xdmAjYB4zKnry/+bo34ACHrSQcYgWaPCDfJY5Jh77zsNOsoyys
         aM5ItxQ+qzGuCxG5pC3OOsm37SrcNSlktShAGASOynpek37zBi3oMvgBfYgAHnvtFeK8
         c7i46hNnrg8Kh43nTx5EtWFkX/7OoMxq0dPvJItzcef7ilpMwhsF+Jx8EpTDvQKBlkAG
         DHMx0gBm6U6nLzdXFRvq28POePKTycsxmuRP6uP58S2gneP/QfKzn9oSvuBjx3SrOjm5
         nysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632050; x=1702236850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDQ4TbM0XahyYNXKtKolVVF+ns22YUcdG8yY0a8mQfw=;
        b=oONxTFni7DgY70XsMe9aE9tXZd4d41zYsV32ir05b/PcKo5QKEHNplVKhbgbLjY6zO
         +bmBipjweXCnPEySjtdAAB+p7JC6iNRfEBA5Cgw46/+JgOof3uTqAuC1b0Yagmp5SJg5
         GJMzeuY17H95S6ij/92JZYGk56gBsQ1A+eY9P96+UBRH/tRzogV5qWKa7tpoE6vgov0H
         uMR8YSJAIJRSnCjA9H7F431lW3g/16r2RWS7ZKJJp9KDWgHhEOqYgM5hj2nsQvQLQkj/
         GSyfSseQSEvgvQkBz2FDuxnJWiosnUgnmPxnEpkHMERiuqAz1uCSLEvs1gulDhMtxA+C
         6GlA==
X-Gm-Message-State: AOJu0Yw49t4dA9+Jo5ScvTxZx67YFoQrYhlsT6y016eFKP1iuOQO0IGC
        ArqVPEhWiuuABb7UqRz/844z6QLHezt8Og==
X-Google-Smtp-Source: AGHT+IGrgWTT1VXkOItmhhZtzkYYiWGpRkwsCUythGO3znmw0L9Nb8VqPAQNWs5Rvb8VaVG26JBSVA==
X-Received: by 2002:a0d:f687:0:b0:5ca:eca:700b with SMTP id g129-20020a0df687000000b005ca0eca700bmr25634935ywf.52.1701632050006;
        Sun, 03 Dec 2023 11:34:10 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id i84-20020a0ddf57000000b005d79fce2daasm997549ywe.22.2023.12.03.11.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:09 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yury Norov <yury.norov@gmail.com>, linux-sh@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 35/35] sh: mach-x3proto: rework ilsel_enable()
Date:   Sun,  3 Dec 2023 11:33:07 -0800
Message-Id: <20231203193307.542794-34-yury.norov@gmail.com>
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

Fix opencoded find_and_set_bit(), which also suppresses potential
KCSAN warning.

CC: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/sh/boards/mach-x3proto/ilsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3proto/ilsel.c
index f0d5eb41521a..7fadc479a80b 100644
--- a/arch/sh/boards/mach-x3proto/ilsel.c
+++ b/arch/sh/boards/mach-x3proto/ilsel.c
@@ -99,8 +99,8 @@ int ilsel_enable(ilsel_source_t set)
 	}
 
 	do {
-		bit = find_first_zero_bit(&ilsel_level_map, ILSEL_LEVELS);
-	} while (test_and_set_bit(bit, &ilsel_level_map));
+		bit = find_and_set_bit(&ilsel_level_map, ILSEL_LEVELS);
+	} while (bit >= ILSEL_LEVELS);
 
 	__ilsel_enable(set, bit);
 
-- 
2.40.1

