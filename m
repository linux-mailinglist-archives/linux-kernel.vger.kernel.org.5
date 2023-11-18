Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D197F00C3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjKRPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjKRPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:40 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC87D210B;
        Sat, 18 Nov 2023 07:52:00 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5c739c80e29so18512357b3.3;
        Sat, 18 Nov 2023 07:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322719; x=1700927519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLtIilfR7gLFqagyYs+6NDG1iSmOOH2SMP2aNmrlvmc=;
        b=GW216KwSCWFh4PSi9cZrFkFhSYyawbd/ImFwY7t+jv0HJKOv88GRK3GQ27YRh6i1H8
         PRFBNg+087O7RyBwPj11KKG5KncOXTAafBFpaebdyWn/iiGrk5oDZXaDn8Gd1kLa3+jK
         4HdAqXiuISk8PTv5tR4HtIMAgaD4KVF1+SB4tnyVxZ/mjk9voCpT8U7aZif0zXCyohWq
         pwVk/l+C1HMfZFBkERtFg+FgyjoDNQym8a2Ij3uTjkHKikfc2oo1Y93VPw1v/TaRGCkY
         ngWt5mZBoMBivDE/5F03cQM93f1YteDre75FIRo12N6ZGd9+2YNhGqEPaL4g7mv/MzV3
         R1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322719; x=1700927519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLtIilfR7gLFqagyYs+6NDG1iSmOOH2SMP2aNmrlvmc=;
        b=LAPhpyjy7P8OqRrlRDPQqLZMl6YYnwBTNszwK1jVahcD4o4dyft/GpsB9KxEE29CM5
         f/uUyLtSpUNAmG80ICybjKN33nZhuIbQi/7gs97/C1j7RX45WisJARhj3+PKQ7XkrOYa
         TRuujqPjjGU1s4iPB3aEXnw00dxO2cocaDcY4vSqHFkQjGEHavNcx5cQ6S6pGKTfFKio
         i91ae6HCMFmmKmP8AilzO42DmvUzHRsx2a5zQWUNzuxSVzV/A8dRTJ22iDZLApL3pxLQ
         nBdcLHGxzEz2+SJTiTQ3uHgTtQAO+LUT+Z3afpJ1S6CfUIvUyDbtIdGhvsyeEj5QVnn3
         93lA==
X-Gm-Message-State: AOJu0YytblmIcL4NLe/7l0s+b4ZK7WwucJ7Ta5AjmGYst2gUcIFhYS7p
        7qPx2c4lV1EzgF9+VK76SkRenmbzuDIlYmp1
X-Google-Smtp-Source: AGHT+IHzm0/pMsA84butgw//kfAU4Z52dcxRoxcpd4wkUYIvA5AU7oytHGlrX6abNYyb17yO7KbvWw==
X-Received: by 2002:a05:690c:13:b0:5c9:7f0a:e2fb with SMTP id bc19-20020a05690c001300b005c97f0ae2fbmr835696ywb.12.1700322718902;
        Sat, 18 Nov 2023 07:51:58 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id i9-20020a0ddf09000000b005a7a92a62besm1174746ywe.8.2023.11.18.07.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:57 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 34/34] sh: rework ilsel_enable()
Date:   Sat, 18 Nov 2023 07:51:05 -0800
Message-Id: <20231118155105.25678-35-yury.norov@gmail.com>
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

Fix opencoded find_and_set_bit(), which also suppresses potential
KCSAN warning.

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
2.39.2

